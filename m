Return-Path: <stable+bounces-62054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EA5993E26E
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 03:06:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 80C48B2349D
	for <lists+stable@lfdr.de>; Sun, 28 Jul 2024 01:06:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7D544DA13;
	Sun, 28 Jul 2024 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sISvAP0S"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5254AEF7;
	Sun, 28 Jul 2024 00:53:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722128016; cv=none; b=UBkERtd/AVuiE7dptOPS+LpoMK8yfvUYeO69f2Uuh0Q43jPMt+tlerrsz7gkvda5gdqIcptK5UMNqNqKhlvbTqFmZ6glEMhveLj7gfCfXg+GC7oktCEgENPoESLOl/ZA0fDWTu6iP4HTSQ86Ct3vjeljvMzjDy+NsKzN6f7aLV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722128016; c=relaxed/simple;
	bh=8huf2b1zUDtI/+aB/o9iSX4DPMdv9JttLYPxCmKelVc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RHybEhQxZLvgn56Irnet0Vv+PotBifsv80uRn+vBGy99OhWFmpMnnvKUzrq8zfnlqGjW7c6SARrdYpZoWAiFE5EgPwPio4uv7+Ljc4OY4VUCqYNof2Vx+dvb8NNSjQOWzkWIBKwgMZMnxc4f6dU0WddkYuIJzYlm+6NjKJ1ku2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sISvAP0S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3E2C32781;
	Sun, 28 Jul 2024 00:53:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1722128016;
	bh=8huf2b1zUDtI/+aB/o9iSX4DPMdv9JttLYPxCmKelVc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sISvAP0SH74R88G5T7GmJTeCsy6rIGFguhRViJrqEbrZL3qW4vHBNtznXaixvJmqI
	 uiKWWuv/6Q1N1jfo0pf7o+XmtP9LNiURLU9Nk18p3aWTIdjw68+MJ9gAYlT1wT4NaG
	 Sz+x2l0asF94fcRbGbqiF1T/9XV2xxpkai+Gydi5ZzVsvcFWfXBgaCj0hI9wiPC6VA
	 byXziyMXI5kaAqToUnzAKCMUGphFnO/6p+g9iUaM9SbDO6W/4nIdAcNHFvmOa2OVJc
	 k8LfNSN3kyRKDt8dIPer9nTIqXj5lpBDEudG1RBjCF3thi2WjEa7AihG/imuJP3uA9
	 X9dqaQaKWBv2Q==
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
Subject: [PATCH AUTOSEL 6.10 03/27] r8169: remove detection of chip version 11 (early RTL8168b)
Date: Sat, 27 Jul 2024 20:52:46 -0400
Message-ID: <20240728005329.1723272-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240728005329.1723272-1-sashal@kernel.org>
References: <20240728005329.1723272-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.10.2
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
index 7b9e04884575e..d2d46fe17631a 100644
--- a/drivers/net/ethernet/realtek/r8169_main.c
+++ b/drivers/net/ethernet/realtek/r8169_main.c
@@ -2274,7 +2274,9 @@ static enum mac_version rtl8169_get_mac_version(u16 xid, bool gmii)
 
 		/* 8168B family. */
 		{ 0x7c8, 0x380,	RTL_GIGA_MAC_VER_17 },
-		{ 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
+		/* This one is very old and rare, let's see if anybody complains.
+		 * { 0x7c8, 0x300,	RTL_GIGA_MAC_VER_11 },
+		 */
 
 		/* 8101 family. */
 		{ 0x7c8, 0x448,	RTL_GIGA_MAC_VER_39 },
-- 
2.43.0


