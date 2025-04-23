Return-Path: <stable+bounces-135820-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5C0CA9904E
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 17:18:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B5CC1174505
	for <lists+stable@lfdr.de>; Wed, 23 Apr 2025 15:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DC6728A1CC;
	Wed, 23 Apr 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hRoWaCOC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B36028937D;
	Wed, 23 Apr 2025 15:08:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745420929; cv=none; b=qaj+hBsVD3LZ9q0JNwPmhsKemz3oLw9B04YXPc3tZ2MGNiipGopNCBWzepOGPQUWjmRN/GPchCCqEAJ00gBfT5en9AlraXF6Xg6jabcMT3ghgqOUv9IgLYV7OAvoA1Ju/QmZsyKj8VOE91dPUKcvI4OigwIYnBRCCl+9A2NLmOo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745420929; c=relaxed/simple;
	bh=qaR/TKrOuQEfWM96EW5N1hpaRQeQGgXLgCdRQVFf6HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hQMjAmOHDbNP/97NYIJZfcEeQLSThACy+71JFyaZAI+eGTWhcj2aDbLbhXORsI5VsttgYAGri3UqFP4neLpfp/DHS0eHbFHv28l5E0+2nHYC+kD7VlNKImem2tNq3AMFKSF/qEip7ODlCku3bqo2jD11ZuGWOReq3s60Lsy9Vds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hRoWaCOC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0B04C4CEE2;
	Wed, 23 Apr 2025 15:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745420929;
	bh=qaR/TKrOuQEfWM96EW5N1hpaRQeQGgXLgCdRQVFf6HE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hRoWaCOCcVEE1AeUf6Es6dUxmYkFvELEq3yvnHVrTiNupa8wmB84xSNUDURj8Tl9Z
	 YxhpID5JOhZ+zc6bAbk1SssmSa7WPlCqFOB9lg1ER8vi84MDKBVypiyrtkErKduE0+
	 Rr/nSz+4FQ+/rFnyqMArzZpMDMKbSYTpnLP0q6kk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Catalin Marinas <catalin.marinas@arm.com>
Subject: [PATCH 6.6 128/393] arm64: cputype: Add MIDR_CORTEX_A76AE
Date: Wed, 23 Apr 2025 16:40:24 +0200
Message-ID: <20250423142648.645656871@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250423142643.246005366@linuxfoundation.org>
References: <20250423142643.246005366@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

commit a9b5bd81b294d30a747edd125e9f6aef2def7c79 upstream.

>From the TRM, MIDR_CORTEX_A76AE has a partnum of 0xDOE and an
implementor of 0x41 (ARM). Add the values.

Cc: stable@vger.kernel.org # dependency of the next fix in the series
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://lore.kernel.org/r/20250107120555.v4.4.I151f3b7ee323bcc3082179b8c60c3cd03308aa94@changeid
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/arm64/include/asm/cputype.h |    2 ++
 1 file changed, 2 insertions(+)

--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -75,6 +75,7 @@
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
 #define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_CORTEX_A76AE	0xD0E
 #define ARM_CPU_PART_NEOVERSE_V1	0xD40
 #define ARM_CPU_PART_CORTEX_A78		0xD41
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
@@ -159,6 +160,7 @@
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_CORTEX_A76AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76AE)
 #define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)



