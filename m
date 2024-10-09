Return-Path: <stable+bounces-83199-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EF98996A00
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 14:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DF21C1F230FC
	for <lists+stable@lfdr.de>; Wed,  9 Oct 2024 12:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32685193419;
	Wed,  9 Oct 2024 12:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m54HrKpg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A914E1922DD;
	Wed,  9 Oct 2024 12:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728476977; cv=none; b=q6sR1ye5s/uXJJteEwkATmUJ8gwHDbh4ncPe4lmFsMtubOEIq6q6ajRBLK2iehEObOC5YNJ4uFER+awYpr3hhXmY5N23Zp/3AlUjSVNWB36pYUsPcjUSIdBGfEay2uAPCU3cE2MLmQAYa1XOczLwZWYhcYVMC/pt/Mly/lt0ayY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728476977; c=relaxed/simple;
	bh=l+Dp8u1H1jL5+Dk9FVYOSsx/97fryCIdmK9n0MSBrOM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jZSA3fV9M7H0m02247u5MtIRI+qLnAzg79XxnGWQX6YEie0/w4xlk/pyssGD0M+eNQVPTddp8iOsWHNSUDafhmSnaYT+N9bd8sJlwZY8Srk8zxTnLHuHk/KtURwfaeKYiWZAkCVWVg1S4scAH+y+2gdekNWUsNQuUcMFm3LNOZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m54HrKpg; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-20ba8d92af9so51639085ad.3;
        Wed, 09 Oct 2024 05:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728476974; x=1729081774; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eMdFLkf55iY8mo8GSix8A+wWwdNb0+DgkDm6Xc8j4s4=;
        b=m54HrKpg1MNGtGfe8whhA+hEHYgGv5Ua0OznKcnW/alTX6TIJ5o8ZJ71vDNCjtHLtp
         dV4glmnREqjGDTJGKuvGJc8yep8mXk963/53lEd0mDk5P8CmnZ9wW0gHMIWhtJiD7Lkl
         Q3nuOasT+YYhC+pIGkcId5n2j9DKf+bfDQ5EvgpWtePM/F1Rk/6nRm0KIhlY8kBojH6z
         5vQ2ti4WzWztk0z0xr6qBb19p2hwExDeNamF+yrHJqC1MhJgiTMNeOWft8JoIGvOIs0w
         zpRywPDXMdl8DtHOFinlu6OYFNju/pb3uo3TnvruhKeI2oM+N9Zi8qCF2rwW7fiQYPzH
         TAAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728476974; x=1729081774;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eMdFLkf55iY8mo8GSix8A+wWwdNb0+DgkDm6Xc8j4s4=;
        b=IJfq3FUTBwIUr2y36/ZZAxJ7zB8A3sTjT388Jherz96PDYTdUXDrQ49R2Q/Nx9XDqa
         3IxYx1mdCcog1vUrOWVKGe/g7bKivg81mygPy9eKaFd4F1fOvYsqZ4QBw98Au+RJyWyD
         DWgYkaV33uWO19uxsif981+iqn8mdXCv0qqmUQgb6ipHwTFPVFow5A8KQz+wJLdXl/vA
         nCUTYrUU1vISqHdfQJY4GHXZ2DMO3m+tonGv6A1goU0XUbx5ilq8YiSluQ78VkmNOaPb
         p/qT7WVNs/bs55PBhSgC+oLxeQIalfdbI9SUc07KNQ0QQE0nJpLIG5sKhi5VsRzph/1T
         aRXA==
X-Forwarded-Encrypted: i=1; AJvYcCVNJbxY5XDAecVGbkRUcDn5vomtABYSxYV1k77Zn7m+rGXxQhIx57YbR9L4lW8zcG7oAAJKRGYW@vger.kernel.org, AJvYcCWwt9SvycN7+y79uwrdkJLLrpBBj8NxqgDXrB0PyzjkdecLI5C7Ajk0z04SfaOLq6f+2Le6qbpNuFACvEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMzqzaAPICW7mT/VN7sr8Ef2LM/XwAvUjGuavrAwqP0z/9HEWz
	YDx5bzjZw1GgOyWBxC3WeY44ITRE6AJE6uFdGCWmjOVl9SvLyarvDqdB8cZK
X-Google-Smtp-Source: AGHT+IHOhfqq0sDN4lcnvYYpx8jag/IqmcLbJY3tWBChS7jUw5p6ehVxXu2GHV6j0c3N1NtWOWbpag==
X-Received: by 2002:a17:902:d491:b0:20b:983c:f095 with SMTP id d9443c01a7336-20c6378fc02mr37086205ad.51.1728476973686;
        Wed, 09 Oct 2024 05:29:33 -0700 (PDT)
Received: from archlinux.. ([2405:201:e00c:517f:5e87:9cff:fe63:6000])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-20c65fc262dsm10591305ad.225.2024.10.09.05.29.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Oct 2024 05:29:33 -0700 (PDT)
From: Mohammed Anees <pvmohammedanees2003@gmail.com>
To: alexander.deucher@amd.com,
	christian.koenig@amd.com,
	Xinhui.Pan@amd.com,
	airlied@gmail.com,
	simona@ffwll.ch,
	srinivasan.shanmugam@amd.com,
	David.Wu3@amd.com,
	felix.kuehling@amd.com,
	YuanShang.Mao@amd.com,
	pierre-eric.pelloux-prayer@amd.com
Cc: amd-gfx@lists.freedesktop.org,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	Mohammed Anees <pvmohammedanees2003@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/amdgpu: prevent BO_HANDLES error from being overwritten
Date: Wed,  9 Oct 2024 17:58:31 +0530
Message-ID: <20241009122831.109809-1-pvmohammedanees2003@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Before this patch, if multiple BO_HANDLES chunks were submitted,
the error -EINVAL would be correctly set but could be overwritten
by the return value from amdgpu_cs_p1_bo_handles(). This patch
ensures that if there are multiple BO_HANDLES, we stop.

Cc: stable@vger.kernel.org
Fixes: fec5f8e8c6bc ("drm/amdgpu: disallow multiple BO_HANDLES chunks in one submit")
Signed-off-by: Mohammed Anees <pvmohammedanees2003@gmail.com>
---
v2:
- Switched to goto free_partial_kdata for error handling, following the existing pattern.
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
index 1e475eb01417..d891ab779ca7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_cs.c
@@ -265,7 +265,7 @@ static int amdgpu_cs_pass1(struct amdgpu_cs_parser *p,
 
 			/* Only a single BO list is allowed to simplify handling. */
 			if (p->bo_list)
-				ret = -EINVAL;
+				goto free_partial_kdata;
 
 			ret = amdgpu_cs_p1_bo_handles(p, p->chunks[i].kdata);
 			if (ret)
-- 
2.46.0


