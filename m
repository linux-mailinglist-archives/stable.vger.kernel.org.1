Return-Path: <stable+bounces-182718-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E812BADC90
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 17:24:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8C5E3178BA5
	for <lists+stable@lfdr.de>; Tue, 30 Sep 2025 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FFA818BBAE;
	Tue, 30 Sep 2025 15:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zJI98CYc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D4E416A956;
	Tue, 30 Sep 2025 15:24:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759245861; cv=none; b=i1wYZUjs/mI07jCKyptJlfNmmEYpdTutTOgDtgjpb0kdke0sjL92MMThqQIfEmlwN1wvh3fDUPhh9lAbwl7vFsf2p3ycNrsN5L+X6/DOytmVVyLWDQ2qM/Jl2hRgxVnOojAwI3eFDoX+2YEzIdxCNFiljwA8/G7NfP/2UepLAjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759245861; c=relaxed/simple;
	bh=U6UyMTXZnvvvnuoNznGs0lkFPgjy7XUGxPsRMy0EMas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Nn/D5GazxY7d0ab4QUD2375k3UDImgRzGHJksKQ8guv9qf3SSw4nfX4MN0JyNYd/JM9l4avMSTfhlBwOAMXFS42sSIEpBCtDX/aq3Bk0VjpzsyJ0B3qphnZ6z4AW0geaFKvjVTqIWwDmDN/+vVPdyLjJlF6CwTjk3jV0OgPyecU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zJI98CYc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67510C4CEF0;
	Tue, 30 Sep 2025 15:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1759245859;
	bh=U6UyMTXZnvvvnuoNznGs0lkFPgjy7XUGxPsRMy0EMas=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=zJI98CYcOx8nll/Ta0ueRvO5CEisjZzKZpB+qcGoaxcMEgGOBGzXydDBooYGtd6BK
	 zpqPuOtU+k8rOTwucIPnbqg8gFLcsJKyS9u7JrdtZuK39V3apeh+IBfdRBNPbqC/zB
	 b9TSxv9/ru9C/GCqaL00GEvioeaQbl0vRstcLWZQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH 6.6 72/91] ARM: bcm: Select ARM_GIC_V3 for ARCH_BRCMSTB
Date: Tue, 30 Sep 2025 16:48:11 +0200
Message-ID: <20250930143824.178934239@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250930143821.118938523@linuxfoundation.org>
References: <20250930143821.118938523@linuxfoundation.org>
User-Agent: quilt/0.69
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

From: Florian Fainelli <florian.fainelli@broadcom.com>

commit 2b28fe75c7dbe7ec322e706eed4622964409e21d upstream.

A number of recent Broadcom STB SoCs utilize a GIC-600 interrupt
controller thus requiring the use of the GICv3 driver.

Link: https://lore.kernel.org/r/20240726233414.2305526-1-florian.fainelli@broadcom.com
Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm/mach-bcm/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- a/arch/arm/mach-bcm/Kconfig
+++ b/arch/arm/mach-bcm/Kconfig
@@ -186,6 +186,7 @@ config ARCH_BRCMSTB
 	select ARCH_HAS_RESET_CONTROLLER
 	select ARM_AMBA
 	select ARM_GIC
+	select ARM_GIC_V3
 	select ARM_ERRATA_798181 if SMP
 	select HAVE_ARM_ARCH_TIMER
 	select ZONE_DMA if ARM_LPAE



