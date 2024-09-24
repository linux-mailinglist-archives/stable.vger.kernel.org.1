Return-Path: <stable+bounces-76987-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 41704984525
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 13:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BCB32B20ED1
	for <lists+stable@lfdr.de>; Tue, 24 Sep 2024 11:50:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFC012BF25;
	Tue, 24 Sep 2024 11:50:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from MSK-MAILEDGE.securitycode.ru (msk-mailedge.securitycode.ru [195.133.217.143])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2D1912A14C;
	Tue, 24 Sep 2024 11:50:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.133.217.143
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727178619; cv=none; b=VEmuZpri0oqj3BjNXrTqWaqi+FF7Z5w0dfqqzxduZ9wzg1RSMfT3smINJJc25Buim2o7MxLiUXIEwsC0BXFMrrqFlvhZiI6xROj7cI16Bje5Dvw68H2xKNZw/8Gx5gPam7i9TB0hIRobRgiNgyKO+oB6DxqNxSu+13RszkM3OFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727178619; c=relaxed/simple;
	bh=m9gcGOwO2HgNBdo2N/ChjcvYpjqTaGiYsQEoY3muEZs=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ts+SXqNNlUwHSZKdq0dsNSG8P6mZ8FqWyHCje9FIixs3KQKZxwDrntkxoyBxGvS/2eWPdKNYF39I2VpxYCITujFtSmU9T6Q1qGrRMXBAYoHblax3DQU1LV+MDwJwgdqvy7nq0ofMla4Z63LqpCw1NF0fYZu6F3KyDtJaBimonnM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru; spf=pass smtp.mailfrom=securitycode.ru; arc=none smtp.client-ip=195.133.217.143
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=securitycode.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=securitycode.ru
From: George Rurikov <g.ryurikov@securitycode.ru>
To: Christoph Hellwig <hch@lst.de>
CC: George Rurikov <g.ryurikov@securitycode.ru>, Sagi Grimberg
	<sagi@grimberg.me>, Chaitanya Kulkarni <kch@nvidia.com>, Keith Busch
	<kbusch@kernel.org>, Israel Rukshin <israelr@mellanox.com>, Max Gurtovoy
	<maxg@mellanox.com>, Jens Axboe <axboe@kernel.dk>,
	<linux-nvme@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>
Subject: [PATCH] nvme: rdma: Add check for queue in nvmet_rdma_cm_handler()
Date: Tue, 24 Sep 2024 14:49:46 +0300
Message-ID: <20240924114946.1090615-1-g.ryurikov@securitycode.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-ClientProxiedBy: MSK-EX1.Securitycode.ru (172.17.8.91) To
 MSK-EX2.Securitycode.ru (172.17.8.92)

After having been assigned to a NULL value at rdma.c:1758, pointer 'queue'
is passed as 1st parameter in call to function
'nvmet_rdma_queue_established' at rdma.c:1773, as 1st parameter in call
to function 'nvmet_rdma_queue_disconnect' at rdma.c:1787 and as 2nd
parameter in call to function 'nvmet_rdma_queue_connect_fail' at
rdma.c:1800, where it is dereferenced.

I understand, that driver is confident that the
RDMA_CM_EVENT_CONNECT_REQUEST event will occur first and perform
initialization, but maliciously prepared hardware could send events in
violation of the protocol. Nothing guarantees that the sequence of events
will start with RDMA_CM_EVENT_CONNECT_REQUEST.

Found by Linux Verification Center (linuxtesting.org) with SVACE

Fixes: e1a2ee249b19 ("nvmet-rdma: Fix use after free in nvmet_rdma_cm_handl=
er()")
Cc: stable@vger.kernel.org
Signed-off-by: George Rurikov <g.ryurikov@securitycode.ru>
---
 drivers/nvme/target/rdma.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1b6264fa5803..becebc95f349 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1770,8 +1770,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *=
cm_id,
                ret =3D nvmet_rdma_queue_connect(cm_id, event);
                break;
        case RDMA_CM_EVENT_ESTABLISHED:
-               nvmet_rdma_queue_established(queue);
-               break;
+               if (!queue) {
+                       nvmet_rdma_queue_established(queue);
+                       break;
+               }
        case RDMA_CM_EVENT_ADDR_CHANGE:
                if (!queue) {
                        struct nvmet_rdma_port *port =3D cm_id->context;
@@ -1782,8 +1784,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *=
cm_id,
                fallthrough;
        case RDMA_CM_EVENT_DISCONNECTED:
        case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-               nvmet_rdma_queue_disconnect(queue);
-               break;
+               if (!queue) {
+                       nvmet_rdma_queue_disconnect(queue);
+                       break;
+               }
        case RDMA_CM_EVENT_DEVICE_REMOVAL:
                ret =3D nvmet_rdma_device_removal(cm_id, queue);
                break;
@@ -1793,8 +1797,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *=
cm_id,
                fallthrough;
        case RDMA_CM_EVENT_UNREACHABLE:
        case RDMA_CM_EVENT_CONNECT_ERROR:
-               nvmet_rdma_queue_connect_fail(cm_id, queue);
-               break;
+               if (!queue) {
+                       nvmet_rdma_queue_connect_fail(cm_id, queue);
+                       break;
+               }
        default:
                pr_err("received unrecognized RDMA CM event %d\n",
                        event->event);
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

