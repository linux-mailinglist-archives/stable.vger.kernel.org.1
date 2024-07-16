Return-Path: <stable+bounces-59852-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01B0F932C1C
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:52:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2FB921C23189
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:52:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A566619F469;
	Tue, 16 Jul 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y8z83H2D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B2F519F46C;
	Tue, 16 Jul 2024 15:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721145103; cv=none; b=PQO7abO94uxxoYK8uuqJKEJd/38r9FQ0M8gwabrTEXWAiDXv+aowaWih7eL5bCZ/UXSk1hRPLvJpCsTB0+u+itdD1EOsnDvlyG2zAoq1Xzwsjwxq9OlK1JBZi9QVxFRas40McIQOLFQWZGAfnLEIOZUfMc2BzyIrTXGVdgItM+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721145103; c=relaxed/simple;
	bh=zsWObvqZoPupaU+wSgjR8EZ4yPA6D5zwj7zXGP5D6DI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ICycegoJAOG8WH/SvKyLBQgpAY/qcHs/jIVZl6QJAUva/ySCA1EFbAcIYHFoaG6+rHsjwdEc0VhgyWe0kaEinTYfv3EF96yxvKweP7XnIJD7mQiP2KPhcuTklaFxcyoXgu0hjQa7jBWsVgNKo2ASSyTh0t7BC7xAVS0riQfwHmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y8z83H2D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5BFCC116B1;
	Tue, 16 Jul 2024 15:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721145103;
	bh=zsWObvqZoPupaU+wSgjR8EZ4yPA6D5zwj7zXGP5D6DI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y8z83H2DbBbLYDTxhoF+44V249P7da5Axoz83ZeWw2fLCBfN179PW0+D5/ivtMyiP
	 1N5AWDl6gXjnEUM1xcL7o8ho+swzsiqRVRYhljCm8oAiTA0SXJa+L5eI8HieNPdJMK
	 xYWvYTcK1BruHWRbDL2xrLtkOwaDJpZRbzgxt28E=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Joy Chakraborty <joychakr@google.com>,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6.9 100/143] nvmem: meson-efuse: Fix return value of nvmem callbacks
Date: Tue, 16 Jul 2024 17:31:36 +0200
Message-ID: <20240716152759.824679105@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152755.980289992@linuxfoundation.org>
References: <20240716152755.980289992@linuxfoundation.org>
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

6.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Joy Chakraborty <joychakr@google.com>

commit 7a0a6d0a7c805f9380381f4deedffdf87b93f408 upstream.

Read/write callbacks registered with nvmem core expect 0 to be returned
on success and a negative value to be returned on failure.

meson_efuse_read() and meson_efuse_write() call into
meson_sm_call_read() and meson_sm_call_write() respectively which return
the number of bytes read or written on success as per their api
description.

Fix to return error if meson_sm_call_read()/meson_sm_call_write()
returns an error else return 0.

Fixes: a29a63bdaf6f ("nvmem: meson-efuse: simplify read callback")
Cc: stable@vger.kernel.org
Signed-off-by: Joy Chakraborty <joychakr@google.com>
Reviewed-by: Dan Carpenter <dan.carpenter@linaro.org>
Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Link: https://lore.kernel.org/r/20240628113704.13742-3-srinivas.kandagatla@linaro.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvmem/meson-efuse.c |   14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

--- a/drivers/nvmem/meson-efuse.c
+++ b/drivers/nvmem/meson-efuse.c
@@ -18,18 +18,24 @@ static int meson_efuse_read(void *contex
 			    void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
 
-	return meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
-				  bytes, 0, 0, 0);
+	ret = meson_sm_call_read(fw, (u8 *)val, bytes, SM_EFUSE_READ, offset,
+				 bytes, 0, 0, 0);
+
+	return ret < 0 ? ret : 0;
 }
 
 static int meson_efuse_write(void *context, unsigned int offset,
 			     void *val, size_t bytes)
 {
 	struct meson_sm_firmware *fw = context;
+	int ret;
+
+	ret = meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
+				  bytes, 0, 0, 0);
 
-	return meson_sm_call_write(fw, (u8 *)val, bytes, SM_EFUSE_WRITE, offset,
-				   bytes, 0, 0, 0);
+	return ret < 0 ? ret : 0;
 }
 
 static const struct of_device_id meson_efuse_match[] = {



