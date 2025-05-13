Return-Path: <stable+bounces-144224-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59B68AB5CAB
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 20:48:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0811C864E52
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 18:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C72502BEC5A;
	Tue, 13 May 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tZcHxr16"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86C17748F
	for <stable@vger.kernel.org>; Tue, 13 May 2025 18:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747162120; cv=none; b=evSKaBjz6MsfzM3JkwdUePe5toESus47aPH1xvWFS41h1wLhlTh1E/rGFnfUtz4K0m1bGz1faa+5Jb/1wgjkVM7yN4x8TI7JlbV+sz2FGwYRZL73hVEg4tdL+5/LzD96gxVfNNAO8IdRvKk5xGvd6BI5JZgO62HCNqHT3PZcmVA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747162120; c=relaxed/simple;
	bh=EvD71TVde2gyONIv4NrrAgGTFGSANrQ7rASu82Rnym8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dC1MSJGO6Sp3tblt/bBawPAG7OfRxCvNTk9GTIotACnmjsrFekq+J5l3gtWevj9TOvfZPQFC2LObYrrqRRD0sc51Y1NNP735pEBjNCopLYOMX+jcPdGtXAHris2JMfHRYtKOQsuUofnfy9469VMxRmddRavs4fLk04crTmFVYQA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tZcHxr16; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D99BC4CEE4;
	Tue, 13 May 2025 18:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747162120;
	bh=EvD71TVde2gyONIv4NrrAgGTFGSANrQ7rASu82Rnym8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tZcHxr163G6m0qZaJN7g2gdMRp6fxUDjIsK1CiAHmitYFUe1aIf8ld2rsYtZc25ZA
	 QuppubEPIKiuYcjm3tJYG5QqVV01acGLS6ML8zbUdGjDXrfowG1rEI8uIweHpMtLsj
	 63WwRXeiH+7fhwBiXCALt+wwhKRQaWpEyP3a2zLdH3nlTTtmR+S+Gu4z8yD93Ppc5l
	 F2rZh3Xgsu9ld/Wavg94ITBAT2u4WQoeZ49wMhjJYg0ZPMfG/JL3f+kV6N5+AGpgce
	 TnHY4QdS3UmhY0SIVZmmiuuxnpzf+I0OuoX8AuycJQ3aVYabnupSjvLNjQYjdu2xgl
	 S3nM/V2wyk6Lw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	bigeasy@linutronix.de
Cc: Sasha Levin <sashal@kernel.org>
Subject: Re: [PATCH 5.4.y] clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()
Date: Tue, 13 May 2025 14:48:35 -0400
Message-Id: <20250513110535-97908736bfc4c5b0@stable.kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To:  <20250513072606.620633-1-bigeasy@linutronix.de>
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

Summary of potential issues:
⚠️ Found matching upstream commit but patch is missing proper reference to it

Found matching upstream commit: 94cff94634e506a4a44684bee1875d2dbf782722

Status in newer kernel trees:
6.14.y | Present (different SHA1: 6fdc7368341b)
6.12.y | Present (different SHA1: e0e66bb1af60)
6.6.y | Present (different SHA1: 5dd520b92acb)
6.1.y | Present (different SHA1: d2f5f71707cf)
5.15.y | Present (different SHA1: f29f5341f350)
5.10.y | Present (different SHA1: 7d45c9f3693e)

Note: The patch differs from the upstream commit:
---
1:  94cff94634e50 ! 1:  c0d1d522f39bf clocksource/i8253: Use raw_spinlock_irqsave() in clockevent_i8253_disable()
    @@ Commit message
         raw_spinlock_irqsave() to cure this.
     
         [ tglx: Massage change log and use guard() ]
    +    [ bigeasy: Dropped guard() for stable ]
     
         Fixes: c8c4076723dac ("x86/timer: Skip PIT initialization on modern chipsets")
         Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
         Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
         Cc: stable@vger.kernel.org
         Link: https://lore.kernel.org/all/20250404133116.p-XRWJXf@linutronix.de
    +    (cherry picked from commit 94cff94634e506a4a44684bee1875d2dbf782722)
    +    Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
     
      ## drivers/clocksource/i8253.c ##
     @@ drivers/clocksource/i8253.c: int __init clocksource_i8253_init(void)
    @@ drivers/clocksource/i8253.c: int __init clocksource_i8253_init(void)
      void clockevent_i8253_disable(void)
      {
     -	raw_spin_lock(&i8253_lock);
    -+	guard(raw_spinlock_irqsave)(&i8253_lock);
    ++	unsigned long flags;
    ++
    ++	raw_spin_lock_irqsave(&i8253_lock, flags);
      
      	/*
      	 * Writing the MODE register should stop the counter, according to
     @@ drivers/clocksource/i8253.c: void clockevent_i8253_disable(void)
    - 	outb_p(0, PIT_CH0);
      
      	outb_p(0x30, PIT_MODE);
    --
    + 
     -	raw_spin_unlock(&i8253_lock);
    ++	raw_spin_unlock_irqrestore(&i8253_lock, flags);
      }
      
      static int pit_shutdown(struct clock_event_device *evt)
---

Results of testing on various branches:

| Branch                    | Patch Apply | Build Test |
|---------------------------|-------------|------------|
| stable/linux-5.4.y        |  Success    |  Success   |

