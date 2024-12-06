Return-Path: <stable+bounces-99589-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 32F5E9E725E
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 16:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E68A0280C60
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 15:08:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7759148314;
	Fri,  6 Dec 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aYZ18U+S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8498C53A7;
	Fri,  6 Dec 2024 15:08:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733497688; cv=none; b=TDoELNL22MElK1MaaBCPpAqNgEflZ/Y9eeZChwXnkoV0dh6DwRQIEDBcE9rx6Cso4v+/+kbNIYJ912CsW51UxvT3wFldKY68sjWakKkP1N1LjQyUvAHxV1MCwV4aLdqe8UjcTuyBGYE5fhZ+76ue+pFO8nmGw2LSzrcjxO/VZBA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733497688; c=relaxed/simple;
	bh=QxLRjcNSUmJRZ5ySrfpkAQFSnE66IPCe/KO2NXFc1fI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XKiTfN2UVZF6VV2MqjT0IZ5GJx6xOYgpcMHCkzoOieabkO7ADMl5w9F34Pd9QTUr8S6CtJcXAH7IB2h80PNU2Ylfgm3IgikDvO10pdKcwTnsgVQdNkQXtJekZWLd3EXFPtyeTIPTCzzAjevhl3893bkefV7/F//ezjFfJJ68bLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aYZ18U+S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E72C6C4CEDC;
	Fri,  6 Dec 2024 15:08:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1733497688;
	bh=QxLRjcNSUmJRZ5ySrfpkAQFSnE66IPCe/KO2NXFc1fI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=aYZ18U+S90BEbohbZp3LC+y8s/XCTl/UR/+6LbytPrRCJ80qouKK4tDtXRdvVFVVm
	 gqDVnheYQhuhMu7Ht1lEIHKxLjsiM0Tm18D1UC+4UdV4h7PiLELkAo/C6/1+mAs/1y
	 UztDFuQp3Kdz9GWP8XK8bwIuB7+lFdRuJluDRSZc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Richard <thomas.richard@bootlin.com>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 364/676] PCI: j721e: Use T_PERST_CLK_US macro
Date: Fri,  6 Dec 2024 15:33:03 +0100
Message-ID: <20241206143707.564866607@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241206143653.344873888@linuxfoundation.org>
References: <20241206143653.344873888@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Richard <thomas.richard@bootlin.com>

[ Upstream commit f96b6971373382855bc964f1c067bd6dc41cf0ab ]

Use the T_PERST_CLK_US macro, and the fsleep() function instead of
usleep_range().

Link: https://lore.kernel.org/linux-pci/20240102-j7200-pcie-s2r-v7-6-a2f9156da6c3@bootlin.com
Signed-off-by: Thomas Richard <thomas.richard@bootlin.com>
Signed-off-by: Krzysztof Wilczyński <kwilczynski@kernel.org>
Stable-dep-of: 22a9120479a4 ("PCI: j721e: Deassert PERST# after a delay of PCIE_T_PVPERL_MS milliseconds")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/cadence/pci-j721e.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/cadence/pci-j721e.c b/drivers/pci/controller/cadence/pci-j721e.c
index 82f8c3a701c2f..b83ae35a210fe 100644
--- a/drivers/pci/controller/cadence/pci-j721e.c
+++ b/drivers/pci/controller/cadence/pci-j721e.c
@@ -520,7 +520,7 @@ static int j721e_pcie_probe(struct platform_device *pdev)
 		 * after 100 us.
 		 */
 		if (gpiod) {
-			usleep_range(100, 200);
+			fsleep(PCIE_T_PERST_CLK_US);
 			gpiod_set_value_cansleep(gpiod, 1);
 		}
 
-- 
2.43.0




