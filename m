Return-Path: <stable+bounces-98182-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8717D9E2F0C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 23:27:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EDC5165FA2
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 22:27:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 507CE208978;
	Tue,  3 Dec 2024 22:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="0l3qHT4Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f73.google.com (mail-pj1-f73.google.com [209.85.216.73])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC6051F890E
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 22:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.73
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733264870; cv=none; b=u9pEmk/NTlLXa/UPm/sxghjYya985mkPvsVAbssBhUC7mMNwt/C2X2nmLOAB/DyE6lgUzZtrFleCFBYBQOW4vn8bg9LvDpVQlgLU4xcnFwgnU0AVf2JzlpArewBm/kiq7iWjcqxOeRuAYq3MkRlwvPGAKt6MB5IY8C4qhRxSMR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733264870; c=relaxed/simple;
	bh=WNYe1o1E+sKTVbP6Ybjq1VDhGh2GpC/P2mbOJzZZqPU=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NEcJHrJURU4mV22m5VjDurhl3Hf9wmni5V7RoUBOTQ67UyYPb39SxcV40fhuLMHUfFkIkDW5fJCdZqRuGHwxLHPwVagWsf1tKexhaelM0qaHUAqJ/YLOvVFQhJQpWhkbMzm4NfkLjmGWcPMrPLrKvMul1BnIepfgiLMyfhIoB7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=0l3qHT4Y; arc=none smtp.client-ip=209.85.216.73
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--tweek.bounces.google.com
Received: by mail-pj1-f73.google.com with SMTP id 98e67ed59e1d1-2ee76edbb51so4222237a91.2
        for <stable@vger.kernel.org>; Tue, 03 Dec 2024 14:27:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1733264868; x=1733869668; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fvqSApl58CYFy0UhTS9HgevMdMxy/zQMiCldsU69za4=;
        b=0l3qHT4YCdXOJ+uSQuhuIFzlUyFljYEOi7NJuqg5sp9Npi9FmjtGfbJrhGnaVehhnO
         M1jmL9kusIuxMgoGFxZATHuh9ZWz09FEkB2SOS8Iw84H0oqASq7qMliHYmw+Ss1iUb/j
         g681A1EQHM3vZeNTYcHcARPw5Zlh2PY6drRHVIjdezrc/YB1QIzyEXCpT4N0xRVUvk63
         HC7kV62RmmOVajqKRej409q3+5p0M30aFNAa+Ovg14dnD9OOSOlyPg1AMnKpyjNiA0rY
         jm2JM0IsDTW7fHl94RPpNPFEkIl0J15Q+gjRjvsAwus3sdL+4oivFuXoC+Ygxd2pyxIo
         7m4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1733264868; x=1733869668;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fvqSApl58CYFy0UhTS9HgevMdMxy/zQMiCldsU69za4=;
        b=w/iUMb/kLvMLpuG7ip7u15vDs8Vw8GW1KwcBGStiS/BenFICF5QHlmu0RjhyBkPbpE
         6iZeJ+avOFgXRx7wQanVtH1RUhPz3w5tZ+LMxTxAjO5NsXc5dn+lhKKb1L/ooJi0ZHM2
         lTFs3VyDnNXSkpwhFiGtDskY2Cch470Tpa/w4EmXptvttrpH8EU00ZoagDZldWkVHiMy
         zqxbXindhYa+9pLFxCN2efIBwPyu9wDolzstQAAUlp6fcd1a7fb7HUFYeeTlIfIkOtV8
         4adZAYrGcfKFKI+07/iQNyXd62cEaoFwjgkm7Q+z1wXlxRyuqG+eRxbsA17nrAACYCvB
         9ePA==
X-Forwarded-Encrypted: i=1; AJvYcCWy8AnWpOmR+O8psDJ4Cs+pJ5hl/3o9a03OT2OY8c6GmrHVDfz9fQHppj9ajKfq6cWqY9yBACk=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXXBpcUJbEIhj5dNZhOeFFnd5SqRVwxItS26ikyOjJH881ZWO3
	AlV+F2W+nOXl0iWnmScAidjfycsg9Eva6KKrqYaUzld2ufpEh3Cm+uISMXF6Hdv37fx/gE1F/w=
	=
X-Google-Smtp-Source: AGHT+IFmeN3P+Vylk2gC4lu4YM2dsQ/SnGCyQUe1nX4+5lJDrCUCxHnsjQodefPMSy+q41o9EjTjTXP7nQ==
X-Received: from pjf15.prod.google.com ([2002:a17:90b:3f0f:b0:2eb:12c1:bf8f])
 (user=tweek job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:390e:b0:2ee:c4f2:a77d
 with SMTP id 98e67ed59e1d1-2ef0121557emr4759165a91.21.1733264868061; Tue, 03
 Dec 2024 14:27:48 -0800 (PST)
Date: Wed,  4 Dec 2024 09:27:41 +1100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.338.g60cca15819-goog
Message-ID: <20241203222741.1739916-1-tweek@google.com>
Subject: [PATCH] selinux: ignore unknown extended permissions
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
 security/selinux/ss/services.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/security/selinux/ss/services.c b/security/selinux/ss/services.=
c
index 971c45d576ba..2fa8aebcb2e5 100644
--- a/security/selinux/ss/services.c
+++ b/security/selinux/ss/services.c
@@ -979,7 +979,8 @@ void services_compute_xperms_decision(struct extended_p=
erms_decision *xpermd,
 			return;
 		break;
 	default:
-		BUG();
+		// An unknown extended permission has been found. Ignore it.
+		return;
 	}
=20
 	if (node->key.specified =3D=3D AVTAB_XPERMS_ALLOWED) {
--=20
2.47.0.338.g60cca15819-goog


