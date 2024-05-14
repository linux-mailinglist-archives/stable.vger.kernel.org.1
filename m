Return-Path: <stable+bounces-43943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 942538C5057
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 13:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C513F1C20A3B
	for <lists+stable@lfdr.de>; Tue, 14 May 2024 11:03:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB3A35A79B;
	Tue, 14 May 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qDS7L0JS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8450E13CA99;
	Tue, 14 May 2024 10:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715683233; cv=none; b=qFEcUb+C3PIG6/MsW/gyHYTdnEtIL5R8WzKCAgi82wjyGNRROuErtdDyXPEmjYQ0WSeyM7ifeai8F3MUxVDciOYqpn5o29Ziv1y2ucObNb1Ee5ByhDQebhPHGU1G0zxLXq7afAwBVBWHTPdl+l4CPIY+UUB730awL7OaMMJBcAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715683233; c=relaxed/simple;
	bh=qD8IEYwBn1ElLZNUsxjVLNuKvuIh1giYyxWm6MWBaik=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rzqe+aL/TU8770x48tqMKd2lZU0237ylOvC+2eFQ3H4f5YUktClbE5ZvmxmIEytD20t9igYtXLqJnvc/ObqPEYH0jhf1N8SB7Ew/m5886VASRb+wSVf289WD7mdD0KUqoSiiTW66KQujYjTjC1QUuFS2kMLgJT1LZyXtjY5ZiBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qDS7L0JS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6737CC2BD10;
	Tue, 14 May 2024 10:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715683233;
	bh=qD8IEYwBn1ElLZNUsxjVLNuKvuIh1giYyxWm6MWBaik=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qDS7L0JSFtK8rw1uKQGhhX54xpaV2YfNqf+GvSqVQGqVogPSUnyaFeTds9c7/SOYe
	 0Q/6A7ev8UxI7lDbutNd06Ty+9AxSExvuy3GsRa/hwCtpzSM3X5VyB8vrPu11Lsb2D
	 uKIdgm1ygUu2v+NlkMjtw5+0/jFRmzplrchCy+BE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Lyude Paul <lyude@redhat.com>,
	Dave Airlie <airlied@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 188/336] drm/nouveau/dp: Dont probe eDP ports twice harder
Date: Tue, 14 May 2024 12:16:32 +0200
Message-ID: <20240514101045.697728968@linuxfoundation.org>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240514101038.595152603@linuxfoundation.org>
References: <20240514101038.595152603@linuxfoundation.org>
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

6.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Lyude Paul <lyude@redhat.com>

[ Upstream commit bf52d7f9b2067f02efe7e32697479097aba4a055 ]

I didn't pay close enough attention the last time I tried to fix this
problem - while we currently do correctly take care to make sure we don't
probe a connected eDP port more then once, we don't do the same thing for
eDP ports we found to be disconnected.

So, fix this and make sure we only ever probe eDP ports once and then leave
them at that connector state forever (since without HPD, it's not going to
change on its own anyway). This should get rid of the last few GSP errors
getting spit out during runtime suspend and resume on some machines, as we
tried to reprobe eDP ports in response to ACPI hotplug probe events.

Signed-off-by: Lyude Paul <lyude@redhat.com>
Reviewed-by: Dave Airlie <airlied@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240404233736.7946-3-lyude@redhat.com
(cherry picked from commit fe6660b661c3397af0867d5d098f5b26581f1290)
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/nouveau/nouveau_dp.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_dp.c b/drivers/gpu/drm/nouveau/nouveau_dp.c
index 7de7707ec6a89..3f72bc38bd2c4 100644
--- a/drivers/gpu/drm/nouveau/nouveau_dp.c
+++ b/drivers/gpu/drm/nouveau/nouveau_dp.c
@@ -225,12 +225,15 @@ nouveau_dp_detect(struct nouveau_connector *nv_connector,
 	u8 *dpcd = nv_encoder->dp.dpcd;
 	int ret = NOUVEAU_DP_NONE, hpd;
 
-	/* If we've already read the DPCD on an eDP device, we don't need to
-	 * reread it as it won't change
+	/* eDP ports don't support hotplugging - so there's no point in probing eDP ports unless we
+	 * haven't probed them once before.
 	 */
-	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP &&
-	    dpcd[DP_DPCD_REV] != 0)
-		return NOUVEAU_DP_SST;
+	if (connector->connector_type == DRM_MODE_CONNECTOR_eDP) {
+		if (connector->status == connector_status_connected)
+			return NOUVEAU_DP_SST;
+		else if (connector->status == connector_status_disconnected)
+			return NOUVEAU_DP_NONE;
+	}
 
 	mutex_lock(&nv_encoder->dp.hpd_irq_lock);
 	if (mstm) {
-- 
2.43.0




