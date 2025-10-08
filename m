Return-Path: <stable+bounces-183576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CAB5BBC335B
	for <lists+stable@lfdr.de>; Wed, 08 Oct 2025 05:20:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id BB6534E65F7
	for <lists+stable@lfdr.de>; Wed,  8 Oct 2025 03:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CDF929E0E9;
	Wed,  8 Oct 2025 03:20:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b="O1mWmbhe"
X-Original-To: stable@vger.kernel.org
Received: from cse.ust.hk (cssvr7.cse.ust.hk [143.89.41.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5AF1209F5A;
	Wed,  8 Oct 2025 03:20:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=143.89.41.157
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759893641; cv=pass; b=LOpzF08Igi5tCChyTkBLZR0BMO4uK/q9wRLVMMxt/OOgKufBiwR71rotj6+TjDs12f0avQ4/MJIAfn1AOZX6/syC+BR+vsw36Z12m2xx1AxEgBsVoLFoBWmpDuqet39cHFPtfR7ZMFXWJxx0sdmq4c+YLEzEsUU0PbQGhkEZJCg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759893641; c=relaxed/simple;
	bh=7d2Q9ZTuBEetu77KNDrONqWiHf5pg8/Rj+okFCgdYRU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=urcCKPmeg2A+mjil12S/icMgv8+NsXYK+GLNEdkpfmmKxqTnZIIClniU5S0naTvq8zsg4pCFaaIRgqS8mOYWO0y3ilyQoqKarOeBg1ZnCcKhsBgFa4Dlq+8+pHxwFmq7NWaVjTh8X+/p4gvqqgLuDcJGEE1ZATqEZmd65vVh3+A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk; spf=pass smtp.mailfrom=cse.ust.hk; dkim=pass (1024-bit key) header.d=cse.ust.hk header.i=@cse.ust.hk header.b=O1mWmbhe; arc=pass smtp.client-ip=143.89.41.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=cse.ust.hk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cse.ust.hk
Received: from osx.local (ecs-119-8-240-33.compute.hwclouds-dns.com [119.8.240.33])
	(authenticated bits=0)
	by cse.ust.hk (8.18.1/8.12.5) with ESMTPSA id 5983K89V1969764
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 8 Oct 2025 11:20:14 +0800
ARC-Seal: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse; t=1759893615; cv=none;
	b=rcPP8yLtXjCv4k/DLipdIwhSVZ5CwYt/xRFq7i0sc44nIC1QHO6MKK6f4NMvuQ8kYDya1k01xg07pUe2fM3cXzrsuq+OJWSQdo8LQCS9USU+itC8yK2FujLsLpkMTCmEiHkvUa3UPZ9mfTNiDN7YE8cQdqJhQjQDQJ2rOQyn4Rw=
ARC-Message-Signature: i=1; a=rsa-sha256; d=cse.ust.hk; s=arccse;
	t=1759893615; c=relaxed/relaxed;
	bh=WuLSA2EjkrLhSQFnaBGCNZGIYOqkvds6auE54bA3lWQ=;
	h=DKIM-Signature:Date:From:To:Subject:Message-ID:MIME-Version; b=cSCrFM+NEka5AqGCOg0vIypTESoI7v1+4r5/Iw+kIN7yny9+mcqkVFeAOpPi2vuB63bMjH9YfY+PwtIsi39lRszyy0eNcDlHUkBd47H0omi5RdOmJpJ6rmwT0PsW6f3y3S2JAcL3PwByrbKkfCTykeSXiS35+nefRX9kbPdq0w0=
ARC-Authentication-Results: i=1; cse.ust.hk
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cse.ust.hk;
	s=cseusthk; t=1759893615;
	bh=WuLSA2EjkrLhSQFnaBGCNZGIYOqkvds6auE54bA3lWQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=O1mWmbhe3wxDfirmk6JKjwo4Qc+QANnMrDAiMaxMv6vbHp21QI7HEUmaDtREupztT
	 ITsS1D23MTLgcXf6uISKfRLSIZ43UdPgZs0z8dh//rgVL68sU0qEaYGtX3KX+x5a4p
	 SIjm8/XVkjp/qyzWU2cfbTulg9rsFvv7Ircqe+jo=
Date: Wed, 8 Oct 2025 11:20:03 +0800
From: Shuhao Fu <sfual@cse.ust.hk>
To: Lyude Paul <lyude@redhat.com>, Danilo Krummrich <dakr@kernel.org>
Cc: dri-devel@lists.freedesktop.org, nouveau@lists.freedesktop.org,
        stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3] drm/nouveau: Fix refcount leak in nouveau_connector_detect
Message-ID: <aOXYV5pgilTvqMxR@osx.local>
References: <aOPy5aCiRTqb9kjR@homelab>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aOPy5aCiRTqb9kjR@homelab>
X-Env-From: sfual

A possible inconsistent refcount update has been identified in function
`nouveau_connector_detect`, which may cause a resource leak.

After calling `pm_runtime_get_*(dev->dev)`, the usage counter of `dev->dev`
gets increased. In case function `nvif_outp_edid_get` returns negative,
function `nouveau_connector_detect` returns without decreasing the usage
counter of `dev->dev`, causing a refcount inconsistency.

Closes: https://gitlab.freedesktop.org/drm/nouveau/-/issues/450
Fixes: 0cd7e0718139 ("drm/nouveau/disp: add output method to fetch edid")
Signed-off-by: Shuhao Fu <sfual@cse.ust.hk>
Cc: stable@vger.kernel.org

Change in v3:
- Cc stable
Change in v2:
- Add "Fixes" and "Cc" tags
---
 drivers/gpu/drm/nouveau/nouveau_connector.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_connector.c b/drivers/gpu/drm/nouveau/nouveau_connector.c
index 63621b151..45caccade 100644
--- a/drivers/gpu/drm/nouveau/nouveau_connector.c
+++ b/drivers/gpu/drm/nouveau/nouveau_connector.c
@@ -600,8 +600,10 @@ nouveau_connector_detect(struct drm_connector *connector, bool force)
                                new_edid = drm_get_edid(connector, nv_encoder->i2c);
                } else {
                        ret = nvif_outp_edid_get(&nv_encoder->outp, (u8 **)&new_edid);
-                       if (ret < 0)
-                               return connector_status_disconnected;
+                       if (ret < 0) {
+                               conn_status = connector_status_disconnected;
+                               goto out;
+                       }
                }

                nouveau_connector_set_edid(nv_connector, new_edid);
--
2.39.5


