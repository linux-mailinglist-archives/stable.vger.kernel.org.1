Return-Path: <stable+bounces-177628-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D30E8B422E4
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 16:02:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A86133A9CC2
	for <lists+stable@lfdr.de>; Wed,  3 Sep 2025 14:01:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC0330F52D;
	Wed,  3 Sep 2025 14:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GyiR/SZ3"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3A755789D;
	Wed,  3 Sep 2025 14:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756908047; cv=none; b=Th/I6ofDf0iYnmzSB6S0NvBxTpDdV+pvUkNzGZctN+yFVUQtpABKbQfNiZS7MKXZIfRhmw7gLLjYMJ4dP9LxRhcdyWCqsCnSQjNH00VLbSroNe5w6Nn41iFILt99uD9Iyd46ClrAapfmuTRi79pXxiWR3kMggPQ9gfRRDtCbw7s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756908047; c=relaxed/simple;
	bh=lSF301elCdPOXOy81GiG5IgHSG1690Usuy6RvYlRfa0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=qhcTkB3BCoRVhLU6mY9R5qUKzt4GSmd/xqYOK+HGr+zM5Mb3UT0T1wSNmGOlYbKKtHuxQpNP6CFbLIUuKk9PuixqLefbmuCszDuQ+dtUrVogtvok5TLT6/4/X5+S2IvBbMiL7WPD8r3zV7fCbvkPJfufDq/prYZeH6LzbEFW4ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GyiR/SZ3; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-77250e45d36so2763933b3a.0;
        Wed, 03 Sep 2025 07:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756908045; x=1757512845; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xAesZB2lk9ao4BWYXbJjTK7DuZ36IgP0HTueS0+3TwI=;
        b=GyiR/SZ3LwbvrpCfK8AG+WNipOM/1vifWFQN6K0VwQfCRWN89jDvjP/GP65Qf+EJn6
         +ufX5Nh8D+qibj8TNIW3WaT170WpFUxqNqLQQbEdyW0TodHyr3nilF7J0cqWmt6qgqfs
         ZfkT5Jw8SOUiCLYuDgnCa4tIXfdBuwglS6EUBZD8NfInIwnQe7XCftNddB7mo/zPBFCP
         9cdCm3M5ucVSo6xNWPaCk8Y0iIkziX84Q6pRQIOQvT+zynRLXwO47WCfzfKAHxvF6ike
         v8yKREburrRZGlyNGETvVH7uHBi7/IalPkAaivOEvSHaYFYm9n0c79+MtqN4WWaaTQoG
         DGvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756908045; x=1757512845;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xAesZB2lk9ao4BWYXbJjTK7DuZ36IgP0HTueS0+3TwI=;
        b=shInUsIGLQLRhp5fnB7hLdzsrvLf8jiNtmuiWQtAapwG6gHmLAri61jm1blu4drZhJ
         BRX6MiGyAW1WDGAknnsxYAmevnIgSigtIgs7CZ0yNzQ6/9HbtCh5IYpHxuq8tvzqteXm
         jenosbgTlFK7tkY7BeCJdRJcy7pK1fUaXXgdZQGThxOGUkji+DmMwcw5avCbz5jkFQQF
         Dvm8w+3rWF+xA6iEEbpI9bl28D2KKsjvAuEHYEUcF/tYCJIbwCZQMju9CjUoZKI5Xy7R
         Dp2M1tOZNS9GEGL7Q0EBP5wAfik5m3i8eT+jGxi84NgSOzam8V8WLAsKnw0v75MPWqOU
         neyg==
X-Forwarded-Encrypted: i=1; AJvYcCVY9ZcQqhuspaz3EItBO8xRCFe/tjDqhm/Fky156wsp7BqSgAzQKohQpZMiYEyORloV72VISCI1@vger.kernel.org, AJvYcCWoKCIcC5uev+NDFlIMPM1dJ72A9ItSB4Kb8Oke+J44tYH4n2E5QJhBmm4M75lkO+nw6XY0sDl4mAzeumg=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxl4+Dze7bfmewy5kz6qSoLWru1/sPwC1bB7lU/k+oQ7EKgmm/M
	fGA3eWOPFKphWmHctRf8ays8SqDkfmjRah6tBsj7lGHLtMzFgGzuLGVA
X-Gm-Gg: ASbGncun7j07cHtETAKh5G5h15BJvYC4LvnuVVszKIJuvFfHG2qrl7FH1ucCI5xkIe/
	QLoirDcisIHmzJjflUY3utGtwp7Aj5PoxVJkgYwUp4HcAp1IWB2u7lgmBTEQe8OfRRp/co/wG75
	13hGQV6XTtufFngmLwcw/NDtVRL/BZzR8x1Nk6GQisUFLNBwJ5QQTSOsuS52RK4ckgG3f57a9XG
	RRdb6XAOFnfC5DdRUwEaCIOLUyINnEuwZApaPFkTZM3WdDb/uz+x81jvv9HOo3xatxIHQNoOM/g
	FtaX9L356xl8oGbrLKGMKKzwMs3aj1C3r4xYJk77HavzEr+8L+t/fo+fwqMCAmXk8QPgYp5UFkI
	jj1bnDWO6d999SY4E+lmJiypwLmw30RNQnjQtqZ42BUP0kdX7xBlV0jUNfIl5SIV1cFnZu3XAkf
	ewoO5y0j7/V3r7lQZOsT7/ku9GTq5DPax+gH20iSv3svY6bb1JdoncxGQ=
X-Google-Smtp-Source: AGHT+IEiZzIqbK6NtZy7OvrioKfNs+nNoDPdVd41ZcGEBWChbdaMmyXQ4AtaISVEW5t+yv55VsqWyg==
X-Received: by 2002:a05:6a20:9189:b0:248:7a71:c1e with SMTP id adf61e73a8af0-2487a710dcfmr3734029637.52.1756908043165;
        Wed, 03 Sep 2025 07:00:43 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.165])
        by smtp.googlemail.com with ESMTPSA id d2e1a72fcca58-77243ffcebasm12891155b3a.51.2025.09.03.07.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 07:00:42 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Thomas Zimmermann <tzimmermann@suse.de>,
	Javier Martinez Canillas <javierm@redhat.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Thierry Reding <treding@nvidia.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] As the doc of of_parse_phandle() states: "The device_node pointer with refcount incremented.  Use  * of_node_put() on it when done."
Date: Wed,  3 Sep 2025 22:00:35 +0800
Message-Id: <20250903140035.2529812-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The function doesn't calls
of_node_put() to release this reference, causing a reference leak.

Move the of_parse_phandle() call after devm_kzalloc() and add the missing
of_node_put() call immediately after of_address_to_resource() to properly
release the device node reference.

Found via static analysis.

Fixes: 9a10c7e6519b ("drm/simpledrm: Add support for system memory framebuffers")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/gpu/drm/sysfb/simpledrm.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sysfb/simpledrm.c b/drivers/gpu/drm/sysfb/simpledrm.c
index 8530a3ef8a7a..f0bd7e958398 100644
--- a/drivers/gpu/drm/sysfb/simpledrm.c
+++ b/drivers/gpu/drm/sysfb/simpledrm.c
@@ -183,15 +183,16 @@ simplefb_get_memory_of(struct drm_device *dev, struct device_node *of_node)
 	struct resource *res;
 	int err;
 
-	np = of_parse_phandle(of_node, "memory-region", 0);
-	if (!np)
-		return NULL;
-
 	res = devm_kzalloc(dev->dev, sizeof(*res), GFP_KERNEL);
 	if (!res)
 		return ERR_PTR(-ENOMEM);
 
+	np = of_parse_phandle(of_node, "memory-region", 0);
+	if (!np)
+		return NULL;
+
 	err = of_address_to_resource(np, 0, res);
+	of_node_put(np);
 	if (err)
 		return ERR_PTR(err);
 
-- 
2.35.1


