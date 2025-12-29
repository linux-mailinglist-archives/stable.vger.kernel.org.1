Return-Path: <stable+bounces-204090-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F3FCCE787C
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 17:33:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 10BA7300E453
	for <lists+stable@lfdr.de>; Mon, 29 Dec 2025 16:33:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FE41334C0A;
	Mon, 29 Dec 2025 16:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Cgof7Gcv"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D183D332EA9;
	Mon, 29 Dec 2025 16:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767026021; cv=none; b=gBTZ6rlKNji6attJBAXV0B1hyUyPxjokWbME0yQ3jBkr2djHlJTjQGDXYGwKds1vzP/oCQryqOdO7IitRMU47b0bJrZOdNFBp3hb6J1tRlbpVnty+ZSDPInasbX61Bue+BUBLaywvU6Aj+7BQnst+m7cfTr2I1cqdjNDQEqKmQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767026021; c=relaxed/simple;
	bh=u0z16yqlmPRG12qCZ+DTvYscww8R1TQga2zKl6EqulU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRPICKi8XpDBtNfCmGq4NzZwxRvDb99sm8/VF7A2gicDeXuupdzvTU/VQ6ltJST/0jExHi7DP0oXQykgxXc61LhRJvLjRIbBDyPQPZ/t6Vy16ngNwOpneHeY+lpJqG7oucVc+w10socRaDJYXQ9+MsXKcLwF2rAsBygdT+MMuy4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Cgof7Gcv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5BFBAC4CEF7;
	Mon, 29 Dec 2025 16:33:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1767026021;
	bh=u0z16yqlmPRG12qCZ+DTvYscww8R1TQga2zKl6EqulU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cgof7GcvnKYsmR+0tx8QpqS9uaa3ToQuY7PsGXZM0HmAUJU44JjIsGmkXf9RnbbUM
	 t4UAQ5ufr8aZ7d0JQQvIz4/rioKf3fy/hExfLp79WJXbODPGwVhVSLVS46JX4bppR9
	 g6aAGegPZnhYDjGnOTDG5Y3QhQpHCAy7Ha4Zlycc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harry Wentland <harry.wentland@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.18 386/430] drm/amd/display: Use GFP_ATOMIC in dc_create_plane_state()
Date: Mon, 29 Dec 2025 17:13:08 +0100
Message-ID: <20251229160738.525382812@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251229160724.139406961@linuxfoundation.org>
References: <20251229160724.139406961@linuxfoundation.org>
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

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Deucher <alexander.deucher@amd.com>

commit 3c41114dcdabb7b25f5bc33273c6db9c7af7f4a7 upstream.

This can get called from an atomic context.

Closes: https://gitlab.freedesktop.org/drm/amd/-/issues/4470
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 8acdad9344cc7b4e7bc01f0dfea80093eb3768db)
Cc: stable@vger.kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_surface.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_surface.c
@@ -86,7 +86,7 @@ uint8_t  dc_plane_get_pipe_mask(struct d
 struct dc_plane_state *dc_create_plane_state(const struct dc *dc)
 {
 	struct dc_plane_state *plane_state = kvzalloc(sizeof(*plane_state),
-							GFP_KERNEL);
+							GFP_ATOMIC);
 
 	if (NULL == plane_state)
 		return NULL;



