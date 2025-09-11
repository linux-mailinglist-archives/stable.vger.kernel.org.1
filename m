Return-Path: <stable+bounces-179243-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B6830B52B0D
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 10:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C8ECA8107D
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:01:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEF7B225768;
	Thu, 11 Sep 2025 08:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="JyZAoI7j"
X-Original-To: stable@vger.kernel.org
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEF892DECD3;
	Thu, 11 Sep 2025 08:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.171.202.116
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757577645; cv=none; b=MNVz6gJvDtzptmTKhzSswK4tXkkn5RqRGhGjEtYWtYTyh9UKBu8eudprVTnswETcv6qek6ejdz1iyxDXAKcNtfa3zonC9fPHf/4zcKNCTSweh9xK+lri+LYNbCw+lg+cSpmBahvO9WQSHyTznMXupnVmYivNnQFuLmKFkE5d2Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757577645; c=relaxed/simple;
	bh=gRzWgPjSxPvTT2pzilMZzJVnW86CdzBP0S4gR4XIJbA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Mlsv7eCPF2jmxFf3ZElwdJN9WuOJDbagC30apCs1zN+Xa9fhtXvOQB1E00HZ5iLQ1J/1jAINBCKNOZdz969FxCSdaNfIqdrKAfz+fRTuOoleldU8tkTE1E/T8oUGnhktpUja4A5PIZsUngNXSayoKhoj1uQfBmjYStepIkiGl+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=JyZAoI7j; arc=none smtp.client-ip=185.171.202.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-04.galae.net (Postfix) with ESMTPS id 23737C8F1EF;
	Thu, 11 Sep 2025 08:00:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id F3B30606BB;
	Thu, 11 Sep 2025 08:00:41 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 19C18102F1CF1;
	Thu, 11 Sep 2025 10:00:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1757577641; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=hr+BgcLInrDvy2HOmRqiItOPagbDlMwPRNd0wxjD3B8=;
	b=JyZAoI7jOjtoHkj24fpNvy8chFoP+TqIp+SBpZOyGl6Fkerue21JCjg/QEi1H4FMf+s3z/
	xQTjYB2xSD+HEaUncrRccM9kCBe2p4Y7+IWyX+q1bj0jCn7yqeXBkK6+xHlsk5zPjdhZeo
	CtNP6s6aEVakFLuhgW5dv0/Hd8usIyoSXlE4+AXXe//K1WHR2zcqMgX954ii5V+bGo8IgZ
	TRxYko9X+faMehAzza6sTUWkgkX27y/eQIj9QCYHxKIV0/vCING+oA9YbEFCcswTBsg24I
	Gqs4ZbXtZAt9F7zdHwsY9NlsY/Se5KA2wAv2wgreSo7B3vMnPL85RSneXy1+ZQ==
From: Miquel Raynal <miquel.raynal@bootlin.com>
To: Santhosh Kumar K <s-k6@ti.com>
Cc: Richard Weinberger <richard@nod.at>,  Vignesh Raghavendra
 <vigneshr@ti.com>,  Gabor Juhos <j4g8y7@gmail.com>,
  <linux-mtd@lists.infradead.org>,  <linux-kernel@vger.kernel.org>,
  <stable@vger.kernel.org>,  Daniel Golle <daniel@makrotopia.org>
Subject: Re: [PATCH v2] mtd: core: always verify OOB offset in
 mtd_check_oob_ops()
In-Reply-To: <454e092d-5b75-4758-a0e9-dfbb7bf271d7@ti.com> (Santhosh Kumar
	K.'s message of "Thu, 11 Sep 2025 11:52:27 +0530")
References: <20250901-mtd-validate-ooboffs-v2-1-c1df86a16743@gmail.com>
	<175708415877.334139.11409801733118104229.b4-ty@bootlin.com>
	<454e092d-5b75-4758-a0e9-dfbb7bf271d7@ti.com>
User-Agent: mu4e 1.12.7; emacs 30.1
Date: Thu, 11 Sep 2025 10:00:39 +0200
Message-ID: <87348tbeqg.fsf@bootlin.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Last-TLS-Session-Version: TLSv1.3

Hello,

On 11/09/2025 at 11:52:27 +0530, Santhosh Kumar K <s-k6@ti.com> wrote:

> Hello,
>
> On 05/09/25 20:25, Miquel Raynal wrote:
>> On Mon, 01 Sep 2025 16:24:35 +0200, Gabor Juhos wrote:
>>> Using an OOB offset past end of the available OOB data is invalid,
>>> irregardless of whether the 'ooblen' is set in the ops or not. Move
>>> the relevant check out from the if statement to always verify that.
>>>
>>> The 'oobtest' module executes four tests to verify how reading/writing
>>> OOB data past end of the devices is handled. It expects errors in case
>>> of these tests, but this expectation fails in the last two tests on
>>> MTD devices, which have no OOB bytes available.
>>>
>>> [...]
>> Applied to mtd/next, thanks!
>> [1/1] mtd: core: always verify OOB offset in mtd_check_oob_ops()
>>        commit: bf7d0543b2602be5cb450d8ec5a8710787806f88
>
> I'm seeing a failure in SPI NOR flashes due to this patch:
> (Tested on AM62x SK with S28HS512T OSPI NOR flash)

Gabor, can you check what happens with mtdblock? Otherwise this will
need to be reverted.

Thanks,
Miqu=C3=A8l

