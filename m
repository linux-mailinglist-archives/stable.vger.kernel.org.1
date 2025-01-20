Return-Path: <stable+bounces-109548-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 48D08A16E8A
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 15:41:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F342018803B6
	for <lists+stable@lfdr.de>; Mon, 20 Jan 2025 14:41:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E427A1E3771;
	Mon, 20 Jan 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H8azd3b4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A34DA1E376E
	for <stable@vger.kernel.org>; Mon, 20 Jan 2025 14:41:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737384103; cv=none; b=GDyZTq67NhYGx8IpaC1nEqwKo1rRhhNQuyI1654M9sAuEg8sjPJkzbm0JqRkN4d+dUOphU2MEhfwhMRPdhP+RgF/wiWANI7W9ldqRcRs+zG9qluN8Hjowc0yoSOW+pWPZevlrVlsVQ3O870Uxjo5ZXG3hOXFrQG9oqi5ZfvEZPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737384103; c=relaxed/simple;
	bh=T384Zte9d+GRK/qTDQ1La+iKC7EaNcwT/t75WhSwut4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ZavId1aNFTs/m8b8vFZ3abMXNUb77f918MZfANaf2GsvAhjOjjTrvFUeu9XsL/aWu8sEMjh4D0+KxF7Ml200fkyGTmxPWgfL9AS06HtQPPzDXDliZjIMen3OVJIbOCJRIe8o5VkBT4qUBZyrfgir4IlQ/CYYLpXiabBapGYN4Ew=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H8azd3b4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA050C4CEDD;
	Mon, 20 Jan 2025 14:41:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737384103;
	bh=T384Zte9d+GRK/qTDQ1La+iKC7EaNcwT/t75WhSwut4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H8azd3b41hop4ze5RR8NcaC3OTPH1Q8RcVmJWMKcr8/osOwlGflRIuB1NAAmO8aze
	 +GHrIVX3WzWFMRHkCHFKo0fEYUpz50QXrjjseHqYC4IxDZ15MsoDSZ9jX5ovZEqhWQ
	 J+05868TSaDBC/VRzGcSCU7CQRTVH50opGAi9L7lh0V+y4uORY10H2Rgb59hMo8cnZ
	 xe5h0vEgstU0KygdFcN9OtcKsZdWBQ1md2z0ECwesrk4y6saA2N/rKO/RX1k9Kpkc5
	 OH3GWH2Yi6SD0F9zYh+iWWyYT84XgWFT+OGrj1+XXKavQAXDkp/5045DNbtYOhXMq1
	 mEUO4Y2GocJyg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Keerthana K <keerthana.kalyanasundaram@broadcom.com>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH v5.10-v5.15] Bluetooth: RFCOMM: Fix not validating setsockopt user input
Date: Mon, 20 Jan 2025 09:41:41 -0500
Message-Id: <20250120092513-113c86aba38f5664@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250120064647.3448549-1-keerthana.kalyanasundaram@broadcom.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

The upstream commit SHA1 provided is correct: a97de7bff13b1cc825c1b1344eaed8d6c2d3e695

WARNING: Author mismatch between patch and upstream commit:
Backport author: Keerthana K<keerthana.kalyanasundaram@broadcom.com>
Commit author: Luiz Augusto von Dentz<luiz.von.dentz@intel.com>


Status in newer kernel trees:
6.12.y | Present (exact SHA1)
6.6.y | Present (different SHA1: 4ea65e2095e9)
6.1.y | Present (different SHA1: eea40d33bf93)
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  a97de7bff13b1 ! 1:  8599b21ee1809 Bluetooth: RFCOMM: Fix not validating setsockopt user input
    @@ Metadata
      ## Commit message ##
         Bluetooth: RFCOMM: Fix not validating setsockopt user input
     
    +    [ Upstream commit a97de7bff13b1cc825c1b1344eaed8d6c2d3e695 ]
    +
         syzbot reported rfcomm_sock_setsockopt_old() is copying data without
         checking user input length.
     
    @@ Commit message
         Reported-by: syzbot <syzkaller@googlegroups.com>
         Signed-off-by: Eric Dumazet <edumazet@google.com>
         Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
    +    Signed-off-by: Sasha Levin <sashal@kernel.org>
    +    Signed-off-by: Keerthana K <keerthana.kalyanasundaram@broadcom.com>
     
      ## net/bluetooth/rfcomm/sock.c ##
     @@ net/bluetooth/rfcomm/sock.c: static int rfcomm_sock_setsockopt_old(struct socket *sock, int optname,
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.15.y       |  Success    |  Failed    |
| stable/linux-5.10.y       |  Success    |  Success   |

Build Errors:
Build error for stable/linux-5.15.y:
    net/bluetooth/rfcomm/sock.c: In function 'rfcomm_sock_setsockopt_old':
    net/bluetooth/rfcomm/sock.c:639:21: error: implicit declaration of function 'bt_copy_from_sockptr'; did you mean 'copy_from_sockptr'? [-Werror=implicit-function-declaration]
      639 |                 if (bt_copy_from_sockptr(&opt, sizeof(opt), optval, optlen)) {
          |                     ^~~~~~~~~~~~~~~~~~~~
          |                     copy_from_sockptr
    cc1: some warnings being treated as errors
    make[3]: *** [scripts/Makefile.build:289: net/bluetooth/rfcomm/sock.o] Error 1
    make[3]: Target '__build' not remade because of errors.
    make[2]: *** [scripts/Makefile.build:552: net/bluetooth/rfcomm] Error 2
    make[2]: Target '__build' not remade because of errors.
    make[1]: *** [scripts/Makefile.build:552: net/bluetooth] Error 2
    make[1]: Target '__build' not remade because of errors.
    make: *** [Makefile:1906: net] Error 2
    make: Target '__all' not remade because of errors.

