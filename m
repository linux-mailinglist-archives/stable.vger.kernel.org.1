Return-Path: <stable+bounces-195391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E616BC75F1B
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 19:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id ACA834E056E
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 18:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7B00364EBE;
	Thu, 20 Nov 2025 18:42:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P/+o/Ic3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9677835FF5E
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 18:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763664166; cv=none; b=rdfM99NWRlSGdAkG88hYy+eltziL4+CmIjApnjP+NnejsLHSppJbzcdo6l1LBhKLtzBuekb/ZC1PO0F3BDPvllF47Q0+ISYr7PtTS7vLmnjLJKMOZb1T753bC5JihqSi/xrXoPHwkUPsO4qTtOq0NW4a4RFOiXE5FX7Rneay9PA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763664166; c=relaxed/simple;
	bh=qtO0Yo/x+NoyGrhoTSDRJI6VIi6/M3eSSOIV4tJNl0I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oF/VZgqTneVzb233gBEcmokp+8T6ABi4VZv/NJuOGQ+zTh6fg+McqzbVu1Q4H1nZkmbpDaNXpdXplypQF6B9SE9Fu2Y/3LpIF2KhB8BszcWyZDmhlPL9fQeDRDzgds4fLOAw2RrxoXemep7/cNNHffz7QfWFbPoH2xYtM5P0Jes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P/+o/Ic3; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-7bb3092e4d7so1329003b3a.0
        for <stable@vger.kernel.org>; Thu, 20 Nov 2025 10:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763664164; x=1764268964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z5IkkGmTBKtnq9MgWNqv3BWJfeeYyXZgIWDNQMVeTZQ=;
        b=P/+o/Ic34xd3d+eftruG92z+Zz9OuYR4ymtw90Dghk/iAS4W57tZ0jMkMAHbcmY9IU
         1Lu6IKHYUq5usJj++j8pusx/Q8zBP5WjgtaJWaspwOYqUQZhe8Fs5nIFVn28RTkqHEp0
         ysbFdIMWU+VKP35rzQhvt/Ie8nQZO5MWuFrrXM+xS44hN1MaPXT138TK8Vd/GUGxBjG8
         y4Tq10JLY2w7tWLFT7FgfG7Ldol+jPQNHikZuTFjTULHfEwiSXcPDZKf4LtAxYxA7VTQ
         VLx1UZqhKIUUW/VleiiVPkQZ8fEQpCKHRzPBCmJZntvwzjkK51LSVI2mO6rAIaGbvjcB
         JLkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763664164; x=1764268964;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z5IkkGmTBKtnq9MgWNqv3BWJfeeYyXZgIWDNQMVeTZQ=;
        b=vn5NOSXf++TVkG9ds4xjuLy/r20Rbd+bUOdPAdM1ZQwYXi/85jS0mwwm1egSpHopHL
         CY6acR1SB2kTc3pcscZsVXY9mbYCY4ZcJjbBPl8rO1axREd+FzCkiGOc5Tznkeo9FOUD
         vji9kyxOUhezGPDGgr0IdkH5w7SDloLNiNAZeC8yq4wYQ4TkHMgifFTudWMKl0ErbHd/
         vV3bR+ujbscQCxrR/YY6XxDpcjO8RhXvzQD5bPUBkkS7nTZpeKmmAChf08GaHjUCEX2x
         b1/2rTGStoC5yQA7w0pt1Dm+d7Kj6eArHAOnw7TK6TOMfoJE4QuB7Ax2jSSrJArcHzqc
         MI4A==
X-Forwarded-Encrypted: i=1; AJvYcCWuWcrH3JU8ogJRdr6QfDsDR8MwsJHKQLntTk0sCrWLyg6S6r8KfOSNDz1qSb4upK93HMx8ZU0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyxoszCSCH2ADn+OFu0mJfNdO57su+LrOpBpHgSnlv8OARo6q7h
	Sn1pwg1jzGX5s0LekX95VJ2gbLqgMOz20R0VjrBlwYP959pxVHgXvZW6
X-Gm-Gg: ASbGncvVXNldbc7JHnOO7k4oO21vfiVQd+LrrHZOjj59ILNkMDQD/BvHQkEUSWQtWpj
	1pnXFc14FvsNceH2crpSj+uIXrQX0QK2Y5zf55jppv9gUEXQ/nRIg4oSFJRRE16ZCGqhCOARViq
	0b5H01F99znJANbw+MDtFk68s2wTG0X+vDwx5Kp1iHhjn3J+2Vv9CdhA4OWR4KLFu8ngIbvb/xi
	geVz4F69hg3sgPzP0Mg2N8T2yc70phjkhKhO8mAnMj9lUGeUTNbVrSz5GFcy/tUABuRAck2gc/G
	yWLsEP5iglxFhd5owhkDsquQviik0oQgqWbg+WLFmYLvRMYqxa9Ss9i0xB9vDUDIyNWcUju0AQQ
	6/tMJPIplaSE3Kb7uC9aLMp5/fVdBrDcABRXCqdfcNga6mr65RYyAqDtI1shZQzRbzPuzFXiKI5
	2DW449n0nJYNCqMESv1KWf68PQp2vw
X-Google-Smtp-Source: AGHT+IEn4fRMkobTZvL45tQ+snkxa4PzVhtyX4lkl507PdlHW0Dkqo+rP9vCwPWP+/AQsmyKFvZE4g==
X-Received: by 2002:a05:6a20:3d1a:b0:35b:b508:b99f with SMTP id adf61e73a8af0-36140a58348mr3931938637.1.1763664163860;
        Thu, 20 Nov 2025 10:42:43 -0800 (PST)
Received: from localhost ([2a03:2880:ff:4d::])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3ed892396sm3565435b3a.29.2025.11.20.10.42.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Nov 2025 10:42:42 -0800 (PST)
From: Joanne Koong <joannelkoong@gmail.com>
To: akpm@linux-foundation.org
Cc: david@redhat.com,
	linux-mm@kvack.org,
	shakeel.butt@linux.dev,
	athul.krishna.kr@protonmail.com,
	miklos@szeredi.hu,
	stable@vger.kernel.org
Subject: [PATCH v1 1/2] mm: rename AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM to AS_WRITEBACK_MAY_HANG
Date: Thu, 20 Nov 2025 10:42:10 -0800
Message-ID: <20251120184211.2379439-2-joannelkoong@gmail.com>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20251120184211.2379439-1-joannelkoong@gmail.com>
References: <20251120184211.2379439-1-joannelkoong@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM was added to avoid waiting on
writeback during reclaim for inodes belonging to filesystems where
a) waiting on writeback in reclaim may lead to a deadlock or
b) a writeback request may never complete due to the nature of the
filesystem (unrelated to reclaim)

Rename AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM to the more generic
AS_WRITEBACK_MAY_HANG to reflect mappings where writeback may hang where
the cause could be unrelated to reclaim.

This allows us to later use AS_WRITEBACK_MAY_HANG to mitigate other
scenarios such as possible hangs when sync waits on writeback.

Signed-off-by: Joanne Koong <joannelkoong@gmail.com>
---
 fs/fuse/file.c          |  2 +-
 include/linux/pagemap.h | 10 +++++-----
 mm/vmscan.c             |  3 +--
 3 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/fuse/file.c b/fs/fuse/file.c
index f1ef77a0be05..0804c832bcb7 100644
--- a/fs/fuse/file.c
+++ b/fs/fuse/file.c
@@ -3126,7 +3126,7 @@ void fuse_init_file_inode(struct inode *inode, unsigned int flags)
 	inode->i_fop = &fuse_file_operations;
 	inode->i_data.a_ops = &fuse_file_aops;
 	if (fc->writeback_cache)
-		mapping_set_writeback_may_deadlock_on_reclaim(&inode->i_data);
+		mapping_set_writeback_may_hang(&inode->i_data);
 
 	INIT_LIST_HEAD(&fi->write_files);
 	INIT_LIST_HEAD(&fi->queued_writes);
diff --git a/include/linux/pagemap.h b/include/linux/pagemap.h
index 09b581c1d878..a895d6b6aabb 100644
--- a/include/linux/pagemap.h
+++ b/include/linux/pagemap.h
@@ -210,7 +210,7 @@ enum mapping_flags {
 	AS_STABLE_WRITES = 7,	/* must wait for writeback before modifying
 				   folio contents */
 	AS_INACCESSIBLE = 8,	/* Do not attempt direct R/W access to the mapping */
-	AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM = 9,
+	AS_WRITEBACK_MAY_HANG = 9,
 	AS_KERNEL_FILE = 10,	/* mapping for a fake kernel file that shouldn't
 				   account usage to user cgroups */
 	/* Bits 16-25 are used for FOLIO_ORDER */
@@ -338,14 +338,14 @@ static inline bool mapping_inaccessible(const struct address_space *mapping)
 	return test_bit(AS_INACCESSIBLE, &mapping->flags);
 }
 
-static inline void mapping_set_writeback_may_deadlock_on_reclaim(struct address_space *mapping)
+static inline void mapping_set_writeback_may_hang(struct address_space *mapping)
 {
-	set_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
+	set_bit(AS_WRITEBACK_MAY_HANG, &mapping->flags);
 }
 
-static inline bool mapping_writeback_may_deadlock_on_reclaim(const struct address_space *mapping)
+static inline bool mapping_writeback_may_hang(const struct address_space *mapping)
 {
-	return test_bit(AS_WRITEBACK_MAY_DEADLOCK_ON_RECLAIM, &mapping->flags);
+	return test_bit(AS_WRITEBACK_MAY_HANG, &mapping->flags);
 }
 
 static inline gfp_t mapping_gfp_mask(const struct address_space *mapping)
diff --git a/mm/vmscan.c b/mm/vmscan.c
index 92980b072121..636c18ee2b2c 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -1216,8 +1216,7 @@ static unsigned int shrink_folio_list(struct list_head *folio_list,
 			} else if (writeback_throttling_sane(sc) ||
 			    !folio_test_reclaim(folio) ||
 			    !may_enter_fs(folio, sc->gfp_mask) ||
-			    (mapping &&
-			     mapping_writeback_may_deadlock_on_reclaim(mapping))) {
+			    (mapping && mapping_writeback_may_hang(mapping))) {
 				/*
 				 * This is slightly racy -
 				 * folio_end_writeback() might have
-- 
2.47.3


