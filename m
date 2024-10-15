Return-Path: <stable+bounces-86181-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AE8199EC2A
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 15:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6870CB20CEA
	for <lists+stable@lfdr.de>; Tue, 15 Oct 2024 13:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 143031E9096;
	Tue, 15 Oct 2024 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gl0rKIUa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C73B21C07DF;
	Tue, 15 Oct 2024 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728998043; cv=none; b=qrLwyncwGFU4/0eqCnebN4x9b8bWufeC82DSmkTxuj3Q8Ze/rG/rIrO8S7shK0da+LZs65ukpNp0bKFK+nt3779CK5Z41bKBPl15M/iYfrrchWLxH7eTzU37UXEVkJXI2v4tT1NIhZiJhiSh7mGw70vRmCv95zXd7ZOzG7WyBcg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728998043; c=relaxed/simple;
	bh=ZERZPZJIhtUETpDXHcPDoTmnZy29cptg1GLtod4F0FY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDSjYajWW4dx+nm9xa+3VymE+rAUbU7bowTCBabvrld0nfKThuNyyWn4k81GRSGW5lfZDtEZGkfy7Y1vSEIFpHBOhN7i4uC46DBVhRZifbNvzigRPun6Ii1v4b3egIKQkVvtpwVjP7kP6ysil3E9i3T6msozLChFJpBknIRp6n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gl0rKIUa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA228C4CEC6;
	Tue, 15 Oct 2024 13:14:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728998043;
	bh=ZERZPZJIhtUETpDXHcPDoTmnZy29cptg1GLtod4F0FY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gl0rKIUa1dK2pEmm1a0tLZR2sFLwBry63Qf9oHdEwCaV/UASkKfuo9PK9Ag2qbR8r
	 OfNzyrVNNFYsYDshEvzNjPzTRsoD6omjglnFm26pDzmgbnTFTB6oCzYK1EbOCPY3Cn
	 Yag96AecmCqy9vC/aaqyhaZu3w0MN8qDsLun9P/k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 5.10 362/518] firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()
Date: Tue, 15 Oct 2024 14:44:26 +0200
Message-ID: <20241015123930.942552833@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241015123916.821186887@linuxfoundation.org>
References: <20241015123916.821186887@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

commit 9c3a62c20f7fb00294a4237e287254456ba8a48b upstream.

mbox_client_to_bpmp() is not used, W=1 builds:

  drivers/firmware/tegra/bpmp.c:28:1: error: unused function 'mbox_client_to_bpmp' [-Werror,-Wunused-function]

Fixes: cdfa358b248e ("firmware: tegra: Refactor BPMP driver")
Cc: stable@vger.kernel.org
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/tegra/bpmp.c |    6 ------
 1 file changed, 6 deletions(-)

--- a/drivers/firmware/tegra/bpmp.c
+++ b/drivers/firmware/tegra/bpmp.c
@@ -25,12 +25,6 @@
 #define MSG_RING	BIT(1)
 #define TAG_SZ		32
 
-static inline struct tegra_bpmp *
-mbox_client_to_bpmp(struct mbox_client *client)
-{
-	return container_of(client, struct tegra_bpmp, mbox.client);
-}
-
 static inline const struct tegra_bpmp_ops *
 channel_to_ops(struct tegra_bpmp_channel *channel)
 {



