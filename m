Return-Path: <stable+bounces-3372-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C77D37FF54F
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:27:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 836E02816A3
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:27:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6C254FAE;
	Thu, 30 Nov 2023 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TWbHOi1L"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 480CB54F9C;
	Thu, 30 Nov 2023 16:27:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4E67C433CA;
	Thu, 30 Nov 2023 16:27:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701361665;
	bh=gzSdboy5AsHc2rCyr4lJ37CJtWFhIQV1+ABHZGbfyJY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=TWbHOi1LzNiuK6AJSLsTL59kO9wsLN4HmduyUacJr9vfDIoQe6m33UxFJ2jEvUO7p
	 pd9qA41pUsD1N91Vm8RW8H+rZyIquIcRVRyW3EITrh+ySDRfolk4winXgWuUcnNCIr
	 YBI9im2pK8gVW2SLU6cJfmi4+GYvUENlKf7oataI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Puliang Lu <puliang.lu@fibocom.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 6.6 104/112] USB: serial: option: fix FM101R-GL defines
Date: Thu, 30 Nov 2023 16:22:31 +0000
Message-ID: <20231130162143.590852509@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162140.298098091@linuxfoundation.org>
References: <20231130162140.298098091@linuxfoundation.org>
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

From: Puliang Lu <puliang.lu@fibocom.com>

commit a1092619dd28ac0fcf23016160a2fdccd98ef935 upstream.

Modify the definition of the two Fibocom FM101R-GL PID macros, which had
their PIDs switched.

The correct PIDs are:

- VID:PID 413C:8213, FM101R-GL ESIM are laptop M.2 cards (with
  MBIM interfaces for Linux)

- VID:PID 413C:8215, FM101R-GL are laptop M.2 cards (with
  MBIM interface for Linux)

0x8213: mbim, tty
0x8215: mbim, tty

Signed-off-by: Puliang Lu <puliang.lu@fibocom.com>
Fixes: 52480e1f1a25 ("USB: serial: option: add Fibocom to DELL custom modem FM101R-GL")
Link: https://lore.kernel.org/lkml/TYZPR02MB508845BAD7936A62A105CE5D89DFA@TYZPR02MB5088.apcprd02.prod.outlook.com/
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/serial/option.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/usb/serial/option.c
+++ b/drivers/usb/serial/option.c
@@ -203,8 +203,8 @@ static void option_instat_callback(struc
 #define DELL_PRODUCT_5829E_ESIM			0x81e4
 #define DELL_PRODUCT_5829E			0x81e6
 
-#define DELL_PRODUCT_FM101R			0x8213
-#define DELL_PRODUCT_FM101R_ESIM		0x8215
+#define DELL_PRODUCT_FM101R_ESIM		0x8213
+#define DELL_PRODUCT_FM101R			0x8215
 
 #define KYOCERA_VENDOR_ID			0x0c88
 #define KYOCERA_PRODUCT_KPC650			0x17da



