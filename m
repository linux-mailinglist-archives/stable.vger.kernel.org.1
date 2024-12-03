Return-Path: <stable+bounces-96319-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F6689E1F27
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 15:29:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E9CCD164E69
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 14:29:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 305171F6694;
	Tue,  3 Dec 2024 14:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iZJPW67s"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92AFA1F4734;
	Tue,  3 Dec 2024 14:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733236169; cv=none; b=d9v5pQgq4o5791yO+zKKi0+lhtp2OrcCCZtj69UJn3vYuDBfPbdCozuyaf6cEupb0z9pNh3Mob/8oZKcpkJ0dd+Y8gNkSrG++omiuZkDMyq06i8JIRdUe/saP3K8J7bPabKbm/gzgqbuRR7fsndk0HvVLmngbF7scPQg6ufODFY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733236169; c=relaxed/simple;
	bh=+1CVOITrMSDAYxuRxJhKLu3y9hJjrRexlXC+t+7zD5I=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=O7lYQU1XgW0TmsnPTZ0O3Cs6qNl6v48fMgVNrtEw1Nz5+1Qu51Z2oBco44Y/aGmH0NrKBp/1IOnImwa02sEyaK0JxcctqLo9ydeUC8D+aHa5uf19qtjSKB3zNd8ai0ejAnJdMHqHaEbWmd0H7VDTXq8507QYLJuvmPdgpawfwAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iZJPW67s; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-7f4325168c8so2831807a12.1;
        Tue, 03 Dec 2024 06:29:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1733236167; x=1733840967; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=/rBUrhM/S9IzUIm28LQHezLCLEm0yncdwfMQ+zgKk9w=;
        b=iZJPW67sqlMd5niVueyWet7xxQrytAOvaqL9oPewCGDX2YEpbk2L+hfcEVCk8NjsLs
         gSuEtcdqj4MVBlgctWyxzahv2t1xJFsC0GXL3xcWEMpvVRH7cBYoEVBQSqCdC8cFM/HE
         dxwzm4Jz+EZ2LtysklO/b0Wkdscah5F403npLKRZQnT6ivNz0MKfwI7ElIBhWwY4KWgb
         MbLcHPsd6acL30rEwZfdEq2YOteHlnTR8J8uzRYLbTLyRf2zu/wLQ6jRSj+gOXzzW6hz
         l1tkiyIFKqnIX/5XQjMmh8MxbvhKejWuCo0mHRNecddBByse6bEvkCbliwj3SZMixWjm
         GfTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733236167; x=1733840967;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/rBUrhM/S9IzUIm28LQHezLCLEm0yncdwfMQ+zgKk9w=;
        b=edLHtbraG8rtjRgxUrLZaU4n5k9/B3jadUJ5plbxdmitGqFvBcEZ2IPBONYOfj4Uu+
         iBQoCQmbouUCjje602mB/JzaLa77P8iI8QBlk98j1NmNrN/JraTODhmhTa5Cxcxg2nG+
         lsvZD9EUCU920CmU5Cn+QZg4AmoHMFnpwB1tLs65Bt/64Aa5oRa7seEU1ZHs9D3RGDUN
         EidZ9dc93bffv/I7tkMaCA0KcjxkOTpbiR2TYgGoVpHh3ma2nQK3QCA4uI9WblwQ+0lL
         8BpN/DS2kynEs76p9qZU+6khC6loRToiiCCFPgU21xGoC8Ej4mbp57QuxFK3On7aHjX5
         CfNQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwblDr2/RA6mL2wGDRjoVA++eJDZD2k/H/mfAkbg5tK1eQke/comn4qRtgWwzL3amiwLhuOFdWgo/nLpY0JsxJ@vger.kernel.org, AJvYcCXKmZpNXkAgpM791fLqWvkNgZ00hYU00kRe+uX8seb/o0Q3YxzIxC7DLeUnxe4gPZB15K5MqESfBFM=@vger.kernel.org, AJvYcCXwDYxv7OPqKLDoCftFsagAhdq1riQSYvpAPa8A2iB/iJg0Jp0uwGPr8grrzVv4wQkzQPkU7vDiQeo714Ae@vger.kernel.org
X-Gm-Message-State: AOJu0YznCGm1MFP96XU/T+lYkub7RQUNh4hr+C9ZowaxSpsr6R1o+Bf5
	isKT50jjHbcTM8R79TIeN+tEbrbAKPul3V0zFuUiO/h9HUKZHthz
X-Gm-Gg: ASbGncvdJmEmgdt+vMsfIwTb62T1Ov5MSkjREybVkiiPcXLmb/8BJnV17u6PhczMCVP
	bXKXQnsRxT+UdTyZwasyHPLY+vXlk9AqqvkmdnDj4zHQSus+Y7CpV/yvpAE5mfDFffLHm5/eB0t
	XOzkdubkDc90NZGdPqJFg3yBij2eu+HUrFr578nebGqPvl4NLv7Eg0PSY971CxxvM5uzLq9peIu
	0Zkr8GEGJSkG1+W1+MrdRCYUfZgGQD0sl+ZiTQwaqyoMoxpHbRr4w==
X-Google-Smtp-Source: AGHT+IHibrNLVHQ7rrCzz9uaAV9eg7OPrWMwQf2AeMxgrpZAGjFmIN7k1DxTtndv45YSoU/1pBIShA==
X-Received: by 2002:a05:6a20:7f83:b0:1e0:d8b2:1c9e with SMTP id adf61e73a8af0-1e1653f1061mr3671929637.30.1733236166315;
        Tue, 03 Dec 2024 06:29:26 -0800 (PST)
Received: from ubuntuxuelab.. ([58.246.183.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-725418482a7sm10494545b3a.190.2024.12.03.06.29.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 06:29:26 -0800 (PST)
From: Haoyu Li <lihaoyu499@gmail.com>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A . R . Silva" <gustavoars@kernel.org>,
	linux-clk@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-hardening@vger.kernel.org
Cc: stable@vger.kernel.org,
	Haoyu Li <lihaoyu499@gmail.com>
Subject: [PATCH] drivers: clk: clk-en7523.c: Initialize num before accessing hws in en7523_register_clocks
Date: Tue,  3 Dec 2024 22:29:15 +0800
Message-Id: <20241203142915.345523-1-lihaoyu499@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With the new __counted_by annocation in clk_hw_onecell_data, the "num"
struct member must be set before accessing the "hws" array. Failing to
do so will trigger a runtime warning when enabling CONFIG_UBSAN_BOUNDS
and CONFIG_FORTIFY_SOURCE.

Fixes: f316cdff8d67 ("clk: Annotate struct clk_hw_onecell_data with __counted_by")

Signed-off-by: Haoyu Li <lihaoyu499@gmail.com>
---
 drivers/clk/clk-en7523.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/clk/clk-en7523.c b/drivers/clk/clk-en7523.c
index e52c5460e927..61d95ead5ec4 100644
--- a/drivers/clk/clk-en7523.c
+++ b/drivers/clk/clk-en7523.c
@@ -503,6 +503,8 @@ static void en7523_register_clocks(struct device *dev, struct clk_hw_onecell_dat
 	u32 rate;
 	int i;
 
+	clk_data->num = EN7523_NUM_CLOCKS;
+
 	for (i = 0; i < ARRAY_SIZE(en7523_base_clks); i++) {
 		const struct en_clk_desc *desc = &en7523_base_clks[i];
 		u32 reg = desc->div_reg ? desc->div_reg : desc->base_reg;
@@ -524,8 +526,6 @@ static void en7523_register_clocks(struct device *dev, struct clk_hw_onecell_dat
 
 	hw = en7523_register_pcie_clk(dev, np_base);
 	clk_data->hws[EN7523_CLK_PCIE] = hw;
-
-	clk_data->num = EN7523_NUM_CLOCKS;
 }
 
 static int en7523_clk_hw_init(struct platform_device *pdev,
-- 
2.34.1


