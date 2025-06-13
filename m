Return-Path: <stable+bounces-152604-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C1AE3AD82F2
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 08:09:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45B273B40EF
	for <lists+stable@lfdr.de>; Fri, 13 Jun 2025 06:08:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E438D25486E;
	Fri, 13 Jun 2025 06:09:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MQrGWcMX"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E35F255F25
	for <stable@vger.kernel.org>; Fri, 13 Jun 2025 06:09:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749794945; cv=none; b=p1msqJsnPjQc0InD7rS19YlFmwrfMwhNpPfypN24Y5/LUzbQDYMWkz1BnbeeNyWVq8bN/2mC6oBqCoKfG/Ck33OvKAthUKVs8W+02aMggK4u33ZFL4Ppv8WUls5w1lsTBA+49ZLEig2MHBa8GKUIvpZO3P9UAqk+XjUGIXM4VFI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749794945; c=relaxed/simple;
	bh=tJ/om+ceomx13bsjFtekyKTo77DmddwBT1kyb/+82QM=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=JAzZ0V9rZ/7I6ODcGteYWG8mQ9ClI4Hz3Wiigkbz3Htrk0W12gfXoayFmCaLH6KJW7wiZzyhv0l6byX7W/FAhyM2MCGjtdkeizEO4IH+t8xo5DY7yk/eb1AyCRca063FCd+uAXirFzLCbyq+LdE9pG0YvLWvIcEOflLWYTPZ4+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MQrGWcMX; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-607c2b96b29so3643949a12.1
        for <stable@vger.kernel.org>; Thu, 12 Jun 2025 23:09:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749794942; x=1750399742; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=UDLqbXfo+VFjKuPOXyUv0l0VtBaeRhl0TqCgV1xn8U8=;
        b=MQrGWcMXCgGi4SaJX9IX+o8ugmAj1X7Q3Ti+8Y0/oi4APSUT4UNZOZY+BPJW7R2J/t
         IXcVqL1zWu2gYZcWmHQaNfTxZl0p2MMD/WwFXaUU6Z8q4gWcOhdDuoV62UDHMEQMRUAo
         WLBKSClydBBrSpscYImfyoj6S0U6bPzmARJGpILv2ewGzZsgLIhYILncxLVajDaLW41P
         ROTko3N4Vv9OhxY0XIxpXIaHdtJzD5MLshwXtinnu2zC/P3Mgt7JTIncjcKGy9/gQYYL
         bKPhhjuHn27l5MhDFUsdZqgfXtjUeZuRMZn/srVFJVI/72FYUF2IJ67WTCgnCazogzcP
         hqmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749794942; x=1750399742;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UDLqbXfo+VFjKuPOXyUv0l0VtBaeRhl0TqCgV1xn8U8=;
        b=nMHrpNaBwRZX3soLOn1CKDeVCyWbKD4eplS0VTuaDPiMmIe1qxfe+BzzCGfVauv8To
         9ABVUXYBm1EYnVo6xu0Q/klDYlhpuNU6cbg9pX4ZdZo2u05HaN7/GwNzs6YjSSMatM5s
         /nvXd1j3WolWivRhFJ5u+Nf+IESRabi29xZMJQ5PxrALXCQYlyhfqRprRAAJBw6f2goW
         hTvs3io96smwiu/UQpWHxlGZgkssCR5u5blNkyJm0ccQouI0qegWcZhFPpYMKsu2paUu
         Uegz2uckhpmbITDivulrCFJVLO9vs/c7NrD3wyp5Af+N/EvaKUNORy9IjTNCNZ0SYqmj
         UBEw==
X-Gm-Message-State: AOJu0Yz/zcZxU/T+VTnb+2lIFrlxFY6+t5L9GWxR6no6+DeF+F9GbAIG
	qpI+9U8QI9VkIkgtKUaLSYX/ttqQQZFdnz2l8RtZN627u7zC7Yk1+ADlCN4n+dajHnpi9NNSqQo
	pn5LgV6bvotOX/HrKpOD54TB5Nv3u9U+wT+Da
X-Gm-Gg: ASbGncv7HuILGs3mnuSLs7EPUQ47bh6celhmLGgSpJH99exdL6BFHfeZlFDrft4Ad0d
	Je4adpQ1Lozk2xiBYU2yGi8eIT1aXxCo624wwfKY/iFEqYkff3VdVVcePs2ZlGONxTTA9i3jqx7
	zVdeWYZUtcWEji4sNav93ioeFe/gzKtjZLlAtu1SsIfA==
X-Google-Smtp-Source: AGHT+IFFmjmLTFpuHGicZ6A05E4iGPGBja8GxdWx2Wxgp/UXrXfLFR+mb314vf2iFxqOdeQoQm/+yzb6okBR5Tt2b20=
X-Received: by 2002:a17:907:da9:b0:ad8:a04e:dbd9 with SMTP id
 a640c23a62f3a-adec5d21666mr182121866b.31.1749794941795; Thu, 12 Jun 2025
 23:09:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Dave Airlie <airlied@gmail.com>
Date: Fri, 13 Jun 2025 16:08:50 +1000
X-Gm-Features: AX0GCFsVvJuALPXwwSx8WUfcDeGQDYvg4_C2QkU2GEkjZzqIr0zEH5lbUV60T8Y
Message-ID: <CAPM=9twiDpukMfKMOqSLXGHDfnQxGFjNnau1_XRt8pueL4MkoQ@mail.gmail.com>
Subject: two nouveau patches for 6.15 stable
To: stable <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hey,

Can we please get

4570355f8eaa476164cfb7ca959fdbf0cebbc9eb
Author: Zhi Wang <zhiw@nvidia.com>
Date:   Thu Feb 27 01:35:53 2025 +0000

    drm/nouveau/nvkm: factor out current GSP RPC command policies

a738fa9105ac2897701ba4067c33e85faa27d1e2
Author: Zhi Wang <zhiw@nvidia.com>
Date:   Thu Feb 27 01:35:54 2025 +0000

    drm/nouveau/nvkm: introduce new GSP reply policy NVKM_GSP_RPC_REPLY_POLL

Into 6.15 stable they fix a major regression in suspend/resume on nouveau.

Thanks,
Dave.

