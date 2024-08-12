Return-Path: <stable+bounces-67271-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C965094F4A8
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 18:33:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 752F91F21A9E
	for <lists+stable@lfdr.de>; Mon, 12 Aug 2024 16:33:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0012186E5E;
	Mon, 12 Aug 2024 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Gt2Q28Ux"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E1752C1A5;
	Mon, 12 Aug 2024 16:33:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723480381; cv=none; b=puewk0HHKh3bfH5nO9R72UVP692ExGaJ3OTyNMqi7OsShNN4KB7LRWI5Q7D1PjT6nuusAnqBmADrNdYSRtZp/Olc9ZCcP6oC465vcpacJ/ab5HFeAryDIWr0B/fttGlEBlOv0nTMQSadIWnd4qdxsM7LSzLcPJRrma82KTuAfik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723480381; c=relaxed/simple;
	bh=C04Dr4td85igqzAXBmaDcWWABzS03a8qfo9PvJa22f0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y0aH5VW3vRgabtO2yd/znRUaqPe1qsBdownPGkC0P7r6fT8IjPxRsIrezne7DnpIG4/g5rqR0YLVFRQ7KrlrasNfSqM05SVmkO5e0Am82FYbUzZaDAJPajJge3tzW0LpEykceFhmMEQ6nGa4b5596NLYnS7QoOQ5rpIrmIOcJrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Gt2Q28Ux; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 010D6C32782;
	Mon, 12 Aug 2024 16:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1723480381;
	bh=C04Dr4td85igqzAXBmaDcWWABzS03a8qfo9PvJa22f0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Gt2Q28UxS55UZyyNwcK+yR5nU7Ao/utNhMrDgISYROyvuWwUr2tv0qbEWjfOorso2
	 SVggO4zDOBt53TD4dtPgVRjgJrZap1MuyN89Vo+Hl99PdQJ64X45rObG5Z+T3xjgNr
	 lralcEuhWMgoIA32U/v44YdhCH/GGBFIxEgKNSM0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dave Airlie <airlied@redhat.com>,
	"Michael J. Ruhl" <michael.j.ruhl@intel.com>,
	Daniel Vetter <daniel.vetter@ffwll.ch>,
	Marco Pagani <marpagan@redhat.com>,
	Maxime Ripard <mripard@kernel.org>
Subject: [PATCH 6.10 178/263] drm/test: fix the gem shmem test to map the sg table.
Date: Mon, 12 Aug 2024 18:02:59 +0200
Message-ID: <20240812160153.363809622@linuxfoundation.org>
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

From: Dave Airlie <airlied@redhat.com>

commit 62b45bab010d1b0cea6166f818f1cd0666a6d8d8 upstream.

The test here creates an sg table, but never maps it, when
we get to drm_gem_shmem_free, the helper tries to unmap and this
causes warnings on some platforms and debug kernels.

This also sets a 64-bit dma mask, as I see an swiotlb warning if I
stick with the default 32-bit one.

Fixes: 93032ae634d4 ("drm/test: add a test suite for GEM objects backed by shmem")
Cc: stable@vger.kernel.org
Signed-off-by: Dave Airlie <airlied@redhat.com>
Reviewed-by: Michael J. Ruhl <michael.j.ruhl@intel.com>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Reviewed-by: Marco Pagani <marpagan@redhat.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240715083551.777807-1-airlied@gmail.com
Signed-off-by: Maxime Ripard <mripard@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/tests/drm_gem_shmem_test.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

--- a/drivers/gpu/drm/tests/drm_gem_shmem_test.c
+++ b/drivers/gpu/drm/tests/drm_gem_shmem_test.c
@@ -102,6 +102,17 @@ static void drm_gem_shmem_test_obj_creat
 
 	sg_init_one(sgt->sgl, buf, TEST_SIZE);
 
+	/*
+	 * Set the DMA mask to 64-bits and map the sgtables
+	 * otherwise drm_gem_shmem_free will cause a warning
+	 * on debug kernels.
+	 */
+	ret = dma_set_mask(drm_dev->dev, DMA_BIT_MASK(64));
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
+	ret = dma_map_sgtable(drm_dev->dev, sgt, DMA_BIDIRECTIONAL, 0);
+	KUNIT_ASSERT_EQ(test, ret, 0);
+
 	/* Init a mock DMA-BUF */
 	buf_mock.size = TEST_SIZE;
 	attach_mock.dmabuf = &buf_mock;



