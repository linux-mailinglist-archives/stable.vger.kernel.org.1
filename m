Return-Path: <stable+bounces-3753-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E8C91802426
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 14:19:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755541F21137
	for <lists+stable@lfdr.de>; Sun,  3 Dec 2023 13:19:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85549EED5;
	Sun,  3 Dec 2023 13:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="d2DirNcN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 478E7C8CB
	for <stable@vger.kernel.org>; Sun,  3 Dec 2023 13:18:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67FDAC433C9;
	Sun,  3 Dec 2023 13:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701609536;
	bh=aAbT61qFXorqa5pgP35iLKr4xbQrrCQgjS7S3mJAoPg=;
	h=Subject:To:Cc:From:Date:From;
	b=d2DirNcNyqfKk0lQ/Ci+lOmB6gcJGJzLpVBwlYC2QiSMp+5G/YJ4i274PeWwIxN2W
	 tek1W37ZqeUXjCcrmi147aua1T/sZ2wjcK71mOKmTUff6BBCZZg0cJmlL4xl4+0JO+
	 YhVAV80yBhBkuYj3L73zVxJF1Y/jEOvfj2INFxJc=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Update EEPROM I2C address for smu v13_0_0" failed to apply to 6.1-stable tree
To: candice.li@amd.com,Hawking.Zhang@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sun, 03 Dec 2023 14:18:52 +0100
Message-ID: <2023120351-refinish-obtuse-e77f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e0409021e34af50e7b6f31635c8d21583d7c43dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023120351-refinish-obtuse-e77f@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

e0409021e34a ("drm/amdgpu: Update EEPROM I2C address for smu v13_0_0")
b81fde0dfe40 ("drm/amdgpu: Add I2C EEPROM support on smu v13_0_6")
6246059a19d4 ("drm/amdgpu: simplify amdgpu_ras_eeprom.c")
8782007b5f57 ("drm/amdgpu: Return from switch early for EEPROM I2C address")
1bb745d7596d ("drm/amdgpu: Remove second moot switch to set EEPROM I2C address")
64a3dbb06ad8 ("drm/amdgpu: Add support for RAS table at 0x40000")
3b8164f8084f ("drm/amdgpu: Decouple RAS EEPROM addresses from chips")
da858deab88e ("drm/amdgpu: Remove redundant I2C EEPROM address")
c9bdc6c3cf39 ("drm/amdgpu: Add EEPROM I2C address support for ip discovery")
bc22f8ec464a ("drm/amdgpu: Update ras eeprom support for smu v13_0_0 and v13_0_10")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e0409021e34af50e7b6f31635c8d21583d7c43dd Mon Sep 17 00:00:00 2001
From: Candice Li <candice.li@amd.com>
Date: Fri, 24 Nov 2023 09:33:47 +0800
Subject: [PATCH] drm/amdgpu: Update EEPROM I2C address for smu v13_0_0

Check smu v13_0_0 SKU type to select EEPROM I2C address.

Signed-off-by: Candice Li <candice.li@amd.com>
Reviewed-by: Hawking Zhang <Hawking.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org # 6.1.x

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
index 65aa218380be..2fde93b00cab 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ras_eeprom.c
@@ -214,6 +214,12 @@ static bool __get_eeprom_i2c_addr(struct amdgpu_device *adev,
 			control->i2c_address = EEPROM_I2C_MADDR_0;
 		return true;
 	case IP_VERSION(13, 0, 0):
+		if (strnstr(atom_ctx->vbios_pn, "D707",
+			    sizeof(atom_ctx->vbios_pn)))
+			control->i2c_address = EEPROM_I2C_MADDR_0;
+		else
+			control->i2c_address = EEPROM_I2C_MADDR_4;
+		return true;
 	case IP_VERSION(13, 0, 6):
 	case IP_VERSION(13, 0, 10):
 		control->i2c_address = EEPROM_I2C_MADDR_4;


