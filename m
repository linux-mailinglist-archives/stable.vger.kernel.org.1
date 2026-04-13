Return-Path: <stable+bounces-236817-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4FtqNvQb3WkJaAkAu9opvQ
	(envelope-from <stable+bounces-236817-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:38:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C9743EF6DF
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:38:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 626293026C83
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 633C1238D27;
	Mon, 13 Apr 2026 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2d4oXFf4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25F85225A38;
	Mon, 13 Apr 2026 16:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776097868; cv=none; b=L8jJMzfCKRTeo434fsguN314Qb0/by/36DfDpaddsVDrzsJvDdRkeXgLH/uBQRVvFHgQQJBfEsp3soxbhW8hd8RYsAI6G4WgnbdoAM16vINCpxRqACe3JUIRYxiw21dm2kQMtbTzG2bcYQF0q/exsmhCHLhI+Y8Rn/fPu2lRVLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776097868; c=relaxed/simple;
	bh=nEzLk/dgi/SWYncJjQGbrq9Y97K6w0BIy9LposXl2rI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s+j0g2rI/GscaefbXWDUFRVTs5kMUw3Ez4Px3y4Jm0tV7k7kSmCvLzT1rekslZi3yrih7g3qg/3snWP+aQ189/8pc5WeSZwrv0kDioK2JTZpcxtwSiVOdw4V72Wa/IPrgqehp7z+lBs6Jx7oaKWWjrXtKyL8RehsNop0BjCJ2Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2d4oXFf4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEF02C2BCAF;
	Mon, 13 Apr 2026 16:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776097868;
	bh=nEzLk/dgi/SWYncJjQGbrq9Y97K6w0BIy9LposXl2rI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2d4oXFf4QJAUlvyeVovLBTYPcANNkGdXaK2PciZRraM9S++wDEBuXDW+gXY2XKdOo
	 BCIk5MApyLGUcMCT9uL3p+zfoMSggko2U7J3Jjf3Xq5got51fvASfc33Nc0Yxscxr7
	 DtzGSM+YYHPs6jkZO/Ct/feoSun/aqR/1/dRqy6w=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Klaudia Kloc <klaudia@vidocsecurity.com>,
	=?UTF-8?q?Dawid=20Moczad=C5=82o?= <dawid@vidocsecurity.com>,
	Jenny Guanni Qu <qguanni@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 261/570] netfilter: xt_time: use unsigned int for monthday bit shift
Date: Mon, 13 Apr 2026 17:56:32 +0200
Message-ID: <20260413155840.257590103@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155830.386096114@linuxfoundation.org>
References: <20260413155830.386096114@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,vidocsecurity.com,gmail.com,strlen.de,kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-236817-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,strlen.de:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vidocsecurity.com:email]
X-Rspamd-Queue-Id: 6C9743EF6DF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jenny Guanni Qu <qguanni@gmail.com>

[ Upstream commit 00050ec08cecfda447e1209b388086d76addda3a ]

The monthday field can be up to 31, and shifting a signed integer 1
by 31 positions (1 << 31) is undefined behavior in C, as the result
overflows a 32-bit signed int. Use 1U to ensure well-defined behavior
for all valid monthday values.

Change the weekday shift to 1U as well for consistency.

Fixes: ee4411a1b1e0 ("[NETFILTER]: x_tables: add xt_time match")
Reported-by: Klaudia Kloc <klaudia@vidocsecurity.com>
Reported-by: Dawid Moczadło <dawid@vidocsecurity.com>
Tested-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Jenny Guanni Qu <qguanni@gmail.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/xt_time.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/xt_time.c b/net/netfilter/xt_time.c
index 6aa12d0f54e23..61de85e02a40f 100644
--- a/net/netfilter/xt_time.c
+++ b/net/netfilter/xt_time.c
@@ -227,13 +227,13 @@ time_mt(const struct sk_buff *skb, struct xt_action_param *par)
 
 	localtime_2(&current_time, stamp);
 
-	if (!(info->weekdays_match & (1 << current_time.weekday)))
+	if (!(info->weekdays_match & (1U << current_time.weekday)))
 		return false;
 
 	/* Do not spend time computing monthday if all days match anyway */
 	if (info->monthdays_match != XT_TIME_ALL_MONTHDAYS) {
 		localtime_3(&current_time, stamp);
-		if (!(info->monthdays_match & (1 << current_time.monthday)))
+		if (!(info->monthdays_match & (1U << current_time.monthday)))
 			return false;
 	}
 
-- 
2.51.0




