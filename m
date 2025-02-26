Return-Path: <stable+bounces-119732-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E698A468CE
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 19:03:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 20F8F172341
	for <lists+stable@lfdr.de>; Wed, 26 Feb 2025 18:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41A01221F21;
	Wed, 26 Feb 2025 18:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KV53t0cD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9522022B595
	for <stable@vger.kernel.org>; Wed, 26 Feb 2025 18:02:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740592980; cv=none; b=hUeqS8UnSGtkOhYz8J9HTzHO/YIm93390zBDJMfcAyZptB5YehVMbogNkqj4fon7Gbll+ZHJjWQGIsSGOpGHRGpisjYEDIp2mDDfhtYeHArz3bNY8lqrPuXh1e6jnQvVtJg1eCrMfJ6f7/V1ZaPYWnSa/Tpxmh/Oocmun87Oifs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740592980; c=relaxed/simple;
	bh=w5cyvEfXAn7kPCStXxRU5PStJ8Ue0Ta+g9Bm1ZPxsUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mNTnVWR5adCqGtFtzO8YESY+I+X69USHQ1p93TfpKzz4MntYdrZdx9HByHIMQ5C2ZlJfy6C601QGfNtPsI+pIkOm1Y+wUvEliw0btaGIG6ec3d/J1DtAHeJGjF/dXBwvwPb76qkBWRFbw/ZhhhO78uy3W43U41uve/K3v1uwy28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KV53t0cD; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-223480ea43aso832525ad.1
        for <stable@vger.kernel.org>; Wed, 26 Feb 2025 10:02:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740592977; x=1741197777; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vY89IKRCZO3Qji0837zJbJJ3wh+hqi/K7lDP7BBo1zU=;
        b=KV53t0cDC1Zoio3eV7spCCDCId4scK/qtGK3P+GZK4WFEAqBmqZUdabbk2YyHIdG6R
         SVLqTDB/R36gzfUfVAj/2TuCfTcVk/T/v1QDjjdniegXNnE8A8JAQLfLrtCv4MxytS9L
         BDuXP7Gh8fziJWBhrFMe46Da4szV7f3yH5kWGRgAX7VHduMtbXOge7vR5XTk2bq4vju1
         798R7EVgxxqTkfyl2/mFccU4RvtG/KA3kPkJ48WM1DKgarMMrhJoBONOINn+r5alOPF+
         tfjlCOcmXMW9E92528Pt4MrpdyMEGJ8U3b1ngNbqTpKqzNWMwxm6qWUpRoCvmfkPKFL9
         phhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740592977; x=1741197777;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vY89IKRCZO3Qji0837zJbJJ3wh+hqi/K7lDP7BBo1zU=;
        b=l4Wi6O9fseh6FDizx/0ZMC+OWjdpMvp9siE1YvYA+PK9o8bjhvb4UUUDUV/khMMUBl
         QTyyINTteIAaiZSV2gQ3eM0eKfWksrgMhdDe9cr1QXM147sNhNL/9kWepWLiqui9wOFi
         mak4Hy2OUpgJtBfIVunbc7wtdMpmnTxOWu/vNLAPHNj7Ax4bv1szVJeLkfvkB7ITionp
         vxlvTxsOt3+q+s0Jvyv721tL0/ql/C4zSNmsG7z0G/cZ3UJkGKbQDhO66oZGq9dAupX4
         /ZRXcgkBp/U98kGVZNQZGdI9GSoSu4XF+01Kg865RuUS+54BfGtGNK0/03RAo4xtK83L
         PS/w==
X-Gm-Message-State: AOJu0YxUuZbxfIHQu8ZUZzoC/LI9HcuMS86JmgK5J5k6C2GBZC6Tu/DE
	0PgbRb1x9rIWR0pa3rVGI8LtkNjwZGiHRvO5vo1GKYv6TjSAZYiKBl012w==
X-Gm-Gg: ASbGncuVuJjynaZPapmza0ACM2zaDbPPhQYYSZFlOMLm6Uh5f69H35hJpXoY26s4h9c
	M13m7Ia93EfWiGWbKaYY/WjGDPyocB1hZyLZ2CjNPH/68EhNGCTs8qCwwudwzoML1vj1mOJZziz
	gUhywgko46LctTSHUrgs2fCDzPtisQqtFPQRnldmx61FH5d9UaZKnn9Js9nfGhgcA4jU3X4Ywyu
	8nMtZeupwY4KYgN3qbhHPVuCN/JJXi5fO0ho0F9pcpU2TZV78qXTsMMeu6P8vmjNCMyRUAVWGhc
	F6io7mHgS8A27dPpCpnmtEcMi2FV77S335DUvEabnBxNHaFNd6MnvRcqjw6vU7lb3g==
X-Google-Smtp-Source: AGHT+IETrudNXQuXgo9gx4/U2Evj2w1IUIHgEl5VUtm9VfAH/mtVdvTx6qi2qpvpHJRknERAJ1UN6w==
X-Received: by 2002:a17:902:d503:b0:21f:f02:413c with SMTP id d9443c01a7336-221a11737a6mr371047065ad.42.1740592977345;
        Wed, 26 Feb 2025 10:02:57 -0800 (PST)
Received: from carrot.. (i118-19-4-47.s41.a014.ap.plala.or.jp. [118.19.4.47])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2230a000995sm35747655ad.46.2025.02.26.10.02.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2025 10:02:56 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 5.4 5.10 5.15 6.1 2/3] nilfs2: eliminate staggered calls to kunmap in nilfs_rename
Date: Thu, 27 Feb 2025 03:00:22 +0900
Message-ID: <20250226180247.4950-3-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250226180247.4950-1-konishi.ryusuke@gmail.com>
References: <20250226180247.4950-1-konishi.ryusuke@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 8cf57c6df818f58fdad16a909506be213623a88e upstream.

In nilfs_rename(), calls to nilfs_put_page() to release pages obtained
with nilfs_find_entry() or nilfs_dotdot() are alternated in the normal
path.

When replacing the kernel memory mapping method from kmap to
kmap_local_{page,folio}, this violates the constraint on the calling order
of kunmap_local().

Swap the order of nilfs_put_page calls where the kmap sections of multiple
pages overlap so that they are nested, allowing direct replacement of
nilfs_put_page() -> unmap_and_put_page().

Without this reordering, that replacement will cause a kernel WARNING in
kunmap_local_indexed() on architectures with high memory mapping.

Link: https://lkml.kernel.org/r/20231127143036.2425-3-konishi.ryusuke@gmail.com
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Stable-dep-of: ee70999a988b ("nilfs2: handle errors that nilfs_prepare_chunk() may return")
---
 fs/nilfs2/namei.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/nilfs2/namei.c b/fs/nilfs2/namei.c
index 9283a707c013..bbd27238b0e6 100644
--- a/fs/nilfs2/namei.c
+++ b/fs/nilfs2/namei.c
@@ -431,13 +431,14 @@ static int nilfs_rename(struct user_namespace *mnt_userns,
 	old_inode->i_ctime = current_time(old_inode);
 
 	nilfs_delete_entry(old_de, old_page);
-	nilfs_put_page(old_page);
 
 	if (dir_de) {
 		nilfs_set_link(old_inode, dir_de, dir_page, new_dir);
 		nilfs_put_page(dir_page);
 		drop_nlink(old_dir);
 	}
+	nilfs_put_page(old_page);
+
 	nilfs_mark_inode_dirty(old_dir);
 	nilfs_mark_inode_dirty(old_inode);
 
-- 
2.43.5


