Return-Path: <stable+bounces-21557-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id EDA2C85C965
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 22:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A2F8C1F22B49
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 030E2151CE9;
	Tue, 20 Feb 2024 21:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K4snumFC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B67CE446C9;
	Tue, 20 Feb 2024 21:33:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708464786; cv=none; b=PjDDp62qO2KbQaJR5oF5jUVHLsvgJ6RoCF3XS0piXy9uJgxNQXxstZF4SXAc/ru2fa3imKsli0K9vy3tHEJY+CtqJ4U3oc/0WY3zoOUC5fS3ykpbyd06eU86oEvQNKPlVuDDAOkRMW7Nm1yIxtFMJKUoFv3/S5t/9pLo4Imwk/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708464786; c=relaxed/simple;
	bh=Ahy4nKTpgtNXUUwWo6dORIZhF8G//kSXP4r9G14VcuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UJo7HOcmL1QQPCCN2VXXRJYyWNnKNehEJpkLvIbf/QuYb4mPOQQqT4PPL9rmaJN6sy1lI9n63J/KbV2m1yYPsIX7YrW+h3kUr4UpreE5MC08Hh9BspIVRThAHon/dyOMDcMf8VZrDq4VAWsMOQduoSHuH1ioml+wVT2PsLWkBc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K4snumFC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DCB7C433F1;
	Tue, 20 Feb 2024 21:33:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708464786;
	bh=Ahy4nKTpgtNXUUwWo6dORIZhF8G//kSXP4r9G14VcuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K4snumFC8P2V/nhfgsYDCfcdFwx5bCsaEQe9sDkUKkS7ba+na2AFl7NAE88Z4C7OG
	 n/ksSF6xWwbTp2XpHhwFniXoJg6u2olvI0/EsVezT6U8g5xRFVTb+dk9HMmTcXA3In
	 Xqgt2GB5EsgVTVstzkQiKcSoB2lDQGbpq5zaKezY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Mario Limonciello <mario.limonciello@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Nevenko Stupar <nevenko.stupar@amd.com>,
	Chaitanya Dhere <chaitanya.dhere@amd.com>,
	Tom Chung <chiahsuan.chung@amd.com>,
	Wenjing Liu <wenjing.liu@amd.com>,
	Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.7 137/309] drm/amd/display: fix incorrect mpc_combine array size
Date: Tue, 20 Feb 2024 21:54:56 +0100
Message-ID: <20240220205637.420847652@linuxfoundation.org>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240220205633.096363225@linuxfoundation.org>
References: <20240220205633.096363225@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.7-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Wenjing Liu <wenjing.liu@amd.com>

commit 39079fe8e660851abbafa90cd55cbf029210661f upstream.

[why]
MAX_SURFACES is per stream, while MAX_PLANES is per asic. The
mpc_combine is an array that records all the planes per asic. Therefore
MAX_PLANES should be used as the array size. Using MAX_SURFACES causes
array overflow when there are more than 3 planes.

[how]
Use the MAX_PLANES for the mpc_combine array size.

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Reviewed-by: Nevenko Stupar <nevenko.stupar@amd.com>
Reviewed-by: Chaitanya Dhere <chaitanya.dhere@amd.com>
Acked-by: Tom Chung <chiahsuan.chung@amd.com>
Signed-off-by: Wenjing Liu <wenjing.liu@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
+++ b/drivers/gpu/drm/amd/display/dc/dml/dcn32/dcn32_fpu.c
@@ -1089,7 +1089,7 @@ struct pipe_slice_table {
 		struct pipe_ctx *pri_pipe;
 		struct dc_plane_state *plane;
 		int slice_count;
-	} mpc_combines[MAX_SURFACES];
+	} mpc_combines[MAX_PLANES];
 	int mpc_combine_count;
 };
 



