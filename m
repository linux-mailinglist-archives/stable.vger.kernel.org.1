Return-Path: <stable+bounces-159485-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CF9BAF78E7
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 16:56:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3C41017D401
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 14:53:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5201B2EFD93;
	Thu,  3 Jul 2025 14:53:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WThqofSx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0FEB42E7BB6;
	Thu,  3 Jul 2025 14:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751554381; cv=none; b=KnoaLW5MzPM8CqBC01NyPNtQuAGfZGGJAIUTdqHLDK6RDvZ1Ok62UVr6gkPkwER7DLMhlFfGMiTR5cDjhYw0FPBtCWnvIphVv3iinaigAjWC93BkiiJdUKyUhD6UNXra8dqqNxeFN4WDIvueAw6LG6x+A3rWRGTLE2fe9SExFpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751554381; c=relaxed/simple;
	bh=iub757Lc+QtSzu1sli2uj0eGteGpsUNJizkCXnlzUJs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pE6AqBfwbgDHpGFGifiRv9TqpIrhIGD4bHvC+yXZP44p0PdXnLF1JsKaO9YqYZRTS929PYU6SeJ1GBGEt3D4FNjOCXdAzL5jAo4oCvrnh4E+wE6FcL8pAq8zWEkQ1DPM3ysY0BMClYUVQ+119zo/tqLKZSfNTi9hEIvNsHessBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WThqofSx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4233FC4CEE3;
	Thu,  3 Jul 2025 14:53:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751554380;
	bh=iub757Lc+QtSzu1sli2uj0eGteGpsUNJizkCXnlzUJs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WThqofSx/epybD8rcezx44ErEPd0msdxDcNdbFBuAQCe91/WqgL1SX76yWqwzbrRa
	 6F6N7/jsQT8C5OU8NS/wNntkMpuuQuNpqXgxyDKw7lt4i3Ltj0Hqp6HYL5giO6lfGY
	 9FWWp8tQ1iBZPKfsPbtYyMzfoVoplWUSmPBIxFPw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Aurabindo Pillai <aurabindo.pillai@amd.com>,
	Alex Hung <alex.hung@amd.com>
Subject: [PATCH 6.12 169/218] drm/amd/display: Check dce_hwseq before dereferencing it
Date: Thu,  3 Jul 2025 16:41:57 +0200
Message-ID: <20250703144002.925508974@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143955.956569535@linuxfoundation.org>
References: <20250703143955.956569535@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Hung <alex.hung@amd.com>

commit b669507b637eb6b1aaecf347f193efccc65d756e upstream.

[WHAT]

hws was checked for null earlier in dce110_blank_stream, indicating hws
can be null, and should be checked whenever it is used.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Reviewed-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Aurabindo Pillai <aurabindo.pillai@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 79db43611ff61280b6de58ce1305e0b2ecf675ad)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dce110/dce110_hwseq.c
@@ -1217,7 +1217,7 @@ void dce110_blank_stream(struct pipe_ctx
 	struct dce_hwseq *hws = link->dc->hwseq;
 
 	if (link->local_sink && link->local_sink->sink_signal == SIGNAL_TYPE_EDP) {
-		if (!link->skip_implict_edp_power_control)
+		if (!link->skip_implict_edp_power_control && hws)
 			hws->funcs.edp_backlight_control(link, false);
 		link->dc->hwss.set_abm_immediate_disable(pipe_ctx);
 	}



