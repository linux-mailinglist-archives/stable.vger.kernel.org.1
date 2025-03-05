Return-Path: <stable+bounces-120393-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C72DA4F2F2
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 01:48:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3966F7A127D
	for <lists+stable@lfdr.de>; Wed,  5 Mar 2025 00:47:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F21D61DDE9;
	Wed,  5 Mar 2025 00:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoQioto4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29FB81E50B
	for <stable@vger.kernel.org>; Wed,  5 Mar 2025 00:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741135707; cv=none; b=G2qbDA9mt2iLr/VdRa49QH/DCJTQ810GZxuDGzfdfy2GNs5bTHP1Zfe6xWg4sRmUPgsE23kZiqsnU30kqYVktuJK3aoBApdRCsfy7A9An8e1qHKzbdiS3w2i+AIbJfMBlAjrNaMGkzXgmVtGDLQz3DrB++rMCNqX10zxawKRmy0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741135707; c=relaxed/simple;
	bh=JNVN48Idy8zApteJ4Tpy9VC4RKzWR7C77ffb+uIz13A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=cqgyHuMS+C/CVROzfd5fyXH5lpNI6gS3HjpGY9yVoB5vxyoZ5EyhJtNyuRXRhvITshXIVRmOYVWJ7fyhijOhJCv9rMPWO43J8yCTMx37wkNnjLkcBg1yMMBqS0+jFw9orktgxkQpxYhYLhcYasJbRl+1BSuE6hlmtl0RS2xqlWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoQioto4; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-5e4bed34bccso8793534a12.3
        for <stable@vger.kernel.org>; Tue, 04 Mar 2025 16:48:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1741135704; x=1741740504; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/e/GdwvLDoquOr0Afl2EN0vAREZXM36EPXG5G+ON0Dg=;
        b=RoQioto4JpAsahlainY85QahgY9BvDtChAmDBSAIFsBAq65VU4g1Hw/rGsL4jZgPWo
         ZNUZtipj14cB1BJpeWNKoUsANdCZVzK9lMvd52Cl12uGO8wc1oOFwg8GtEp6IxZ01QFt
         Z6J6ZEp1ZM3DAQ+XqNvp7cjWcV5+fHijFzIu18VsARZzqke7YykBNBsSs0O4AawhbJvq
         UHy8FZyh4ngEammY1ZC9jEdkze3VBwng8IiE1H5iPqyUhTLn72hGNafRokchE8QmfqZu
         n3zVYAJ2AR1P2nMLG2OxtwatRiyQb5Wreg8nm1Q3ZtmAb7d0fktbdQSuDXmQcQYyId0q
         V1pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1741135704; x=1741740504;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/e/GdwvLDoquOr0Afl2EN0vAREZXM36EPXG5G+ON0Dg=;
        b=eE6NEpDf31Yz0bXEZ2REIVokXqSbYEUAvXzo1As1L1vRnrR7ryoHIF94JncEUJu5vB
         I9C1FkaV73kVZSwZvcFDLBN3OY+0rKMbcOHGfmmS3dY6bgon8Qrm+fmnUg3PibGVn94A
         Dvs7nfmbOL407vtRmsbfvkmB4+NT9Q4YYwy+AYd7uSXST2fa+nf5Ay7mScwQKPV2LZUV
         IdwjTMsgreTF+aV2p0XjMxCVEOUoZYulUvRBwHQ1L4NNAfUnALSv8R2i0Mk9AKxbOAcY
         SgJTS3dUfNZqfmrPmoHaeh+3PXcdxD738d/5+3wQrMb5wwOAn738wzGBPbz65ljk0MRA
         KAAg==
X-Forwarded-Encrypted: i=1; AJvYcCVeRQf+xgIpohtGSjEfBGi55nVceMgtgeBRYrEE77wsy8TuM0bc1VjAB2K8eE4IlIDlWDUMlZo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw7wFydCtCzZd1dUnahMwX8DEca7hM/0G09YPy0Qff2U6Wyhc2k
	uPWNHadGrqvdXFpdw8i9EWhLkNrUZ9kCHR+oCVDl7UoyDgRn9Z4O
X-Gm-Gg: ASbGncsVmaWX6PHz53OCbqJa/4DyT4cYZ+Nam5SMl8dbIvc5PyvlzL+v43D4BIXqg84
	wdineAGem/1Wi8C3DsPjw1uXmR3M2jwNeHDy8UZcH2Ebj+VnyXs7WGlaDr97kUR7k47OjvPMZ3G
	OELJYzIxWbGG7e1mCHfVz7pTooQh8jz6a9+W1MuOKL9a0NfgNZUbxGMvOinirE49eSl4GA+7/ei
	ihpF4xCaioJCuOu/8K95JEmK15v5IPx8fOhIuUY/CyGO3x5FZrAaKyLTVFtkMDCHjmw004pesGD
	59sYVYshRSV2depCztMUi99SFB4UC1Zbj6biTW8Lo3Yv
X-Google-Smtp-Source: AGHT+IG6gadwKxOh36fq8DrtlBaSp/XaCd1kVvwHXSDhfOFhNJpvKa7fBPZkSi7Lr+IS/nXzw7HHUQ==
X-Received: by 2002:a17:906:f586:b0:ac1:ecb5:7212 with SMTP id a640c23a62f3a-ac20d94d4a0mr102109266b.31.1741135704174;
        Tue, 04 Mar 2025 16:48:24 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-abf0c6ed7f1sm1031397466b.120.2025.03.04.16.48.23
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 04 Mar 2025 16:48:23 -0800 (PST)
From: Wei Yang <richard.weiyang@gmail.com>
To: akpm@linux-foundation.org,
	Liam.Howlett@oracle.com
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	stable@vger.kernel.org
Subject: [Patch v2 1/3] maple_tree: Fix mt_destroy_walk() on root leaf node
Date: Wed,  5 Mar 2025 00:46:45 +0000
Message-Id: <20250305004647.21470-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250305004647.21470-1-richard.weiyang@gmail.com>
References: <20250305004647.21470-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

On destroy, we should set each node dead. But current code miss this
when the maple tree has only the root node.

The reason is mt_destroy_walk() leverage mte_destroy_descend() to set
node dead, but this is skipped since the only root node is a leaf.

Fixes this by setting the node dead if it is a leaf.

Fixes: 54a611b60590 ("Maple Tree: add new data structure")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
CC: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: <stable@vger.kernel.org>

---
v2:
  * move the operation into mt_destroy_walk()
  * adjust the title accordingly
---
 lib/maple_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index 4bd5a5be1440..0696e8d1c4e9 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5284,6 +5284,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 	struct maple_enode *start;
 
 	if (mte_is_leaf(enode)) {
+		mte_set_node_dead(enode);
 		node->type = mte_node_type(enode);
 		goto free_leaf;
 	}
-- 
2.34.1


