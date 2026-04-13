Return-Path: <stable+bounces-237432-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ELpzCNIk3WlSaQkAu9opvQ
	(envelope-from <stable+bounces-237432-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:16:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 899323F113A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 19:16:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D4BE30ECB60
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:58:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94C643368B5;
	Mon, 13 Apr 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XClEGc1F"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5817E332621;
	Mon, 13 Apr 2026 16:57:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776099442; cv=none; b=T4O172n/0f528u4W1oAVBdpo/d4Ci4Zc1IRHR6o6M1eF9esqySZe367hHBC8jPO89iGxXiXUhCF52993kxzzZqLZ1M+Dr9FSc6vBYzRyhCnkP76wO0KyKgs7e+Ma6V3S4NcrOSbZwKcOoJzsdZlnCUMdXIcKDlm4FHT70WZvzM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776099442; c=relaxed/simple;
	bh=M1m9Gq0GkKBo6XP8y2HGSOaZ5fbQ8x3SridUWdWW5aE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IO/9ONKXU8Oe+imK/gMSyX/82AHHCCzzzfMQqK+5Cwui4o8TLTaOQjwlqE4layVX+FcMvhpJYKEaDpfOLhQukGFSOmAOW3I8pSpVjsYla/FeLdxBb1JXWnlWIJD3GHbQjwKISEkttvZZ31bK+BS59h47U6O2Y5k+9GzXfdBfIkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XClEGc1F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3143C2BCAF;
	Mon, 13 Apr 2026 16:57:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776099442;
	bh=M1m9Gq0GkKBo6XP8y2HGSOaZ5fbQ8x3SridUWdWW5aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XClEGc1FYF6VquA80zrC1n7jbQx0mEczU0uxhcsiYfi6GiPEWEFzI1UryqClAa5dJ
	 +yupOwtAEfNjUzBvA4mP9dW1TLDO9WX6UGa0VndpuQ7QqdEy8VlTZXGCV/oU9cuVQF
	 zBvNwF+T2q94QfLK4xFuEsRGm00uGB86OP8HfcQg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Qi Tang <tpluszz77@gmail.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 341/491] netfilter: ctnetlink: zero expect NAT fields when CTA_EXPECT_NAT absent
Date: Mon, 13 Apr 2026 17:59:46 +0200
Message-ID: <20260413155831.806285285@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155819.042779211@linuxfoundation.org>
References: <20260413155819.042779211@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,intel.com,gmail.com,netfilter.org,kernel.org];
	TAGGED_FROM(0.00)[bounces-237432-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:mid,netfilter.org:email,intel.com:email]
X-Rspamd-Queue-Id: 899323F113A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qi Tang <tpluszz77@gmail.com>

[ Upstream commit 35177c6877134a21315f37d57a5577846225623e ]

ctnetlink_alloc_expect() allocates expectations from a non-zeroing
slab cache via nf_ct_expect_alloc().  When CTA_EXPECT_NAT is not
present in the netlink message, saved_addr and saved_proto are
never initialized.  Stale data from a previous slab occupant can
then be dumped to userspace by ctnetlink_exp_dump_expect(), which
checks these fields to decide whether to emit CTA_EXPECT_NAT.

The safe sibling nf_ct_expect_init(), used by the packet path,
explicitly zeroes these fields.

Zero saved_addr, saved_proto and dir in the else branch, guarded
by IS_ENABLED(CONFIG_NF_NAT) since these fields only exist when
NAT is enabled.

Confirmed by priming the expect slab with NAT-bearing expectations,
freeing them, creating a new expectation without CTA_EXPECT_NAT,
and observing that the ctnetlink dump emits a spurious
CTA_EXPECT_NAT containing stale data from the prior allocation.

Fixes: 076a0ca02644 ("netfilter: ctnetlink: add NAT support for expectations")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Qi Tang <tpluszz77@gmail.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nf_conntrack_netlink.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/netfilter/nf_conntrack_netlink.c b/net/netfilter/nf_conntrack_netlink.c
index 8d35e17a0f7e7..befc9d2bc0b52 100644
--- a/net/netfilter/nf_conntrack_netlink.c
+++ b/net/netfilter/nf_conntrack_netlink.c
@@ -3568,6 +3568,12 @@ ctnetlink_alloc_expect(const struct nlattr * const cda[], struct nf_conn *ct,
 						 exp, nf_ct_l3num(ct));
 		if (err < 0)
 			goto err_out;
+#if IS_ENABLED(CONFIG_NF_NAT)
+	} else {
+		memset(&exp->saved_addr, 0, sizeof(exp->saved_addr));
+		memset(&exp->saved_proto, 0, sizeof(exp->saved_proto));
+		exp->dir = 0;
+#endif
 	}
 	return exp;
 err_out:
-- 
2.53.0




