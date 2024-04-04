Return-Path: <stable+bounces-35974-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 198AB898F9B
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 22:33:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C830A28C9C5
	for <lists+stable@lfdr.de>; Thu,  4 Apr 2024 20:33:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3FA0A133426;
	Thu,  4 Apr 2024 20:33:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="XH1dVEZ+"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FCE210E4
	for <stable@vger.kernel.org>; Thu,  4 Apr 2024 20:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712262825; cv=none; b=GRHUfz4mgZjuAblcjw7CRNTz7PKQBfqvf4HeUNUsYjoxq83V7GhX5GNfIziNUrxgHq1g1a6BseFsgFs5Z2cI1ehKHnTmqNsWiUocxiUwvyg21t4qy88D25i3WFuIg+l6OEZmzZb8i6MvWgSEH1EyxuUJn60SCM5SU90A9SiNHNY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712262825; c=relaxed/simple;
	bh=zilOGH9d9aSJ4609zaqdQzRgfqugSYDSLLlLCXBZbuM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a201Ik5niytQj4cgOaxSigboQ9+rhMCdktqDJv4NMHlYyIhXfB+Xt6qiw4XLnGHuY779+dHxNIeW9Hr55AIL8mQ/KFvbo8BfxjdfgWFzwajriyfbriqor4hCtjGtoDjekcdoel2M5JYlSu3L7xdMQpAzVyeZ0kugqdVih0kfU4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=none smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=XH1dVEZ+; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1712262823; x=1743798823;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=zilOGH9d9aSJ4609zaqdQzRgfqugSYDSLLlLCXBZbuM=;
  b=XH1dVEZ+Zb+yq8W4qnaImTg0+yFX3TBCtU+D2yVyQz85saD4/+QCs4a4
   KbAR3BW5FDTHw5gw7MCkgZFTx9oOIiuFOFEi/PsT5hhYiUu6sXHCGDKOZ
   RR0GsMHF1Kw1hkZm6P1N6tJxOrGoLxqkJMcpPwoeh+YfzM1mSAoPzBNII
   PROk88RcDaDg2Lkx0bKska2yVfDJMQ8QFZ57DrRoGGym06ASFT/Iv9S8H
   uC8HMCvwNmvJcmj1aE502iUoLxjMld4Ia/yN2QJPdBu3q4+w39hkB9q3O
   05iax5GU6ioprybCeVjL0wCjeSHDWWdXqWxl5xqUitciRVvTeBnh2GC+1
   A==;
X-CSE-ConnectionGUID: DzfEPtCBT3+gYkjGUNbZ+w==
X-CSE-MsgGUID: ai3AiOEXQT6q8A8E8tVn2A==
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="25019719"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="25019719"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2024 13:33:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,11034"; a="827790578"
X-IronPort-AV: E=Sophos;i="6.07,180,1708416000"; 
   d="scan'208";a="827790578"
Received: from stinkpipe.fi.intel.com (HELO stinkbox) ([10.237.72.74])
  by orsmga001.jf.intel.com with SMTP; 04 Apr 2024 13:33:40 -0700
Received: by stinkbox (sSMTP sendmail emulation); Thu, 04 Apr 2024 23:33:39 +0300
From: Ville Syrjala <ville.syrjala@linux.intel.com>
To: dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org,
	stable@vger.kernel.org
Subject: [PATCH 01/12] drm/client: Fully protect modes[] with dev->mode_config.mutex
Date: Thu,  4 Apr 2024 23:33:25 +0300
Message-ID: <20240404203336.10454-2-ville.syrjala@linux.intel.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240404203336.10454-1-ville.syrjala@linux.intel.com>
References: <20240404203336.10454-1-ville.syrjala@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

The modes[] array contains pointers to modes on the connectors'
mode lists, which are protected by dev->mode_config.mutex.
Thus we need to extend modes[] the same protection or by the
time we use it the elements may already be pointing to
freed/reused memory.

Cc: stable@vger.kernel.org
Closes: https://gitlab.freedesktop.org/drm/intel/-/issues/10583
Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
---
 drivers/gpu/drm/drm_client_modeset.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/drm_client_modeset.c b/drivers/gpu/drm/drm_client_modeset.c
index 871e4e2129d6..0683a129b362 100644
--- a/drivers/gpu/drm/drm_client_modeset.c
+++ b/drivers/gpu/drm/drm_client_modeset.c
@@ -777,6 +777,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 	unsigned int total_modes_count = 0;
 	struct drm_client_offset *offsets;
 	unsigned int connector_count = 0;
+	/* points to modes protected by mode_config.mutex */
 	struct drm_display_mode **modes;
 	struct drm_crtc **crtcs;
 	int i, ret = 0;
@@ -845,7 +846,6 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 		drm_client_pick_crtcs(client, connectors, connector_count,
 				      crtcs, modes, 0, width, height);
 	}
-	mutex_unlock(&dev->mode_config.mutex);
 
 	drm_client_modeset_release(client);
 
@@ -875,6 +875,7 @@ int drm_client_modeset_probe(struct drm_client_dev *client, unsigned int width,
 			modeset->y = offset->y;
 		}
 	}
+	mutex_unlock(&dev->mode_config.mutex);
 
 	mutex_unlock(&client->modeset_mutex);
 out:
-- 
2.43.2


