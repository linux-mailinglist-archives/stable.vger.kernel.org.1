Return-Path: <stable+bounces-34290-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 260D6893EB6
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 18:07:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A8272B212E2
	for <lists+stable@lfdr.de>; Mon,  1 Apr 2024 16:07:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFC24778B;
	Mon,  1 Apr 2024 16:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N2h4b+6p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED302383BA;
	Mon,  1 Apr 2024 16:07:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711987623; cv=none; b=b1VmFAACxFeuM1w/mL81SktSt/asbAyvR4RNkSA1s11Pwrsp5fUXD0Vry4/Vu8vu53+GK7Av14NRkBZloe320Ij64uBDxcckaoxpUVI54I91rkAsaLRmSjIXnpBqPWtcfbXL/kEqufsuIbvd7gFA5OXLI9JgQXzqP9fQnBKXpaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711987623; c=relaxed/simple;
	bh=oGXXS1+k08bD6+LAYJO7uZ0cNaMKZnUcItLWQve0CZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QlkbZr9R9/aGKnXroiIu7c8ivPxZiPFusXLYBHkidIYwF8SWCS8BK0VRAjOYgfTlWSEIJ1J9TW0HRF7dncHbWGbGamZ2y8254WivA6OniAtYJ3/nacySwjt0OpW0Gldaqjf0dTZlC/IyxhH9HDlGyEz1g6HuR6X4AxHX6Zi+3Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N2h4b+6p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D07C43390;
	Mon,  1 Apr 2024 16:07:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711987622;
	bh=oGXXS1+k08bD6+LAYJO7uZ0cNaMKZnUcItLWQve0CZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N2h4b+6p7vMAdtt0p0EYz6mwGfkVQmBZhp74MRiVOeagjyDM9hctL6jECy1zrGGLS
	 ahXGD6y45YEk4Klfgih0fjbA1ZNhLlVhS3NwVBToyLtjjG4PWaH0fhQOiEYpve6ZOI
	 XGWmiZuN1xVD8j+JK5E9dBSHtaY9zUnxYF4/2GOk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Stein <alexander.stein@ew.tq-group.com>,
	stable <stable@kernel.org>,
	Sean Anderson <sean.anderson@seco.com>
Subject: [PATCH 6.8 342/399] Revert "usb: phy: generic: Get the vbus supply"
Date: Mon,  1 Apr 2024 17:45:08 +0200
Message-ID: <20240401152559.382065537@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240401152549.131030308@linuxfoundation.org>
References: <20240401152549.131030308@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexander Stein <alexander.stein@ew.tq-group.com>

commit fdada0db0b2ae2addef4ccafe50937874dbeeebe upstream.

This reverts commit 75fd6485cccef269ac9eb3b71cf56753341195ef.
This patch was applied twice by accident, causing probe failures.
Revert the accident.

Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Fixes: 75fd6485ccce ("usb: phy: generic: Get the vbus supply")
Cc: stable <stable@kernel.org>
Reviewed-by: Sean Anderson <sean.anderson@seco.com>
Link: https://lore.kernel.org/r/20240314092628.1869414-1-alexander.stein@ew.tq-group.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/phy/phy-generic.c |    7 -------
 1 file changed, 7 deletions(-)

--- a/drivers/usb/phy/phy-generic.c
+++ b/drivers/usb/phy/phy-generic.c
@@ -274,13 +274,6 @@ int usb_phy_gen_create_phy(struct device
 		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
 				     "could not get vbus regulator\n");
 
-	nop->vbus_draw = devm_regulator_get_exclusive(dev, "vbus");
-	if (PTR_ERR(nop->vbus_draw) == -ENODEV)
-		nop->vbus_draw = NULL;
-	if (IS_ERR(nop->vbus_draw))
-		return dev_err_probe(dev, PTR_ERR(nop->vbus_draw),
-				     "could not get vbus regulator\n");
-
 	nop->dev		= dev;
 	nop->phy.dev		= nop->dev;
 	nop->phy.label		= "nop-xceiv";



