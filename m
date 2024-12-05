Return-Path: <stable+bounces-98703-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FF5C9E4BA7
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 02:09:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3462F1881530
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 01:09:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3792A38DD6;
	Thu,  5 Dec 2024 01:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MzN2iVwo"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f202.google.com (mail-pf1-f202.google.com [209.85.210.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA69D14286
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 01:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733360982; cv=none; b=RoDXPmYbl3bIUubeWIH04aEuihICPHxRhsoBkt1ppLgtCKQ+Dof8y1E+Audeuc/0hrBZYdIBKU/6shloAqM7Q6jif4HxRj5tXV1Zr3pT+qRCZL0lsP50s/89cYAU/+A/9DiaD4Jm5zTqTsJ+MXPPa2z8J5i76Rmiv0Jlu6FKHD8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733360982; c=relaxed/simple;
	bh=fK8aXyugHxZZ2C2Y/zkgdBQLIkxLT4EIWlla4y/kXg4=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=p400tLyCezTrNPUvv9KpyftIpI9+r1b3sge4sAePQQqdMTWh+H6v8lMIUc5A781OOW5RUbNi09AHOjF7t33X0vVjpQ6MbrFafOBIL20z0yuLu9wI5xioN1CpYaax3BZXwPTx5dwSXRNJnoMttLUy0eyjGaYHyafxZGtmOsFTVPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=MzN2iVwo; arc=none smtp.client-ip=209.85.210.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Received: by mail-pf1-f202.google.com with SMTP id d2e1a72fcca58-724efa5d35bso343998b3a.3
        for <stable@vger.kernel.org>; Wed, 04 Dec 2024 17:09:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733360979; x=1733965779; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=n59Xnl6D50ylHiqQ1RjIxFw3EGEnTlwF1fv399YL458=;
        b=MzN2iVwoDcUaROIc8ynFpbFUanbanPTDBVR1TEXa0hZiH5b11HMPmmZTWCYSc+jkIE
         h+pc6VxhMEqRvbJTVUSmgTX+2jr1HIP77R7f8zxA5eDErDISEQSAfvag/8k5FJlx+AeC
         g2Zl8KlOQwuTZkNrFEozzK+D0UmgD7Y0Bb1/bmQIbeTRRG1LIkJPbhd9dO4hCUOczgDH
         OUdM/kkiA0IKItP7Ua5vVa1tcDHxBjv3eM2jcQ5pwAxUbHZR54Uz04JO+q3oex/bwEC3
         kIWi7twM7mXEq4dh92Cy2ioFpTFB1goxkSuaspZ99td1xI/bgHkgR/4caxMhbKIXjCcR
         3rgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733360979; x=1733965779;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=n59Xnl6D50ylHiqQ1RjIxFw3EGEnTlwF1fv399YL458=;
        b=jX8qsPHrkYksVggGAKyiCE6oWugSUpdxtvgTcu/YH/Th/glZ0hCb6NgWCukklXt1MY
         xevuyhFbomB5GniATeey2Uk02jk1GFeqj1MlRWDWF/dLsVfhHriz7uq7u80wQ6I0WErK
         4qjdiWymppmm+hXj3QGSg+oKbRvXBODbZEoUrOWR6USMlvZA4O29dTfdz/M3DzMxV3A0
         2SINhnzU1ZHK+ritZ3/9f0jwNq+p/FUdGffwfboicd+Z04yCQZB4haFE/c9xtW8mqZn/
         qo9/ZAdwgMHG1x/7r92VmpWlVaiW8KqFhptuOkt5Sjf4rx9Flq2PGMBMeSc5CcR9jdyF
         KueQ==
X-Forwarded-Encrypted: i=1; AJvYcCU1x2afM/WliT815Zmy9PHqUv+odUZLF3RDHejyROIn7q/ef66w8yu879tQBDTIV0GL/Ts1I9s=@vger.kernel.org
X-Gm-Message-State: AOJu0YzRtuSKCLpB56f9N70K4pfqKrKg8609Vc9cz0MR7NeQAEwRXoMH
	uYmQVtN0mEoVc1GQScBnSb+R9ObDR3JW/fIG1a+OZMlMZmNJL57QDexBis0OGWtuEPSks1d1+g=
	=
X-Google-Smtp-Source: AGHT+IG9q/7Y6jw7LO5D1bpEuo1BX4/QTu8OeJ5x0t6/Jsyxa1hzCp86q2jhrL5XYS6WhbIRB8FVkpXZ0g==
X-Received: from pfbjo4.prod.google.com ([2002:a05:6a00:9084:b0:725:9eaa:f2f5])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6a00:1414:b0:71e:5b4a:66d4
 with SMTP id d2e1a72fcca58-72587f00581mr9491823b3a.9.1733360979157; Wed, 04
 Dec 2024 17:09:39 -0800 (PST)
Date: Thu,  5 Dec 2024 12:09:19 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241205010919.1419288-1-tweek@google.com>
Subject: [PATCH v2] selinux: ignore unknown extended permissions
From: "=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>
To: Paul Moore <paul@paul-moore.com>
Cc: "=?UTF-8?q?Christian=20G=C3=B6ttsche?=" <cgzones@googlemail.com>, 
	Stephen Smalley <stephen.smalley.work@gmail.com>, 
	"=?UTF-8?q?Bram=20Bonn=C3=A9?=" <brambonne@google.com>, Jeffrey Vander Stoep <jeffv@google.com>, selinux@vger.kernel.org, 
	"=?UTF-8?q?Thi=C3=A9baud=20Weksteen?=" <tweek@google.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

When evaluating extended permissions, ignore unknown permissions instead
of calling BUG(). This commit ensures that future permissions can be
added without interfering with older kernels.

Fixes: fa1aa143ac4a ("selinux: extended permissions for ioctls")
Cc: stable@vger.kernel.org
Signed-off-by: Thi=C3=A9baud Weksteen <tweek@google.com>
---
v2: Add pr_warn_once, remove other BUG() call for key.specified

 security/selinux/ss/services.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index 971c45d576ba..3d5c563cfc4c 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -979,7 +979,10 @@ void services_compute_xperms_decision(struct extended_=
perms_decision *xpermd,
 			return;
 		break;
 	default:
-		BUG();
+		pr_warn_once(
+			"SELinux: unknown extended permission (%u) will be ignored\n",
+			node->datum.u.xperms->specified);
+		return;
 	}
=20
 	if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
@@ -998,7 +1001,8 @@ void services_compute_xperms_decision(struct extended_=
perms_decision *xpermd,
 					    &node->datum.u.xperms->perms,
 					    xpermd->dontaudit);
 	} else {
-		BUG();
+		pr_warn_once("SELinux: unknown specified key (%u)\n",
+			     node->key.specified);
 	}
 }
=20
--=20
2.47.0.338.g60cca15819-goog


