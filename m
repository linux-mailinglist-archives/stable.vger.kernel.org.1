Return-Path: <stable+bounces-133672-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3993AA926C8
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 20:16:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 502194A10A9
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 18:16:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41C411EB1BF;
	Thu, 17 Apr 2025 18:16:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Izb0sS5J"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0084D3594D;
	Thu, 17 Apr 2025 18:16:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744913788; cv=none; b=VSnVI3DMZ4DYFE+JxFjXQtiVBm9im0+3WbkC87OgIMqgP7+DK3Qzioo3y+EldY3CJA7QMG2k7r5sp/X8ocX5rMtUlo8vhJ0ydMq6SXOnqO15Sc3q9lHf2U4x4OeJy+P0paWF6Gb1o0GfD0JfM8WdkjU3TAl0KGBM/pKjVJLq40M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744913788; c=relaxed/simple;
	bh=wU2f/HQnjRo7EB3xYTmDhZpWEf61pwqJa4oWFRDAipY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=PJlxboHMScFnuWuV9myjUA4ilB7ps4fxcUy5G3WWerXVTR9lTD12E3hmNVd42+GC2cCAHyFOpzQH4QSecLpk8cq8qExDZWViGILhBGLazWvl8WGby0X1rw1I4aEFL1eoe7o4HU2qYNypMngmAF1CSzmjRLmUZCjLKeeM0EZ8WEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Izb0sS5J; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 857DEC4CEE4;
	Thu, 17 Apr 2025 18:16:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744913787;
	bh=wU2f/HQnjRo7EB3xYTmDhZpWEf61pwqJa4oWFRDAipY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Izb0sS5Jv1hMv8v4hE9OpwGeiK+Ne7x7PRyVnZvjZzB3U0nFvlNaAzE3WeK55xA0S
	 njYkcQhtPX+pcy8MXBeLZU4WFU2pQkUuNkRVdvH7sHpGcYKNsS28uOF/BEjApD4R+o
	 BK2qPBsA9+NO0e+L/G6JURuUKJWyZiv4hvgDV/4g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Bjorn Helgaas <bhelgaas@google.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.14 427/449] PCI: Fix reference leak in pci_alloc_child_bus()
Date: Thu, 17 Apr 2025 19:51:55 +0200
Message-ID: <20250417175135.482553361@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250417175117.964400335@linuxfoundation.org>
References: <20250417175117.964400335@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 1f2768b6a3ee77a295106e3a5d68458064923ede upstream.

If device_register(&child->dev) fails, call put_device() to explicitly
release child->dev, per the comment at device_register().

Found by code review.

Link: https://lore.kernel.org/r/20250202062357.872971-1-make24@iscas.ac.cn
Fixes: 4f535093cf8f ("PCI: Put pci_dev in device tree as early as possible")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/pci/probe.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -1217,7 +1217,10 @@ static struct pci_bus *pci_alloc_child_b
 add_dev:
 	pci_set_bus_msi_domain(child);
 	ret = device_register(&child->dev);
-	WARN_ON(ret < 0);
+	if (WARN_ON(ret < 0)) {
+		put_device(&child->dev);
+		return NULL;
+	}
 
 	pcibios_add_bus(child);
 



