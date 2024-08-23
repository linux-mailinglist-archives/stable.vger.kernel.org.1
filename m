Return-Path: <stable+bounces-69951-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A440995C832
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 10:39:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E2431F229DC
	for <lists+stable@lfdr.de>; Fri, 23 Aug 2024 08:39:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0398D149019;
	Fri, 23 Aug 2024 08:39:07 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 235A81474D7
	for <stable@vger.kernel.org>; Fri, 23 Aug 2024 08:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724402346; cv=none; b=PwP84AL6BT+5dJ40njBhjYBn9XBo0Twg8mvcfpDI4mHQ2D0AwN/oJekcWk9HYrN8ft+3DsTZvYmFXs/b7JO+Fq9xY8u88OAp0n51VBGBbd+937J3KzbioXYjjwAUwUVTBKWy+HGmxM9AmWGZpxhE9L0XvOXaRXmWdWzTMW7VPuM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724402346; c=relaxed/simple;
	bh=jmP+67+kzGgCVdYMDJFUqEVPPDYl1rjbAR7aJZ21ZFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mmIgNdYNv8sceEa4emmo+rKE45LenLEjwPhmd+Ef/dR3sv3y9cG/VivZu/QaGc1sRVfhWzx9m7mxxDHZyqtsSuhLSY6jA1jYJdw1UCXUpYiQAo+W7po6Kimi1fYhf1kXVO1YIYG0UWSbFyQ/ylV+x6Az+8UePyoSs+gp+5n4FEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-a8657900fc1so271705666b.1
        for <stable@vger.kernel.org>; Fri, 23 Aug 2024 01:39:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724402343; x=1725007143;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xvj9hxMUgrCPts/g24ndvu4n5zYtmQ0Zl5d7YT1KCtk=;
        b=RliQjHAgytVgGnhZi/9HInv1I+xriKqA8/VKhpN86vsgq0GHpDRCvqrfNe48KNa1MU
         7/4Hj5287vmypzQtmsKqHxivS8i2lZxWAnaT3HpvPh7obTCcE3P1/O+UU6osrOLG4fuz
         1E7lJodnJ6PTcI4uS7GCXMIJGqlJT4aT3e7we6+YIIfKmKDyoEajkldTxsew6KbT06D/
         pkYjUJRM34+frpxLTgGtruZ4d3FtTFF8wGRBzYaqrzTnNmYlFXmhy/SoUYVyVra1k5nx
         2NKAjaeJXzPC21ECAJZPBzPc/KvcYsQuzRostd+3YiaE6v30Um5B1Fcf0IrhB62NHwFY
         GIvQ==
X-Gm-Message-State: AOJu0YzPNvfVH/gFBl8CZVTskBlr6TrMFhPPZxTpzCMtCEmKE4bYrypo
	c21jvJ6MvLoiMO1rOmO2HwU7nwbKrV6PbzudRXxwVkAQvFDBoDBSCsq+foIm
X-Google-Smtp-Source: AGHT+IGvXwtcat/bGMRqlYp6caR4VW0wZZDiE6MVfQBnJ++bIFez4yvvIoVH6sTRWyRwMTmtq5X4QQ==
X-Received: by 2002:a17:907:9408:b0:a80:bf0f:2256 with SMTP id a640c23a62f3a-a86a51751fdmr97592266b.8.1724402342477;
        Fri, 23 Aug 2024 01:39:02 -0700 (PDT)
Received: from localhost (fwdproxy-lla-005.fbsv.net. [2a03:2880:30ff:5::face:b00c])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a868f4360e7sm226343766b.123.2024.08.23.01.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Aug 2024 01:39:02 -0700 (PDT)
From: Breno Leitao <leitao@debian.org>
To: stable@vger.kernel.org
Cc: Michael van der Westhuizen <rmikey@meta.com>,
	Dmitry Osipenko <digetx@gmail.com>,
	Andy Shevchenko <andy@kernel.org>
Subject: [PATCH 6.1.y] i2c: tegra: Do not mark ACPI devices as irq safe
Date: Fri, 23 Aug 2024 01:38:50 -0700
Message-ID: <20240823083850.2250934-1-leitao@debian.org>
X-Mailer: git-send-email 2.43.5
In-Reply-To: <2024081950-amaze-wriggle-3057@gregkh>
References: <2024081950-amaze-wriggle-3057@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

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
(cherry picked from commit 14d069d92951a3e150c0a81f2ca3b93e54da913b)
---
 drivers/i2c/busses/i2c-tegra.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/i2c/busses/i2c-tegra.c b/drivers/i2c/busses/i2c-tegra.c
index aa469b33ee2ee..86d3689152457 100644
--- a/drivers/i2c/busses/i2c-tegra.c
+++ b/drivers/i2c/busses/i2c-tegra.c
@@ -1823,9 +1823,9 @@ static int tegra_i2c_probe(struct platform_device *pdev)
 	 * domain.
 	 *
 	 * VI I2C device shouldn't be marked as IRQ-safe because VI I2C won't
-	 * be used for atomic transfers.
+	 * be used for atomic transfers. ACPI device is not IRQ safe also.
 	 */
-	if (!i2c_dev->is_vi)
+	if (!i2c_dev->is_vi && !has_acpi_companion(i2c_dev->dev))
 		pm_runtime_irq_safe(i2c_dev->dev);
 
 	pm_runtime_enable(i2c_dev->dev);
-- 
2.43.5


