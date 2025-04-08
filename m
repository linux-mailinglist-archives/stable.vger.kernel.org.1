Return-Path: <stable+bounces-130030-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9019EA80270
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 13:47:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DECA4189210C
	for <lists+stable@lfdr.de>; Tue,  8 Apr 2025 11:43:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D6264A76;
	Tue,  8 Apr 2025 11:43:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wq2i1HKL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E5F227EBD;
	Tue,  8 Apr 2025 11:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744112626; cv=none; b=UQbrTxdqEmDZybVMro7vecdApTtrPtfHc+OptmIbfF0Rs6QDOYq+iKvyovpLFKc2lIKPHIMZwAwKGboXy7BFGmJalDm9wBewzgLRDr7fZB+5TTjeRFJnEvVu257en/BMkO2vlOr1B4zAt90a9HM4s8QXCyZQmMalm0YyoN8IOUI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744112626; c=relaxed/simple;
	bh=LdMjE7qqXEAjuTFWu7GfD2z2sbF5r8u7VAxKpbAnOjk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cJsrWbgQS6cdvhWZuNCGGl590o4+PKIYR7+2OKty0k9dnCdfypvcCpbvCZMHcaIijOye5+kOnuK48WgC1+4JaXGc2c/t02r7a8QPImzlPUFFOVVRxmAPjPOcznvtRsmSp1aiXwvzLppEkAMRPtaoTwUMylLFfb9/m8h2c3j55vI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wq2i1HKL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FFC2C4CEE5;
	Tue,  8 Apr 2025 11:43:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744112626;
	bh=LdMjE7qqXEAjuTFWu7GfD2z2sbF5r8u7VAxKpbAnOjk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wq2i1HKL40/jl6OoSggG37yzu3QQRAm0HA0dwVQamF9S37Hx1HVzN8eWECLyO6XGU
	 33IgHELrTYwt0rDzje+AY/3dgQ7KFOxhJc3AyVvzTPylp1LvTNNZBgPSm/hP8tVY3m
	 0/a55H/r4BBFySrc07tQPa4iIP2papwKjt4EM4MI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Chenyuan Yang <chenyuan0y@gmail.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>,
	"Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 139/279] thermal: int340x: Add NULL check for adev
Date: Tue,  8 Apr 2025 12:48:42 +0200
Message-ID: <20250408104830.092814448@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250408104826.319283234@linuxfoundation.org>
References: <20250408104826.319283234@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Chenyuan Yang <chenyuan0y@gmail.com>

[ Upstream commit 2542a3f70e563a9e70e7ded314286535a3321bdb ]

Not all devices have an ACPI companion fwnode, so adev might be NULL.
This is similar to the commit cd2fd6eab480
("platform/x86: int3472: Check for adev == NULL").

Add a check for adev not being set and return -ENODEV in that case to
avoid a possible NULL pointer deref in int3402_thermal_probe().

Note, under the same directory, int3400_thermal_probe() has such a
check.

Fixes: 77e337c6e23e ("Thermal: introduce INT3402 thermal driver")
Signed-off-by: Chenyuan Yang <chenyuan0y@gmail.com>
Acked-by: Uwe Kleine-König <u.kleine-koenig@baylibre.com>
Link: https://patch.msgid.link/20250313043611.1212116-1-chenyuan0y@gmail.com
[ rjw: Subject edit, added Fixes: ]
Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/thermal/intel/int340x_thermal/int3402_thermal.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
index 43fa351e2b9ec..b7fdf25bfd237 100644
--- a/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
+++ b/drivers/thermal/intel/int340x_thermal/int3402_thermal.c
@@ -45,6 +45,9 @@ static int int3402_thermal_probe(struct platform_device *pdev)
 	struct int3402_thermal_data *d;
 	int ret;
 
+	if (!adev)
+		return -ENODEV;
+
 	if (!acpi_has_method(adev->handle, "_TMP"))
 		return -ENODEV;
 
-- 
2.39.5




