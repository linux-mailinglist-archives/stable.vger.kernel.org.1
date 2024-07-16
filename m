Return-Path: <stable+bounces-59509-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 57336932A7B
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 17:34:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 011831F23721
	for <lists+stable@lfdr.de>; Tue, 16 Jul 2024 15:34:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDEA51DFDE;
	Tue, 16 Jul 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DQ0fXGBZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB9BE541;
	Tue, 16 Jul 2024 15:34:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721144065; cv=none; b=ULYtCoeKYFMqwGWtd29VwNZwhQS9EBcgkqyf/U8YWv5yUvDQSGIlt/xCMd3MTXDMm2+GA+qTRyayNmVahG/9vVOdJFLvaUhm4Fd2C7+oniLbr0owfPFz1bXqVQg/k8M2GphZhsKmMJWK1Uxi42yJ59Y+pzmVpFxm3udb5e6hCk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721144065; c=relaxed/simple;
	bh=NhZSDD9urzrwILdzr3fEMrcwGNmdZB3RODffLvygE+E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TvImuSPRXHAsiLHTb2GXnjNe0+FHhslJ7cTsOR2O0pJLO2bV4gU4uL6xY5/oZ49C4PDSl2Y6bj6GgS0hQ8iUnLpBG5x0HzfCuZGgY6FmI65X5A99ruWNupUh0Q2dBMBTyGMku/rx6q46UC8wPAI07JD2WAnQ8CEGuUc5x6F+/ys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DQ0fXGBZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF06AC116B1;
	Tue, 16 Jul 2024 15:34:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1721144065;
	bh=NhZSDD9urzrwILdzr3fEMrcwGNmdZB3RODffLvygE+E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DQ0fXGBZFdZFsXo47oi1HU2/caVSOmTuz5fwC+ILV7JzM74+qal+6AtonBv6nwW/Q
	 dFmQgKobmf53Ayt6s0bqV44EMdUX2Z3Q74YfuPIgPMsoE0FeMWkT+WrohfnBlpeytT
	 dtHqWxCXR5DDRqWjydnyciyrWIcKjMv6CmgVoNvc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Rodrigo Siqueira <rodrigo.siqueira@amd.com>,
	Wayne Lin <wayne.lin@amd.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 4.19 04/66] drm/amd/display: Skip finding free audio for unknown engine_id
Date: Tue, 16 Jul 2024 17:30:39 +0200
Message-ID: <20240716152738.336040014@linuxfoundation.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240716152738.161055634@linuxfoundation.org>
References: <20240716152738.161055634@linuxfoundation.org>
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

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Alex Hung <alex.hung@amd.com>

[ Upstream commit 1357b2165d9ad94faa4c4a20d5e2ce29c2ff29c3 ]

[WHY]
ENGINE_ID_UNKNOWN = -1 and can not be used as an array index. Plus, it
also means it is uninitialized and does not need free audio.

[HOW]
Skip and return NULL.

This fixes 2 OVERRUN issues reported by Coverity.

Reviewed-by: Rodrigo Siqueira <rodrigo.siqueira@amd.com>
Acked-by: Wayne Lin <wayne.lin@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/dc/core/dc_resource.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
index 6896d69b8c240..8b4337794d1ef 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_resource.c
@@ -1703,6 +1703,9 @@ static struct audio *find_first_free_audio(
 {
 	int i, available_audio_count;
 
+	if (id == ENGINE_ID_UNKNOWN)
+		return NULL;
+
 	available_audio_count = pool->audio_count;
 
 	for (i = 0; i < available_audio_count; i++) {
-- 
2.43.0




