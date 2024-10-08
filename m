Return-Path: <stable+bounces-82433-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09652994CDC
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:59:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 37DE3B2B252
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:58:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4B431DFD8B;
	Tue,  8 Oct 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EpeoXH0X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820471DF72E;
	Tue,  8 Oct 2024 12:57:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392245; cv=none; b=FR2cUkncXss/hI3EAhIXWSfqE4wZ33PcizA3bQoigW/R7tYJY3JdsW2EGqlGxbJimry1BaGszCDqvqk/C46Qum8n6irprNg+9rO/qdq3x+U1qZG4mKf1NiVtIhDmXiUjUE9q6up5BjtnOFDiFMFgrOE5Tw90zqDpa7+grC8d4Ew=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392245; c=relaxed/simple;
	bh=qZm5zj/GT7SOZdjNDFXHZ1F3IlnjWokg8cmDBeOJAtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AhKdreTPtzrn6fxB5CILjWcW3otwdo4msZ9WXdAUpikqz1n0MIo6g6xfjXuMj95eW88/lu+Ds7yx0aEqToAspS8bIINb9EthSwoAAPlFf60+vrawpFjHx5iA7dOyFOStPVo0o0l83jEnn5dSWK5Z5wGG+Ll018wFkP7kOZmNLOE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EpeoXH0X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A096AC4CECD;
	Tue,  8 Oct 2024 12:57:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392245;
	bh=qZm5zj/GT7SOZdjNDFXHZ1F3IlnjWokg8cmDBeOJAtI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EpeoXH0X7WUSHMnD1PBF00TirtCuzFT2WaGyiTmptred/MyziLx+lSbZEdCYLClea
	 qploRGFxYKSSZAQ82d47LbvDy3Hbcf0vxpkeVfVf6xj4D4E5tF9Hoh8YrFOkqwg6ww
	 ziAYKfo86gGirRMBXhurCAqPYbD1+0TuOPjT6DI8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 6.11 359/558] firmware: tegra: bpmp: Drop unused mbox_client_to_bpmp()
Date: Tue,  8 Oct 2024 14:06:29 +0200
Message-ID: <20241008115716.427500128@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
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

6.11-stable review patch.  If anyone has any objections, please let me know.

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



