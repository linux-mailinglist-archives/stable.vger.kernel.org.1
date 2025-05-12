Return-Path: <stable+bounces-143760-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1379FAB4132
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:03:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 385B1188B0CA
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E8D51DF754;
	Mon, 12 May 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bb5yti7n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B26B175BF;
	Mon, 12 May 2025 18:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072990; cv=none; b=FnqO2P2VMpeapvPUctJIeYeBE6I1qU5YcDfQoauFt3P//AmQWOnsn7+7b6esESsBCODwfGlfl9xPZrPUPG7XoVM8MR1/UfwOivcQPZ21Wj//HAohwf6X6UXp2ufPea1SSrcpMh8sNOPv/fiPErj4InolbLZYmeo6up5bz9D8L8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072990; c=relaxed/simple;
	bh=r4TOCgKKQTdtcHIHea+yNNGJCkPgF0EE2g3UdTxBWjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mcUcKSykrcpDK/e7gygwKUlEo8m15qxuqBvtohA9DeC1yNp6dT5/qFco5wMUZiDQC5NUKeDm63SGq49EShSS3lZZ8K0DXQzKwHVxOug+VxLFwee+FtSCdvfz98cka+QGudyYvLZ6HC3gVRxIIafP9gwCAQ0kN2qUhD2su6FBcqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bb5yti7n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B707C4CEE7;
	Mon, 12 May 2025 18:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072990;
	bh=r4TOCgKKQTdtcHIHea+yNNGJCkPgF0EE2g3UdTxBWjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bb5yti7nR9VDVch3sBMeXv5qwmSu8ZzdbGnEX1i9jWR9MYF9iAEFI8X3IR1eUfjV3
	 RNar/SHFtcxTjhdp/1nJmD93bif3yxfJjJDrih4AnqZL1wyvYDbQ4X74d8Yg0qexGd
	 JDslrzUeoaEDq+JQmjbmBqxWStTzgiTEce2Qcoeo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Prashanth K <prashanth.k@oss.qualcomm.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.12 119/184] usb: gadget: f_ecm: Add get_status callback
Date: Mon, 12 May 2025 19:45:20 +0200
Message-ID: <20250512172046.670073479@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172041.624042835@linuxfoundation.org>
References: <20250512172041.624042835@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Prashanth K <prashanth.k@oss.qualcomm.com>

commit 8e3820271c517ceb89ab7442656ba49fa23ee1d0 upstream.

When host sends GET_STATUS to ECM interface, handle the request
from the function driver. Since the interface is wakeup capable,
set the corresponding bit, and set RW bit if the function is
already armed for wakeup by the host.

Cc: stable <stable@kernel.org>
Fixes: 481c225c4802 ("usb: gadget: Handle function suspend feature selector")
Signed-off-by: Prashanth K <prashanth.k@oss.qualcomm.com>
Reviewed-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20250422103231.1954387-2-prashanth.k@oss.qualcomm.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/function/f_ecm.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/usb/gadget/function/f_ecm.c
+++ b/drivers/usb/gadget/function/f_ecm.c
@@ -892,6 +892,12 @@ static void ecm_resume(struct usb_functi
 	gether_resume(&ecm->port);
 }
 
+static int ecm_get_status(struct usb_function *f)
+{
+	return (f->func_wakeup_armed ? USB_INTRF_STAT_FUNC_RW : 0) |
+		USB_INTRF_STAT_FUNC_RW_CAP;
+}
+
 static void ecm_free(struct usb_function *f)
 {
 	struct f_ecm *ecm;
@@ -960,6 +966,7 @@ static struct usb_function *ecm_alloc(st
 	ecm->port.func.disable = ecm_disable;
 	ecm->port.func.free_func = ecm_free;
 	ecm->port.func.suspend = ecm_suspend;
+	ecm->port.func.get_status = ecm_get_status;
 	ecm->port.func.resume = ecm_resume;
 
 	return &ecm->port.func;



