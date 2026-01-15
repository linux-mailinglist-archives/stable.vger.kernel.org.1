Return-Path: <stable+bounces-208538-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 46944D25E85
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 17:55:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F79D300A34B
	for <lists+stable@lfdr.de>; Thu, 15 Jan 2026 16:55:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 156CD3BF2F1;
	Thu, 15 Jan 2026 16:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="n5z+5s/H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464303BF2F7;
	Thu, 15 Jan 2026 16:55:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768496135; cv=none; b=kkQcSX0/d8dfQpGed8dJcK1qo6nc0Fdk0Iqym8WhbgUAPzz1q22q3aTyA/aluVXgMz36V/bkkjWUan9iMUrBPfUbKOKbzAr2qZqc6vgf4jZS/JFBhN9EyA5vYiHqnOe0WRvAPAXZOADFPV599qhzIEPvvpDViU42ag+M4+JvDaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768496135; c=relaxed/simple;
	bh=zRODUFtwzKtPQ8WLS4If7B4OpXGpX2YJt/nt3N5ffYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=G+PAdeaHQyswixs8ZiXMY8PvCVsw2on54TQICQDUZQb4CZ4d81ROcd6pnIm98ltXP1rJnk+Ty3KxivbW0QVf7PjSpKtSdSMqc0FKL+2BmGX+u0CsoYqpNMpma/gBEB8+PMcgWsZNlvkWPLcC9FLHhYveal1CNYxUNjy70jwxsfA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=n5z+5s/H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDBA5C116D0;
	Thu, 15 Jan 2026 16:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768496134;
	bh=zRODUFtwzKtPQ8WLS4If7B4OpXGpX2YJt/nt3N5ffYQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=n5z+5s/H/kW1tx4dvpRZFDT3WKeZChmso6NwvsbbLV/QP+zHA6hvrfv3DLBVHUUFf
	 Am3LWkClFruAERlSgstfz+NRR8bxfzpURssm7W2G9RCLE7+YE1/udZgU8U1HqvUglY
	 riCotAMEztExL6sEvjU1sICboubclbtXScuJs+O8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alyssa Ross <hi@alyssa.is>,
	Danilo Krummrich <dakr@kernel.org>,
	Alexandre Courbot <acourbot@nvidia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 072/181] gpu: nova-core: select RUST_FW_LOADER_ABSTRACTIONS
Date: Thu, 15 Jan 2026 17:46:49 +0100
Message-ID: <20260115164204.923028209@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260115164202.305475649@linuxfoundation.org>
References: <20260115164202.305475649@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alexandre Courbot <acourbot@nvidia.com>

[ Upstream commit 3d3352e73a55a4ccf110f8b3419bbe2fbfd8a030 ]

RUST_FW_LOADER_ABSTRACTIONS was depended on by NOVA_CORE, but NOVA_CORE
is selected by DRM_NOVA. This creates a situation where, if DRM_NOVA is
selected, NOVA_CORE gets enabled but not RUST_FW_LOADER_ABSTRACTIONS,
which results in a build error.

Since the firmware loader is an implementation detail of the driver, it
should be enabled along with it, so change the "depends on" to a
"select".

Fixes: 54e6baf123fd ("gpu: nova-core: add initial driver stub")
Closes: https://lore.kernel.org/oe-kbuild-all/202512061721.rxKGnt5q-lkp@intel.com/
Tested-by: Alyssa Ross <hi@alyssa.is>
Acked-by: Danilo Krummrich <dakr@kernel.org>
Link: https://patch.msgid.link/20251106-b4-select-rust-fw-v3-2-771172257755@nvidia.com
Signed-off-by: Alexandre Courbot <acourbot@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/nova-core/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/nova-core/Kconfig b/drivers/gpu/nova-core/Kconfig
index 20d3e6d0d796e..527920f9c4d39 100644
--- a/drivers/gpu/nova-core/Kconfig
+++ b/drivers/gpu/nova-core/Kconfig
@@ -3,7 +3,7 @@ config NOVA_CORE
 	depends on 64BIT
 	depends on PCI
 	depends on RUST
-	depends on RUST_FW_LOADER_ABSTRACTIONS
+	select RUST_FW_LOADER_ABSTRACTIONS
 	select AUXILIARY_BUS
 	default n
 	help
-- 
2.51.0




