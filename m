Return-Path: <stable+bounces-196519-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EDA2C7AB49
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 17:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F22EA3A0FC5
	for <lists+stable@lfdr.de>; Fri, 21 Nov 2025 16:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683E828C864;
	Fri, 21 Nov 2025 16:05:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IXDbVTi1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2718C27FD59
	for <stable@vger.kernel.org>; Fri, 21 Nov 2025 16:05:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763741150; cv=none; b=uBFFNtJldRqWRgksP9Y4guw4zfJ+pwQlmxJ8GJa6LEPpALnUNYEuvVjto+9UTzpAk1SQ3eNYrqOX2hR1lsG01XfTRNdyUBNwKM2erjyEGctHslo83vSCd4BWyvJ8if0f6z9ECjMjtzL/X0n7v8tunhi2GH9Tsr10z/PD1CDKYOQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763741150; c=relaxed/simple;
	bh=2NmzpyRPZVq7dn4hMwKmlHbzHnFktqpG7qwB9NUHKzY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=prT18lppYXlGFYS23HrkCtsdxSIH7YPF9PKG6VHooUQWqpHOMMpUKYEu/QBBWmpIFBlk0kcRJNS4USee1m/QdObPnPBIH/okyQp5t9xWTkkMZQFMmemnEZjptToPFYP8hZ8n0L/2QXeCbHr9zrshlXktw1pc6HStkY9f3E+QZVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IXDbVTi1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6A3AC4CEF1;
	Fri, 21 Nov 2025 16:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763741149;
	bh=2NmzpyRPZVq7dn4hMwKmlHbzHnFktqpG7qwB9NUHKzY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IXDbVTi1rdJ0T4lLSdhLs0JvjLFdSIUbcmoElOp2UiYOrGtk1bpOvIicDGIZ3qu/k
	 4D6QLrHKSOw5DkOqopjYXogWRhkvQ3X+ua3cv8xger/uS+aEJo9zNuTIHZASmMFpT/
	 U8vCdjuL/abGa7ka82V9nrIOYnxNvGTt7yhlFtM6p5HzTgAUMUaTgb8OBQzwYoIfTF
	 aCwqImtpKckQP94XMBrSyQjKFsQYjTa3RvcT9zI7IdkfZHfeq8G0ZkYsTpBmMdACnJ
	 pl5CT5jIKkm6dYXSkyrl3Q45/GipB6cSoAdvYiWnUBHCR4yiXcZxq0CN0iATkZW2an
	 Tns98rpD+L83Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Imre Deak <imre.deak@intel.com>,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Animesh Manna <animesh.manna@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/dp_mst: Disable Panel Replay
Date: Fri, 21 Nov 2025 11:05:47 -0500
Message-ID: <20251121160547.2589081-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025112017-gigahertz-gravitate-93f3@gregkh>
References: <2025112017-gigahertz-gravitate-93f3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Imre Deak <imre.deak@intel.com>

[ Upstream commit f2687d3cc9f905505d7b510c50970176115066a2 ]

Disable Panel Replay on MST links until it's properly implemented. For
instance the required VSC SDP is not programmed on MST and FEC is not
enabled if Panel Replay is enabled.

Fixes: 3257e55d3ea7 ("drm/i915/panelreplay: enable/disable panel replay")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/issues/15174
Cc: Jouni Högander <jouni.hogander@intel.com>
Cc: Animesh Manna <animesh.manna@intel.com>
Cc: stable@vger.kernel.org # v6.8+
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
Signed-off-by: Imre Deak <imre.deak@intel.com>
Link: https://patch.msgid.link/20251107124141.911895-1-imre.deak@intel.com
(cherry picked from commit e109f644b871df8440c886a69cdce971ed533088)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
[ placed MST check at function start since DPCD read was moved to caller ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_psr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 136a0d6ca9707..34d61e44c6bd9 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -591,6 +591,10 @@ static void _panel_replay_init_dpcd(struct intel_dp *intel_dp)
 {
 	struct intel_display *display = to_intel_display(intel_dp);
 
+	/* TODO: Enable Panel Replay on MST once it's properly implemented. */
+	if (intel_dp->mst_detect == DRM_DP_MST)
+		return;
+
 	if (intel_dp_is_edp(intel_dp)) {
 		if (!intel_alpm_aux_less_wake_supported(intel_dp)) {
 			drm_dbg_kms(display->drm,
-- 
2.51.0


