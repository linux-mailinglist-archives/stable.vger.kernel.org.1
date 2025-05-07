Return-Path: <stable+bounces-142423-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 348BAAAEA92
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 20:57:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99C6C1B6501E
	for <lists+stable@lfdr.de>; Wed,  7 May 2025 18:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48C628B4F0;
	Wed,  7 May 2025 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F+onCYb5"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80FB61CF5C6;
	Wed,  7 May 2025 18:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746644205; cv=none; b=sWqE5nQcd3UGHkUe5FYN6wCuW9gq0ItdezbnN9e0fVxpkOzt+h8hvLvj8UcjwT8IBxuAnRCKBv1A4Xj0tJ6+7Mu1wXBuVg6zrGPrJ0/Cf8Ur0iYKauubt755l8q+Gvk6+RGQsYA9ugy37RHTABaBp5bHkr9bpmSlpD1TsdaWwhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746644205; c=relaxed/simple;
	bh=4NHqLvFL1t7fGOpRLFx/UOq6OzK/i2qWQNkLJKX1Sh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=J3qSFPBo1ACBH9BA/h8LODbu+CJS3WcLJF8uxv3ycrvavNyrjE1Bvp8mKoiXVzY9mEoZ3WIMxEa4RYLgJDceCMUJdF/f27ZBu4bjziRwGzJIQoDYUd2cXBisbBz4MD+3rDywFrJrrV+vXFwfDOE7SVuA1K6HdxiLYRp3WMKnZbs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F+onCYb5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12EF2C4CEE2;
	Wed,  7 May 2025 18:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746644205;
	bh=4NHqLvFL1t7fGOpRLFx/UOq6OzK/i2qWQNkLJKX1Sh4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F+onCYb5ktYOITyodvnjm/tY7i8eHH2FTjZoaod8WV4UCNoFCzhpLHstavYJ4UysU
	 EWsa8Z3nWNEVQXhigLFLN/cKpNvl0K11Z3PqYlNrAT9Ec+M1slki1kykP8ObnQM7i8
	 gfQsLDuIuyv9BEaYzcozLmVbTRGXN9+dHpBFnLDk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Romain THERY <romain.thery@ik.me>,
	Kurt Borja <kuurtb@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 6.14 153/183] platform/x86: alienware-wmi-wmax: Add support for Alienware m15 R7
Date: Wed,  7 May 2025 20:39:58 +0200
Message-ID: <20250507183831.062630419@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250507183824.682671926@linuxfoundation.org>
References: <20250507183824.682671926@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.14-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Kurt Borja <kuurtb@gmail.com>

commit 246f9bb62016c423972ea7f2335a8e0ed3521cde upstream.

Extend thermal control support to Alienware m15 R7.

Cc: stable@vger.kernel.org
Tested-by: Romain THERY <romain.thery@ik.me>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Link: https://lore.kernel.org/r/20250419-m15-r7-v1-1-18c6eaa27e25@gmail.com
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/platform/x86/dell/alienware-wmi.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/drivers/platform/x86/dell/alienware-wmi.c
+++ b/drivers/platform/x86/dell/alienware-wmi.c
@@ -252,6 +252,15 @@ static const struct dmi_system_id alienw
 	},
 	{
 		.callback = dmi_matched,
+		.ident = "Alienware m15 R7",
+		.matches = {
+			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "Alienware m15 R7"),
+		},
+		.driver_data = &quirk_x_series,
+	},
+	{
+		.callback = dmi_matched,
 		.ident = "Alienware m16 R1",
 		.matches = {
 			DMI_MATCH(DMI_SYS_VENDOR, "Alienware"),



