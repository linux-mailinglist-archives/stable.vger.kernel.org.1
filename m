Return-Path: <stable+bounces-91487-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E8549BEE36
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 14:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 267A31F23ED5
	for <lists+stable@lfdr.de>; Wed,  6 Nov 2024 13:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA5A91DED7C;
	Wed,  6 Nov 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FmMqMqFv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A161DF97A;
	Wed,  6 Nov 2024 13:14:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730898876; cv=none; b=ATKTxAsi2sIlldhLMoLWdmAWnoKzIlBOpVrfhXDApx1ThhG4z8MtedMNyLMfHjhC6pAIJttEiGOEHOUuP9qDh2eT3/lId5DGsUQnqZRphYTCgv8YNRpKv4Dmz8whX/m7UgbktHewxAe6lBl794ONJLYpQQHNdnK4yqurF9FDy0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730898876; c=relaxed/simple;
	bh=NY5k51ihubFHMu9jBu+nFocit6tYoqVnA3JLhBzvVxo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Gkd0p7hkqiGv0P0gOJ908ROthvhCJRbogZsMirSs8j+5N5GSV5w0xiemrjO93TWAOs8DttsSMfYwBJ09XVEFlNRFUYasMo6Py8l3NBbW3jBX7q8yfFQ9fVIXVfaSdBgpIZRyRj7qts/HFDDKdyP4iVbWOiZP7SW+s3h2dAunsYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FmMqMqFv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F15B8C4CECD;
	Wed,  6 Nov 2024 13:14:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1730898876;
	bh=NY5k51ihubFHMu9jBu+nFocit6tYoqVnA3JLhBzvVxo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FmMqMqFvEUirMk61tW+a8GF+nQyNH18PzGo3H5EX0DskwJgIENvwS1VLFdzpW/4fL
	 FgAaOPYswObf2cj9OQt8QChaxe6cYS+jQAE4vkyIPBqrGOjwW8oVSD7MKxXPi/4tza
	 LihAegqO42eeuvKgEBOxOjVhIEWHA9LlRVJCAisg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Icenowy Zheng <uwu@icenowy.me>,
	stable <stable@kernel.org>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH 5.4 348/462] usb: storage: ignore bogus device raised by JieLi BR21 USB sound chip
Date: Wed,  6 Nov 2024 13:04:01 +0100
Message-ID: <20241106120340.122181231@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241106120331.497003148@linuxfoundation.org>
References: <20241106120331.497003148@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Icenowy Zheng <uwu@icenowy.me>

commit a6555cb1cb69db479d0760e392c175ba32426842 upstream.

JieLi tends to use SCSI via USB Mass Storage to implement their own
proprietary commands instead of implementing another USB interface.
Enumerating it as a generic mass storage device will lead to a Hardware
Error sense key get reported.

Ignore this bogus device to prevent appearing a unusable sdX device
file.

Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
Cc: stable <stable@kernel.org>
Acked-by: Alan Stern <stern@rowland.harvard.edu>
Link: https://lore.kernel.org/r/20241001083407.8336-1-uwu@icenowy.me
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/storage/unusual_devs.h |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/usb/storage/unusual_devs.h
+++ b/drivers/usb/storage/unusual_devs.h
@@ -2412,6 +2412,17 @@ UNUSUAL_DEV(  0xc251, 0x4003, 0x0100, 0x
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_NOT_LOCKABLE),
 
+/*
+ * Reported by Icenowy Zheng <uwu@icenowy.me>
+ * This is an interface for vendor-specific cryptic commands instead
+ * of real USB storage device.
+ */
+UNUSUAL_DEV(  0xe5b7, 0x0811, 0x0100, 0x0100,
+		"ZhuHai JieLi Technology",
+		"JieLi BR21",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_IGNORE_DEVICE),
+
 /* Reported by Andrew Simmons <andrew.simmons@gmail.com> */
 UNUSUAL_DEV(  0xed06, 0x4500, 0x0001, 0x0001,
 		"DataStor",



