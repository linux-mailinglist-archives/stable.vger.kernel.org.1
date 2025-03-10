Return-Path: <stable+bounces-122407-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D0903A59F81
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 18:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 641133A90F5
	for <lists+stable@lfdr.de>; Mon, 10 Mar 2025 17:39:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AC5022FE18;
	Mon, 10 Mar 2025 17:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vkNbPcnQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC3FF22D4C3;
	Mon, 10 Mar 2025 17:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741628403; cv=none; b=jpGFpBb9iOvv+8uNa+6ekS4oW7s9dcfV3WWaSlfVpt7t6FVqtXwTr6KWo8igGgNK6kcbzj2r+tBYioEl9dREnwqfGhnYjZBKIBp4+ZWRhtzo7Bx7Co2+l4Ts49wrPapMIyj6Wc0nxTdM9hwEDNgTGlOiQgRO8iODxDG1SOaLBmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741628403; c=relaxed/simple;
	bh=mUhL/py6onsJmeBpNUzL5YlZKtv95fvTvrmoBdgH3ro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YLYXfajbGRKi9KimHun5A9K1d/DwTDMjyxsU4qR7sx84bATYBDO0987IHHyloN1plpSQ7r4TBNwoom05YB5i8MaL1ZpF8LaOT6FcIBwBF9gNXQrqIOuD6WWatZ08NKaXp8yduOrjL0L4behRAFCh4N59QAEpfuCW6Hl7EFGS/yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vkNbPcnQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D9CC4CEE5;
	Mon, 10 Mar 2025 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1741628403;
	bh=mUhL/py6onsJmeBpNUzL5YlZKtv95fvTvrmoBdgH3ro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vkNbPcnQLci8EkW4VidOx2BolxfWBdIh4MR/BtkydnUkaN31ngVpkjPEKb4bslBKe
	 0AWKyLEki62CztxlweO9hQt6JXIVOvQNRNX1rdraL1LYPuF0v9EKvQz7U2KI/rFY0C
	 vq+wFgzV9P0HX/DL/9wc5kqQHgHM92ETBRfvqxrk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alex Hung <alex.hung@amd.com>,
	Ma Ke <make24@iscas.ac.cn>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.1 019/109] drm/amd/display: Fix null check for pipe_ctx->plane_state in resource_build_scaling_params
Date: Mon, 10 Mar 2025 18:06:03 +0100
Message-ID: <20250310170428.312900687@linuxfoundation.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250310170427.529761261@linuxfoundation.org>
References: <20250310170427.529761261@linuxfoundation.org>
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

From: Ma Ke <make24@iscas.ac.cn>

commit 374c9faac5a763a05bc3f68ad9f73dab3c6aec90 upstream.

Null pointer dereference issue could occur when pipe_ctx->plane_state
is null. The fix adds a check to ensure 'pipe_ctx->plane_state' is not
null before accessing. This prevents a null pointer dereference.

Found by code review.

Fixes: 3be5262e353b ("drm/amd/display: Rename more dc_surface stuff to plane_state")
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 63e6a77ccf239337baa9b1e7787cde9fa0462092)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1100,7 +1100,8 @@ bool resource_build_scaling_params(struc
 	DC_LOGGER_INIT(pipe_ctx->stream->ctx->logger);
 
 	/* Invalid input */
-	if (!plane_state->dst_rect.width ||
+	if (!plane_state ||
+			!plane_state->dst_rect.width ||
 			!plane_state->dst_rect.height ||
 			!plane_state->src_rect.width ||
 			!plane_state->src_rect.height) {



