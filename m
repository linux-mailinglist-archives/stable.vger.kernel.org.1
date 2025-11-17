Return-Path: <stable+bounces-194934-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 490C4C62F15
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 09:44:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 16A4E4ED063
	for <lists+stable@lfdr.de>; Mon, 17 Nov 2025 08:43:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A5502320A0E;
	Mon, 17 Nov 2025 08:42:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tmOtTaSV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4UuJKWAr"
X-Original-To: stable@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 051F730DD2E;
	Mon, 17 Nov 2025 08:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763368965; cv=none; b=jp4RlgCPOODYXlXHfyKx5wW8Zkt33bAvREyGWu1m8+RJUL4kAl6QSiaNhXZTUo+tz6EM7tas9A5tbnpJHZzVsFXD7HvDMVqkrWSl/PIEex4HtC8cnXQCoMZzerLIXADHrfAkUmn09q9zXCfyZp4TKlK+uqmHrzTOGPT0nFzEpWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763368965; c=relaxed/simple;
	bh=yePJkGfSCtQZBlmej9cL7pS+aD2u5JxO+xi1jowVm90=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XFpbupW4Vw6w3ynWFsPWu7OHTcdH4V2KNqiYLHmODj5b/vGHuiG+l2SKvP5y4oGxs41ImwjHXuSWD4SmwAYgTFMS7T6cSgAuDr50uWif7q5jq0uA+MEgGTpu1qpIDolZDQs8UAjom9qV/apvMCd1UmEHtuyWOrPScaRhGNQCIXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tmOtTaSV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4UuJKWAr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
From: Nam Cao <namcao@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763368962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g4qn0Y0Rqw592PoX51rNKaez6SCV9aIVGkzVEoBovC4=;
	b=tmOtTaSVCbbVvIQ0hI4PV9v/+wkYZRQB3MPYY+eZrDEJFs7MDGKTGbitxKjwk9emE88bef
	US/esNzQdfll9rzljPjVjfRObXr7Y9hOx4mOVFdibqGreyF93gzPY8z+exraEU8+uF7i0m
	NqMklN4w/8JbDR3qaYtW+WIjb9Jzl5HUrvr43Ak1g1X747CNGuVhT+EYpY8SlaXqh/FLtB
	rvKVCu4p3kIsyfdhUs/CicCRsCRMcF4xqZ0Gv4LxV1wz3xUkMLmKPh7LwF4qOrvlDCEA5r
	GnIvidIlM/Va8dJZQ0UDaMcemwkVwMMg60BkdBeJ8kG0T0hoT+SNtu8B5axgww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763368962;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=g4qn0Y0Rqw592PoX51rNKaez6SCV9aIVGkzVEoBovC4=;
	b=4UuJKWArM+/eV98WyjvhEQNFpcfXVUQHdGTBxpuKxo5nB0yRp0rCbgHa2gSsK9bfFMEhY/
	5EBf69eVzWqzJiCQ==
To: Lyude Paul <lyude@redhat.com>,
	Danilo Krummrich <dakr@kernel.org>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Nam Cao <namcao@linutronix.de>,
	Ben Skeggs <bskeggs@redhat.com>,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] nouveau/firmware: Add missing kfree() of nvkm_falcon_fw::boot
Date: Mon, 17 Nov 2025 08:42:31 +0000
Message-ID: <20251117084231.2910561-1-namcao@linutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

nvkm_falcon_fw::boot is allocated, but no one frees it. This causes a
kmemleak warning.

Make sure this data is deallocated.

Fixes: 2541626cfb79 ("drm/nouveau/acr: use common falcon HS FW code for ACR=
 FWs")
Signed-off-by: Nam Cao <namcao@linutronix.de>
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/nouveau/nvkm/falcon/fw.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c b/drivers/gpu/drm/nou=
veau/nvkm/falcon/fw.c
index cac6d64ab67d..4e8b3f1c7e25 100644
--- a/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
+++ b/drivers/gpu/drm/nouveau/nvkm/falcon/fw.c
@@ -159,6 +159,8 @@ nvkm_falcon_fw_dtor(struct nvkm_falcon_fw *fw)
 	nvkm_memory_unref(&fw->inst);
 	nvkm_falcon_fw_dtor_sigs(fw);
 	nvkm_firmware_dtor(&fw->fw);
+	kfree(fw->boot);
+	fw->boot =3D NULL;
 }
=20
 static const struct nvkm_firmware_func
--=20
2.51.0


