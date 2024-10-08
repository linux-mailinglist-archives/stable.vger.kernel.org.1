Return-Path: <stable+bounces-82854-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 61EB3994F67
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:27:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B7F2CB28755
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:21:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A4CF1DF243;
	Tue,  8 Oct 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hrlJz2lM"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DF1A1DF254;
	Tue,  8 Oct 2024 13:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728393649; cv=none; b=ImXfFNPIet8BTGas52YxqpKXFjUscMdfEhN+dXQmiWgE+amdnpNBINt5Evc7oJDQdhjLLSuuhx9XIdh2a1N9BbF9J49PvtR10Mwy99gTuvQc8O0F2hAUoJxecmOyfPOJAIVuEgqdsO6LrSh6pAaZ+eOuLx1Z0kbb2lMDVqowxHc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728393649; c=relaxed/simple;
	bh=sOAupW5NoV5DgkuEb1O6i5TXtND8MPasFImhHsnOAvs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RgNIfEhlaukhPgN/t89VqhVvmCAWjWlhh4cZDCod1qTY70U3e6QgzGT3vMp7FGUs36nu4Tu42HYYc6xqLJFg3nezVF6VAT1snfCuVAb0Xk8/7c4kiyKLp4uPu8FGgxv6WztavidX5eNr5T6P3RBKf0/SsMM3Q/aOmrhA6T7a1dw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hrlJz2lM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 78C93C4CEC7;
	Tue,  8 Oct 2024 13:20:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728393649;
	bh=sOAupW5NoV5DgkuEb1O6i5TXtND8MPasFImhHsnOAvs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hrlJz2lMSFAb+B1bOQZPhwbaLAsq1LAR/ubzfR6HGjT3bpRLTqMBV/1KZgl4iHJx8
	 Kd+OrolHbyd/MMDSovE/VHa+o1B/TrHppVgBpFSYgT0IUr29fsfgSp7COZzqD5FGNf
	 m8DlIamEKy2UDTJvQIFZ1h7q5tzNAsc9DQwjnvAY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 6.6 214/386] firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()
Date: Tue,  8 Oct 2024 14:07:39 +0200
Message-ID: <20241008115637.829073565@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115629.309157387@linuxfoundation.org>
References: <20241008115629.309157387@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

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
@@ -24,12 +24,6 @@
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



