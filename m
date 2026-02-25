Return-Path: <stable+bounces-218696-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CIiQJZtUnmmmUgQAu9opvQ
	(envelope-from <stable+bounces-218696-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:47:07 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2DFCE18FD43
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 02:47:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 385B331CE917
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5741126B764;
	Wed, 25 Feb 2026 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yB7cYcYO"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B7702494FE;
	Wed, 25 Feb 2026 01:39:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983555; cv=none; b=hpyMMYpelatgMLacoKExWVQg7Swjnqkluy+c0Vj/7Ifec0oNhwTaUku8XS9T5HxfmKxadz8EL2vAWK0SY6+JSs5ESyo1CI7PpAuPQe1C16mkNZ/zDQe2/VLTKwVK4AjW4Kpd81pudL9H+msJBJ0c9PY68/jD1xyT1y8wzRgQQRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983555; c=relaxed/simple;
	bh=yODjyLtt0Vk64uo1Ec2du4ajEmgTVBTlTiFrwQwZoHA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LL9bbz3L5MoKAE8ycLQUPLAuuy31JY9UCRBiM2VNF+L+7WtHdg/k253ODezbLDYYtrxjA1wpIQIZhNx0GmpIdysk9e2xZyUkaGFUVxE5DQXsRh48DCSYFU/x07sLxXian4C4d+f4Kxkg1qaViItgATK6hbpTF9Y88oWCkWN1iwU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yB7cYcYO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4BDC116D0;
	Wed, 25 Feb 2026 01:39:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983555;
	bh=yODjyLtt0Vk64uo1Ec2du4ajEmgTVBTlTiFrwQwZoHA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yB7cYcYOUcyB+yrtgWgd26Prk4ZktBXZQno6CHNPLpUP1s0/ZnF8JmkLa7Ol/NNI1
	 Gav2qj/ZbTz0OPWH2V7LSlEn0qjPkvacDJ8gfFx/AaKvbntb6ZTAvpw0xWtZQDiC4f
	 7G5+MpEPpE6+T310uJWahga6lA7MIvPmjd9nf0gc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Simon Horman <horms@kernel.org>,
	Allison Henderson <achender@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 656/781] net/rds: rds_sendmsg should not discard payload_len
Date: Tue, 24 Feb 2026 17:22:45 -0800
Message-ID: <20260225012415.879355728@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-218696-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url]
X-Rspamd-Queue-Id: 2DFCE18FD43
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Allison Henderson <achender@kernel.org>

[ Upstream commit da29e453dcb3aa7cabead7915f5f945d0add3a52 ]

Commit 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with
connection teardown") modifies rds_sendmsg to avoid enqueueing work
while a tear down is in progress. However, it also changed the return
value of rds_sendmsg to that of rds_send_xmit instead of the
payload_len. This means the user may incorrectly receive errno values
when it should have simply received a payload of 0 while the peer
attempts a reconnections.  So this patch corrects the teardown handling
code to only use the out error path in that case, thus restoring the
original payload_len return value.

Fixes: 3db6e0d172c9 ("rds: use RCU to synchronize work-enqueue with connection teardown")
Reviewed-by: Simon Horman <horms@kernel.org>
Signed-off-by: Allison Henderson <achender@kernel.org>
Link: https://patch.msgid.link/20260213035409.1963391-1-achender@kernel.org
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/rds/send.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/rds/send.c b/net/rds/send.c
index 0b3d0ef2f008b..071c5dca969a2 100644
--- a/net/rds/send.c
+++ b/net/rds/send.c
@@ -1382,9 +1382,11 @@ int rds_sendmsg(struct socket *sock, struct msghdr *msg, size_t payload_len)
 		else
 			queue_delayed_work(rds_wq, &cpath->cp_send_w, 1);
 		rcu_read_unlock();
+
+		if (ret)
+			goto out;
 	}
-	if (ret)
-		goto out;
+
 	rds_message_put(rm);
 
 	for (ind = 0; ind < vct.indx; ind++)
-- 
2.51.0




