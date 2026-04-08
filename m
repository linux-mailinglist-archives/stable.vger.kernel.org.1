Return-Path: <stable+bounces-234807-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iATgJAqi1mmyGggAu9opvQ
	(envelope-from <stable+bounces-234807-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:44:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 196E13C1657
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 20:44:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0634A304D17B
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:43:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C51F3B0AFC;
	Wed,  8 Apr 2026 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BwbwKNAQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF593D669E;
	Wed,  8 Apr 2026 18:43:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673813; cv=none; b=BTb6UhpJ8PpGfDb9aOAm2w+ngPhFP12Umce2m1ZFx9VjefENQDVfJAoCYn5kAzf2qACH6Sk1SeIE8JgW1SClsmYFefa9rGr7lK0H/ZXizpAgKaw8C17f4iQOdTwD8NXMSWMoPIRLhvgOtK/s/08C8f3xrt1htTZ3O3DO6h89jNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673813; c=relaxed/simple;
	bh=qxzyRy6+nIo7xbYUuG5WLJnAWYry2Bp1/pgZcNyStQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e/G3M4SHOqGXa5HP++ty+H7lK1wRED1Dqh7CmllHi8kHZPZ7N+0/uyZoMH3AHHdrkAJXNpNmYUPM7Mo66oNBRpwZ1xErjrhaMHSV2gsyBZXPKsLrAZq8QjzetFX6EKjMFx74O1oKWmHUiDjqHLhHeaEX9MVrWVVsSKilNVJiwMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BwbwKNAQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F5CFC19421;
	Wed,  8 Apr 2026 18:43:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673812;
	bh=qxzyRy6+nIo7xbYUuG5WLJnAWYry2Bp1/pgZcNyStQc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BwbwKNAQo+BNHmFlI5xcjWoxjRmyHR7IABu9RFMb/1BdB5qEkmtUZpPuqw2GDjBQP
	 t3PU/DzJbNE3+Pe3a1kySYFFJOHFw6atSAJ1BGos5gxbj9ANLss402xwzLSxw6lR7p
	 1vwUKJB+CmhN5jcXL9u5Ptm00JYZYA2IXKCKdHEs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qi Tang <tpluszz77@gmail.com>,
	Phil Sutter <phil@nwl.cc>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 072/242] netfilter: nf_conntrack_helper: pass helper to expect cleanup
Date: Wed,  8 Apr 2026 20:01:52 +0200
Message-ID: <20260408175929.778416842@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,nwl.cc,netfilter.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-234807-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,netfilter.org:email,nwl.cc:email]
X-Rspamd-Queue-Id: 196E13C1657
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qi Tang <tpluszz77@gmail.com>

[ Upstream commit a242a9ae58aa46ff7dae51ce64150a93957abe65 ]

nf_conntrack_helper_unregister() calls nf_ct_expect_iterate_destroy()
to remove expectations belonging to the helper being unregistered.
However, it passes NULL instead of the helper pointer as the data
argument, so expect_iter_me() never matches any expectation and all
of them survive the cleanup.

After unregister returns, nfnl_cthelper_del() frees the helper
object immediately.  Subsequent expectation dumps or packet-driven
init_conntrack() calls then dereference the freed exp->helper,
causing a use-after-free.

Pass the actual helper pointer so expectations referencing it are
properly destroyed before the helper object is freed.

  BUG: KASAN: slab-use-after-free in string+0x38f/0x430
  Read of size 1 at addr ffff888003b14d20 by task poc/103
  Call Trace:
   string+0x38f/0x430
   vsnprintf+0x3cc/0x1170
   seq_printf+0x17a/0x240
   exp_seq_show+0x2e5/0x560
   seq_read_iter+0x419/0x1280
   proc_reg_read+0x1ac/0x270
   vfs_read+0x179/0x930
   ksys_read+0xef/0x1c0
  Freed by task 103:
  The buggy address is located 32 bytes inside of
   freed 192-byte region [ffff888003b14d00, ffff888003b14dc0)

Fixes: ac7b84839003 ("netfilter: expect: add and use nf_ct_expect_iterate helpers")
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
Reviewed-by: Phil Sutter <phil@nwl.cc>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/netfilter/nf_conntrack_helper.c b/net/netfilter/nf_conntrack_helper.c
index ceb48c3ca0a43..9d7d36ac83083 100644
--- a/net/netfilter/nf_conntrack_helper.c
+++ b/net/netfilter/nf_conntrack_helper.c
@@ -419,7 +419,7 @@ void nf_conntrack_helper_unregister(struct nf_conntrack_helper *me)
 	 */
 	synchronize_rcu();
 
-	nf_ct_expect_iterate_destroy(expect_iter_me, NULL);
+	nf_ct_expect_iterate_destroy(expect_iter_me, me);
 	nf_ct_iterate_destroy(unhelp, me);
 }
 EXPORT_SYMBOL_GPL(nf_conntrack_helper_unregister);
-- 
2.53.0




