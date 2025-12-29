Return-Path: <stable+bounces-204035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C675FCE792B
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CDA93014DE4
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:36:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 204B5332903;
	Mon, 29 Dec 2025 16:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/VXLT8t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D290F332908;
	Mon, 29 Dec 2025 16:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767025865; cv=none; b=j61FFZ2WZljStC85UlDyOjQ9sD3RtGy0rV1YbQujhCllhSrqF6vZu6jzdktNTIgfwXkmd4OdPvyLFfI15pt7xrSi0XcPYHYQ9lBnK2DA9BWKDWn2EK552bjHGn7em6bkYutXigE12ZimPXUdLIbFaPiMZsmHrlABwgFYJeRzlJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767025865; c=relaxed/simple;
	bh=NYOB8Li9P9XYW9c4F53VIoGQpqlaOtJQKhOIiOrO5DY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hHgahrRLdO+8swQ6vNBJuMZRgR/MyOIHynW4WtPTARINJ3C9wdmRORbu+cidIah9V9q+FiR7nVbrOL9Z6GmANX/y/7NMWejIAsesDUDUT31pFYvDRYsP16JViCHOipvYdok5a4fkN9qDLMpvG6Oh84ILCB/XkjE1QZQoshywjHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/VXLT8t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52B9FC4CEF7;
	Mon, 29 Dec 2025 16:31:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767025865;
	bh=NYOB8Li9P9XYW9c4F53VIoGQpqlaOtJQKhOIiOrO5DY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e/VXLT8takb8jQqTa4DB4kAQ+TiVoNmFyFZtTDwlL2WkdSGStqwUXd78++ZBrMKIu
	 L2DPFPT5hP77W347vvpY3taflryfdXAHNt0gr1zGTg6Ti26eueJB1ncWjPjJCwlPLQ
	 s71LIyk3c6YYLJLUJ7nVRSkuviG51meVFN5TR5Fc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Dimitri Fedrau <dima.fedrau@gmail.com>,
	Andrew Lunn <andrew@lunn.ch>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.18 364/430] net: phy: marvell-88q2xxx: Fix clamped value in mv88q2xxx_hwmon_write
Date: Mon, 29 Dec 2025 17:12:46 +0100
Message-ID: <20251229160737.724164850@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thorsten Blum <thorsten.blum@linux.dev>

commit c4cdf7376271bce5714c06d79ec67759b18910eb upstream.

The local variable 'val' was never clamped to -75000 or 180000 because
the return value of clamp_val() was not used. Fix this by assigning the
clamped value back to 'val', and use clamp() instead of clamp_val().

Cc: stable@vger.kernel.org
Fixes: a557a92e6881 ("net: phy: marvell-88q2xxx: add support for temperature sensor")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
Reviewed-by: Dimitri Fedrau <dima.fedrau@gmail.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20251202172743.453055-3-thorsten.blum@linux.dev
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/phy/marvell-88q2xxx.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/phy/marvell-88q2xxx.c
+++ b/drivers/net/phy/marvell-88q2xxx.c
@@ -698,7 +698,7 @@ static int mv88q2xxx_hwmon_write(struct
 
 	switch (attr) {
 	case hwmon_temp_max:
-		clamp_val(val, -75000, 180000);
+		val = clamp(val, -75000, 180000);
 		val = (val / 1000) + 75;
 		val = FIELD_PREP(MDIO_MMD_PCS_MV_TEMP_SENSOR3_INT_THRESH_MASK,
 				 val);



