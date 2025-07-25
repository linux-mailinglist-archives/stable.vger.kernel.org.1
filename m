Return-Path: <stable+bounces-164781-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 95140B12751
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:24:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F86AC1B9F
	for <lists+stable@lfdr.de>; Fri, 25 Jul 2025 23:24:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 670AB25F7A7;
	Fri, 25 Jul 2025 23:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mP/UmwA8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283951D9A5D
	for <stable@vger.kernel.org>; Fri, 25 Jul 2025 23:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753485867; cv=none; b=EMhMGQdQEiOCI7mLj/eAF84B0AEfvH/LsgZiRhsM30ikEvo4WzghQh1XSgjMFvZI2d11O6LnJjO29Bt9U2BGHjHn6WSXMiT4AyySa6Svlo7qcXIjri80KaPQC/Y6QiNFk1fczXqACc2BkgWKrXtS2jLzatmolFyHzs0Z0VeCHlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753485867; c=relaxed/simple;
	bh=E22Ew5yiq34g1opQVOgov6Gr/QG7lnWBf52PmWV/1vs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u7bMq3+rtms0B35C8U3CAs1+OTzfcuxakgFMJFpgUeHz7Nl9AKklqTCe4zC9aDIZddQOXvFfU7D6zZrZzORnhx4wFipo8+O41l2UvxWby9g9nkFIA0lYqunYCCDIbJgE0jeRsP8d7yERrBE/uqH3NhzFxkdeNtg5BMkDjKxGR7Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mP/UmwA8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36279C4CEF4;
	Fri, 25 Jul 2025 23:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753485866;
	bh=E22Ew5yiq34g1opQVOgov6Gr/QG7lnWBf52PmWV/1vs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mP/UmwA8xK5+UzvaYw2PpJJsbs4prvKhMwuxWWisa2Fq/nX7f7dMn5on94eXSf40R
	 PLfqv4WufvVNAqt+U8QgodlN9ChwdBIgFl7NoKRJDG0fvK/4ge/vQP8Hr1mMq0kBto
	 F4br+LAKgNL6sIXj7RmJQCIp9K0HMeM9azcShGoBdB39dVDw7LMg5Qtdw+p27lemUg
	 JMUcFauZaTUfuzHoHaOrXyoxE4BxOya0H4I8GG1y3oNAIgO1CAtuRP/djWaF5NsyxW
	 oh14yrqLqNQAtHTgmjcQ0pPezzvVTBRwAnJV4Fs0ACLHSYMZucepPVxAg7crozTuaH
	 XbdeEK08f5FNA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: pcl812: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 19:24:24 -0400
Message-Id: <1753470120-8a5225b9@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181257.291722-4-abbotti@mev.co.uk>
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

✅ All tests passed successfully. No issues detected.
No action required from the submitter.

The upstream commit SHA1 provided is correct: b14b076ce593f72585412fc7fd3747e03a5e3632

Status in newer kernel trees:
6.15.y | Not found
6.12.y | Not found
6.6.y | Not found
6.1.y | Not found
5.15.y | Not found

Note: The patch differs from the upstream commit:
---
1:  b14b076ce593 ! 1:  b9004585cda3 comedi: pcl812: Fix bit shift out of bounds
    @@ Metadata
      ## Commit message ##
         comedi: pcl812: Fix bit shift out of bounds
     
    +    [ Upstream commit b14b076ce593f72585412fc7fd3747e03a5e3632 ]
    +
         When checking for a supported IRQ number, the following test is used:
     
                 if ((1 << it->options[1]) & board->irq_bits) {
    @@ Commit message
         Link: https://lore.kernel.org/r/20250707133429.73202-1-abbotti@mev.co.uk
         Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
     
    - ## drivers/comedi/drivers/pcl812.c ##
    -@@ drivers/comedi/drivers/pcl812.c: static int pcl812_attach(struct comedi_device *dev, struct comedi_devconfig *it)
    - 		if (IS_ERR(dev->pacer))
    - 			return PTR_ERR(dev->pacer);
    + ## drivers/staging/comedi/drivers/pcl812.c ##
    +@@ drivers/staging/comedi/drivers/pcl812.c: static int pcl812_attach(struct comedi_device *dev, struct comedi_devconfig *it)
    + 		if (!dev->pacer)
    + 			return -ENOMEM;
      
     -		if ((1 << it->options[1]) & board->irq_bits) {
     +		if (it->options[1] > 0 && it->options[1] < 16 &&

---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| origin/linux-5.10.y       | Success     | Success    |

