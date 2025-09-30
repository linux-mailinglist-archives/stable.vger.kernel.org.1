Return-Path: <stable+bounces-182879-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 95810BAE93C
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 22:57:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4F4CB1C75A5
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 20:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB03286D50;
	Tue, 30 Sep 2025 20:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q937sLEB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FA94C81
	for <stable@vger.kernel.org>; Tue, 30 Sep 2025 20:57:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759265845; cv=none; b=SgukOSEIOHKuNUDHPGjwGiNMxVlVqwYS4suwLy4Lil8mvFbKD601bIz5/y1aOrY/lhT3vYRtAqqqvI5MtiQL4QF0+3zb1zB6MOgAa2+rNcxE4rzCUpG0j1oLNGVJj+hU21pnE5ltChHgCCxRUD4t18wAsbwraoiBBMFGflOlsjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759265845; c=relaxed/simple;
	bh=6gn3JvEnkwb8OKeTMxuhbf4tkQ2jON2+HRrM6ridCJA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=HJeTsUXZpQIMwCpWl6mgsZLM03kDLbx1WSvykz0/08EwfccGsgNFQwgS2MicMdYMew7Rz2ZS9Pkqa4x7xPQrjfHgCkyYa0aYApVMUaobyCA1CWpNP06x6aYWQ1oNLkXuTiXxKyGiZ70riSM69xoQsX0GWcAc+sXgqW/G/CVtSzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q937sLEB; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3324fdfd54cso6912734a91.0
        for <stable@vger.kernel.org>; Tue, 30 Sep 2025 13:57:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759265843; x=1759870643; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=KD4HsssgWXiRjdclammiAZ8JcMZf+BthaQoepiATDDI=;
        b=Q937sLEBCF/R62VGA2G4f4Ey0zXlIZUoHrv1hxnQS+rJDyMts2OBZeLhvuYvBVbGIL
         onWrTbeddfKt3C8DVlg+DexRestRZuxcz/TJ9QoSWgFG71wkuKmP9L0mkpxahFIAYUDQ
         4nJ+y1rPq0WyApL3WzOQoBI3adMcZhBq8CAlYkRBObSU6T+RSAdNqz/1AD7qj1qnTbNs
         Utbid/NJsGzWhm07o10HEzW0r8wLH7ehve8Rzd/hl6plL4it19Au5gGzJGMad4VHS0d6
         HwjC1zDECRVTLKXkTEk6KjEiwYyIurqrfFDfwEV+S/VUfcxRQegTlPhfYpsUWsTWAewk
         MM8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759265843; x=1759870643;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KD4HsssgWXiRjdclammiAZ8JcMZf+BthaQoepiATDDI=;
        b=bGql7v96DBa2O5ZIHwrKgc6i21pSLGCA1fWTb7QmYjW54t+R9NyGTl3zN2ZsLAwF2S
         Ifm9uFjlaIK93wG/EYEgsRMl2BxvqbC7pufZE4ONDzikLS6sSqByyLmMmIhqmOGeJT3E
         G6RinsSYurHfz6b5Ka0Exl4kTsK3m3yWwPElsZcTLY3G2O7Q04Y4RcZ5LOOPn87MUAse
         +/eoBOodqD3LKLO9H6tdRyvhqG5K0k03YZraWdmRGozuwQEcgx++Oz+ABtBwbWnNBM45
         DhuVlQvc8h8cJSAveJaNImoHkt0jMdfDQhe9vwj0A3OH/oRxFrJCp3qu3vCI19oZ6ID6
         id+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVgxp+B5UhY8HXumVwODHJjrzTO+Sr3OXPoNMxVPjsBHbG9CmOTYwy2gpf/ZTb64OEJ+yZiYss=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzerqypNEZhNAlLDWc9yz7Lfx/sJ7aGZpm+D1LjSJiHK0P7MgO
	Yk43nAWfy7R3vX6LQBw5arcAOr6Z1uYVod2edrayWUF+KmCzjX716p6w
X-Gm-Gg: ASbGncsppP78LII9UCO2lYWx+MTRD1RfkRTdjTZB2+Q8TbrN587GWR6SWtFKY27oll1
	pNm0F+xk3MRApvAvvAZ8vTpBqoVCVf1hOApoQoRJmll/sEXPMV4lSrOU1YXfFXCe6ifApXXO/j1
	AGmA0hKxhAoapGYTDbP2DVYFK6cmwyOX+fFCtqvZ1CABK+UWPfxZmYUmDlaeGYm+p2eWBZbhT3C
	BT91ARua7G8D7ofuENwDDxzV1/k+DR1ddAQfeDPjNmO0gDesSFPncUof/RA+plkWyqNWiCaRp6J
	RTF5zvxTGpJCipMygixwo0xg7EoUk76HWUMVz4xS+MVZuj13csXfBjssLfbzE3ZILUiHiEqMZIs
	2cbWgEkC1PwGWp/ak5aC/FHt2g5aUe+W7eVM1cQYjn3euxPGPj+AUj9rg6POsYnNu0G/hPKo8Ey
	v5cFd8+tyllIng6iT/2GyRv9YKTomV
X-Google-Smtp-Source: AGHT+IEL9i/9pFNAxMQIrsaF8HkZgzD5JDTexCku+5N4stZQsJ2UqCF+gxubh0mvyi2u5bv1JlNBXw==
X-Received: by 2002:a17:90b:1d04:b0:329:e2b1:def3 with SMTP id 98e67ed59e1d1-339a6e90504mr841855a91.10.1759265843136;
        Tue, 30 Sep 2025 13:57:23 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2401:4900:4176:b4f9:480e:ed50:969b:5d2b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-339a6ff26f8sm454898a91.13.2025.09.30.13.57.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Sep 2025 13:57:22 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] ext4: fix use-after-free in extent header access
Date: Wed,  1 Oct 2025 02:27:15 +0530
Message-ID: <20250930205715.615436-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

#syz test: git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master

syzbot reported multiple use-after-free bugs when accessing extent headers
in various ext4 functions. These occur because extent headers can be freed
by concurrent operations while other threads still hold pointers to them.

The issue is triggered by racing threads performing concurrent writes to
the same file. After commit 665575cff098 ("filemap: move prefaulting out
of hot write path"), the write path no longer prefaults pages in the hot
path, creating a wider race window where:

1. Thread A calls ext4_find_extent() and gets a path with extent headers
2. Thread A's write attempt fails, entering the slow path
3. During the gap, Thread B modifies the extent tree, freeing nodes
4. Thread A continues using the now-freed extent headers, causing UAF

Fix this by validating the extent header in ext4_find_extent() before
returning the path. This ensures all callers receive a valid extent path,
fixing the race at a single point rather than adding checks throughout
the codebase.

This addresses crashes in ext4_ext_insert_extent(), ext4_ext_binsearch(),
and potentially other locations that use extent paths.

Reported-by: syzbot+9db318d6167044609878@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9db318d6167044609878
Fixes: 665575cff098 ("filemap: move prefaulting out of hot write path")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
---
 fs/ext4/extents.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ext4/extents.c b/fs/ext4/extents.c
index ca5499e9412b..04ceae5b0a34 100644
--- a/fs/ext4/extents.c
+++ b/fs/ext4/extents.c
@@ -4200,6 +4200,7 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	unsigned int allocated_clusters = 0;
 	struct ext4_allocation_request ar;
 	ext4_lblk_t cluster_offset;
+	struct ext4_extent_header *eh;
 
 	ext_debug(inode, "blocks %u/%u requested\n", map->m_lblk, map->m_len);
 	trace_ext4_ext_map_blocks_enter(inode, map->m_lblk, map->m_len, flags);
@@ -4212,7 +4213,12 @@ int ext4_ext_map_blocks(handle_t *handle, struct inode *inode,
 	}
 
 	depth = ext_depth(inode);
-
+	eh = path[depth].p_hdr;
+	if (!eh || le16_to_cpu(eh->eh_magic) != EXT4_EXT_MAGIC) {
+		EXT4_ERROR_INODE(inode, "invalid extent header after find_extent");
+		err = -EFSCORRUPTED;
+		goto out;
+	}
 	/*
 	 * consistent leaf must not be empty;
 	 * this situation is possible, though, _during_ tree modification;
-- 
2.43.0


