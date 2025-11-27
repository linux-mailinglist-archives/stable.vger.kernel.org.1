Return-Path: <stable+bounces-197414-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D43C8C8F2E9
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:13:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 90C003BCAAF
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4AC3346AE;
	Thu, 27 Nov 2025 15:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Y2Fz5xbs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAE58334373;
	Thu, 27 Nov 2025 15:02:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255750; cv=none; b=c4oMwabtPD03p61Xrskzhaw05CdklmRAEYcs/dBNYSVVszHv8JEpmyRMyoAgRXXlXayGqxLmJtB7mKtR+K4PUIxXe1B/2zLYZdLUquQXfWHNpOuiSUaIbsP0AeveDhA6szeTvkKQkS33cuxZqYDUdE3acua683rpkUFC84BMXTw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255750; c=relaxed/simple;
	bh=Yd7v+vUmYdmq/4jwce9+esRu46NcpeSP7tNxMzU1ta8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JXEQZvn7wUJTRXvn4xDowbQWDbk/2nAdvldzAXt4wM5iyAU9FhDKlqlBtppSMcWApGHmAGre6LWWh14Z5bDbRBXFwWEEjN8ZjmhX3sVR5reLoOmyyaWUGyEMArrwoBNtm2Efa44KdhN87Z4yA1U9ycOQtNVPZhGlZyW5F+elW64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Y2Fz5xbs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AFFDC4CEF8;
	Thu, 27 Nov 2025 15:02:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255750;
	bh=Yd7v+vUmYdmq/4jwce9+esRu46NcpeSP7tNxMzU1ta8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y2Fz5xbsHIPk0bmGnYAkNqpPkzGknIbltYsL+LYtTuy86/STLlGJwfyGey4I4rQtg
	 umPPSc51E5tqNIwS4FXZ59V25A1Ni4T9s4GEGNmz+X8aYt2eMGEhYterkqDDacKEwH
	 p7ry/vZb2/uPPsdjFksDGK/zNtqBuOqeGr4ykvhs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	Thierry Reding <treding@nvidia.com>
Subject: [PATCH 6.17 068/175] drm/tegra: dc: Fix reference leak in tegra_dc_couple()
Date: Thu, 27 Nov 2025 15:45:21 +0100
Message-ID: <20251127144045.450887391@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144042.945669935@linuxfoundation.org>
References: <20251127144042.945669935@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 4c5376b4b143c4834ebd392aef2215847752b16a upstream.

driver_find_device() calls get_device() to increment the reference
count once a matching device is found, but there is no put_device() to
balance the reference count. To avoid reference count leakage, add
put_device() to decrease the reference count.

Found by code review.

Cc: stable@vger.kernel.org
Fixes: a31500fe7055 ("drm/tegra: dc: Restore coupling of display controllers")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Acked-by: Mikko Perttunen <mperttunen@nvidia.com>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Link: https://patch.msgid.link/20251022114720.24937-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tegra/dc.c |    1 +
 1 file changed, 1 insertion(+)

--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -3148,6 +3148,7 @@ static int tegra_dc_couple(struct tegra_
 		dc->client.parent = &parent->client;
 
 		dev_dbg(dc->dev, "coupled to %s\n", dev_name(companion));
+		put_device(companion);
 	}
 
 	return 0;



