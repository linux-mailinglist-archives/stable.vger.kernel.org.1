Return-Path: <stable+bounces-180947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 291B6B9119A
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 14:21:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC5BE3B7FEC
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 12:21:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C928F288C24;
	Mon, 22 Sep 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="encnEY2o"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819C84A1E;
	Mon, 22 Sep 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758543663; cv=none; b=WbHlNlYaydbuUFb1f1jKDT6h/tSfe+hVCBf3BWZkRwUqgXAHOJaj8BMw+x0OJqm/bGeZU1/f2KAtqnuym6/eD72pqSgfhU+dCgBrZ8vn4/zwuKLYENNn3IO2a/+ygkF1b08VwhlXe7/sY1VsZrTQxzYzCHcz9r7RswlfIDiycXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758543663; c=relaxed/simple;
	bh=ViEQLBan4Shyr+1aYZ9y/fzuOhYaRstrxknRLRm0rGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ddMpeRjlaGCj1LAee6lMgb15nHD+M9jYTMDWvdZu1Qinpm3YtoHzPCgtPi/9eg5vmKrNyZhwfhGiSKr/fPd83xYQM+l9zBC4iVQEn4oJkL3gk2+7bd65DO21zIbk6T+4awY7mJ3sBF/Jo7ryva+0ZKjkzKuR5RZNyeKI9/FSe3Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=encnEY2o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F9EFC4CEF0;
	Mon, 22 Sep 2025 12:21:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758543663;
	bh=ViEQLBan4Shyr+1aYZ9y/fzuOhYaRstrxknRLRm0rGA=;
	h=From:To:Cc:Subject:Date:From;
	b=encnEY2oI3pkWuxyAegZ3o1uxvsHR3E3/cPqc8+frAtqwQXBKwNYjVwVv6/0+zsUP
	 STOfoN9NEi3sbeverjAzNFEShAsmT+1+f9nKLCgJaOClGtmbch2RdO+1PPooZFd+um
	 r6TWlWp2Gwf8HqMXcEuQNBvnYEeTZB3/cO8nACwL4Lb8WEM/vGgdFw56tcIR1Xv1Rc
	 QQpcTzj37r0SE2ddvS69P/nDDx0EX9s6pmunPi/T+nwcH74Z2pKTciIQNrj5hq7Dr4
	 c5j78Oyg1rGKuztmrtpMc42INM8ZZdDygoslJ2tk33Aa0dBVMfuftviMb3xsx0IAJM
	 ZrRwNMGbe1vnw==
Received: from johan by xi.lan with local (Exim 4.98.2)
	(envelope-from <johan@kernel.org>)
	id 1v0fXL-0000000078t-1O9R;
	Mon, 22 Sep 2025 14:20:56 +0200
From: Johan Hovold <johan@kernel.org>
To: Alain Volmat <alain.volmat@foss.st.com>,
	Raphael Gallais-Pou <rgallaispou@gmail.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org,
	Benjamin Gaignard <benjamin.gaignard@collabora.com>
Subject: [PATCH] drm: sti: fix device leaks at component probe
Date: Mon, 22 Sep 2025 14:20:12 +0200
Message-ID: <20250922122012.27407-1-johan@kernel.org>
X-Mailer: git-send-email 2.49.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make sure to drop the references taken to the vtg devices by
of_find_device_by_node() when looking up their driver data during
component probe.

Note that holding a reference to a platform device does not prevent its
driver data from going away so there is no point in keeping the
reference after the lookup helper returns.

Fixes: cc6b741c6f63 ("drm: sti: remove useless fields from vtg structure")
Cc: stable@vger.kernel.org	# 4.16
Cc: Benjamin Gaignard <benjamin.gaignard@collabora.com>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/gpu/drm/sti/sti_vtg.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/sti/sti_vtg.c b/drivers/gpu/drm/sti/sti_vtg.c
index ee81691b3203..ce6bc7e7b135 100644
--- a/drivers/gpu/drm/sti/sti_vtg.c
+++ b/drivers/gpu/drm/sti/sti_vtg.c
@@ -143,12 +143,17 @@ struct sti_vtg {
 struct sti_vtg *of_vtg_find(struct device_node *np)
 {
 	struct platform_device *pdev;
+	struct sti_vtg *vtg;
 
 	pdev = of_find_device_by_node(np);
 	if (!pdev)
 		return NULL;
 
-	return (struct sti_vtg *)platform_get_drvdata(pdev);
+	vtg = platform_get_drvdata(pdev);
+
+	put_device(&pdev->dev);
+
+	return vtg;
 }
 
 static void vtg_reset(struct sti_vtg *vtg)
-- 
2.49.1


