Return-Path: <stable+bounces-128780-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECC8CA7F0B7
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 01:14:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B5931884C81
	for <lists+stable@lfdr.de>; Mon,  7 Apr 2025 23:14:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA33227B88;
	Mon,  7 Apr 2025 23:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y8aUZdeO"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B5EA21B8F8;
	Mon,  7 Apr 2025 23:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744067664; cv=none; b=b+jh3/QuQbaiRT5mMTY/7P6sYbpbkQx7vsfUP3uIfgDLU2AprkgIVnM1V73m4cVok6sqbZ0jsWoYc1oYlhksWmndt32IVS+x0BaQXhFu5ORUzjP6P7A5MmipCemisW9UCHonLDxPXuHxLpBcWiTngfr6nLzsxyR4otRR4bqC7Qw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744067664; c=relaxed/simple;
	bh=JNVN48Idy8zApteJ4Tpy9VC4RKzWR7C77ffb+uIz13A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Esx+1h6n3xacwTE5EoylUBT2C1liyIOrdYsjQR7FJhixwwCJhHW+pzr9zq+fRwKQk3M8vMa8IwVv9dwgqCeo0guqMSr/K0Gfi8u+Z0iQL/p9UhF7ffD7Ylt6nMPUsTKU4Awwfojt3tOdoOMjF9OS79uk+0rPcqM70p7gzdySMSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y8aUZdeO; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5e8be1bdb7bso8209138a12.0;
        Mon, 07 Apr 2025 16:14:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744067660; x=1744672460; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/e/GdwvLDoquOr0Afl2EN0vAREZXM36EPXG5G+ON0Dg=;
        b=Y8aUZdeOdyLfhCQEiZrJCuy7i9yYhGSQqXHW+/eIUtU6zfQLN0UIypkQFtVBMmbcWZ
         O6JWTWhYcSt8X/ORZB6DE5RDiZCFPbDL5TZu/teMYQOpivs/I13BpUEK2LTQ8ueE2uEH
         j2vy0LDq7kCeyeLfuvuw3vJ8xqQoAFTwIMDEZ9zcS2Qz+PHkicIbx8QPRpCqF+o6kqZW
         4nAW4O1JuP6NkCVJr80OpbVHjnXcwY8YMXpkOQqvjGJHVBlm2Mo0ARyKk53P2PzS1Ova
         b8TpFql/tymutFKoKq3nZmWskGPc3TEnjMAyX/TldVzLuVEMM/55mrPYvRLdHW52u2xq
         ZJGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744067660; x=1744672460;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/e/GdwvLDoquOr0Afl2EN0vAREZXM36EPXG5G+ON0Dg=;
        b=W/0u3eB8qJ+EFcJ5HxfO/43587XpjK7hxMxScpfgPz1wteeoPzv1NtH459OPAE9LKJ
         4mSQRUwlDNOYJ2YZW2KsOObsCzqOrRxY/kmxbOL2wcfb84GDDQKDHl1SQJ/45U+pBEGy
         t1hD6kNm7krpdB2yOcTrok0oIpK363/iD13eZvfuKnSF81OVuh1UHItWoEZDNhXhW7RL
         CsYNYg/uinlGIeuGvq1gnGla+jK0CRvUm5jlptG/52Cnu7rheIWULBPNQLUZte8uAt8h
         YcK0vzlZvpP75T+gMWtjbD+U0FLywpE4A8PPadf2nPWU2eOW/jJG6d1w0dSt9YJUjzDy
         dw7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWqB2HfZ0LvBSc6E7XzdwmMg9GtiXl16RatyVAEGcx+lsOPxjf3OPS0h4jq/4D/98JicnMvrx0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yypz6k9NkBbKH1CKmdveqVWbHbftJMwbkXACN2xaH7LNgd4Llwm
	Rfo+Ww17PrIXXmftpbSvgpBGzt47AElPoLZhCr2Wr8kWSrtoWH1OkMJEybnY
X-Gm-Gg: ASbGncue9hnaF3nwG/1ciHQBfzq014vhOTpoDl2YX8p4xx0b8dvFIR9C8PwoDK8DYKn
	0TfrxlfTsZHgLtDkz+ZrwWyGQ4Ig7gBEt6VUs4JOEaNZnhaaa7Y94ZpCkegVra6vB6YcpzlRmwA
	ZCqJXrbLKqkZbc2KYpfBH8T7RROtGMYWsXPOTH281MwIUaaQvopNbYL5iM3xU36YzvhqZ5vwo0q
	2Q2Bh/zG/80X0H/5uIjDGC3OfWIUvMaysnwS0+xZCeDQFuo5RdhMKxf99MW1FeZdMKZtEg1euKD
	9GMr0/T0GEko4UetISNHIZlUiGwZNSInKaQi8HJ1mHRRpu1+kZ4eQxM=
X-Google-Smtp-Source: AGHT+IEizGkSgcvWbtRztjIhWVy9nYG+6Q1+YXuX+viOwFgo+QuD+47ezAE0MB7BT51RcdiPpVzD+w==
X-Received: by 2002:a17:907:7206:b0:ac7:cbe2:87f5 with SMTP id a640c23a62f3a-ac7e6ef17ffmr1014917266b.0.1744067660454;
        Mon, 07 Apr 2025 16:14:20 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ac7c013f730sm831204166b.92.2025.04.07.16.14.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 07 Apr 2025 16:14:20 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: linux-kernel@vger.kernel.org,
	maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	stable@vger.kernel.org
Subject: [RESEND Patch v2 1/3] maple_tree: Fix mt_destroy_walk() on root leaf node
Date: Mon,  7 Apr 2025 23:13:52 +0000
Message-Id: <20250407231354.11771-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250407231354.11771-1-richard.weiyang@gmail.com>
References: <20250407231354.11771-1-richard.weiyang@gmail.com>
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


