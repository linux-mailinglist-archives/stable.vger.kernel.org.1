Return-Path: <stable+bounces-147883-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 86983AC5AEF
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 21:45:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 482751BA6781
	for <lists+stable@lfdr.de>; Tue, 27 May 2025 19:45:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9B411BF58;
	Tue, 27 May 2025 19:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b="KO79ENi7"
X-Original-To: stable@vger.kernel.org
Received: from mout.gmx.net (mout.gmx.net [212.227.15.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A88E745009
	for <stable@vger.kernel.org>; Tue, 27 May 2025 19:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.15.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748375120; cv=none; b=uytKe3MIQ1VW0CA5j1jxfYKU3WoRWfstmzeMrFE2PJN5EuFxGijAx246GrYQGJN7Ffbjk2DH7X3nk2ApaHLmWJCXsQlMFieWhHIBKT7RIB6pWYdugA5nsjiEbg6ZZge05K2Ycq01A+bzQ+Xbe0UZEjloGckbcvh3VVfSC2TkwZM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748375120; c=relaxed/simple;
	bh=hHiXx2dfR2wI9B4j1fNfS+yi4xkIC+xvmn+Bm3chrao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d6o2kug9Cp1ig2SlTHa2jqhSUYP5FkIDoBjzN6QDwvwiJkIdG8nXND2b4ozLAbcU3CseVyCKMlipJITLK3t4zOkLsoDwtswusTMWtQn/giiLX2TlhNaiz3wzVNdcungFErT3W6zlpofAAmhjWD1htU139WxdRi8P0BKd0gOGuNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de; spf=pass smtp.mailfrom=gmx.de; dkim=pass (2048-bit key) header.d=gmx.de header.i=natalie.vock@gmx.de header.b=KO79ENi7; arc=none smtp.client-ip=212.227.15.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=gmx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmx.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
	s=s31663417; t=1748375100; x=1748979900; i=natalie.vock@gmx.de;
	bh=Epo7gdDY+vOcQ702mnbNNZX+jejI0N2QF3Cp5n8Mdvg=;
	h=X-UI-Sender-Class:From:To:Cc:Subject:Date:Message-ID:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:cc:
	 content-transfer-encoding:content-type:date:from:message-id:
	 mime-version:reply-to:subject:to;
	b=KO79ENi75rosQ7YihlsEZFqOBvuVfmzURf+LqZT71tZ6JHFVkGvf+W6uqqZIoTPO
	 3X6aUNJfSqH8ctHv6lUqVbi4jdJDJTbYM+9bXu44VF32STVpXtOOLA0RHSvBKhgr6
	 3u+9ICGcfwtnduJcPZqBHT5nPaOl4FVxfhWpgPEEmYH+UeXgwBu9DjMMjGK/JCh8i
	 0dEjaC698a8IqytsGBcvqGNyhuzAI9TtcdwG4cRvpV/ok+KJdM4IfWb6d9cAermve
	 pZnKsdmEUkN9rIXRBqdavt0eg9p+HpFP970hP4QMZ9iyekx2UyxK7aNykVq3eqbkr
	 7Q45UOhkuxu1o+b4+Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from localhost.localdomain ([109.91.201.165]) by mail.gmx.net
 (mrgmx005 [212.227.17.190]) with ESMTPSA (Nemesis) id
 1N1fn0-1v4RwC0iTo-010ZmR; Tue, 27 May 2025 21:45:00 +0200
From: Natalie Vock <natalie.vock@gmx.de>
To: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	Natalie Vock <natalie.vock@gmx.de>,
	stable@vger.kernel.org
Subject: [PATCH 2/2] drm/amdgpu: Dirty cleared blocks on allocation
Date: Tue, 27 May 2025 21:43:53 +0200
Message-ID: <20250527194353.8023-3-natalie.vock@gmx.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250527194353.8023-1-natalie.vock@gmx.de>
References: <20250527194353.8023-1-natalie.vock@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:dVN3WfoLH9ABYbROuTDWX1Z+A+OBgwagxLhxW+cGgjpcFCPxYCu
 XNXy1Yp2jZ5/6MYMiPa059jv/yLqLt4qg1dFVWkkWqujUgXxqgon+l+57ftOw8nfZFNxQ61
 zogG6E6WHfaLABbUo4WYtl+O/P7VYEf3+qTtYVYh4ShfOZG8sJp8tpDORQmDecmBCUpKJuX
 vwEXFPWZc3tAr54fIafdQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:OErwcn66BHM=;WVvaVE2TNzq9K5+1M50x7eaeknC
 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
 L1ZHfKoIUTKPoogM

If we hand out cleared blocks to users, they are expected to write
at least some non-zero values somewhere. If we keep the CLEAR bit set on
the block, amdgpu_fill_buffer will assume there is nothing to do and
incorrectly skip clearing the block. Ultimately, the (still dirty) block
will be reused as if it were cleared, without any wiping of the memory
contents.

Most severely, this means that any buffer allocated with
AMDGPU_GEM_CREATE_VRAM_CLEARED | AMDGPU_GEM_CREATE_WIPE_ON_RELEASE
(which is the case for **all userspace buffers**) are neither
guaranteed to contain cleared VRAM, nor are they being wiped on
release, potentially leaking application memory to arbitrary other
applications.

Fixes: a68c7eaa7a8ff ("drm/amdgpu: Enable clear page functionality")
Cc: stable@vger.kernel.org

Link: https://gitlab.freedesktop.org/drm/amd/-/issues/3812

Signed-off-by: Natalie Vock <natalie.vock@gmx.de>
=2D--
 drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c b/drivers/gpu/dr=
m/amd/amdgpu/amdgpu_vram_mgr.c
index 2d7f82e98df9..cecc67d0f0b8 100644
=2D-- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vram_mgr.c
@@ -591,6 +591,13 @@ static int amdgpu_vram_mgr_new(struct ttm_resource_ma=
nager *man,
 	list_for_each_entry(block, &vres->blocks, link) {
 		unsigned long start;
=20
+		/*
+		 * Allocated blocks may be dirtied as soon as we return.
+		 * Mark all blocks as dirty here, otherwise we might
+		 * incorrectly assume the memory is still zeroed.
+		 */
+		drm_buddy_block_set_dirty(block);
+
 		start =3D amdgpu_vram_mgr_block_start(block) +
 			amdgpu_vram_mgr_block_size(block);
 		start >>=3D PAGE_SHIFT;
=2D-=20
2.49.0


