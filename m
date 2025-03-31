Return-Path: <stable+bounces-127090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D3E7EA76870
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 16:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13C853A6926
	for <lists+stable@lfdr.de>; Mon, 31 Mar 2025 14:42:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E04422257E;
	Mon, 31 Mar 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mqgNas8c"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A25B222577;
	Mon, 31 Mar 2025 14:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743431721; cv=none; b=LDaHYEEq6GwZGDjTrOQaEujBdq+pmuO5gne5zNrZWvTF1MpZh5Wevd0phTB0ekKV4lzqiDOTfwChIB1PYKSroFb9V2+HgR4jFMWc8pl27navLO3KeW7JBhqJKiFn81bGkPTxNFYlegjgHYC0xLnLAj5J7ScR9StqdGQAKFP+0j4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743431721; c=relaxed/simple;
	bh=QQfSJ6URsGQRTmdqKZqvlDNd1JClNHUaKpoKWm2qpLo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UJgSRxZmXjWDIuWM79ESmJoRUhLO5QGgOoWxP78MBpr2lYWfl0Ho404I38ZBMOz+qUiYD5PWW/Mg+FJEMdB6i0xbeWh9EAw8nST+6LyanPUK+4H5TcGeKfzq7+MqS5b+lEEWyGlL+mnHEjdp8g0Vrm76CGlT0oW7wTgPSAxO0Gk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mqgNas8c; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 894C6C4CEE3;
	Mon, 31 Mar 2025 14:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743431721;
	bh=QQfSJ6URsGQRTmdqKZqvlDNd1JClNHUaKpoKWm2qpLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mqgNas8cw91gCsJaFfDNaYCqy8xv1Je+YUtB/eC5aF/Ct0tufZbtAJ5EcFZ0Z9DCM
	 uphQcAyflqm+yzq3C7nkZOoHy3W8VjPOR30zV+2WtooWeoeeti8EPY1Yk1Uidz1G/t
	 gBPIECN+0Mib4SAJq8LQPzW+4ifoeO+empVYkf4SFrYbnRtBMdc3t5ck4IZRUa1EqP
	 jkdpFIy0RQDPjMEppVCYYi+aU/KhLPa2UfSvIWGUgYgt71wx4OFK6mEljI1LsLdmZ8
	 1DJ/+n7CAV49YSqsxmN+QBqp+oaggqTv23ywTMkAoGPJVRVmFXSEJYroarf7UdJm24
	 9FS1ECGTGLegw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Douglas Anderson <dianders@chromium.org>,
	Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Sasha Levin <sashal@kernel.org>,
	will@kernel.org,
	mark.rutland@arm.com,
	oliver.upton@linux.dev,
	shameerali.kolothum.thodi@huawei.com,
	bwicaksono@nvidia.com,
	scott@os.amperecomputing.com,
	linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 6.13 12/16] arm64: cputype: Add QCOM_CPU_PART_KRYO_3XX_GOLD
Date: Mon, 31 Mar 2025 10:34:46 -0400
Message-Id: <20250331143450.1685242-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250331143450.1685242-1-sashal@kernel.org>
References: <20250331143450.1685242-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.9
Content-Transfer-Encoding: 8bit

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 401c3333bb2396aa52e4121887a6f6a6e2f040bc ]

Add a definition for the Qualcomm Kryo 300-series Gold cores.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Trilok Soni <quic_tsoni@quicinc.com>
Link: https://lore.kernel.org/r/20241219131107.v3.1.I18e0288742871393228249a768e5d56ea65d93dc@changeid
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 488f8e7513495..c8058f91a5bd3 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -119,6 +119,7 @@
 #define QCOM_CPU_PART_KRYO		0x200
 #define QCOM_CPU_PART_KRYO_2XX_GOLD	0x800
 #define QCOM_CPU_PART_KRYO_2XX_SILVER	0x801
+#define QCOM_CPU_PART_KRYO_3XX_GOLD	0x802
 #define QCOM_CPU_PART_KRYO_3XX_SILVER	0x803
 #define QCOM_CPU_PART_KRYO_4XX_GOLD	0x804
 #define QCOM_CPU_PART_KRYO_4XX_SILVER	0x805
@@ -195,6 +196,7 @@
 #define MIDR_QCOM_KRYO MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO)
 #define MIDR_QCOM_KRYO_2XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_GOLD)
 #define MIDR_QCOM_KRYO_2XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_2XX_SILVER)
+#define MIDR_QCOM_KRYO_3XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_GOLD)
 #define MIDR_QCOM_KRYO_3XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_3XX_SILVER)
 #define MIDR_QCOM_KRYO_4XX_GOLD MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_GOLD)
 #define MIDR_QCOM_KRYO_4XX_SILVER MIDR_CPU_MODEL(ARM_CPU_IMP_QCOM, QCOM_CPU_PART_KRYO_4XX_SILVER)
-- 
2.39.5


