Return-Path: <stable+bounces-89391-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 117D79B73F7
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 05:56:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AB9EAB23075
	for <lists+stable@lfdr.de>; Thu, 31 Oct 2024 04:56:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4892A13B590;
	Thu, 31 Oct 2024 04:56:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="YLRYp3mC"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 450F713174B
	for <stable@vger.kernel.org>; Thu, 31 Oct 2024 04:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730350579; cv=none; b=VHl2ucEnmVKV1rV8sxxmHE1BDcnZkltkr5qtAYbQzJKew9eBJDr3pZZajQdBOmPkRLoW+Y+GRn69xjgVc/grRnAbd0f5bio4LHaand4olD2fme/V4ERZd6UFgn/NVIcRUVTMuoCz4fSSutlS9CJTKHRB1SLEfQMrrwcVQFvIEGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730350579; c=relaxed/simple;
	bh=90DyzMh+3InP5LjjTqhduziKAJPe9dWWJgXzrPyn2vo=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=jcqf+XN7iwR+2f4vzbSyrYplT/BzC75CODsLZWdXQnc8r5DB4gkv3ksFK3CryDjzcWU749ziEXU+xQBOGZ9saFPg9qK/OfCq0cmct4PQ+RoRGUb/7LLaTTcVeWfFsJ/rbLND+o+OKfL9gBMScfZqzTPfJX77UkGoPv8s9NIZdmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=YLRYp3mC; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--avagin.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-6e370d76c15so10016487b3.2
        for <stable@vger.kernel.org>; Wed, 30 Oct 2024 21:56:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730350576; x=1730955376; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=I97b63gkdmSBdnuB9dOGrYfy4ImSP9vTzH5ACLew3Zw=;
        b=YLRYp3mC134cb6P7R/kcTiCDYR74LxToAxYKl45wNbdHPw58cVs/zHrrhF4pFC3+U4
         f2fD30I2v7iboH/FcUVduNsxXPm+v7ppGXrWNaYPqKB6CNwGJ694Vg5+rbpkY5xQYQoo
         Nr3d+VLcZ3x2dIDNLcClVysa8y2RW04NacOWqHUXrliFRXZPMizhi8NfMMNpj0hBr644
         EWUth+za/EtXo5GDGYOxLjQUe8VNqAVS6jt09devo03DxIoV65Vf4BD2NgzxK2s8QpUT
         uirA24R/Nxndz0tV0cVSlGvbJ/446WfEFPPxCAnFu1xt2KhmbTmM85jrNH6S+ljCF8PH
         7Dcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730350576; x=1730955376;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I97b63gkdmSBdnuB9dOGrYfy4ImSP9vTzH5ACLew3Zw=;
        b=BuDRURhykEz6AD11i07I1HIIlwKboOU8B43HstqnQWUJ0g0g2I7cRpxKPux8DBEy6a
         B31Bpnr0UTud1vywJ7UPqM7YrhZUkfoCOCQh5Fo7ieSX5F1MYpEfwOlqublu2A6vw6Xz
         jqW0jt/ivyErPLH6Bw7j+CofwSrCSsVAFCwfCQRs63BEJczwzocmPgr8sDmUT+YSDyjY
         yroIc+U9Kin+xnQgWbwOr7wY/JYh9iNwRisagYtx/swDL31gzpJpd/xyGkzylumU6yYU
         lafqax44H2brNoKJ1uTSAqfapzVkJne2atjs8CqFsO1PSWuEfutDPXcxQt262pI8vdjd
         MjWQ==
X-Forwarded-Encrypted: i=1; AJvYcCX+vWdXQ8uMS/c2LSjk8NmBxQMcNzC/w57RAOERvJqn1+SalOV7i51ffexLHAt09/EipfJB14k=@vger.kernel.org
X-Gm-Message-State: AOJu0YyhG+hJmVqeq82ZIsbf01ZhqJeiJUJnE1zqjiofVdCC/kLz5NJI
	KMlCqyhd2WHjULvaqO0jOacJp7oa4o89rPMj6NWTCz1I+vVdA1QqAv4CpzKTLLWyrHZ0LEZ5mo5
	F3Q==
X-Google-Smtp-Source: AGHT+IFDKij6GqUhNl2/DRmDfo7qXWmYSb2Sa5UFVNMcbiS21Jx6n2f7TRhyYY1CL5jEng9qhM8rjfAven0=
X-Received: from avagin.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:b84])
 (user=avagin job=sendgmr) by 2002:a25:d8c9:0:b0:e30:c868:1eba with SMTP id
 3f1490d57ef6-e30c868200cmr12089276.2.1730350576189; Wed, 30 Oct 2024 21:56:16
 -0700 (PDT)
Date: Thu, 31 Oct 2024 04:56:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.163.g1226f6d8fa-goog
Message-ID: <20241031045602.309600-1-avagin@google.com>
Subject: [PATCH] ucounts: fix counter leak in inc_rlimit_get_ucounts()
From: Andrei Vagin <avagin@google.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>, Kees Cook <kees@kernel.org>
Cc: Roman Gushchin <roman.gushchin@linux.dev>, linux-kernel@vger.kernel.org, 
	Andrei Vagin <avagin@google.com>, Alexey Gladkov <legion@kernel.org>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

The inc_rlimit_get_ucounts() increments the specified rlimit counter and
then checks its limit. If the value exceeds the limit, the function
returns an error without decrementing the counter.

Fixes: 15bc01effefe ("ucounts: Fix signal ucount refcounting")
Tested-by: Roman Gushchin <roman.gushchin@linux.dev>
Co-debugged-by: Roman Gushchin <roman.gushchin@linux.dev>
Cc: Kees Cook <kees@kernel.org>
Cc: Andrei Vagin <avagin@google.com>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Alexey Gladkov <legion@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrei Vagin <avagin@google.com>
---
 kernel/ucount.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/kernel/ucount.c b/kernel/ucount.c
index 8c07714ff27d..16c0ea1cb432 100644
--- a/kernel/ucount.c
+++ b/kernel/ucount.c
@@ -328,13 +328,12 @@ long inc_rlimit_get_ucounts(struct ucounts *ucounts, enum rlimit_type type)
 		if (new != 1)
 			continue;
 		if (!get_ucounts(iter))
-			goto dec_unwind;
+			goto unwind;
 	}
 	return ret;
-dec_unwind:
+unwind:
 	dec = atomic_long_sub_return(1, &iter->rlimit[type]);
 	WARN_ON_ONCE(dec < 0);
-unwind:
 	do_dec_rlimit_put_ucounts(ucounts, iter, type);
 	return 0;
 }
-- 
2.47.0.163.g1226f6d8fa-goog


