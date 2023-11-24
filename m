Return-Path: <stable+bounces-1870-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFBE27F81C0
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 20:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 54AAC1F20FCE
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A50B4364A7;
	Fri, 24 Nov 2023 19:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Bdo0vlqL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6498833E9;
	Fri, 24 Nov 2023 19:01:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E702BC433C8;
	Fri, 24 Nov 2023 19:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700852476;
	bh=vExmVEul3Fp28VrZt6Tzzxz44NhIezXC/NTmN4z30J0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Bdo0vlqLwAhqYDfVU9sjTH/oN6Lkqp1iLff7ZItBs5q8iIOeHPB0x1NoN6v0COoBo
	 yQ+12WlM9nZXw2bLWCYLP+V4Kurtt40AOv8754MYoMStdjTqjtIaksmSswdaeAbHak
	 vztmOXTGa/E+1PGqVDHfXjy9kgsnEzL0Oq26JZB8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Vicki Pfau <vi@endrift.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 6.1 371/372] Input: xpad - add VID for Turtle Beach controllers
Date: Fri, 24 Nov 2023 17:52:38 +0000
Message-ID: <20231124172022.620916744@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172010.413667921@linuxfoundation.org>
References: <20231124172010.413667921@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vicki Pfau <vi@endrift.com>

commit 1999a6b12a3b5c8953fc9ec74863ebc75a1b851d upstream.

This adds support for the Turtle Beach REACT-R and Recon Xbox controllers

Signed-off-by: Vicki Pfau <vi@endrift.com>
Link: https://lore.kernel.org/r/20230225012147.276489-4-vi@endrift.com
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/joystick/xpad.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/joystick/xpad.c
+++ b/drivers/input/joystick/xpad.c
@@ -474,6 +474,7 @@ static const struct usb_device_id xpad_t
 	XPAD_XBOX360_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOXONE_VENDOR(0x0f0d),		/* Hori Controllers */
 	XPAD_XBOX360_VENDOR(0x1038),		/* SteelSeries Controllers */
+	XPAD_XBOXONE_VENDOR(0x10f5),		/* Turtle Beach Controllers */
 	XPAD_XBOX360_VENDOR(0x11c9),		/* Nacon GC100XF */
 	XPAD_XBOX360_VENDOR(0x11ff),		/* PXN V900 */
 	XPAD_XBOX360_VENDOR(0x1209),		/* Ardwiino Controllers */



