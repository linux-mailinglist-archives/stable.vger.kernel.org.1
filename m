Return-Path: <stable+bounces-239479-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cDM1J8tL5mkgugEAu9opvQ
	(envelope-from <stable+bounces-239479-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:52:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD5A42EAD7
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 17:52:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 82A093004D33
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 15:52:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E014336896;
	Mon, 20 Apr 2026 15:52:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hGyyzDjQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FBB2E093A;
	Mon, 20 Apr 2026 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776700358; cv=none; b=qcFM14ZSZFDxiURoU9v2Zga+NeWeWITQ8lg3gYpNBeUOZQd13a4yOXi9FysY0/nDNrc6wj1/Xy10T+p+U13Rkmup/slCPgmgtldm/ruyMY+B3C5B+mDcd0d0NN4Nj4lEKpTlvjDWYOWoQbD9LybvbNJckoTGNlR4GZCYD4/brDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776700358; c=relaxed/simple;
	bh=WnEOZxxahRZbEQjabfreuum/G/OTbylgATb8Dakwa7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KRQ/J1Io1q7m5K23fiT46CIOlhmh+DpBtDIp39UkmHNJys9JYpTQXGj2JF/HurLNcBead/7IR/Ydfby2a/1usjatIxK92yFGrKIHmE1zT/0g7nWdw6B5ExzBySRHtPExf4zhV5kHfF7hBg537/FDDPmYLlGHSf8oDUishn3UryM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hGyyzDjQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59951C19425;
	Mon, 20 Apr 2026 15:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776700358;
	bh=WnEOZxxahRZbEQjabfreuum/G/OTbylgATb8Dakwa7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hGyyzDjQZ4CXC1MEZVn2L3spfRjxANB0LPlfV87CXuDF4bbl1rOWUAkPRDoWkprzx
	 hsO3ZliyakVHSOAYIfdYsGqwm6F9BJ4JNjwka4901z517PHO0aM7tzsDkZrVjW2ibp
	 29S7KbhJNPjd6Cab8Mr90O9IQenl3Yf6iCQLUKa8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kotlyarov Mihail <mihailkotlyarow@gmail.com>,
	Florian Westphal <fw@strlen.de>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 108/220] xfrm: fix refcount leak in xfrm_migrate_policy_find
Date: Mon, 20 Apr 2026 17:40:49 +0200
Message-ID: <20260420153937.922776962@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153934.013228280@linuxfoundation.org>
References: <20260420153934.013228280@linuxfoundation.org>
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
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,strlen.de,secunet.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-239479-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[secunet.com:email,linuxtesting.org:url,linuxfoundation.org:dkim,linuxfoundation.org:mid,strlen.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 2FD5A42EAD7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kotlyarov Mihail <mihailkotlyarow@gmail.com>

[ Upstream commit 83317cce60a032c49480dcdabe146435bd689d03 ]

syzkaller reported a memory leak in xfrm_policy_alloc:

  BUG: memory leak
  unreferenced object 0xffff888114d79000 (size 1024):
    comm "syz.1.17", pid 931
    ...
    xfrm_policy_alloc+0xb3/0x4b0 net/xfrm/xfrm_policy.c:432

The root cause is a double call to xfrm_pol_hold_rcu() in
xfrm_migrate_policy_find(). The lookup function already returns
a policy with held reference, making the second call redundant.

Remove the redundant xfrm_pol_hold_rcu() call to fix the refcount
imbalance and prevent the memory leak.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 563d5ca93e88 ("xfrm: switch migrate to xfrm_policy_lookup_bytype")
Signed-off-by: Kotlyarov Mihail <mihailkotlyarow@gmail.com>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_policy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/xfrm/xfrm_policy.c b/net/xfrm/xfrm_policy.c
index 4526c9078b136..29c94ee0ceb25 100644
--- a/net/xfrm/xfrm_policy.c
+++ b/net/xfrm/xfrm_policy.c
@@ -4528,9 +4528,6 @@ static struct xfrm_policy *xfrm_migrate_policy_find(const struct xfrm_selector *
 	pol = xfrm_policy_lookup_bytype(net, type, &fl, sel->family, dir, if_id);
 	if (IS_ERR_OR_NULL(pol))
 		goto out_unlock;
-
-	if (!xfrm_pol_hold_rcu(pol))
-		pol = NULL;
 out_unlock:
 	rcu_read_unlock();
 	return pol;
-- 
2.53.0




