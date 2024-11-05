Return-Path: <stable+bounces-89933-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B9EBB9BDA00
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 00:57:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6FF0D1F222D7
	for <lists+stable@lfdr.de>; Tue,  5 Nov 2024 23:57:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 170E2216A1A;
	Tue,  5 Nov 2024 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dNgv1qiY"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7927321620A
	for <stable@vger.kernel.org>; Tue,  5 Nov 2024 23:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730851021; cv=none; b=mkSXCriWzO7UNdpphGd9DblXyc9iV/ycBArwUNqrzeQGcxChHc/pg1JMPT50BnHUeDtktpGUPlea3alquZbiaX8sSPVXbJyal1TGV6on8ld+tUOm5qOwzL+NnzvRlTEICLfFTlomV50oa8BgUynBPz337gotsYj/pUSPzJvz3oo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730851021; c=relaxed/simple;
	bh=ZWS01Ixcff70Q8jYvnFnidhgGCGOCRhHbX90HbPP7FA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aRk3mjt2mqSxVDzp9hPuEDPsoJNy2Lvyf3RhAx26c/RussVZFaNVURu4+hAEWW2ekE5vxtzD3tRY4F7olPPtDM5HosY+TCRZZiRVpUeCK4cyn3iMYL85SOPQBL6/hON+AXQG5UCS7H+9119EhMwamCixq+U/f6T3Iy0iDniy5do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dNgv1qiY; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-20ce65c8e13so69263665ad.1
        for <stable@vger.kernel.org>; Tue, 05 Nov 2024 15:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730851019; x=1731455819; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=twoPyl0D4Xq+hzWr9lyXWIFOucklkcgjFX43EOeLLgA=;
        b=dNgv1qiYb9rWZdCV7t/2tQVPuDYlYuP6uwUZn6kFxmUPLM//8KEnxh1ezGbdpP51aF
         mXVFE+HhGvmgUrjmO16m//RDkHMMETX0CSzS8IPZSeQDE8s0XuusKJihg+USJwbU5dzA
         e6HgFAIuSt1jD9OienpOQIP67RmJSvyZVb4HaC7jfXXIHzC5Sj4dSA2nrxDvp60FBp+2
         sC6C0+Bg6sHz0nq5TvnaI1d6I3wHMtxE7/agBcKjfkjeQoTcgCQl3csqqMVFsRKQDoaH
         jrcruVPVIt2X1Bl4mYOUt8wBzhIfBY6N7bg3P+muYvX1RQdloGBgx5CNkEjgHCaY3Gep
         umZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730851019; x=1731455819;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=twoPyl0D4Xq+hzWr9lyXWIFOucklkcgjFX43EOeLLgA=;
        b=ZKaGHvgwDbpth4h86Ozj45ZyNcLsMjn/VWm2TbBscKkyWJhV2E5AmxGQQNXMTqPf/t
         0/bI6Z3eRfylK4TytPiPlHYnPUs5ECflI4KBUB29WZyavfo4NZJLQ4PkpIEwUPJWV/c7
         tfiArM89ynJZu1UNS9RQ59uEsP8gNgcjRS6iV9Ku/mqe62An50MuSnOckTHJ8yzF5Gkj
         6/DEMZULU6+/M0/VjV1IYn1k6DnCMAMMprzNB+0YJ7cgZhTjomt/BkWjnOydOVVqCgxS
         gfMiUsRdeq7ZiERwJIwQMguKl919RvaC1I3FhAAtuk2pWRWHm/8K9KPpoKHah1mTPADd
         OcTw==
X-Gm-Message-State: AOJu0YxTe8FFvRiW0MXNVhk7ckG9zbTCBmezi8hjO2xJ2qv004x8xEmg
	7zpfzligvEg6pV8mCeQqPGxPDjXRy34gtO/GLLFCiQiBRjaPWAvfkQZtjg==
X-Google-Smtp-Source: AGHT+IHMPj0F0Q3NMQVyqAL3zMU2kFSf7Emrl9+kIJjNxBiwWo/BV5l2lBe63zKV0d9LxIC3NvZOyw==
X-Received: by 2002:a17:902:cec9:b0:20c:f3be:2f82 with SMTP id d9443c01a7336-21103b2009cmr295292895ad.33.1730851019159;
        Tue, 05 Nov 2024 15:56:59 -0800 (PST)
Received: from carrot.. (i114-180-55-233.s42.a014.ap.plala.or.jp. [114.180.55.233])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-211057a2e9fsm85000005ad.160.2024.11.05.15.56.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Nov 2024 15:56:58 -0800 (PST)
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 4.19 5.4 5.10 5.15 6.1 6.6] nilfs2: fix kernel bug due to missing clearing of checked flag
Date: Wed,  6 Nov 2024 08:56:31 +0900
Message-ID: <20241105235654.15044-1-konishi.ryusuke@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <2024110529-clapper-deferred-1146@gregkh>
References: <2024110529-clapper-deferred-1146@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 41e192ad2779cae0102879612dfe46726e4396aa upstream.

Syzbot reported that in directory operations after nilfs2 detects
filesystem corruption and degrades to read-only,
__block_write_begin_int(), which is called to prepare block writes, may
fail the BUG_ON check for accesses exceeding the folio/page size,
triggering a kernel bug.

This was found to be because the "checked" flag of a page/folio was not
cleared when it was discarded by nilfs2's own routine, which causes the
sanity check of directory entries to be skipped when the directory
page/folio is reloaded.  So, fix that.

This was necessary when the use of nilfs2's own page discard routine was
applied to more than just metadata files.

Link: https://lkml.kernel.org/r/20241017193359.5051-1-konishi.ryusuke@gmail.com
Fixes: 8c26c4e2694a ("nilfs2: fix issue with flush kernel thread after remount in RO mode because of driver's internal error or metadata corruption")
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Reported-by: syzbot+d6ca2daf692c7a82f959@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=d6ca2daf692c7a82f959
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
Please apply this patch to the stable trees indicated by the subject
prefix instead of the failed patches.

This patch is tailored to take page/folio conversion into account.
Compiled and tested successfully.

Thanks,
Ryusuke Konishi

 fs/nilfs2/page.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 36d29c183bb7..956c90700e15 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -405,6 +405,7 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 
 	ClearPageUptodate(page);
 	ClearPageMappedToDisk(page);
+	ClearPageChecked(page);
 
 	if (page_has_buffers(page)) {
 		struct buffer_head *bh, *head;
-- 
2.43.5


