Return-Path: <stable+bounces-109822-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 293B3A183FA
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 19:02:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D78807A2AB1
	for <lists+stable@lfdr.de>; Tue, 21 Jan 2025 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134C81F472D;
	Tue, 21 Jan 2025 18:02:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="A8cnkFim"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DB61F0E36;
	Tue, 21 Jan 2025 18:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737482539; cv=none; b=jHZErzyQ72wSIGUuNn9H0dlaAH1R3wY8GQiu+qEKEosUWJmiH0K+PgmsAzF578XAGAWvgIPPPAJsRivz/Nqq9OhytMJOhgcD7OFzQbcA1nIEznNM0FcFm6Rbkb/vtkgKFyoOO7mQJge1NHONw4d4yP1iZkkJi+OCuqr44V09Vek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737482539; c=relaxed/simple;
	bh=QRqrO3nESGufnXQr17wvnmwBMzw+KA6zzOjMZ06PVIY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=X9h2DW84NU7vnT6puO0DOX5Ag3k4VPBzVvYlzPhop7pANQU/enRdgZBj7lo6ZZ/SljpGyMe+i2txbFLB2krp2EPKt/dHc5ksWO9lVp6fbWi8oQ0VCF6Zd7VvFKmRksgCsEZbVDvdQoaWoikmsg7d+NiJfbTkWTWVL6wsa1DUgMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=A8cnkFim; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4FE27C4CEDF;
	Tue, 21 Jan 2025 18:02:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1737482539;
	bh=QRqrO3nESGufnXQr17wvnmwBMzw+KA6zzOjMZ06PVIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A8cnkFimG7D//sKDDj4NyMPbVfWqeveqcLuBgoumcUJpt6D5HyrVJvuLND9JXXNtW
	 yuNgVzolUgH/LyPb4ylRJRXVjKeODxgBiIYX6nmG2Bo9UsL73fylOnGJc3Aw5D5RLm
	 hIrqpuG3M+CkMQAXbJ5CmUccIymi5Lshmt7l25TA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 6.12 112/122] drm/xe/oa: Add missing VISACTL mux registers
Date: Tue, 21 Jan 2025 18:52:40 +0100
Message-ID: <20250121174537.369293260@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250121174532.991109301@linuxfoundation.org>
References: <20250121174532.991109301@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ashutosh Dixit <ashutosh.dixit@intel.com>

commit 79a21fc921d7aafaf69d00b4938435b81bf66022 upstream.

Add missing VISACTL mux registers required for some OA
config's (e.g. RenderPipeCtrl).

Fixes: cdf02fe1a94a ("drm/xe/oa/uapi: Add/remove OA config perf ops")
Cc: stable@vger.kernel.org
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250111021539.2920346-1-ashutosh.dixit@intel.com
(cherry picked from commit c26f22dac3449d8a687237cdfc59a6445eb8f75a)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_oa.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -1980,6 +1980,7 @@ static const struct xe_mmio_range xe2_oa
 	{ .start = 0x5194, .end = 0x5194 },	/* SYS_MEM_LAT_MEASURE_MERTF_GRP_3D */
 	{ .start = 0x8704, .end = 0x8704 },	/* LMEM_LAT_MEASURE_MCFG_GRP */
 	{ .start = 0xB1BC, .end = 0xB1BC },	/* L3_BANK_LAT_MEASURE_LBCF_GFX */
+	{ .start = 0xD0E0, .end = 0xD0F4 },	/* VISACTL */
 	{ .start = 0xE18C, .end = 0xE18C },	/* SAMPLER_MODE */
 	{ .start = 0xE590, .end = 0xE590 },	/* TDL_LSC_LAT_MEASURE_TDL_GFX */
 	{ .start = 0x13000, .end = 0x137FC },	/* PES_0_PESL0 - PES_63_UPPER_PESL3 */



