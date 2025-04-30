Return-Path: <stable+bounces-139247-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D418AA57D8
	for <lists+stable@lfdr.de>; Thu,  1 May 2025 00:06:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2BBE33B511F
	for <lists+stable@lfdr.de>; Wed, 30 Apr 2025 22:05:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4819122425E;
	Wed, 30 Apr 2025 22:06:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b="iImSj47e"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0FCD221729;
	Wed, 30 Apr 2025 22:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746050764; cv=none; b=RkNYwKwbFsVg2zEfS+eQ3L61EPJ4FxKe02lgnfFCZOkcqqUvlpzuJznn3FpFyAyAYOJEKNjvIM2dxIBgR2Th2VoIz+QA1+ymQr2k1CuawwduRlJnDqDpjXZ9eLopjZkxw7uuPaNG+quQxmkJwTlG9EjX7NozeMDZj3nfX0YkRX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746050764; c=relaxed/simple;
	bh=5fuitnncfD5tDUPddDF+UDVEs5aeUDwBqWLUYZxf27Y=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=I5QqKK5H1dBAj3wAUhdQJLw3d7yu/4wB980ENk1GyjBvlEddWRNYSs7b0BEYWqVGfGbAbNIo06/N4VqyxZiv5cXe5Wr+SeD3weOL3Sgfqarf4tKAoATB6j1rFTFzd8QbB9QCxfFXAtbVEOs5BfdFgj+DRNN8/oTfdvb25E6tTKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linuxonhyperv.com header.i=@linuxonhyperv.com header.b=iImSj47e; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linuxonhyperv.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1202)
	id 86A98204E7FE; Wed, 30 Apr 2025 15:06:02 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 86A98204E7FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxonhyperv.com;
	s=default; t=1746050762;
	bh=cEirtZm/SmFjzm0Vy14RfmaUhYtp12qkUzkZo1lRLGU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iImSj47e07xsBznoeQZejw+4P9PkzBztTIYHqH5HzOisxe8kF32Im5Zu5RPLNfmAe
	 N3xgl/l7sXhWbrUKmJxwd4csshn+X7AMecSc+A8liwJXMf2Ye83MdsnEUwPFfU529I
	 7fJr1M+maMSvsMIPJx9QQdclIWboWJXu0CHDwZkk=
From: longli@linuxonhyperv.com
To: "K. Y. Srinivasan" <kys@microsoft.com>,
	Haiyang Zhang <haiyangz@microsoft.com>,
	Wei Liu <wei.liu@kernel.org>,
	Dexuan Cui <decui@microsoft.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-hyperv@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Long Li <longli@microsoft.com>,
	stable@vger.kernel.org
Subject: [Patch v2 3/4] uio_hv_generic: Adjust ring size according to system page alignment
Date: Wed, 30 Apr 2025 15:05:57 -0700
Message-Id: <1746050758-6829-4-git-send-email-longli@linuxonhyperv.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
References: <1746050758-6829-1-git-send-email-longli@linuxonhyperv.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

From: Long Li <longli@microsoft.com>

Following the ring header, the ring data should align to system page
boundary. Adjust the size if necessary.

Cc: stable@vger.kernel.org
Fixes: 95096f2fbd10 ("uio-hv-generic: new userspace i/o driver for VMBus")
Signed-off-by: Long Li <longli@microsoft.com>
---
 drivers/uio/uio_hv_generic.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/uio/uio_hv_generic.c b/drivers/uio/uio_hv_generic.c
index 08385b04c4ab..dfc5f0e1a254 100644
--- a/drivers/uio/uio_hv_generic.c
+++ b/drivers/uio/uio_hv_generic.c
@@ -256,6 +256,12 @@ hv_uio_probe(struct hv_device *dev,
 	if (!ring_size)
 		ring_size = SZ_2M;
 
+	/*
+	 * Adjust ring size if necessary to have the ring data region page
+	 * aligned
+	 */
+	ring_size = VMBUS_RING_SIZE(ring_size);
+
 	pdata = devm_kzalloc(&dev->device, sizeof(*pdata), GFP_KERNEL);
 	if (!pdata)
 		return -ENOMEM;
-- 
2.34.1


