Return-Path: <stable+bounces-143313-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1002AB3F10
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 19:30:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 417F78645EF
	for <lists+stable@lfdr.de>; Mon, 12 May 2025 17:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FD502522BA;
	Mon, 12 May 2025 17:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2cSBOSXT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F8F78F52;
	Mon, 12 May 2025 17:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747071044; cv=none; b=jXQocxs/CiGE48cyD8jo/aqDtyNRl0zFg1V81Q/f7CZAQe9Al2YcIlzjzimAwP8AL3TWq55L4m99LP8bsU4QusluwZYTC0+UXFpA8nGauwQnJLt2DCskXIWnb3/bZ5aVHdgCXiSkqFNtWg1sOgUftyBYQ32QpQNtAj/yu/Yq3Yg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747071044; c=relaxed/simple;
	bh=wIMlSYfMSAXb10fklQzb/e8TR2oiyrTCLvmQjcmrH00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=l4PXR854dgTmf+vTujXtKr8sSoz7qEmf/ijrIZzTu2/hwf4NArOgc5bfzO5NZ/ySj1Rf4pzoMI1lYkVPtRMTtKneQNkBK5g5T3+zaEWi3jSst61JFX5vuKM9haXXT1C1yPVpOVJ0i0NU4JGR6jx3DFL+zieehejh4/GFfdZ8KMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2cSBOSXT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35253C4CEE7;
	Mon, 12 May 2025 17:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1747071044;
	bh=wIMlSYfMSAXb10fklQzb/e8TR2oiyrTCLvmQjcmrH00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2cSBOSXTafIoW9sjR4nQ4KM4FOvy2SLG8Q4oVLxnmia9+/e65kFlPzTvPPU5RUJAi
	 /8FiF59nxbs+YUwRoigI8j/qqVK3xpdCJDF3x6QRqRnU3PpWOBXaqlv0NPxp3ov6gh
	 yMQaNx8twoRbWo9s6U1LLCZhocJp4oBN6BEDjORU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Matthias Eilert <kernel.hias@eilert.tech>,
	Aditya Garg <gargaditya08@live.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Subject: [PATCH 5.15 19/54] Input: synaptics - enable InterTouch on TUXEDO InfinityBook Pro 14 v5
Date: Mon, 12 May 2025 19:29:31 +0200
Message-ID: <20250512172016.424952891@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250512172015.643809034@linuxfoundation.org>
References: <20250512172015.643809034@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aditya Garg <gargaditya08@live.com>

commit 2abc698ac77314e0de5b33a6d96a39c5159d88e4 upstream.

Enable InterTouch mode on TUXEDO InfinityBook Pro 14 v5 by adding
"SYN1221" to the list of SMBus-enabled variants.

Add support for InterTouch on SYN1221 by adding it to the list of
SMBus-enabled variants.

Reported-by: Matthias Eilert <kernel.hias@eilert.tech>
Tested-by: Matthias Eilert <kernel.hias@eilert.tech>
Signed-off-by: Aditya Garg <gargaditya08@live.com>
Link: https://lore.kernel.org/r/PN3PR01MB9597C033C4BC20EE2A0C4543B888A@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM
Cc: stable@vger.kernel.org
Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/input/mouse/synaptics.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/input/mouse/synaptics.c
+++ b/drivers/input/mouse/synaptics.c
@@ -188,6 +188,7 @@ static const char * const smbus_pnp_ids[
 	"LEN2054", /* E480 */
 	"LEN2055", /* E580 */
 	"LEN2068", /* T14 Gen 1 */
+	"SYN1221", /* TUXEDO InfinityBook Pro 14 v5 */
 	"SYN3003", /* HP EliteBook 850 G1 */
 	"SYN3015", /* HP EliteBook 840 G2 */
 	"SYN3052", /* HP EliteBook 840 G4 */



