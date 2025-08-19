Return-Path: <stable+bounces-171846-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A353B2CF0E
	for <lists+stable@lfdr.de>; Wed, 20 Aug 2025 00:05:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7E65564B9C
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 22:01:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0BEC25B31B;
	Tue, 19 Aug 2025 22:00:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ymJukU6+"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f54.google.com (mail-qv1-f54.google.com [209.85.219.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31ECD353375
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 22:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755640851; cv=none; b=mKBtSVNcrskanMS7n8WMuSG3kSJTHJySTGcjFw2JBQAi+qLyjqJ1hZs3tDAGAIW3Ip6/mem8ga+bmIaga81IecGENBRBgr2E8RMhB/1OvwUfBiH5V00vNnGZvoa8AZZ4OmLWzlYAaKXyulUKNch8Jyq/z25t2OL7HjsTeZlI3SA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755640851; c=relaxed/simple;
	bh=3q7E0xstPx3GeNDNlkRK2lEn/9GKIsnEAAC0rS7rcbA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=UdyltZqKT5c6Ee1U9poYupqfPFP8obPiBRwaylCKbVVHBS99OAK9ujSnrN1AEsyyfrO1o/Zu81drNE90CifbY3lXKMVukzb0vNeW5swYhHPr4xphxwleTrl0u1E7qJK47JTys5tKeFkUQJIjH22BdGHA5t6N56ypF9P+XVHGPac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ymJukU6+; arc=none smtp.client-ip=209.85.219.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qv1-f54.google.com with SMTP id 6a1803df08f44-70a927f38deso29363176d6.1
        for <stable@vger.kernel.org>; Tue, 19 Aug 2025 15:00:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1755640849; x=1756245649; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=3q7E0xstPx3GeNDNlkRK2lEn/9GKIsnEAAC0rS7rcbA=;
        b=ymJukU6+2bTbRvCUHTmthRXy092bpBrvK7X+6TYGPIRfu4CeZ5BWkFgX0jY+ePlTAa
         u9y/SDHiUKz0Q/qK+i4Hscr500WAnSECgAJLcoJyd2pHss2UL3XoIYIBJGxlExwsRewL
         8QYGXla4tceyyRwoLAsFySGs9NV1wy7TxZdYwf2IQfjyZd1FJpkmRmajIR9aqD0cr0Dw
         qxq6i3E+VytY+Cv65s1eSwmGuQFSJ8y8AhHA+ZlIX8idvuZoVKE0y3A9x9bAdPENZvWC
         eyHIGEVs283wtO2ectR4+g+FB7tu0GNrLln0lDGWEa0QaNy+Y6Pq3/qaP4x2D4G7oqx2
         sbIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755640849; x=1756245649;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3q7E0xstPx3GeNDNlkRK2lEn/9GKIsnEAAC0rS7rcbA=;
        b=Q/G2GX/KtAPWa5s8eszKdXCZbTeqHoZx8Xtv++GE92ybkwTyXP9J7mIydeoPKKF8wL
         6DI6EMujCBKbHpRqKhfE9d4J8xjSdxCaM7HZPKiwWS8sDmVGpLBq4Ujf5scTLyPJnuPW
         qJEjwrNeijQhy0z4qNPOez5IZEIMhWgLK1eO5nl0PjYaucdf9w+4z0mvEPo2JLIvB0VM
         z1OkNxhma//Bebgu8YqjiB+VukTXMlGvXTDvCkaQOV2PlapSAEWqnSc8jn8AfWlsZfK2
         8eo22hsgk/EGpFyfWTCbXtjRPogCrlwO38eUHAWeKRXp+nbh5bpkYYdvs/B5R4iwVCEY
         Fu6Q==
X-Forwarded-Encrypted: i=1; AJvYcCWq9uPi72E77kkl393MDojqFZquZwGduvcsOxX2bkdktGfjZBP63LIEbv/Yie5i22qdoT3bino=@vger.kernel.org
X-Gm-Message-State: AOJu0YxsKdFCG3w/c3jKIhm8qSX8T82NvquOUnLBEu2Duuq+6LJGUNHk
	/N7Eb5qbAdrRDbGGyWL2fZ1NvHooTX3JHUNP589O/giA7FHbXiCYRIpJMnZkgOO0mLaIwiUpK1U
	/Bx7wH5+BY/H0N5+9pHpoBz1RZ4Tw16tL99xYAWuS
X-Gm-Gg: ASbGncszwkT7koKtkyrw5BP8d9Gy7P9rT5FtjWyAmWQTbksdGFemJLfI/TlYCyxKXu+
	vblUH9F9MD1QURjgrjwW4I1TvU6WoXQvfcNOhgDPtG8NvSGmTIoQPhHCbFh4mZRQP/8f/JlJnGT
	kJvNdOMqH+bgR84VObFPqhzb/LTtgNEvl4PUWwBOnoBdiycn8rwCFX9vmhWMGpFREDLhG1R4lOy
	n6fNq1xkeJ+YFesjKfRUbAOBx1Cmn29rYh9aZZU6+XfS5D0M+W7IWrdSxnZ
X-Google-Smtp-Source: AGHT+IEG1V/xjVVDYdXSQGC2hgeHUn/Ejny6kmRMJmuYzd/jyW3aMkmOKMhwq7JgOAdHJWMTpUIhyisJ83OKJQgXals=
X-Received: by 2002:ad4:5ded:0:b0:707:4b47:9b72 with SMTP id
 6a1803df08f44-70d76f56e3cmr6462256d6.12.1755640847368; Tue, 19 Aug 2025
 15:00:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Alistair Delva <adelva@google.com>
Date: Tue, 19 Aug 2025 15:00:25 -0700
X-Gm-Features: Ac12FXwxzRWoB25e9Lfyp5eGGPa3w7eIvSq4CuatvL1ZR7MQDCAnqGcE1x3AN18
Message-ID: <CANDihLGGcVHO=8uX6+TWciJyXqy6KtRHGgjbAGq4a1hZ36mU8A@mail.gmail.com>
Subject: 2a23a4e1159c to 6.12
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Elie Kheirallah <khei@google.com>, Frederick Mayle <fmayle@google.com>, 
	Cody Schuffelen <schuffelen@google.com>, "Cc: Android Kernel" <kernel-team@android.com>, 
	Linux Stable maillist <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Dear stable maintainers,

Please consider cherry-picking 2a23a4e1159c ("kvm:
retrynx_huge_page_recovery_thread creation") to 6.12. It fixes
a problem where some VMMs (crosvm, firecracker, others) may
unnecessarily terminate a VM when -ENOMEM is returned to
userspace for a non-fatal condition.

Report of the change's success on 6.12 and first request:
https://lore.kernel.org/all/aBOPWGPTCgnUgtw-@CMGLRV3/

Example downstream bug report from libkrun:
https://github.com/containers/libkrun/issues/314

We are seeing this same flaky behavior at scale on infra
machines running 6.12.38 from Debian bpo.

Thanks!

