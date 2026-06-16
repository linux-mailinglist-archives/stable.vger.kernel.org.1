Return-Path: <stable+bounces-266390-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id WPl6FH+dMWotoQUAu9opvQ
	(envelope-from <stable+bounces-266390-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:01:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C396F694A9B
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 21:01:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=linuxfoundation.org header.s=korg header.b=yiG+TsBs;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266390-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-266390-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=linuxfoundation.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4D4663226E05
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 18:56:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20E7447CC7A;
	Tue, 16 Jun 2026 18:56:12 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFE343EB0F5;
	Tue, 16 Jun 2026 18:56:10 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781636171; cv=none; b=TySHhaeBz3vnSXQdD087ohDKLXyL9kWsYmB2aGPnOBPgUcGZfSciccq8nBTXVD1hP7hY0OwI+HFFrH1/exJwXr3cFNvyVxit6mIXezmwX0mLhqGBGxT2f7B12p3bTE5i6YA2o7iNakq+Ml46PxVBkPKqK2sCu6F6X2ziO3iNxNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781636171; c=relaxed/simple;
	bh=P+5Afdt3fKNac2IH3qgKz0hojaP2CbxMIXPucM/naK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4V2uxRo5/QrgS8MZoADzAfGJ5JiNVt+zFwfMN9GmxkxtRZKypPNtTKdnOd6rmxRQymKsFUkNfVygFM7t8bgzJLfvqwB2qRXCEDbJIvFuq1Cy94NKkotSQhgxNoKH6MwXrlhCbA9MJq/1WtpDZMo+nq2Zer2X04B+KGI0D+1u6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yiG+TsBs; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1DEF1F000E9;
	Tue, 16 Jun 2026 18:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781636170;
	bh=pFS4vm1VU4MzL/s8VzhgpSi+hYTad7qO6Ts5hG+AgQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=yiG+TsBsYqFjCcfTdaHsMDpf2+coHIUmgvd4QYO8Sl13mNaayxuoBbxprUme7ZnZ/
	 XrQFp/9A2J4aW2pMADEvHkXWNht2adjAEdTjohEEpt4QcCysmlcdpU0LAQBuSBx8uz
	 b7FF5c6xDkWXHupqQvaT4XYtYdXshtinN9ozXDF8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sanghyun Park <sanghyun.park.cnu@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 165/342] xfrm: policy: fix use-after-free on inexact bin in xfrm_policy_bysel_ctx()
Date: Tue, 16 Jun 2026 20:27:41 +0530
Message-ID: <20260616145055.870651495@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260616145048.348037099@linuxfoundation.org>
References: <20260616145048.348037099@linuxfoundation.org>
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
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-266390-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:patches@lists.linux.dev,m:sanghyun.park.cnu@gmail.com,m:steffen.klassert@secunet.com,m:sashal@kernel.org,m:sanghyunparkcnu@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,secunet.com,kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,linuxfoundation.org:dkim,linuxfoundation.org:mid,linuxfoundation.org:from_mime,secunet.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C396F694A9B

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sanghyun Park <sanghyun.park.cnu@gmail.com>

[ Upstream commit 7f2d76c9c03257c0782afef9d95321fa04096f60 ]

Fix the race by pruning the bin while still holding xfrm_policy_lock,
before dropping it. Use __xfrm_policy_inexact_prune_bin() directly since
the lock is already held. The wrapper xfrm_policy_inexact_prune_bin()
becomes unused and is removed.

Race:

  CPU0 (XFRM_MSG_DELPOLICY)           CPU1 (XFRM_MSG_NEWSPDINFO)
  ==========================          ==========================
  xfrm_policy_bysel_ctx():
    spin_lock_bh(xfrm_policy_lock)
    bin = xfrm_policy_inexact_lookup()
    __xfrm_policy_unlink(pol)
    spin_unlock_bh(xfrm_policy_lock)
    xfrm_policy_kill(ret)
    // wide window, lock not held
                                       xfrm_hash_rebuild():
                                         spin_lock_bh(xfrm_policy_lock)
                                         __xfrm_policy_inexact_flush():
                                           kfree_rcu(bin)  // bin freed
                                         spin_unlock_bh(xfrm_policy_lock)
    xfrm_policy_inexact_prune_bin(bin)
    // UAF: bin is freed

Fixes: 6be3b0db6db8 ("xfrm: policy: add inexact policy search tree infrastructure")
Signed-off-by: Sanghyun Park <sanghyun.park.cnu@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 13 ++-----------
 1 file changed, 2 insertions(+), 11 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 5bcc5642ccf067..e17faf51f32553 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -1124,15 +1124,6 @@ static void __xfrm_policy_inexact_prune_bin(struct xfrm_pol_inexact_bin *b, bool
 	}
 }
 
-static void xfrm_policy_inexact_prune_bin(struct xfrm_pol_inexact_bin *b)
-{
-	struct net *net = read_pnet(&b->k.net);
-
-	spin_lock_bh(&net->xfrm.xfrm_policy_lock);
-	__xfrm_policy_inexact_prune_bin(b, false);
-	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
-}
-
 static void __xfrm_policy_inexact_flush(struct net *net)
 {
 	struct xfrm_pol_inexact_bin *bin, *t;
@@ -1720,12 +1711,12 @@ xfrm_policy_bysel_ctx(struct net *net, const struct xfrm_mark *mark, u32 if_id,
 		}
 		ret = pol;
 	}
+	if (bin && delete)
+		__xfrm_policy_inexact_prune_bin(bin, false);
 	spin_unlock_bh(&net->xfrm.xfrm_policy_lock);
 
 	if (ret && delete)
 		xfrm_policy_kill(ret);
-	if (bin && delete)
-		xfrm_policy_inexact_prune_bin(bin);
 	return ret;
 }
 EXPORT_SYMBOL(xfrm_policy_bysel_ctx);
-- 
2.53.0




