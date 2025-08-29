Return-Path: <stable+bounces-176689-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 895ABB3B601
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 10:30:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 585B0561A03
	for <lists+stable@lfdr.de>; Fri, 29 Aug 2025 08:30:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1FD3225417;
	Fri, 29 Aug 2025 08:30:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KsejlunZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4240B2629D;
	Fri, 29 Aug 2025 08:30:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756456224; cv=none; b=FNOYtEmRSlMX/xA5hBoNJqMsQGZEKSpD8kQMyLPMijMLqs7umLgtLzU8YE2ka1Yq5QywM67w6t50WVOsMdW35hyPo/Z2RVJpG8jftxJVjAEXNX5G83nqngX2ASl0pExsxjQndu2H00zy8qRN+qp8LGOLP4I7ompegymH3pHdlMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756456224; c=relaxed/simple;
	bh=fmztinXNGZoFyDM9iQimoe4sUQp0ILd71JgU+IBaAck=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=B2BAWRNcKcfYs1LcornWSY66uMILvuDXk4aIJ5raPwkCO5PjY/IkIhiGy0/Sm0UN38iM2jo7jabKpzRVRqKCP82Qx3c35e6ySYx9fOe/pF3XE+We6qQE029I7kCcrNaSILyCNQ2X7Pv8Ss4nTIeYmB4Ygo5UV4XtPpVO0I9dSSo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KsejlunZ; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-b4d1e7d5036so179865a12.1;
        Fri, 29 Aug 2025 01:30:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756456222; x=1757061022; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=wUFkmc/x2ufMRoDkDhwet0rnXo3rgvzLQTvAmQ/ZxPM=;
        b=KsejlunZCf9K5DwrQAJu6S53GsJ7+DisS51fKBJ+81/7cPSqeA7CoAqvf0Q2Nj+u0R
         gfRs1w4XS2VEUv7Ulfp6qBKAbWzQkb5jYM6BHzISbzzhJU0htuVHmG5tB9yVZ+mSq80r
         iN7LI05jg4uBRfgOWLMTDFIJZUl9VOpq0lqhaP+nXc2XvogMdGuWIUKKP6MO89PR+CmX
         nfNki7jlCBA9TvnXfzLNQZLYuwjrzLqwdpf1qSRhrWVsdr3webkpn5/Uxig0IkqBxXqg
         WON0dLhk2zZzwkiOvnDI8tDiBoz+DVZwBzW+2Pg3vDllkzk6n0cKXuzRqFmtbCEWzF2w
         iLEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756456222; x=1757061022;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wUFkmc/x2ufMRoDkDhwet0rnXo3rgvzLQTvAmQ/ZxPM=;
        b=uCr1IVB518mnx9tCqGmqeSKokSaC6Zr/mTUzSkb+e1mOiI6mvAXh88RT+BMMj4/crQ
         7xEf9IKf4gIvQQcu9wqv/gYycWf8tEBrPgkYWssC52Kt45ZbWqVuXw4zI69Xwt+lP4Da
         P6JqWpjmdx4jnHlbgJA7Evn7H6gw8gF2TUauCKiK4j1H377EQZP3ADXq+VUUuyjBf8Dj
         NGEji629Iw/D1MuzPCVMaJXxzLAAw1WTpgbw7g9V7ErWPYkiKqhHbzrSn5BAX5QFG7SJ
         EbcmyYaRmp0mJxQQw5KCr0DoPjG0dIRkqV/R0stpNKmclDNydFb9DxX8uqvHy7L552bP
         V1FQ==
X-Forwarded-Encrypted: i=1; AJvYcCVk9ICK/HrAlZuiBGqM57OXbfjzK6QtgLb9EHazELycJKEm/Z4KEJ5VMywwvsqxTinK7dslmm4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzHWyLy87cJmSQZ8OVO8W963JLNLb/AShneNEl7thKxVi4wTeYE
	1/hopWKaKh3IGUJBabIRVTKfhIiEnvdt3xtDwCSHLoZW1Aoj4x2Jap+f
X-Gm-Gg: ASbGncuzc06lLtSVFSHrstFfCfdaNZb/65X0HfCX8E1PTpIuzs0ChPB9ZnceuNeR4bF
	ajDzTluPMq3Jqfv7xfcu9PM1Sv33VLWUFk3Aqs6Kb1aZh+07eFVuI5vegf8kTFTslTk3NJbiPxO
	qp0WQ2P+RKQwFxaz2M1O798Abfdp8/7QeKZr0045E6zFYXaMG/ChDAivwArRajaVqzlbgMQ5vZT
	QNK2OTHVbKQWm7JcBwwPAHcrrNMUbHQWpDBWNn3XaJVwYECmXffiWzDDwKPwqZodbhwTI9d/65c
	3ulN2jEd/a4IjVnFIfjNqqF9qKTaVJKyouh+n+DW7GigolNUa7QIPecu6pKR/Do+klwt0C06mvm
	u6on5qnMq8Vu6+Tc+tLCzWg5h6EC82Tn4TBGRYVvViDajECpMOcU+OxivJpcO1GUFvd5nwHLnAs
	mkFyx98ahZ/bzSgVX93hkl7Fjz+q6ExprOoCL/UYJHydvI
X-Google-Smtp-Source: AGHT+IFy6XSrFwHA3q5MgaSXaSW7U25H3wu7AFeipRS6C0qM8v53NULMWlW/+QJoXG7hl/ZwLuWNDA==
X-Received: by 2002:a17:903:1b06:b0:240:a559:be6a with SMTP id d9443c01a7336-2462ef4446amr356429315ad.34.1756456222497;
        Fri, 29 Aug 2025 01:30:22 -0700 (PDT)
Received: from vickymqlin-1vvu545oca.codev-2.svc.cluster.local ([14.22.11.165])
        by smtp.googlemail.com with ESMTPSA id 98e67ed59e1d1-3276fcf04b8sm7511108a91.26.2025.08.29.01.30.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Aug 2025 01:30:22 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: chris@zankel.net,
	jcmvbkbc@gmail.com,
	linmq006@gmail.com,
	thorsten.blum@linux.dev,
	viro@zeniv.linux.org.uk
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] xtensa: simdisk: add input size check in proc_write_simdisk
Date: Fri, 29 Aug 2025 16:30:15 +0800
Message-Id: <20250829083015.1992751-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.35.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A malicious user could pass an arbitrarily bad value
to memdup_user_nul(), potentially causing kernel crash.

This follows the same pattern as commit ee76746387f6
("netdevsim: prevent bad user input in nsim_dev_health_break_write()")

Fixes: b6c7e873daf7 ("xtensa: ISS: add host file-based simulated disk")
Fixes: 16e5c1fc3604 ("convert a bunch of open-coded instances of memdup_user_nul()")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/xtensa/platforms/iss/simdisk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/xtensa/platforms/iss/simdisk.c b/arch/xtensa/platforms/iss/simdisk.c
index 6ed009318d24..3cafc8feddee 100644
--- a/arch/xtensa/platforms/iss/simdisk.c
+++ b/arch/xtensa/platforms/iss/simdisk.c
@@ -231,10 +231,14 @@ static ssize_t proc_read_simdisk(struct file *file, char __user *buf,
 static ssize_t proc_write_simdisk(struct file *file, const char __user *buf,
 			size_t count, loff_t *ppos)
 {
-	char *tmp = memdup_user_nul(buf, count);
+	char *tmp;
 	struct simdisk *dev = pde_data(file_inode(file));
 	int err;
 
+	if (count == 0 || count > PAGE_SIZE)
+		return -EINVAL;
+
+	tmp = memdup_user_nul(buf, count);
 	if (IS_ERR(tmp))
 		return PTR_ERR(tmp);
 
-- 
2.35.1


