Return-Path: <stable+bounces-192837-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C4BFC43CE9
	for <lists+stable@lfdr.de>; Sun, 09 Nov 2025 12:53:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C0578188C94C
	for <lists+stable@lfdr.de>; Sun,  9 Nov 2025 11:53:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 966142DECC2;
	Sun,  9 Nov 2025 11:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ikgj9kXs"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B14512DEA7D
	for <stable@vger.kernel.org>; Sun,  9 Nov 2025 11:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762689185; cv=none; b=S2Z/ZijlERQw477xk0x1wLS+dVvX/qWzo818PpqV5LXJn2cS89J/Gu3zRQtBJ44Vr0Mf/zgf9XCD5d1dA9qHrOaHoBO/0yFyVJ8lb/qCmKh2Ajd+RX0yBa4Gs94cXHUYn9xc9+IX6nqN/U/VmcKueJV6A1YlrrxQKgK3dAletgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762689185; c=relaxed/simple;
	bh=YDk5MRIGuW1x2NadRPuVP+NinleU3/BZNen7SBV7Ix4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=YqlB62fslRIaQPhXNtFdL3V/KMqScj0bIpOxmQePSix9ITROVpCcV0XvWjvrB+y47NpsO+Uil6Yt91d4ZGg4WBM0NDHpfNVBAwQnmenMQU+2G0kk618GS7pAhDp5dHJA7xCkDOMocfpgzlk6ImAl78owoSx/Mw/P6BxcRw4QQF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ikgj9kXs; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-471191ac79dso22408325e9.3
        for <stable@vger.kernel.org>; Sun, 09 Nov 2025 03:53:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762689182; x=1763293982; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=oi5/iqZfrxw/CP5GK2yW/mE7gxZjVbgvC6f7zP3R/B4=;
        b=ikgj9kXsZCo1EnYwrXQKyv0gtvl5RKyFBl4BDa5Bib6P/g2AMclfr18KdgpckCQUvH
         yCPzbtLbvK16KDM57+XRepaPcu0XDDfJMzZDAhSoQBKX2AAt6FgXX0HmTai7XSYIe8q+
         2WcvpIToaNOGZHzjzj9LZ8EFUEC0o1Py0V8vTMTVIPNCsde1FE51BrS3nXg8VYHw3Yij
         dh4E3eJFyxJYRwfPtZcQ+rNImI6/GhRDg5/fxYN4YAzVxhfHfm9Rcarxasda9rizv13P
         phoT5j2tO9xTNJN1KXzH0ROkirkI1tsvVIq/siv2LcodWheZcARM+C6geVPdOTXE+1qj
         yOkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762689182; x=1763293982;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oi5/iqZfrxw/CP5GK2yW/mE7gxZjVbgvC6f7zP3R/B4=;
        b=W25GN0tOHtw3Q1r8Yhbe4qByt5w5MKtPFGDZMk62Ln/8GFcLuFSQOXYw8UC6gdwuRH
         FPbZLa8oSQrZSSVyjne57UQ0aVnWy7zqqluXdliqnROj3u0m7paDvFx0Z9UrkniZyKOe
         EnTdLQtb2hMveLNW0NZnVL5PVWGFd6lui8kNe6SpILQlyMNi6zwc5eiIkhb4MtKlfk84
         7dzAYi1/jULyNN7Wy1TMcb9HGzNyrd/QBSpXnC3KE2HABEliDc9OU8BADzxNsjq3ZMZi
         pVb3ITvUlH1BasXaNSzOcEuWfG5ByNVJLNm+APFPGD+sJ0t0ETVnQN+F7sPTY24mmh31
         faJw==
X-Forwarded-Encrypted: i=1; AJvYcCUBazfK2AXwdGugOdP1StUrdHbdoEi25yTyk34HEDs6Hwvmj2Uf6zGlHsZedV4Re2vzPAfI44Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2L0rv+BBdFqswgkCilYilyyECMS/57VBdEAN99mr+YvBYkX/M
	Y5xq409tpBRipLfN44KEXf/j1bD57gcoLVVkfZsIcY9YyKxbsX1hbE8H
X-Gm-Gg: ASbGncvToCYMRJpp9euq7lsuTxOTV5rbKpjmYYdGdRWLmULiI1628dJ/zwrKG374bsP
	6kIB5AHN2GAdHpboTlQ7vEXSRLNl7NVdIHj/PHEAXQBQdm9hGe53YwVOW7wyDDZQovDq/6IGXhM
	dGem4a/W1JFFoIitfKBRXTtqJpjEUd3t/xQNEgYLUt/goCnA41UjxpuuTFTENtNj14wDg0lOZJQ
	Ce2AnFeWG6+nkJ1d1QfJ8W+KW5LCB30/vgCNq+7MyJ8UnkxRXqqCNJ9YWEXSuNeocjztDWvFpI8
	0Dofp6au1stw/mNyi9tNToDxtveL03P4PQ4cy1FQgo5bANzJWGn7y9UxTpDRrcCe90dKEiw4+G5
	0jv8JYLaad3HChQ3aEaGhfCx71P4W9nLYTw0kaMtecLpn82C7bEIHCGfL/jJpO/zBnYfootkj9t
	fdayfrnUVFwR0vvtNMgTGhrnZGNcbsvUdP3hCLT3M4
X-Google-Smtp-Source: AGHT+IF0OdPl7P7zek6LN5EpjrwqGOR8oHSE9cecr6daRpyCulT9z+cFJeMMKofyvzMK78abF/CwMw==
X-Received: by 2002:a05:600c:4f4c:b0:477:7a87:48d1 with SMTP id 5b1f17b1804b1-4777a874db1mr13826495e9.30.1762689181321;
        Sun, 09 Nov 2025 03:53:01 -0800 (PST)
Received: from Ansuel-XPS24 (93-34-90-37.ip49.fastwebnet.it. [93.34.90.37])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-4776bcfd021sm185197325e9.11.2025.11.09.03.52.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 09 Nov 2025 03:53:00 -0800 (PST)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-mtd@lists.infradead.org,
	linux-kernel@vger.kernel.org
Cc: Christian Marangi <ansuelsmth@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] mtd: mtdpart: ignore error -ENOENT from parsers on subpartitions
Date: Sun,  9 Nov 2025 12:52:44 +0100
Message-ID: <20251109115247.15448-1-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 5c2f7727d437 ("mtd: mtdpart: check for subpartitions parsing
result") introduced some kind of regression with parser on subpartitions
where if a parser emits an error then the entire parsing process from the
upper parser fails and partitions are deleted.

Not checking for error in subpartitions was originally intended as
special parser can emit error also in the case of the partition not
correctly init (for example a wiped partition) or special case where the
partition should be skipped due to some ENV variables externally
provided (from bootloader for example)

One example case is the TRX partition where, in the context of a wiped
partition, returns a -ENOENT as the trx_magic is not found in the
expected TRX header (as the partition is wiped)

To better handle this and still keep some kind of error tracking (for
example to catch -ENOMEM errors or -EINVAL errors), permit parser on
subpartition to emit -ENOENT error, print a debug log and skip them
accordingly.

This results in giving better tracking of the status of the parser
(instead of returning just 0, dropping any kind of signal that there is
something wrong with the parser) and to some degree restore the original
logic of the subpartitions parse.

(worth to notice that some special partition might have all the special
header present for the parser and declare 0 partition in it, this is why
it would be wrong to simply return 0 in the case of a special partition
that is NOT init for the scanning parser)

Cc: stable@vger.kernel.org
Fixes: 5c2f7727d437 ("mtd: mtdpart: check for subpartitions parsing result")
Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 drivers/mtd/mtdpart.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 994e8c51e674..2876501a7814 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -425,9 +425,12 @@ int add_mtd_partitions(struct mtd_info *parent,
 
 		mtd_add_partition_attrs(child);
 
-		/* Look for subpartitions */
+		/* Look for subpartitions (skip if no maching parser found) */
 		ret = parse_mtd_partitions(child, parts[i].types, NULL);
-		if (ret < 0) {
+		if (ret < 0 && ret == -ENOENT) {
+			pr_debug("Skip parsing subpartitions: %d\n", ret);
+			continue;
+		} else if (ret < 0) {
 			pr_err("Failed to parse subpartitions: %d\n", ret);
 			goto err_del_partitions;
 		}
-- 
2.51.0


