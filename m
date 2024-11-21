Return-Path: <stable+bounces-94515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 116379D4C57
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 12:54:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7896CB22FA1
	for <lists+stable@lfdr.de>; Thu, 21 Nov 2024 11:54:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF121D2F43;
	Thu, 21 Nov 2024 11:54:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="QgTE7EH9"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1C271CF5D4;
	Thu, 21 Nov 2024 11:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732190065; cv=none; b=XCDoHMB2RXxfdVm4JwcvtGUnDlUh2kAQUSl7gF/iYebmzdXC6iZxuFH6OYEVQqe3/JyIo/qdlDzl0aG7d15asi7zzqyVsGqlQ1IkbIT7n+0gZGDzSJcBUtZnaH2rFrAAR/ngAJR5AwDds+VnNjc2eN0+GAz2T7RVgVNYGmXpOns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732190065; c=relaxed/simple;
	bh=GA+riEPnI10/xWsNFm8z78mAIS3Moz8d5/rbC4MCogA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rjI4uOmb1CWA3c1TOGPaWZtQauZVHv9gZjGWN2FpnLMdkDiOkl4Y7sVx1jGJrhw+JsTqH/tpRHOKik7ha8i5xwieo+S3ZmOnQvazqzYisDx9uRX3MMacbOWew2KuzfZ2ivdEeCBu7ehI3bYDQkpYZT6amhx57tZ3Fq+L93wmcsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=QgTE7EH9; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from ldvnode.intra.ispras.ru (unknown [10.10.2.153])
	by mail.ispras.ru (Postfix) with ESMTPSA id C147F518E763;
	Thu, 21 Nov 2024 11:47:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru C147F518E763
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1732189660;
	bh=4kSpGNx4NEEFrF0ZMmnj2iC3dLzPzs1+TqbYsa2ECRM=;
	h=From:To:Cc:Subject:Date:From;
	b=QgTE7EH9jvkqd/hyYBk8H/UXwFa2wQAFJE9vVejIsSLkOeHp7Gjh3Vwa6DTYkLqjg
	 OMN9j0bAfak3oQP/swIZ1A36QKBXxslAXYPEqffNToKkzFDTh8f9Y7FIUbOLPYpHJT
	 IH83O/SZR4CH3jIurVcLnVPkwJyfnETgNdm4hy+w=
From: Vitalii Mordan <mordan@ispras.ru>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: Vitalii Mordan <mordan@ispras.ru>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Rich Felker <dalias@libc.org>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	linux-sh@vger.kernel.org,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Alexey Khoroshilov <khoroshilov@ispras.ru>,
	Vadim Mutilin <mutilin@ispras.ru>,
	stable@vger.kernel.org
Subject: [PATCH] usb: ehci-hcd: fix call balance of clocks handling routines
Date: Thu, 21 Nov 2024 14:47:00 +0300
Message-Id: <20241121114700.2100520-1-mordan@ispras.ru>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If the clocks priv->iclk and priv->fclk were not enabled in ehci_hcd_sh_probe,
they should not be disabled in any path.

Conversely, if they was enabled in ehci_hcd_sh_probe, they must be disabled
in all error paths to ensure proper cleanup.

Found by Linux Verification Center (linuxtesting.org) with Klever.

Fixes: 63c845522263 ("usb: ehci-hcd: Add support for SuperH EHCI.")
Cc: stable@vger.kernel.org # ff30bd6a6618: sh: clk: Fix clk_enable() to return 0 on NULL clk
Signed-off-by: Vitalii Mordan <mordan@ispras.ru>
---
 drivers/usb/host/ehci-sh.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/host/ehci-sh.c b/drivers/usb/host/ehci-sh.c
index d31d9506e41a..77460aac6dbd 100644
--- a/drivers/usb/host/ehci-sh.c
+++ b/drivers/usb/host/ehci-sh.c
@@ -119,8 +119,12 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 	if (IS_ERR(priv->iclk))
 		priv->iclk = NULL;
 
-	clk_enable(priv->fclk);
-	clk_enable(priv->iclk);
+	ret = clk_enable(priv->fclk);
+	if (ret)
+		goto fail_request_resource;
+	ret = clk_enable(priv->iclk);
+	if (ret)
+		goto fail_iclk;
 
 	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
 	if (ret != 0) {
@@ -136,6 +140,7 @@ static int ehci_hcd_sh_probe(struct platform_device *pdev)
 
 fail_add_hcd:
 	clk_disable(priv->iclk);
+fail_iclk:
 	clk_disable(priv->fclk);
 
 fail_request_resource:
-- 
2.25.1


