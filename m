Return-Path: <stable+bounces-234150-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QK0jEryb1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234150-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:17:32 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD9C3C058C
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:17:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EB812303C028
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE03B3859FE;
	Wed,  8 Apr 2026 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WkzWwbeU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D1522DCF41;
	Wed,  8 Apr 2026 18:15:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775672113; cv=none; b=WGrbXBOXjpmn5QUW4Co+daQRtJMpr4Usmj/Y8IvW4I6L17YG9/6InrbyHbo5UaS2dMNd09xwXKm5JrMoFZpqDOb48LAMC0CGsQkf8RWfI4VkmCBTLvmMez2GSA0K3K+tI4SBkvB3e+cd4i1KrxMGLOGssfLY7MspEstK2wSRsh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775672113; c=relaxed/simple;
	bh=+lDqDuVSq8dawNOe2+NKF62fqt1vcSnDFbJiiPNVhGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kixijxb/qUMyCCw1O/HxRdzNxZFDRUy1EdeExGALeAtM8K4NnjaQkn619ztn+YlfTNHkYOy/TYx1pKnBUYJYtzjVsWDFva82yLBVfIjdNpwBSBwXjQQvavCx3RsZrO7MVdqdxTz9Muu3IqirxUis9dnMBItiq3g7fM1efxiCn3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WkzWwbeU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 135B0C19421;
	Wed,  8 Apr 2026 18:15:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775672113;
	bh=+lDqDuVSq8dawNOe2+NKF62fqt1vcSnDFbJiiPNVhGA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WkzWwbeUIMNMjM9ERatgoj5KfNcZ/ca1dsEB3yMHRYCDaKe+yXwwWlFGFbSeLaSzn
	 lrsny+WbVH+ya6MngxBBp3WU+WHrq8raSEHWU4Evo+1gBf0KxtOnck8Ec3yBJ/uwdL
	 wibE5dw7cdQI/Ywkjbh2y/Ak9pVd0MmVm6bzmt9c=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Yifan Wu <yifanwucs@gmail.com>,
	Juefei Pu <tomapufckgml@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <enjou1224z@gmail.com>,
	Zhengchuan Liang <zcliangcn@gmail.com>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 162/312] net: ipv6: flowlabel: defer exclusive option free until RCU teardown
Date: Wed,  8 Apr 2026 20:01:19 +0200
Message-ID: <20260408175939.815584525@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175933.715315542@linuxfoundation.org>
References: <20260408175933.715315542@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-234150-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,lzu.edu.cn,google.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[13];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lzu.edu.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: ADD9C3C058C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhengchuan Liang <zcliangcn@gmail.com>

[ Upstream commit 9ca562bb8e66978b53028fa32b1a190708e6a091 ]

`ip6fl_seq_show()` walks the global flowlabel hash under the seq-file
RCU read-side lock and prints `fl->opt->opt_nflen` when an option block
is present.

Exclusive flowlabels currently free `fl->opt` as soon as `fl->users`
drops to zero in `fl_release()`. However, the surrounding
`struct ip6_flowlabel` remains visible in the global hash table until
later garbage collection removes it and `fl_free_rcu()` finally tears it
down.

A concurrent `/proc/net/ip6_flowlabel` reader can therefore race that
early `kfree()` and dereference freed option state, triggering a crash
in `ip6fl_seq_show()`.

Fix this by keeping `fl->opt` alive until `fl_free_rcu()`. That matches
the lifetime already required for the enclosing flowlabel while readers
can still reach it under RCU.

Fixes: d3aedd5ebd4b ("ipv6 flowlabel: Convert hash list to RCU.")
Reported-by: Yifan Wu <yifanwucs@gmail.com>
Reported-by: Juefei Pu <tomapufckgml@gmail.com>
Co-developed-by: Yuan Tan <yuantan098@gmail.com>
Signed-off-by: Yuan Tan <yuantan098@gmail.com>
Suggested-by: Xin Liu <bird@lzu.edu.cn>
Tested-by: Ren Wei <enjou1224z@gmail.com>
Signed-off-by: Zhengchuan Liang <zcliangcn@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Link: https://patch.msgid.link/07351f0ec47bcee289576f39f9354f4a64add6e4.1774855883.git.zcliangcn@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv6/ip6_flowlabel.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/net/ipv6/ip6_flowlabel.c b/net/ipv6/ip6_flowlabel.c
index 18481eb76a0a4..eb0d517aa6cb3 100644
--- a/net/ipv6/ip6_flowlabel.c
+++ b/net/ipv6/ip6_flowlabel.c
@@ -133,11 +133,6 @@ static void fl_release(struct ip6_flowlabel *fl)
 		if (time_after(ttd, fl->expires))
 			fl->expires = ttd;
 		ttd = fl->expires;
-		if (fl->opt && fl->share == IPV6_FL_S_EXCL) {
-			struct ipv6_txoptions *opt = fl->opt;
-			fl->opt = NULL;
-			kfree(opt);
-		}
 		if (!timer_pending(&ip6_fl_gc_timer) ||
 		    time_after(ip6_fl_gc_timer.expires, ttd))
 			mod_timer(&ip6_fl_gc_timer, ttd);
-- 
2.53.0




