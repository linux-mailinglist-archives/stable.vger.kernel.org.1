Return-Path: <stable+bounces-5380-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DA17280CB8C
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:53:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 165441C20B7E
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:53:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AD74778A;
	Mon, 11 Dec 2023 13:53:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="p0SJguA2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03A7347773;
	Mon, 11 Dec 2023 13:53:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0574CC433C8;
	Mon, 11 Dec 2023 13:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302784;
	bh=Z11gVKak3AudfsY9eiwwmKrfy2eHNlv6I4ERRcbZX1c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=p0SJguA23bx5x8W174Ga9krfTIu7x60FkA/P5aNeUdsbkTZIwvCiCBnHbonHUiOCK
	 Hms2VD1eHQCoiOzWaAJIkTSaWtJ1nw++uVqF2csLDivgahxHcfG5DmAU2HYvNdvINa
	 vre/sQ2OTyZKPI6AO+ghnV9BkpIzYOfsRMK/Zo/02CyJiOnJlbWPGr3AZQamH4RsXJ
	 k4wTwkzobBzY3kgh1r9HLAGbXCYkzb07O4z8eZTsBWnPbeB9d4qeugXOb8vNmBivhG
	 BCCGs7vGf4QPWqbG5CFCJqbCM1YQ9bl/nnqYLJsw3Yw1rkB2TAYWXmzXB3620bd/7c
	 jvX/O/FDkRtZQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	allen.hubbe@amd.com,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 25/47] pds_vdpa: clear config callback when status goes to 0
Date: Mon, 11 Dec 2023 08:50:26 -0500
Message-ID: <20231211135147.380223-25-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231211135147.380223-1-sashal@kernel.org>
References: <20231211135147.380223-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.5
Content-Transfer-Encoding: 8bit

From: Shannon Nelson <shannon.nelson@amd.com>

[ Upstream commit dd3b8de16e90c5594eddd29aeeb99e97c6f863be ]

If the client driver is setting status to 0, something is
getting shutdown and possibly removed.  Make sure we clear
the config_cb so that it doesn't end up crashing when
trying to call a bogus callback.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Message-Id: <20231110221802.46841-3-shannon.nelson@amd.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/pds/vdpa_dev.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 52b2449182ad7..9fc89c82d1f01 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -461,8 +461,10 @@ static void pds_vdpa_set_status(struct vdpa_device *vdpa_dev, u8 status)
 
 	pds_vdpa_cmd_set_status(pdsv, status);
 
-	/* Note: still working with FW on the need for this reset cmd */
 	if (status == 0) {
+		struct vdpa_callback null_cb = { };
+
+		pds_vdpa_set_config_cb(vdpa_dev, &null_cb);
 		pds_vdpa_cmd_reset(pdsv);
 
 		for (i = 0; i < pdsv->num_vqs; i++) {
-- 
2.42.0


