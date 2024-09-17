Return-Path: <stable+bounces-76582-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 034D897AFC2
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 13:38:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9AAB41F24414
	for <lists+stable@lfdr.de>; Tue, 17 Sep 2024 11:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 993EF166F17;
	Tue, 17 Sep 2024 11:38:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from MSK-MAILEDGE.securitycode.ru (msk-mailedge.securitycode.ru [195.133.217.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED1A4291E;
	Tue, 17 Sep 2024 11:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.217.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726573123; cv=none; b=fAbUXkpANgwbzS/Y08NS0ZSNsLdKOFIYtllF8tGLtZOoZEfkXP0pKqfAalSMuCq1cQQK4TXRE6o1Mbl9PVXOrPiAIHKewo0choa1d6RV1EJySvUuibX6LjXf2LrDpXT6e095xmWp8ELXjsXSUj2B1eH7f5oUDrLqwn3de3PFKfU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726573123; c=relaxed/simple;
	bh=VHWbmrfyp7kgfmRY2M4P/MMRHq5iiSVFxjguUg3vZ24=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=dM2vcqWTa0a9TGnQdx8UuGA+8DOYSY0Vy6e+2Xb2KA3LSIQeHFvqnli5GJcFNq7rEpAvBgWiVOIGlda86oGU5cPNQ66oQD4Pr/6IAI+JFccg4hKWSdKWQhUkgRpVwQoTWNuH0DyU16D2bdOJEvz4kUHaSVkVsDOK05CoBTFHCv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru; spf=pass smtp.mailfrom=securitycode.ru; arc=none smtp.client-ip=195.133.217.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=securitycode.ru
From: George Rurikov <g.ryurikov@securitycode.ru>
To: Christoph Hellwig <hch@lst.de>
CC: George Rurikov <g.ryurikov@securitycode.ru>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] nvmet: Remove unnecessary check in nvmet_sq_destroy()
Date: Tue, 17 Sep 2024 14:35:35 +0300
Message-ID: <20240917113535.1916516-1-g.ryurikov@securitycode.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-ClientProxiedBy: SPB-EX2.Securitycode.ru (172.16.24.92) To
 MSK-EX2.Securitycode.ru (172.17.8.92)

This fix is mostly cosmetic.

Since =E2=80=9Cctrl->sqs=E2=80=9D is initialized in the same place as =E2=
=80=9Cctrl=E2=80=9D
(nvmet_alloc_ctrl), in my opinion checking =E2=80=9Cctrl->sqs=E2=80=9D for =
0 in line
814 is redundant.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Cc: stable@vger.kernel.org
Fixes: 64f5e9cdd711 ("nvmet: fix memory leak when removing namespaces and c=
ontrollers concurrently")
Signed-off-by: George Rurikov <g.ryurikov@securitycode.ru>
---
 drivers/nvme/target/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index ed2424f8a396..d1b287310265 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -811,7 +811,7 @@ void nvmet_sq_destroy(struct nvmet_sq *sq)
         * If this is the admin queue, complete all AERs so that our
         * queue doesn't have outstanding requests on it.
         */
-       if (ctrl && ctrl->sqs && ctrl->sqs[0] =3D=3D sq)
+       if (ctrl && ctrl->sqs[0] =3D=3D sq)
                nvmet_async_events_failall(ctrl);
        percpu_ref_kill_and_confirm(&sq->ref, nvmet_confirm_sq);
        wait_for_completion(&sq->confirm_done);
--
2.34.1

=D0=97=D0=B0=D1=8F=D0=B2=D0=BB=D0=B5=D0=BD=D0=B8=D0=B5 =D0=BE =D0=BA=D0=BE=
=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D0=
=BE=D1=81=D1=82=D0=B8

=D0=94=D0=B0=D0=BD=D0=BD=D0=BE=D0=B5 =D1=8D=D0=BB=D0=B5=D0=BA=D1=82=D1=80=
=D0=BE=D0=BD=D0=BD=D0=BE=D0=B5 =D0=BF=D0=B8=D1=81=D1=8C=D0=BC=D0=BE =D0=B8 =
=D0=BB=D1=8E=D0=B1=D1=8B=D0=B5 =D0=BF=D1=80=D0=B8=D0=BB=D0=BE=D0=B6=D0=B5=
=D0=BD=D0=B8=D1=8F =D0=BA =D0=BD=D0=B5=D0=BC=D1=83 =D1=8F=D0=B2=D0=BB=D1=8F=
=D1=8E=D1=82=D1=81=D1=8F =D0=BA=D0=BE=D0=BD=D1=84=D0=B8=D0=B4=D0=B5=D0=BD=
=D1=86=D0=B8=D0=B0=D0=BB=D1=8C=D0=BD=D1=8B=D0=BC=D0=B8 =D0=B8 =D0=BF=D1=80=
=D0=B5=D0=B4=D0=BD=D0=B0=D0=B7=D0=BD=D0=B0=D1=87=D0=B5=D0=BD=D1=8B =D0=B8=
=D1=81=D0=BA=D0=BB=D1=8E=D1=87=D0=B8=D1=82=D0=B5=D0=BB=D1=8C=D0=BD=D0=BE =
=D0=B4=D0=BB=D1=8F =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=B0. =D0=95=
=D1=81=D0=BB=D0=B8 =D0=92=D1=8B =D0=BD=D0=B5 =D1=8F=D0=B2=D0=BB=D1=8F=D0=B5=
=D1=82=D0=B5=D1=81=D1=8C =D0=B0=D0=B4=D1=80=D0=B5=D1=81=D0=B0=D1=82=D0=BE=
=D0=BC =D0=B4=D0=B0=D0=BD=D0=BD=D0=BE=D0=B3=D0=BE =D0=BF=D0=B8=D1=81=D1=8C=
=D0=BC=D0=B0, =D0=BF=D0=BE=D0=B6=D0=B0=D0=BB=D1=83=D0=B9=D1=81=D1=82=D0=B0,=
 =D1=83=D0=B2=D0=B5=D0=B4=D0=BE=D0=BC=D0=B8=D1=82=D0=B5 =D0=BD=D0=B5=D0=BC=
=D0=B5=D0=B4=D0=BB=D0=B5=D0=BD=D0=BD=D0=BE =D0=BE=D1=82=D0=BF=D1=80=D0=B0=
=D0=B2=D0=B8=D1=82=D0=B5=D0=BB=D1=8F, =D0=BD=D0=B5 =D1=80=D0=B0=D1=81=D0=BA=
=D1=80=D1=8B=D0=B2=D0=B0=D0=B9=D1=82=D0=B5 =D1=81=D0=BE=D0=B4=D0=B5=D1=80=
=D0=B6=D0=B0=D0=BD=D0=B8=D0=B5 =D0=B4=D1=80=D1=83=D0=B3=D0=B8=D0=BC =D0=BB=
=D0=B8=D1=86=D0=B0=D0=BC, =D0=BD=D0=B5 =D0=B8=D1=81=D0=BF=D0=BE=D0=BB=D1=8C=
=D0=B7=D1=83=D0=B9=D1=82=D0=B5 =D0=B5=D0=B3=D0=BE =D0=B2 =D0=BA=D0=B0=D0=BA=
=D0=B8=D1=85-=D0=BB=D0=B8=D0=B1=D0=BE =D1=86=D0=B5=D0=BB=D1=8F=D1=85, =D0=
=BD=D0=B5 =D1=85=D1=80=D0=B0=D0=BD=D0=B8=D1=82=D0=B5 =D0=B8 =D0=BD=D0=B5 =
=D0=BA=D0=BE=D0=BF=D0=B8=D1=80=D1=83=D0=B9=D1=82=D0=B5 =D0=B8=D0=BD=D1=84=
=D0=BE=D1=80=D0=BC=D0=B0=D1=86=D0=B8=D1=8E =D0=BB=D1=8E=D0=B1=D1=8B=D0=BC =
=D1=81=D0=BF=D0=BE=D1=81=D0=BE=D0=B1=D0=BE=D0=BC.

