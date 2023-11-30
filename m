Return-Path: <stable+bounces-3522-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A01E7FF60E
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 17:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE208B20F6E
	for <lists+stable@lfdr.de>; Thu, 30 Nov 2023 16:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33B9948CEB;
	Thu, 30 Nov 2023 16:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="azidKzAV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00FE3D382;
	Thu, 30 Nov 2023 16:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D74AC433C8;
	Thu, 30 Nov 2023 16:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1701362044;
	bh=FsQxoO4a8IdfQ4iHFmu75vNruE+kpq3FPdQE9Tjyop0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=azidKzAVP+i627WixS92Oh80Uv+3Ro0eQMopvtbpvlJHOJAkxXGmzFzZBkvowHWLp
	 a6/ITsKbqtB7gdWjLO8B2MaaXHRuREoJ/SpzTgtT6cRYU2sRsa9Zs9zMeRDGXyyIa9
	 kvZK4YH/8Hy1DLUtG9L5g/sxhrYQryG37ZG3cQ+8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 5.15 65/69] usb: dwc3: Fix default mode initialization
Date: Thu, 30 Nov 2023 16:23:02 +0000
Message-ID: <20231130162135.201760400@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231130162133.035359406@linuxfoundation.org>
References: <20231130162133.035359406@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit 10d510abd096d620b9fda2dd3e0047c5efc4ad2b upstream.

The default mode, configurable by DT, shall be set before usb role switch
driver is registered. Otherwise there is a race between default mode
and mode set by usb role switch driver.

Fixes: 98ed256a4dbad ("usb: dwc3: Add support for role-switch-default-mode binding")
Cc: stable <stable@kernel.org>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20231025095110.2405281-1-alexander.stein@ew.tq-group.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/drd.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/usb/dwc3/drd.c
+++ b/drivers/usb/dwc3/drd.c
@@ -545,6 +545,7 @@ static int dwc3_setup_role_switch(struct
 		dwc->role_switch_default_mode = USB_DR_MODE_PERIPHERAL;
 		mode = DWC3_GCTL_PRTCAP_DEVICE;
 	}
+	dwc3_set_mode(dwc, mode);
 
 	dwc3_role_switch.fwnode = dev_fwnode(dwc->dev);
 	dwc3_role_switch.set = dwc3_usb_role_switch_set;
@@ -554,7 +555,6 @@ static int dwc3_setup_role_switch(struct
 	if (IS_ERR(dwc->role_sw))
 		return PTR_ERR(dwc->role_sw);
 
-	dwc3_set_mode(dwc, mode);
 	return 0;
 }
 #else



