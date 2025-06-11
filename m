Return-Path: <stable+bounces-152362-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 82EABAD47C3
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 03:13:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D968E189CAA7
	for <lists+stable@lfdr.de>; Wed, 11 Jun 2025 01:13:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5960F22615;
	Wed, 11 Jun 2025 01:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+NgpO/X"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1C28F3
	for <stable@vger.kernel.org>; Wed, 11 Jun 2025 01:13:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749604382; cv=none; b=Sy/w4n/+dBF+v3guyYiPz2r3WeNbFK5EZrSZv4b5Qg78LMLTSXHrlXSttjrWD5Je52IMBjw8oQkfelWYrVp9IK986YcVsY7lFoVKlxRu40YBT1CDeR4g5LyIX0lH3AVA5gcuK9Ouz3/u3GdNt1GLjFTca61IPQhVEH7AKPIbYqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749604382; c=relaxed/simple;
	bh=Oy3+8cdokoYP7+O8eXUIfolD7g+IxpH49uHeq7vRBys=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=PcLrNBOHWfQZzACQpLGOmuSTsF6GgrmASG8C6yWYuEWz+vND/0Hqq5RQfdl4DlowlsVBVdxSEsYSJWuD2zSmikfPh9fatPoB4CwxbWHbDjUgUfVrYS7rv6BheKNjKmsRVNVuBQAN5BKSoeBiYSc9CwVgZMM8+bhaD5Uf2UcWTAg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+NgpO/X; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-adb2bb25105so983673566b.0
        for <stable@vger.kernel.org>; Tue, 10 Jun 2025 18:13:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749604379; x=1750209179; darn=vger.kernel.org;
        h=references:in-reply-to:message-id:date:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/q9F0QVgKQXBPTRqYCAtV3TQoo4PQHbILQ0hjeePie4=;
        b=Q+NgpO/XPNIbB/VHEaFSsKMPSJSAaI7yKrm/95ZrL1BKN/s/JDXf+L9WYGwQaudlPP
         HIsi6MjdpuZJgxEw8qfKzhZURS5ClKVYaSOSc9KGO8NQzi86am12+sWb8pDvaxMotTSQ
         QPcvcEBOyPQpUjqXip3DswQUOuvqeh3uomzHYYiRCruQQ5OQPPgoqjZTVqU9bpfXLrJg
         WW544EgwtIQGfC8kLwGKfnLSXo6ViC0B3KEEooC5e4reGcYs9hSelo+S/jjPEY9i7BtH
         5d9TlI975ULYBlRjLw/i//tnZL4ZvxDtfBliVGBcegvtF4pzuyeNXWId3iJegOYCdBqV
         nCLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749604379; x=1750209179;
        h=references:in-reply-to:message-id:date:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/q9F0QVgKQXBPTRqYCAtV3TQoo4PQHbILQ0hjeePie4=;
        b=pEoQiRjROnkLRIJIU7Z4/rq7pI2fXzhOyx8JXhVx9Gwag9kNZf4e2V2dWX9VLJebLD
         YCn+tYOq5G7bDFT0B9ovwvfCdQZKQMo/KBXMjqg4Odr2GKux/2C+ah6YM6Lf0M8NU/iu
         CoC2JM1WPej0/z/ssH2oreyu97UIkpjbUqIfFKvhmTTLkxgxol0xElrcekTA59oZgeL8
         uaVMrVGWmVw3a4YZeewvaI8+IHMELpDaSwv7AOY7D2P5ON1CVzml6XRaygKn0GOCGR+Z
         a7Bs/PO494Kvyu3CBEiTYV5myOqTplyiyL9dx4sOUHsydb7OI/ZrPiqknZVrz7ruRIZz
         lJNw==
X-Forwarded-Encrypted: i=1; AJvYcCUn+u1a7jzeUoSsXNilDtKQFGhcjsHJqwH1w2eIYdUUy+Ki6Qc5qHmCes9lVk7OodIDYwlNF90=@vger.kernel.org
X-Gm-Message-State: AOJu0YzoYWp3mqmyMEBflQqWRjU3HL3CzVJKi5ToqEkdNnRJgQQtGpdq
	BK4xOg9i92jmMAwrhxulU7vnYzdvTmjdpcKbzZmDKIxqNwxVaeScrSZ7
X-Gm-Gg: ASbGncsFH6A/YcVzvW1UoBDtmsAhg8pOKYyVXf7iCJkGpA6DOW1y0MlwSjYh+2/qKrU
	wAwLe2uhQ+7X7my25m+Xv7IvufY5/AUt4RwKLjyTHqvCBY8f6xRuEkpVW/GEpT6G4+aDdk3fE7N
	G8JEmS8cke4jM6JFO1fPiq8yUsLCELxFlyv+R++hunHQRqbOegXWGq00uMw2LqfHtJ8LnlRP6p8
	JsoOQr5JO/hKpSvMwOGS/Xd3nGWWRmuH7RsjZI8o7+9o6fbEkwdFxDKYTFHNmmerNLPs+H/5XVd
	yPoE24+pZ2Qb+3EEPieGNUH8x4nxXPnMd+PY1fmvslGn7pZB4iMu8nImEs6KYw==
X-Google-Smtp-Source: AGHT+IG40UJ332YITSwQAm9A2G9QbVijkCR1+TXJHPaXkxzDWWirrsZgm9nKrWeCE7JvwCH5z+AM+Q==
X-Received: by 2002:a17:907:60d0:b0:ada:abf7:d0e1 with SMTP id a640c23a62f3a-ade8c8d9dfdmr76014766b.37.1749604378658;
        Tue, 10 Jun 2025 18:12:58 -0700 (PDT)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1dc38388sm797360166b.130.2025.06.10.18.12.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 10 Jun 2025 18:12:58 -0700 (PDT)
From: Wei Yang <richard.weiyang@gmail.com>
To: Liam.Howlett@oracle.com,
	akpm@linux-foundation.org,
	willy@infradead.org
Cc: maple-tree@lists.infradead.org,
	linux-mm@kvack.org,
	Wei Yang <richard.weiyang@gmail.com>,
	"Liam R . Howlett" <Liam.Howlett@Oracle.com>,
	stable@vger.kernel.org
Subject: [Patch v3 2/3] maple_tree: restart walk on correct status
Date: Wed, 11 Jun 2025 01:12:52 +0000
Message-Id: <20250611011253.19515-3-richard.weiyang@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20250611011253.19515-1-richard.weiyang@gmail.com>
References: <20250611011253.19515-1-richard.weiyang@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

Commit a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW
states") adds more status during maple tree walk. But it introduce a
typo on the status check during walk.

It expects to mean neither active nor start, we would restart the walk,
while current code means we would always restart the walk.

Fixes: a8091f039c1e ("maple_tree: add MAS_UNDERFLOW and MAS_OVERFLOW states")
Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
Cc: Liam R. Howlett <Liam.Howlett@Oracle.com>
Cc: <stable@vger.kernel.org>
Reviewed-by: Liam R. Howlett <Liam.Howlett@Oracle.com>
---
 lib/maple_tree.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/maple_tree.c b/lib/maple_tree.c
index b0c345b6e646..7144dbbc3481 100644
--- a/lib/maple_tree.c
+++ b/lib/maple_tree.c
@@ -4930,7 +4930,7 @@ void *mas_walk(struct ma_state *mas)
 {
 	void *entry;
 
-	if (!mas_is_active(mas) || !mas_is_start(mas))
+	if (!mas_is_active(mas) && !mas_is_start(mas))
 		mas->status = ma_start;
 retry:
 	entry = mas_state_walk(mas);
-- 
2.34.1


