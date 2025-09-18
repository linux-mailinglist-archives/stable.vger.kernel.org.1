Return-Path: <stable+bounces-178334-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DAA6B47E3C
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 22:21:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 482FE3C1671
	for <lists+stable@lfdr.de>; Sun,  7 Sep 2025 20:21:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9B51F1921;
	Sun,  7 Sep 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ULBsM4Zc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E13D1A2389;
	Sun,  7 Sep 2025 20:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757276506; cv=none; b=aDHyTG4fkx3rep1ktUACN/36DPMyyGxiyiL2sQ/1ctmnVMeM8W2OsWv3XUVrt5POa0RKTcOCONUvwBSqP+7/yz6mV0c2k6FaeuqUqFJti/e0cMvHvADLtsNGdx/fnh5PwnToJnrs81JIgBDJaRHnD4zYEgYvN+5C80T8dk89FQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757276506; c=relaxed/simple;
	bh=bPqRlOlGIPouChl4Jxh3WXuQ8/yM84wrm3epgbvucLA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=teGItW7tnPMhJalNTtm4jOD8TZ2bMktmawvNMPW7QsM8gN62utg9+evrnOo0VGrM8QNuqjj3uad9kyOGjX+gEj4TkBW9dEyc6V3VW19K4rUe1Wzm/L1fO5B5sSGwyHjEUiLuoSnEPyVTnPptboPFckrGeHtc0d9UTQD3qxPZ3jA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ULBsM4Zc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23F1BC4CEF0;
	Sun,  7 Sep 2025 20:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757276506;
	bh=bPqRlOlGIPouChl4Jxh3WXuQ8/yM84wrm3epgbvucLA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ULBsM4Zc3Kq/iJIMrSDpNxAPAV7l8VFFVemlqAs3wWXU2MpQWSCVBl0E+x6V8a4UM
	 pjGFtG8UAlWT9cgMfx9H2A29tFCPFIOG/O1TG25QMNimDmVRdB6vEF+c9qW5xAQQNd
	 7FJyOQHTLJIYC9mm+HaCQLp1tw/PF8ogNa0zD268=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Westphal <fw@strlen.de>,
	Wang Liang <wangliang74@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 021/121] netfilter: br_netfilter: do not check confirmed bit in br_nf_local_in() after confirm
Date: Sun,  7 Sep 2025 21:57:37 +0200
Message-ID: <20250907195610.359476337@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250907195609.817339617@linuxfoundation.org>
References: <20250907195609.817339617@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wang Liang <wangliang74@huawei.com>

[ Upstream commit 479a54ab92087318514c82428a87af2d7af1a576 ]

When send a broadcast packet to a tap device, which was added to a bridge,
br_nf_local_in() is called to confirm the conntrack. If another conntrack
with the same hash value is added to the hash table, which can be
triggered by a normal packet to a non-bridge device, the below warning
may happen.

  ------------[ cut here ]------------
  WARNING: CPU: 1 PID: 96 at net/bridge/br_netfilter_hooks.c:632 br_nf_local_in+0x168/0x200
  CPU: 1 UID: 0 PID: 96 Comm: tap_send Not tainted 6.17.0-rc2-dirty #44 PREEMPT(voluntary)
  RIP: 0010:br_nf_local_in+0x168/0x200
  Call Trace:
   <TASK>
   nf_hook_slow+0x3e/0xf0
   br_pass_frame_up+0x103/0x180
   br_handle_frame_finish+0x2de/0x5b0
   br_nf_hook_thresh+0xc0/0x120
   br_nf_pre_routing_finish+0x168/0x3a0
   br_nf_pre_routing+0x237/0x5e0
   br_handle_frame+0x1ec/0x3c0
   __netif_receive_skb_core+0x225/0x1210
   __netif_receive_skb_one_core+0x37/0xa0
   netif_receive_skb+0x36/0x160
   tun_get_user+0xa54/0x10c0
   tun_chr_write_iter+0x65/0xb0
   vfs_write+0x305/0x410
   ksys_write+0x60/0xd0
   do_syscall_64+0xa4/0x260
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>
  ---[ end trace 0000000000000000 ]---

To solve the hash conflict, nf_ct_resolve_clash() try to merge the
conntracks, and update skb->_nfct. However, br_nf_local_in() still use the
old ct from local variable 'nfct' after confirm(), which leads to this
warning.

If confirm() does not insert the conntrack entry and return NF_DROP, the
warning may also occur. There is no need to reserve the WARN_ON_ONCE, just
remove it.

Link: https://lore.kernel.org/netdev/20250820043329.2902014-1-wangliang74@huawei.com/
Fixes: 62e7151ae3eb ("netfilter: bridge: confirm multicast packets before passing them up the stack")
Suggested-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Wang Liang <wangliang74@huawei.com>
Signed-off-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/bridge/br_netfilter_hooks.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/net/bridge/br_netfilter_hooks.c b/net/bridge/br_netfilter_hooks.c
index 2a4958e995f2d..e6962d693359b 100644
--- a/net/bridge/br_netfilter_hooks.c
+++ b/net/bridge/br_netfilter_hooks.c
@@ -648,9 +648,6 @@ static unsigned int br_nf_local_in(void *priv,
 		break;
 	}
 
-	ct = container_of(nfct, struct nf_conn, ct_general);
-	WARN_ON_ONCE(!nf_ct_is_confirmed(ct));
-
 	return ret;
 }
 #endif
-- 
2.50.1




