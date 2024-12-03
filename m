Return-Path: <stable+bounces-98137-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E7F579E292F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:27:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACDDB28408F
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 17:27:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B5541FBCB0;
	Tue,  3 Dec 2024 17:26:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="4SAjdCyj"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F09B1FA826
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 17:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733246811; cv=none; b=OV5vGF5XpKGYVdpWDWE7pFSiTJqtWVZW8sLR+iZ6eG0RAl0jGGNcfliwsk8OOX/rAVOdzI+yqbUyg6jP81O7CW0Rtm3FMfYQXfSLJN+/vq78XYcZfjKF0zGHVMv3yiqP50cw4nIJkgq+bHgwt/FF4cplisuJEmY14i2Hvx1xwtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733246811; c=relaxed/simple;
	bh=Aq2zO2su/gJQZo1LKHbVMD9Hcz8GmXaQFYJOvJIHJUg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=I9QhAj1XpUWXVAflK7rfp7Dvb9/89hDwC1DfoXhf79oSZ38Wrf2xSVS2/CjMgHEq1WrLK3n8eIqS/ueZm8dOjPiH6TZStH8phaadmMxQjFOPW/JuLKyj9WjG0LRxjs/y6sRB05iZGfN1GMbMqxMTiEjshKIYic4J9xViybNzF2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=4SAjdCyj; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4349ea54db7so56565e9.0
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 09:26:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733246808; x=1733851608; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9A/J5jkgomsMiHFvcuDoSxKD5NJW5y7f08S/zY5zTv8=;
        b=4SAjdCyjnIkugf8ljwDjQXnvxNeDEy1R3GoxGeaOuV0Zb0CNbkf+V7fSrTVGXqKVhD
         Cq95lsNfmUSVwpWk+HDaec9oUsAlRMEIbLrmHCDQEND2gQJRoPas9IGX0OeK0z6tTckY
         IVwrqCe6eXV1AkjY3J/otecJDvb1KU6L4sjiCNVzk6o6s+MHOou8A8DEVpoEGCoU7O8R
         tAlak021kRrD++owqZ6JAHiMwFG7BE+AMYGWT5YY9ejwAUgMJYC+b7BVUsJ+eGuPbSMC
         UbGQOZo1SO7gcyygN048hQ+Y4bmLU67CX8HTrLG49d4RHQ1jFrPU7abrroLJE7AWkBYr
         IjaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733246808; x=1733851608;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9A/J5jkgomsMiHFvcuDoSxKD5NJW5y7f08S/zY5zTv8=;
        b=IuV0i2hpNYeGOMptoyc054Omjpbowutay5eQZhCsloIa1moaU0frWmk/Rcf7fRxGYQ
         kY8dWDUSZFjFfQ25n1XEKGlQP+HOEQ6/oR8hauhaUjV8EyWtI/gIxzkEC3UJoDwp/Yjv
         LY2AAsKOvDib5p9PZ3zeqSe2b7VXJeinhGOF36HiFAsJGewCB3sVG1Rhw7ygD+nHAm9K
         Apq8rHBwhkxFsHQ+GUCYVbxDPFcyMf10EBTU1Qw8MAwA+a3q2DuK7Pcs4td+H1ianrlt
         4NMG0CZaHtAIFogyUCiHvM8K9Es6Zo7Ek5uhiYz7TSm+v/OxJf3uaIkeegB72JLHzR/B
         RiFg==
X-Forwarded-Encrypted: i=1; AJvYcCUKncjwsiAOnbcuPU9cXq+DYx0mQMaOEu4Xn/PnCp9LyHrEQiuEwxGxtuWnVdh3nVk7KDUG9hg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxfWrScBShAiA43LtKPWfQ4nhoV0Zpoe258ZAptp40ZrVfAg9+G
	i0BEX9EKpmvCp8nIzwqxoW0HRBQE3vPQTxD45fBgr04pNMvwfERR/uUvlwH8qA==
X-Gm-Gg: ASbGnctbNsdvnMmu7cU4HHHNay1/jSeRH832f2+7ahKJ8Z1GeUVAQL1NnWpc3NYr8L0
	fkEBQ3iS8pQUpRZkZgB2hix8EMx4w/uuNhvPC0oOMbALPIkmV6Cotg97YAsCURQ497A/GpfLMLZ
	UI4XK8AzhXMcCqa0UJEwuzskWP/a02IlZCRzu3d2d7Hdsp9oawmqnJ5NMsByQVwhJJtVd+0AAHu
	ve4oSrYLRjw2XAv6yQf0Nl/wnadSWS+fb8I5Q==
X-Google-Smtp-Source: AGHT+IFZqTIc4JHhlvLFIIqiUiNlQB9koDtYePpOB1Asac3qhzzJf/qabHheeO4gqnlhnImPyoFMHQ==
X-Received: by 2002:a05:600c:1f93:b0:42b:a961:e51 with SMTP id 5b1f17b1804b1-434d04fbed7mr1401935e9.0.1733246807548;
        Tue, 03 Dec 2024 09:26:47 -0800 (PST)
Received: from localhost ([2a00:79e0:9d:4:92ba:3294:39ee:2d61])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-434b0f70d9csm201336315e9.38.2024.12.03.09.26.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Dec 2024 09:26:47 -0800 (PST)
From: Jann Horn <jannh@google.com>
Date: Tue, 03 Dec 2024 18:25:35 +0100
Subject: [PATCH 1/3] udmabuf: fix racy memfd sealing check
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241203-udmabuf-fixes-v1-1-f99281c345aa@google.com>
References: <20241203-udmabuf-fixes-v1-0-f99281c345aa@google.com>
In-Reply-To: <20241203-udmabuf-fixes-v1-0-f99281c345aa@google.com>
To: Gerd Hoffmann <kraxel@redhat.com>, 
 Vivek Kasireddy <vivek.kasireddy@intel.com>, 
 Sumit Semwal <sumit.semwal@linaro.org>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 John Stultz <john.stultz@linaro.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Joel Fernandes (Google)" <joel@joelfernandes.org>
Cc: dri-devel@lists.freedesktop.org, linux-media@vger.kernel.org, 
 linaro-mm-sig@lists.linaro.org, linux-kernel@vger.kernel.org, 
 Jann Horn <jannh@google.com>, Julian Orth <ju.orth@gmail.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.15-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1733246802; l=1642;
 i=jannh@google.com; s=20240730; h=from:subject:message-id;
 bh=Aq2zO2su/gJQZo1LKHbVMD9Hcz8GmXaQFYJOvJIHJUg=;
 b=nHri5mQURsQCt6qUqaiD5aSYbBqGWvkkFAyFFqtmxx/10lRP3oWxueAag4of6Gz9UdJJ7j6rF
 fH9tuFCVgXJDnU7/j0wwtosFko/X7UkQaHlRmJaTrIACgXmedoy/Ws4
X-Developer-Key: i=jannh@google.com; a=ed25519;
 pk=AljNtGOzXeF6khBXDJVVvwSEkVDGnnZZYqfWhP1V+C8=

The current check_memfd_seals() is racy: Since we first do
check_memfd_seals() and then udmabuf_pin_folios() without holding any
relevant lock across both, F_SEAL_WRITE can be set in between.
This is problematic because we can end up holding pins to pages in a
write-sealed memfd.

Fix it using the inode lock, that's probably the easiest way.
In the future, we might want to consider moving this logic into memfd,
especially if anyone else wants to use memfd_pin_folios().

Reported-by: Julian Orth <ju.orth@gmail.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=219106
Closes: https://lore.kernel.org/r/CAG48ez0w8HrFEZtJkfmkVKFDhE5aP7nz=obrimeTgpD+StkV9w@mail.gmail.com
Fixes: fbb0de795078 ("Add udmabuf misc device")
Cc: stable@vger.kernel.org
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/dma-buf/udmabuf.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/dma-buf/udmabuf.c b/drivers/dma-buf/udmabuf.c
index 8ce1f074c2d32a0a9f59ff7184359e37d56548c6..662b9a26e06668bf59ab36d07c0648c7b02ee5ae 100644
--- a/drivers/dma-buf/udmabuf.c
+++ b/drivers/dma-buf/udmabuf.c
@@ -436,14 +436,15 @@ static long udmabuf_create(struct miscdevice *device,
 			goto err;
 		}
 
+		inode_lock_shared(memfd->f_inode);
 		ret = check_memfd_seals(memfd);
-		if (ret < 0) {
-			fput(memfd);
-			goto err;
-		}
+		if (ret)
+			goto out_unlock;
 
 		ret = udmabuf_pin_folios(ubuf, memfd, list[i].offset,
 					 list[i].size, folios);
+out_unlock:
+		inode_unlock_shared(memfd->f_inode);
 		fput(memfd);
 		if (ret)
 			goto err;

-- 
2.47.0.338.g60cca15819-goog


