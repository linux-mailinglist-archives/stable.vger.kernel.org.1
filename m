Return-Path: <stable+bounces-243706-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA6vNYis+Gn2xgIAu9opvQ
	(envelope-from <stable+bounces-243706-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CAB04BF65A
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:26:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B59B8308A842
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:22:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B809E3DE458;
	Mon,  4 May 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OTmGh++u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FBDF3DE443;
	Mon,  4 May 2026 14:22:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904568; cv=none; b=AEdkX4ze1rkpGocRz1mAqyfxgf3VUbPRsp+F0cvf0RatgDfYkbzRAkMeE+ZhlTLRNh0yATAeFM9P1Zu3M9jvGk4GG2aHXqFQjdGTxLK6AYZd5/CKjZd3svGtAD4gg2zDfchHGuPpTkdBWoxaoLG/kIZi6Dm9xm/a6SJkKkgwvc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904568; c=relaxed/simple;
	bh=qka7P6T+XrPxn3uolb4tAD54cNIk1EJNB8xpwxkkW58=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WoBkhBzPD3pPJoJ3btrk8Gdmfu89r3uVdUim5EC2q89r4trvmcjH/jAQINSl16FOBpIciVbZL2EK7vOSFLy8Ns5RSg80Xp/AfNlgS52WEPywY4xjmeDeWWBLeiA01+ZlGB08OwXP8jgl2K7m+CT33s0Aa5UJssqaPCyualL+0/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OTmGh++u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 049CCC2BCB8;
	Mon,  4 May 2026 14:22:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904568;
	bh=qka7P6T+XrPxn3uolb4tAD54cNIk1EJNB8xpwxkkW58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=OTmGh++uKeBGjuknB7b1Yxoyb8OMgkNx+rZfzfRBIkwwiQ5Uj0eWmVgksHIXoungd
	 73xPE9syp3HbZVV2wyNM20YcpCCBdmc9jpoPGSJe7OT8sKQWOZVHAR7cOIKTWQ5w9m
	 9Wp5zWp3haQc9THfK/JxGka+ANujo41qjSRti2to=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Yuan Tan <yuantan098@gmail.com>,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ruijie Li <ruijieli51@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Dust Li <dust.li@linux.alibaba.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 089/215] net/smc: avoid early lgr access in smc_clc_wait_msg
Date: Mon,  4 May 2026 15:51:48 +0200
Message-ID: <20260504135133.409834304@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 6CAB04BF65A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243706-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,kernel.org,gmail.com,lzu.edu.cn,linux.alibaba.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,msgid.link:url,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,alibaba.com:email,lzu.edu.cn:email]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ruijie Li <ruijieli51@gmail.com>

commit 5a8db80f721deee8e916c2cfdee78decda02ce4f upstream.

A CLC decline can be received while the handshake is still in an early
stage, before the connection has been associated with a link group.

The decline handling in smc_clc_wait_msg() updates link-group level sync
state for first-contact declines, but that state only exists after link
group setup has completed. Guard the link-group update accordingly and
keep the per-socket peer diagnosis handling unchanged.

This preserves the existing sync_err handling for established link-group
contexts and avoids touching link-group state before it is available.

Fixes: 0cfdd8f92cac ("smc: connection and link group creation")
Cc: stable@kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Ruijie Li <ruijieli51@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Dust Li <dust.li@linux.alibaba.com>
Link: https://patch.msgid.link/08c68a5c817acf198cce63d22517e232e8d60718.1776850759.git.ruijieli51@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/smc/smc_clc.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/net/smc/smc_clc.c
+++ b/net/smc/smc_clc.c
@@ -785,8 +785,8 @@ int smc_clc_wait_msg(struct smc_sock *sm
 		dclc = (struct smc_clc_msg_decline *)clcm;
 		reason_code = SMC_CLC_DECL_PEERDECL;
 		smc->peer_diagnosis = ntohl(dclc->peer_diagnosis);
-		if (((struct smc_clc_msg_decline *)buf)->hdr.typev2 &
-						SMC_FIRST_CONTACT_MASK) {
+		if ((dclc->hdr.typev2 & SMC_FIRST_CONTACT_MASK) &&
+		    smc->conn.lgr) {
 			smc->conn.lgr->sync_err = 1;
 			smc_lgr_terminate_sched(smc->conn.lgr);
 		}



