Return-Path: <stable+bounces-191814-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32051C250E9
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 13:43:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7AB0D1A66A26
	for <lists+stable@lfdr.de>; Fri, 31 Oct 2025 12:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0AED34A785;
	Fri, 31 Oct 2025 12:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b="KIY/eR+q"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta1.migadu.com (out-178.mta1.migadu.com [95.215.58.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAA26311C21
	for <stable@vger.kernel.org>; Fri, 31 Oct 2025 12:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761914587; cv=none; b=tB87PWZ/a5+XLDGVkrHYvitxIedcuz53MgAt2gvIDHQvVfqhDI6tN9LTN6hQz4tq+MGZxQmT4ICAeb41/6otHBMAHm2+oMOezcfrc7Qn6PtZGsf++gbOHwtaC9W4Qa5pUfP0Ci63irgZEdIQOXGyRClugwmf0lqPkiRXke9tQAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761914587; c=relaxed/simple;
	bh=PLD/9RwCyc/wENbahoWPvbxicWmVeAGz1BL3RIu9cxE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QPP0hNznRIIXiWrjnSRpR4/Fu+t6UTFFGYOp0qDhEWJAOYev5b5tf5LtPVH4TCkeLms08eFrfCMktrc+vXEeOvF6O8isfN2FtLWsmQ+2jeSSohKg0GZSPK+uYqQ/MdM6kMudOnVFQd/Qiu0UzbahUE5YXKzdS+0YNSiJdZvvQI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org; spf=pass smtp.mailfrom=postmarketos.org; dkim=pass (2048-bit key) header.d=postmarketos.org header.i=@postmarketos.org header.b=KIY/eR+q; arc=none smtp.client-ip=95.215.58.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=postmarketos.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=postmarketos.org
Message-ID: <722a6cf2-7109-47e9-9957-cde5171d7053@postmarketos.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=postmarketos.org;
	s=key1; t=1761914574;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qBcoDhvBiRpbFrBHTGJxuS/5uthc7Xf+aqUT566+UzE=;
	b=KIY/eR+qz/ils6v60wWH3T/RCgqwFResSB+xZ1PPuel1IdiFSAwnlBnEUY9hsUabolKn8r
	4HD2rjsTLdTDtihF8ClUe0eGCsZvEr7xz5A4+iynARIoRSy/BuANrfHHp3zU0x6uQ7boy1
	5KabZw0ZcOxGQV1ZmXK0H/yroDAbfmfn7EBFBxZvdqblnqkfSUQmNS9lTK9Bo5Se0rIvuH
	99yRWEYAcxiCYNRLZT+Jyqtwg+wgpEwUTVmPrjhfS/bq2CzUHD9xrfLhozdvVQsW5yiVPW
	YmcF+Zynh7HLDEKdZCXwv6bYGmBBJqqhdmolF/XUiiEWjQN4uNdmK4AO8Z2VSQ==
Date: Fri, 31 Oct 2025 15:42:47 +0300
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 0/3] SDM630/660: Add missing MDSS reset
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>,
 Bjorn Andersson <andersson@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
 devicetree@vger.kernel.org, stable@vger.kernel.org,
 ~postmarketos/upstreaming@lists.sr.ht
References: <20251031-sdm660-mdss-reset-v1-0-14cb4e6836f2@postmarketos.org>
 <25579815-5727-41e8-a858-5cddcc2897b7@oss.qualcomm.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Alexey Minnekhanov <alexeymin@postmarketos.org>
In-Reply-To: <25579815-5727-41e8-a858-5cddcc2897b7@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT

On 31.10.2025 12:21, Konrad Dybcio wrote:
> On 10/31/25 3:27 AM, Alexey@web.codeaurora.org wrote:
>> Since kernel 6.17 display stack needs to reset the hardware properly to
>> ensure that we don't run into issues with the hardware configured by the
>> bootloader. MDSS reset is necessary to have working display when the
>> bootloader has already initialized it for the boot splash screen.
>>
>> Signed-off-by: Alexey Minnekhanov <<alexeymin@postmarketos.org>>
> 
> You git identity has two less/greater than symbols
> 
> Also.. thunderbird argues there's two of you:
> 
> 
> Alexey@web.codeaurora.org
> Minnekhanov@web.codeaurora.org
> 
> plus.. I thought codeaurora was long dead!?
> 
> My DNS certainly doesn't know about web.codeaurora.org specifically
> 
> Konrad

This is a result of me first time trying to use b4 and misconfiguration
of git: user.email contained my email inside '<' and '>' which somehow
caused the prep/send process to generate emails with broken half-empty
"From:" field, containing only name and surname without email. And then
perhaps email server closer to your side decided to "fill the gaps" and
append some non-existent web.codeaurora.org part? At least I don't have
any better guess.

I will send v2 later and hopefully get this all fixed.

--
Regards,
Alexey Minnekhanov

