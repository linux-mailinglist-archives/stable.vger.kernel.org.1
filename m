Return-Path: <stable+bounces-68848-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4AC3E953449
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 16:25:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7586F1C224ED
	for <lists+stable@lfdr.de>; Thu, 15 Aug 2024 14:25:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 247C31A0712;
	Thu, 15 Aug 2024 14:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r5ECRSD/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEE431AC8AE;
	Thu, 15 Aug 2024 14:24:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723731855; cv=none; b=dLhXVMflUmI77ie2P1UzkWHYHCXjQXNMaP4TBYbEcwFyAodzWPf6IGk3yTdntMz0oIA2f//DlonyFZ7fjXur9ktjlZQysl+DyBQnslsvxNG418vX1g6Cg2NUZkdf4XAAXu+OgVZAhLvaMSVhcom/q4Vjm3t9m0EdqVg1Oqch5gI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723731855; c=relaxed/simple;
	bh=I/me8FpqMZjJJL4EMM5iXjByD2NcgLU+rS8Adz8Mg8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ipOTqz92accYL4Xrv8fSW7l1QQa25VNRLe+VTfjzQbGHT1ZaujGIB9ugjk2BcDN2DXH47Vdf4UKNmMpsjcVpTwmDyK9isoaC7vAsDoRNI1Ate7lK+4iTWacvXUbORedH9bERifsKrV4h/IYnio36qnGaY+bpO1vVhwp0pFe68sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r5ECRSD/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24ECFC32786;
	Thu, 15 Aug 2024 14:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723731855;
	bh=I/me8FpqMZjJJL4EMM5iXjByD2NcgLU+rS8Adz8Mg8g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=r5ECRSD/gXTJcsUOM6XgNspaxPbYIJbNJ+JUYdNm9fZKu20YmixQkzS++wiLubWOX
	 aI/0B1e7Aa1UyvD9+dWorWWVwWWg/cfybqEroJPnWOWiiNwzwwQTLaHDTh3a2BvuJb
	 vJbQhk2eBPxC0dFF1E0NjFmPC60+meMM+LXImJd0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	hmy <huanglin@uniontech.com>,
	Wentao Guan <guanwentao@uniontech.com>,
	WangYuli <wangyuli@uniontech.com>,
	Keith Busch <kbusch@kernel.org>
Subject: [PATCH 5.4 258/259] nvme/pci: Add APST quirk for Lenovo N60z laptop
Date: Thu, 15 Aug 2024 15:26:31 +0200
Message-ID: <20240815131912.834696263@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240815131902.779125794@linuxfoundation.org>
References: <20240815131902.779125794@linuxfoundation.org>
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

5.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: WangYuli <wangyuli@uniontech.com>

commit ab091ec536cb7b271983c0c063b17f62f3591583 upstream.

There is a hardware power-saving problem with the Lenovo N60z
board. When turn it on and leave it for 10 hours, there is a
20% chance that a nvme disk will not wake up until reboot.

Link: https://lore.kernel.org/all/2B5581C46AC6E335+9c7a81f1-05fb-4fd0-9fbb-108757c21628@uniontech.com
Signed-off-by: hmy <huanglin@uniontech.com>
Signed-off-by: Wentao Guan <guanwentao@uniontech.com>
Signed-off-by: WangYuli <wangyuli@uniontech.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nvme/host/pci.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2822,6 +2822,13 @@ static unsigned long check_vendor_combin
 			return NVME_QUIRK_SIMPLE_SUSPEND;
 	}
 
+	/*
+	 * NVMe SSD drops off the PCIe bus after system idle
+	 * for 10 hours on a Lenovo N60z board.
+	 */
+	if (dmi_match(DMI_BOARD_NAME, "LXKT-ZXEG-N6"))
+		return NVME_QUIRK_NO_APST;
+
 	return 0;
 }
 



