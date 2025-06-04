Return-Path: <stable+bounces-151154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E4B1ACD3EE
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 03:24:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6ECDA7AB617
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 01:21:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BDC269D0C;
	Wed,  4 Jun 2025 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hf66xPBY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8422C2101B7;
	Wed,  4 Jun 2025 01:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748999048; cv=none; b=pjqAxP5V90Qc56e8ZD8VWCoaLkekkVSoP02qHZMo80nr4u/CvBn0W8DR5tvnmTz62T25Y2VxBkq7i8MwffNqcYgBjvfMev4gyS789UVIFqA81+RZXYzUHB937TqJeicYboyKTYrtS2V7XhbOwZfAJYxBW0rlwIT2lCcLKRgIk+8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748999048; c=relaxed/simple;
	bh=nGLUuk8PrJoHmmLNS99QbGwMgWx12JTyt0gdT4qTMCc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OKAkmqO4Yv0dWWMvaDLjViUAigIlAEK2M5xscO+agLQXb3RCDbKMDjFKGzj2jEiAzrCjp1jlQZdWfqbTwaIp7VNpyZSCw3faxjAOhnZmltSTKihTQC4/gSFFgFJ6RUFtfFa8auF8bcgXFJvwiy5nGbq3hON/M8fgw3odRF9nmh8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hf66xPBY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7491CC4CEEF;
	Wed,  4 Jun 2025 01:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1748999048;
	bh=nGLUuk8PrJoHmmLNS99QbGwMgWx12JTyt0gdT4qTMCc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hf66xPBYnROgfhtxkM5Fxa3bLZS7RKx68iPcfpvPG5r0q7aNxF413AzOWhf7ZXwcp
	 kD8rAlywl/a2l1oMZlxABieZdAWfN9X7SN60W8BJ5zNj7gxDeOF6/y6AmU/GF+oYh7
	 kMD5F/ig/OEgMAPxhDr6463iQWrQuCyESEIwvzwm6KGMZTfrgAUuT+VzO3F8HijRd4
	 no+eE6JFrPgvy2cYGdQz47hUXCF55/oDvzW4qw/PLmyex+w5T1noKrvVYT/yt64VSr
	 FcrHjpefv/mWeUMVc+inJJ6V+JMklxBzzhmoIKIyBoWX4EvDVJl/ObOTJUZ5X5Ux9o
	 vCFWzyGFDcm2w==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Rengarajan S <rengarajan.s@microchip.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	bryan.whitehead@microchip.com,
	UNGLinuxDriver@microchip.com,
	netdev@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 02/46] net: lan743x: Modify the EEPROM and OTP size for PCI1xxxx devices
Date: Tue,  3 Jun 2025 21:03:20 -0400
Message-Id: <20250604010404.5109-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604010404.5109-1-sashal@kernel.org>
References: <20250604010404.5109-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.140
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Rengarajan S <rengarajan.s@microchip.com>

[ Upstream commit 3b9935586a9b54d2da27901b830d3cf46ad66a1e ]

Maximum OTP and EEPROM size for hearthstone PCI1xxxx devices are 8 Kb
and 64 Kb respectively. Adjust max size definitions and return correct
EEPROM length based on device. Also prevent out-of-bound read/write.

Signed-off-by: Rengarajan S <rengarajan.s@microchip.com>
Link: https://patch.msgid.link/20250523173326.18509-1-rengarajan.s@microchip.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my detailed analysis: ## Security Fix Classification This commit
addresses a **security vulnerability** by adding bounds checking to
prevent out-of-bounds reads and writes in EEPROM/OTP operations for
PCI1xxxx devices. The commit explicitly states "Also prevent out-of-
bound read/write" in the commit message, making this a clear security
fix. ## Code Analysis Details The commit adds critical bounds checking
in four functions: 1. **`lan743x_hs_otp_read()`** - Adds `if (offset +
length > MAX_HS_OTP_SIZE) return -EINVAL;` 2.
**`lan743x_hs_otp_write()`** - Adds `if (offset + length >
MAX_HS_OTP_SIZE) return -EINVAL;` 3. **`lan743x_hs_eeprom_read()`** -
Adds `if (offset + length > MAX_HS_EEPROM_SIZE) return -EINVAL;` 4.
**`lan743x_hs_eeprom_write()`** - Adds `if (offset + length >
MAX_HS_EEPROM_SIZE) return -EINVAL;` The new size limits are: -
`MAX_HS_OTP_SIZE = 8 linux 1024` (8KB) - `MAX_HS_EEPROM_SIZE = 64 linux
1024` (64KB) ## Vulnerability Impact Without these bounds checks, the
functions could perform out-of-bounds memory operations when: - User-
space provides large `offset` or `length` values via ethtool EEPROM/OTP
access - The hardware access operations could read/write beyond the
intended EEPROM/OTP memory regions - This could potentially lead to
memory corruption or information disclosure ## Context from Kernel Tree
Analysis The kernel tree analysis confirms that: - The original LAN743x
functions already had proper bounds checking - The newer Hearthstone
PCI1xxxx variants lacked these critical safety checks - This creates an
inconsistency where newer hardware had weaker security protections - The
commit message explicitly mentions preventing "out-of-bound read/write"
## Backport Suitability Criteria ✅ **Fixes important security
vulnerability**: Prevents out-of-bounds memory access ✅ **Small and
contained change**: Only adds 4 simple bounds checks, minimal code
change ✅ **Low regression risk**: Simple validation logic that only
rejects invalid inputs ✅ **Clear side effects**: Only affects invalid
operations that should fail anyway ✅ **No architectural changes**:
Maintains existing function interfaces and behavior ✅ **Affects critical
subsystem**: Network driver EEPROM/OTP access with potential security
implications ## Comparison with Similar Commits The similar commits
shown all have "Backport Status: NO" but they are primarily feature
additions (new EEPROM support, SGMII support, performance improvements).
This commit is fundamentally different as it's a **security fix**
addressing missing bounds validation, not a new feature. ## Conclusion
This commit represents a textbook example of a stable tree backport
candidate: it's a small, targeted security fix that prevents out-of-
bounds memory access with minimal code changes and negligible regression
risk. The absence of bounds checking in the Hearthstone variants while
present in the original LAN743x functions suggests this was an oversight
that needs correction across all supported kernel versions.

 .../net/ethernet/microchip/lan743x_ethtool.c   | 18 ++++++++++++++++--
 1 file changed, 16 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/microchip/lan743x_ethtool.c b/drivers/net/ethernet/microchip/lan743x_ethtool.c
index e47a579410fbb..bd00ee2ca69fd 100644
--- a/drivers/net/ethernet/microchip/lan743x_ethtool.c
+++ b/drivers/net/ethernet/microchip/lan743x_ethtool.c
@@ -18,6 +18,8 @@
 #define EEPROM_MAC_OFFSET		    (0x01)
 #define MAX_EEPROM_SIZE			    (512)
 #define MAX_OTP_SIZE			    (1024)
+#define MAX_HS_OTP_SIZE			    (8 * 1024)
+#define MAX_HS_EEPROM_SIZE		    (64 * 1024)
 #define OTP_INDICATOR_1			    (0xF3)
 #define OTP_INDICATOR_2			    (0xF7)
 
@@ -272,6 +274,9 @@ static int lan743x_hs_otp_read(struct lan743x_adapter *adapter, u32 offset,
 	int ret;
 	int i;
 
+	if (offset + length > MAX_HS_OTP_SIZE)
+		return -EINVAL;
+
 	ret = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (ret < 0)
 		return ret;
@@ -320,6 +325,9 @@ static int lan743x_hs_otp_write(struct lan743x_adapter *adapter, u32 offset,
 	int ret;
 	int i;
 
+	if (offset + length > MAX_HS_OTP_SIZE)
+		return -EINVAL;
+
 	ret = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (ret < 0)
 		return ret;
@@ -497,6 +505,9 @@ static int lan743x_hs_eeprom_read(struct lan743x_adapter *adapter,
 	u32 val;
 	int i;
 
+	if (offset + length > MAX_HS_EEPROM_SIZE)
+		return -EINVAL;
+
 	retval = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (retval < 0)
 		return retval;
@@ -539,6 +550,9 @@ static int lan743x_hs_eeprom_write(struct lan743x_adapter *adapter,
 	u32 val;
 	int i;
 
+	if (offset + length > MAX_HS_EEPROM_SIZE)
+		return -EINVAL;
+
 	retval = lan743x_hs_syslock_acquire(adapter, LOCK_TIMEOUT_MAX_CNT);
 	if (retval < 0)
 		return retval;
@@ -604,9 +618,9 @@ static int lan743x_ethtool_get_eeprom_len(struct net_device *netdev)
 	struct lan743x_adapter *adapter = netdev_priv(netdev);
 
 	if (adapter->flags & LAN743X_ADAPTER_FLAG_OTP)
-		return MAX_OTP_SIZE;
+		return adapter->is_pci11x1x ? MAX_HS_OTP_SIZE : MAX_OTP_SIZE;
 
-	return MAX_EEPROM_SIZE;
+	return adapter->is_pci11x1x ? MAX_HS_EEPROM_SIZE : MAX_EEPROM_SIZE;
 }
 
 static int lan743x_ethtool_get_eeprom(struct net_device *netdev,
-- 
2.39.5


