Return-Path: <stable+bounces-83404-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A4FF29995A0
	for <lists+stable@lfdr.de>; Fri, 11 Oct 2024 01:11:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0684FB2416F
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 23:11:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B902E1E7C2A;
	Thu, 10 Oct 2024 23:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P4AKHNFi"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF6C31E6DD5;
	Thu, 10 Oct 2024 23:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728601878; cv=none; b=rGgMbCxQZQWlN8fxzr8QamD7EFPdrpWKWsCCwLwZ6WiL9of/RkVUJimpxtPUKrrHME9plgLCsRGtKV4y9UQtAEi4YwQquV7ZR5u8izw1Blz78ZH0u2nC6VQgNEZ2DsdMrN7/6jT9oeFsHgkj2MEObmGVWyUWaGCwSfygHawSG94=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728601878; c=relaxed/simple;
	bh=IZsWutkwsQdz6JsfcZXxwWl/8k7REIn4zPH/HX5ytTs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=oaoSVHGiKmqGzdLtYs+GzUxHglDdMV5AKahMdGj0U6EjAbIhdKU37Q0r4UCyIKCpLtY71AGzkiIwYHXgT2nbCdAOUHHd7zfrmGl26LscvlE3+afvuWyRefuDTtT2BYqDwlmMnUMNvDnBoTrkMieOWmogppubBJfSw4A3XQYgAbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P4AKHNFi; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-431160cdbd0so8920555e9.1;
        Thu, 10 Oct 2024 16:11:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728601875; x=1729206675; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMBH9FWJx0l+KVOa+9SWfJtBbSYbCQsEEV5rTO8JJDE=;
        b=P4AKHNFiftxoeHR60RfO3agMxWR/1t2dd3P4c3fr0R4Y6rmN/7Hwz3fHxA3NkwNG9t
         XwvvlbPYiPutAmyf9tIKtLlZfiwvPietwbIIGsS4pC6du2ru7BoS5yehISTWf0uq/CkE
         VwKXNjHc8iBCMgFtDFB8YjWRHRiT2jk6+qxoW9yLzKVIuFCG6mMznIy2BH/r1PbnFhKq
         Ikookr+u49TmJ/6PZHdPvNIHkuygThDDNOFjlFyakUl4P6wMslrVN3vqFvXTI4pvYn4r
         r02vOvBXYilpqXKd1neNTeuu+3jhEN/AYk36qzRs7l05XCqZMEeCfUzHDOlKVrJOTRV+
         XFtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728601875; x=1729206675;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QMBH9FWJx0l+KVOa+9SWfJtBbSYbCQsEEV5rTO8JJDE=;
        b=HLvSoVXOIgT7oNKlc6WdY8XjEhmIUpeh5uvvG3OPWnyiOlVkbS3cVjdoM2rvGgsB6I
         H0xvWHPzeDsR+4597yQ+aHQQyzfgSfB3jShfLstJtF+aIlSAthLkWBqXrV71gcBS9Isa
         IafNIzKTqOyny3nbJ/X0iFHZHaNIbpXluqFyrSLTD81ukoCrTGcde035C237zKk5UxUF
         rHqxnBtSBpMJ85toPh9h7vjantOBIMiyEz+8RjqrCUNTaJfhHfML3HX/2y47FqGO4R/+
         lOYDEYvdcqaTzllvivbHYdsLEoQYWuFL2S4Qwip6NfPDBuqpbjuDwbMdYZGF260kE6XR
         ZF7g==
X-Forwarded-Encrypted: i=1; AJvYcCW7YFUTHcO2DBz2hjvBShYa/Y4poyl9hk9dEvorXrkJcWLnLc8SzDhT9qLoRDbNWG23VHP29xC0@vger.kernel.org, AJvYcCWxibBNufODcqNNDjjIJ9VtmPdLsd2mMVKnxnGQlnqIHlQ5Ng+vVOnFsgejaK19HgX+k5fJ9DyT9J/vHLE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxSwk2gpwXji0RIGMVgfVfMtnGfKYGfb6IIOYtuV9G2KR6WKISL
	A9X8dKwqLnzdt7sbZcaEOCNTSIY5O8v6mx0oq3QoUj4rIxWl+pJH
X-Google-Smtp-Source: AGHT+IEYwIA6/NSQJaiEsBC2TPm1jMFPNq2BHxvPMOWmgWKUbfcxi0VUCUbp4n1lGpz6V5FTEpaF+Q==
X-Received: by 2002:a05:600c:b9a:b0:42f:84ec:3f9 with SMTP id 5b1f17b1804b1-4311d884328mr5474175e9.3.1728601875208;
        Thu, 10 Oct 2024 16:11:15 -0700 (PDT)
Received: from [127.0.1.1] (2a02-8389-41cf-e200-3d08-841a-0562-b7b5.cable.dynamic.v6.surfer.at. [2a02:8389:41cf:e200:3d08:841a:562:b7b5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-431182d7934sm27465325e9.3.2024.10.10.16.11.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Oct 2024 16:11:13 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Fri, 11 Oct 2024 01:11:08 +0200
Subject: [PATCH 1/3] drm: logicvc: fix missing of_node_put() in
 for_each_child_of_node()
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241011-logicvc_layer_of_node_put-v1-1-1ec36bdca74f@gmail.com>
References: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
In-Reply-To: <20241011-logicvc_layer_of_node_put-v1-0-1ec36bdca74f@gmail.com>
To: Paul Kocialkowski <paul.kocialkowski@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.14-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1728601870; l=922;
 i=javier.carrasco.cruz@gmail.com; s=20240312; h=from:subject:message-id;
 bh=IZsWutkwsQdz6JsfcZXxwWl/8k7REIn4zPH/HX5ytTs=;
 b=vDiJc06bbjTXqlJJzhKcNDKePYrX8gMJetxAA7AyKGfKL3+gRD8zjKO29PA/TVHrBnXaNElJE
 MALOBokxz/lBZTTCZiWJS0jsedVPf5SCf2JvwCx9ds9xzpFZVTm0NNu
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=lzSIvIzMz0JhJrzLXI0HAdPwsNPSSmEn6RbS+PTS9aQ=

Early exits from the for_each_child_of_node() loop require explicit
calls to of_node_put() for the child node.

Add the missing 'of_node_put(layer_node)' in the only error path.

Cc: stable@vger.kernel.org
Fixes: efeeaefe9be5 ("drm: Add support for the LogiCVC display controller")
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/gpu/drm/logicvc/logicvc_layer.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/gpu/drm/logicvc/logicvc_layer.c b/drivers/gpu/drm/logicvc/logicvc_layer.c
index 464000aea765..52dabacd42ee 100644
--- a/drivers/gpu/drm/logicvc/logicvc_layer.c
+++ b/drivers/gpu/drm/logicvc/logicvc_layer.c
@@ -613,6 +613,7 @@ int logicvc_layers_init(struct logicvc_drm *logicvc)
 
 		ret = logicvc_layer_init(logicvc, layer_node, index);
 		if (ret) {
+			of_node_put(layer_node);
 			of_node_put(layers_node);
 			goto error;
 		}

-- 
2.43.0


