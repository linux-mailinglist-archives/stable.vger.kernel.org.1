Return-Path: <stable+bounces-5381-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DF79080CB92
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 14:53:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 94B441F21575
	for <lists+stable@lfdr.de>; Mon, 11 Dec 2023 13:53:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8040E47788;
	Mon, 11 Dec 2023 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JNxZzgpL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36D784776B;
	Mon, 11 Dec 2023 13:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C73C433C7;
	Mon, 11 Dec 2023 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702302790;
	bh=ce52MwjmCIqIGNpNziEdwAz/8cYu0NoXFtL2rJUJqLo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=JNxZzgpLHXLGUscfzHgZELbcJv8FCZjRWlDswmv6kZ/fHe9TzniSXBiDUY8MLEmkp
	 1ussrscWsZwFtr9vDld/wApBpwEGqZ9kZ/UZxtOW20Qq50CcoypgyzDPph3BT2Z3R0
	 V3V4CWhEaJ+K4pTfZTWo2+ESa9Z6fU2l3VB2RofURrCyodAfuzwWcLoGj5FRmJgiyu
	 L2V4sX1pGb/zE2ookO7hvAeLvKMVuNagm/o3aBX854R77zWmjQbU4+mGQ4GektHfmF
	 5LgQmxHhArjQYTUL6HBN1AtOfF99/KcjS0HSjfj7fvCortbANtGJWG0jn1UjpdSNFP
	 86xQCMNIlQsnA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shannon Nelson <shannon.nelson@amd.com>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Sasha Levin <sashal@kernel.org>,
	allen.hubbe@amd.com,
	virtualization@lists.linux.dev
Subject: [PATCH AUTOSEL 6.6 26/47] pds_vdpa: set features order
Date: Mon, 11 Dec 2023 08:50:27 -0500
Message-ID: <20231211135147.380223-26-sashal@kernel.org>
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

[ Upstream commit cefc9ba6aed48a3aa085888e3262ac2aa975714b ]

Fix up the order that the device and negotiated features
are checked to get a more reliable difference when things
get changed.

Signed-off-by: Shannon Nelson <shannon.nelson@amd.com>
Message-Id: <20231110221802.46841-4-shannon.nelson@amd.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Acked-by: Jason Wang <jasowang@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/vdpa/pds/vdpa_dev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/vdpa/pds/vdpa_dev.c b/drivers/vdpa/pds/vdpa_dev.c
index 9fc89c82d1f01..25c0fe5ec3d5d 100644
--- a/drivers/vdpa/pds/vdpa_dev.c
+++ b/drivers/vdpa/pds/vdpa_dev.c
@@ -318,9 +318,8 @@ static int pds_vdpa_set_driver_features(struct vdpa_device *vdpa_dev, u64 featur
 		return -EOPNOTSUPP;
 	}
 
-	pdsv->negotiated_features = nego_features;
-
 	driver_features = pds_vdpa_get_driver_features(vdpa_dev);
+	pdsv->negotiated_features = nego_features;
 	dev_dbg(dev, "%s: %#llx => %#llx\n",
 		__func__, driver_features, nego_features);
 
-- 
2.42.0


