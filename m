Return-Path: <stable+bounces-218876-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CHWAAqBXnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218876-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:00:00 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1321905AF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:59:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3EAA430BEAAF
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 961A5279DCA;
	Wed, 25 Feb 2026 01:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aHiLzL81"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56BBB279DB3;
	Wed, 25 Feb 2026 01:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983763; cv=none; b=LxdIGyWL9r9RxGYFhYoWaKlObCdt9RRhQmF+Gi49lk5vXFDyPUkJtsvs/unWr9cBHJyh8nfthZ+BQ3aaPMKX+rDRfQddxDZs2wRIonV7e+teuwbfkTswKAiWlxgOsMPf1CU453Mj7VcQCh5kE8A/W5xjO6HntPS26dPDQztlBCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983763; c=relaxed/simple;
	bh=jEydx9mCNRnhRgWMxGdyzJIAe6flJl1zBK/WoM9OUVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EnxTC4/GF04Dtn5ajmR4khF30CvtIWqfHCuEYyhLgcp7W3Y8aMLHAYP+NOS/s+aHyx5MBdcTmgrIjIhGRy4gOTKeGYmRS+YJTuzsrTPhANKNY05N5PMdoZtzXMm2+31p6LsYBBXaK8ks2rZeDmukUgkKct3UU5pQGOGD3t8MIMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aHiLzL81; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10318C116D0;
	Wed, 25 Feb 2026 01:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983763;
	bh=jEydx9mCNRnhRgWMxGdyzJIAe6flJl1zBK/WoM9OUVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aHiLzL813MexOmPgdc1aAw3JyvIRrIfhFEzbQGJlHWtAAvnPRDW3OYlV7iVSZKb8M
	 hvfw7klIDnaoZG12BcgGmh/KTJXZgSw/3FpY7mz4JOR74w71w2z0El4o0kDnUo7FUm
	 d7+6ripOhXBJZPziIgPeHISGrZ3pUCy7w+DVihjs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Bart Van Assche <bvanassche@acm.org>,
	Xiao Ni <xni@redhat.com>,
	Li Nan <linan122@huawei.com>,
	Yu Kuai <yukuai@fnnas.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 055/641] md: fix return value of mddev_trylock
Date: Tue, 24 Feb 2026 17:16:21 -0800
Message-ID: <20260225012350.373255414@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218876-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,huawei.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,fnnas.com:email,acm.org:email]
X-Rspamd-Queue-Id: 6A1321905AF
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

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
index fd6e001c1d38f..9d66afb8cc6e6 100644
--- a/drivers/md/md.h
+++ b/drivers/md/md.h
@@ -736,8 +736,8 @@ static inline int mddev_trylock(struct mddev *mddev)
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




