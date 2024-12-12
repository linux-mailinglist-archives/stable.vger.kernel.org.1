Return-Path: <stable+bounces-101589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B9059EED5B
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:45:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F238164E7E
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 15:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5C73222D59;
	Thu, 12 Dec 2024 15:41:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bm.lauterbach.com (bm.lauterbach.com [62.154.241.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 741F6215799;
	Thu, 12 Dec 2024 15:41:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=62.154.241.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734018092; cv=none; b=OH5IywKBMZTQXPbOnknmXnXyCJ38CSn1EoYL4GgIBe4WRxo6QiGszt/cD0FtGqRYi3lb3dsSFT+h0ObwOwpW42VnW09sSv0VNhMem5Fg+tIrqEnvaJBHsRAmyR2S/13h/UkiGgqNINpASRRvowU+7Q95ZKwtN/yPBY9rj8CnUt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734018092; c=relaxed/simple;
	bh=4niNNU3UJmwI8sRI+2DvCo+K56fl99MNZJH1e6dbsnQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nNmXQohpS7kecCPp0tAUx01vL5NkPs55HCG4P0riHiyvtjRFgISZ4MliS7gPxUWPaDqxXj2FcaeMAf02zXgX83HaJZEc3lPe/WdXWVgXhhmmCm+RNU23hoQ5XKPBEcKpUDJ7Cz0C2GCF9zn8TBtryt1bI3XpOuCMV8j8txFT4Sw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lauterbach.com; spf=pass smtp.mailfrom=lauterbach.com; arc=none smtp.client-ip=62.154.241.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lauterbach.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lauterbach.com
Received: from ingpc2.intern.lauterbach.com (unknown [10.2.10.44])
	(Authenticated sender: ingo.rohloff@lauterbach.com)
	by bm.lauterbach.com (Postfix) with ESMTPSA id 02A46D349880;
	Thu, 12 Dec 2024 16:41:25 +0100 (CET)
From: Ingo Rohloff <ingo.rohloff@lauterbach.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	Ingo Rohloff <ingo.rohloff@lauterbach.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] usb: gadget: configfs: Ignore trailing LF for user strings to cdev
Date: Thu, 12 Dec 2024 16:41:14 +0100
Message-ID: <20241212154114.29295-1-ingo.rohloff@lauterbach.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Bm-Milter-Handled: 166a2dfb-2e12-4590-8fa5-72e30323519f
X-Bm-Transport-Timestamp: 1734018085056

Since commit c033563220e0f7a8
("usb: gadget: configfs: Attach arbitrary strings to cdev")
a user can provide extra string descriptors to a USB gadget via configfs.

For "manufacturer", "product", "serialnumber", setting the string via
configfs ignores a trailing LF.

For the arbitrary strings the LF was not ignored.

This patch ignores a trailing LF to make this consistent with the existing
behavior for "manufacturer", ...  string descriptors.

Fixes: c033563220e0 ("usb: gadget: configfs: Attach arbitrary strings to cdev")
Cc: stable@vger.kernel.org
Signed-off-by: Ingo Rohloff <ingo.rohloff@lauterbach.com>
---
 drivers/usb/gadget/configfs.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/configfs.c b/drivers/usb/gadget/configfs.c
index 6499a88d346c..fba2a56dae97 100644
--- a/drivers/usb/gadget/configfs.c
+++ b/drivers/usb/gadget/configfs.c
@@ -827,11 +827,15 @@ static ssize_t gadget_string_s_store(struct config_item *item, const char *page,
 {
 	struct gadget_string *string = to_gadget_string(item);
 	int size = min(sizeof(string->string), len + 1);
+	ssize_t cpy_len;
 
 	if (len > USB_MAX_STRING_LEN)
 		return -EINVAL;
 
-	return strscpy(string->string, page, size);
+	cpy_len = strscpy(string->string, page, size);
+	if (cpy_len > 0 && string->string[cpy_len - 1] == '\n')
+		string->string[cpy_len - 1] = 0;
+	return len;
 }
 CONFIGFS_ATTR(gadget_string_, s);
 
-- 
2.47.1


