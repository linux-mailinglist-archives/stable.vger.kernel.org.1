Return-Path: <stable+bounces-50184-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B0C8E9047EE
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 02:11:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9E340B238BB
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 00:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FF38382;
	Wed, 12 Jun 2024 00:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b="jv00Z7rX"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B3AC197
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 00:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718151060; cv=none; b=rEJuwHz1CjG7R3hKjC8HPKDTYOAR1CBoTsgWJvNm6IH9tELq9yVvbwTi+OdV6oR+f/ycRpa95kO/X+K0tKp2I7YSCTwEImh9psgpZZ+4uDvNWYOecTfQ1NCBJ4avG8kyHVaz9HxMU9vmujdB893tLCb8s9QpJsphHruDrcPYq2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718151060; c=relaxed/simple;
	bh=yA3GemOLta7ptddMW/7rnk7IdpnukaO6SkrLIQz3nbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=cqAx3iPnrT8rrQdc+Jm4MR5C9O41kTMpzqlKQtGjk3GzlMXSVp9aLDnK2arADcMl1jPDLTIM0ZsE7u2DvSFHn2wnFHFMC8f834ocDlGuzIHGFAxNeewJ2XOnH3h2Gcf+tFEu7Ek44bMwokQ2qoIvPhjPAT8THWKn67zH1/lXVtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (2048-bit key) header.d=canonical.com header.i=@canonical.com header.b=jv00Z7rX; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com [209.85.216.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 912843F2A1
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 00:10:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20210705; t=1718151050;
	bh=yA3GemOLta7ptddMW/7rnk7IdpnukaO6SkrLIQz3nbM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version;
	b=jv00Z7rXmMaB0IN49bfULAKzmdiXfaoKIcZwFbY2xWZDGy7PEaunOsHeXr4ZsNb9F
	 uHBHXbvYAuBLvuNbVPIgoTqpNNjDbI0VRS1YF86XHyCr5xaQoF1/kw64tfXDmZrW+J
	 Sf0x54oQb/hdKoGyHc98GAQgPWaFDgaF7Qy3Mdjv62+9Z2GHeAfInS+mCWqzKbpJoz
	 lPGgqFajaggWlmFQcBy//hpuPdWs94iTTES7nIQ6WoQC/PfTKhzSeutxqemj8smgag
	 HK37T1j3i+RdIskEwy5tMMaAAqu+uHRF0i8Cx76v0kG4RPzWzBajxKx0a7U6l3D9+1
	 wliTdKOFN1nRA==
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2c2def267dcso3536659a91.1
        for <stable@vger.kernel.org>; Tue, 11 Jun 2024 17:10:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718151049; x=1718755849;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yA3GemOLta7ptddMW/7rnk7IdpnukaO6SkrLIQz3nbM=;
        b=ODo0tbV4E8gOAZzSNjYLpdf3U3M7mtuuFsRooc3AAE3SVrOD8/5JNGrJ1C+MdxOLTZ
         lZePQfNcl3i6JA19A6Lf0INtRTCMwwqPHof72U3XRyG2/BJGCrtY/kpIR0CqFwSwKTUT
         4qUROj3MQblx/IGDr3YekaIDu7/PV2j9z/KpKZl/7rPjOolc4LJT3072TMiRoPISpCRq
         IExd37REqZMMhWkGwUy7zYib5hIDMsVUlGsRpgY5pBlv/MVbn8fh39xHUu7e90TGqhPA
         7qeKQZ4nGnZk8yBO9lJ5trDDbBYBdZBqNofQLOEuwPMov61r095YMaehbiJ2n+EQLLl3
         SsRw==
X-Forwarded-Encrypted: i=1; AJvYcCXiZJHrfV4WlTu/TRlZ2L3t6tpQ//tNaZKWjFMRoMOveFjuO63DkbcRl/UyzgRKQfFn8fn7v2WjZ3IL2YJrba0wiGbQODCL
X-Gm-Message-State: AOJu0Yw8PRLTNmZhuRRdK01/eEJQT0Kvsqdmr3mbi8IJgoOUaqalAEMU
	Jn7iL4TVL2panxNYf6OMpqJ/4ESarnv85m9dIHbXEobi5POi7Uoz5BTbZpeSNHLlYjaiMMNpTnl
	FXT7gW/SXqZe7wjaTznwVTGnFo+MC34K2BANhqK8DwiniYSnSRZi67cNs8Ln1ogOufZwKdF/1ib
	FHBMFj
X-Received: by 2002:a17:902:db11:b0:1f7:e32f:f067 with SMTP id d9443c01a7336-1f83b6eacfemr5651165ad.50.1718151049187;
        Tue, 11 Jun 2024 17:10:49 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEtrQz+Z+est4OL6JMDV7Qe9u9duB8be/MwTdrnQYsCLYsrV7LoeCf5ZBBuNVwo06AB7Snq9g==
X-Received: by 2002:a17:902:db11:b0:1f7:e32f:f067 with SMTP id d9443c01a7336-1f83b6eacfemr5650975ad.50.1718151048830;
        Tue, 11 Jun 2024 17:10:48 -0700 (PDT)
Received: from ThinkPad-X1.. (222-154-76-179-fibre.sparkbb.co.nz. [222.154.76.179])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-1f71ad56202sm38921265ad.276.2024.06.11.17.10.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jun 2024 17:10:48 -0700 (PDT)
From: Matthew Ruffell <matthew.ruffell@canonical.com>
To: w_armin@gmx.de
Cc: Alexander.Deucher@amd.com,
	Christian.Koenig@amd.com,
	Felix.Kuehling@amd.com,
	Prike.Liang@amd.com,
	Xinhui.Pan@amd.com,
	Yifan1.Zhang@amd.com,
	amd-gfx@lists.freedesktop.org,
	bkauler@gmail.com,
	dri-devel@lists.freedesktop.org,
	gregkh@linuxfoundation.org,
	sashal@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] Revert "drm/amdgpu: init iommu after amdkfd device init"
Date: Wed, 12 Jun 2024 12:10:37 +1200
Message-Id: <20240612001037.10409-1-matthew.ruffell@canonical.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <fe03d95a-a8dd-4f4c-8588-02a544e638e7@gmx.de>
References: <fe03d95a-a8dd-4f4c-8588-02a544e638e7@gmx.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Greg KH, Sasha,

Please pick up this patch for 5.15 stable tree. I have built a test kernel and
can confirm that it fixes affected users.

Downstream bug:
https://bugs.launchpad.net/ubuntu/+source/linux/+bug/2068738

Thanks,
Matthew

