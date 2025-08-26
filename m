Return-Path: <stable+bounces-175161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA1E6B367BD
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 16:09:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA3B37C807B
	for <lists+stable@lfdr.de>; Tue, 26 Aug 2025 13:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B58C352FF1;
	Tue, 26 Aug 2025 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R30mj0Lj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB12C352FE8;
	Tue, 26 Aug 2025 13:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756216302; cv=none; b=jod8K7HELCnL/SDpJ6T43g085fqhuPgrLjc8f9I1WQ3uSKL1y7EnjMckVZDd3NAt5SDsGD9YXjBy1ds54JzdY2Vvzv0E4b5McYkJHxF4yUK6cWeT2xFwVdw1JsoOHsEtHFWS8bC7sEc7KIyho4fNrF0qAm1GfCGJQxuQ8SnfjdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756216302; c=relaxed/simple;
	bh=E4H1mRzL105X3nJqYAQ6IuHOCgXUAsScTQuzoK4Gn7o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KDSNQzwqhSaVIwNVbs6YoPtFZ4a7bEvbhL63dk6cKXum53P7b60t0yZ1UDiu2Chu8e3KfuZ//nH264A93WyykPIeye4H0Ui60KgMZy/1v0ZnvA0nZvXRKTKjxpc+NyS86w1mRLkJAcV36a5zizVMd69oEO3fYjm8EwznHXvYCi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R30mj0Lj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FD1DC113CF;
	Tue, 26 Aug 2025 13:51:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756216302;
	bh=E4H1mRzL105X3nJqYAQ6IuHOCgXUAsScTQuzoK4Gn7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R30mj0LjOY0u+3STc/VWDpyQ6AfwejfRKSn0YcVeJqU6FJq5PxGZlaEjRF6I9j+U9
	 IgaiFmrOdUuwHjVBFtniUyDZ1my79Rb8xu5gj+pcBHxoKLfCSfUXBiLVYknxXp3yxt
	 F5SVHBJb+bhJ9VHzgM4GR2FYXv853SNvRy5W1kHA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Nevenko Stupar <nevenko.stupar@amd.com>,
	Ilya Bakoulin <Ilya.Bakoulin@amd.com>,
	Ray Wu <ray.wu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 361/644] drm/amd/display: Separate set_gsl from set_gsl_source_select
Date: Tue, 26 Aug 2025 13:07:32 +0200
Message-ID: <20250826110955.357047016@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250826110946.507083938@linuxfoundation.org>
References: <20250826110946.507083938@linuxfoundation.org>
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

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ilya Bakoulin <Ilya.Bakoulin@amd.com>

[ Upstream commit 660a467a5e7366cd6642de61f1aaeaf0d253ee68 ]

[Why/How]
Separate the checks for set_gsl and set_gsl_source_select, since
source_select may not be implemented/necessary.

Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Signed-off-by: Ilya Bakoulin <Ilya.Bakoulin@amd.com>
Signed-off-by: Ray Wu <ray.wu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
index bf2a8f53694b..59d16c553800 100644
--- a/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
+++ b/drivers/gpu/drm/amd/display/dc/dcn20/dcn20_hwseq.c
@@ -160,14 +160,13 @@ static void dcn20_setup_gsl_group_as_lock(
 	}
 
 	/* at this point we want to program whether it's to enable or disable */
-	if (pipe_ctx->stream_res.tg->funcs->set_gsl != NULL &&
-		pipe_ctx->stream_res.tg->funcs->set_gsl_source_select != NULL) {
+	if (pipe_ctx->stream_res.tg->funcs->set_gsl != NULL) {
 		pipe_ctx->stream_res.tg->funcs->set_gsl(
 			pipe_ctx->stream_res.tg,
 			&gsl);
-
-		pipe_ctx->stream_res.tg->funcs->set_gsl_source_select(
-			pipe_ctx->stream_res.tg, group_idx,	enable ? 4 : 0);
+		if (pipe_ctx->stream_res.tg->funcs->set_gsl_source_select != NULL)
+			pipe_ctx->stream_res.tg->funcs->set_gsl_source_select(
+				pipe_ctx->stream_res.tg, group_idx, enable ? 4 : 0);
 	} else
 		BREAK_TO_DEBUGGER();
 }
-- 
2.39.5




