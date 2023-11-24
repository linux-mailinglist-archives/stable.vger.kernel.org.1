Return-Path: <stable+bounces-647-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6159A7F7BF6
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 19:10:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92C4B1C210C7
	for <lists+stable@lfdr.de>; Fri, 24 Nov 2023 18:10:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDDC339FFC;
	Fri, 24 Nov 2023 18:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rt5c/jR0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8718639FE3;
	Fri, 24 Nov 2023 18:10:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10F23C433C8;
	Fri, 24 Nov 2023 18:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1700849424;
	bh=5boYX/uAT/YdCTa71jQYR1cIbKMBTMEszDxq4/q9TuI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rt5c/jR0RtUmtkD/bxLVOAoRzg7G9k9CyO7iRzgZM5Gidy3wNcSjvpeLWogQuu28d
	 ponQgDI+VFJC5Q8gK3KzF4gp5bTmBnyxtyD2DZagjdoNp6pa4p7KcvIUkGf/CMsY2i
	 +72dIuIxEjAOcyaxz5T7YZclPp5t8xTyhgiSaVeY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Qing Wang <qinwang@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 176/530] vdpa_sim_blk: allocate the buffer zeroed
Date: Fri, 24 Nov 2023 17:45:42 +0000
Message-ID: <20231124172033.434790247@linuxfoundation.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231124172028.107505484@linuxfoundation.org>
References: <20231124172028.107505484@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefano Garzarella <sgarzare@redhat.com>

[ Upstream commit 0d82410252ea324f0064e75b9865bb74cccc1dda ]

Deleting and recreating a device can lead to having the same
content as the old device, so let's always allocate buffers
completely zeroed out.

Fixes: abebb16254b3 ("vdpa_sim_blk: support shared backend")
Suggested-by: Qing Wang <qinwang@redhat.com>
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
Message-Id: <20231031144339.121453-1-sgarzare@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Eugenio Pérez <eperezma@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
index b3a3cb1657955..b137f36793439 100644
--- a/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
+++ b/drivers/vdpa/vdpa_sim/vdpa_sim_blk.c
@@ -437,7 +437,7 @@ static int vdpasim_blk_dev_add(struct vdpa_mgmt_dev *mdev, const char *name,
 	if (blk->shared_backend) {
 		blk->buffer = shared_buffer;
 	} else {
-		blk->buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+		blk->buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
 				       GFP_KERNEL);
 		if (!blk->buffer) {
 			ret = -ENOMEM;
@@ -495,7 +495,7 @@ static int __init vdpasim_blk_init(void)
 		goto parent_err;
 
 	if (shared_backend) {
-		shared_buffer = kvmalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
+		shared_buffer = kvzalloc(VDPASIM_BLK_CAPACITY << SECTOR_SHIFT,
 					 GFP_KERNEL);
 		if (!shared_buffer) {
 			ret = -ENOMEM;
-- 
2.42.0




