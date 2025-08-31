Return-Path: <stable+bounces-176777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 11EF4B3D527
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 22:24:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AA30D17894A
	for <lists+stable@lfdr.de>; Sun, 31 Aug 2025 20:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A23722CBC6;
	Sun, 31 Aug 2025 20:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="pG1+XyXl"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F432153ED
	for <stable@vger.kernel.org>; Sun, 31 Aug 2025 20:24:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756671844; cv=none; b=E7DOmHeX45K6VNLBfd40Z0SLUYW/Uw8jLmGUmv4v4zC5XsCyLRZrFNe2biL99sjxW6+3Yuy37vZpxSpyOPX+2jZN/JCMXLO+gWOAYqRuVL8qljh08J3qRf2dHc6Z78ieZUPfAhuQl/jiK2hvN3Wru9wvkVyBCImtr4aFmkf/pyU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756671844; c=relaxed/simple;
	bh=ZWxKwichyf4+kmJJD8+fgKfqOMDO/v7cTKzgkvUg61Y=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QA8H3bReoV6P6kobvsl6BspaY+oVuRzmI2c/tbLXxSrrf/Gmf4TT7LgDDKbQO/kYvhdBscpdNL27RVdrEsRNde6e6jMQPUfAYgao1hCtlfmAimWZNZhU8XiF+NuQFQZ2jtT4f2ZyUg+2swkMnaAvB/jOgZ9rBRP1x7MFhdaR4ac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=pG1+XyXl; arc=none smtp.client-ip=80.241.56.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp2.mailbox.org (smtp2.mailbox.org [IPv6:2001:67c:2050:b231:465::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4cFNkc3kv0z9tSH;
	Sun, 31 Aug 2025 22:23:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1756671832;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nA56/uCXm1wm9gJsuNhqE0F161KkM3Pj2CH/v2HVsyA=;
	b=pG1+XyXl2oI+oTfkwqJYLBnbeAbllEcLpTZbImehge5f4H/hY98USO0ywb2ut3MdqIjogO
	1RjBJ9EGCmiJRhVJmcTiyuCQljB4b7JQhYDeDRY/cGLHvgDF2uT7ocTekQiMd8qkBCnNTc
	GnjjcWnBPDIeDJcqT1fc9cUxI6kg/wVSOeFDHzy+7C4Vi0jBapxUn9mlMg80XZEz40U0Gb
	Hcw+hL16/KCQIWWV+kV42fcWufW0M8v3L55GDutEhqEh/JDbwb42+nZEhPWgJA7iH3Z+Br
	G0czmfveMK6GzuzK7HD6oFv9A2xnQZGmzw0Atb6UyHLzlW+SUYYbfWAjzS2aHA==
Message-ID: <58e76f32-76d4-4853-ba91-da6b3a4ecb1d@mailbox.org>
Date: Sun, 31 Aug 2025 22:23:45 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: PCI: dwc: Ensure that dw_pcie_wait_for_link() waits 100 ms after
 link up
To: Greg KH <gregkh@linuxfoundation.org>
Cc: linux-stable <stable@vger.kernel.org>,
 Manivannan Sadhasivam <mani@kernel.org>
References: <29e310e4-4ef9-40bf-9570-7b72e0369ce4@mailbox.org>
 <2025082533-altitude-reapprove-3061@gregkh>
Content-Language: en-US
From: Marek Vasut <marek.vasut@mailbox.org>
In-Reply-To: <2025082533-altitude-reapprove-3061@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-ID: fded17d62bc4d3f1009
X-MBO-RS-META: m34rf9mjw768wiwybfuk6q86rjai8yg6

On 8/25/25 9:39 AM, Greg KH wrote:
> On Wed, Aug 20, 2025 at 12:39:05AM +0200, Marek Vasut wrote:
>> Please backport the following commit into Linux v5.4 and newer stable
>> releases:
>>
>> 80dc18a0cba8dea42614f021b20a04354b213d86
>>
>> The backport will likely depend on macro rename commit:
>>
>> 817f989700fddefa56e5e443e7d138018ca6709d
>>
>> This part of commit description clarifies why this is a fix:
>>
>> "
>> As per PCIe r6.0, sec 6.6.1, a Downstream Port that supports Link speeds
>> greater than 5.0 GT/s, software must wait a minimum of 100 ms after Link
>> training completes before sending a Configuration Request.
>> "
>>
>> In practice, this makes detection of PCIe Gen3 and Gen4 SSDs reliable on
>> Renesas R-Car V4H SoC. Without this commit, the SSDs sporadically do not
>> get detected, or sometimes they link up in Gen1 mode.
>>
>> This fixes commit
>>
>> 886bc5ceb5cc ("PCI: designware: Add generic dw_pcie_wait_for_link()")
>>
>> which is in v4.5-rc1-4-g886bc5ceb5cc3 , so I think this fix should be
>> backported to all currently maintained stable releases, i.e. v5.4+ .
> 
> Can you send backported and tested patches for these kernels so that we
> know they work properly?
Since the affected device I have available locally and the controller 
driver are only in Linux 6.12.y , I sent the two backports to stable@ 
for 6.12.y only . I hope they are OK .

