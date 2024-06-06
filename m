Return-Path: <stable+bounces-49884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B578FEF40
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 16:49:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3E0B6288B54
	for <lists+stable@lfdr.de>; Thu,  6 Jun 2024 14:49:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4A0F41CB337;
	Thu,  6 Jun 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nDTm4XqQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 094861A255F;
	Thu,  6 Jun 2024 14:22:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717683759; cv=none; b=jUf0YRNOzvsmCp/K67LKSZboisB+UH5EejijVBgRbMLVn/BxM9EtcZ4+ZH8E5uTGrfq86IVSMp45rj/sIDLt7Jbd58+6VH76VN3cd5Uyb/JpFrMoDdfPAIBOGhicukBtZAkvf3RWqwz5erfZb56VLkA1a7zAYrujKCyfI2JVZJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717683759; c=relaxed/simple;
	bh=/QXmgZ6vH7q0BfH/jve9wuqyvekLHpqVMTM82IZNl/E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOduxfC4kqFdOsvPXdx8BmhSu6xgySyMD5BLXlxCKx9MfyV0bn7uO+jcR3s4E4d9OsUgQ7z9pSDJoSxTwUaqVGLejOldrrhAWpuahWbWEA42xF1xacHDvWvttkAKAzNz2gMkoCYth8wi1ebUjFHlstYZ+U6CK0koWDqMeCLgQxI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nDTm4XqQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D8B6BC2BD10;
	Thu,  6 Jun 2024 14:22:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1717683758;
	bh=/QXmgZ6vH7q0BfH/jve9wuqyvekLHpqVMTM82IZNl/E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nDTm4XqQCbTPgZX8HOO3ZTpilmGWfeM/QdGOxG2CB8m07h1QvBikQtayx98hSYN6e
	 3oX8AzZamEp4yTxgAwUvOfqg5y4BlcPG55EnYcbICWXs5Epb4+NRF159+0r88InwOC
	 KlrA0ab+I6XKA83SbNYzpPPXUG5iKGlu58P4yhZ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chris Ruehl <chris.ruehl@gtsys.com.hk>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 734/744] hwmon: (shtc1) Fix property misspelling
Date: Thu,  6 Jun 2024 16:06:46 +0200
Message-ID: <20240606131756.005720028@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240606131732.440653204@linuxfoundation.org>
References: <20240606131732.440653204@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Guenter Roeck <linux@roeck-us.net>

[ Upstream commit 52a2c70c3ec555e670a34dd1ab958986451d2dd2 ]

The property name is "sensirion,low-precision", not
"sensicon,low-precision".

Cc: Chris Ruehl <chris.ruehl@gtsys.com.hk>
Fixes: be7373b60df5 ("hwmon: shtc1: add support for device tree bindings")
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/shtc1.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/shtc1.c b/drivers/hwmon/shtc1.c
index 1f96e94967ee8..439dd3dba5fc8 100644
--- a/drivers/hwmon/shtc1.c
+++ b/drivers/hwmon/shtc1.c
@@ -238,7 +238,7 @@ static int shtc1_probe(struct i2c_client *client)
 
 	if (np) {
 		data->setup.blocking_io = of_property_read_bool(np, "sensirion,blocking-io");
-		data->setup.high_precision = !of_property_read_bool(np, "sensicon,low-precision");
+		data->setup.high_precision = !of_property_read_bool(np, "sensirion,low-precision");
 	} else {
 		if (client->dev.platform_data)
 			data->setup = *(struct shtc1_platform_data *)dev->platform_data;
-- 
2.43.0




