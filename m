Return-Path: <stable+bounces-151494-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 61A37ACEB0B
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 09:45:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CFF74189AF83
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 07:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA41C1F2C44;
	Thu,  5 Jun 2025 07:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="r4/mreHm"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 594211E89C
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 07:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749109496; cv=none; b=oS/58jElH91yTr8EWOVEq1cpc1KY82ejmO0a0qchrLFCLyW4EoGPJ0773bgS1+uDBqB3SZKdUNJ8zRF0jKGkLrjC2nVPV5zQvJBo1ZKlFkA4FQdwfrGevjZeyUc2VsHC+RyDRUj697mM9eKKGyfthSF0yPlbGGfy3XgrDxMGCCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749109496; c=relaxed/simple;
	bh=koo9KnNGzdg+j/9TTwOoECC8d6JubXwghoeL3jq8lFY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TH/EsbpgPQjg64TM1RCMBdHqyrBgrWVQa+EweuW9+hC+iGAfYswPlDg/fO06i1LSdpMeP+rSLuHREdVO9PohbsX4Uc7zzVpi0DsQ7cLDUrgwkXnViitMF3IqBPCzIj0I9Tb9Fu9usgdkS7YOopzHMMj+a2GFepP1NcVgTP5Ior4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=r4/mreHm; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <722c3acd-6735-4882-a4b1-ed5c75fd4339@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1749109491;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=b8263wLZF3ntjaVctoSl5LjGbGpmVNGsF5VmI0VpUBU=;
	b=r4/mreHm0aE0hRThmMlSXSM2WRqgAayrtD6/WSWiwDnyX4tXQ8/zcAFaqDhMy00m6vPiaw
	zFG888CUQHs7GcEOmHIDHxsibl4a34WRy+7JD9QexwC13eBX+4fAY7d7xkulqe9l+tbO/5
	RC+au1F16EGN2OUnS4vvuSzx7bgkL6gnDQtirQ/BNh7h3zcFe3BJfN4f3/ZOpKNEBSw2Rj
	P5bKII1nHPkFk9AvRXaCwHfl9VmdEd+rZYPEFGit6b0ZbID9qNjRhhLHvvPiGKwkLXIldJ
	OHOQqBvAWtvPzdIzicoa2YqSAqLYoVXZP4ZXweNXnlIP9xHdqsVMDm4Esoi39A==
Date: Thu, 5 Jun 2025 09:44:49 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Laura Nao <laura.nao@collabora.com>, stable@vger.kernel.org,
 Uday M Bhat <uday.m.bhat@intel.com>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
 <20250320112806.332385-1-laura.nao@collabora.com>
 <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org>
 <2025040121-strongbox-sculptor-15a1@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <2025040121-strongbox-sculptor-15a1@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 4/1/25 11:17, Greg KH wrote:
> On Fri, Mar 28, 2025 at 07:06:10AM -0400, Philip Müller wrote:
>> Yes, I can confirm that with the current stable-queue patches on top of
>> 5.10.235 it compiles. I only had to not apply the following patch
>>
>> ASoC: Intel: sof_sdw: Add support for Fatcat board with BT offload enabled
>> in PTL platform
> 
> I've dropped this commit from the queue now, thanks.
> 
> greg k-h

Somehow the issue came back with 5.10.238 ...

-- 
Best, Philip

