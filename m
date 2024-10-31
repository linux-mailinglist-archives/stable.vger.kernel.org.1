Return-Path: <stable+bounces-89437-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DBDF39B8152
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 18:34:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5EED41F25A8B
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 17:34:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F9981BE239;
	Thu, 31 Oct 2024 17:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eDcuvM5F"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98BAB1B6539;
	Thu, 31 Oct 2024 17:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730396029; cv=none; b=BpDJWCdsq45IRE6HQvCZes1G+YCCkbke5KOXqzxyDo9gBt3WKMOd7RsBdAEsv0YqPknBRzXqMGh6oEa8Jl+2/r8o/3hAORiiqPvn/cPDFtiSGpX5wrve951kFj0fysYsdUZozTD4nd8wapnqnTd5pdQ6aOTZB5aX30EqDQ6fFZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730396029; c=relaxed/simple;
	bh=IGVolImcMlNftMI/RGRi+8yI+0ZXlL9lnQIjOFSHlak=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=ojcVkLLTtP/yaMjfU4ScTXNOdfojUB/X/qYGJE1mKthaMUBz3/B5sbPR/C3BBOWK9u+49HUpMLS4ziuKfPeBdJU8Qmn1rWJzZtevohqFFBuplS67eRpe1k1/1xSZEFrf11hBHaFRpYhnAuMSYRssLYP8BdfDXfJfTkIiXU6+g2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eDcuvM5F; arc=none smtp.client-ip=209.85.167.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-539e4908837so153923e87.0;
        Thu, 31 Oct 2024 10:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730396026; x=1731000826; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=LIXbyaTfssNAyjGRH62B+/Wf9jW1JYzFaYHYfgpeAWA=;
        b=eDcuvM5FP2d/k4iRAcPtJ6I6xXZV8GAQraisbzy6Puqiyks0MzgKf157BWmmYser6x
         2RBXyojhSlkd62W1+slDIHki4DfRSxnkccmQDRgJCYX0NtVl9XbZByO6kEScN1APQe17
         qedbu80uOnkeXHr5KBVDEpdiQoZv9aHE4RoCsUIKsWiQp1J/f9bP75ZrX0zZKlS/Ajnf
         MCVgRMSlRK7V4YBADMEG0+/vYTLXO08EAmeDqmhk5u9qrOQ4CO1GiHzSlO4BAuZF6bhc
         Rjg6cYfIQpl16KV5XWjARaaFEg5XlFcmBkDEO8yGb9sWx6YquDK0khc2WVb+NgXZJCiV
         rCxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730396026; x=1731000826;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LIXbyaTfssNAyjGRH62B+/Wf9jW1JYzFaYHYfgpeAWA=;
        b=EAjj8eJcNufVHXTYYkP6LoeXPCI//jx2lVlY9kujdnb8m3RJxiAo4pqYzw9oB5uBHQ
         7ygTOZvfZrpj4CPR2+c6YK2BMWz56R0t0FLouTX8AmHywroIf0m/bLpb7DiJzoH0/qZE
         FWhNF8uK8dtPCglWWjLI+z/vHbKihrU8px2Jdwj0p4iPaXdtW3vwIpPzMdxXLWHqf7Fr
         m2XRYyTt0QO++a7eWLpBOiizHZ2EoDsczguUu1rlh5p75WOeIkPkiGrkz/6DHi8uB8i1
         RiI1lhzBwfoIcKc3dgR18Z+/GQqgepXJqjr2M05tmT0k6b302LDp6H8pK61lonBJEapu
         au5A==
X-Forwarded-Encrypted: i=1; AJvYcCUVJKLQp52ZEqgKtcK8VAJMVy96wA45hkINZZcEHnv9NRSBv+oWkocgYNk4wYf2gT/s3NdZbq3B@vger.kernel.org, AJvYcCWmNTTRo9Wy+uzmNfbn0n7xx/lvYyvIIlzZyJS8O+ah0qZXSQ7qwdyipWnQ+STSQxm3qyEzXZoWnHM1cYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxL9m6o0uDk6DiT8n9uqqQe/BPkf7s3vzGmiNO+2Ar3YuiF+txv
	u/A1n+4h7KOgbuJzgqASSRMoPjBN3QDLofIlaaJRoZ1CqApK6pu3
X-Google-Smtp-Source: AGHT+IHuM9wLydex6CXCJYt8RpMld+KpUmO1ocY+CUO2ZVzT1y6Hymj5lWWus0GILDLZ60xO3FUJdQ==
X-Received: by 2002:ac2:4c52:0:b0:52f:287:a083 with SMTP id 2adb3069b0e04-53b34728fd9mr3123365e87.0.1730396025338;
        Thu, 31 Oct 2024 10:33:45 -0700 (PDT)
Received: from localhost.localdomain (109-252-121-216.nat.spd-mgts.ru. [109.252.121.216])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-53c7bde09adsm272401e87.263.2024.10.31.10.33.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Oct 2024 10:33:44 -0700 (PDT)
From: George Rurikov <grurikov@gmail.com>
To: Christoph Hellwig <hch@lst.de>
Cc: MrRurikov <grurikov@gmal.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Israel Rukshin <israelr@mellanox.com>,
	Max Gurtovoy <maxg@mellanox.com>,
	Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	George Rurikov <g.ryurikov@securitycode.ru>
Subject: [PATCH] nvme: rdma: Add check for queue in nvmet_rdma_cm_handler()
Date: Thu, 31 Oct 2024 20:33:27 +0300
Message-Id: <20241031173327.663-1-grurikov@gmail.com>
X-Mailer: git-send-email 2.31.1.windows.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: MrRurikov <grurikov@gmal.com>

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

Fixes: e1a2ee249b19 ("nvmet-rdma: Fix use after free in nvmet_rdma_cm_handler()")
Cc: stable@vger.kernel.org
Signed-off-by: George Rurikov <g.ryurikov@securitycode.ru>
---
 drivers/nvme/target/rdma.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
index 1b6264fa5803..becebc95f349 100644
--- a/drivers/nvme/target/rdma.c
+++ b/drivers/nvme/target/rdma.c
@@ -1770,8 +1770,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		ret = nvmet_rdma_queue_connect(cm_id, event);
 		break;
 	case RDMA_CM_EVENT_ESTABLISHED:
-		nvmet_rdma_queue_established(queue);
-		break;
+		if (!queue) {
+			nvmet_rdma_queue_established(queue);
+			break;
+		}
 	case RDMA_CM_EVENT_ADDR_CHANGE:
 		if (!queue) {
 			struct nvmet_rdma_port *port = cm_id->context;
@@ -1782,8 +1784,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		fallthrough;
 	case RDMA_CM_EVENT_DISCONNECTED:
 	case RDMA_CM_EVENT_TIMEWAIT_EXIT:
-		nvmet_rdma_queue_disconnect(queue);
-		break;
+		if (!queue) {
+			nvmet_rdma_queue_disconnect(queue);
+			break;
+		}
 	case RDMA_CM_EVENT_DEVICE_REMOVAL:
 		ret = nvmet_rdma_device_removal(cm_id, queue);
 		break;
@@ -1793,8 +1797,10 @@ static int nvmet_rdma_cm_handler(struct rdma_cm_id *cm_id,
 		fallthrough;
 	case RDMA_CM_EVENT_UNREACHABLE:
 	case RDMA_CM_EVENT_CONNECT_ERROR:
-		nvmet_rdma_queue_connect_fail(cm_id, queue);
-		break;
+		if (!queue) {
+			nvmet_rdma_queue_connect_fail(cm_id, queue);
+			break;
+		}
 	default:
 		pr_err("received unrecognized RDMA CM event %d\n",
 			event->event);
-- 
2.34.1


