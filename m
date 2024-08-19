Return-Path: <stable+bounces-69491-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ADF7795671A
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 11:33:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D9D7B22931
	for <lists+stable@lfdr.de>; Mon, 19 Aug 2024 09:33:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC6E315ECCF;
	Mon, 19 Aug 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e8Xn477Z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7BEF115CD77
	for <stable@vger.kernel.org>; Mon, 19 Aug 2024 09:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059913; cv=none; b=QYqTSdN9W9oSbJ4IL/4UIit2Tyu/kG/aAkrCVHOmNHdKDeC+hEmONwkMP2OslKWwhoBvGnPBVlGPZiZzlQI/N87nFSZV+6m5YwjbsnxIrFmO4tIplwGlR3cb/OVn3If1ngtVJNDcO8HlFQ0giMotmc85es3XKQeMJWiq048teD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059913; c=relaxed/simple;
	bh=V8MNeDxuYGZ0bpe1U2s8XZzet0AWbiAt94yKVWaRV+U=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=biGuJRSsZnRTIPN/Euxi2I9pNQrODlhIIgEYHqzdaBbsZEp+2TdlVTZ2gM0ZXHee9NuRtrI/FLs91KzJWT+pq3cS/9dyshdXw7hPQCI6/DGQ34kGvxC534kin8l6Iq44/0qD/aPc4vpqB7TzbnN2bWelyKXOzcc/yBmBBZFxjrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e8Xn477Z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA2CC4AF0C;
	Mon, 19 Aug 2024 09:31:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724059913;
	bh=V8MNeDxuYGZ0bpe1U2s8XZzet0AWbiAt94yKVWaRV+U=;
	h=Subject:To:Cc:From:Date:From;
	b=e8Xn477ZH4vVXOFXHvqv8VLN7g04yfTZ8LxSETZ0X9D10tDs2r5DTUg8fhDLFyg+M
	 H6uoVIbUqp7l6RRphX2/OC3o7rVVujTKWT5hVlPC79dlntOJraXnCRUtutrpNFnulN
	 uZgv5OVnQYp6DV5SpWvnYaSiZTAIuKXZMKGM9C9o=
Subject: FAILED: patch "[PATCH] i2c: tegra: Do not mark ACPI devices as irq safe" failed to apply to 6.1-stable tree
To: leitao@debian.org,andi.shyti@kernel.org,andy@kernel.org,digetx@gmail.com,rmikey@meta.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 19 Aug 2024 11:31:50 +0200
Message-ID: <2024081950-amaze-wriggle-3057@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 14d069d92951a3e150c0a81f2ca3b93e54da913b
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024081950-amaze-wriggle-3057@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:

14d069d92951 ("i2c: tegra: Do not mark ACPI devices as irq safe")
4f5d68c85914 ("i2c: tegra: allow VI support to be compiled out")
a55efa7edf37 ("i2c: tegra: allow DVC support to be compiled out")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 14d069d92951a3e150c0a81f2ca3b93e54da913b Mon Sep 17 00:00:00 2001
From: Breno Leitao <leitao@debian.org>
Date: Tue, 13 Aug 2024 09:12:53 -0700
Subject: [PATCH] i2c: tegra: Do not mark ACPI devices as irq safe

On ACPI machines, the tegra i2c module encounters an issue due to a
mutex being called inside a spinlock. This leads to the following bug:

	BUG: sleeping function called from invalid context at kernel/locking/mutex.c:585
	...

	Call trace:
	__might_sleep
	__mutex_lock_common
	mutex_lock_nested
	acpi_subsys_runtime_resume
	rpm_resume
	tegra_i2c_xfer

The problem arises because during __pm_runtime_resume(), the spinlock
&dev->power.lock is acquired before rpm_resume() is called. Later,
rpm_resume() invokes acpi_subsys_runtime_resume(), which relies on
mutexes, triggering the error.

To address this issue, devices on ACPI are now marked as not IRQ-safe,
considering the dependency of acpi_subsys_runtime_resume() on mutexes.

Fixes: bd2fdedbf2ba ("i2c: tegra: Add the ACPI support")
Cc: <stable@vger.kernel.org> # v5.17+
Co-developed-by: Michael van der Westhuizen <rmikey@meta.com>
Signed-off-by: Michael van der Westhuizen <rmikey@meta.com>
Signed-off-by: Breno Leitao <leitao@debian.org>
Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Signed-off-by: Andi Shyti <andi.shyti@kernel.org>

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index 85b31edc558d..1df5b4204142 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1802,9 +1802,9 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	 * domain.
 	 *
 	 * VI I2C device shouldn't be marked as IRQ-safe because VI I2C won't
-	 * be used for atomic transfers.
+	 * be used for atomic transfers. ACPI device is not IRQ safe also.
 	 */
-	if (!IS_VI(i2c_dev))
+	if (!IS_VI(i2c_dev) && !has_acpi_companion(i2c_dev->dev))
 		pm_runtime_irq_safe(i2c_dev->dev);
 
 	pm_runtime_enable(i2c_dev->dev);


