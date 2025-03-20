Return-Path: <stable+bounces-125676-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 39C3BA6AB1B
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 17:31:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9F87C188D054
	for <lists+stable@lfdr.de>; Thu, 20 Mar 2025 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73901EB5E0;
	Thu, 20 Mar 2025 16:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="kOLYCVlv"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D2EB1B422A;
	Thu, 20 Mar 2025 16:31:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742488299; cv=none; b=LmObYG6gw50YpV0zWmzraAF2clGGsynlDZMvkN6SfnxMvEhe9md2dnSg3Xjvh3Z2c4jHcfSuKSxs2ylrpkC0+OUkzjUHpPN1+Qz+S/2shF7KUhczokrKU4FjMOaV7yFxAGzeMEt1PLsPDB+V4KYoSbhZbetmWmLKbqx35s3OPFE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742488299; c=relaxed/simple;
	bh=fwCJ8UJLOopH3XD3q/NiXqeMDiwELoEkMT8DTYo/Y3o=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=OtgwCHGZMYqZjwMou7q0SAx9RXZHLssH8f2Ww8Jbw//7NBw1sa1cZkAKcBjZbV1tXyPKfTN1r7LHT0q5JX1Sy2UHJPbut5GZ4Y3klqx4IdK5mHOLUKaTeqcKH8+9xr1uzp7fBS1jhFWEMgrIV3Vo+FhsjDqaw2HwgmED/uVbc2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=kOLYCVlv; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 16DAB2116B5F; Thu, 20 Mar 2025 09:31:38 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 16DAB2116B5F
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1742488298;
	bh=O4TdvvsuswOKm2h5fe2nqFWjK0nbWozaugS8JT+X8xg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kOLYCVlv384lUIA22vgrncEZwqCB8lJ86DY5WH0yPJ1WQPx8I9GwgIgkguljystsj
	 hdxCxISNxzxcjrXkSSTLex8mf/m8khm6/V3oCHp1nTfoD8cZkef0WxTSJDl+9LoOjI
	 /PNA3U3GHo/yF4+Y2qsFKfmvWxx6sgiIWO6MgMds=
From: Hardik Garg <hargar@linux.microsoft.com>
To: gregkh@linuxfoundation.org
Cc: akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@denx.de,
	rwarsow@gmx.de,
	shuah@kernel.org,
	srw@sladewatkins.net,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.13 000/241] 6.13.8-rc1 review
Date: Thu, 20 Mar 2025 09:31:38 -0700
Message-Id: <1742488298-6035-1-git-send-email-hargar@linux.microsoft.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20250319143027.685727358@linuxfoundation.org>
References: <20250319143027.685727358@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>

The kernel, bpf tool, perf tool, and kselftest builds fine for v6.13.8-rc1 on x86 and arm64 Azure VM.

Kernel binary size for x86 build:
text      data      bss      dec       hex      filename
29937944  17838882  6316032  54092858  339643a  vmlinux

Kernel binary size for arm64 build:
text      data      bss      dec       hex      filename
36685282  15081125  1054416  52820823  325fb57  vmlinux


Tested-by: Hardik Garg <hargar@linux.microsoft.com>




Thanks,
Hardik

