Return-Path: <stable+bounces-62111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 81FDC93E32F
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:27:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0E81C208C9
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ECA9145A03;
	Sun, 28 Jul 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G6YAG59h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48AC41459F7;
	Sun, 28 Jul 2024 00:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128169; cv=none; b=W+D/BYfEtsJaqYS2JlLVHIxSHKOi0BXMwws+RvYnuyWdcOSiCzx2cqNdo9hfVH561+Umfyw6b8VvBkMRbJrD4Oozs/KKRSJJ+pmU29q8PRkU8++BuQvpIfRArx0VgnEqzhnykoy43xNRRK7uAdzfPiXUGC2OnyqAW4CfgQoK+Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128169; c=relaxed/simple;
	bh=gy6QXuiiN10NZUo5qJCimcvef+4IP+hu4ho2/sIyk88=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XKde2vJqAkGiq60KtKydnNu4MfWlZQlkE8+nd/nQwFrZo2IvKITAjSZYag6yX+adMIQM2XPNQRRz03V5H0aaZ4Bv2Nx9ej/7kHaykJ9qiwlJe/wgwTgn5/Q+qonFemL48KDuStiBguMFghoRWoOjY9cRC5ekq5j7rd6JCAatMzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G6YAG59h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0CA2C32781;
	Sun, 28 Jul 2024 00:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128169;
	bh=gy6QXuiiN10NZUo5qJCimcvef+4IP+hu4ho2/sIyk88=;
	h=From:To:Cc:Subject:Date:From;
	b=G6YAG59hhNbr9MbPKStP7hGbXx7i37TuLkZTXdq5W446DziW+GuVcbA6LRWrnXecf
	 rcANihc9ydUCnRmt61rbcefSZXbrwiVpm6unCnibTj6+KFiSwZ+WmGie+DpAqwogBk
	 nJbRfUbTff0jmFfOKuYljfr4xeHbv4hoje7Qx56TuuZoUvrTqXZnayxue90oiR04Ai
	 O3muesFq0VI5Qk28owBJCvgs8ho6D6dtvNMCTyfbDWS4XfPbQbGBuX0fHf5eqlfDxa
	 rrXuCDurFIuWjSa/jhUzVa/W/Pto/cR+49bUg6PE4qulM5dqVCSU0STQwfScaAjQkb
	 zZRgYZeoOr9zA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Heiner Kallweit <hkallweit1@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	nic_swsd@realtek.com,
	davem@davemloft.net,
	edumazet@google.com,
	pabeni@redhat.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 1/6] r8169: remove detection of chip version 11 (early RTL8168b)
Date: Sat, 27 Jul 2024 20:55:58 -0400
Message-ID: <20240728005606.1735387-1-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.223
Content-Transfer-Encoding: 8bit

From: Heiner Kallweit <hkallweit1@gmail.com>

[ Upstream commit 982300c115d229565d7af8e8b38aa1ee7bb1f5bd ]

This early RTL8168b version was the first PCIe chip version, and it's
quite quirky. Last sign of life is from more than 15 yrs ago.
Let's remove detection of this chip version, we'll see whether anybody
complains. If not, support for this chip version can be removed a few
kernel versions later.

Signed-off-by: Heiner Kallweit <hkallweit1@gmail.com>
Link: https://lore.kernel.org/r/875cdcf4-843c-420a-ad5d-417447b68572@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/realtek/r8169_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/realtek/r8169_main.c b/drivers/net/ethernet/realtek/r8169_main.c
index d24eb5ee152a5..7d3443ad8e797 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2018,7 +2018,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 		/* 8168B family. */
 		{ 0x7cf, 0x380,	RTL_GIGA_MAC_VER_12 },
 		{ 0x7c8, 0x380,	RTL_GIGA_MAC_VER_17 },
-		{ 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
+		/* This one is very old and rare, let's see if anybody complains.
+		 * { 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
+		 */
 
 		/* 8101 family. */
 		{ 0x7c8, 0x448,	RTL_GIGA_MAC_VER_39 },
-- 
2.43.0


