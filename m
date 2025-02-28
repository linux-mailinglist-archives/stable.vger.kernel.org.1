Return-Path: <stable+bounces-119893-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id AE9B7A491C8
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 07:52:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A253016FB02
	for <lists+stable@lfdr.de>; Fri, 28 Feb 2025 06:52:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90A211C1F12;
	Fri, 28 Feb 2025 06:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="Go0ANso7"
X-Original-To: stable@vger.kernel.org
Received: from m16.mail.163.com (m16.mail.163.com [117.135.210.3])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9760F139E
	for <stable@vger.kernel.org>; Fri, 28 Feb 2025 06:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=117.135.210.3
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740725522; cv=none; b=M2ijb+Wi4bVV6Yf5GsSPFG5HBn1w+8m51Bei5FG+VkhoNdwggWJgSgRr+wtykw+hC4DVe9c/I7uHZs6oI0U4CfdHrlMDq4pTLQy1SZMZhK29uFRIf27jubZDCn0xGg3UpjYkBpnAxt0L9phTTgKuMVX7x1YY+yMKWs0cbPr7ubA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740725522; c=relaxed/simple;
	bh=NXgI+zhxrYwUTHVWra0OQaREZ9LHkj0oAflqfrHxg/w=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=jq9PqqiDnkSsoBZ2mjBTn2A80aZA60UIg5BtyP6KFLoYdIMBWbMbR8nPkt4NRzOOAZJU+ldv7y0jGNzXw9ATSmV6elYx60kRBu//DCRS8tFhDNEf4qhuNRbap5eqxkTrE8jPvaWQNCAooHaGfihQPY/VNxxZGri9MY5c6XNw4Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=Go0ANso7; arc=none smtp.client-ip=117.135.210.3
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:Subject:Date:Message-Id:MIME-Version; bh=LUns6
	mIjyIVFAH3uU5guxjPHvQg+NzpDzWFZxLl+ACo=; b=Go0ANso7LwCyB0cninxDJ
	x+KluDCFlhFkx9rKBtdIitdIhdAqwIPv4eY07M42DOgbYDfY25bIh9TmCsAmoy+f
	9Qao3ZUtuoCm4hVHIeb0ych6S10GFD7/V0W7V0f0q3E3Xmox7UoHAMOROo/EuIzo
	BHg/mKm1RG2744l3tAgbCc=
Received: from public (unknown [])
	by gzga-smtp-mtada-g0-2 (Coremail) with SMTP id _____wD3gynVXMFn48y4PA--.48321S4;
	Fri, 28 Feb 2025 14:51:12 +0800 (CST)
From: jetlan9@163.com
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: Tuo Li <islituo@gmail.com>,
	BassCheck <bass@buaa.edu.cn>,
	Justin Tee <justin.tee@broadcom.com>,
	Laurence Oberman <loberman@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Wenshan Lan <jetlan9@163.com>
Subject: [PATCH 6.1.y] scsi: lpfc: Fix a possible data race in lpfc_unregister_fcf_rescan()
Date: Fri, 28 Feb 2025 14:50:56 +0800
Message-Id: <20250228065056.1232-1-jetlan9@163.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:_____wD3gynVXMFn48y4PA--.48321S4
X-Coremail-Antispam: 1Uf129KBjvJXoW7Cr17uF4fXr45AFyUAw45trb_yoW8Ww1UpF
	WfGa43Zr18CF429F47Cw1kJF1Y9aykJ3429FZYq3y5ua48tryxGrWxXFZ0qayvyr1IkFZx
	JF4q934UWa1xArJanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0p_lksrUUUUU=
X-CM-SenderInfo: xmhwztjqz6il2tof0z/1tbiWwv+yGe9VxZzGgABsV

From: Tuo Li <islituo@gmail.com>

[ Upstream commit 0e881c0a4b6146b7e856735226208f48251facd8 ]

The variable phba->fcf.fcf_flag is often protected by the lock
phba->hbalock() when is accessed. Here is an example in
lpfc_unregister_fcf_rescan():

  spin_lock_irq(&phba->hbalock);
  phba->fcf.fcf_flag |= FCF_INIT_DISC;
  spin_unlock_irq(&phba->hbalock);

However, in the same function, phba->fcf.fcf_flag is assigned with 0
without holding the lock, and thus can cause a data race:

  phba->fcf.fcf_flag = 0;

To fix this possible data race, a lock and unlock pair is added when
accessing the variable phba->fcf.fcf_flag.

Reported-by: BassCheck <bass@buaa.edu.cn>
Signed-off-by: Tuo Li <islituo@gmail.com>
Link: https://lore.kernel.org/r/20230630024748.1035993-1-islituo@gmail.com
Reviewed-by: Justin Tee <justin.tee@broadcom.com>
Reviewed-by: Laurence Oberman <loberman@redhat.com>
Signed-off-by: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Wenshan Lan <jetlan9@163.com>
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index d3a5f10b8b83..57be02f8d5c1 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -6942,7 +6942,9 @@ lpfc_unregister_fcf_rescan(struct lpfc_hba *phba)
 	if (rc)
 		return;
 	/* Reset HBA FCF states after successful unregister FCF */
+	spin_lock_irq(&phba->hbalock);
 	phba->fcf.fcf_flag = 0;
+	spin_unlock_irq(&phba->hbalock);
 	phba->fcf.current_rec.flag = 0;
 
 	/*
-- 
2.34.1


