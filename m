Return-Path: <stable+bounces-192231-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5A2C2D2E9
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 17:38:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 38D9318986D2
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 16:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5613191D6;
	Mon,  3 Nov 2025 16:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="V9Xh9GEq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACD5F3191A9
	for <stable@vger.kernel.org>; Mon,  3 Nov 2025 16:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762187844; cv=none; b=AHmu/7C74XG9hYaHxUrPSbFbWqpn1m+AfddCf02kFM0VsYhUn2bSxEZ7S7rBUVcOEzSWcDmpqLcW0K4+U37EeemyJbyLBWzMxKQH38pthVLwh0Wt9c4qxrPsq4DLg60VZvFXlClVxii+IeLkhvOJzQ0Kg06DwwQSp91X7KYT0IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762187844; c=relaxed/simple;
	bh=wJjmntvfExnlICRxK102abAFvivMt90fKAxX98hdlYk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uqft9bALyHfhnM29n405HFdT5JlavQUR7DIhkjYxjbQlGunWTW/WH8tmCHIkYQIyLz6Ukiw0LICIQFlnbwPB2IzQnpv4y6L4JCowOYNKxbouc+o79VOoVbUnyDwMatZzzhzz4HeHWVgYNzZPPJwOctkS811ci5OfLIPn9RZWLPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=V9Xh9GEq; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-78af3fe5b17so4347366b3a.2
        for <stable@vger.kernel.org>; Mon, 03 Nov 2025 08:37:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762187842; x=1762792642; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=V9Xh9GEqqakLENJv++F44TPZ6hs4GdYcXT+kdy11SDPwcY5sh8xJLitGOpmCtW8JDr
         XgXLIGp9vDzDFUwwTpZ9lesxspeUbb4xtz7rQpOA3E8Hb53ijuSEmtzUL1WUMVf7nvXI
         cznb0gCHxb98GYaWQWVdF7b7stGWR9ZMa6CJTApPDpqC5kwUbF3wSz3xWKr84P2sWdS5
         9wWbQY6Wzd5q10MATigfea4EHH70mPWtlC82+ik/TUhToHOdX1ljggAyq78S+lfxwnTW
         QTGRgKHCXEcW1V2kj4LgfIbUb683rfXk+oV1lKY/7kDkjnxRBKucT27jSsbvhxD62gsW
         IAlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762187842; x=1762792642;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RqJ5gNa1nUUGBUXHUrJf6QlrVR0rCRb3Pp7Ymbcprkc=;
        b=ird5QejhA10qaV2jDULTCLzYjsWVI7DkMkcnkMfbI1AMG2tt4bdoQzbc48S6q++NYq
         WmYpW49i2lt4xob7Hkx1FTGv7N3n3U1tCkP7yhjyk6Q7cVbpRp/60TnE0o0t/UwPSCQh
         SoYpVugRr6cuhrBuHEv89g/YW76bei7Hy3LQK36yqYSj2HVsknv4p1Ii79EWbN5Q8Ukq
         ffnqkDbGsPYv2v8Zudg6F6JjqjNRC+1m/B/Tj0Zoh2RvbPwtL48t7s0zeHnSPtYOLnWb
         So6XclO/kixDCdmm8s+6njzFD8rAZzWVyvNQjpj9giZX252jMJmJ7ENZCkZ6JgAAlUG/
         +TvQ==
X-Forwarded-Encrypted: i=1; AJvYcCU4H/h7WrgxtFcvXBXmEhbMrxkmU3tITt1IrKEE5jlL8qNo7LzmgFWHe2V7U7q7OTaORxtuIe0=@vger.kernel.org
X-Gm-Message-State: AOJu0YywAJUCR7DWTD3j4uGo8AzGCMBTHRlCEU7fQinxI2CVxH+MTZB+
	0Yolh+oAFoaocLO+JQv8v620pbcrST9FGw33pxSE+0IGU9S/QcHd1Q3R
X-Gm-Gg: ASbGncsjaLY2Jxwmh68dv0gTXkPtoOvjYL5uqvGjFhVLdsPQBCXAn9xsUVEbyvYlTIW
	BT/dSwLOWPrPUACNgPrxW1ek/3gy8s4ic9eOL6G84jFrJ3WekTlgiKZkhymOLYDU1mf4XsyuqqY
	zCTqA5hvv0fB/mCWBJZprgzDob/WxGtQlxtOqljzRM5CgihWAfRMrx50HWh9VcjRThRj9BCEXA1
	59wFwpPe5wYqevUdOY0P05A+XIrcuzEtUxVJLnPWDszJ3LFMwF64Jw1nTt8btm2PqK6Fpe0KShN
	Yp4t9H39kknUfowTQq32DEmfaZyTApwXCccOukZBC/PFIvkUWvFfeJ9wN7g8ShtssNvfNZ44j8j
	CCZsZhyoViJeQag2Vz5MnNcfJSvAg1LnmzG/B6erKl15mkhm97g0uYzfVXcz+xbFir/r5MiUtCO
	04A8PK26EobQcCQEjPrbfjR4fALTE=
X-Google-Smtp-Source: AGHT+IG+w7iJAzmb9LjCnbErWEAX7LNvJkcpla1jAFDM+Y4gmMZZU0oJMClikIddg63gu998oSNJwA==
X-Received: by 2002:a05:6a20:939f:b0:246:d43a:3856 with SMTP id adf61e73a8af0-348ca565705mr15735758637.22.1762187841867;
        Mon, 03 Nov 2025 08:37:21 -0800 (PST)
Received: from monty-pavel.. ([120.245.115.90])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3407ec24330sm6853704a91.2.2025.11.03.08.37.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 08:37:21 -0800 (PST)
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
Subject: [PATCH v4 2/5] exfat: check return value of sb_min_blocksize in exfat_read_boot_sector
Date: Tue,  4 Nov 2025 00:36:15 +0800
Message-ID: <20251103163617.151045-3-yangyongpeng.storage@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
References: <20251103163617.151045-2-yangyongpeng.storage@gmail.com>
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


