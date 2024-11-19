Return-Path: <stable+bounces-93893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 62AE59D1EA8
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 04:07:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 119AA1F22752
	for <lists+stable@lfdr.de>; Tue, 19 Nov 2024 03:07:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5750C13775E;
	Tue, 19 Nov 2024 03:07:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L2WnvmSW"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EE581494B0
	for <stable@vger.kernel.org>; Tue, 19 Nov 2024 03:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731985626; cv=none; b=F73y3LRgeocZXwMvI3pB2LSkzkaRr4CrUHPm/+1qduuzQDbIUWmhG4//Xdvt5ceTbqobv0ZJNyBGpl2rTbnhbm9thsuMhVyK3N2jf6QnICAMnJvtd27rwW3lNXZ6kp0b6zxa4ZriciIS+RLeaHa0f8TertBT9M93NQvsHqDPw0E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731985626; c=relaxed/simple;
	bh=vWMIQDSzA5s6UjZUHrBv3leu6BUEJt8y1EL5peF7Xlw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L+FLp/J4XDxx4dh/fY5FaExdmlebzeqA+EMSmoIuBc33XW2WpqU1AQa1THD6YuWz9T4tvheX0Qq6SW7ifZ3c+1ERhBZY7GXw30G/cxDqqAEiLVUo/ezJmmqI3B2fQ41skSlb/ITwBxLpwpTKrkJ63dTOckKC7IFg6HuiHyMYkDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L2WnvmSW; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731985623;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=u3zjitKmLTy2QyhtDhzL0k3n7osN8xJda+GTFhWt4Us=;
	b=L2WnvmSWgCIg4Yt2FCHCBuyVZOAmka4Hp+OUXNT+WuyknH407AxDfNsDgrmmkoFMTtqy0z
	F2xsX01gG+gAdnyJP//gnh+Ja/onuYLhvSUtNLGdsazt8g/EDuiHeQnBL5Ju9LcNDrrYpe
	99+o9/CpmuunNnsxQQGJ8wXiCSf4aX0=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-511-oWJo-CqCN76j7tkjAXBzxg-1; Mon,
 18 Nov 2024 22:07:00 -0500
X-MC-Unique: oWJo-CqCN76j7tkjAXBzxg-1
X-Mimecast-MFC-AGG-ID: oWJo-CqCN76j7tkjAXBzxg
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 54FA919560B4;
	Tue, 19 Nov 2024 03:06:59 +0000 (UTC)
Received: from localhost (unknown [10.72.116.35])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0998E1956054;
	Tue, 19 Nov 2024 03:06:57 +0000 (UTC)
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Ming Lei <ming.lei@redhat.com>,
	stable@vger.kernel.org
Subject: [PATCH] ublk: fix error code for unsupported command
Date: Tue, 19 Nov 2024 11:06:46 +0800
Message-ID: <20241119030646.2319030-1-ming.lei@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

ENOTSUPP is for kernel use only, and shouldn't be sent to userspace.

Fix it by replacing it with EOPNOTSUPP.

Cc: stable@vger.kernel.org
Fixes: bfbcef036396 ("ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/ublk_drv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index c6d18cd8af44..d4aed12dd436 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -3041,7 +3041,7 @@ static int ublk_ctrl_uring_cmd(struct io_uring_cmd *cmd,
 		ret = ublk_ctrl_end_recovery(ub, cmd);
 		break;
 	default:
-		ret = -ENOTSUPP;
+		ret = -EOPNOTSUPP;
 		break;
 	}
 
-- 
2.44.0


