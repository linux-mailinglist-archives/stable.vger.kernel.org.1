Return-Path: <stable+bounces-132942-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F083A91893
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:01:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E59585A11A7
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:01:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17538226CF8;
	Thu, 17 Apr 2025 10:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TNpUbRnN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9A2A224AFA
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884102; cv=none; b=Iizmlhi8nwXQIDMBuSBWVkVy9/EBoI4zrK4NBc0LwISJrC1iPWjJk31Gvr1zIdGZY9ZZZgSDx5TRTXIMVrPcYPLvPquTNf7fxeHQh/KRwEl0My95Xy9gUYzDkDV5uS0I6Ivx4zidDCp+u10+nHNEKl5eSKYnOUJ+XdYGHVuRVZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884102; c=relaxed/simple;
	bh=gkNjb8Q7C+GzT/1xWch93mY5pCLqMdnCDQTIv7Q/Cvw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=rfCyB9qqxSk4ncZyhpJAAZHCPRMwLBiNcaY9SNmUFXx/poQM7zgcMCVIm8PZTpyw9tT9sORZcf4cYtQ0yzGLnC4CKds0TcFIL+qp6IJfomoId3biZDJdiH+wU1X7ZgfcS0ou8nu7TnLfsTeCvvt8uQ4EeaxwytPV32aOF8nyQI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TNpUbRnN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3610C4CEE7;
	Thu, 17 Apr 2025 10:01:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884101;
	bh=gkNjb8Q7C+GzT/1xWch93mY5pCLqMdnCDQTIv7Q/Cvw=;
	h=Subject:To:Cc:From:Date:From;
	b=TNpUbRnNSZfC6QxsfWKHKblRaNMefaPGGuJoRaHm5KHO0gv0KAHxEthW4l09gtnWY
	 k4g1o/X4fP3eEMconfPFA6k8Kt/gKwdmUrk17Tbg7FKm1ctDiq501EWcsHRccg36Xv
	 lu0Owjun6Uw+vuJZN+UqrORaUYujAMG7cNQaPxPU=
Subject: FAILED: patch "[PATCH] arm64: errata: Add QCOM_KRYO_4XX_GOLD to the" failed to apply to 5.4-stable tree
To: dianders@chromium.org,catalin.marinas@arm.com,quic_tsoni@quicinc.com,sbauer@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:01:38 +0200
Message-ID: <2025041738-survival-undress-f372@gregkh>
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
git cherry-pick -x ed1ce841245d8febe3badf51c57e81c3619d0a1d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041738-survival-undress-f372@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From ed1ce841245d8febe3badf51c57e81c3619d0a1d Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Tue, 7 Jan 2025 12:05:58 -0800
Subject: [PATCH] arm64: errata: Add QCOM_KRYO_4XX_GOLD to the
 spectre_bhb_k24_list

Qualcomm Kryo 400-series Gold cores have a derivative of an ARM Cortex
A76 in them. Since A76 needs Spectre mitigation via looping then the
Kyro 400-series Gold cores also need Spectre mitigation via looping.

Qualcomm has confirmed that the proper "k" value for Kryo 400-series
Gold cores is 24.

Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Cc: Scott Bauer <sbauer@quicinc.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Trilok Soni <quic_tsoni@quicinc.com>
Link: https://lore.kernel.org/r/20250107120555.v4.1.Ie4ef54abe02e7eb0eee50f830575719bf23bda48@changeid
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index da53722f95d4..e149efadff20 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -866,6 +866,7 @@ u8 spectre_bhb_loop_affected(int scope)
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
 			{},
 		};
 		static const struct midr_range spectre_bhb_k11_list[] = {


