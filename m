Return-Path: <stable+bounces-238979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wDaAC2Y55mlutgEAu9opvQ
	(envelope-from <stable+bounces-238979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:34:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 849AC42D32F
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40E1C31615E1
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 13:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B250B3F54A7;
	Mon, 20 Apr 2026 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tOnxE9wA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DDC3F23DB;
	Mon, 20 Apr 2026 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776691547; cv=none; b=KtNVDWYuS/CDfHKJxsEgUl4FZN25GkoeYclp1eUCM2cTe6jyJMPOOdiRxm0r1LA0BJIsMX0VPxN/MlaGfBj0SUtJtOSeWmY8eQvSmv+wkIAgb8RKk2ACLPmPaFcomIT+XBjBcClVnde+rLRGkyZe6xNlGxVwn3rdBTux2r7yNnU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776691547; c=relaxed/simple;
	bh=EmrrolUQ9+NKYFK+I/2JSP0Cd7peVIsW0fvVyG/GObM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gzFORqI1yRer5mTxPzhG8Sz44QBmHYXHQJt2vZVTGTECUg4ngw7fUiZ6Fc++ncOS++o4NYpkoRMTEmFu1LKtBQjRWgkgkY6UHRk8jPvP5OkGEubDrEqNfUcYHHzaI0ONrb8N77MG14W1/mB0NY9DqaE/PuauZDN545W9m8y7vOc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tOnxE9wA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE665C2BCB6;
	Mon, 20 Apr 2026 13:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776691547;
	bh=EmrrolUQ9+NKYFK+I/2JSP0Cd7peVIsW0fvVyG/GObM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tOnxE9wAiw+cqfqL2XLxbilTZCT9i79lHbixfK3T65UoCfEwkEyWrfWJeaBIpRvz4
	 dxhY0l5x68a8uLjkQKNJrFVV5U/fkDLw2XmPU/skmGtiHAuwIaRNy3U25J1Eb9+1Mx
	 4nEDfOf5I5JWtdKWAJ3fSP0N8RYM6IMA8BIu8F0zNsXiuNxrrHNhBoD8vOHAuNsuB/
	 hzB0b2jwQYmxCNrAmxVHSaBMjetGujOtUWoDkLlWTnssO3birerXq7GM2X/eZEHFCg
	 KBLnTgJl4f/rzzp9ZvnugvhzA+50xWc8rk1lt/lsWFsFB+vo4baFGtKBQ3byjSIiE/
	 tYkzcr7H41K3g==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	jiri@resnulli.us,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	przemyslaw.kitszel@intel.com,
	anthony.l.nguyen@intel.com,
	mateusz.polchlopek@intel.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.18] devlink: Fix incorrect skb socket family dumping
Date: Mon, 20 Apr 2026 09:18:07 -0400
Message-ID: <20260420132314.1023554-93-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420132314.1023554-1-sashal@kernel.org>
References: <20260420132314.1023554-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.18.23
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-238979-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[14];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 849AC42D32F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Li RongQing <lirongqing@baidu.com>

[ Upstream commit 0006c6f1091bbeea88b8a88a6548b9fb2f803c74 ]

The devlink_fmsg_dump_skb function was incorrectly using the socket
type (sk->sk_type) instead of the socket family (sk->sk_family)
when filling the "family" field in the fast message dump.

This patch fixes this to properly display the socket family.

Fixes: 3dbfde7f6bc7b8 ("devlink: add devlink_fmsg_dump_skb() function")
Signed-off-by: Li RongQing <lirongqing@baidu.com>
Link: https://patch.msgid.link/20260407022730.2393-1-lirongqing@baidu.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

Error: Failed to generate final synthesis

 net/devlink/health.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/devlink/health.c b/net/devlink/health.c
index 136a67c36a20d..0798c82096bdc 100644
--- a/net/devlink/health.c
+++ b/net/devlink/health.c
@@ -1327,7 +1327,7 @@ void devlink_fmsg_dump_skb(struct devlink_fmsg *fmsg, const struct sk_buff *skb)
 	if (sk) {
 		devlink_fmsg_pair_nest_start(fmsg, "sk");
 		devlink_fmsg_obj_nest_start(fmsg);
-		devlink_fmsg_put(fmsg, "family", sk->sk_type);
+		devlink_fmsg_put(fmsg, "family", sk->sk_family);
 		devlink_fmsg_put(fmsg, "type", sk->sk_type);
 		devlink_fmsg_put(fmsg, "proto", sk->sk_protocol);
 		devlink_fmsg_obj_nest_end(fmsg);
-- 
2.53.0


