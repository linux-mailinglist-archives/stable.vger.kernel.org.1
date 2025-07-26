Return-Path: <stable+bounces-164816-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A2EBB12858
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 03:01:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 832341CE19F9
	for <lists+stable@lfdr.de>; Sat, 26 Jul 2025 01:02:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA44819B3EC;
	Sat, 26 Jul 2025 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IkyHTaTW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B7BA12DDA1
	for <stable@vger.kernel.org>; Sat, 26 Jul 2025 01:01:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753491703; cv=none; b=rxycAmVdCU7nhd+mXyhzeq4Z5cSTOMdabZ7hrxCnWOXxSdsD+OiHKXvn4gBa/B+VwzQaaPyiL0b/vxBqn8JLyO26pD26tUVsbuE7jCR6Z0mLauqONTwdp27oyC1ARwweHCcZBu7r6x95H+W1+e0sBKPnoMWxxk3X3btEjN3A70U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753491703; c=relaxed/simple;
	bh=wvRqj5ZfHUwBHOQCW3hlO0/ubqosAfpjZQOwaIjb+Wg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=t0ShixeNqf3PLxEiKnCEkmtOktDEyoJHN5vyVjnyT4sEsq2iwkg4oRur61jxnDfJQe/yjtz2tHK7a+uFyTfGY2Tn5HB16Q5WnUsVflbIMXvxXG6mrL5DYaqUNS2luYpio5RNThvPZ6/tGOok/vYwIq5i/axX1ml7It+CnLdHdJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IkyHTaTW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6872EC4CEE7;
	Sat, 26 Jul 2025 01:01:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753491702;
	bh=wvRqj5ZfHUwBHOQCW3hlO0/ubqosAfpjZQOwaIjb+Wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IkyHTaTWI4mlB9C5+pPK7YaSEmv5fZWHB8e7Ob/YqoBXe2E/y1hvARc3zRn/5Pdyo
	 9Vk2uT32Vb6/Sl35b93069RAO1wmZYCUHUmF3POvWJO7ssdFYgjRSpSS6fLrKPzru6
	 mR5DUKeaVhONWcRi1vYfLVhGC0nohnWHWaE2v4zMNw8KV55ThOZRTS170nqEHvtQJR
	 xxdNHM69i/xPgJCCy3DiW3Oxlq9/A/otSLJIMnCyhE9Z7RoMr+uNHO9p8QCsob4TTb
	 IqENH5BPpExm4lke9AEQ43oB0nsGMmzqf0r/ZmaBLyaYYXx9On9GiA1je2BFPO4itu
	 yg8kN0f/BsuaQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.10.y] comedi: pcl812: Fix bit shift out of bounds
Date: Fri, 25 Jul 2025 21:01:40 -0400
Message-Id: <1753466860-f663f02e@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250724181646.291939-4-abbotti@mev.co.uk>
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
1:  b14b076ce593 ! 1:  08dbf07f845c comedi: pcl812: Fix bit shift out of bounds
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

