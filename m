Return-Path: <stable+bounces-104384-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 383AF9F3720
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 18:14:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7B1D67A54B1
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:14:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A98B3205E2E;
	Mon, 16 Dec 2024 17:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="NZi4WoX3"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD5A0206269;
	Mon, 16 Dec 2024 17:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369189; cv=none; b=EQI/AI9MMG6AuS1BaST5kR2BInQq6P5jhqYZoD+QpI/PtvSYe1DXjABipKO4+Ahx/kGghAVIxFOiuc4tHTf6SludEGLyXUonBDZIJVeX08peaqJOrgWfySlWgqZuC3Z3wfip3hy5vE6SXZLuyvqznKbYC1lIFATSi7XJThNJn/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369189; c=relaxed/simple;
	bh=6N+eu+/irAyGfKsQGYlEcT3OSWa09XZOE7Y+4BDwTaY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=IHKa3QMd8YnmSRZiXkHZPvghuY8tRNCF60F7e//IsOS3rXIc1auJTmpkfDfdPirw0X+h+vd3fUsR7g3toUvYDCPkKXTZ7KAlvm1La3fRuXP/wlZeqptSohv/WShGadUPfqIWraRR/rh/Pi/tjnvogD2DqnUQUQOSW/nIyqvVtQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=NZi4WoX3; arc=none smtp.client-ip=212.227.126.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1734369163; x=1734973963; i=christian@heusel.eu;
	bh=KjNS+UnMdiex2ZH4y6IXBjpzth/EivtUkC1wsD2jnk0=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=NZi4WoX3NifmeJI7D1Ig+Y0IMVog1RYs83u1zZmfgi7Li7YOQKCae/QUbzxrGVf9
	 uKrU3voorVpmYhKiOtZnbo10ZKXBLQH1TOFLzHefWmKnSt/Yb+suDJosh02JtCzV6
	 4PbP2LE8GTkVn3O5dP0/zwFSyLWkfbNhkmoFicz1ZoqwJfs8OVj3CtJUGnuWiypZg
	 OYjghoFuuoGIjQxJEF/U475iF2g+PLdYs6Eu7IBivJjt3hS0w2p7FK3XeI69KvRO6
	 JtJj2Z0JpOP87EgCGhNoUbtsgqUTwG7EOseh43itPcsnThTg6plAnOS+rkALSDKzS
	 v0ET2KDwHjIqA2ng8g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.lan ([141.70.80.5]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MqK6l-1tt0dk1B6R-00aMJQ; Mon, 16 Dec 2024 18:12:43 +0100
From: Christian Heusel <christian@heusel.eu>
To: stable@vger.kernel.org,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
	"David (Ming Qiang) Wu" <David.Wu3@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: [PATCH 6.12.y] amdgpu/uvd: get ring reference from rq scheduler
Date: Mon, 16 Dec 2024 18:12:28 +0100
Message-ID: <20241216171228.1728499-1-christian@heusel.eu>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <719b5eb1-a5a9-4dbe-b3b1-399fb299bafb@manjaro.org>
References: <719b5eb1-a5a9-4dbe-b3b1-399fb299bafb@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:+fUa3ShK9Sh/SKPXOk4BYlKgezEhcZKlV7wVKIgGjTzVDwX6X+1
 3lQL8/VqCkyG7YMewt0naIRj2Jg2n4QUlrywYcidewKuiSru8Eny+OtRItaW2qy+sXzABXm
 A/ISKvQUshx93Wq1PC66Q+At4Yee1XavPfqiJ19c/8Ju6uXuh3Na3f5uAJ/g6rxun4JEoI1
 fGZlLVaC+3RaUfV6YocOw==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:EbG3xVjeA4k=;qruDq3JtGbyRrSFwWJdLPi+PY/7
 Wr0/IhasTwsWuw28ruSxciyzPQo52BJyPuIQ4PB/I6736aG+fD8LuxNjpJaOU/eOXQvrl/0Rr
 bOaKRSoUopw1HkS+yZuNCn+Wjmok0Clo9rZ/LrFIixHdVdR2Oay7iQzBwo4aEycgjTAkDnKxz
 GfMM7SgaDHJfubqsvJW4kMnskrN+nkC9+9Aly6IMIbw9DbyFfZrwh9to51aIU1jS9uRG/FhEG
 zMLhgu74nZ7sOR12Tj3W2e60MBBbE81bkE8yPoVDiPc11+AsgKFEjONk/BMouATHL/84sBU1y
 vs71EeQ7StgK9irilWR4RY0y5kzalu7wSpTEnououNaIOfQttqG6WqzlMRLqMOeT82tm9aEOf
 2JqZC7z99f4qwOBUsbJ6wzxwyVrRol0k4dJgnjYbDsiHWwz/GrKJjICx7iLPWDpdWe0SR/my5
 9s849B9T91hNsduvJNZCGVPtunzFTduStEoFM9/uPlcexzxS6EUV34g3xkc0sqM4vMRc9OUto
 pliC+j2vCtRw1biEoQ2GcerRp3fqPY1p8ELwJ3dhiB+NrPqIsYXURbjLAAcNpHsg7tURXXRdV
 6vzrf+o7Udme9wbqwbUyNq/EMHoSnz6YELQDod2CfsvyAuzaCTPUKQLccWKKPF2rWvUQY8otC
 YVT5WCBbpiHW6cg2T/9iccbyifh+BDL1EzuRoi6aJyk3lL6FWNd68IX88C4UeUzhW095PcsNQ
 cXwFyszJZvHMUCGmzmkfh3kzLf5t0m7+RGnS6D2+oY5AJZcc90jDmukxR9jzq9d4n27VG4J7Z
 4icruPtmnP9jolVfvhcUh00ULVhiu6edcRpOj87ApRiESQvoiIaE2c3pY6se0qMkT50MuuFQo
 o6rus/1vV177nGv1kuxQifNzKWdGD+zqy3hx3w4U8ndUZ9JkTh+93KI944N/zfmGX9dE63w3c
 57PDGVWiHC1WRTYI0YPh4h8oW4LJN+bCONdwZ5/x7s4CmBIRugG2Rf6E2f58JntF7COrgCZZ/
 Hq/hgYGR/Yfn7wTZlJSwSbQ5AYx+fHAz90ZfEoQ

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

base.sched may not be set for each instance and should not
be used for cases such as non-IB tests.

Fixes: 2320c9e6a768 ("drm/sched: memset() 'job' in drm_sched_job_init()")
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 47f402a3e08113e0f5d8e1e6fcc197667a16022f)
=2D--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/uvd_v7_0.c
index 6068b784dc69..9a30b8c10838 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1289,7 +1289,7 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct am=
dgpu_cs_parser *p,
 					   struct amdgpu_job *job,
 					   struct amdgpu_ib *ib)
 {
-	struct amdgpu_ring *ring =3D to_amdgpu_ring(job->base.sched);
+	struct amdgpu_ring *ring =3D amdgpu_job_ring(job);
 	unsigned i;

 	/* No patching necessary for the first instance */
=2D-
2.47.1


