Return-Path: <stable+bounces-82499-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C81AD994D14
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 15:01:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8DF3A28676A
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 13:01:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3160617F4FF;
	Tue,  8 Oct 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="RiGygMUt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45991DE4DB;
	Tue,  8 Oct 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728392470; cv=none; b=WEsRlZkWn3v3ot3i6xQdhlJIK0IIOX4QxCOismcFLo5tzaFmS+AIPTngpU8Kb0zXSqF7XxIlN0G8Nj2n8khAo6gL8cDww9QimtlOzAmq2/3HnVzCySh1leGGs7o/C9ttnzlOuefuKvit/I4BCU4KNheNbrdSo+hSuJLNlyJzhUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728392470; c=relaxed/simple;
	bh=91DolElmDlQ7M4OvGKDBe4L3ZiMx7+bNLJIHApAGscs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=p46hkWcN6PV1ZW3v3SU2Ng58sxH0x2QX4uCGGmohH0mXLkn/Kr+m9yjHeOmJkAjBHC81Nq0zSJ3JSWX1En0JPPr98VIcrLa8ybqVxI8BE2rRzxyifB/KtmLxKsCPWUrHc+YyNoMEaVIugwK5/l6ggKS6so3fb6mu0ApS6r9+5bQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=RiGygMUt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6032CC4CEC7;
	Tue,  8 Oct 2024 13:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728392469;
	bh=91DolElmDlQ7M4OvGKDBe4L3ZiMx7+bNLJIHApAGscs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RiGygMUtF8lItlwXwajLfBwzRj090q4WnoueTvN2FQSA8mNh6cS4UUMbkNNTB0O9k
	 DceV51zpdbNbIrnzFKIDeSMXqEdIK9yxNAbNat15uaOyF1+gX7mLC6PFi5Njyc+sYs
	 CK3gFcvEGHRS2LzfMNu7yWubLMuRSNGpnYLZtU+o=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Jos=C3=A9=20Roberto=20de=20Souza?= <jose.souza@intel.com>,
	Ashutosh Dixit <ashutosh.dixit@intel.com>,
	Lucas De Marchi <lucas.demarchi@intel.com>
Subject: [PATCH 6.11 425/558] drm/xe/oa: Dont reset OAC_CONTEXT_ENABLE on OA stream close
Date: Tue,  8 Oct 2024 14:07:35 +0200
Message-ID: <20241008115718.999130229@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115702.214071228@linuxfoundation.org>
References: <20241008115702.214071228@linuxfoundation.org>
User-Agent: quilt/0.67
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

6.11-stable review patch.  If anyone has any objections, please let me know.

------------------

From: José Roberto de Souza <jose.souza@intel.com>

commit 8135f1c09dd2eecee7cb637f7ec9a29e57300eb8 upstream.

Mesa testing on Xe2+ revealed that when OA metrics are collected for an
exec_queue, after the OA stream is closed, future batch buffers submitted
on that exec_queue do not complete. Not resetting OAC_CONTEXT_ENABLE on OA
stream close resolves these hangs and should not have any adverse effects.

v2: Make the change that we don't reset the bit clearer (Ashutosh)
    Also make the same fix for OAC as OAR (Ashutosh)

Bspec: 60314
Fixes: 2f4a730fcd2d ("drm/xe/oa: Add OAR support")
Fixes: 14e077f8006d ("drm/xe/oa: Add OAC support")
Closes: https://gitlab.freedesktop.org/drm/xe/kernel/-/issues/2821
Signed-off-by: José Roberto de Souza <jose.souza@intel.com>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Cc: stable@vger.kernel.org
Reviewed-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240924213713.3497992-1-ashutosh.dixit@intel.com
(cherry picked from commit 0c8650b09a365f4a31fca1d1d1e9d99c56071128)
Signed-off-by: Lucas De Marchi <lucas.demarchi@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/xe/xe_oa.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_oa.c b/drivers/gpu/drm/xe/xe_oa.c
index eae38a49ee8e..2804f14f8f29 100644
--- a/drivers/gpu/drm/xe/xe_oa.c
+++ b/drivers/gpu/drm/xe/xe_oa.c
@@ -709,8 +709,7 @@ static int xe_oa_configure_oar_context(struct xe_oa_stream *stream, bool enable)
 		{
 			RING_CONTEXT_CONTROL(stream->hwe->mmio_base),
 			regs_offset + CTX_CONTEXT_CONTROL,
-			_MASKED_FIELD(CTX_CTRL_OAC_CONTEXT_ENABLE,
-				      enable ? CTX_CTRL_OAC_CONTEXT_ENABLE : 0)
+			_MASKED_BIT_ENABLE(CTX_CTRL_OAC_CONTEXT_ENABLE),
 		},
 	};
 	struct xe_oa_reg reg_lri = { OAR_OACONTROL, oacontrol };
@@ -742,10 +741,8 @@ static int xe_oa_configure_oac_context(struct xe_oa_stream *stream, bool enable)
 		{
 			RING_CONTEXT_CONTROL(stream->hwe->mmio_base),
 			regs_offset + CTX_CONTEXT_CONTROL,
-			_MASKED_FIELD(CTX_CTRL_OAC_CONTEXT_ENABLE,
-				      enable ? CTX_CTRL_OAC_CONTEXT_ENABLE : 0) |
-			_MASKED_FIELD(CTX_CTRL_RUN_ALONE,
-				      enable ? CTX_CTRL_RUN_ALONE : 0),
+			_MASKED_BIT_ENABLE(CTX_CTRL_OAC_CONTEXT_ENABLE) |
+			_MASKED_FIELD(CTX_CTRL_RUN_ALONE, enable ? CTX_CTRL_RUN_ALONE : 0),
 		},
 	};
 	struct xe_oa_reg reg_lri = { OAC_OACONTROL, oacontrol };
-- 
2.46.2




