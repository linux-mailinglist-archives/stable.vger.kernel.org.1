Return-Path: <stable+bounces-98159-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E95D59E2C4E
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 20:48:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4CA93B3D46C
	for <lists+stable@lfdr.de>; Tue,  3 Dec 2024 18:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03C541FC7EC;
	Tue,  3 Dec 2024 18:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y4nSFSqX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B897B1F8901
	for <stable@vger.kernel.org>; Tue,  3 Dec 2024 18:13:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733249619; cv=none; b=eA7yeyOMBai9qo1YRb39pW1F5ubSoAPPKbO18Hx30/r5+G5+30QWv6WFPt5HUmG+qkyXXtjk8B6LZweQ/yTcYKgUQz5E2J8hbynkO057PkmDIw03VuC+bIU4NfQxluJxbobh08XIQ27J1WUuL9uwp2vY1VjUjvL1RTQkRUv/ZT0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733249619; c=relaxed/simple;
	bh=yKXIVsyL4EYIC2MbAsmBxXMDFEgjy9DkUx1+GLZWOUw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lYUE8EWn5aZVBAnScHNdODeXCpguQiCWq4Md566kaOoMj+gPKUoPN+t3ze3AyH5R4+oakBFlHvrtcw4oJ2P9FiuNzi3CEbW9BI6/JLd1WIjI4QIHm3YND54DcYeRXX/Qitw07ZbC0cqU2gz2YWE5MexOdQpWkdyeeGIjIkW48+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y4nSFSqX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E94AC4CECF;
	Tue,  3 Dec 2024 18:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733249619;
	bh=yKXIVsyL4EYIC2MbAsmBxXMDFEgjy9DkUx1+GLZWOUw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y4nSFSqXumAEFCAwlec0r/bzuraCgCxk4rfP1XetME64ue/6bssjD3EP0hq7WTpjf
	 L/mnH4uRjxj7nyFhKbngSNi8Ekvg14Fw8tn0OPM6NHPsiijozYq7x3WvZEKc5Nhp3A
	 0ebVn7di4utKg/fSFhtbYGNED7CkMMGuq+1dJRyos4Ya9mxtjKaGnnNH8FkdtKr+HX
	 Nuu2ieg/RDAuuVfkw686vzQlwPZGHHkTqgZT3t+aLVzQl+GrrPiAya61FToA0RHRo1
	 mX6iGN6ZaKzGZR7qn971ZjWM7BNorPU8SgeIPupIOu06Gwia9jXWEfJcpBB0yElG4p
	 ZzTnX+JbIwmPQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>,
	Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 6.11 v4 2/3] net: fec: refactor PPS channel configuration
Date: Tue,  3 Dec 2024 13:13:37 -0500
Message-ID: <20241203130409-685cfa76aeba26db@stable.kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To:  <20241203141600.3600561-3-csokas.bence@prolan.hu>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Sasha's backport helper bot ]

Hi,

Found matching upstream commit: bf8ca67e21671e7a56e31da45360480b28f185f1

WARNING: Author mismatch between patch and found commit:
Backport author: =?UTF-8?q?Cs=C3=B3k=C3=A1s=2C=20Bence?= <csokas.bence@prolan.hu>
Commit author: Francesco Dolcini <francesco.dolcini@toradex.com>


Status in newer kernel trees:
6.12.y | Not found
6.11.y | Not found

Note: The patch differs from the upstream commit:
---
1:  bf8ca67e21671 ! 1:  cb1ab3e3c1544 net: fec: refactor PPS channel configuration
    @@ Commit message
         Reviewed-by: Frank Li <Frank.Li@nxp.com>
         Reviewed-by: Csókás, Bence <csokas.bence@prolan.hu>
         Signed-off-by: Paolo Abeni <pabeni@redhat.com>
    +    (cherry picked from commit bf8ca67e21671e7a56e31da45360480b28f185f1)
    +    Signed-off-by: Csókás, Bence <csokas.bence@prolan.hu>
     
      ## drivers/net/ethernet/freescale/fec_ptp.c ##
     @@
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-6.11.y       |  Success    |  Success   |

