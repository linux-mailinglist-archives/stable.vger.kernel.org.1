Return-Path: <stable+bounces-104386-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B66BC9F376B
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 18:22:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 68455188319A
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:22:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6C42E206266;
	Mon, 16 Dec 2024 17:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="GlNio+bL"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1846F205E17;
	Mon, 16 Dec 2024 17:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.72.192.75
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369705; cv=none; b=a7p98rcbGaFPDVfzhWax+z48RbDf1hXgjvEC32lNkk/mlg/3qkqoWXnRqqsBpjBgJVtXaX4Wx2ARCZmgXNoFg6vyDN+bFJWOVM/oRghg6vFZm42KtHh62YTsgNUhPVgJsq4QwL4Y+3aIPCICNJ7gZiw+TS7BiQDdn0VNoMZsmKg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369705; c=relaxed/simple;
	bh=g/Hdc9SLw49UHJBQxnDSEM7A2PduIfZ8dNEiMd6vHOQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hVLu08v8HoBuKU7yOzLU14r6sdNYAvezb8jgUW69G/kNEgXejr858SZtDi6gtWbXHFsT9n0bzPR200OjlSc0NwoViQ4S0iWSKD4VK/9UibCJEIcbrdnHlN1F13QDbaOsEuL/nKhQYINmqyhbidMuHevAS3H+wTdZGW07Ed4KbyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=GlNio+bL; arc=none smtp.client-ip=217.72.192.75
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1734369695; x=1734974495; i=christian@heusel.eu;
	bh=LxONalUXsder9Tj+XTP7D4M3p6DsqjYpuGm6lwk5TxA=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=GlNio+bLJilz/Nc/Svr4d9I5xmkCuCLZ9N+6FW6+dFu4xwSglqIEkJ/OqTVvRV8Q
	 9JO5+Xh+DWd0gcdrC15SP18zFEHplpaxefbKhd2HRVJLI65qVwbGGpBAksGyCJ4vF
	 bLWBT8+RMEOx355fy+iMnYOyNpo8x22w9kCNMLv1/y9HLjkfiK2xhbMv3GMFz0jtL
	 xVEZIJu+EkztIqdA7jywiS2ZGSHw9Krjjc+jomqKciF4Aseqn62IZ7YFzAFPlPkwF
	 8Czoh5Rhmf1h4e2KoNzTm3EyLtNb2dhGP73cZDK6YvU/PYvvcddHKLk+Ua6i1OwMo
	 ED7jFZVUezvDLbuK2g==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.lan ([141.70.80.5]) by mrelayeu.kundenserver.de
 (mreue109 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MKbc2-1t8sfm2S3o-00UeJu; Mon, 16 Dec 2024 18:15:54 +0100
From: Christian Heusel <christian@heusel.eu>
To: stable@vger.kernel.org,
	=?UTF-8?q?Philip=20M=C3=BCller?= <philm@manjaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Mario Limonciello <mario.limonciello@amd.com>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
	"David (Ming Qiang) Wu" <David.Wu3@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Christian Heusel <christian@heusel.eu>
Subject: [PATCH 6.6.y] amdgpu/uvd: get ring reference from rq scheduler
Date: Mon, 16 Dec 2024 18:15:49 +0100
Message-ID: <20241216171549.1729353-1-christian@heusel.eu>
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
X-Provags-ID: V03:K1:x0OvB+GCXdag03AgnfolBtNnEJJgUsSbWTdADQL7QUe4BsxFmlW
 NSOg2+L8uqt17OvZ/TCJbLkOEeAOToXaelCnxUpuQdfVXSf8UK27WuA1jQ/6MMhgVAB4W1k
 IN0029klUFwwYPI2n9IOCNC9zvfM534zxL3G5KV7arr/q0GexgXbmjwh5PSKjivmISVxYNW
 GFOU7/b1B2MrmqtLw+45g==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:4eustjGBccw=;hvXDJIMhmRC1ecLs/eej/bJrlq6
 V1IcAincn3ViG1kwQmqeiwnQUoxl9Gyl+RGi2AJAWawtHWDAzxyzjyeQr+8Ann+dkW1W1KgLV
 va0vPKfTDmwe1JuT6QjoNsUpn68w6IXXWQ7k2eTZh2Mqn+PnM/IB72YNMiQIzKhAW6JUNXB3C
 j/095ufA1TmphNdvJ9jul+c5DhPs1We3T+oDw2LyGRPsolNEg/8AUkK5wYDCHKG/9Dm5ny2G9
 LiQgBHHeKbbC2Jv5vYbRJDYbdfrhrRmJacdhPANhrt+GGA1VFqP7pMSPcZJj0LLHSpmlwQp4t
 h/bFnrxeDhZ085RJSg589ODL4U0O+Fz5L7JYOAtu/+6DAubaf45nORqb6eeOX1seF9PdXYSkp
 mqedL2X8JvGSBfDYkxjV13zTXsO4JgQDtzp+RP+f/ciH+tzB2xdwhTCSOOgWVXV2BAKXHmFjv
 i9Xw3h9yj0MxfHD7urJHrRV1VkGMunzgywRYddMh4+/aApbstCivzwtGDFnxGYgSkJeRlWHLJ
 BhC3IEg0p9ycBcrEZMZ6u7LpcietKvxcXeiHDbpN+ANsVQTO7uxx2qdWkNw27QBa51D7Mua1F
 l17AcTYnPniHM1bHdOCEAW9rpK5165+lGMVG3pHPTOxPLJz+lnDTwj2ZmiSELYQrTcqXmDIRs
 qLx401ZcmGOZM+aHHjUamW1u2z89igl5Gu6jlcBBy2bDoeNViP+2jUPdnt8bJVC6Lu6tkAE4G
 gEKuMGx1eSiCACJoDgMEd1mpgA5v6a01W/p8kIzYOgPg0HE6EVwg1gtsN+GROZpy4jWpEMwg0
 Dp/ybXRYnCIs8u1mvwF5Z0cNGrbVoM+avz2lisS5RWFnPEgm2bW/OSFUA3sKI00cKIloZZC08
 Hx0qX0bRAbhKW07ROCZ7w1K6wwdxobnVRW1Smg1WrbwO53BCbh9WTSQ0LuMCznoVWGNIkn6BK
 N5fiq1Juc8CLkIrXtlhxcwffNN6OkZC5SXMqbDBsGjG/UmApNBIWWHWp1Mf7HRmffvzVyO0mK
 5fFDWdzPdSiUHbtjG93z6nu4AK5ZtkZSi4aAgTW

From: "David (Ming Qiang) Wu" <David.Wu3@amd.com>

base.sched may not be set for each instance and should not
be used for cases such as non-IB tests.

Fixes: 2320c9e6a768 ("drm/sched: memset() 'job' in drm_sched_job_init()")
Signed-off-by: David (Ming Qiang) Wu <David.Wu3@amd.com>
Reviewed-by: Christian K=C3=B6nig <christian.koenig@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 47f402a3e08113e0f5d8e1e6fcc197667a16022f)
Signed-off-by: Christian Heusel <christian@heusel.eu>
=2D--
 drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c b/drivers/gpu/drm/amd/a=
mdgpu/uvd_v7_0.c
index 86d1d46e1e5e..4fba0b3d10f1 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1286,7 +1286,7 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct am=
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


