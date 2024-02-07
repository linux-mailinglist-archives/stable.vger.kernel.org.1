Return-Path: <stable+bounces-19084-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39E7B84D02C
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 18:50:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2661C25E96
	for <lists+stable@lfdr.de>; Wed,  7 Feb 2024 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A9282D8F;
	Wed,  7 Feb 2024 17:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bY7pumXX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5603F82D63
	for <stable@vger.kernel.org>; Wed,  7 Feb 2024 17:50:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707328207; cv=none; b=c8YlZlav7pREbkYCMpZ/Oa7xpFvDxHTAj3YY+xet+3W1VIS7sbV2PGGLktNAemvpRwBw+LAffPE1LVw5vvJBT5g3WHTeCyUVpXgKlNRg4eLHFlbQHwuP/Yzn65GYmh1hkXPxKbksn6Lyd0l/FpRQI0sM8e+JDNuRiG/MaM+CpSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707328207; c=relaxed/simple;
	bh=/8YYwTt1AJRdGmjsL44US76/DLuIf6PF+50fyO09ea4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Deq+D/4vIrrK4L9Akfhvk47QAKymT7wYvuCLYu+sum+oKAf/c1aVOlCh98ErBdEZO1C03rfa0xmgUVEOCwVODA52xnZhMtXjDHroAwLT6VbRcbUrFmz7MZWPRYCC9exEW5sYg18U1gVnOBvQBhaNnYzDvq4Llya7cE1k1JiPpPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bY7pumXX; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-560c696ccffso119693a12.1
        for <stable@vger.kernel.org>; Wed, 07 Feb 2024 09:50:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707328204; x=1707933004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z2FSP0AMac+5+E+PTkV33ahdwTRCUgCpOnh1itA8xHg=;
        b=bY7pumXXAzivKLkP+OtxaYJR4yQWBww8FPo2lT/W5DvYkQjgHTYg3F2TMg/Wh3QV3s
         AprYwYuRGFCLBrg8izydo4R8rDqyXFIEKVwKYat3ayWNWer9IOgQy5+/vGfbsNbLn3GM
         Lpi19ZuOrlqsOirx0y3LKTjeXMj/kVghB8OxSvDreNt7DAesqxf79As7ACLT2wODizgS
         jFoblXWiO0E51X2Pmbw4+ErvzMhDw7v7IGi/tokdrHIOkz2rMzpGGjZiIw3nQeoyv8qr
         IJ45EVcj9W3CVkGEEJIuPiVORDXqSQTVd7f6rv/yxGIunWc6BLnoABmCe1lmKeFti8ra
         6xTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707328204; x=1707933004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z2FSP0AMac+5+E+PTkV33ahdwTRCUgCpOnh1itA8xHg=;
        b=kZGJ5UGrW/f7Cim6quAQZ82b4wseTqAj3oxZWZ5GQ5F7CI6bPKsnRererjCa910c69
         ED2rFzrTAvGcJNj9fN+I2jfYfhx0hHWv+FsUg30XivPDc9yDwOCv6boaaYmZ+l3jXZ3G
         XG4F0/w7U8SFtyPB72hXy8EsFlmTrbX18AffxLRKtAf0/Jvw0+obnhp8AK4fh+vorfHg
         SyseJqtHyHp/EKMZQki6HIushNKQzmr3isZuQ1YzB1wKmkxT8lfL2eBQjstgLLct1h4K
         oVIWa59cbqeD56Ba0GhPtqpJ/xiYeaa4yEN/Nv24r3xNCxiq9WHoDNg/HyaRvR3dfsiP
         KWgQ==
X-Gm-Message-State: AOJu0YyQCHmDAbl8i7j90p2QjVoYR9gfR+d0Ee0wFZxE3tu38oh+N5u+
	Zdy9mnFFZaSZXXYSqLS+EgIJPBroEfts2O6tT9ThpS6dg+pnl39my9OHzT1Z
X-Google-Smtp-Source: AGHT+IEtzxtSoyL4zD0Jt8OZkZVEeLRJGCIq291CR/YkwkGPSz+ePtZ9DA9Nnme/DYNmlXmz/b00oQ==
X-Received: by 2002:a50:f688:0:b0:55f:ecdb:bcd5 with SMTP id d8-20020a50f688000000b0055fecdbbcd5mr277034edn.2.1707328203906;
        Wed, 07 Feb 2024 09:50:03 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXqyUnvdgxWOzQY/RwNTPGsjWaINK5My8em0zcGkd0Kqvnzv546crHfgdz0M+9z7P7MYE9pgGqMhf/0ky1S5mP8UXI5q5F6zqNq+TOT0cZNtkkrq21YiTJ3vImEHKGz7ZV+/CUhZQVw5OKnuvu5sLMXOwSXimkeep0rcROwrwg5Jb5xdGQSLCWiWc+cMSY+994ZrJK33/773HNVlOkkkt1WAPIcQHxUR0cifxzpHGlMTWykWyRuKZ/ZAuud07P49uOl8c5+TyKz0O4OYSJ1fPDtd4ZA/15g6rjBfsJQ7owj3R3RNl9mNI1RMm6nJUJetA==
Received: from toolbox.int.toradex.com (31-10-206-125.static.upc.ch. [31.10.206.125])
        by smtp.gmail.com with ESMTPSA id c18-20020aa7df12000000b00560f3954ffdsm180992edy.24.2024.02.07.09.50.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Feb 2024 09:50:03 -0800 (PST)
From: max.oss.09@gmail.com
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org,
	patches@lists.linux.dev,
	s.hauer@pengutronix.de,
	han.xu@nxp.com,
	tomasz.mon@camlingroup.com,
	richard@nod.at,
	tharvey@gateworks.com,
	linux-mtd@lists.infradead.org,
	Max Krummenacher <max.krummenacher@toradex.com>
Subject: [regression 5.4.y][RFC][PATCH 0/1]  mtd: rawnand: gpmi: busy_timeout_cycles
Date: Wed,  7 Feb 2024 18:49:10 +0100
Message-ID: <20240207174911.870822-1-max.oss.09@gmail.com>
X-Mailer: git-send-email 2.42.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Max Krummenacher <max.krummenacher@toradex.com>

Hello

With the backported commit e09ff743e30b ("mtd: rawnand: gpmi: Set
WAIT_FOR_READY timeout based on program/erase times") in kernel 5.4.y
I see corruption of the NAND content during kernel boot.
Reverting said commit on top of current 5.4.y fixes the issue.

It seems that the commit relies on commit 71c76f56b97c ("mtd:
rawnand: gpmi: Fix setting busy timeout setting"), but its
backport got reverted.
One should either backport both commits or none, having only one
results in potential bugs.

I've seen it in 5.4.y, however in 5.10.y and 5.15.y there one of
the two backports is also reverted and likely the same regression
exists.

Any comments?

Max

Max Krummenacher (1):
  Revert "Revert "mtd: rawnand: gpmi: Fix setting busy timeout setting""

 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

-- 
2.42.0


