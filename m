Return-Path: <stable+bounces-197388-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59FF8C8F253
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:11:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 936223BC84C
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:01:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A067533437A;
	Thu, 27 Nov 2025 15:01:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="U0rIW41z"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B9ED20FAAB;
	Thu, 27 Nov 2025 15:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255676; cv=none; b=XEs4k7cP0Dqx0yLWgDHHGX5Y2U6JATud2yElBqPeSuDLqlE+bX21Yxdj71DVjb8HJ5scQiKx8UKDY2SXMFgyZ3eTn8uouu+lD49DZdkdXisr5URnxshu3BIBmnDw9PDhUbRmog0W2mXnRh4JayTEs/2tn3udVJDWeKXYWwRwQtc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255676; c=relaxed/simple;
	bh=QugguSdakp2L3182dzT4Sx+epFRt5FE4on6BB2KBTP0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRPfva1vYdoqp7BuM0X8Foy8XqQgluD9rVdO0nJrxvBtQKlpHSkP95JDMGg0lQLBslOfkx+GE1xnrNfXOx6YIeOGpNy/9zjjwU1tq5WJG5meOkxs6pH0fwYqdYkADRNVAXYG4WempJ7gLThbnuUNUnAUFYh/rFezEcP/nhO/lHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=U0rIW41z; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6F815C4CEF8;
	Thu, 27 Nov 2025 15:01:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255675;
	bh=QugguSdakp2L3182dzT4Sx+epFRt5FE4on6BB2KBTP0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=U0rIW41zSgPdA5eck75KN/dDgFEd38JV9nW1mKIamB8sHke4dvgiRdzvMLUzWJijF
	 taIEHmmlAjgqiv3KSjbvtGDM0UJ2wHwxhPLx+hByFrz1FBN9cv8bZbnfD0DQI47rM9
	 0U/9hHACT8J1E+MunNoU1k/xZgZ5aDD6aG/ig1zk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Aric Cyr <aric.cyr@amd.com>,
	Ivan Lipski <ivan.lipski@amd.com>,
	Dan Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.17 076/175] drm/amd/display: Clear the CUR_ENABLE register on DCN20 on DPP5
Date: Thu, 27 Nov 2025 15:45:29 +0100
Message-ID: <20251127144045.742307249@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144042.945669935@linuxfoundation.org>
References: <20251127144042.945669935@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Lipski <ivan.lipski@amd.com>

commit 5bab4c89390f32b2f491f49a151948cd226dd909 upstream.

[Why]
On DCN20 & DCN30, the 6th DPP's & HUBP's are powered on permanently and
cannot be power gated. Thus, when dpp_reset() is invoked for the DPP5,
while it's still powered on, the cached cursor_state
(dpp_base->pos.cur0_ctl.bits.cur0_enable)
and the actual state (CUR0_ENABLE) bit are unsycned. This can cause a
double cursor in full screen with non-native scaling.

[How]
Force disable cursor on DPP5 on plane powerdown for ASICs w/ 6 DPPs/HUBPs.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4673
Reviewed-by: Aric Cyr <aric.cyr@amd.com>
Signed-off-by: Ivan Lipski <ivan.lipski@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 79b3c037f972dcb13e325a8eabfb8da835764e15)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c |    8 ++++++++
 1 file changed, 8 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/hwss/dcn20/dcn20_hwseq.c
@@ -614,6 +614,14 @@ void dcn20_dpp_pg_control(
 		 *		DOMAIN11_PGFSM_PWR_STATUS, pwr_status,
 		 * 		1, 1000);
 		 */
+
+		/* Force disable cursor on plane powerdown on DPP 5 using dpp_force_disable_cursor */
+		if (!power_on) {
+			struct dpp *dpp5 = hws->ctx->dc->res_pool->dpps[dpp_inst];
+			if (dpp5 && dpp5->funcs->dpp_force_disable_cursor)
+				dpp5->funcs->dpp_force_disable_cursor(dpp5);
+		}
+
 		break;
 	default:
 		BREAK_TO_DEBUGGER();



