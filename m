Return-Path: <stable+bounces-184122-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA507BD1169
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 03:25:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D33454E5735
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 01:25:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B4222157B;
	Mon, 13 Oct 2025 01:25:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TusayYQL"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A01C34BA2C
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 01:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760318708; cv=none; b=mz4DEKeBbM5ZIun95tANAOJFj96MTDyR/Z3stayKD/aZYm+m2sMFSM3lalMMWal4s2xH0J5rBfjVl0X+YWx5j77v5AjV6Ipe/sBLrrIYKIdvwExNn0AaCeBRpn45qxeHKku6jg2RldMACDAyRHXz2zBSClqTDRqVqj6dU71QiQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760318708; c=relaxed/simple;
	bh=J4Yzb9iZ9EpboV9biYUfsNSETmRqq2TmKs+QNpM5zWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Y8O2cffWq4sLQln1ki/OubaU7f10LSRmzaPpWBeM3yb/6PsbonJQQwt5Ls7iMggN83Ehx//zTyc+RBKXnL371oCnppQ+ehocwuM8r+4Dmk6pmgH1Ef2TNqe47RnAOi4wXP2kEV49dxixuSgXzrcweuTv2MAIknX5eGsf1TXIRq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TusayYQL; arc=none smtp.client-ip=209.85.210.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f170.google.com with SMTP id d2e1a72fcca58-7930132f59aso5051349b3a.0
        for <stable@vger.kernel.org>; Sun, 12 Oct 2025 18:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760318707; x=1760923507; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XzRaVDpvVh3GxyQKpxmp+g1qh+O73uHDOdF7bHEjts=;
        b=TusayYQLr6ULJS5hqKumYA+q+alOoLMWOlTssjXTV6KTrrmA+F+HqMqpOWAFLJM4WF
         JjwBy19VBV9/HmLvnIIdY3Fe6EXdilg7Y4tZQhh1sOHOoeAwojKGMg3cnnnh/F3fBsZR
         K+0JtJOTsieTYeeYqq6B7F9zabKQL6r22EjmPBTNcaNCVmK7CWKHptr4+1GM7s5XPj4h
         cf8wkswjWGSuI02nies9jnnaDN+ywDQoXushFqGCHd5wPXyJ1n8BhlLzro48Urxje6Dj
         0ANXdd0sNpRJ06KWcbJ9UJuz1w8gpkIogMKlx6M8TjJ5Hg+C3q0ApOTco8nuX0vY8lZx
         nmVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760318707; x=1760923507;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XzRaVDpvVh3GxyQKpxmp+g1qh+O73uHDOdF7bHEjts=;
        b=ed0VioAH7vhqDg+sq4sq/AqGwqwe6y/qPsbQvLBQCQxECIRzuc4WY36po18aWS4wOi
         2FlPjtoZSJVtuJ6p5uwLO2TfS6a9V06mwCI2/O4RdrF1VfyphTxGuUp5RJHPyzEsD6+0
         85V1qlpOQh7eCFvEoR3LtZhkRDTm5a0HXWnVUUrUDRCvDRQ7UWAqse4oPNPok0JQORaQ
         7I2nCxlYLOHR4itA+VfJ/hsl8xdE9/RjylaKMb672MQ81xzOekHhxP0YFs5F6l+FNb/8
         KyoTUEzHql4V2/v8DW16Wqi8o/CtjIKyKcJCCV9EeFTcNrLUPMUYKdqZ17hvI4IZi4pG
         cm9Q==
X-Forwarded-Encrypted: i=1; AJvYcCWuY2/QrfHSTSk025lkQH4rJ1k9x0j9mUdiGR9WZ25W6Cw2A23BsrPoo/sARpESHFL2TN+GrOg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzqtbuoFeUqV5Jpd5N0k3m6X/PZxtYtz9+O79mlcbGe1kFwCwfE
	BDcQgU1Yx4PZZ3uetStvG2ys1Sjs97mWd97iLuqCFwqvO56ScZAZaS37
X-Gm-Gg: ASbGnctsf9ten/gzxSoGpvAVz2LnqvwyK4NPS/mzMzfo4XKl/zbDZksH1Xn3mWs4/XS
	b/HjqfhPSjrYIYYUOWxhej1CR/biRfzdjz5OIKHKvpkwma1wfg/HpN/fPL52/Ux7VkXL5VVZvoi
	OpmsleKb02IllKogmyDw6s3VYieGnnN9gE53tXIgi7D5tMVGYfAdOoYjFI1zay7Lcp2WhvaRJWF
	EdCS8ySrNHKbzh8iDaixoanR/cKAQu+TJ5ygxy9qh5N0jZKCK93uyJI0MX8wHXF20pV4JWu4YiW
	AXe1E1utw0IaXtwz9xg0u/2MQ+iNvaMuHQpudReJ4kaFzRc+O3EdnEGsz2hs+h2jfNDQuOEFIAP
	GPp88N8YfVsoEVYyU4svXL2rR2JjpKWBpWeH8hlDw/bF0dDotwGZcKBd1sQVV9XXl24Z0xMuGxY
	LqCT10X7r5D7azOxrxfqfLHqSKOIHD6tL+Qh5j2BOd
X-Google-Smtp-Source: AGHT+IFXuq6utVo73OWeSEuj14q0CkwfN1GgVLYORuB4LZiqsEwAojqct8Qfn2AYeX65r6KqqCfiOw==
X-Received: by 2002:a05:6a00:3ccd:b0:771:fdd9:efa0 with SMTP id d2e1a72fcca58-7938723b3a3mr25095907b3a.15.1760318706741;
        Sun, 12 Oct 2025 18:25:06 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:7f7:56b1:ddb:2ccb])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7992d5b8672sm9566711b3a.69.2025.10.12.18.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 18:25:05 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: sashal@kernel.org,
	stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com
Subject: Re: Patch "hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list" has been added to the 6.17-stable tree
Date: Mon, 13 Oct 2025 06:55:00 +0530
Message-ID: <20251013012500.16338-1-kartikey406@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Sasha,

Please do NOT backport commit dd83609b8898 alone to stable. This patch 
causes a regression in fallocate(PUNCH_HOLE) operations where pages are 
not freed immediately, as reported by Mark Brown.

The fix for this regression is already in linux-next as commit 
91a830422707 ("hugetlbfs: check for shareable lock before calling 
huge_pmd_unshare()").

Please backport both commits together to avoid introducing the 
regression in stable kernels:
- dd83609b88986f4add37c0871c3434310652ebd5 ("hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list")
- 91a830422707a62629fc4fbf8cdc3c8acf56ca64  ("hugetlbfs: check for shareable lock before calling huge_pmd_unshare()")

Thanks,
Deepanshu Kartikey

