Return-Path: <stable+bounces-22734-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5025D85DD89
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 15:06:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB6C0B22B0F
	for <lists+stable@lfdr.de>; Wed, 21 Feb 2024 14:06:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADCBA7E781;
	Wed, 21 Feb 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BX0VThhq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AF227C6C0;
	Wed, 21 Feb 2024 14:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708524339; cv=none; b=gY3itDBJnah/+FieBeKHMQ6sTDfnRbyFpjZFjk8m6oIdJqxrJU7nbIAje26BrXj8ScddAhSmM54vFdneah5NVkmtD/quxekkz3ZPQIAS4YF17brxyB0wHYRy0YdbRpcF0bDdRanJfjkafAPpGEHROMywxkQFwGpTk3udlyQqUP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708524339; c=relaxed/simple;
	bh=lTfYrVFa9cjeJh+ifkvMMY14avtn36kvlRafsO3Av4E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qJoe+6l+JFUHau1Fwom9VAhellM/CVqT/UTrNXyeLGycEgD0DQHrPO66JlX41PVF7gxAEWML+BwtqB9sOIYn1Wycj7GzbhDB/kql9kZvnLbzYpiOWBUuJ0yoy8azZGd6zU5k06ACiBsrHoEBhiCrj+IrxfFqkwooVpsUo5X7pkk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BX0VThhq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD3D9C433F1;
	Wed, 21 Feb 2024 14:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708524339;
	bh=lTfYrVFa9cjeJh+ifkvMMY14avtn36kvlRafsO3Av4E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BX0VThhqTQZAVRid/x1l1o4UOXtLRzcrwGuVNLafFnzQRXZLjLetwXs3BQuPmGB8t
	 FWAF8Gew+9Q+dQFK/lMBtm7XLxS2hIwm8n2WoUhTUdtT1tnlyaOh0phA+DVswiOUmg
	 wdmSfDUMTPfW/uPQ7DW9mnKwlWG1UTPBt3VkAR2Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hans de Goede <hdegoede@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 213/379] misc: lis3lv02d_i2c: Add missing setting of the reg_ctrl callback
Date: Wed, 21 Feb 2024 14:06:32 +0100
Message-ID: <20240221130001.205668819@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240221125954.917878865@linuxfoundation.org>
References: <20240221125954.917878865@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

[ Upstream commit b1b9f7a494400c0c39f8cd83de3aaa6111c55087 ]

The lis3lv02d_i2c driver was missing a line to set the lis3_dev's
reg_ctrl callback.

lis3_reg_ctrl(on) is called from the init callback, but due to
the missing reg_ctrl callback the regulators where never turned off
again leading to the following oops/backtrace when detaching the driver:

[   82.313527] ------------[ cut here ]------------
[   82.313546] WARNING: CPU: 1 PID: 1724 at drivers/regulator/core.c:2396 _regulator_put+0x219/0x230
...
[   82.313695] RIP: 0010:_regulator_put+0x219/0x230
...
[   82.314767] Call Trace:
[   82.314770]  <TASK>
[   82.314772]  ? _regulator_put+0x219/0x230
[   82.314777]  ? __warn+0x81/0x170
[   82.314784]  ? _regulator_put+0x219/0x230
[   82.314791]  ? report_bug+0x18d/0x1c0
[   82.314801]  ? handle_bug+0x3c/0x80
[   82.314806]  ? exc_invalid_op+0x13/0x60
[   82.314812]  ? asm_exc_invalid_op+0x16/0x20
[   82.314845]  ? _regulator_put+0x219/0x230
[   82.314857]  regulator_bulk_free+0x39/0x60
[   82.314865]  i2c_device_remove+0x22/0xb0

Add the missing setting of the callback so that the regulators
properly get turned off again when not used.

Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20231224183402.95640-1-hdegoede@redhat.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/misc/lis3lv02d/lis3lv02d_i2c.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
index 52555d2e824b..ab1db760ba4e 100644
--- a/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
+++ b/drivers/misc/lis3lv02d/lis3lv02d_i2c.c
@@ -151,6 +151,7 @@ static int lis3lv02d_i2c_probe(struct i2c_client *client,
 	lis3_dev.init	  = lis3_i2c_init;
 	lis3_dev.read	  = lis3_i2c_read;
 	lis3_dev.write	  = lis3_i2c_write;
+	lis3_dev.reg_ctrl = lis3_reg_ctrl;
 	lis3_dev.irq	  = client->irq;
 	lis3_dev.ac	  = lis3lv02d_axis_map;
 	lis3_dev.pm_dev	  = &client->dev;
-- 
2.43.0




