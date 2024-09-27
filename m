Return-Path: <stable+bounces-78139-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E3FC8988947
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 18:46:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9742F284200
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:46:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3B201714B6;
	Fri, 27 Sep 2024 16:46:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IUEsB+IA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0QpyIETp"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510DA139587;
	Fri, 27 Sep 2024 16:46:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455565; cv=none; b=LaBX/IMZlIj5Ha0UBVsHM+K5qbcuIXgGpZJC+0GJ8SVM2D+120hwkMDGZ+9ve5hc3ULvnXY4gGTlOU6TV3b23VKSpLkui0ndM6l1+u2QJRXS1IKc+wGAg2tVs5+m5XdZbgQgiw//C4Yeig4zOIk4t5TAxbKHnUNjSk6Bcz9hMxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455565; c=relaxed/simple;
	bh=Dq39zctb0+M+IyvzrX8hPT9pWJireV6GwwDwnMBinqk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=o2sF6YUrusWVCIVTry2Xpi1aty9MzvFCjrMgWdtqHWAkFpwhnd7CvEtvrM4zGv+aHSXxxclhEkYBCIHt2CUnSsxrN2eaMcSREgTb4zT7vuYylGC1EOtxL6I8+Y8vsNeH94hwmSKBnhpcS2CMtABXnr1mrUF09gBENPXlv7CtiHk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IUEsB+IA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0QpyIETp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1727455558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=duuwl2G3x5FNBhikPhn175qnffZs/xH8VAphAGWC7mw=;
	b=IUEsB+IA9enHtwMdL/vLDJ0YFw+n9xoDyBRk6/96HRC4rToE7tKdmZ89Zll61tVuiMjydo
	bK1G2L3p5fXzjkl3i+57cg12GOwPtR04r3LIj+WwAzewGHDg2fPp+mIIYmqVPEbj1IAuQM
	ZTODKk9Lmg+Xgf6CDNPSo6kHlFTqwjcncZ94n+4CFHuNkm0RNGDe4NoZUN6CpwgZqxmEqR
	/d7+LD0qHW8UZKmqN2GgrwlvOyMghwMXKpHL3DFK0Bej3+HMwbP0RphXLc7RyzZal73yvG
	JZO95wlGEkz4iDYD/LrKCaWcOX+C70nNiY80ZdjXVLm91pUaZ3gqyPXVtX4AuA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1727455558;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=duuwl2G3x5FNBhikPhn175qnffZs/xH8VAphAGWC7mw=;
	b=0QpyIETpEcfanTxgcw7vJOJ3XHz1/iIZntGUDzbL1dAv1JsdR7VLmxxZ0RSzFwdIMpryNT
	apZGu9u4dOX98eAA==
Date: Fri, 27 Sep 2024 18:45:38 +0200
Subject: [PATCH] tools/nolibc: s390: include std.h
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20240927-nolibc-s390-std-h-v1-1-30442339a6b9@linutronix.de>
X-B4-Tracking: v=1; b=H4sIADHh9mYC/x3MQQqAIBBA0avErBswDcSuEi3SxhoIDSciiO6et
 HyL/x8QKkwCQ/NAoYuFc6ro2gbCNqeVkJdq0Er3ymmLKe/sA4pxCuVccMPgfWeiVXG2Bmp3FIp
 8/89xet8PcaK7D2MAAAA=
X-Change-ID: 20240927-nolibc-s390-std-h-cbb13f70fa73
To: Willy Tarreau <w@1wt.eu>, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <linux@weissschuh.net>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 =?utf-8?q?Thomas_Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727455556; l=1026;
 i=thomas.weissschuh@linutronix.de; s=20240209; h=from:subject:message-id;
 bh=Dq39zctb0+M+IyvzrX8hPT9pWJireV6GwwDwnMBinqk=;
 b=RHItbtGGV9sIR5Q1cpcfUcivvYj0Q1EtXVlat1lkjCcJMvcz6dOUQBzxZcV7s/Vb04V2F4XOf
 1gSclD3z7NcDdPDbriSORa6H5WfvFhdVQWjubRJk76uK1bq1omzOuyD
X-Developer-Key: i=thomas.weissschuh@linutronix.de; a=ed25519;
 pk=pfvxvpFUDJV2h2nY0FidLUml22uGLSjByFbM6aqQQws=

arch-s390.h uses types from std.h, but does not include it.
Depending on the inclusion order the compilation can fail.
Include std.h explicitly to avoid these errors.

Fixes: 404fa87c0eaf ("tools/nolibc: s390: provide custom implementation for sys_fork")
Cc: stable@vger.kernel.org
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
---
 tools/include/nolibc/arch-s390.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/include/nolibc/arch-s390.h b/tools/include/nolibc/arch-s390.h
index 2ec13d8b9a2db80efa8d6cbbbd01bfa3d0059de2..f9ab83a219b8a2d5e53b0b303d8bf0bf78280d5f 100644
--- a/tools/include/nolibc/arch-s390.h
+++ b/tools/include/nolibc/arch-s390.h
@@ -10,6 +10,7 @@
 
 #include "compiler.h"
 #include "crt.h"
+#include "std.h"
 
 /* Syscalls for s390:
  *   - registers are 64-bit

---
base-commit: e477dba5442c0af7acb9e8bbbbde1108a37ed39c
change-id: 20240927-nolibc-s390-std-h-cbb13f70fa73

Best regards,
-- 
Thomas Weißschuh <thomas.weissschuh@linutronix.de>


