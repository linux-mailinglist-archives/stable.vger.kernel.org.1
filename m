Return-Path: <stable+bounces-114357-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 061B9A2D296
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 02:26:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB8227A5278
	for <lists+stable@lfdr.de>; Sat,  8 Feb 2025 01:25:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 955AB76035;
	Sat,  8 Feb 2025 01:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R4pOY+yu"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE6F22941C
	for <stable@vger.kernel.org>; Sat,  8 Feb 2025 01:26:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738977967; cv=none; b=MX6gMDhsAlHZewzvm4OhfvpgXFsBRcIIs68U+nVog0rBJDdkjh16eUTayOk/lJ7dJTFct/GSzGez/XQqcnhmAyxM7KEy1z665NhML4qf68Agi8XvcHnMrM1hHA6R6RHZpGFwMt6SUBorjBtH1HHSttRQTmpev3gVBpx0oCfdrRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738977967; c=relaxed/simple;
	bh=sahtUrRV4F11OtxMiLtnkU8Z/2ECsHfUt5TTOZjXfIg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=YymbsTHyzmzkR8zXW0GA+tT6DSuQoiLBcjFwbuUSLOnRvhLdnaoXBLPc4Bbo1QPwvq3HOyt5jSXPnbLodrqFPeO7i7wgPMpyzevaFghczv0xaKNJMJarWVHvF7Mh8lddL96X1xikqz1+Qpx9DFKs2J+5fPlRKg/cMc0TC/7trLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R4pOY+yu; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5dce1d61b44so4840036a12.2
        for <stable@vger.kernel.org>; Fri, 07 Feb 2025 17:26:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738977964; x=1739582764; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fLDMeSZyah2fkrjijPxL4OtrUZg2XamYMH3/3OG/eCg=;
        b=R4pOY+yuyTPNiEDxMrK6bBws/RxJJ7IhxQ4Gw1bvP4W+7CZNqQZjvsQWIzi0Pj1KNl
         ESNRmoMK1Hf0ZxHvvZOAJwTq+2As7m1+M7Aw8USNEGk+VZhwP821FTgLKtfRaHSlY5cP
         QfO59GYlGuPgKT0e0xMLmL7OH2aRbesmdTSHmwTLb3G9NKVOGkmbPOAxnunnM7/0M3Cw
         yNWuT+UxnVdHKizs8yti9ynggAESt/jdJ25tnY/spU6DfXkvveNQLHdNfJ7oyiuukBpU
         zvIIW0qJ5ArGhfQKRiuyuQefHnVXLyRpT08GK+JzfCzLjnRoNCixSMc9b/R68DJWBDzU
         C3XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738977964; x=1739582764;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fLDMeSZyah2fkrjijPxL4OtrUZg2XamYMH3/3OG/eCg=;
        b=q1bKC36sv2Hjf8FOPr+a2O15M88RyNArD4lThG5ek6pzazGVyk9IL7arxCEw7EAOkX
         aeXtVtXRpaI9jKHHwL8xlzK9SOd55KI/9SMM8pD+Sg2uGv6WI+4zjz/mwMUoPjIjIrF8
         jz4OB/lQp0/q6On5BAf0pwedAM0IkNq7sxiMz976HLY4RVGdt7ajGiBXd+8N/Usef7Vs
         tP9szZINko5EOIyBvHbjKBj+fooS6S8Usht+2JE2XvcyRODWazz/xUSZup1rJ2DD7Xqx
         O7H1SQmyNMmaib8EmsWaOk6RjZX8GleHIXdyVaeOsZ3sl9UNi6JFmIRoEEh4rePo+Epo
         GM7A==
X-Forwarded-Encrypted: i=1; AJvYcCVGxfnZ1bGQCK7CvO7FV/bGd8Y1LBtM7/cEnyuddq4rLxuDbSOFasKTZBYybl5qPbuepaYXgB8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwhE1pAXiX1y8BFe5t5g1wjDyEc3wGGi1/ld8cZpOZG9W5OfeS6
	LjrtYA4O5CKFDxoco6d4vIx3q+eCqsJfo60FjdV1lecq0NTDSoEh
X-Gm-Gg: ASbGncubXAIWv12ntsE6VeU6sUAWTKbNFnCpLh3r6xXT7wlNxwPYnDjIL64/Hm4tCWt
	H8WQgbq3JRlZ6Kp7gjN/EB5+39TbqT/wvML0dbYQnSX/eQsyU1KMrcXhFCtpIJ7bs6cgALiY3JZ
	mjPJd4JZNQg3U6/IJiuB55ZsZqnzgPl65e/jHQwWuBf1TvqhydlRuPoaf6NRnQrPLiDwDPIUe9r
	p448LlgSKnVWO40cUeLKaeWkcrerHWlzPT/w020paO6XjMBOKwJ+jfaK9QNDizeymSi6FPCyK6R
	n2iPgiFNWWjAE6Y=
X-Google-Smtp-Source: AGHT+IEPtwi0N2AbvtnTVVyyBxTDyMu15TivVjy+pf1TDfT9vTvLYpAMwscrZ0qLSeZw8OB0RdcALw==
X-Received: by 2002:a17:907:7f1e:b0:ab7:ca9:44e4 with SMTP id a640c23a62f3a-ab789ac11b5mr517843166b.15.1738977963829;
        Fri, 07 Feb 2025 17:26:03 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab772f49551sm362874466b.21.2025.02.07.17.26.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 07 Feb 2025 17:26:02 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/3] maple_tree: may miss to set node dead on destroy
Date: Sat,  8 Feb 2025 01:18:50 +0000
Message-Id: <20250208011852.31434-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250208011852.31434-1-richard.weiyang@gmail.com>
References: <20250208011852.31434-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On destroy, we should set each node dead. But current code miss this
when the maple tree has only the root node.

The reason is mt_destroy_walk() leverage mte_destroy_descend() to set
node dead, but this is skipped since the only root node is a leaf.

This patch fixes this by setting the root dead before mt_destroy_walk().

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: <stable@vger.kernel.org>
---
 lib/maple_tree.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 198c14dd3377..d31f0a2858f7 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5347,6 +5347,8 @@ static inline void mte_destroy_walk(struct maple_enode *enode,
 {
 	struct maple_node *node = mte_to_node(enode);
 
+	mte_set_node_dead(enode);
+
 	if (mt_in_rcu(mt)) {
 		mt_destroy_walk(enode, mt, false);
 		call_rcu(&node->rcu, mt_free_walk);
-- 
2.34.1


