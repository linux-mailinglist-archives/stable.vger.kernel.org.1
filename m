Return-Path: <stable+bounces-166125-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 25F2EB197D6
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 02:31:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5515C17087C
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 00:31:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC8F11C8FBA;
	Mon,  4 Aug 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl93khdJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78C462C190;
	Mon,  4 Aug 2025 00:30:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754267448; cv=none; b=KN4JL5XwICxxXCMxKVoHLAasg6/XlEIkgOIV/GQQWVNeCl++Mx3g4k9GsbbQsTytXxBzwJ4NewPYrFvx5o8ce7AGtibY4fmXDYpebzJgD9Ew9olYVdbMTsFVEi7NsOs33mixp+sprni+rPWBDTEObicIphIZo56o1HdtCotO4MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754267448; c=relaxed/simple;
	bh=bfLHrI+KHBL420kB9LvWPzH5vg3kP5L2x0mod4WtyLQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=jtOVV3vLGhtWRSg6xwicpn6eesFxWdxEBHEE8hAmO0GDAWohZLckX7pJkjLrNPH53RqKkmSYkiR9bZTCVuFfN3t4KOpWRVfyoMJ4mQZi9Lwz8JzDkgaB8mYGNsF2KUF1Wf1lJ9pVvBa5ImnxT4j1HmLb50YZo1vA6KNNgeYh1kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl93khdJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CECE0C4CEEB;
	Mon,  4 Aug 2025 00:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1754267448;
	bh=bfLHrI+KHBL420kB9LvWPzH5vg3kP5L2x0mod4WtyLQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=sl93khdJTo3Tchn0N73IuduQx7IFsH90c6N2LoSxWPAMLglJZ78rNMytJIntNhHm1
	 qb5w20rVy7r7ntytmY17BDPNc8RzMwpExvX5xCrn50as9kDdR8oxi+VoYaxMLdkd5+
	 wDceKIAUY+G3oVsr8V6Tnum6wa9xv0xd8w5XZx/AX1RkFTOdtuhV5oZc/8MvGoDsr8
	 iKQYhi+7F7qwCankU7b9uPf9lvSFRVYmQfmXhPvsDIx3GAz0Ur+wlFvYokZRHnj44U
	 fCnK/U4zltn84p5rsJoVuPAxmbh23DYREwlNNGfU+8f7c7P+H6dOWlaOAJ+JMJxUIu
	 jUNmjY921eqBw==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
	Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	michal.simek@amd.com,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.15 69/80] usb: dwc3: xilinx: add shutdown callback
Date: Sun,  3 Aug 2025 20:27:36 -0400
Message-Id: <20250804002747.3617039-69-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250804002747.3617039-1-sashal@kernel.org>
References: <20250804002747.3617039-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.15.9
Content-Transfer-Encoding: 8bit

From: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>

[ Upstream commit 70627bf82e36e61c40c3315e1206e4ea4c02e668 ]

Adds a shutdown callback to ensure that the XHCI stack is properly
shutdown in reboot/shutdown path.

In kexec flow, kernel_restart_prepare() performs actions necessary
to prepare the system for a restart and invokes device_shutdown. To
ensure proper shutdown attach the dwc3 shutdown implementation which
mirrors the remove method.

$ kexec -e

<snip>
xhci-hcd xhci-hcd.0.auto: remove, state 1
usb usb1: USB disconnect, device number 1
usb 1-1: USB disconnect, device number 6
xhci-hcd xhci-hcd.0.auto: USB bus 1 deregistered
kexec_core: Starting new kernel

Signed-off-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Link: https://lore.kernel.org/r/1748977771-714153-1-git-send-email-radhey.shyam.pandey@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

LLM Generated explanations, may be completely bogus:

**Backport Status: YES**

This commit should be backported to stable kernel trees. Here's my
detailed analysis:

## Analysis of the Commit

### 1. **Bug Fix Nature**
This commit fixes a real bug where the USB XHCI stack is not properly
shut down during kexec operations. The commit message explicitly shows
the issue - when `kexec -e` is executed, the XHCI controller is removed
but without a proper shutdown sequence, which can lead to:
- Memory corruption if the controller continues DMA operations
- System instability during kexec transitions
- Potential crashes after kexec

### 2. **Simple and Contained Fix**
The code change is minimal and low-risk:
```diff
+       .shutdown       = dwc3_xlnx_remove,
```
It simply reuses the existing `dwc3_xlnx_remove` function as the
shutdown callback. This is a common pattern in kernel drivers.

### 3. **Follows Established Pattern**
My analysis shows this follows an established pattern in the dwc3 driver
family:
- `dwc3-of-simple.c` uses its remove function for shutdown
- `dwc3-rtk.c` has a dedicated shutdown function that calls similar
  cleanup
- The recent Tegra XUSB commit (3a3be3a1ebf0) added a shutdown callback
  for similar reasons (preventing SMMU-related crashes)

### 4. **Clear Side Effects**
The `dwc3_xlnx_remove` function performs standard cleanup:
- Depopulates child devices (`of_platform_depopulate`)
- Disables and unprepares clocks
- Manages runtime PM state

These are all safe operations for shutdown context.

### 5. **Meets Stable Criteria**
- **Fixes a real bug**: Prevents potential system instability during
  kexec
- **Small change**: Single line addition
- **Low risk**: Reuses existing, tested code path
- **No new features**: Pure bug fix
- **Clear benefit**: Improves system reliability during reboot/kexec
  operations

### 6. **Similar Issues in Other Drivers**
The pattern of missing shutdown callbacks causing issues during
kexec/reboot is well-documented in the kernel, particularly for devices
that perform DMA operations.

The fix ensures proper hardware shutdown sequence during system
reboot/shutdown, preventing the USB controller from accessing memory
after the system has started transitioning to a new kernel or shutting
down. This is especially important for systems using kexec for fast
reboots or crash dump collection.

 drivers/usb/dwc3/dwc3-xilinx.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/usb/dwc3/dwc3-xilinx.c b/drivers/usb/dwc3/dwc3-xilinx.c
index 4ca7f6240d07..09c3c5c226ab 100644
--- a/drivers/usb/dwc3/dwc3-xilinx.c
+++ b/drivers/usb/dwc3/dwc3-xilinx.c
@@ -422,6 +422,7 @@ static const struct dev_pm_ops dwc3_xlnx_dev_pm_ops = {
 static struct platform_driver dwc3_xlnx_driver = {
 	.probe		= dwc3_xlnx_probe,
 	.remove		= dwc3_xlnx_remove,
+	.shutdown	= dwc3_xlnx_remove,
 	.driver		= {
 		.name		= "dwc3-xilinx",
 		.of_match_table	= dwc3_xlnx_of_match,
-- 
2.39.5


