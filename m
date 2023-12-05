Return-Path: <stable+bounces-4410-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A25A280475D
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 04:37:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5978B1F21474
	for <lists+stable@lfdr.de>; Tue,  5 Dec 2023 03:37:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF8228BF1;
	Tue,  5 Dec 2023 03:37:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="IH9FXu4D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E6816FB1;
	Tue,  5 Dec 2023 03:37:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D04AC433C9;
	Tue,  5 Dec 2023 03:37:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701747469;
	bh=pKw8AhDN84ROstUDiO8ZRlGuAHd6v8T4JUVD7q3/ERc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IH9FXu4DSbAjS3zIJ0u7Wy1CeTaHnuM6zrm82oXVLmhGDu4z8KT7pAcvrh85POwUV
	 /ifLHHoo0kIrS/OkHItFcTIWOgV7Gr92FjmzrXazERuQNC9v6GQqrDgrA+iLMqLCpj
	 XMGuCGTuvUTiC2bTpcrvFlF7OaGQCwAIMGp6fzDc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Puliang Lu <puliang.lu@fibocom.com>,
	Johan Hovold <johan@kernel.org>
Subject: [PATCH 5.10 063/135] USB: serial: option: fix FM101R-GL defines
Date: Tue,  5 Dec 2023 12:16:24 +0900
Message-ID: <20231205031534.369889913@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231205031530.557782248@linuxfoundation.org>
References: <20231205031530.557782248@linuxfoundation.org>
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



