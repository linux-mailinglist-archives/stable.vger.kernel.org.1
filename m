Return-Path: <stable+bounces-177786-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B3878B44EC1
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 09:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 748DA1C27F79
	for <lists+stable@lfdr.de>; Fri,  5 Sep 2025 07:10:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FA29289367;
	Fri,  5 Sep 2025 07:09:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="zjR5YD3g"
X-Original-To: stable@vger.kernel.org
Received: from xmbghk7.mail.qq.com (xmbghk7.mail.qq.com [43.163.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 221A6DF71
	for <stable@vger.kernel.org>; Fri,  5 Sep 2025 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=43.163.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757056198; cv=none; b=k5JwKl/u1P6tJXaxYhcFWw8VVNzqZNFXIsNBj5l/2iPBs63d7DqEi+0z42GZzmgod4K4UeY77TXPDRcBPQPM8jYjB9EuJUEgAlhbsHDwSNdBkaB0WaoMIlYy+so+pr7T/QYXOXGruXpgv/aYDYiiZGM60A4hVcDQxfQHCfHF5I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757056198; c=relaxed/simple;
	bh=OC4o1i94qVpKoZyQ/s+YuCDrzE4DA4F/IrVsGdCobkw=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=Y+yBgFL2oeCxfa+3IaoHPjc88B3FTSnv6xTS1hTPsJWk0QDqrm+Q35sQ94f1pNf74AO6swW7TMUU54W6GiZ7RnPYRUZJJbY6uq/Q3vXAbxbH7PglPGh4ZIHvtC1gDr7tUShYOCIDEk1ZzJ1KOVx9vSBxfyFMKit9B8kqpYprcCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=zjR5YD3g; arc=none smtp.client-ip=43.163.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1757055886;
	bh=crFPl5YHNuT6YJMa1eIlpsdXSZrYTWQTPH2BOt4SdgE=;
	h=From:To:Cc:Subject:Date;
	b=zjR5YD3gHKccFGt1QnyqbzfveyxncbT654EPBq9OO8dTNVRPX2lKgnM2KTs59nrz4
	 ug5j8rf9Rn2IR7v47ZNJ5YQ5NOlUDEgWJZX0NcfljPsnNAuLRL6yJc3hs+LTXU6t27
	 G07EMw2+2EYD5S12yPSGLp5GNZERHXfHDrwz4mTQ=
Received: from LAPTOP-HOSUGD0G.wrs.com ([120.244.194.248])
	by newxmesmtplogicsvrszb20-0.qq.com (NewEsmtp) with SMTP
	id 11A3C006; Fri, 05 Sep 2025 15:04:26 +0800
X-QQ-mid: xmsmtpt1757055866tghwkxzoq
Message-ID: <tencent_ADD77C7E5C48525937E1C0C0D836B4D02A0A@qq.com>
X-QQ-XMAILINFO: NY3HYYTs4gYS1/jI0bDsh1R0fvDkewYvv5sKdLGIIQjgoS32DvvRf+0XfUdz8A
	 W1L3DEp70v1/gpAChjzGGQrZhpuyiUUTn/TIB1sJkOhwHO4ARrGItHCwYlVFsDBH2THCUMeffOU+
	 +B50hbRCENPhK6hz0QT7Seara4zNCsTwEzFi7lHSmSzftTyPIQTyZttDKn5kWfTMMkH4V5WqbOLu
	 e3GiQV6dkowezjFBN07Mrm497VWMZvrUgXhRGdX6skc6H2UpfqrfLjdkU9vFSXXzX38JCsiUEmAZ
	 tWgN0bnxa3NT2yLd96Z3fmNuzzGcZtQOM+oL1x7mybphIPs6FWF8Uuk64kOQU/l7FEVvcxOIjcwu
	 5neDbKGKUHW30T50DMjCarJVOf4IDcH1lVkn1YnHqSRTxzMOMkcTmdLVrWvP6CmDU815f/eYXQZB
	 UuJJQEwxLNnXG/3Qw0/mxf4VFFBNJok0iAEq+pmXMGyaIg98tCW0mj6KU10eDvyWYTTqQEsD+Uq9
	 P1bdD2f9p03sQZkYArHWTxAy0/UzrZHg/EFxZVQzRSBP8/i8KXAEu2PFQpzTvtZ3wZVYdU+uzFNs
	 kQ5W90EscRj7xu6UlvghR3u7jjVaeQzjV7XOPVs5nCmjtSuHLSKSzyYWZAGzacp+rdF1PBekCNDS
	 /4jhWAVa3OJV7e2FRFZ2jQUdawAsserfjdya1wPSjydsHeCyAMyd87rQvXp50AOt/897kOZZCKYL
	 Pgdhv0aj91uTehyPSGrsVOk8F4MOjz+9Nt78826P3ljEoU8LqX87y5Ya4S3ECl1/HI2F7XrJDnm7
	 b1wG4UXFeb4Y7blzyaq0aCtPDip2fF5di8jcrZO1gFkY6pqT1rItQgmCLIOSItAOqJv2KD2jpDjz
	 /RDmUBXVpy7evElG9rBG19EDw46Kun5S8Hcnr3AgnvmUnauO137JkV7t8sAQeBfmNjNnjjr23r4B
	 q9JQ8oKfjZv/r6Zytn1lJ4t+eHYSdki6PrqaGPwe2o5U+izL2cZ8kO4oLKWgXU+5SD4zRWO4bsO5
	 xO0VYlytRGAi5s4uxyS8knbSo9YRU=
X-QQ-XMRINFO: OD9hHCdaPRBwq3WW+NvGbIU=
From: alvalan9@foxmail.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Alex Hung <alex.hung@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Jerry Zuo <jerry.zuo@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Alva Lan <alvalan9@foxmail.com>
Subject: [PATCH 6.1.y] drm/amd/display: Check link_res->hpo_dp_link_enc before using it
Date: Fri,  5 Sep 2025 15:03:58 +0800
X-OQ-MSGID: <20250905070358.11097-1-alvalan9@foxmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 0beca868cde8742240cd0038141c30482d2b7eb8 ]

[WHAT & HOW]
Functions dp_enable_link_phy and dp_disable_link_phy can pass link_res
without initializing hpo_dp_link_enc and it is necessary to check for
null before dereferencing.

This fixes 2 FORWARD_NULL issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Signed-off-by: Jerry Zuo <jerry.zuo@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Minor context change fixed. ]
Signed-off-by: Alva Lan <alvalan9@foxmail.com>
---
 drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
index 153a88381f2c..fd9809b17882 100644
--- a/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_hwss_hpo_dp.c
@@ -29,6 +29,8 @@
 #include "dc_link_dp.h"
 #include "clk_mgr.h"

+#define DC_LOGGER link->ctx->logger
+
 static enum phyd32clk_clock_source get_phyd32clk_src(struct dc_link *link)
 {
 	switch (link->link_enc->transmitter) {
@@ -224,6 +226,11 @@ static void disable_hpo_dp_link_output(struct dc_link *link,
 		const struct link_resource *link_res,
 		enum signal_type signal)
 {
+	if (!link_res->hpo_dp_link_enc) {
+		DC_LOG_ERROR("%s: invalid hpo_dp_link_enc\n", __func__);
+		return;
+	}
+
 	if (IS_FPGA_MAXIMUS_DC(link->dc->ctx->dce_environment)) {
 		disable_hpo_dp_fpga_link_output(link, link_res, signal);
 	} else {
--
2.34.1


