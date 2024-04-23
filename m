Return-Path: <stable+bounces-41297-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A65468AFB12
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 23:53:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D78AE1C2212B
	for <lists+stable@lfdr.de>; Tue, 23 Apr 2024 21:53:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E0D14C5A5;
	Tue, 23 Apr 2024 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cYcEIEwv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E0B7145B38;
	Tue, 23 Apr 2024 21:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713908812; cv=none; b=dNzZCaxY98BBnQIZg9/zS+nTXietU74FGOCJNTY9GumS7+4/JjL1Q07cfvtMQxSJxhCBrsPmtyGOTBwWRIMPwpWlK7z8QcuGdv85TZhmDn18bN4kijCXy7/lczg79d6rQblmft060GUWo7pSYRtAOyWWD4A19jVHtDy7dzwn1lY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713908812; c=relaxed/simple;
	bh=I8tvUOgZ0cAXCaIbo0Shl6WnAtSYuVAzuAGifAj9WVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HlsFndaFpJRAjItlVVUTQ5AyK6zK7hCArt+BQBL8eTDk0onePpG5uGi7rvU+msdCKkr8wcVOfNyy1EDkPEIYKXwk1AMUHoZVRQkoNbY6EqOgA9Q6kcpGXRuN86ldg+LT0y2ivEnnQ2KmL8qMVs+y2KwVtoGpEThdeqXZfOXJN/4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cYcEIEwv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4C7CC32782;
	Tue, 23 Apr 2024 21:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1713908811;
	bh=I8tvUOgZ0cAXCaIbo0Shl6WnAtSYuVAzuAGifAj9WVo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cYcEIEwvU3KIIEkk0huOIH0Zx1na9N3Z4D7R1BYfLh58CZwkk8jqA0IgkUbxMVMSo
	 ruBboWjjrv54tXQliszrUzrk3tjPYbSMj3sVmoNffpogqsg29nMyPH621AnAwDhdHH
	 XK7HfgEltMtJMF+WJi3Agyqzj8waWtIaE8XFIEnE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Usyskin <alexander.usyskin@intel.com>,
	Tomas Winkler <tomas.winkler@intel.com>
Subject: [PATCH 5.15 56/71] mei: me: disable RPL-S on SPS and IGN firmwares
Date: Tue, 23 Apr 2024 14:40:09 -0700
Message-ID: <20240423213846.108023588@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240423213844.122920086@linuxfoundation.org>
References: <20240423213844.122920086@linuxfoundation.org>
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

From: Alexander Usyskin <alexander.usyskin@intel.com>

commit 0dc04112bee6fdd6eb847ccb32214703022c0269 upstream.

Extend the quirk to disable MEI interface on Intel PCH Ignition (IGN)
and SPS firmwares for RPL-S devices. These firmwares do not support
the MEI protocol.

Fixes: 3ed8c7d39cfe ("mei: me: add raptor lake point S DID")
Cc: stable@vger.kernel.org
Signed-off-by: Alexander Usyskin <alexander.usyskin@intel.com>
Signed-off-by: Tomas Winkler <tomas.winkler@intel.com>
Link: https://lore.kernel.org/r/20240312051958.118478-1-tomas.winkler@intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/misc/mei/pci-me.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/misc/mei/pci-me.c
+++ b/drivers/misc/mei/pci-me.c
@@ -115,7 +115,7 @@ static const struct pci_device_id mei_me
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_P, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ADP_N, MEI_ME_PCH15_CFG)},
 
-	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_CFG)},
+	{MEI_PCI_DEVICE(MEI_DEV_ID_RPL_S, MEI_ME_PCH15_SPS_CFG)},
 
 	{MEI_PCI_DEVICE(MEI_DEV_ID_MTL_M, MEI_ME_PCH15_CFG)},
 	{MEI_PCI_DEVICE(MEI_DEV_ID_ARL_S, MEI_ME_PCH15_CFG)},



