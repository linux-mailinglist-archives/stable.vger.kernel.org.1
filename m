Return-Path: <stable+bounces-191723-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CECDC1FEE5
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 13:06:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BFC034EA93F
	for <lists+stable@lfdr.de>; Thu, 30 Oct 2025 12:05:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 083603128C5;
	Thu, 30 Oct 2025 12:05:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H+c0wQjG"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FE101B983F
	for <stable@vger.kernel.org>; Thu, 30 Oct 2025 12:05:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761825913; cv=none; b=sPX1QUwv1qc9ZGHCUEKNPQI7auCFbprVDkVy6OCtEe9IqDJdI7ZYNBIiOvjfrZgCUrPPQZFrw1HI7XHv95/7VI/IqMBYhtzkeQNRO9j1JCByH2ilwRUKS86sP+RAu3/XZ2lIV856sbFashPfU9VgP5LOXC0WvH3NUIzzTB8Pcf0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761825913; c=relaxed/simple;
	bh=Nnmy/nhRXy1Jb2EolZDFX082PZeZ22LYX0yNSq8ROCg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nC4pMqxxAtEa8IsqNPmPBAHS47APMDUJE2OlTcCgo3PS9sV/8UxYt1qEodT+R3zIery9WLHm+4M+0x9ys2DkWUtxyNrwOq+fNsZBTKe/pYfo5K40C8ERiOJfcOLAOaGs2yAPI6DLptNxt8J0Z95cKZxLdPb3xo10kdIWhiSkZTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H+c0wQjG; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4771b03267bso7016685e9.0
        for <stable@vger.kernel.org>; Thu, 30 Oct 2025 05:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761825910; x=1762430710; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OCpWVCeFoXMs1/EyJIuFGqtdg2vmYZ9/7tM7s70z/qU=;
        b=H+c0wQjGAMRqI3BM58JSCWRYsnmL6RELy9aBlGdO+v9a2eUJku4z08/XkbAGVY26j+
         8JVFUQ7Z9qOncEzCGwXN/tYAv0vhW28YkqFGNBwbqBYmlpo+3UNIxlEFn95diBkGnKfU
         IjmIFasmTsktL++A+MamH8kynWkPEu4Orp6colEwN10japUSkzvYYXyq4WHk1hQABosL
         4ZU7dgNI6kxuUVjsTPm2qwLOMtCPBteJ7/gIH1Z9AbXtHBaoqPkagiPgfPni2BjycveW
         8KwFFJxfNeToyWvhJa9IMSj2tUQ2xzRkKum1OJg20BBfdN/SkJBPWTewzBKLkZeCwn2e
         49vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761825910; x=1762430710;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OCpWVCeFoXMs1/EyJIuFGqtdg2vmYZ9/7tM7s70z/qU=;
        b=A34EGrzrroTbnoABh/Mu/nAjykg3BZNyyCU/KwWiSDxzKH2mbYowu+tVl0Yl5uVJSy
         Kxx2gi3XcJlPZxi0jQW83z2H6jp9JdYlQ8UPV39y4mOftkvG//hk0g3qAV/McPjszp8U
         QSWD8yIfmy+9S85yyxoxDlENzJYvEfQq9ardvIRJYPzxMSqEgAmumQnBBPto+NWD0e2X
         kDukIc5rZzQrzlnplSzM6hnBhlTVjhuLQ71P8jyG4rxVtUacEDGA33CMxU/A+n7M8JzY
         v9w3s9mRNNF69lu1w4kuWdJ51bslkdIt+nweK1tOomqmT4g5VAVsGT2Sr+lQGoeAJT5h
         vLSw==
X-Forwarded-Encrypted: i=1; AJvYcCU+iajwrh+cnSq7qXXXVZLtFySJomVfSE3yIN63X//JfLS7luOaa0M79yOw6LWglNwHhU63Z0Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YyLzh4vc+2l/S2/BR6UZnu55JoT+7sjuum9MLllZnFYpFy4gK8n
	eeXniBlv2c9HVjo1dCWalgXWOleUaGS8NCJRxN/y04K0Gcb/0pil5XJR
X-Gm-Gg: ASbGnctr6GGir3Gw+mRPClaV75kFOcT5xKup9QyE3fiQOCHQFr+RFuBQNN2MWyyX+OO
	GadepRnx8FpxfxGqMy4cVinOT2DUpc2o7Noel8zTJe+hRnjcFLPLy+7TZivajwOyBr0sIeHvtJ+
	hjLyuUwcZcENJEhxy01ZB6i9Et+X9zP2XpdWtRYWtEU4szWqAawlvJ4wz4g035zUw4f79lFfL69
	4i9n7QMRg1d28MRSuNNx8XyBUKOTz9CWiERQgTUOOL/MuT8H/Wxv8cvC36BT6Tyn/UMeo3YY+dD
	8X4e8vpcvxrC+1/z0NK7lseVL55SPm2aUfig5Bybxjhwv3ENk9V0BMoGCeeaqn5g1WNOQGr6kqJ
	RQUYYxlvLzv2hUIUJiXvkDKnPiey5HkASLGliLQ5z1y5PE6snEgGIQwAf/96xf+mtUchgNAM1S9
	9UfsKVT/3cUpqWUGFMBjiZa2csGHnQAnUdGf5ACYdbz/uTw2t9jJKDJLD3AyDA
X-Google-Smtp-Source: AGHT+IFu0rRxNzi3BvOKL1lXRDq2cHd03YnzoBoOPePE4rUTNG1zrE1V3xFacaBHpTSekptbKXeGkw==
X-Received: by 2002:a05:600d:6355:b0:477:28c1:26ce with SMTP id 5b1f17b1804b1-47728c12b10mr14305245e9.7.1761825910183;
        Thu, 30 Oct 2025 05:05:10 -0700 (PDT)
Received: from biju.lan (host86-162-200-138.range86-162.btcentralplus.com. [86.162.200.138])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-429952ca569sm31018677f8f.12.2025.10.30.05.05.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Oct 2025 05:05:09 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Marc Kleine-Budde <mkl@pengutronix.de>,
	Vincent Mailhol <mailhol@kernel.org>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
	Tranh Ha <tranh.ha.xb@renesas.com>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	linux-can@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
	Biju Das <biju.das.au@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] can: rcar_canfd: Fix controller mode setting for RZ/G2L SoCs
Date: Thu, 30 Oct 2025 12:05:04 +0000
Message-ID: <20251030120508.420377-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Biju Das <biju.das.jz@bp.renesas.com>

The commit 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
applies to all SoCs except the RZ/G2L family of SoCs. As per RZ/G2L
hardware manual "Figure 28.16 CAN Setting Procedure after the MCU is
Reset" CAN mode needs to be set before channel reset. Add the
mode_before_ch_rst variable to struct rcar_canfd_hw_info to handle
this difference.

The above commit also breaks CANFD functionality on RZ/G3E. Adapt this
change to RZ/G3E, as well as it works ok by following the initialisation
sequence of RZ/G2L.

Fixes: 5cff263606a1 ("can: rcar_canfd: Fix controller mode setting")
Cc: stable@vger.kernel.org
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/net/can/rcar/rcar_canfd.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/net/can/rcar/rcar_canfd.c b/drivers/net/can/rcar/rcar_canfd.c
index 49ab65274b51..1724fa5dace6 100644
--- a/drivers/net/can/rcar/rcar_canfd.c
+++ b/drivers/net/can/rcar/rcar_canfd.c
@@ -444,6 +444,7 @@ struct rcar_canfd_hw_info {
 	unsigned ch_interface_mode:1;	/* Has channel interface mode */
 	unsigned shared_can_regs:1;	/* Has shared classical can registers */
 	unsigned external_clk:1;	/* Has external clock */
+	unsigned mode_before_ch_rst:1;	/* Has set mode before channel reset */
 };
 
 /* Channel priv data */
@@ -615,6 +616,7 @@ static const struct rcar_canfd_hw_info rcar_gen3_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.mode_before_ch_rst = 0,
 };
 
 static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
@@ -632,6 +634,7 @@ static const struct rcar_canfd_hw_info rcar_gen4_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 1,
+	.mode_before_ch_rst = 0,
 };
 
 static const struct rcar_canfd_hw_info rzg2l_hw_info = {
@@ -649,6 +652,7 @@ static const struct rcar_canfd_hw_info rzg2l_hw_info = {
 	.ch_interface_mode = 0,
 	.shared_can_regs = 0,
 	.external_clk = 1,
+	.mode_before_ch_rst = 1,
 };
 
 static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
@@ -666,6 +670,7 @@ static const struct rcar_canfd_hw_info r9a09g047_hw_info = {
 	.ch_interface_mode = 1,
 	.shared_can_regs = 1,
 	.external_clk = 0,
+	.mode_before_ch_rst = 1,
 };
 
 /* Helper functions */
@@ -806,6 +811,10 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	/* Reset Global error flags */
 	rcar_canfd_write(gpriv->base, RCANFD_GERFL, 0x0);
 
+	/* RZ/G2L SoC needs setting the mode before channel reset */
+	if (gpriv->info->mode_before_ch_rst)
+		rcar_canfd_set_mode(gpriv);
+
 	/* Transition all Channels to reset mode */
 	for_each_set_bit(ch, &gpriv->channels_mask, gpriv->info->max_channels) {
 		rcar_canfd_clear_bit(gpriv->base,
@@ -826,7 +835,8 @@ static int rcar_canfd_reset_controller(struct rcar_canfd_global *gpriv)
 	}
 
 	/* Set the controller into appropriate mode */
-	rcar_canfd_set_mode(gpriv);
+	if (!gpriv->info->mode_before_ch_rst)
+		rcar_canfd_set_mode(gpriv);
 
 	return 0;
 }
-- 
2.43.0


