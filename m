Return-Path: <stable+bounces-105403-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D27DC9F8E8A
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 10:04:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDE8218916E7
	for <lists+stable@lfdr.de>; Fri, 20 Dec 2024 09:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B9F91AA782;
	Fri, 20 Dec 2024 09:03:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="Gi6PNfsb"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B10111A83ED
	for <stable@vger.kernel.org>; Fri, 20 Dec 2024 09:03:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734685429; cv=none; b=gMNArtuWRZNT/bQPt31k9x6ExBXIhINoGjiCa6GNixp5OzkSGLIdvYMj2I+xQmQEiyZpMx2Q1l4Y0wZRKNz0j3ITs+CsQl9z9CNhcQfJ1egCQSeiA0+2ohHwAAUSX5UDJH/dIhUCytjVebHxl4TrVF8KIhrm2Ry0jY4Yo7sUb70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734685429; c=relaxed/simple;
	bh=rUGZF8yKmy+p1+ThFeCkZ6lSsu656MxTdFk1QCg9Tts=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fS/me3VxLbVCxqYYm2mXwmdMutecekjTfPYdHNIP+sCZPa6AwM4nddtntEZBcUmALRD4trO6CiqXSPbPypON1TCafTq9exdq7XCyhHXfA+XCuwPWEn4znhqqmr6/IZWc1sJFJXFsecy9khNsE+swRe8mRgjBaJ+tkd7OwOMsEi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=Gi6PNfsb; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-436341f575fso17566125e9.1
        for <stable@vger.kernel.org>; Fri, 20 Dec 2024 01:03:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1734685426; x=1735290226; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pq1bmVOour8kC/0ODYFkalnMVivKoV+qKdeFNxm3Yvc=;
        b=Gi6PNfsbXt7l5F8zvhLxhSTEC633XvQzbCbOogMNRT5Ny3VsT+DkfjWo3mS9fB5KV4
         mTsQJtYpqizT+mJQUDFucLHFuIY7zonLfwY/2488VezyMzMbXpcIIQ89eroDhRmvPHpg
         O+IzqpYEhFjz3laTe6OyWrBYzIlR8e5NoYwCvQhNdJacHt7JJvfhls1hCTfBj5nPVFsG
         uxFeNrClGYMGrEygfEgExALVwtmKTm6yClH/j6+Ro+f9Xmwj6VpT0U6kcme3b5hslHPC
         ohiFJfP0fgojMWNd8ISvKPQq+u5sS7AaePBrhTN5kXFBVhKReMeEb93Uus8z08dfsElG
         yFmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734685426; x=1735290226;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pq1bmVOour8kC/0ODYFkalnMVivKoV+qKdeFNxm3Yvc=;
        b=lqmm1o+QHFgGdTdepUduQ54sMMaV3P8DizRJQHMgzH3gdv5o6IuJUdn5mnS8geiP+U
         lwY5xA8vvE1trtFhmwxOQsTzMykiMEIyZyMagDJqAqjCYmJgYnAC3CK3hRNr66HgNYWw
         d/NbkV1I9La7HiDp2vQM1P3oLKYFhh2OyQtuUIUGXU2N36k0XB14d27aG1QJ3m9YIu9V
         BxyC0bDd2Xm5Z+UjQYLJ8OykTBWVEMtvmkvn2xYm90/6XOb00eFW/97R5D0mLha24pkY
         mllqmSV8evAhMUaPcOUvo3Z3vz3sr6T30IPtGrUxPF5vK+4OWOYcY71clOt0r+SH5ro3
         tvhQ==
X-Forwarded-Encrypted: i=1; AJvYcCUTtplzyJESHJIkaZoBGz64Vg6OkLNp7BWqnhAobcEx3u3ErEJE/FN2Nh9ZjvWBiDosxB+s8us=@vger.kernel.org
X-Gm-Message-State: AOJu0YzgfHfSqbbuPLoOkXFddr4rqTiBS+uP2io6PQRhVevDrU2Ldp3L
	yiULW6166FJyr4IlDbWvx4wNYgXLCsidLg5ZWyinumvWoMpLpcXhINvHeSLs5GqUL5ayxWp1L35
	dhc4=
X-Gm-Gg: ASbGncuhjwZbvaZM/sTAZPsy64esiOyJ/hKsYvVwmFb5chVBR0P4XyhiuMjlXAcmaAM
	PPs/sInfJBj1lCcHC/Q5fbu0nxidm0TJIr2lxT/5LqeOdlY3owEy2NkxGedE1yR2LaidUt9r2wd
	2Gv6HP7LBe9xFVHzrF/Kne+Yo5i1+dP4OLnJoQ6VLSvg8zrp+hCVCpgx/ldKRol0rQdFk/tZlE7
	bWOk+7Z7A+lwIlWfuwJDNkelRs8J8dCSPRP0NK3ZfNO8+r34QU1yQh+CfuYbTYwPvtpnTHuY3YT
	OjwRvGAaTiCwWQJc1y6ald6oysd24w==
X-Google-Smtp-Source: AGHT+IHgsh5xJuAMq4qoVNA6TBwXpF2ZHhv/viApIXc0e7PnnUdfQR1REEbtj0sPbgIGdKOKXJ+NIQ==
X-Received: by 2002:a05:600c:154b:b0:434:a734:d279 with SMTP id 5b1f17b1804b1-43668644104mr17730505e9.16.1734685425998;
        Fri, 20 Dec 2024 01:03:45 -0800 (PST)
Received: from [100.64.0.4] (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-436611ea3e0sm40610375e9.7.2024.12.20.01.03.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 Dec 2024 01:03:45 -0800 (PST)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Fri, 20 Dec 2024 10:03:30 +0100
Subject: [PATCH 1/2] clk: qcom: gcc-sm6350: Add missing parent_map for two
 clocks
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241220-sm6350-parent_map-v1-1-64f3d04cb2eb@fairphone.com>
References: <20241220-sm6350-parent_map-v1-0-64f3d04cb2eb@fairphone.com>
In-Reply-To: <20241220-sm6350-parent_map-v1-0-64f3d04cb2eb@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>, 
 Konrad Dybcio <konradybcio@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Weiss <luca.weiss@fairphone.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2

If a clk_rcg2 has a parent, it should also have parent_map defined,
otherwise we'll get a NULL pointer dereference when calling clk_set_rate
like the following:

  [    3.388105] Call trace:
  [    3.390664]  qcom_find_src_index+0x3c/0x70 (P)
  [    3.395301]  qcom_find_src_index+0x1c/0x70 (L)
  [    3.399934]  _freq_tbl_determine_rate+0x48/0x100
  [    3.404753]  clk_rcg2_determine_rate+0x1c/0x28
  [    3.409387]  clk_core_determine_round_nolock+0x58/0xe4
  [    3.421414]  clk_core_round_rate_nolock+0x48/0xfc
  [    3.432974]  clk_core_round_rate_nolock+0xd0/0xfc
  [    3.444483]  clk_core_set_rate_nolock+0x8c/0x300
  [    3.455886]  clk_set_rate+0x38/0x14c

Add the parent_map property for two clocks where it's missing and also
un-inline the parent_data as well to keep the matching parent_map and
parent_data together.

Fixes: 131abae905df ("clk: qcom: Add SM6350 GCC driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 drivers/clk/qcom/gcc-sm6350.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/drivers/clk/qcom/gcc-sm6350.c b/drivers/clk/qcom/gcc-sm6350.c
index a811fad2aa2785fffbdee0d4bd3cd1133e4d0906..74346dc026068a224e173fdc0472fbaf878052c4 100644
--- a/drivers/clk/qcom/gcc-sm6350.c
+++ b/drivers/clk/qcom/gcc-sm6350.c
@@ -182,6 +182,14 @@ static const struct clk_parent_data gcc_parent_data_2_ao[] = {
 	{ .hw = &gpll0_out_odd.clkr.hw },
 };
 
+static const struct parent_map gcc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data gcc_parent_data_3[] = {
+	{ .fw_name = "bi_tcxo" },
+};
+
 static const struct parent_map gcc_parent_map_4[] = {
 	{ P_BI_TCXO, 0 },
 	{ P_GPLL0_OUT_MAIN, 1 },
@@ -701,13 +709,12 @@ static struct clk_rcg2 gcc_ufs_phy_phy_aux_clk_src = {
 	.cmd_rcgr = 0x3a0b0,
 	.mnd_width = 0,
 	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_ufs_phy_phy_aux_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_ufs_phy_phy_aux_clk_src",
-		.parent_data = &(const struct clk_parent_data){
-			.fw_name = "bi_tcxo",
-		},
-		.num_parents = 1,
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
 		.ops = &clk_rcg2_ops,
 	},
 };
@@ -764,13 +771,12 @@ static struct clk_rcg2 gcc_usb30_prim_mock_utmi_clk_src = {
 	.cmd_rcgr = 0x1a034,
 	.mnd_width = 0,
 	.hid_width = 5,
+	.parent_map = gcc_parent_map_3,
 	.freq_tbl = ftbl_gcc_usb30_prim_mock_utmi_clk_src,
 	.clkr.hw.init = &(struct clk_init_data){
 		.name = "gcc_usb30_prim_mock_utmi_clk_src",
-		.parent_data = &(const struct clk_parent_data){
-			.fw_name = "bi_tcxo",
-		},
-		.num_parents = 1,
+		.parent_data = gcc_parent_data_3,
+		.num_parents = ARRAY_SIZE(gcc_parent_data_3),
 		.ops = &clk_rcg2_ops,
 	},
 };

-- 
2.47.1


