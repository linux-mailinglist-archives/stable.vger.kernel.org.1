Return-Path: <stable+bounces-78526-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ED5B98BEE2
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 16:04:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03CEC1F22BA1
	for <lists+stable@lfdr.de>; Tue,  1 Oct 2024 14:04:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1CAC1C463C;
	Tue,  1 Oct 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HoLx31rh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0ACE1C0DD1
	for <stable@vger.kernel.org>; Tue,  1 Oct 2024 14:03:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727791438; cv=none; b=NmYHPesVV5c4s9inpuiR5UqJbRy0cqCLGvlIY9Zl9DbxMKuSvQSRGipsOJvug9nNtok2sUyos7tfGB3bp4srGpcb2rC1/xziOMIVpuE3H8OuvibjS+DO8GKmDxN3XgTYGic8TaQdPef9KGP+/S8lnBCQBp1Ko4AALORo2mk6YsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727791438; c=relaxed/simple;
	bh=YHbWLW27JnNcs9t87AqSdWPNZJP0I4l0hF2K5inj+wg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Si0tx7D7+fp1+u9FAKuB7APhcW21YZMCXDdZE9VPL8JEbVxkm2hHq4MBsDl4lCzKBtzhBLklcrEiD5K3QksR7XpBGx54RfmsmiYK6i4t+Z6Eqrkyt7l/KEQnTlbfxpBXmeP2SC+ojvvWURdaGdYoprlzUJvvw8wBCGCPiL38WW8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HoLx31rh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2530BC4CEC6;
	Tue,  1 Oct 2024 14:03:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727791438;
	bh=YHbWLW27JnNcs9t87AqSdWPNZJP0I4l0hF2K5inj+wg=;
	h=Subject:To:Cc:From:Date:From;
	b=HoLx31rhr61J9Gf7sHmgwZD3/lfywbH48y2Q1UjJIYuWR5vzw1sV7GljU/ak/QTot
	 iwhkJu6rkYPYAvCoQo44QgAMdzzeTLqCuZ8+n9oLCvEGHbcWfaFItZLAU4qQ+dsBIq
	 ZOnweBoXRO4wyBqK2zfU8HFlJW4iJ13xet/T2eH8=
Subject: FAILED: patch "[PATCH] dt-bindings: spi: nxp-fspi: add imx8ulp support" failed to apply to 6.6-stable tree
To: haibo.chen@nxp.com,Frank.Li@nxp.com,broonie@kernel.org,krzysztof.kozlowski@linaro.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 01 Oct 2024 16:03:49 +0200
Message-ID: <2024100148-payday-steadfast-3ba9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 12736adc43b7cd5cb83f274f8f37b0f89d107c97
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100148-payday-steadfast-3ba9@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

12736adc43b7 ("dt-bindings: spi: nxp-fspi: add imx8ulp support")
18ab9e9e8889 ("dt-bindings: spi: nxp-fspi: support i.MX93 and i.MX95")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 12736adc43b7cd5cb83f274f8f37b0f89d107c97 Mon Sep 17 00:00:00 2001
From: Haibo Chen <haibo.chen@nxp.com>
Date: Thu, 5 Sep 2024 17:43:35 +0800
Subject: [PATCH] dt-bindings: spi: nxp-fspi: add imx8ulp support

The flexspi on imx8ulp only has 16 number of LUTs, it is different
with flexspi on other imx SoC which has 32 number of LUTs.

Fixes: ef89fd56bdfc ("arm64: dts: imx8ulp: add flexspi node")
Cc: stable@kernel.org
Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://patch.msgid.link/20240905094338.1986871-2-haibo.chen@nxp.com
Signed-off-by: Mark Brown <broonie@kernel.org>

diff --git a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
index 4a5f41bde00f..902db92da832 100644
--- a/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
+++ b/Documentation/devicetree/bindings/spi/spi-nxp-fspi.yaml
@@ -21,6 +21,7 @@ properties:
           - nxp,imx8mm-fspi
           - nxp,imx8mp-fspi
           - nxp,imx8qxp-fspi
+          - nxp,imx8ulp-fspi
           - nxp,lx2160a-fspi
       - items:
           - enum:


