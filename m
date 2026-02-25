Return-Path: <stable+bounces-218099-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aDoHBkpQnmlIUgQAu9opvQ
	(envelope-from <stable+bounces-218099-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:28:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id ACD6018EB4A
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:28:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 92BC930636AF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70B0421D596;
	Wed, 25 Feb 2026 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vl2nz8da"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 333E2251795;
	Wed, 25 Feb 2026 01:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771982875; cv=none; b=pqK2IB0+uqheQlntpnl+KbRwQH+mhe5R2ZpicTj7mT3vAnymm0tBJANCe0JdRVqVN5/rBSOKEf7D/G+wDxBGujSVjyxZVARAaDzAHgSaa82WUC0KbF22TKrbPd6z7F2AG2T6zmhnOaX7Scsc4NZEPt7Igw1BaMNLE47UHcMSY7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771982875; c=relaxed/simple;
	bh=Q7pT1VbQHwIntsqXVBh4zpXrOxuWnZ1QxBaGZ848Gj4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tIZEqKj5T1TmQsxGcgfQSzetwlpShk5rPmbyWiRHytckoFrNvQ+BjoIGXRNFkGR40UxMjYGiU4U9qK2t785br+5YxpI59SG/Cbw0lRkN76IfwZWf3AaJjPJ3q+uh2shexDb2MlmCT3zzkmRrpRvYcnUT8NPLSiEoL1DgsIPKpXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vl2nz8da; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DEBA4C19423;
	Wed, 25 Feb 2026 01:27:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771982875;
	bh=Q7pT1VbQHwIntsqXVBh4zpXrOxuWnZ1QxBaGZ848Gj4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Vl2nz8dahXpcXW8BX0nZFdJPxm1KSpBvJJauEvnB6KiRxX+c4QKXjK31nGkYxVcDW
	 d/WcAODvD5eKwP5o8d3tNbx6yZ0MJu6Yj8AqKK4uw39mRyDF1Ifjqmzva6AjHtBLPI
	 IGNbTRqxAK6AcVT6NrnLqOUFaBq+R+8xd3xvBbRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	Xiao Ni <xni@redhat.com>,
	Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 059/781] md: fix return value of mddev_trylock
Date: Tue, 24 Feb 2026 17:12:48 -0800
Message-ID: <20260225012401.153339873@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218099-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: ACD6018EB4A
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Xiao Ni <xni@redhat.com>

[ Upstream commit 05c8de4f09b08e97c6ecb190dcec0e68b167cb03 ]

A return value of 0 is treaded as successful lock acquisition. In fact, a
return value of 1 means getting the lock successfully.

Link: https://lore.kernel.org/linux-raid/20260127073951.17248-1-xni@redhat.com
Fixes: 9e59d609763f ("md: call del_gendisk in control path")
Reported-by: Bart Van Assche <bvanassche@acm.org>
Closes: https://lore.kernel.org/linux-raid/20250611073108.25463-1-xni@redhat.com/T/#mfa369ef5faa4aa58e13e6d9fdb88aecd862b8f2f
Signed-off-by: Xiao Ni <xni@redhat.com>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by:  Li Nan <linan122@huawei.com>
Signed-off-by: Yu Kuai <yukuai@fnnas.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/md/md.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/md.h b/drivers/md/md.h
index 6985f2829bbd6..3bfbee595156d 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -737,8 +737,8 @@ static inline int mddev_trylock(struct mddev *mddev)
 	int ret;
 
 	ret = mutex_trylock(&mddev->reconfig_mutex);
-	if (!ret && test_bit(MD_DELETED, &mddev->flags)) {
-		ret = -ENODEV;
+	if (ret && test_bit(MD_DELETED, &mddev->flags)) {
+		ret = 0;
 		mutex_unlock(&mddev->reconfig_mutex);
 	}
 	return ret;
-- 
2.51.0




