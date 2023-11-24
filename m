Return-Path: <stable+bounces-800-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id ECE737F7C9C
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:16:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A31471F20FAD
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:16:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 032613A8C6;
	Fri, 24 Nov 2023 18:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="lJScJP6C"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD50639FE3;
	Fri, 24 Nov 2023 18:16:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA414C433C8;
	Fri, 24 Nov 2023 18:16:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849808;
	bh=VQZeeuii/eSoiiVDMP29la6kmx4dHiws2INPXpMCzDw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJScJP6C8m4mVzJLC+l1dxyoAaNiwxrxnzt1ugUZQrlPmJtr/Upi/mIuxAgdARWZ1
	 pWMgrVCLwmh9iyTEGhEtWjC9svNkF0RXzZx14pDIt3jEVeW+g4pKm1FgPMYLdODXYa
	 3QaSAVZfQ6/j/XsrkgV/TMxBQZx66OUac5Oh/HCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 6.6 321/530] mmc: vub300: fix an error code
Date: Fri, 24 Nov 2023 17:48:07 +0000
Message-ID: <20231124172037.808825227@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
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

From: Dan Carpenter <dan.carpenter@linaro.org>

commit b44f9da81783fda72632ef9b0d05ea3f3ca447a5 upstream.

This error path should return -EINVAL instead of success.

Fixes: 88095e7b473a ("mmc: Add new VUB300 USB-to-SD/SDIO/MMC driver")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/0769d30c-ad80-421b-bf5d-7d6f5d85604e@moroto.mountain
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/host/vub300.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/mmc/host/vub300.c
+++ b/drivers/mmc/host/vub300.c
@@ -2309,6 +2309,7 @@ static int vub300_probe(struct usb_inter
 		vub300->read_only =
 			(0x0010 & vub300->system_port_status.port_flags) ? 1 : 0;
 	} else {
+		retval = -EINVAL;
 		goto error5;
 	}
 	usb_set_intfdata(interface, vub300);



