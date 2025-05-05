Return-Path: <stable+bounces-139706-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D06AAA96E2
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 17:05:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C8DA16580C
	for <lists+stable@lfdr.de>; Mon,  5 May 2025 15:05:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B016425C6E8;
	Mon,  5 May 2025 15:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mDtBKQN4"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06FBF25A2C6
	for <stable@vger.kernel.org>; Mon,  5 May 2025 15:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746457504; cv=none; b=eKtpqDEuBh6GFtosOFJ0J+HfOlQgxzPMmaoyYk6IBCS76LRv3+WeFg55gYdW255G/AXngFbnGZc7OG0njJBaiV4ETo0c2gfYJBkAyCP0VMCP/wrxqUCpruDIEBEWHApgsb43whigpiUdo1ZE22Cqu8qIony6qO+8Wl7aMgeGhhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746457504; c=relaxed/simple;
	bh=LK37zr9dhJR9vsBD5tV0deO8G6uKTAwciHQYLzVSsEM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=VUsyWnyc4tzyEMCmZjwVAz1YHdFZN4yLdCHGWLXFJRTzcYmrULn6g73+cue8e2cDw1Qt3VJQXmptLk2kEisVv6ywoZo5QaHNivw1pox0ShG/x9ygjSR2cuzCEeF716e6O3bSDIQK9G7z0uLsupga9P3Z8StaD+yJogTDYplVucc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mDtBKQN4; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-22e15aea506so36583885ad.1
        for <stable@vger.kernel.org>; Mon, 05 May 2025 08:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746457502; x=1747062302; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=IjGmK1VQDs51C++XwEPJE9hdFrNl1/NFDSHcZQyFi7A=;
        b=mDtBKQN4wlFv7ZfZe6HQW70QmotTfbUpoV4bRTNlgnXTI0uMlM/oXejGIfQeJ6uXMV
         OzCzmOQYf9B7rp3PubjksrSS5OQCPmKBPqL2AUHxA+oIWgaw8uoC1yhKdKMAhCQKa832
         CDedQ+/Szs349G8g8qNTzAyQBR4VzVaCWtHuiQv9CZxwiZdELLLXBD0wKIJYnEWhjNCA
         8LIdu0IYoccOwJeu4C69weJvV3K9ey7Y77rRuH6mKQs2Zv2XYJM58/wxd0toxjR5bhWk
         J7JAl2eGV2N6qqt7+BJn5+9St51IJcY+H3axuvpgMd5p+I42HIPr4tqfyNQVgxjKKaIQ
         NfRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746457502; x=1747062302;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IjGmK1VQDs51C++XwEPJE9hdFrNl1/NFDSHcZQyFi7A=;
        b=EXjBLa3A8HA3jNTsfSJxiPkKduJEtQ3yy3AQCRlijBz2BPcDTgseX6ZipFqndltj0U
         zcci50tf6yWZNfNnneBPXLFNIz+J1Pb6OKCC6Z2uYHvKiIIlLThvgmGB+5Kr9PdPq8sA
         L/926w8fN+wXDTjp66VMKhghO3EOJU3BxI/Cw/4RFHcy9a3G6WPbd7wyYEGlEtfEQDH/
         ckzGDZkfui+cOqVy6HEu+jz4N2tLFaE78Hg30t0UIbjCoffekMjF6Pn2MUNe/3MYwbo/
         /4RCF9KWwYzP6eA/xAGDvx5tVucG4EhCrPM2MBOGRMC0eG0rynR6C3htJgRJoYY0JGOC
         AWTw==
X-Gm-Message-State: AOJu0YxrC/s9z5B67hTO2WfSyrJhLFgw6QtZpeAgKI4AHMPa3sqTknvH
	Q5rVUS9OnJp24/1aOpsyx/pAHbpmugI2iZwVMfsHP2mhlQfxksu9AJmCnU+H
X-Gm-Gg: ASbGncsXN2cbwHosmazsvxZwujhYXPCpa64+KLBlWHaQZWYAbWYslDm59bcKEW7OQE6
	ypk4Xn5KvdSQ4yn1N1dVcUmcMBJJSRAYBd6+Nz3yG8lXzezzUPQDGkCGqE6IQusrLnKWi/ZnYeB
	p9PbtcfMeYnl5SQKmPgC6Pu+J740uZNRGIRctlEcvK1ASSNSbLvkhDjqHMx15309M4125PiMC0b
	DLjBJM/ej71YVr+Sz4EqRRJ14df+Si3nPxSDg0E3gUsd7K3zkHfIaF4htfW6u2iWqCiZCbQYbUw
	NAxvCweSr3HWtDXZzEUhFC82UUaWV0zho/9j4nnOngX+BTVDQCpfbanAWjD0UA==
X-Google-Smtp-Source: AGHT+IHwsmCDgr39Y6f6C1AFYxaSrygrWkIhQR6YsCQlEr00vU47/lN3VFjZ8uCjbG6bY40jbCteiA==
X-Received: by 2002:a17:902:db11:b0:22c:33b2:e430 with SMTP id d9443c01a7336-22e1e8e9e21mr97391175ad.6.1746457502218;
        Mon, 05 May 2025 08:05:02 -0700 (PDT)
Received: from ubuntu.localdomain ([39.86.156.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-22e151e9df5sm55985575ad.82.2025.05.05.08.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 May 2025 08:05:01 -0700 (PDT)
From: Penglei Jiang <superman.xpt@gmail.com>
To: stable@vger.kernel.org
Cc: Penglei Jiang <superman.xpt@gmail.com>
Subject: [PATCH v2 6.14.y] btrfs: fix the inode leak in btrfs_iget()
Date: Mon,  5 May 2025 08:03:22 -0700
Message-Id: <20250505150322.40733-1-superman.xpt@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <2025050558-charger-crumpled-6ca4@gregkh>
References: <2025050558-charger-crumpled-6ca4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The commit 48c1d1bb525b1c44b8bdc8e7ec5629cb6c2b9fc4 fails to compile
in kernel version 6.14.

Version 6.14:
    struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
    {
            struct inode *inode;
            ~~~~~~~~~~~~~~
            ...
            inode = btrfs_iget_locked(ino, root);
            ...
    }

Version 6.15:
    struct btrfs_inode *btrfs_iget(u64 ino, struct btrfs_root *root)
    {
            struct btrfs_inode *inode;
            ~~~~~~~~~~~~~~~~~~~~
            ...
            inode = btrfs_iget_locked(ino, root);
            ...
    }

In kernel version 6.14, the function btrfs_iget_locked() returns a
struct inode *, so the patch code adjusts to use iget_failed(inode).

Reported-by: Penglei Jiang <superman.xpt@gmail.com>
Link: https://lore.kernel.org/linux-btrfs/20250421102425.44431-1-superman.xpt@gmail.com/
Fixes: 7c855e16ab72 ("btrfs: remove conditional path allocation in btrfs_read_locked_inode()")
Signed-off-by: Penglei Jiang <superman.xpt@gmail.com>
---
 fs/btrfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index ad7009d336fa..d2edb2201e3a 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -5660,7 +5660,7 @@ struct inode *btrfs_iget(u64 ino, struct btrfs_root *root)
 
 	path = btrfs_alloc_path();
 	if (!path) {
-		iget_failed(&inode->vfs_inode);
+		iget_failed(inode);
 		return ERR_PTR(-ENOMEM);
 	}
 
-- 
2.17.1


