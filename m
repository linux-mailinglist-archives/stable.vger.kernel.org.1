Return-Path: <stable+bounces-78662-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 421E098D456
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 15:19:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C170DB20C05
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 13:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9317B1D040E;
	Wed,  2 Oct 2024 13:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="z8KrYxrq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE6A25771;
	Wed,  2 Oct 2024 13:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727875155; cv=none; b=uzOfUmYt6Zh30KrRdZyn7sleoCbwI9upQmz+TiDBCElmFE7uPSF16If6SyknImxPIxfp0RrmOQVrC8BGUEfafNxHPQwPI9l6ZamkzBr4FD4huZ7tMB7fdwbdgCFEZ/mS5NQQPteQrjz6P6D/w74T2MhH1EzTUDCJGMGkcNBVsR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727875155; c=relaxed/simple;
	bh=pb/XhFBvVrR63AjEa3A4s292qsr7qb/3EwBqQN1t4Xs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gnanEM1hn/uKaCMRhTGv9cXppSp8mUSFNAu3z1xr5Ml1vJzi1SSD1Bd+GdQI0KFzk1uJwZxyvrd328Z722JUoKL2PPHLZFUXP0F41XdpzKxmZ/4NUzKq0FSzlf95nAz42SHw1pihCgF/3WaLk3impBnK4hQqLHDxAkT5YtBPewI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=z8KrYxrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 704EBC4CEC5;
	Wed,  2 Oct 2024 13:19:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727875154;
	bh=pb/XhFBvVrR63AjEa3A4s292qsr7qb/3EwBqQN1t4Xs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=z8KrYxrqAdygld1XgIQWetOurOPhwikr+T2mwi7rvVJGu2bY/u80uc1DD4NerTmzH
	 iiBj+LK0tYBkOSQk5XHQ0ioIaD3wuZaO3DFG8VymfT1V1eXX/5GzcG7LzSd/fSumkU
	 tRUmMuA94RR8U0iCQ9vAcrKhpvSOkSzTPPUCgKm8=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.11 010/695] eth: fbnic: select DEVLINK and PAGE_POOL
Date: Wed,  2 Oct 2024 14:50:08 +0200
Message-ID: <20241002125822.899327764@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125822.467776898@linuxfoundation.org>
References: <20241002125822.467776898@linuxfoundation.org>
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

From: Simon Horman <horms@kernel.org>

[ Upstream commit 9a95b7a89dffae5f1e99dd73748f144fec820292 ]

Build bot reports undefined references to devlink functions.
And local testing revealed undefined references to page_pool functions.

Based on a patch by Jakub Kicinski <kuba@kernel.org>

Fixes: 1a9d48892ea5 ("eth: fbnic: Allocate core device specific structures and devlink interface")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202408011219.hiPmwwAs-lkp@intel.com/
Signed-off-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20240802-fbnic-select-v2-1-41f82a3e0178@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/meta/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/meta/Kconfig b/drivers/net/ethernet/meta/Kconfig
index c002ede364020..85519690b8377 100644
--- a/drivers/net/ethernet/meta/Kconfig
+++ b/drivers/net/ethernet/meta/Kconfig
@@ -23,6 +23,8 @@ config FBNIC
 	depends on !S390
 	depends on MAX_SKB_FRAGS < 22
 	depends on PCI_MSI
+	select NET_DEVLINK
+	select PAGE_POOL
 	select PHYLINK
 	help
 	  This driver supports Meta Platforms Host Network Interface.
-- 
2.43.0




