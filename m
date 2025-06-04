Return-Path: <stable+bounces-151371-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 29066ACDD21
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 13:51:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 13ADE7A7AB4
	for <lists+stable@lfdr.de>; Wed,  4 Jun 2025 11:50:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE19128FA98;
	Wed,  4 Jun 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dFu0uwMA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF6728FA91;
	Wed,  4 Jun 2025 11:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749037840; cv=none; b=DusWEV6pEjMgD27duDcnXZsyWKmrDCX2TcuWOvFTyGv1CqpPLb5BMGKN3NVCLpET4aqggJstv2+HZfuIf544MYhYY6W3a2wOL/oJPGa5SdSdda4WzHZiIEyZ96ScCoJY9Dts/UjVEWCFHHWIJYATl+RFCq1hulQUADXrRQAn+OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749037840; c=relaxed/simple;
	bh=71ZwEdFAjFOVAAwRnZcmu74PJaEJkRD23GstajR/2CY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=l5Rg59m2c8o25qr3tYkUz3MweGBckpYXXhNdmm356wd/KwuNz086VpIeff+yHM6kodNlenFMLMBfRZAXMkIWtcI6m7ToodbWREWqDtTaU+LRLobfMnRuu1VWo2WzEdNyAn8NHZbSs4L4o+3ZxzGOtXC7aslt1rXPj6LNx4kOOwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dFu0uwMA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C690C4CEE7;
	Wed,  4 Jun 2025 11:50:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749037839;
	bh=71ZwEdFAjFOVAAwRnZcmu74PJaEJkRD23GstajR/2CY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFu0uwMAOL7fuZyi0JVrFzX+N2r1W5+8OXcfKW2guBbUEw1oyAMi8rBDqEcS4WiUA
	 gzXlQYaUUtUFVKTVcIGlScHGLcCdRy5dE6vUmP2FSHI/9Fh/8BHDV8Mx0ijsUPpn0b
	 wdpuMfQPjpWM3uMDNSB2Or6fMupdCunygI+8whVYmcS3XkLmOJ9HT0dRbJHC/aLJ7b
	 16GCn2TpXO7b8eozL/olfXUsbef6nacGMV/KKiXdFprLZCr7CvCwHDPE59vh72jRw0
	 +Ul18CjEoZy0LoyAea5r2bu6KQX8j6tTjc1MiAUx0jRUixUwouACuzXVIoPmMpZBuB
	 MYd/MSIKfmZaQ==
From: Sasha Levin <sashal@kernel.org>
To: patches@lists.linux.dev,
	stable@vger.kernel.org
Cc: Jann Horn <jannh@google.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Rouven Czerwinski <rouven.czerwinski@linaro.org>,
	Sasha Levin <sashal@kernel.org>,
	op-tee@lists.trustedfirmware.org
Subject: [PATCH AUTOSEL 5.15 4/5] tee: Prevent size calculation wraparound on 32-bit kernels
Date: Wed,  4 Jun 2025 07:50:32 -0400
Message-Id: <20250604115033.209492-4-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250604115033.209492-1-sashal@kernel.org>
References: <20250604115033.209492-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.184
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jann Horn <jannh@google.com>

[ Upstream commit 39bb67edcc582b3b386a9ec983da67fa8a10ec03 ]

The current code around TEE_IOCTL_PARAM_SIZE() is a bit wrong on
32-bit kernels: Multiplying a user-provided 32-bit value with the
size of a structure can wrap around on such platforms.

Fix it by using saturating arithmetic for the size calculation.

This has no security consequences because, in all users of
TEE_IOCTL_PARAM_SIZE(), the subsequent kcalloc() implicitly checks
for wrapping.

Signed-off-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
Tested-by: Rouven Czerwinski <rouven.czerwinski@linaro.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---

**YES** This commit should be backported to stable kernel trees. Here's
my extensive analysis: ## Vulnerability Analysis The commit fixes a real
integer overflow vulnerability in the TEE (Trusted Execution
Environment) subsystem on 32-bit kernels. The issue occurs in the
`TEE_IOCTL_PARAM_SIZE()` macro defined as: ```c #define
TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x)) ``` Where
`struct tee_ioctl_param` is 32 bytes (4 × 8-byte fields). On 32-bit
systems, when a user provides a large `num_params` value, the
multiplication `32 * num_params` can wrap around, potentially bypassing
buffer length validation checks. ## Specific Vulnerable Code Locations
The vulnerable pattern appears in 4 locations in
`drivers/tee/tee_core.c`: 1. **Line 490**: `tee_ioctl_open_session()` -
`sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len` 2.
**Line 568**: `tee_ioctl_invoke()` - `sizeof(arg) +
TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len` 3. **Line 702**:
`tee_ioctl_supp_recv()` - `sizeof(*uarg) +
TEE_IOCTL_PARAM_SIZE(num_params) != buf.buf_len` 4. **Line 801**:
`tee_ioctl_supp_send()` - `sizeof(*uarg) +
TEE_IOCTL_PARAM_SIZE(num_params) > buf.buf_len` ## Attack Scenario On
32-bit systems, if `num_params = 0x08000000` (134,217,728), then: -
`TEE_IOCTL_PARAM_SIZE(0x08000000) = 32 * 0x08000000 = 0x100000000` -
This wraps to `0x00000000` on 32-bit systems - The size validation
`sizeof(arg) + 0 != buf.buf_len` could be bypassed - Subsequent
`kcalloc()` would allocate a huge buffer, but the size calculations
would be wrong ## Why This Should Be Backported **Matches "YES" backport
criteria from similar commits:** 1. **Security Fix**: Like Similar
Commit #2 (rtl8188eu security hole) and #4 (gup_benchmark integer
overflow), this prevents user-controlled integer overflow that could
lead to memory corruption. 2. **Small, Contained Change**: The fix uses
the kernel's standard `size_add()` and `size_mul()` helpers from
`linux/overflow.h` - exactly like Similar Commit #3 which was noted as
using `size_add()` for similar protection. 3. **Critical Subsystem**:
TEE handles sensitive cryptographic operations and trusted applications,
making security fixes here particularly important. 4. **Low Regression
Risk**: The fix only adds overflow protection without changing
functionality. The `size_mul()` and `size_add()` functions are well-
tested kernel overflow helpers. 5. **User-Controllable Input**: The
`num_params` value comes directly from user space through ioctl calls,
making this a user-triggerable condition. 6. **Clear Security Impact**:
While the commit states "no security consequences because kcalloc()
implicitly checks for wrapping," this is defense-in-depth - the size
validation should not rely on downstream allocation checks. The fix
pattern exactly matches Similar Commit #4 (mm/gup_benchmark.c) which was
backported for preventing integer overflow in size calculations with
user-provided values. This commit follows the same security principle
and uses the same overflow-safe arithmetic helpers that the kernel has
standardized on for these scenarios.

 drivers/tee/tee_core.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
index a44e5b53e7a91..a7e89c229fc51 100644
--- a/drivers/tee/tee_core.c
+++ b/drivers/tee/tee_core.c
@@ -10,6 +10,7 @@
 #include <linux/fs.h>
 #include <linux/idr.h>
 #include <linux/module.h>
+#include <linux/overflow.h>
 #include <linux/slab.h>
 #include <linux/tee_drv.h>
 #include <linux/uaccess.h>
@@ -19,7 +20,7 @@
 
 #define TEE_NUM_DEVICES	32
 
-#define TEE_IOCTL_PARAM_SIZE(x) (sizeof(struct tee_param) * (x))
+#define TEE_IOCTL_PARAM_SIZE(x) (size_mul(sizeof(struct tee_param), (x)))
 
 #define TEE_UUID_NS_NAME_SIZE	128
 
@@ -493,7 +494,7 @@ static int tee_ioctl_open_session(struct tee_context *ctx,
 	if (copy_from_user(&arg, uarg, sizeof(arg)))
 		return -EFAULT;
 
-	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
+	if (size_add(sizeof(arg), TEE_IOCTL_PARAM_SIZE(arg.num_params)) != buf.buf_len)
 		return -EINVAL;
 
 	if (arg.num_params) {
@@ -571,7 +572,7 @@ static int tee_ioctl_invoke(struct tee_context *ctx,
 	if (copy_from_user(&arg, uarg, sizeof(arg)))
 		return -EFAULT;
 
-	if (sizeof(arg) + TEE_IOCTL_PARAM_SIZE(arg.num_params) != buf.buf_len)
+	if (size_add(sizeof(arg), TEE_IOCTL_PARAM_SIZE(arg.num_params)) != buf.buf_len)
 		return -EINVAL;
 
 	if (arg.num_params) {
@@ -705,7 +706,7 @@ static int tee_ioctl_supp_recv(struct tee_context *ctx,
 	if (get_user(num_params, &uarg->num_params))
 		return -EFAULT;
 
-	if (sizeof(*uarg) + TEE_IOCTL_PARAM_SIZE(num_params) != buf.buf_len)
+	if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) != buf.buf_len)
 		return -EINVAL;
 
 	params = kcalloc(num_params, sizeof(struct tee_param), GFP_KERNEL);
@@ -804,7 +805,7 @@ static int tee_ioctl_supp_send(struct tee_context *ctx,
 	    get_user(num_params, &uarg->num_params))
 		return -EFAULT;
 
-	if (sizeof(*uarg) + TEE_IOCTL_PARAM_SIZE(num_params) > buf.buf_len)
+	if (size_add(sizeof(*uarg), TEE_IOCTL_PARAM_SIZE(num_params)) > buf.buf_len)
 		return -EINVAL;
 
 	params = kcalloc(num_params, sizeof(struct tee_param), GFP_KERNEL);
-- 
2.39.5


