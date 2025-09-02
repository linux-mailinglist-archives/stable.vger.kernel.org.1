Return-Path: <stable+bounces-177257-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 62D38B4043A
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 15:40:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 442E8547EC0
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 13:39:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5083126056D;
	Tue,  2 Sep 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yfzOwiwD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E82830DD1A;
	Tue,  2 Sep 2025 13:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756820077; cv=none; b=EFlzo3xFMgDZgIzV7oiwo5YOGN/w9mvjZxAz4z3HI7wlwBzafiqsX/tti7jZaWLrRNmbrIl2ltuHL+/Og5/+WJ/cq9i6k2TkhqCcrwGoxngxIEHdoIA7WycI4l8ab1YEPb3KDDdnItN4kJgR9PeoFGM4Cr/7aDv8az4/12e0gMw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756820077; c=relaxed/simple;
	bh=3pSlwGFZoQPvEguzNJljMNMwXnHO8Fmwfjit5um4v/4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbwDwAIvM71/Q/Ma1/nmv2LpTYEm4wE+REdh1/pTLSHt96OC0m7NZn7h6Dl9bV082iZJAMkYow3w+w2g0yG6FzZqGzeQOXr/TQ+rz/sgoalGkwOx2HuQhtCUeexKBtq/B9qPwItkpqVpRQJ1WuiZip1IYYjmlhAXEvP+dh0o6oY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yfzOwiwD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89C4AC4CEED;
	Tue,  2 Sep 2025 13:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1756820076;
	bh=3pSlwGFZoQPvEguzNJljMNMwXnHO8Fmwfjit5um4v/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=yfzOwiwDDiwY7HeQQs+VgSffUhTWA1Lb6POCq6kKrn6QVkERlw2cZISxiJUd2x31X
	 5YCFJdqqXiPaebJKklRLLZB+xnq13Td+EyjMrACJjh2/zqnigux3l+jShr6x9PJFRR
	 257e5bzvA5Wf8GzBGkPzXBdRHpH4hf2rRc/aP1X0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Timur Tabi <ttabi@nvidia.com>,
	Danilo Krummrich <dakr@kernel.org>
Subject: [PATCH 6.12 86/95] drm/nouveau: fix error path in nvkm_gsp_fwsec_v2
Date: Tue,  2 Sep 2025 15:21:02 +0200
Message-ID: <20250902131942.904048348@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250902131939.601201881@linuxfoundation.org>
References: <20250902131939.601201881@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Timur Tabi <ttabi@nvidia.com>

commit 66e82b6e0a28d4970383e1ee5d60f431001128cd upstream.

Function nvkm_gsp_fwsec_v2() sets 'ret' if the kmemdup() call fails, but
it never uses or returns 'ret' after that point.  We always need to release
the firmware regardless, so do that and then check for error.

Fixes: 176fdcbddfd2 ("drm/nouveau/gsp/r535: add support for booting GSP-RM")
Cc: stable@vger.kernel.org # v6.7+
Signed-off-by: Timur Tabi <ttabi@nvidia.com>
Link: https://lore.kernel.org/r/20250813001004.2986092-1-ttabi@nvidia.com
Signed-off-by: Danilo Krummrich <dakr@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c |    5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

--- a/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
+++ b/drivers/gpu/drm/nouveau/nvkm/subdev/gsp/fwsec.c
@@ -209,11 +209,12 @@ nvkm_gsp_fwsec_v2(struct nvkm_gsp *gsp,
 	fw->boot_addr = bld->start_tag << 8;
 	fw->boot_size = bld->code_size;
 	fw->boot = kmemdup(bl->data + hdr->data_offset + bld->code_off, fw->boot_size, GFP_KERNEL);
-	if (!fw->boot)
-		ret = -ENOMEM;
 
 	nvkm_firmware_put(bl);
 
+	if (!fw->boot)
+		return -ENOMEM;
+
 	/* Patch in interface data. */
 	return nvkm_gsp_fwsec_patch(gsp, fw, desc->InterfaceOffset, init_cmd);
 }



