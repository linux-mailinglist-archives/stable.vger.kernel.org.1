Return-Path: <stable+bounces-152361-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B084EAD47C2
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 03:13:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8FCCC189CA3F
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 01:13:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB11317BBF;
	Wed, 11 Jun 2025 01:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikV5a04y"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C76D22D5427
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 01:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749604381; cv=none; b=qpFsMnVmfVi5z60v+JAjL8glSNuxjXL3xeCyec/GU3csL55U5kBADkQ2EJ6y66J5mGqnotxdzfCEd+5p/1rrt+BNlhVDZ5lMUX4QLUfDPiAdMzvVifw+hfi6DJO3AjS0WmtgCpasRdJmObHvwuPnsBVk0C8WkIBCSBcGi/Z4OyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749604381; c=relaxed/simple;
	bh=eIK+da+OLGSXm+5qfI76/fBr+0i4XER+RWLHIcSX5l0=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=AXuj5aNaoAQuI5pUPPYM5EsD3L7ghHaK6d8E6JKh/1qeiOhoACPjO1hCFtbsvtSI2m6TRUkCR2VEb/uXmtjHl1mQHzNTf+qKTBAaf9Dlb3VCziGAV/xi0sGjHOvUpY9bFCN5zpvs8OdFo9dMfzf5X1rVC/BWtgtl/3lvstZR3Es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikV5a04y; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-6077dea37easo7591309a12.3
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 18:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749604378; x=1750209178; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=iRJ6O+s3XABPlTWV3eN6DId9Ma2DDx185T/aGv+NQxk=;
        b=ikV5a04yvkswUSMadJQe1hZMNhz/TG6ZWO8LjerROZVa/KASKrnOubrCct8jfBW00K
         Oa6mGKXNHNgq8NERaV6pCWtTqUjgFosSMqyN0L3GZyuoA8yslaNi40YcOhb1A/FbhNGf
         KHv0YO9b9k5IvG2GpeDgQsqXm7aFRGBsUTeA6NbOkRQHTkEvh6CMoo6DKxYjST9+WrK3
         Tuk5CTPmtbLaqKvrs9MVMtCnSESsLZVngalFmzgxuWavfku/FrVwOKlPcEMC9/yYGibr
         z/1S1ePlpNcZiFlkVtbxHnXOCP9G7ERDAxBo+FvUZUK+Bva5NbYSqhbiDtaIEQdAsfWS
         N+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749604378; x=1750209178;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iRJ6O+s3XABPlTWV3eN6DId9Ma2DDx185T/aGv+NQxk=;
        b=RSPaxKPomHNYJDoWSkyzgl6OvfeP2E3UINM9BytIwHN7ub2IlHtqeoPVcNAAHqGBYz
         Zz8wuCwvvRwliefn0WxtxzUC5TdgvVsr8GEixVOv0Kmsbgj7SdzkVLQfB3D/EwBRf25U
         APlFiNQEaKe1Bh9Wi4RT6R19YKNX7ed+CttICsOsoA4w2fxEQE0PjwayNSf3yqSKoiSq
         cNCHtHWNglKzBXLKhCW813SnVgLjYp4ZSYGfK+yMctAjUakygKjEYYKGxbaJ8dX06LpN
         LB58M7dCIWDmACsR5R5xv34g+F7NJ8CKDB8DTIEvnDBt9pG+1wLlksre8R03d4/Dc2ad
         s+BQ==
X-Forwarded-Encrypted: i=1; AJvYcCXU10U81Y5TilpWE5iwhMSRkd/jTQ8KZ7Y0oWHqWQAJZm1Q71KIZA+DobtN++/w3DwHRJ9ur/w=@vger.kernel.org
X-Gm-Message-State: AOJu0YzjOtgD6kYIyNqZj7gBVEuTXrz++XV5A/dj3uVQ+k7dLr1k6kNk
	VKH+qSB3ARyTBBF+727BHUitllGQgZ3ca6dKwDXL46U/RIy1dxXrihWx
X-Gm-Gg: ASbGncvWzFldJ/e2MqGHzXAFSm1jYl6DKSEBuB3ZynftsblLqXvh/XyxzNbG6I3BBEN
	SiSyATpS/T1p3mMwp5p8yOx8nt8QlD1SubHaGPeMLfiXOLz29ExwDWiKdIq1DXlaRpC6a428CR2
	Zs+1oLC3gcBw6V3C6l4ADVRksmtJqSxPHSqn1CZXxZNVJYnZ1vVibmUGT+c0UbKPyChN9dOGcg2
	ISY+XKufcvQvccpwSexhSnDQY3yYbLSsWPY6GcCKifvb/Y+MFnVoSSgn1Jc11jD6ps7eXun1dk7
	wc5dVo8i6uaH9Y2ig8VYUuAP72mFZzRF5o+Fg+r42Y9IThpTSAwznzPMHevIKg==
X-Google-Smtp-Source: AGHT+IEYbL/caU1BJpVVJ1puQQCXnkuwbG4wlacVSfVfmhF3K+TSkyvjMUgCDcScAVdWcl/uWLu60Q==
X-Received: by 2002:a05:6402:5194:b0:601:31e6:698d with SMTP id 4fb4d7f45d1cf-60846cdb725mr1004872a12.23.1749604377903;
        Tue, 10 Jun 2025 18:12:57 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6077837756esm6824352a12.17.2025.06.10.18.12.56
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jun 2025 18:12:56 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	stable@vger.kernel.org
Subject: [Patch v3 1/3] maple_tree: Fix mt_destroy_walk() on root leaf node
Date: Wed, 11 Jun 2025 01:12:51 +0000
Message-Id: <20250611011253.19515-2-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250611011253.19515-1-richard.weiyang@gmail.com>
References: <20250611011253.19515-1-richard.weiyang@gmail.com>
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
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>

---
v2:
  * move the operation into mt_destroy_walk()
  * adjust the title accordingly
---
 lib/maple_tree.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index affe979bd14d..b0c345b6e646 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -5319,6 +5319,7 @@ static void mt_destroy_walk(struct maple_enode *enode, struct maple_tree *mt,
 	struct maple_enode *start;
 
 	if (mte_is_leaf(enode)) {
+		mte_set_node_dead(enode);
 		node->type = mte_node_type(enode);
 		goto free_leaf;
 	}
-- 
2.34.1


