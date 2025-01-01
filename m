Return-Path: <stable+bounces-106635-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 31ACB9FF539
	for <lists+stable@lfdr.de>; Thu,  2 Jan 2025 00:49:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0175B161524
	for <lists+stable@lfdr.de>; Wed,  1 Jan 2025 23:49:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 726CF76035;
	Wed,  1 Jan 2025 23:49:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XuHrS3Jr"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f74.google.com (mail-pj1-f74.google.com [209.85.216.74])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3444014293
	for <stable@vger.kernel.org>; Wed,  1 Jan 2025 23:49:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.74
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735775377; cv=none; b=Bu8GoROdOUb5pEfn7TVfVGqOtI2j3eYw3vzgr4+90Vup7EP1164OxfwFpf21SMeZAbuODiNsL4S9SwVV8xUO26Qk0EMVjvcf00wfBQt65dJ0xSEA3GMQfek7iKAMXVzHPEh61ljFSMs2OsmIXz0J262WeB8V1wmiZdaFY2B+z8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735775377; c=relaxed/simple;
	bh=0ifGb4dHYX7F/coxD3uUGV2VHVJYQVs4a64yKYZvhUA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=VdYZu2hQPMv1b+6ob0Fb+jUXX1cE8RmQdoJv9d263HbfjT3ehAFuGqrbR92cVcQmKaZmj5SO9NacBRtqcBEzPf50LyQcW1R1GdxyXhpVgVxST11yO2mB7KdKRctYR3c4g6pYXsBZNF6HeXrUzrlxe58ztBjpYyX+JwO1QNb+uiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XuHrS3Jr; arc=none smtp.client-ip=209.85.216.74
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Received: by mail-pj1-f74.google.com with SMTP id 98e67ed59e1d1-2ef35de8901so14489720a91.3
        for <stable@vger.kernel.org>; Wed, 01 Jan 2025 15:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1735775374; x=1736380174; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=viNudoDuQ/WqSPcEHxsEzLChPLqgUbZV1FHRz5da8nc=;
        b=XuHrS3Jr6bjf7kdAQKUAdJ8AY8smfDD0CfT1NSzTk/IDvToupxmEZfo6SLltS9VWqb
         n4wJRLFUkpt6788B4X8fRl4JT/dNTfbOnefhoYWICQ3+wrXLKzAuM/Xcq43vR48H40cp
         LirYc2sLFgukjxJWqodKKGYIk107yFysmmu/SliWCk15QTNFOubop4JKJbBYPOcHFr2/
         oLzrN0QUA6+Tvh5UOLodi1nnr9gypZn36ZjTlN5XcwR/5lgLvILwWAIr+mTCIHZjltdc
         gnO71qGYNyG4Cl0CzngvYKd9gKIyLnKHzXIQt+jvANiKbbEDDU7HFbYcRyOvdd9E8heh
         iSfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735775374; x=1736380174;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=viNudoDuQ/WqSPcEHxsEzLChPLqgUbZV1FHRz5da8nc=;
        b=hK/ixKgFDcyldwaSO3fxStBS9SExBc3nQhmN11tzSx7nbylkFgyYCeJyoPuRU0fkOw
         jWpE4ElFtn/7XcghSolWKuyhGr5e/Jj+5Xem+ezz3bb+S5hVOOaollgx1+8OOeAJk/vu
         PIsXj0ZPmVW83bI22+MdKTmvWhptJOZds/sSHPGWHE5HQYk1RG0IuYitaYATH/vbGaYE
         aVob1wIEf7pQEbsVuiwe72VIMmkjT0Lq6KKONsHKppTBpW3LpUjDu3nIIWArCqB4B9Ns
         TbvaSErf0fsBY+qwC3OaKETH3SSJPU7H034d6RyrmJGBep37xHsOw0PtowmvSsFTGPvD
         9AnQ==
X-Gm-Message-State: AOJu0YwU41ZuL3bHC4RLnRyjU3NHEknP4Xn7Vn/hFFhpzvjcbhX0ypTO
	8jF0iQ3iBQ9gS8IDNe6oSCDAJDwYU0saE335Me1bis/jwC5LHN4QPAo9hljjQfouOU562TtagpH
	kiDoFHxvmRUznEfq7t9giCtUaHCNuuOZEBF0+H4enmxb4GmMbHxUuQhxbX6bYIxEi5VoaJjPEgl
	LM4jc8RDlVVJaVIhDdNte0yj8525c=
X-Google-Smtp-Source: AGHT+IGy5EuD8dZJmIgLuVXglsqCi2aCfdJ+Zx96K0I5biIkAUS4u3/p81UomC05vP3CM/kBnbnhgvDTJQ==
X-Received: from pfbcm7.prod.google.com ([2002:a05:6a00:3387:b0:72a:89d4:9641])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1411:b0:725:f376:f4f4
 with SMTP id d2e1a72fcca58-72abde01aa8mr64862241b3a.13.1735775374272; Wed, 01
 Jan 2025 15:49:34 -0800 (PST)
Date: Thu,  2 Jan 2025 10:49:03 +1100
In-Reply-To: <2024122319-risk-starlit-ce4a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <2024122319-risk-starlit-ce4a@gregkh>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
Message-ID: <20250101234903.1565129-1-tweek@google.com>
Subject: [PATCH stable 5.4 -> 6.12] selinux: ignore unknown extended permissions
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: stable@vger.kernel.org
Cc: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, Paul Moore <paul@paul-moore.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

commit 900f83cf376bdaf798b6f5dcb2eae0c822e908b6 upstream.

When evaluating extended permissions, ignore unknown permissions instead
of calling BUG(). This commit ensures that future permissions can be
added without interfering with older kernels.

Cc: stable@vger.kernel.org
Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
Signed-off-by: Paul Moore <paul@paul-moore.com>
(cherry picked from commit 900f83cf376bdaf798b6f5dcb2eae0c822e908b6)
---
 security/selinux/ss/services.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index a9830fbfc5c6..88850405ded9 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -955,7 +955,10 @@ void services_compute_xperms_decision(struct extended_=
perms_decision *xpermd,
 					xpermd->driver))
 			return;
 	} else {
-		BUG();
+		pr_warn_once(
+			"SELinux: unknown extended permission (%u) will be ignored\n",
+			node->datum.u.xperms->specified);
+		return;
 	}
=20
 	if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
@@ -992,7 +995,8 @@ void services_compute_xperms_decision(struct extended_p=
erms_decision *xpermd,
 					node->datum.u.xperms->perms.p[i];
 		}
 	} else {
-		BUG();
+		pr_warn_once("SELinux: unknown specified key (%u)\n",
+			     node->key.specified);
 	}
 }
=20
--=20
2.47.1.613.gc27f4b7a9f-goog


