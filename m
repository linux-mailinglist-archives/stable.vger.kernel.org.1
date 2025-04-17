Return-Path: <stable+bounces-132949-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4532A9189F
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:02:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2856C5A1B64
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:02:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06279226D0E;
	Thu, 17 Apr 2025 10:02:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2aJCiGq0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B80121C84AD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884137; cv=none; b=HbrNqtF6xG8LYXbCinrM7dgWe5xTehPsjo/dNFFY9pDkoml4QFr3BEKtNVLjQpZR5nBHUT9AbCr8Pc60pSCiPIQcEUA5FelDxnEI+6GSmUthSejCJO6pyJISlsg/TO/7ICoE26tfRtGAHXewjo+gYWcVdHpWGSTHYm9yPsZUIrQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884137; c=relaxed/simple;
	bh=0u8+V1O4jfiaZ5thHCteUuJNVclpfNiRkYU0D4KOBCY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U/te7UhIV6l+ZPHgyNcB7Aiig6NNOarTzvwIYuUSqt1c4iy1rjAhH1vxFSV4254k3qJD/8LQ8NkZTUDlKKPBAuo51arVryBrO97VNSndS18bNW1MOyHbD6K4HN4nKXwRhY8UlcLS3UB2zKVwnDGMocDfN+sShdPRUnXph9ZFecc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2aJCiGq0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61630C4CEF0;
	Thu, 17 Apr 2025 10:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884137;
	bh=0u8+V1O4jfiaZ5thHCteUuJNVclpfNiRkYU0D4KOBCY=;
	h=Subject:To:Cc:From:Date:From;
	b=2aJCiGq09z3XdPvfS6im8il1Y2noG90xPpy/G8gnoUyE8oIU6e+atIo+W63MqL+aZ
	 5VV6oWZUCrLx9lPYEn43pxMEKd4tEjbvLJT5O6JDUMfuI/yjVaJ/mAmKhq9D+HVgcT
	 xfjfuiHYVZbHafClNMxxGQw/ufYlcSs7CBHMm7n8=
Subject: FAILED: patch "[PATCH] arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre" failed to apply to 5.4-stable tree
To: dianders@chromium.org,catalin.marinas@arm.com,quic_tsoni@quicinc.com,sbauer@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:01:59 +0200
Message-ID: <2025041759-disarray-snowplow-d290@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 0c9fc6e652cd5aed48c5f700c32b7642bea7f453
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041759-disarray-snowplow-d290@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c9fc6e652cd5aed48c5f700c32b7642bea7f453 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Tue, 7 Jan 2025 12:06:00 -0800
Subject: [PATCH] arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre
 BHB safe list

Qualcomm has confirmed that, much like Cortex A53 and A55, KRYO
2XX/3XX/4XX silver cores are unaffected by Spectre BHB. Add them to
the safe list.

Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Cc: Scott Bauer <sbauer@quicinc.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Trilok Soni <quic_tsoni@quicinc.com>
Link: https://lore.kernel.org/r/20250107120555.v4.3.Iab8dbfb5c9b1e143e7a29f410bce5f9525a0ba32@changeid
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 17aa836fe46d..89405be53d8f 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -854,6 +854,9 @@ static bool is_spectre_bhb_safe(int scope)
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A520),
 		MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
 		{},
 	};
 	static bool all_safe = true;


