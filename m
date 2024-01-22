Return-Path: <stable+bounces-12709-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1CF4836FB4
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 19:22:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 68FDDB2CE58
	for <lists+stable@lfdr.de>; Mon, 22 Jan 2024 17:57:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBF0A50A84;
	Mon, 22 Jan 2024 17:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hnCXtn/l"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FAE75FDC3
	for <stable@vger.kernel.org>; Mon, 22 Jan 2024 17:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705944094; cv=none; b=uxIlSkZvb/9H2DZp3KU4xmJvXKTuKTazVejO206c/pQoVL5Jb0DI5ryWUkdNsj2u/C9h3gA8XPG03T9kyp+NpWljDomBTu6BdWAhnMra2iZ4GsItoipDX7tftMHzuLjuKQPx6dVaQ4rr+EXgRhV1uXjrLz7tF5zYsS/Aos/txLQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705944094; c=relaxed/simple;
	bh=AKfsnPJjBxMQwg0RWLJL1I3S8Xk9KtI5BLW9GcXdXJo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qfFadBx2+Y/RUrDhhUxB1DjiAUbvZYV5DHlMk9QtflQINkdw17H4jFG5TzA3gCPFUZETMZxYZpDPJ7N7+MmZkZemGmnpTRCXwE3S8blwCJrZG435/+2muFfWEmbX4frZWKhV/SmByMdmz6R/KC5PdzOZgM43Ai6PGWq3p9fLgJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hnCXtn/l; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1705944091;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=YRefZ/wsrn6xc/POzLXdqCo2wo2k5mzHvh76/txm/d0=;
	b=hnCXtn/lKNfpsO4DLtpVB6nu04g8lTlTinw7hvO0AvZe56sFPZeOdnfWh53ysfCU2Qv/AU
	I/cTYIYH7kj2jHosYUYbg5xo9YzGY/UcCLH4rLu/sKyq4HPy060sElqHRZBiFym5FmZkRE
	MHWNLzg3EQPCnbvV1t4LxXy2RsRPQK8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-630-HDr-DmkRM0ymMmHIgC6W3g-1; Mon, 22 Jan 2024 12:21:27 -0500
X-MC-Unique: HDr-DmkRM0ymMmHIgC6W3g-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4E397185A783;
	Mon, 22 Jan 2024 17:21:26 +0000 (UTC)
Received: from hydra.redhat.com (unknown [10.39.194.5])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 8DE8840C1430;
	Mon, 22 Jan 2024 17:21:25 +0000 (UTC)
From: Jocelyn Falempe <jfalempe@redhat.com>
To: zack.rusin@broadcom.com,
	stable@vger.kernel.org,
	dri-devel@lists.freedesktop.org
Cc: Jocelyn Falempe <jfalempe@redhat.com>
Subject: [PATCH 0/2] drm/vmwgfx backport two fixes to v6.1.x branch
Date: Mon, 22 Jan 2024 18:10:11 +0100
Message-ID: <20240122172031.243604-1-jfalempe@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

Hi,

I've backported this two commits:
f9e96bf19054 drm/vmwgfx: Fix possible invalid drm gem put calls
91398b413d03 drm/vmwgfx: Keep a gem reference to user bos in surfaces

They both fixes a950b989ea29 ("drm/vmwgfx: Do not drop the reference
to the handle too soon")
which has been backported to v6.1.x branch as 0a127ac97240

There was a lot of conflicts, and as I'm not familiar with the vmwgfx
driver, it's better to review and test them.
I've run a short test, and it worked, but that's certainly not enough.

Thanks,

Zack Rusin (2):
  drm/vmwgfx: Fix possible invalid drm gem put calls
  drm/vmwgfx: Keep a gem reference to user bos in surfaces

 drivers/gpu/drm/vmwgfx/vmwgfx_bo.c       |  7 ++----
 drivers/gpu/drm/vmwgfx/vmwgfx_cotable.c  |  8 +++----
 drivers/gpu/drm/vmwgfx/vmwgfx_drv.h      | 20 ++++++++++++++++++
 drivers/gpu/drm/vmwgfx/vmwgfx_execbuf.c  | 12 +++++------
 drivers/gpu/drm/vmwgfx/vmwgfx_gem.c      | 24 ++++++++++++++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_kms.c      | 10 ++++-----
 drivers/gpu/drm/vmwgfx/vmwgfx_overlay.c  |  3 +--
 drivers/gpu/drm/vmwgfx/vmwgfx_resource.c | 18 ++++++++--------
 drivers/gpu/drm/vmwgfx/vmwgfx_shader.c   |  5 ++---
 drivers/gpu/drm/vmwgfx/vmwgfx_surface.c  | 27 +++++++-----------------
 10 files changed, 75 insertions(+), 59 deletions(-)


base-commit: fec3b1451d5febbc9e04250f879c10f8952e6bed
-- 
2.43.0


