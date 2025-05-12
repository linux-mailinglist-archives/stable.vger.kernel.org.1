Return-Path: <stable+bounces-143761-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66691AB4133
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 20:03:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1A911188983A
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 18:03:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2DC92512F1;
	Mon, 12 May 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hb8xFb7D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA14175BF;
	Mon, 12 May 2025 18:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747072993; cv=none; b=DO/XKDg++9QmqcPxTGrPWPRCk+Up7JbDFeQIPetcl1fvFbwQFvKxPa0qTRNrOGhFoxPr/iIZTq6J7l4Nk5bI4aQM05/89NXyP4mTZgh5F9ALRGE/2gi6WSt8YmID1krjjbEKX9zPmmvf2Jun9vdWR8SB1lHVi+aMYUbwJbpuImM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747072993; c=relaxed/simple;
	bh=qtsacM62oZpW8efanknMHfDVYltRn0uUvYF1kEtZYok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNiUrU3h9bEEFzpPCRB6WhX3g/4dpdGSvlAW1tkJsjCFKHxfg+JPPeXs2JNCufHaHdGxrYgIi0MICq95oD0tfAzqZsAV2EGAfRNp6iEbintHyHr3KRiyYfUGZ1mUZk62C5KtfFPC2en3U3bDlQnZhHJqLK5HpXxucIdyCIMUrmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hb8xFb7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7C49C4CEE7;
	Mon, 12 May 2025 18:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747072993;
	bh=qtsacM62oZpW8efanknMHfDVYltRn0uUvYF1kEtZYok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hb8xFb7D/PO0Nom7MwYoDKYoL1xFcUrt7Kgjd7Ecw9l8dEdohruvuBWOQ5p5TVa+i
	 hSsvf9FlEKwp7Z0iQnAGJm733tZOY39dt6hKXaI0Ok8b5INSZfLpcxH+551OckS9KE
	 eD6feNXOdqgmy7bKHn+VNHkkjW8jrpKfbQWzOXWI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable <stable@kernel.org>,
	Wayne Chang <waynec@nvidia.com>
Subject: [PATCH 6.12 120/184] usb: gadget: tegra-xudc: ACK ST_RC after clearing CTRL_RUN
Date: Mon, 12 May 2025 19:45:21 +0200
Message-ID: <20250512172046.709501302@linuxfoundation.org>
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

From: Wayne Chang <waynec@nvidia.com>

commit 59820fde001500c167342257650541280c622b73 upstream.

We identified a bug where the ST_RC bit in the status register was not
being acknowledged after clearing the CTRL_RUN bit in the control
register. This could lead to unexpected behavior in the USB gadget
drivers.

This patch resolves the issue by adding the necessary code to explicitly
acknowledge ST_RC after clearing CTRL_RUN based on the programming
sequence, ensuring proper state transition.

Fixes: 49db427232fe ("usb: gadget: Add UDC driver for tegra XUSB device mode controller")
Cc: stable <stable@kernel.org>
Signed-off-by: Wayne Chang <waynec@nvidia.com>
Link: https://lore.kernel.org/r/20250418081228.1194779-1-waynec@nvidia.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/gadget/udc/tegra-xudc.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1749,6 +1749,10 @@ static int __tegra_xudc_ep_disable(struc
 		val = xudc_readl(xudc, CTRL);
 		val &= ~CTRL_RUN;
 		xudc_writel(xudc, val, CTRL);
+
+		val = xudc_readl(xudc, ST);
+		if (val & ST_RC)
+			xudc_writel(xudc, ST_RC, ST);
 	}
 
 	dev_info(xudc->dev, "ep %u disabled\n", ep->index);



