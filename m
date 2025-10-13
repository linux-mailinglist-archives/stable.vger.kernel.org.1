Return-Path: <stable+bounces-184121-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0604BD0FFA
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 02:43:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 606D63B61D4
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 00:43:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C7D1D8E10;
	Mon, 13 Oct 2025 00:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SVn3TM5H"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ED4B72610
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 00:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760316189; cv=none; b=LMv4/oJehxLvNeTZ7zg8I9voE+cEZxGxN7aWzNUSWrJ7UKSoKxnHG+zSgCaTvOXMb7mNnBQtzlRHURXO8EbZskRYqK6SXGotD8zK884LSOUX0nxyPob977XlBkuDuve64hrs2CVSH5dpdEZagNGCbSMZJ6UOPONsZAzMUDR147E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760316189; c=relaxed/simple;
	bh=J4Yzb9iZ9EpboV9biYUfsNSETmRqq2TmKs+QNpM5zWU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cCacdhFbTYCgw79jjSTH8J907hvl3VXkIQiXNxqAXomCKonGDcoHGJ30mpOPHqLfXfNuQZeTFrKC5hO+4m7knZZ+tKd8iY8r/YeLKRg6iX6YXxMDffHdMRTqJhDlBVLJJTlggJXLWp3uH2kHeTHl4ysmisz3b86vCJAIKUvJ4pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SVn3TM5H; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-791c287c10dso3151723b3a.1
        for <stable@vger.kernel.org>; Sun, 12 Oct 2025 17:43:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760316187; x=1760920987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0XzRaVDpvVh3GxyQKpxmp+g1qh+O73uHDOdF7bHEjts=;
        b=SVn3TM5HQN7tb9zzH877a4+kDQttUfuzhw2t8CA3Bww4x8WwXvR3JTGKyXKpF1PCIk
         Y2BefxNjqM44fZHXGKLQmUqzZz2Ota0ppHK2Og1vrKUkmcnjTcTnpvRn8zUf3Zl0gvDq
         1227QsmoM9zSu6VGe6c7TenULzpnf1YJCcryrcIFXCsfzjjNolkLBuemM9SsToRObGJ5
         Cfp3jnZhhsFXfV38Ny08spOukosDg2KLALgcr7rhc1ENqVBhw1iKLzuASeLjyQCdb3zi
         T21UV0MdwNn7uvQY9RsqV06cvLRm+HjXtGK7QZYtjj254k23Lq1/UFB9lfvN4eQa9vuV
         rmNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760316187; x=1760920987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0XzRaVDpvVh3GxyQKpxmp+g1qh+O73uHDOdF7bHEjts=;
        b=Gdb3JwLcICZHfXgh0trXmD2DxvExOd8oA6zxL5NLwvugwRm2A4Ruk/YtPMhC/Rc/5T
         FWsArLOSXbSeU94KQvLeXNr759geMfDmVtuUzwr4J+vIRdwOCpIyQ/rd4OWKoQzoQ9NP
         oJBldkHCKj5iDhfXiFpbNiceuEEqWdi09s9cRV46mEIXiUKqryrKiI/l9nC4zSFY3NEM
         DNPUdACKLe2Xclgm/hj/xJ4XhqsCSWC+LR3kGAF2XRtOaYzBM13gm3NCpQ2n9TGVyolA
         uLEPsNsgbr+voAL3NN99SteCh/1gjeVHroeCGL3yYNQVj+irxOq7qFuzaTUUiR5hCQco
         S6tg==
X-Gm-Message-State: AOJu0Yxxrb5oF8o44FTlNyjPleUrqt2S6wIT3ubbe95IcpNavIE5fBCN
	RrJiyn7JPjLVREsZ7BXJU+8eTTb8Kkjiq6DE53Mt+aZED2mPwrEvjcgSxJvUKADz
X-Gm-Gg: ASbGnctd3h3vnvQ953xqxnJKeVxqgEO9V3pCUf3xlIBUve0CJDMq03CvMQ3F2mXnigr
	T+deEHDZ9GyKaVBU+2QCRzo6uhdXKMIEemcYrSnk6b4QYijDAmEyA5QnwyTmbnly8QEFUEKJiwY
	Wce36NcrEWbv/dz+mx8G2QInFK35yXpolrSGJRGnBNRR9GL8BJwNmfuz1lKA0UxoBP00OqFspqx
	okIggImmaiWqnyHtPgN12EgZFgcmzb8VNpxPwcSqLTnXEE/ylFo3coVHwWPS+r1Y9/wW2IPNHkR
	HofslJSXYjzwD0zwsn7XWH2wog5dl/vUFgbVht0waJ1tJ2RrANzc68CBiKmZdjP7k6657NGHr9Y
	B8nDeucmTDfLNffmxNLkqwt/pE8cTUOf39dzH6lRY5tQHsUd6wT0rJcPy5qSU7LEdp2IttXts4x
	B1puq1F5yuP8IqRI0i8SBGj2GRT00DKbMzStU/Rqyk
X-Google-Smtp-Source: AGHT+IEJ9+3If9FCMPigZ3r6dNXt7DjswUYuB0YkB/zAzqOWxFcGsIafhkW8OCsnNf8/fBxmvhWCDw==
X-Received: by 2002:a05:6a21:99a1:b0:302:c800:bc0b with SMTP id adf61e73a8af0-32da83e64d7mr24494230637.44.1760316187101;
        Sun, 12 Oct 2025 17:43:07 -0700 (PDT)
Received: from deepanshu-kernel-hacker.. ([2405:201:682f:389d:7f7:56b1:ddb:2ccb])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-33b626d284bsm9847620a91.18.2025.10.12.17.43.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 17:43:06 -0700 (PDT)
From: Deepanshu Kartikey <kartikey406@gmail.com>
To: stable@vger.kernel.org,
	stable-commits@vger.kernel.org
Cc: muchun.song@linux.dev,
	osalvador@suse.de,
	david@redhat.com
Subject: Re: Patch "hugetlbfs: skip VMAs without shareable locks in hugetlb_vmdelete_list" has been added to the 6.16-stable tree
Date: Mon, 13 Oct 2025 06:13:01 +0530
Message-ID: <20251013004301.4700-1-kartikey406@gmail.com>
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

