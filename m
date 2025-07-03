Return-Path: <stable+bounces-160045-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1845EAF7B73
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:25:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1DA747B591F
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95CC2F0024;
	Thu,  3 Jul 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vFx+En58"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98F5F2EFDBE;
	Thu,  3 Jul 2025 15:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751556193; cv=none; b=pvdfjyCPQdzaeBZF5CKjLBYBwEAHZEUYB/2th6Dn8EpIiFQFuLDr2757t1owiMB0RoaQ0DGKEtw3Yk6Np87CwN02841ii8dsAIQcCWCtrv9DpsArwepNhDZ2bhWkA8bjKcrJwa2I58mD4VMSPUWo1LKVUHAHcLqAxRVnNmCInos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751556193; c=relaxed/simple;
	bh=70ymnXdB+LaNjkX1JK0hKq9AcCePcS3MfIlrWjK7uWQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q8C+jhDAoBcfPF7oeoXtYbKfjDQSP1WYJA0z2fUJAA+uHb2QwU7uZ4AP7Iu17U8tpmO5bBBX1ob2BjqaWR3JrPPvqU9YSwi/jIFViz6V3Is0qU97W9t6JQSDvXSxVpOlIlZNAXfXiJh0ZWFUDF/esNp1HQmMYDNPDzf7CyJ4w0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vFx+En58; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE193C4CEED;
	Thu,  3 Jul 2025 15:23:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751556193;
	bh=70ymnXdB+LaNjkX1JK0hKq9AcCePcS3MfIlrWjK7uWQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vFx+En586tGBigJzM1168K4lE1lhqBZHYhkaef3dyA5J6+HRFwRSapblTCzpQJOKl
	 xp/TlUcYKWfuPnZZEJ/4BwliEjTLHiM2tTy5opBzn2aofIpaif1dpJObVU+aAG6FIF
	 fhYRrCfBrnQPDaWZQAKNoa2fOS4DYhybVDZgvhFI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qiu-ji Chen <chenqiuji666@gmail.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 6.1 104/132] drm/tegra: Fix a possible null pointer dereference
Date: Thu,  3 Jul 2025 16:43:13 +0200
Message-ID: <20250703143943.473463683@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143939.370927276@linuxfoundation.org>
References: <20250703143939.370927276@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Qiu-ji Chen <chenqiuji666@gmail.com>

commit 780351a5f61416ed2ba1199cc57e4a076fca644d upstream.

In tegra_crtc_reset(), new memory is allocated with kzalloc(), but
no check is performed. Before calling __drm_atomic_helper_crtc_reset,
state should be checked to prevent possible null pointer dereference.

Fixes: b7e0b04ae450 ("drm/tegra: Convert to using __drm_atomic_helper_crtc_reset() for reset.")
Cc: stable@vger.kernel.org
Signed-off-by: Qiu-ji Chen <chenqiuji666@gmail.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://lore.kernel.org/r/20241106095906.15247-1-chenqiuji666@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tegra/dc.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -1391,7 +1391,10 @@ static void tegra_crtc_reset(struct drm_
 	if (crtc->state)
 		tegra_crtc_atomic_destroy_state(crtc, crtc->state);
 
-	__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	if (state)
+		__drm_atomic_helper_crtc_reset(crtc, &state->base);
+	else
+		__drm_atomic_helper_crtc_reset(crtc, NULL);
 }
 
 static struct drm_crtc_state *



