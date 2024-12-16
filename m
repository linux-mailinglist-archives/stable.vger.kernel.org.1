Return-Path: <stable+bounces-104387-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 39F539F3777
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 18:24:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F150E1884368
	for <lists+stable@lfdr.de>; Mon, 16 Dec 2024 17:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1256205E31;
	Mon, 16 Dec 2024 17:23:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b="L98pygMw"
X-Original-To: stable@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCCF4EB38;
	Mon, 16 Dec 2024 17:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734369784; cv=none; b=fLZcqeGHL+f4/ouTCuSQklDPUv/UH2W5culz7UlXNLZcVElzdSG2cJ4Lklg0+nJozcdIf53+VljQGfYuIcqNFzU3UCsnjTf7qbq0H6FrchM3BovPPD4FnkMYMTExmP02x8vnOuKN5GdjTHXcWut+LlXK8J1cBadZi21Z6UPYGs8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734369784; c=relaxed/simple;
	bh=fzlQ95lRUf70t6aa2i5KzdnifjEDoPpkgsMLZez+sw4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DhSiCZwDdEOGJtT+4h5iBD+3LSLvKNOOwhAHWtO0YKcbV4RE3hDKHVd2w6oDjO+7ro9vWwhLK6rUKZIVjL2av43DHrW2CaER2XzV/xLlrkDLkduiZp4NK3n1R1YLlwiFgbyMaej74EEUvAGFJnsiqfJhqL3G0Er/0jo/MA9o0FQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu; spf=pass smtp.mailfrom=heusel.eu; dkim=pass (2048-bit key) header.d=heusel.eu header.i=christian@heusel.eu header.b=L98pygMw; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=heusel.eu
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=heusel.eu
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=heusel.eu;
	s=s1-ionos; t=1734369776; x=1734974576; i=christian@heusel.eu;
	bh=d1bs32I9MhR7rMd4Z9on5F9rIKFrxNTKssAa/K6qKuw=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Type:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=L98pygMw47/B3sD6YPgiUMnJYcIO3qQQgtdPQiJArxkSd4dRY/Pu+v2jc5DxOYU7
	 zmLcg3+TvukFTrfCHrY71kdSU7FG7B7zsWpxUd/TE0UqUgGCgoUoEA/5gOYQw3y9Q
	 0+QciIJaDzyEKfL64q/BzFgO9gb9OtIp7OFLid9PkiqkGY1BpyWXEYbRPlGOCkxFh
	 KAhZqzglmfpH0/HCB8utUEt3s0veBWkQ7u+CLeENCqEzDMW3kmm4wHxBuDd+VekfJ
	 ts1kfjcauEIEnrfqLmLW55F+ENgK5XNQ/fyJdc3VBfcAl6DGwrZgeMP0ILOnlsXC7
	 7xmjfJMT+QwDRhoxcw==
X-UI-Sender-Class: 55c96926-9e95-11ee-ae09-1f7a4046a0f6
Received: from meterpeter.lan ([141.70.80.5]) by mrelayeu.kundenserver.de
 (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis) id
 1MXGak-1t517200Qo-00KL1X; Mon, 16 Dec 2024 18:17:18 +0100
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
Subject: [PATCH 6.1.y] amdgpu/uvd: get ring reference from rq scheduler
Date: Mon, 16 Dec 2024 18:17:10 +0100
Message-ID: <20241216171710.1729859-1-christian@heusel.eu>
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
X-Provags-ID: V03:K1:mkOgkVZHRWV7wYNDILo3Yw3U45ypoJdo+ZVnfIUNAhsPXIFgx/S
 j7Fk31qZ9xKtR6A/2zqI//yYvGV0tgrkFl7HFGS8pDIYdTg3vNqEzEUnXbpw2oxJpY4sDuC
 Dwpk+fe1Hbd2TuSTzBUn4LlRQWQBAsrY66SS8sDYR5By7BLqMnsxmu6kJ3VCRaXq6eDFcch
 JS+c1eN8/mLgOkbtBm1UQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:uMg9kehp6Gc=;lgDaH3A+LBPlOAf2MVjjNolizi+
 d7Z1UW59tgmyr7F+E5gLMwNqC+VWuvCJTcJTiZLkz/cpOVLV1UqVsTtdjCDsm/OfXAoGj9lQB
 /k/7A158rWyQsuV9PB6ezMihE0zHY+yI39XWapibCO83RGW8YMzo3EIMBbGyHVCYRzyPqEzdt
 4fbnJRV+ja6/7+0W0smCKiopva3vbeeSYVkuvhGIl0iie8u4txtIeOQ3ymxhjPqHqfNFFgEBM
 toy4334m7sBFJf+WfWWaWvklhZ0CE6OO6zYWYMuNM47IGQfEb2bBLqzv7O81pIpGFoUyHxgct
 3NNFgJZGegLlhbAM/lAzv3PjrmljibiFUamvWwp2CF6BE4KuPYYcHZYPfquky6ECS/Bo+OV06
 6VnyQK8zVsVs4UNSO6yVBXWKnUvLJ7PMyP+8u/v/DMF/AExg+YDzSqB5mWSivaNkUDc5usJCQ
 4pXJW0303CNdKj77IFL8RIpQoKAFyZAjLLxR8eIrWB84dH++Cl+5yp0tKjFJI1hbPJnrHiFp1
 YjV3l585DhPrBouYaUWoMvxJbZ72S3tw2z/XSza4jO6o32b1YcGZ9OZ4mLutP32i1Htc4GIMh
 G/Bch3D5YP7/Hr2i6SWTKbx/B4Y+SCD8I24/2pWPulfhCpT2S5CFB7C3rmkfMIto4NkWpLRDz
 mXpS360aQIwEeQovTckVBX3cnQCJunkE556bC9CtuA0yw1TW9KBXOaRMw1yvnmXBN1Xf9foNz
 PpbG/2AYdoIkUyH5Mq3Pk82pXGBa7eQSGSloJs4E88pq84jSRafP8KCYj0lwhUbxOFU3F+VyB
 ycEC7g3DsCmSqUyd0AWKg9RKDA+xfCKjpvDHpArF7+/7wxEK5LuZnWQA3AWpIwnt2pYByOVha
 p4+qC3CfYlkvlQ4XKUTLXSrwyqjiBj72SiXUvw4QEL2CJO39okBDLezO4R93fHunhAg52tA9y
 WZ/S4nuYvyJJU5J+zLP8SnZYwbP2cjcATShsOLj/9XGvEEIt8MzaRu8ICnwtQz19fF8cfuFCF
 jqZUcYpS+F2aSVM/LhQfXsAoGcUYMoeRMEseIC+

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
index e668b3baa8c60..1c5d79528ca75 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
+++ b/drivers/gpu/drm/amd/amdgpu/uvd_v7_0.c
@@ -1284,7 +1284,7 @@ static int uvd_v7_0_ring_patch_cs_in_place(struct am=
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


