Return-Path: <stable+bounces-195044-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id E00D5C67288
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 04:34:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B04684E2078
	for <lists+stable@lfdr.de>; Tue, 18 Nov 2025 03:34:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECD9730217D;
	Tue, 18 Nov 2025 03:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FyKKujqN"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27FDC30AAC6
	for <stable@vger.kernel.org>; Tue, 18 Nov 2025 03:33:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763436836; cv=none; b=tBt8Yf0lSy73kJSWv/AAMzFOAHvXnHiKBuOQt9LfH80uBS2yG+RGYiFJNbSOk0PyujqFOhdyzYqIzEmdTiD0VNInq0ZHpDF7Bcx2WFPwZ7+doQ3FYhY7GLh0sNiOCbpEsAOEiF532qb8arsGkBAClQHXZUxmfl8uWP6iwxAMZzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763436836; c=relaxed/simple;
	bh=geufpOCEDdFKcZ5MrqwwzZdC8+vVlLCwpno40cRwcLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=fu1xuc7xx50zCq0gEBC5/RGJ9Uk4HLoKTFU88dhArojz74FjaFYMEeIfFUeBMLb0eLxztw7Pn9Cxq42/73xD3ZSY58F9YSUhD6Bidz8P6PhdmuLhe1SvahNR5sFV0UUgxbeCadUp4+Iv07p26K8F6sTEv6t/7iSWB/EFMrdS960=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FyKKujqN; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29812589890so64275205ad.3
        for <stable@vger.kernel.org>; Mon, 17 Nov 2025 19:33:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763436834; x=1764041634; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4POpDdLCAEAaguEwBjZapDEtx8R3iRforMNq6m5UEKA=;
        b=FyKKujqNMMDxGv8e22gg3zoaGD7x8YmwAFHnIB/IaWBNl85Qri1ugt6EVGCH5PlGY9
         uG+WB0WJpdesl52cZabnXcS5WH9aPoDvvHUkDU4he4qvOvuBW059yYdHzBP3Vc1+xsOF
         0saZRjA9mUYPLinG15Nf7Vu/yYbyJbTMmZQfsPdKiN17vcj8y0rfm08ZsvZmRIEUnjzF
         8ZxSO+Llgtw7S5aSssFF+PKBQEU0HDhybJd/qFa/G8LKsUGveEqLrn6LYA5S3UhD5uQw
         ZqbEa5tapoHDxIu4oDoDgz9rgXV2CzibLiH5UD6bt6RwOYaa+8Q7ZYH5L44KyszouHrP
         X9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763436834; x=1764041634;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4POpDdLCAEAaguEwBjZapDEtx8R3iRforMNq6m5UEKA=;
        b=BqyQor549u0qkPnIuCVbABbnTFhwoiGfOGZb7miS2I6ozXYUJe3pHe9vQJjLm+3P+e
         PrcJljJgXZhWJQ+giL/Oyenjm9FAeRHWQ776XrVpuHixkNIkylwcblqVEfcL3GkzdtqP
         c7qN9U24cwlf77zPgmLkR8BYAfEKKKL5L8MKyr9IddKYiac/lBmt4Ak+FgBRStnOe+49
         8L8ALBgVXgY3OM5Yo2o5pecC6BO14JRqd6pO53xntZxeZlkaXOR3PFQuwkN+kghs4Uo9
         pfjMSUdhw2/S02+y1ieTzDdLZWmY2et2V2gZrkVP3O0NmFucxgFTaGMT46F9Mext3S0J
         1SuA==
X-Forwarded-Encrypted: i=1; AJvYcCWcKJgeffkxMrjZfmlxyZJ94YAqz3pYLTav00FZXJpo8wxU0zqWIgv4R+IrGIo8LO+4vyBmiPw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzo81+rpNyrssFHwT/OQz2s39zYs7de6SAcur+ZUngFX3UH/HWV
	0clFjubK75IOToIhTMrqHdCGISMOfLt2xIO4Yu0MPschMu7PAmOAke42
X-Gm-Gg: ASbGncteqS6yrB8k+Wr9ejrb7hHfDGklPfZT3rNQRVIu4j/jiQiC31TLosrMhHet4Y4
	A8mUfokQruhxsk3yWrNguQnPku7WKY30u+/6K2owQcJ9Ayh9X7GJgjSp8zOxat+/1XeR+44OZiZ
	ohS8X0Z+jWaM3O50cIHwoxZ1SVhxl92Gvs7UkmMEJ974HErgxPQtL4tLVbeGnVCo21tp6CFccSv
	PvsmdaLYY7MJi4FQbrpPkH6Lx773JyYq1dIoPwKuUfhRqUNvLP0qpzLCwxSNFZ/2/2n0coeAQBJ
	O31AmFbwklRy08OjD2Kx0EQ6bPDp6TpmNOZ6DnT1yW/iBR9k3k7rFnHBEFzm8AdC9ErOlfdOjAj
	pzxiITwcRYWJrCqKd6dmT6duxeMHVMY1EoAQsilA2uiEIXuBelsWV0Q4rETlD3QIomnJ2zmSuFU
	clkU8wIc4E6iPCmb8JcsmDW46z3w8N5WONlG1CMQ==
X-Google-Smtp-Source: AGHT+IGdPC7Cyz7EiLnEPeeedFK9rwJEg8TG2kP1KcNvBMkrm9YQB0epxVT4tlbA7xQi7ezGfVf1wA==
X-Received: by 2002:a17:902:f78d:b0:299:dc84:fd0 with SMTP id d9443c01a7336-299dc8410aemr79764285ad.17.1763436834248;
        Mon, 17 Nov 2025 19:33:54 -0800 (PST)
Received: from bass-virtual-machine.. ([1.203.169.140])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2985c2376f6sm153724295ad.21.2025.11.17.19.33.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 19:33:53 -0800 (PST)
From: Gui-Dong Han <hanguidong02@gmail.com>
To: 3chas3@gmail.com,
	horms@kernel.org,
	kuba@kernel.org
Cc: linux-atm-general@lists.sourceforge.net,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	baijiaju1990@gmail.com,
	Gui-Dong Han <hanguidong02@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH REPOST net v2] atm/fore200e: Fix possible data race in fore200e_open()
Date: Tue, 18 Nov 2025 11:33:30 +0800
Message-Id: <20251118033330.1844136-1-hanguidong02@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Protect access to fore200e->available_cell_rate with rate_mtx lock to
prevent potential data race.

In this case, since the update depends on a prior read, a data race
could lead to a wrong fore200e.available_cell_rate value.

The field fore200e.available_cell_rate is generally protected by the lock
fore200e.rate_mtx when accessed. In all other read and write cases, this
field is consistently protected by the lock, except for this case and
during initialization.

This potential bug was detected by our experimental static analysis tool,
which analyzes locking APIs and paired functions to identify data races
and atomicity violations.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Gui-Dong Han <hanguidong02@gmail.com>
Reviewed-by: Simon Horman <horms@kernel.org>
---
v2:
* Added a description of the data race hazard in fore200e_open(), as
suggested by Jakub Kicinski and Simon Horman.

REPOST:
* Reposting v2 as it seems to have been overlooked.
---
 drivers/atm/fore200e.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/atm/fore200e.c b/drivers/atm/fore200e.c
index 4fea1149e003..f62e38571440 100644
--- a/drivers/atm/fore200e.c
+++ b/drivers/atm/fore200e.c
@@ -1374,7 +1374,9 @@ fore200e_open(struct atm_vcc *vcc)
 
 	vcc->dev_data = NULL;
 
+	mutex_lock(&fore200e->rate_mtx);
 	fore200e->available_cell_rate += vcc->qos.txtp.max_pcr;
+	mutex_unlock(&fore200e->rate_mtx);
 
 	kfree(fore200e_vcc);
 	return -EINVAL;
-- 
2.34.1


