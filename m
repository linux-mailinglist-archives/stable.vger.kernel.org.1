Return-Path: <stable+bounces-198202-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B7A61C9EDFF
	for <lists+stable@lfdr.de>; Wed, 03 Dec 2025 12:43:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 643844E495C
	for <lists+stable@lfdr.de>; Wed,  3 Dec 2025 11:43:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5EB82F1FEA;
	Wed,  3 Dec 2025 11:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="F29uoVtw"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f228.google.com (mail-qk1-f228.google.com [209.85.222.228])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 138C22F5A02
	for <stable@vger.kernel.org>; Wed,  3 Dec 2025 11:43:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.228
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764762207; cv=none; b=J31pwNPRaeUFiPkk4/wl3oUUEfg6uQI8s53I/Ffm49HF1rSGLT4lBOkf+hDRW3/LMS5+LSFEgiF6ORvfBvKNIBiI46zXFSB21g3hPBaggJHg0oGlBM3RP7425/fDnWQZoZUsQjUKeR2U1HibyjcXYF8uwPHE2o/PtxwEMAxm3mE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764762207; c=relaxed/simple;
	bh=jHvcw93pij0zT9T64vqa15EoUwp17wtdheQYlCkPZdk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=oV46m7FcN/hvZpokJBDZuBcYckiob3AZTmPMwo8NGdW00BtsNkaP3BM5VamflcmNaHNFD3997ahJohJosG2EdZblmMNeP5DZJRMG0nwTuDyRxihPM49GMSHt01UvxPDlaYC32w058gI+B6oyKQdGenZAw+SApZWmNTEV4isuzzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=F29uoVtw; arc=none smtp.client-ip=209.85.222.228
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-qk1-f228.google.com with SMTP id af79cd13be357-8b22624bcdaso759442085a.3
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764762205; x=1765367005;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xfKxGcIt7PpDGlUMG/YhMtCzZ0SJhEy//FNn25168d8=;
        b=KGPft3k8Ehs/7WGRKR/qJlJXozV+IdHTb7ohtDSuWy28ftdOlfW4u5ulMFfIaK0NJR
         vY1XRb1fItIc0NzN7f3LrbG0HZOB/Gg85LQn8EdYpiCxUPKwU054L4eOoX8G2IKNPf0+
         gORuZC4ObrN6e6uk4tnQdyDUIdHm7OYCQR++H5yhNfS4Um5VsXVvE3FQ5CrOerg+s9wF
         C3JE4yfmLvpc+Ji75PSC0SmFyKeEy/QU+G5k53Xzd36wmnpWb9i3LLPoLAMCBJRGcPwt
         J9jZZ9AJ6+5P+YeLglOqJ8u6884dqdxmDwdg1Cc5vRzBfSF+MCSXTuChJ3mMFKnuVQbf
         02+g==
X-Gm-Message-State: AOJu0Yyc4+v8vmsNwqxqFyaTevi6rZbpz8CklY8NFbhWuapy+f2+x/ma
	bepuadPTBo12EqR4FChybUuEVgJafNBPI3MF+o36+lWkaqB6XY+QoW4O6Hjjd3AFf8sB4+hooPk
	6jNwJnHmlnByePH+SaIDgbANBe8QP3nTdNwdouor9n/Y8UrKaPMroRZBA56g6P6a496TVbDXxnv
	0awnul+rP6Sft5DP9qzui2snI4myaH0IqbjX6PumJ6lmtJImXF9roEOEmzTZJttP1aC9zAWnKlT
	Pf7SLK1UI4=
X-Gm-Gg: ASbGnctlNh98Rbck//yVVp0yEeMeMSAIEOmp8B4Oed3ATf0TgGk+DXiJgtHC44Yiczg
	pm1GV6YVjTtUtN0BsupMzFEI/hCyT5KcT+JPTuiJKpziPVjXV5etXJXJis/KZ7ozDaXyqvTmTA6
	Bgkcolsg1XYwH3Wh58x3dCu3ESdRtUGRPY5qURZho4NUeCxVAdeJm0y04/08w6x5u1iDXIeMhEe
	vk7jePVbDxzOg8W3+PCYYt12mTcyiCRrj0G94O2XOpJHtiBGteGPAnGo75fFBUhqtgYfSzYJslf
	gIWjmfiGMDIg1RUnPDALIsvsJo28f5/rfI2Ba0AFeArLZDqLNC1apxO6LqflF137NEFFZNez22z
	P6vls2KHRjxJF1PwTiD6I+nZUYG9mtSYCQTYZRRyty9kwOTahCZnEv/ARsWRvClwHEJpHOQYJVB
	wNeGEzQ0L2K9Tb4BFD1pTH+bHYg4w9jYawWiHJNVOrWQpf
X-Google-Smtp-Source: AGHT+IFVPDvJwqRZytMgpxUtOEACaU8KNroStYTObnuCd4or+1ErrFSdBUr067chp6kAV60TsJCno5y6SO0c
X-Received: by 2002:a05:620a:4094:b0:815:630d:2cbd with SMTP id af79cd13be357-8b5e47d32e4mr237971985a.34.1764762204955;
        Wed, 03 Dec 2025 03:43:24 -0800 (PST)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-117.dlp.protect.broadcom.com. [144.49.247.117])
        by smtp-relay.gmail.com with ESMTPS id 6a1803df08f44-886524c9db2sm25249016d6.12.2025.12.03.03.43.24
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 03 Dec 2025 03:43:24 -0800 (PST)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-8b22ab98226so1923813485a.2
        for <stable@vger.kernel.org>; Wed, 03 Dec 2025 03:43:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1764762204; x=1765367004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xfKxGcIt7PpDGlUMG/YhMtCzZ0SJhEy//FNn25168d8=;
        b=F29uoVtwFhVoBVgII1+/c89WtTo6Gk1tfsKbmVpAZXrEN1eDOTaOjMdrCLo5vKmeD9
         sBzn04Gxntg1hEv+/gseInvYI6BjIz36+kgRBumbO0kWGcTeY7rmfsZLOVy6srCLAJaB
         I9MF2YjgzYgezv7/vU4AlC8KWtJ+rC3JW0oCk=
X-Received: by 2002:a05:620a:4728:b0:8b2:eea5:3311 with SMTP id af79cd13be357-8b5e47d1cf2mr251570385a.26.1764762204256;
        Wed, 03 Dec 2025 03:43:24 -0800 (PST)
X-Received: by 2002:a05:620a:4728:b0:8b2:eea5:3311 with SMTP id af79cd13be357-8b5e47d1cf2mr251567285a.26.1764762203820;
        Wed, 03 Dec 2025 03:43:23 -0800 (PST)
Received: from photon-dev-haas.. ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-8b52a1b65bbsm1284727985a.33.2025.12.03.03.43.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Dec 2025 03:43:23 -0800 (PST)
From: Ajay Kaher <ajay.kaher@broadcom.com>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: mingo@redhat.com,
	peterz@infradead.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	linux-kernel@vger.kernel.org,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	yin.ding@broadcom.com,
	tapas.kundu@broadcom.com
Subject: [PATCH v6.1 0/4] sched: The newidle balance regression
Date: Wed,  3 Dec 2025 11:25:48 +0000
Message-Id: <20251203112552.1738424-1-ajay.kaher@broadcom.com>
X-Mailer: git-send-email 2.40.4
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e

This series is to backport following patches for v6.1:
link: https://lore.kernel.org/lkml/20251107160645.929564468@infradead.org/

Peter Zijlstra (4):
  sched/fair: Revert max_newidle_lb_cost bump
  sched/fair: Small cleanup to sched_balance_newidle()
  sched/fair: Small cleanup to update_newidle_cost()
  sched/fair: Proportional newidle balance

 include/linux/sched/topology.h |  3 ++
 kernel/sched/core.c            |  3 ++
 kernel/sched/fair.c            | 75 +++++++++++++++++++++++-----------
 kernel/sched/features.h        |  5 +++
 kernel/sched/sched.h           |  7 ++++
 kernel/sched/topology.c        |  6 +++
 6 files changed, 75 insertions(+), 24 deletions(-)

-- 
2.40.4


