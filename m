Return-Path: <stable+bounces-192237-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id F0D47C2D3BB
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:49:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D3F544E41C2
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D227331B132;
	Mon,  3 Nov 2025 16:48:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mly6Z4mD"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6AC430DEDE
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:48:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762188499; cv=none; b=g6oxcuBCglIM1zTmiVLN/6YnsOh7k23KRqhDZmIHihCv8hUpQXnXkhzm0aJPln3qKz+KAQ0o/VEo1GJZqu1STGb7IXJrvs2ztss4enm5cZvhO9KJgX+dmEDsZgFYhWT39lfckfgiHbPMjJUDf2m0bERUB098w2VpK/Iud2h7RIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762188499; c=relaxed/simple;
	bh=wJjmntvfExnlICRxK102abAFvivMt90fKAxX98hdlYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt+jHz4JXVzdb49Vo2BPFJ6dafPcL/92lQtljKZbvFXvnCwNJnBwm8MwMi2NlCfTdD8MrNTk0NlgSg+5/8+9mL4QjGd84tQEsq+iIXr3r+1f+GS0JXsrmI1mkLvbjU16k6jAD9WWRMaZ3a+blXWiatKHRaQB9wB8qKw6rH28nxY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mly6Z4mD; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3402942e79cso6520573a91.2
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 08:48:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762188493; x=1762793293; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=mly6Z4mDv830e117Wb/WZgDoDqVTOArVC6L+MlO0OvVQ4iuT+wrIJAOhFpJFqEBmbS
         DHTEMhiowsYxbYlyyX1TDHQwSgpNwQ3nIln6fkTLmcWJ62oAFyNANcIYG7I775kPBGYv
         qjGlZTVGqan2l5/Z7tAFhODGqtTLvbjd7mYxk0cuGo3l2B3P/8DXWrlURCi8GhvUcPq5
         WAjp++Bll1OlWSGJOHrvXSzQz4gJGCFedWfa9jt+O7aGVUZNsCIvQsq+f7hMt+j8y9zF
         bqsiJmweBjT2QCUNi/dBfmURYpF01wzFBPD3VRPMhOuOI8PKOEXwZ5j826K7qJFqul4B
         ym3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762188493; x=1762793293;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=gRiAaQLGqnpslOwXPyUTtnO3N2xwFFZfqi7Yf/s3YenT1mg9cphuTmgi04A2IXPVdH
         4m1rCbqTiwfvxhm6mpK7wjkuY/CrofAKpDo07yL3NFR307PXmsfn6AehLEQAGn4SD+fR
         8EgMdf34t1asOPBjFbFINbL3v9Z55abq8cdkqt6gal3/ivCnHLuju9TIja6apKFj1g8U
         dBLW83wyVPSQLctRWZjjaAB236ziYOTQaK1L3VLg6nkdY7rLGp0i2wXYlohmDrmr29LJ
         gGkvO4enDqe2wKONhlhapb+tQ7/syFEZrqEnSVCuRLDcTKUPEd9RP8t1DTPjwstxRqlH
         B/sg==
X-Forwarded-Encrypted: i=1; AJvYcCWSGgZGhBeuzyNXolnU9FnCbrTbFhgRYZknmajZb9nHjR/INA495x570qW94eWl6wlm8HaW9Qs=@vger.kernel.org
X-Gm-Message-State: AOJu0YxxqnnD/pnQjkBX87k9NXDngZ8z/iS25uGWQ0IiWkgq7mj1k8bi
	S9dwkSPvdqwWv1C8FYAr93ViEnRZAcXsVgHObJucL9/s8qSKiavcJByO
X-Gm-Gg: ASbGncujctT379PwQzJfi6AY6MIgdDiS4YI/YcEY7sfLDRpPnD/uDvTVfUVmZRaUCWQ
	RaUE66pRd6uOwvTdoLH2CPqE2UjJULdt+8NvIuRMVqXoeIKvzjVZ4SMhWeUBbAUM2Cng4eXy/rO
	Al0BCqJv4FGmMjN1xe6oxwsvligt1xk15EeEt4iLmyuZSbAA/viUp9LlW8M9ue9UXhIx0rlDaFJ
	1gDEy4X1qXD7Jkjh2RN8oyc+hIJUO7RK0GZaNK9xN9w+z+XqH1NImV7wKLOtteBZfk7VA8DjcQZ
	RN/KT7vtofW1gZzSeb0E+vr+dQLj2g8OjJuxE4z1hdTQgq7ZUinw2IKfF+nsKEfgFQGsGetXbtS
	+5UfSK4mN3pKVQX7pE3ZWVjomEyRZW2EFxBGEqkdm2WeBV7PgcCvNsDwAjUaZvWg2KQ5q8VQyam
	q+qn/Up4BgY/7LiDSfUjSc3wZsbRXJb22vXPx6qqvaSA==
X-Google-Smtp-Source: AGHT+IHyVbpQ031khovVH+RdF5IYFXxXooq/uMJcv6MssOTN24pCbmD2Np+fsrwq7RaQP1KpB2eDcw==
X-Received: by 2002:a17:90b:3c52:b0:338:3789:2e7b with SMTP id 98e67ed59e1d1-34082fd9099mr17153531a91.13.1762188493051;
        Mon, 03 Nov 2025 08:48:13 -0800 (PST)
Received: from monty-pavel.. ([2409:8a00:79b4:1a90:e46b:b524:f579:242b])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34159a15b6fsm1607264a91.18.2025.11.03.08.48.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:48:12 -0800 (PST)
From: Yongpeng Yang <yangyongpeng.storage@gmail.com>
To: Namjae Jeon <linkinjeon@kernel.org>,
	Sungjong Seo <sj1557.seo@samsung.com>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	Jan Kara <jack@suse.cz>,
	Carlos Maiolino <cem@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-xfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org,
	stable@vger.kernel.org,
	Matthew Wilcox <willy@infradead.org>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Yongpeng Yang <yangyongpeng@xiaomi.com>
Subject: [PATCH v5 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
Date: Tue,  4 Nov 2025 00:47:20 +0800
Message-ID: <20251103164722.151563-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
References: <20251103164722.151563-2-yangyongpeng.storage@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yongpeng Yang <yangyongpeng@xiaomi.com>

sb_min_blocksize() may return 0. Check its return value to avoid
accessing the filesystem super block when sb->s_blocksize is 0.

Cc: <stable@vger.kernel.org> # v6.15
Fixes: 719c1e1829166d ("exfat: add super block operations")
Signed-off-by: Yongpeng Yang <yangyongpeng@xiaomi.com>
---
 fs/exfat/super.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/exfat/super.c b/fs/exfat/super.c
index 7f9592856bf7..74d451f732c7 100644
--- a/fs/exfat/super.c
+++ b/fs/exfat/super.c
@@ -433,7 +433,10 @@ static int exfat_read_boot_sector(struct super_block *sb)
 	struct exfat_sb_info *sbi = EXFAT_SB(sb);
 
 	/* set block size to read super block */
-	sb_min_blocksize(sb, 512);
+	if (!sb_min_blocksize(sb, 512)) {
+		exfat_err(sb, "unable to set blocksize");
+		return -EINVAL;
+	}
 
 	/* read boot sector */
 	sbi->boot_bh = sb_bread(sb, 0);
-- 
2.43.0


