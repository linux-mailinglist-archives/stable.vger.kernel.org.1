Return-Path: <stable+bounces-83615-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B09299B914
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 12:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C673A281C28
	for <lists+stable@lfdr.de>; Sun, 13 Oct 2024 10:42:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D92B813D245;
	Sun, 13 Oct 2024 10:42:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FHxpn/LF"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0ED61DA32;
	Sun, 13 Oct 2024 10:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728816161; cv=none; b=ahs2w0G5tY3nWwVGH+7jauoGr/txVviqvdQ02Ei7aRYPJzo8ipgLR9Cj9ERmq/ZQR+wxecGmQIEAqWb0uCP3z/HF+p4NaDTbdeDM/PTIMMYV00YDJmOKY3M+vHDjX8xOqksqNEYN7ywEHS1/8Hw6qavHe1gvslD2T97U7dWqCYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728816161; c=relaxed/simple;
	bh=RvVa1Hdz0npBvLce7iPzTIjWN+LlLgRw3t8ryHuP8Y4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=Ts0PvVF/Lx+EA5MKIFW4DU6oseMd0835T9Km77rf6s6xMBSC5DqzthQFoclRgI97h0BLOAiVz/PciQ4fT/lJSXeJ9lFM5GbWMVnUJkduOxrs0Dtq2TGxsAMJ5otEA5Ypih1dLCUGO6xk8pssZeFr2vmjdFtIkXSheauZINKoV1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FHxpn/LF; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4311ae6426aso20051805e9.2;
        Sun, 13 Oct 2024 03:42:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728816158; x=1729420958; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=sI0NVFrf3pRuZLAIx9mivd2k+klWW713Wqz1uXcf1I4=;
        b=FHxpn/LFzgBCWSnwxkY8xajU/HrLqfe0JCYqI7iFE5/StuiIgeaJ4iutZZEDUFs2in
         Kj+I2VWmzE6GxMme5DRHAI5FJ0zYLIGwc3q3MzPL7gRxxAPGltFS+K+SSt8ZRbEqT9zL
         LfRf9F3pE2O1gS/680k/6/1k/JKlZ4+EwdLmnU7unglyoqoV006LaNq9jQtvOHX3ye13
         ttxMRWaEMHAzAn/o46NBmv7Dz4zytzh1DNI+QKKh3idGXFhUI681bkScR+xf7Zd3lbBL
         LIBBxC8vJdDLZ1LpOkH26pBYHMUDGZroQ+RepaG9dqlQqdGVaksKuHiPLLrMHz8Uo57V
         T5Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728816158; x=1729420958;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=sI0NVFrf3pRuZLAIx9mivd2k+klWW713Wqz1uXcf1I4=;
        b=EftfhZWyzD7qxIMTy6M2QpY95C4oqzW10gEKcCLOxcFuoWMRbsTsNB1TJ9efh3nC81
         72p1ziwQWokj4IACP2FBFldu/Ak/2kgDclWmQOTg/+X7Hu5AeXgzpB8FNR/G77CPRKzC
         0z8XlE6Zp0z8CgtHfSGR22ttzWoC4ycqxy6OTplwM59Sty5sNp07fTm7aoZRUI92MH9G
         zRWjtR0WQJZrcszChAzQAEGEPkq1e87V+94Mqzr/ZaNJuImczjJbF/1VtFgI/0AxrSOF
         AKm1zk5PVsTAOF24y0JV/1tKXazvXk6n8UsZ5kUeOy1qtbHbJqnHQj7AFFS/n3EWjyLv
         eAGA==
X-Forwarded-Encrypted: i=1; AJvYcCWMvV7CPx5+XbelaIfhTtr7kP/Q9CXP+eXKwHoJEdKQzm+PcktiajCV9BITDgC+3772Bs3VTyDo@vger.kernel.org, AJvYcCXb5SQx5lHCdKrgLZkcafbrdHyzF53i2lHwxdd6fJBAOMHhOmDrq525wvcpf0cvYKGpFEYZtr94Tj7LArc=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIKso5ZTkrU5NPQo2eWOwf/UU/yzfz6zlbrUcNhmj2H49xQotu
	PN4MBIaagFXMpooeAtw/Bwatn5DA4h5GbKRm6sT2Si4rlH56Go5f
X-Google-Smtp-Source: AGHT+IGufmCYtx1yjlM7P4W+1+XvlivxR/a4dbQTa29lFsAyi/NYHTq2CdMAlBpQXoURmLlJxn9+RA==
X-Received: by 2002:a05:600c:1f8c:b0:430:c3a5:652a with SMTP id 5b1f17b1804b1-4311ded53cbmr62215745e9.12.1728816157942;
        Sun, 13 Oct 2024 03:42:37 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-01f9-6cb5-d67b-9d29.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:1f9:6cb5:d67b:9d29])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-430d70b4462sm120913475e9.30.2024.10.13.03.42.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Oct 2024 03:42:36 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Sun, 13 Oct 2024 12:42:32 +0200
Subject: [PATCH] staging: vchiq_arm: Fix missing refcount decrement in
 error path for fw_node
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241013-vchiq_arm-of_node_put-v1-1-f72b2a6e47d0@gmail.com>
X-B4-Tracking: v=1; b=H4sIABekC2cC/x3MTQqAIBBA4avErBO0X+gqETLkWLNIS0uC6O5Jy
 2/x3gORAlOEoXggUOLI3mWosoB5RbeQYJMNlawaJVUt0rzyoTFswlvtvCG9X6foJLaEiNb0EnK
 7B7J8/99xet8P1l9UCWcAAAA=
To: Florian Fainelli <florian.fainelli@broadcom.com>, 
 Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Stefan Wahren <wahrenst@gmx.net>, Umang Jain <umang.jain@ideasonboard.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc: linux-rpi-kernel@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, linux-staging@lists.linux.dev, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728816154; l=2125;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=RvVa1Hdz0npBvLce7iPzTIjWN+LlLgRw3t8ryHuP8Y4=;
 b=dZJuhHm54XpgX1j7LLyPpshdmuzxcgLz23pgRbrWVZwDHB9bpO03XnysqoYVpQtJCGkni0cTr
 qRM3Pxgi1HIDmf8HV3buNwX3ZwQ1Q1xohQbNo14frQOy1FR4vcIeAH/
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

An error path was introduced without including the required call to
of_node_put() to decrement the node's refcount and avoid leaking memory.
If the call to kzalloc() for 'mgmt' fails, the probe returns without
decrementing the refcount.

Use the automatic cleanup facility to fix the bug and protect the code
against new error paths where the call to of_node_put() might be missing
again.

Cc: stable@vger.kernel.org
Fixes: 1c9e16b73166 ("staging: vc04_services: vchiq_arm: Split driver static and runtime data")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
index 27ceaac8f6cc..792cf3a807e1 100644
--- a/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
+++ b/drivers/staging/vc04_services/interface/vchiq_arm/vchiq_arm.c
@@ -1332,7 +1332,8 @@ MODULE_DEVICE_TABLE(of, vchiq_of_match);
 
 static int vchiq_probe(struct platform_device *pdev)
 {
-	struct device_node *fw_node;
+	struct device_node *fw_node __free(device_node) =
+		of_find_compatible_node(NULL, NULL, "raspberrypi,bcm2835-firmware");
 	const struct vchiq_platform_info *info;
 	struct vchiq_drv_mgmt *mgmt;
 	int ret;
@@ -1341,8 +1342,6 @@ static int vchiq_probe(struct platform_device *pdev)
 	if (!info)
 		return -EINVAL;
 
-	fw_node = of_find_compatible_node(NULL, NULL,
-					  "raspberrypi,bcm2835-firmware");
 	if (!fw_node) {
 		dev_err(&pdev->dev, "Missing firmware node\n");
 		return -ENOENT;
@@ -1353,7 +1352,6 @@ static int vchiq_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	mgmt->fw = devm_rpi_firmware_get(&pdev->dev, fw_node);
-	of_node_put(fw_node);
 	if (!mgmt->fw)
 		return -EPROBE_DEFER;
 

---
base-commit: d61a00525464bfc5fe92c6ad713350988e492b88
change-id: 20241013-vchiq_arm-of_node_put-60a5eaaafd70

Best regards,
-- 
Javier Carrasco <javier.carrasco.cruz@gmail.com>


