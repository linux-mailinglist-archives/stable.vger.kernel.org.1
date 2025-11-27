Return-Path: <stable+bounces-197349-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B817C8F01F
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:01:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 37E243435EB
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:00:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED50332900;
	Thu, 27 Nov 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="InDXWF7Q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A6A028D8E8;
	Thu, 27 Nov 2025 14:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255564; cv=none; b=TNcMr2fqDT4xbKYzs+XnvH3Yi4ePxbxifd8MKRa1TGV+51yH0kBmV9TZGaM3e6ogiTAU5WctwUv/ABv/U/h1mC1WiGJIyElkyB6YDY0/cdV8fy6zUTIlBYMrKAs46CuoYaQI2dugUAcs8Z2piRdAZaQIJKJ0bCWFRsxYkDHl1x0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255564; c=relaxed/simple;
	bh=MCeXiwiuUxobnp32jtEFsi0qaTBF3ky/xmvUygULTYM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nh2o4fJhkImuXO2IlCrvYFCaoVyIwLyqX28AkKiuHQrmlIL11VVUKQRaqgS1OfFY4lFLbYEDcnuo+dgMwYf6s9vDom7hrtCZa6M/yUBTv4/FKokgt+JTZLAGxVR46Fzdd3jEG5xdLOXFpqLGy/B/CQU/m8+rog0bPfABcyEjWAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=InDXWF7Q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83148C4CEF8;
	Thu, 27 Nov 2025 14:59:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255563;
	bh=MCeXiwiuUxobnp32jtEFsi0qaTBF3ky/xmvUygULTYM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=InDXWF7Q1afJlkCb85KXWBGZTwmJKaY0vF6MAXTaOHoHRyUjcxV03vI6Y8BHS03kd
	 KZZfxnxnTbNDYru5qD3rMX+9gp7s42WMgyggYer/zGyzdL9HncIRHi+yoa3yavEBZj
	 +Ca8g9QEQZSYom9rUoBPcDB1byRs22D6wJ0NWnTY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Weikang Guo <guoweikang.kernel@gmail.com>,
	Hans de Goede <hdegoede@redhat.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.17 037/175] Input: goodix - add support for ACPI ID GDIX1003
Date: Thu, 27 Nov 2025 15:44:50 +0100
Message-ID: <20251127144044.320021826@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144042.945669935@linuxfoundation.org>
References: <20251127144042.945669935@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hans de Goede <hdegoede@redhat.com>

commit c6d99e488117201c63efd747ce17b80687c3f5a9 upstream.

Some newer devices use an ACPI hardware ID of GDIX1003 for their Goodix
touchscreen controller, instead of GDIX1001 / GDIX1002. Add GDIX1003
to the goodix_acpi_match[] table.

Reported-by: Weikang Guo <guoweikang.kernel@gmail.com>
Closes: https://lore.kernel.org/linux-input/20250225024409.1467040-1-guoweikang.kernel@gmail.com/
Tested-by: Weikang Guo <guoweikang.kernel@gmail.com>
Signed-off-by: Hans de Goede <hdegoede@redhat.com>
Link: https://lore.kernel.org/r/20251013121022.44333-1-hansg@kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/touchscreen/goodix.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/touchscreen/goodix.c
+++ b/drivers/input/touchscreen/goodix.c
@@ -1557,6 +1557,7 @@ MODULE_DEVICE_TABLE(i2c, goodix_ts_id);
 static const struct acpi_device_id goodix_acpi_match[] = {
 	{ "GDIX1001", 0 },
 	{ "GDIX1002", 0 },
+	{ "GDIX1003", 0 },
 	{ "GDX9110", 0 },
 	{ }
 };



