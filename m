Return-Path: <stable+bounces-67269-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C555694F4A4
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 81FEB281541
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:32:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E73186E5E;
	Mon, 12 Aug 2024 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mfBIe/f8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B103915C127;
	Mon, 12 Aug 2024 16:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480369; cv=none; b=pwsrvwTD2i5kEOgAkuRLcVYKhOSOuvHDdDa3rNOKJL6oQ9U3Q53MmvnVjc9j8Un7pQyqE+RFNBxIJ4yU+6EGh93hSbZ5rwFGNdrtuGJRPz4zZ7P4DBtVZDaEe1MLTPGDx8hK3+BxtHIWQpjHNIY64TPpsTG8uY1z4kTaCzHFh8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480369; c=relaxed/simple;
	bh=m69+zG2FjI8P7RPtJnVSNlH3/sU1OEb9UKBs2dJIzoA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nvBue3oeGiXHSfO5Qg1lka3r1SX2iOyc5i9ZjD5MvIvRWJ4mA0kxHZXw+yjqrjEIZyrh9XblwMo/AqBquVNI65qhIEe/B3VFdDHV9efCUX+irJWs1oSRrtK5H8zYjbm8gekviuQ1N0uINX1X4m6nt65I8LifQqmEQj//K6E0Chk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mfBIe/f8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18187C32782;
	Mon, 12 Aug 2024 16:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480369;
	bh=m69+zG2FjI8P7RPtJnVSNlH3/sU1OEb9UKBs2dJIzoA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mfBIe/f8a2TS2j4Vidva60HgX/vlsf6q4Jo1pFLIgwrCemZxsv17OIkdyefOk3ccB
	 yEMGhpJ0gVia6zZz7JBaynDAcHRMswKGUVcGFc/nfO4bhp8i2Ek/FrzH7fRjzqZlvW
	 M70mnagJG0xKwBzNCe5x40RVizkVT/9SVLLU/t18=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ma Ke <make24@iscas.ac.cn>,
	Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH 6.10 176/263] drm/client: fix null pointer dereference in drm_client_modeset_probe
Date: Mon, 12 Aug 2024 18:02:57 +0200
Message-ID: <20240812160153.287404475@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240812160146.517184156@linuxfoundation.org>
References: <20240812160146.517184156@linuxfoundation.org>
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

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ma Ke <make24@iscas.ac.cn>

commit 113fd6372a5bb3689aba8ef5b8a265ed1529a78f upstream.

In drm_client_modeset_probe(), the return value of drm_mode_duplicate() is
assigned to modeset->mode, which will lead to a possible NULL pointer
dereference on failure of drm_mode_duplicate(). Add a check to avoid npd.

Cc: stable@vger.kernel.org
Fixes: cf13909aee05 ("drm/fb-helper: Move out modeset config code")
Signed-off-by: Ma Ke <make24@iscas.ac.cn>
Reviewed-by: Thomas Zimmermann <tzimmermann@suse.de>
Signed-off-by: Thomas Zimmermann <tzimmermann@suse.de>
Link: https://patchwork.freedesktop.org/patch/msgid/20240802044736.1570345-1-make24@iscas.ac.cn
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_client_modeset.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -880,6 +880,11 @@ int drm_client_modeset_probe(struct drm_
 
 			kfree(modeset->mode);
 			modeset->mode = drm_mode_duplicate(dev, mode);
+			if (!modeset->mode) {
+				ret = -ENOMEM;
+				break;
+			}
+
 			drm_connector_get(connector);
 			modeset->connectors[modeset->num_connectors++] = connector;
 			modeset->x = offset->x;



