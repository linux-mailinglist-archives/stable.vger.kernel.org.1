Return-Path: <stable+bounces-34773-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 154358940C4
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:34:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 470E51C21709
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91E03481B4;
	Mon,  1 Apr 2024 16:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="LwSkXCA4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 501301E525;
	Mon,  1 Apr 2024 16:34:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711989248; cv=none; b=OocxyWdtNfoTUa+Gp/LpQvm8UskuWsRpzfYaVM3gnwzSXS8CcYS0iL85Hi5V177dQcuXUl5hB22xa3tpSmBsQSGvcrttzxu+38Qp9+6zHMVVY5zz2FnO8PMfrHad6RxAXWKNZE0I9fG3ZOac7KbRRNowaxYLMOAQ0xy1KskPuoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711989248; c=relaxed/simple;
	bh=REUxNDCh87Uts8aKdsYPqHvn+T+Zm6WpJG+LD8rghrw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=akE8BtKuIi+cJJSoQtBZlMmggUxG/mZF8BQOuqaUy4swguZttROs6Jr2qtLqBeJBng/Z8sIjEEZYlmIjOJotJsp4iHMZBdUghaLWzVsxTM1+I8nPohbBCnM4ErAv2gmaGtGJC8mY6Diwh/vXsQW5ff9TiqJZU55gWGZL9KNbzI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=LwSkXCA4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B4A8C43390;
	Mon,  1 Apr 2024 16:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711989247;
	bh=REUxNDCh87Uts8aKdsYPqHvn+T+Zm6WpJG+LD8rghrw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LwSkXCA4L4QULGCmDPLCs1sqBHu+mq/CKj0BQ2wUPv7t5/x2vyImMLpqFDx452yPh
	 0ABDBwJuPUp24sEQxznDnRaG/VYV4FP3stPfbWmJ3MCLXXaLy5w/HNRFEYO6W/6kmU
	 QpWqiSygN4Pf7xJJdXG0px2Hfd4UaDcHiVIyY/Pg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Subject: [PATCH 6.7 426/432] usb: dwc3: pci: Drop duplicate ID
Date: Mon,  1 Apr 2024 17:46:53 +0200
Message-ID: <20240401152606.134575195@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152553.125349965@linuxfoundation.org>
References: <20240401152553.125349965@linuxfoundation.org>
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

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit f121531703ae442edc1dde4b56803680628bc5b7 upstream.

Intel Arrow Lake CPU uses the Meteor Lake ID with this
controller (the controller that's part of the Intel Arrow
Lake chipset (PCH) does still have unique PCI ID).

Fixes: de4b5b28c87c ("usb: dwc3: pci: add support for the Intel Arrow Lake-H")
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/20240312115008.1748637-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/dwc3/dwc3-pci.c |    2 --
 1 file changed, 2 deletions(-)

--- a/drivers/usb/dwc3/dwc3-pci.c
+++ b/drivers/usb/dwc3/dwc3-pci.c
@@ -51,7 +51,6 @@
 #define PCI_DEVICE_ID_INTEL_MTLP		0x7ec1
 #define PCI_DEVICE_ID_INTEL_MTLS		0x7f6f
 #define PCI_DEVICE_ID_INTEL_MTL			0x7e7e
-#define PCI_DEVICE_ID_INTEL_ARLH		0x7ec1
 #define PCI_DEVICE_ID_INTEL_ARLH_PCH		0x777e
 #define PCI_DEVICE_ID_INTEL_TGL			0x9a15
 #define PCI_DEVICE_ID_AMD_MR			0x163a
@@ -423,7 +422,6 @@ static const struct pci_device_id dwc3_p
 	{ PCI_DEVICE_DATA(INTEL, MTLP, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTL, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, MTLS, &dwc3_pci_intel_swnode) },
-	{ PCI_DEVICE_DATA(INTEL, ARLH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, ARLH_PCH, &dwc3_pci_intel_swnode) },
 	{ PCI_DEVICE_DATA(INTEL, TGL, &dwc3_pci_intel_swnode) },
 



