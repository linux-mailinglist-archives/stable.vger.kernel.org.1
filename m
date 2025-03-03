Return-Path: <stable+bounces-120150-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED615A4C847
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 17:54:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 91E543B1701
	for <lists+stable@lfdr.de>; Mon,  3 Mar 2025 16:50:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F4826561E;
	Mon,  3 Mar 2025 16:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QgFxixoP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2408A22D79E;
	Mon,  3 Mar 2025 16:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741019511; cv=none; b=IxL0lM6yypf8GOTC0lHM5oSrgfysOSlYfri0T/gbludApRS1rfpUQ0v+vM9hupheeW+E398mqv8ojb45Y/8+VCKiCmPRCxgMiMY9jsMznPG2IC6L66yifyKRiCrt7bEo4jIyDo2RxY78KaKL75dl8s8u8frw11oerj5FRRwO3Ww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741019511; c=relaxed/simple;
	bh=1FU2Fs4QNWRlwGQ+/avZIH2gBK1zO4qC3Hoq7lTGkEQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=m6awDnp1mJIhAYklyqdAzeUlCd4+WcC0pVf8jIFn6lNDxCCOod7ld+fmCF+UY2eHGQtQ57AFAT1oZ6BZhJcZ4QD2at3ySRA5/SoTdrCJlEzqSWBWnBFq2A/2umviVxxQH24GAeTSFOIW6kMHK6dM6Mb5swSeaXLvfQ1rTtg5b4g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QgFxixoP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82C30C4CEE6;
	Mon,  3 Mar 2025 16:31:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741019510;
	bh=1FU2Fs4QNWRlwGQ+/avZIH2gBK1zO4qC3Hoq7lTGkEQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QgFxixoP/hjH2BhZcF71YJeQW16hI52Lm7rJBlpYtm+E1WP8iiOMTcodRFYklFPjz
	 6AnimLS0Tx5eWEsREeA5j9UqZ99O6WMgcL39OE7TXaAXwj4EoP9vXUvPF1kX+suYoZ
	 ZtTIHrTvbRrrQnV4bSVqRg/+OB3jkZknSedr03ohkn1ma/8sWNLO837XmqUE+tOXo5
	 TS+xgoC7hdg9V6w6J/zRAwORbBXTLz3ubDzBaFjdtKXseGlVb8qHU83+lBxM1+36UK
	 avQdsHA3xDFrnnd78qxqMGxRWOTrXMh9GBFmS6KCe4RErJAE4+KjtVHImPCIUKaiOS
	 79Pq7hL2P1izw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Thomas Zimmermann <tzimmermann@suse.de>,
	Lyude Paul <lyude@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	dakr@kernel.org,
	airlied@gmail.com,
	simona@ffwll.ch,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org
Subject: [PATCH AUTOSEL 6.1 8/9] drm/nouveau: Do not override forced connector status
Date: Mon,  3 Mar 2025 11:31:32 -0500
Message-Id: <20250303163133.3764032-8-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250303163133.3764032-1-sashal@kernel.org>
References: <20250303163133.3764032-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.129
Content-Transfer-Encoding: 8bit

From: Thomas Zimmermann <tzimmermann@suse.de>

[ Upstream commit 01f1d77a2630e774ce33233c4e6723bca3ae9daa ]

Keep user-forced connector status even if it cannot be programmed. Same
behavior as for the rest of the drivers.

Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20250114100214.195386-1-tzimmermann@suse.de
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index bdf5262ebd35e..5a30d115525ad 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -755,7 +755,6 @@ nouveau_connector_force(struct drm_connector *connector)
 	if (!nv_encoder) {
 		NV_ERROR(drm, "can't find encoder to force %s on!\n",
 			 connector->name);
-		connector->status = connector_status_disconnected;
 		return;
 	}
 
-- 
2.39.5


