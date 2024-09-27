Return-Path: <stable+bounces-78138-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 80F22988944
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 18:43:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B0B601C22833
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 16:43:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E0171C0DF2;
	Fri, 27 Sep 2024 16:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JRZ9DqSo"
X-Original-To: stable@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD4A313CA81
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 16:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727455387; cv=none; b=jmAxXYHycQqTxBYB+BwxhbpM1LtEX4ZFeczU2YclvkELj40+/QORm3tLa9yR3niQegR4w85ohFzbyJyUeQdChvdidf4C/I3fg0sPe6+bD2RF+8J5xDMNRcRnN1z7EoZ7UN5bt7u28V+7zf/WnxQymnfBwkjRYAXU3BY9pgRIUwo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727455387; c=relaxed/simple;
	bh=ADHrCAE6OWSegFHquCJAMeCUACQHblelbtnsnAaXPyg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=tXRQVK4syuFIY/6gHckRiIiiGjQhf5+X38m/PeyRj7kDuFpMSW/+hl0Ew84dSfLNIrhAPcScTb73ThzFhZ14l6TRx4og8aakl++vwpg/q+kBB5GbCEhwEtUOGmUrmmYKOEZ9y5T6Gw5MivPqsbsmYaGLi9rlZM+Ra/wZP2OrqQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=JRZ9DqSo; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ovt.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-e0b8fa94718so3675588276.0
        for <stable@vger.kernel.org>; Fri, 27 Sep 2024 09:43:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1727455385; x=1728060185; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QOR5ZpTmC0OSb0+XgqcR51ucZLnEzNhNNP+u4C5IGdQ=;
        b=JRZ9DqSoTYE3gf7gEzCV30VSaH+IKY7j5BRY+a7dyT1bYBF2MmQeZ4+V1tj627622F
         9kibA1iHvzZ0qfzCMuhS08xV+XU/Mk+VWHINqjoYuhapjPghtVp3Ei7Ek5PzxQkgFZSp
         lpc7LDYqYwkU/DtAeDfcIAsvnStnF+Tuve6VX+y2DJphk+xXzPwo+5iBP0vjwkeWJK4A
         Pn524d2iKqJng580+eZgiQCmM0pYiK+qA0Wo+mFn2oEphoZ7P/zeTUvii+CeNRcQ8APH
         CDfBzt2ss7/Q4WnnomtgKBUDM6tp0JbEOlvVWR9TZ1HRMXZyqIytn8MvDpLTWzMlE6O7
         5OgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727455385; x=1728060185;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QOR5ZpTmC0OSb0+XgqcR51ucZLnEzNhNNP+u4C5IGdQ=;
        b=TlZRrgxKWfOHsiYjFi8QEkdji8fxAx9bbFUYB/7bAqID7OUs0htXY7HT8Av1L43eWd
         ZTyu4jmbE4oiWZ2/nLZgGWv64Lh/ZGN3VmPKaBIMbzWYV8K4K6pFEzsgTBK3DIJUdsRZ
         YVR1p+nq3V20G0lqQJMwf+IMbgJslA2YvAf5ezdSeVVgUQif0BjGohz2apLPAhfTDRZu
         7AOQ5rytbamrLJTFZzeFV8sGrsQ7O+P/+MeXhvHw7fjz/JhWflcI1Ji3/JEYuWjKTkh+
         eC0qWHvh+4/O2knjdkNwm2evP6Krmko8M+ZzHKY9EsnR9i8/2CkHD/HML8bZSCILeaz1
         KIJg==
X-Gm-Message-State: AOJu0YxM31DynmMvc+PLg2GGQtjNJZDyAHGbW6N8rikui/aFsM6RhXGe
	4jg/cqzOMyCWDoZldjb8HjVrTUbvTc8cB+nFiWv9wTkXLiCjUC2ygzdknI52d6UgMMtySibzaF8
	6vmie7N4eFl82NeYdRU8HpvC9179BsElp6Ks/hqOJIlnRonnC3wcomPm3Lrs2sC4HrcGjeX3/oW
	iFi+ODEWAOdE9iqUqp
X-Google-Smtp-Source: AGHT+IFSxKQbfEn73QfIlO7O0kNitQ09aifpoVvVNKDvvAc2Kv/nnXZYDl2E2WxLKnhfNhfUkBYTRPI=
X-Received: from hmarynka.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:1148])
 (user=ovt job=sendgmr) by 2002:a25:a527:0:b0:e25:d596:484c with SMTP id
 3f1490d57ef6-e2604b10984mr13587276.2.1727455384352; Fri, 27 Sep 2024 09:43:04
 -0700 (PDT)
Date: Fri, 27 Sep 2024 16:42:54 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.1.824.gd892dcdcdd-goog
Message-ID: <20240927164254.1270856-1-ovt@google.com>
Subject: [PATCH 6.1.y] vfio/pci: fix potential memory leak in vfio_intx_enable()
From: Oleksandr Tymoshenko <ovt@google.com>
To: stable@vger.kernel.org
Cc: Ye Bin <yebin10@huawei.com>, Kevin Tian <kevin.tian@intel.com>, 
	Reinette Chatre <reinette.chatre@intel.com>, Alex Williamson <alex.williamson@redhat.com>, 
	Sasha Levin <sashal@kernel.org>, Oleksandr Tymoshenko <ovt@google.com>
Content-Type: text/plain; charset="UTF-8"

From: Ye Bin <yebin10@huawei.com>

[ Upstream commit 82b951e6fbd31d85ae7f4feb5f00ddd4c5d256e2 ]

If kzalloc() failed will lead to 'name' memory leak.

Fixes: 18c198c96a81 ("vfio/pci: Create persistent INTx handler")
Signed-off-by: Ye Bin <yebin10@huawei.com>
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Acked-by: Reinette Chatre <reinette.chatre@intel.com>
Link: https://lore.kernel.org/r/20240415015029.3699844-1-yebin10@huawei.com
Signed-off-by: Alex Williamson <alex.williamson@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Oleksandr Tymoshenko <ovt@google.com>
---
 drivers/vfio/pci/vfio_pci_intrs.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vfio/pci/vfio_pci_intrs.c b/drivers/vfio/pci/vfio_pci_intrs.c
index 03246a59b553..5cbcde32ff79 100644
--- a/drivers/vfio/pci/vfio_pci_intrs.c
+++ b/drivers/vfio/pci/vfio_pci_intrs.c
@@ -215,8 +215,10 @@ static int vfio_intx_enable(struct vfio_pci_core_device *vdev,
 		return -ENOMEM;
 
 	vdev->ctx = kzalloc(sizeof(struct vfio_pci_irq_ctx), GFP_KERNEL_ACCOUNT);
-	if (!vdev->ctx)
+	if (!vdev->ctx) {
+		kfree(name);
 		return -ENOMEM;
+	}
 
 	vdev->num_ctx = 1;
 
-- 
2.46.1.824.gd892dcdcdd-goog


