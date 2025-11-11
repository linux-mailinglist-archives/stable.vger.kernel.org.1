Return-Path: <stable+bounces-193275-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 21253C4A235
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 02:02:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 5591C4F501D
	for <lists+stable@lfdr.de>; Tue, 11 Nov 2025 00:59:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332FB255E53;
	Tue, 11 Nov 2025 00:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="S+NmLzh6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E274025392D;
	Tue, 11 Nov 2025 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762822782; cv=none; b=ORDqhoCtxyfuFeUxulsUS8j0/da/e6lS0YBRtRkEg8zJ098ORsb0unUWyCIAcrleF3bZqqfxH6KkSSJaqDRwr6BLrWDLwvItPeSKHD4xNYwtJsitTQK76Lde4dr/tmt9Xk0rnwsJhCQ5Mn+4h/DQsghbsbNpGrle8kdGL0frwQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762822782; c=relaxed/simple;
	bh=Rd9XkEpsPnlgssch5jxr5M43ULA0AFseuqTQ+Fj6a0Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=G7LjD9Ff3vt7FDYn5vf9Um2kbJR+EIvzpDK6+czXRriGugw/KE4EYqho6uezFYZ5UrNESJoD2L6WmSZU3rNh+Lj0cJ466LlpMs6z62arAFVDHS7cQotimovvo99E+asXvuIYCshzMjz397j15jxm+lG7FfNdNrncE4CWyecNCLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=S+NmLzh6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39454C116B1;
	Tue, 11 Nov 2025 00:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762822781;
	bh=Rd9XkEpsPnlgssch5jxr5M43ULA0AFseuqTQ+Fj6a0Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=S+NmLzh6K2m5nhaGnM9EBBpL1SXN6ztYeYeB/NZexeYPzuUU2Y+FiyX5cqGb1BQFb
	 wsfu6fld31VxtlYqOz92kg2RVGAXSYbLBeakrCbWzndDcMoIevhKFReaTN8kGwmcDe
	 0Cku4KVkeDGONBC5ef2/DVyjDgcN8NKmabY8tAR4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jonas=20Schw=C3=B6bel?= <jonasschwoebel@yahoo.de>,
	Svyatoslav Ryhel <clamor95@gmail.com>,
	Thierry Reding <treding@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 170/849] ARM: tegra: p880: set correct touchscreen clipping
Date: Tue, 11 Nov 2025 09:35:40 +0900
Message-ID: <20251111004540.544739622@linuxfoundation.org>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251111004536.460310036@linuxfoundation.org>
References: <20251111004536.460310036@linuxfoundation.org>
User-Agent: quilt/0.69
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Schwöbel <jonasschwoebel@yahoo.de>

[ Upstream commit b49a73a08100ab139e07cfa7ca36e9b15787d0ab ]

Existing touchscreen clipping is too small and causes problems with
touchscreen accuracy.

Signed-off-by: Jonas Schwöbel <jonasschwoebel@yahoo.de>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts b/arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
index 2f7754fd42a16..c6ef0a20c19f3 100644
--- a/arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
+++ b/arch/arm/boot/dts/nvidia/tegra30-lg-p880.dts
@@ -108,8 +108,8 @@
 	i2c@7000c400 {
 		touchscreen@20 {
 			rmi4-f11@11 {
-				syna,clip-x-high = <1110>;
-				syna,clip-y-high = <1973>;
+				syna,clip-x-high = <1440>;
+				syna,clip-y-high = <2560>;
 
 				touchscreen-inverted-y;
 			};
-- 
2.51.0




