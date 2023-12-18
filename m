Return-Path: <stable+bounces-7665-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A2CE8175AD
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 16:42:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 291D1283CB3
	for <lists+stable@lfdr.de>; Mon, 18 Dec 2023 15:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B94053D557;
	Mon, 18 Dec 2023 15:37:19 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56E7C3A1D4
	for <stable@vger.kernel.org>; Mon, 18 Dec 2023 15:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-5c229dabbb6so1208929a12.0
        for <stable@vger.kernel.org>; Mon, 18 Dec 2023 07:37:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702913838; x=1703518638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y/y7DUT/byHayc6uwW5kobarZkk6Px+TVJNfEEfRq9E=;
        b=fu9qLI1u8Jom84yMT8pe4qOr8SfgDAUVki38L/WRA7trRBBHc2QjZ+KyhmVNVUKzyt
         UtCmUx8+FhTySrvmKPMaNy4nTdW9x6ilEU7I/yREuLdoyFnTPbW2lT+qN+eboNLLuCPH
         jo95AWid2GQoGX4U2FgvqQ3BJFNXOEPl02pOlmMQGDRQy/mpl6fmSqQG3jRxYT0xTFmV
         ngGinBGnsnpY/X0UvNHEJFzhVco3y955J6RG2TzRgejgkxmdgMg6ws/AzETGLeaFX3DJ
         S/StNy7auXha8NIB3nV+5DB5FhZFua1G10IYxgFtrNhSvx1gwqOa18pi0idd8sHqO1aC
         c3KA==
X-Gm-Message-State: AOJu0YyF1+K8Vq6VBIKRoWzeHjdxaSktp2cVVOVHnCByhG0uRt4FN8G4
	Fx1jroJzXLGaYkcw7GxoCq9ASmba1K8=
X-Google-Smtp-Source: AGHT+IGfUl1gKD0lmiaBp8gvg/BcJ+4eA0uxkESzRxUed3e2QPaprKFzMpgiY3P2nI44X1uHBM493Q==
X-Received: by 2002:a05:6a20:160b:b0:194:58b3:9518 with SMTP id l11-20020a056a20160b00b0019458b39518mr875517pzj.92.1702913837719;
        Mon, 18 Dec 2023 07:37:17 -0800 (PST)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id fs7-20020a17090af28700b00286ed94466dsm5613041pjb.32.2023.12.18.07.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Dec 2023 07:37:17 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org
Cc: smfrench@gmail.com,
	Hyunchul Lee <hyc.lee@gmail.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.15.y 036/154] ksmbd: smbd: change the return value of get_sg_list
Date: Tue, 19 Dec 2023 00:32:56 +0900
Message-Id: <20231218153454.8090-37-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231218153454.8090-1-linkinjeon@kernel.org>
References: <20231218153454.8090-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 4e3edd0092704b25626a0fe60a974f6f382ff93d ]

Make get_sg_list return EINVAL if there aren't
mapped scatterlists.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/ksmbd/transport_rdma.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 02271ebf418a..ca853433e4b4 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -1085,7 +1085,7 @@ static int get_sg_list(void *buf, int size, struct scatterlist *sg_list, int nen
 	int offset, len;
 	int i = 0;
 
-	if (nentries < get_buf_page_count(buf, size))
+	if (size <= 0 || nentries < get_buf_page_count(buf, size))
 		return -EINVAL;
 
 	offset = offset_in_page(buf);
@@ -1117,7 +1117,7 @@ static int get_mapped_sg_list(struct ib_device *device, void *buf, int size,
 	int npages;
 
 	npages = get_sg_list(buf, size, sg_list, nentries);
-	if (npages <= 0)
+	if (npages < 0)
 		return -EINVAL;
 	return ib_dma_map_sg(device, sg_list, npages, dir);
 }
-- 
2.25.1


