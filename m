Return-Path: <stable+bounces-189035-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FF64BFE1AC
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 21:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D487F3A831D
	for <lists+stable@lfdr.de>; Wed, 22 Oct 2025 19:55:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838342F6182;
	Wed, 22 Oct 2025 19:55:01 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BD702F5305
	for <stable@vger.kernel.org>; Wed, 22 Oct 2025 19:54:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761162901; cv=none; b=VzVFWevS8LzZpU38ljvQ6cTUB359Ktma9zf+5XVDf/kGM0XymaoQrV0aQsaEPCDTqpqK8qFrIa8ehKHorAQVvpfa6g8bs4IwgEfjGhbGNYVojtrvX8UaGKMcduWuQOc0F2gty6x7DmdU0712tKVYSUXItLMFAAwqMH93lTKdazY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761162901; c=relaxed/simple;
	bh=3Ds822EHz+9AU8N6Is8scT7XZVuUqx6dEYTxT4hmM4w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=sTVJmxTQsEgzaBRCrpx5k7nFjJKF/kB5wRxyEE27ZJ7JOwsj+V+e6q3rOeAq5KeH0Y6CvfpgIDfM4RnAT0MOtJGDYL9Ar6yRFnoIWJIW9LVXcdZUCS3wPxtRd+Vws3C+WBURv8CMtrB2M65dvoMw7nnD2was4hDMLlv2U/lVBxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from altlinux.ipa.basealt.ru (unknown [178.76.204.78])
	(Authenticated sender: kovalevvv)
	by air.basealt.ru (Postfix) with ESMTPSA id 90C6323373;
	Wed, 22 Oct 2025 22:54:54 +0300 (MSK)
From: Vasiliy Kovalev <kovalev@altlinux.org>
To: stable@vger.kernel.org
Cc: Shannon Nelson <snelson@pensando.io>,
	Pensando Drivers <drivers@pensando.io>,
	"David S. Miller" <davem@davemloft.net>,
	lvc-project@linuxtesting.org,
	kovalev@altlinux.org
Subject: [PATCH 5.10.y] ionic: catch failure from devlink_alloc
Date: Wed, 22 Oct 2025 22:54:52 +0300
Message-Id: <20251022195452.213553-1-kovalev@altlinux.org>
X-Mailer: git-send-email 2.33.8
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Shannon Nelson <shannon.nelson@amd.com>

commit 4a54903ff68ddb33b6463c94b4eb37fc584ef760 upstream.

Add a check for NULL on the alloc return.  If devlink_alloc() fails and
we try to use devlink_priv() on the NULL return, the kernel gets very
unhappy and panics. With this fix, the driver load will still fail,
but at least it won't panic the kernel.

Fixes: df69ba43217d ("ionic: Add basic framework for IONIC Network device driver")
Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Reviewed-by: Simon Horman <simon.horman@corigine.com>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
[ kovalev: bp to fix CVE-2023-53470 ]
Signed-off-by: Vasiliy Kovalev <kovalev@altlinux.org>
---
 drivers/net/ethernet/pensando/ionic/ionic_devlink.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
index 3d94064c685d..52ebecf2521e 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_devlink.c
@@ -65,6 +65,8 @@ struct ionic *ionic_devlink_alloc(struct device *dev)
 	struct devlink *dl;
 
 	dl = devlink_alloc(&ionic_dl_ops, sizeof(struct ionic));
+	if (!dl)
+		return NULL;
 
 	return devlink_priv(dl);
 }
-- 
2.50.1


