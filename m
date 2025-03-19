Return-Path: <stable+bounces-125428-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 46015A690E7
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 15:52:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EEE0A1706C7
	for <lists+stable@lfdr.de>; Wed, 19 Mar 2025 14:49:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF46D1FC7D9;
	Wed, 19 Mar 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2khjuBGa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DCD11DE8AB;
	Wed, 19 Mar 2025 14:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742395180; cv=none; b=DjVCSIVbH6Ds8n9laU7WeN73ZRD6+uSIc/iAAZ2qFBFi2aNZw/MN/Eux9b6Imfwizv3PDinM5y8NPE4H8iKIjBOueBHuBUk0UBnc/UxbZpo1TdWuHSVySAWd2nL/zVadfMwMCPTpQDhHAenTKbQ9/hZYmFD5Uly9Sy9fGupTE+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742395180; c=relaxed/simple;
	bh=xwDq6jG2rkdUAGwcflfFfaHLpq6eRf/DlTuvR4WEB/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K9k+wzDBvWDzygh1gjuPyislHIhhKM0Wf8nQXYJnlJp18Tm3/U/EdBoLgN7COltTw2O1hwGHoDZaPzd4du1FW3OBTvS43s85BXZUeVg/9dMePLn6iXV2uM616gpNhdB2PH7rjD1Dt2oMnjUNh5BJyjYBwr2kVrQ81ZUQYsZN8So=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2khjuBGa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 713F2C4CEE8;
	Wed, 19 Mar 2025 14:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742395180;
	bh=xwDq6jG2rkdUAGwcflfFfaHLpq6eRf/DlTuvR4WEB/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2khjuBGa1rJH6slr7hKghz8VN6n239wp1ROa79BqrVKYmFGc4hXqUx+F47s8j6+oX
	 joo0rnokRo6K1LDPf31co+8EI04ZZu6KtiA/1FCB15qh6cL1TodJA9e+m0iv+kNfnz
	 suYVqmRR9SVH6Tm7Z4MOHelIBUWFBvaNMKPgDxIA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Florian Westphal <fw@strlen.de>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 010/166] netfilter: nft_ct: Use __refcount_inc() for per-CPU nft_ct_pcpu_template.
Date: Wed, 19 Mar 2025 07:29:41 -0700
Message-ID: <20250319143020.261049735@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250319143019.983527953@linuxfoundation.org>
References: <20250319143019.983527953@linuxfoundation.org>
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

From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>

[ Upstream commit 5cfe5612ca9590db69b9be29dc83041dbf001108 ]

nft_ct_pcpu_template is a per-CPU variable and relies on disabled BH for its
locking. The refcounter is read and if its value is set to one then the
refcounter is incremented and variable is used - otherwise it is already
in use and left untouched.

Without per-CPU locking in local_bh_disable() on PREEMPT_RT the
read-then-increment operation is not atomic and therefore racy.

This can be avoided by using unconditionally __refcount_inc() which will
increment counter and return the old value as an atomic operation.
In case the returned counter is not one, the variable is in use and we
need to decrement counter. Otherwise we can use it.

Use __refcount_inc() instead of read and a conditional increment.

Fixes: edee4f1e9245 ("netfilter: nft_ct: add zone id set support")
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Reviewed-by: Florian Westphal <fw@strlen.de>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/netfilter/nft_ct.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/netfilter/nft_ct.c b/net/netfilter/nft_ct.c
index 255640013ab84..ab1214da99ff3 100644
--- a/net/netfilter/nft_ct.c
+++ b/net/netfilter/nft_ct.c
@@ -230,6 +230,7 @@ static void nft_ct_set_zone_eval(const struct nft_expr *expr,
 	enum ip_conntrack_info ctinfo;
 	u16 value = nft_reg_load16(&regs->data[priv->sreg]);
 	struct nf_conn *ct;
+	int oldcnt;
 
 	ct = nf_ct_get(skb, &ctinfo);
 	if (ct) /* already tracked */
@@ -250,10 +251,11 @@ static void nft_ct_set_zone_eval(const struct nft_expr *expr,
 
 	ct = this_cpu_read(nft_ct_pcpu_template);
 
-	if (likely(refcount_read(&ct->ct_general.use) == 1)) {
-		refcount_inc(&ct->ct_general.use);
+	__refcount_inc(&ct->ct_general.use, &oldcnt);
+	if (likely(oldcnt == 1)) {
 		nf_ct_zone_add(ct, &zone);
 	} else {
+		refcount_dec(&ct->ct_general.use);
 		/* previous skb got queued to userspace, allocate temporary
 		 * one until percpu template can be reused.
 		 */
-- 
2.39.5




