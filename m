Return-Path: <stable+bounces-165057-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 581D7B14D2F
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 13:50:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E72883BF727
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 11:49:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E8428E61E;
	Tue, 29 Jul 2025 11:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b="kpFaaEiL"
X-Original-To: stable@vger.kernel.org
Received: from mail-out.aladdin-rd.ru (mail-out.aladdin-rd.ru [91.199.251.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2D6D28F51B;
	Tue, 29 Jul 2025 11:50:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.199.251.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753789808; cv=none; b=ucLTdUbkbBGE2QsLTYRtMpw7i7+SrYzqiV0XYm5iVWvyObbvMy0rTyIWUdLumvxCzqAIj9CnBo3gNF14wWMdcNaPvgLnehKD7HHmpTXIAIEZ84pv1IMT0RVrY8w6/mrVYlLHVLhLlBVdP2jEjz9iOvGqQzndilR0EzqQnqLg3IY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753789808; c=relaxed/simple;
	bh=Cc8ULeOyaFVbyiqOGp6lL8N5tLZAjBl15kqlBhidWg4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=hKKT717j5vR22W5GYXT+CIEU4xhbc91yFnXw4Nj9zwIq2F3OtXJwv9RuRYp9LXsEzz74rbtQ/aUrPZ32Em9ant0JURX+j9aSQrfx2dMWv/JAn6a8MSpuJEWnqMi2XbUAwXk9j1QWTXBSM5I6oy08VpJ28SB/VDMTlRwFFg1fBnA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru; spf=pass smtp.mailfrom=aladdin.ru; dkim=pass (2048-bit key) header.d=aladdin.ru header.i=@aladdin.ru header.b=kpFaaEiL; arc=none smtp.client-ip=91.199.251.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=aladdin.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=aladdin.ru
DKIM-Signature: v=1; a=rsa-sha256; d=aladdin.ru; s=mail; c=simple/simple;
	t=1753789779; h=from:subject:to:date:message-id;
	bh=Cc8ULeOyaFVbyiqOGp6lL8N5tLZAjBl15kqlBhidWg4=;
	b=kpFaaEiLsDVxz2RTAJ4kNMe/rVBDPPoBR2eNnTrjVQQu65wTFxR3AiWS3CRnQWhpOsjx3XITVaq
	QBLcSwE8mTPDcAva9iXVVMFpDge7J9O3GxwEWDicMOgtfAYAsGoDkIaVFhvOfb8TIzZp51kLQp/9b
	QGzH3BfxtZ1KtCgVMursJs+W4wSnXA80tQ0l6m7vxv2s9SzuPR9+JMZbexyeL5/vY0dOkAjWmVX8o
	YyPA36dS/oEcEnxiOvXjY80mdgsjDJkgvtQykUVfEP5CytA65+1lT3DaN0x23pLCJStsfgQz4+wkn
	22AFt9Xp+LrvA8NZkZq2HhQ1LUQEkcV+wmIw==
From: Daniil Dulov <d.dulov@aladdin.ru>
To: <stable@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC: Daniil Dulov <d.dulov@aladdin.ru>, Harry Wentland
	<harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira
	<siqueira@igalia.com>, Alex Deucher <alexander.deucher@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>, David Airlie
	<airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
	<amd-gfx@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
	<linux-kernel@vger.kernel.org>, <lvc-project@linuxtesting.org>, Tom Chung
	<chiahsuan.chung@amd.com>, Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
	"Roman Li" <roman.li@amd.com>, Alex Hung <alex.hung@amd.com>, Aurabindo
 Pillai <aurabindo.pillai@amd.com>, Hamza Mahfooz <hamza.mahfooz@amd.com>,
	"Srinivasan Shanmugam" <srinivasan.shanmugam@amd.com>
Subject: [PATCH 6.1/6.6] drm/amd/display: Add null check for head_pipe in dcn32_acquire_idle_pipe_for_head_pipe_in_layer
Date: Tue, 29 Jul 2025 14:49:24 +0300
Message-ID: <20250729114924.138111-1-d.dulov@aladdin.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EXCH-2016-02.aladdin.ru (192.168.1.102) To
 EXCH-2016-01.aladdin.ru (192.168.1.101)

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

commit ac2140449184a26eac99585b7f69814bd3ba8f2d upstream.

This commit addresses a potential null pointer dereference issue in the
`dcn32_acquire_idle_pipe_for_head_pipe_in_layer` function. The issue
could occur when `head_pipe` is null.

The fix adds a check to ensure `head_pipe` is not null before asserting
it. If `head_pipe` is null, the function returns NULL to prevent a
potential null pointer dereference.

Reported by smatch:
drivers/gpu/drm/amd/amdgpu/../display/dc/resource/dcn32/dcn32_resource.c:2690 dcn32_acquire_idle_pipe_for_head_pipe_in_layer() error: we previously assumed 'head_pipe' could be null (see line 2681)

Cc: Tom Chung <chiahsuan.chung@amd.com>
Cc: Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>
Cc: Roman Li <roman.li@amd.com>
Cc: Alex Hung <alex.hung@amd.com>
Cc: Aurabindo Pillai <aurabindo.pillai@amd.com>
Cc: Harry Wentland <harry.wentland@amd.com>
Cc: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
[ Daniil: dcn32 was moved from drivers/gpu/drm/amd/display/dc to
  drivers/gpu/drm/amd/display/dc/resource since commit
  8b8eed05a1c6 ("drm/amd/display: Refactor resource into component directory").
  The path is changed accordingly to apply the patch on 6.1.y. and 6.6.y ]
Signed-off-by: Daniil Dulov <d.dulov@aladdin.ru>
---
Backport fix for CVE-2024-49918
 drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
index 1b1534ffee9f..591c3166a468 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn32/dcn32_resource.c
@@ -2563,8 +2563,10 @@ struct pipe_ctx *dcn32_acquire_idle_pipe_for_head_pipe_in_layer(
 	struct resource_context *old_ctx = &stream->ctx->dc->current_state->res_ctx;
 	int head_index;
 
-	if (!head_pipe)
+	if (!head_pipe) {
 		ASSERT(0);
+		return NULL;
+	}
 
 	/*
 	 * Modified from dcn20_acquire_idle_pipe_for_layer
-- 
2.34.1


