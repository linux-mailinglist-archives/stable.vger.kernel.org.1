Return-Path: <stable+bounces-76421-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 153BD97A1B0
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 14:09:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A67F8B24357
	for <lists+stable@lfdr.de>; Mon, 16 Sep 2024 12:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1191E15665C;
	Mon, 16 Sep 2024 12:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="N4B6hyax"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067914AD19;
	Mon, 16 Sep 2024 12:09:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726488544; cv=none; b=GSTMpj/7nsaPoGUxPwtxp2EOQW3bW9FQDlw9c/Ek7vaXGJnYCcWcmxhbXWarSdrb8qRoDInOTRRiyBSn4NkTjBv/u42IxuBUXht217o7+QKhtrJhU12gajSV1gh/NySMYoeuiPbZ1moKmTgehAcC1eZ5V9TfhYtcxqRI464/6jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726488544; c=relaxed/simple;
	bh=Xs+la2YeUbYjDIuOLvViw9gZONAPOFNIHOeIrV6yOwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rjckXueU+5pwl4SAZG3e47tRQaScwnP+bU/fha4pZojKbKsn9Bj+v71NtpUGue48vzGb9s0KyKx/a/wzqAekHePYPvBDBe6+Q0uHaVCgkiXNRG4ZlEE7BxshdhNLIcLYWuh9526KlEf7xcNKK4ieJBd/Byjuz7QNlOxZRva2NXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=N4B6hyax; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48F96C4CEC4;
	Mon, 16 Sep 2024 12:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726488544;
	bh=Xs+la2YeUbYjDIuOLvViw9gZONAPOFNIHOeIrV6yOwY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=N4B6hyaxtnzg7sR4A9xxyCntOmTNHN/I4VXOvKqxpCMGRbx9WZOw9fEmKw6wXVpZD
	 H9imT0XXFgaIPG/qnoWoLCEYaGYMmI2wDhNKtHOucY5ksPsGk/41KpbNVNjnAQKDdS
	 2R6klKuVeVi3A6U1hPqyJAtnv0AZDCEwPYEX6geU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Maximilian Luz <luzmaximilian@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 29/91] platform/surface: aggregator_registry: Add support for Surface Laptop Go 3
Date: Mon, 16 Sep 2024 13:44:05 +0200
Message-ID: <20240916114225.471096253@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240916114224.509743970@linuxfoundation.org>
References: <20240916114224.509743970@linuxfoundation.org>
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

From: Maximilian Luz <luzmaximilian@gmail.com>

[ Upstream commit ed235163c3f02329d5e37ed4485bbc39ed2568d4 ]

Add SAM client device nodes for the Surface Laptop Go 3. It seems to use
the same SAM client devices as the Surface Laptop Go 1 and 2, so re-use
their node group.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
Link: https://lore.kernel.org/r/20240811131948.261806-3-luzmaximilian@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/platform/surface/surface_aggregator_registry.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/drivers/platform/surface/surface_aggregator_registry.c
index c2651599685e..8c5b5f35d848 100644
--- a/drivers/platform/surface/surface_aggregator_registry.c
+++ b/drivers/platform/surface/surface_aggregator_registry.c
@@ -370,6 +370,9 @@ static const struct acpi_device_id ssam_platform_hub_match[] = {
 	/* Surface Laptop Go 2 */
 	{ "MSHW0290", (unsigned long)ssam_node_group_slg1 },
 
+	/* Surface Laptop Go 3 */
+	{ "MSHW0440", (unsigned long)ssam_node_group_slg1 },
+
 	/* Surface Laptop Studio */
 	{ "MSHW0123", (unsigned long)ssam_node_group_sls },
 
-- 
2.43.0




