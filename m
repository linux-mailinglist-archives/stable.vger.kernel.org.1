Return-Path: <stable+bounces-52337-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7FC4909F0E
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 20:18:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7650E1F219A1
	for <lists+stable@lfdr.de>; Sun, 16 Jun 2024 18:18:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 635D933998;
	Sun, 16 Jun 2024 18:18:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Aif/E2cV"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3CAB12B93
	for <stable@vger.kernel.org>; Sun, 16 Jun 2024 18:17:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718561880; cv=none; b=GMt1lwiKXGmlRUtr1NV00YLeFVkVy0bQxLKXOT+ZXtsycnemF5wzrNeLNa6Vq+blnF/I9l156nkQcL/P8z3vtR6QqEsJ/E9Nmi1+PB/RWsY9RnVmkae1qr8bFC455NkEr9HRrrr8rtSyowoXcfntEANj4oXaKj70IwgLJEgViPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718561880; c=relaxed/simple;
	bh=MmQEDTeh+/NCTNTp9hcHOXrtZhpUwWtLrTnySrpHDFY=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=MPLkSSfbiiTeAa9uMHG55O55QsZr+Zzkfguj3rSCatbqxO1ohtAx4WPSZGBkXTOILF4jMHUmWgtcEKR6ZKhjuzK2CGTgnjqJCBEMOaLs+N5+ABBg7GDgAg3DLSP/Y3GeZaP0yTcokzEodijqbaMYHgxcYCYWERoUWrL7+53DxzU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Aif/E2cV; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-6fd8506a0b2so3091595a12.3
        for <stable@vger.kernel.org>; Sun, 16 Jun 2024 11:17:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1718561877; x=1719166677; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IqzSt+ezkETCLEbkiWwlesMZrcytDmfv2p3WWVnHFKA=;
        b=Aif/E2cV6q+UdVMHq6CeWcHcDb/UE91RZrNO9dT3kPZIVhTKoWLIjtZabZtIfoUuAN
         tfIN/dPVaAOwb5yLthORasMBNsEl1lGsElyqU+yE38T35Pwq/qIlaFg1E21ozt3a5ZjM
         m5Wxn7dib/t6Kkyi2iWSI5jAyMY4Ovl/qHUdKohsTR2zag/ZUb8MX0O2cbhC3F9HKSqb
         KNsFwRnD35KG0+rcjcC+GO5wI0nvuUw1YWlqGuaaDt7ZLjdnOb5yrYZcmdt85B3loSUV
         fRO6ztF2VCnpvgsjgx7QYkqXX0MvfLyCVoJxlit1fxZH04uy9JQVhiOVWvVrSZj3na+l
         G5RA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718561877; x=1719166677;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IqzSt+ezkETCLEbkiWwlesMZrcytDmfv2p3WWVnHFKA=;
        b=RuCkKDlG8yVg6UU/h7BQL7gCOPB4SFUELAvzQatZgn5PsdXmzXfIffQsdVS0gIHasN
         oatYfMQBk6XUlIZHWLTBur31DScdNWoq3VgzEQhMw7Xo4+7OrlVtJbhjmx7Kmp4XufhP
         gFp7nfjkuQ1/ajJ7tgrFLYZGn0VUKhUGGLmFiiyExXxjUkf+V6KnY5cI5ytikjPBHFoi
         VELxM4gDJakgMLTKfGpm5qWLvj6QR/2AA0Wz/8n9D5ObrVo3UpE4tLgkwn2Cjhi6+j96
         mm6OKBfGZntaDXkUpmZXfKmUxtxDpB8hVNJp6LPLKGPH1rcNTyTg2GgY8lY8oOdzWD4A
         sKYg==
X-Gm-Message-State: AOJu0Yypb75yoABBOudDUOUrs1fs3onEQg+JJrqpqgMQNmVCWmnYFT3H
	sKVciu0YZEbZUv3JeEy8g/KVBbiAhfMbBpOQSHmeRv12UQzh+pXRhzVCMw==
X-Google-Smtp-Source: AGHT+IGdwKyerRDQwcWQYOjE/M27nDZKepk/fnO2ojxlge4a0ctQ9OCOtCrmHwtCeojioLz6XnonOA==
X-Received: by 2002:a17:902:d2d2:b0:1f4:a6cb:db3d with SMTP id d9443c01a7336-1f862804b23mr93124715ad.44.1718561876951;
        Sun, 16 Jun 2024 11:17:56 -0700 (PDT)
Received: from carrot.. (i114-180-52-104.s42.a014.ap.plala.or.jp. [114.180.52.104])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f855e6fba6sm66830965ad.82.2024.06.16.11.17.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jun 2024 11:17:56 -0700 (PDT)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6] nilfs2: fix potential kernel bug due to lack of writeback flag waiting
Date: Mon, 17 Jun 2024 03:17:29 +0900
Message-Id: <20240616181729.6672-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit a4ca369ca221bb7e06c725792ac107f0e48e82e7 upstream.

Destructive writes to a block device on which nilfs2 is mounted can cause
a kernel bug in the folio/page writeback start routine or writeback end
routine (__folio_start_writeback in the log below):

 kernel BUG at mm/page-writeback.c:3070!
 Oops: invalid opcode: 0000 [#1] PREEMPT SMP KASAN PTI
 ...
 RIP: 0010:__folio_start_writeback+0xbaa/0x10e0
 Code: 25 ff 0f 00 00 0f 84 18 01 00 00 e8 40 ca c6 ff e9 17 f6 ff ff
  e8 36 ca c6 ff 4c 89 f7 48 c7 c6 80 c0 12 84 e8 e7 b3 0f 00 90 <0f>
  0b e8 1f ca c6 ff 4c 89 f7 48 c7 c6 a0 c6 12 84 e8 d0 b3 0f 00
 ...
 Call Trace:
  <TASK>
  nilfs_segctor_do_construct+0x4654/0x69d0 [nilfs2]
  nilfs_segctor_construct+0x181/0x6b0 [nilfs2]
  nilfs_segctor_thread+0x548/0x11c0 [nilfs2]
  kthread+0x2f0/0x390
  ret_from_fork+0x4b/0x80
  ret_from_fork_asm+0x1a/0x30
  </TASK>

This is because when the log writer starts a writeback for segment summary
blocks or a super root block that use the backing device's page cache, it
does not wait for the ongoing folio/page writeback, resulting in an
inconsistent writeback state.

Fix this issue by waiting for ongoing writebacks when putting
folios/pages on the backing device into writeback state.

Link: https://lkml.kernel.org/r/20240530141556.4411-1-konishi.ryusuke@gmail.com
Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Tested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the stable trees indicated by the subject
prefix instead of the patch that failed.

This patch is tailored to account for page/folio conversion and can
be applied to v6.7 and earlier.

Also, all the builds and tests I did on each stable tree passed.

Thanks,
Ryusuke Konishi

 fs/nilfs2/segment.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2d74fb229799..5783efafbabd 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -1694,6 +1694,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh->b_page != bd_page) {
 				if (bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1707,6 +1708,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 			if (bh == segbuf->sb_super_root) {
 				if (bh->b_page != bd_page) {
 					lock_page(bd_page);
+					wait_on_page_writeback(bd_page);
 					clear_page_dirty_for_io(bd_page);
 					set_page_writeback(bd_page);
 					unlock_page(bd_page);
@@ -1723,6 +1725,7 @@ static void nilfs_segctor_prepare_write(struct nilfs_sc_info *sci)
 	}
 	if (bd_page) {
 		lock_page(bd_page);
+		wait_on_page_writeback(bd_page);
 		clear_page_dirty_for_io(bd_page);
 		set_page_writeback(bd_page);
 		unlock_page(bd_page);
-- 
2.43.0


