Return-Path: <stable+bounces-204792-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D6E8FCF3CC5
	for <lists+stable@lfdr.de>; Mon, 05 Jan 2026 14:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 52A7C300385B
	for <lists+stable@lfdr.de>; Mon,  5 Jan 2026 13:28:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 879F320E334;
	Mon,  5 Jan 2026 13:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wY1DMXsv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475E21DED63
	for <stable@vger.kernel.org>; Mon,  5 Jan 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767619644; cv=none; b=QICyFGq2xy+naEpjQeMwaoIx6a4WfW6Ukb+UosIUPVTJQHpc4M8qedXQteSh+D0nkVIbaOEQFF17xzvuVZVQb4Y/q2EHOo4MbPvXJ7+iEMDoiog0hsNhz00249lJW1pxPamLuwazk5UpO8I9/U8ZQ6njOtUodIzD7pXS9PIWjbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767619644; c=relaxed/simple;
	bh=OZk3OLuvXGpp3DffXZpJguXjubI5M6A7erf2Cmqrq+I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=UMUX9A2UDNA46dZm7JHdbzjsmOtAKjTmVa4QBD1RYiyKWxO0Q2YpHcltx79FPkayj1xnqMSYzn4GR4fyeRnZrF0Vjdxru0etmKgU2EGY2lP2U2V5ifAx0xw32yhRalqSOm4WDHvnUv2H9SKqVI+I5I2TLe1C932vK7Rolo2cXew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wY1DMXsv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60296C116D0;
	Mon,  5 Jan 2026 13:27:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767619642;
	bh=OZk3OLuvXGpp3DffXZpJguXjubI5M6A7erf2Cmqrq+I=;
	h=Subject:To:Cc:From:Date:From;
	b=wY1DMXsvKRRjyVqZNoUeU55u31Dsz87dHiCesL3zXMsd4+aFZzuiHXiNqXN6cv1ys
	 Os59VBdJIKsrkiD+w4qHklqAcRpqf+5PwmX82kSmJg54naIXpnMUzw33EOh4msWrtF
	 HutPUJRIqdQozmBgs4fDTJH3LpaUDZMYwTBuLmyw=
Subject: WTF: patch "[PATCH] drm: nouveau: Replace sprintf() with sysfs_emit()" was seriously submitted to be applied to the 6.18-stable tree?
To: madhurkumar004@gmail.com,lyude@redhat.com,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Jan 2026 14:27:19 +0100
Message-ID: <2026010519-labored-arming-4030@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit

The patch below was submitted to be applied to the 6.18-stable tree.

I fail to see how this patch meets the stable kernel rules as found at
Documentation/process/stable-kernel-rules.rst.

I could be totally wrong, and if so, please respond to 
<stable@vger.kernel.org> and let me know why this patch should be
applied.  Otherwise, it is now dropped from my patch queues, never to be
seen again.

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 979e2ec58de2b600955b8290d1df549e33d67347 Mon Sep 17 00:00:00 2001
From: Madhur Kumar <madhurkumar004@gmail.com>
Date: Fri, 5 Dec 2025 14:48:04 +0530
Subject: [PATCH] drm: nouveau: Replace sprintf() with sysfs_emit()

Replace sprintf() calls with sysfs_emit() to follow current kernel
coding standards.

sysfs_emit() is the preferred method for formatting sysfs output as it
provides better bounds checking and is more secure.

Signed-off-by: Madhur Kumar <madhurkumar004@gmail.com>
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patch.msgid.link/20251205091804.317801-1-madhurkumar004@gmail.com
Fixes: 11b7d895216f ("drm/nouveau/pm: manual pwm fanspeed management for nv40+ boards")
Cc: <stable@vger.kernel.org> # v3.3+

diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index 5c07a9ee8b77..34effe6d86ad 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -125,7 +125,7 @@ nouveau_hwmon_get_pwm1_max(struct device *d,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%i\n", ret);
+	return sysfs_emit(buf, "%i\n", ret);
 }
 
 static ssize_t
@@ -141,7 +141,7 @@ nouveau_hwmon_get_pwm1_min(struct device *d,
 	if (ret < 0)
 		return ret;
 
-	return sprintf(buf, "%i\n", ret);
+	return sysfs_emit(buf, "%i\n", ret);
 }
 
 static ssize_t


