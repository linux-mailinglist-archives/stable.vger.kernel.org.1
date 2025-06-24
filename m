Return-Path: <stable+bounces-158327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2BF8AE5D66
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 09:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFA591B67C33
	for <lists+stable@lfdr.de>; Tue, 24 Jun 2025 07:06:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A6DF24BD0C;
	Tue, 24 Jun 2025 07:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="dnjygAVk"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4BB25178E
	for <stable@vger.kernel.org>; Tue, 24 Jun 2025 07:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750748743; cv=none; b=XLyJWQaMqu/UlU4H+y/sT00ihd7VDdikisffY8fn48b4m84qpFNJXkp9dZmiSCUlNNKOtWep/tt98ZHEUpnPen6Hy1rjxPiaAXLb7vECOAz3ENL4RwFI5jCXNDqW1nvPJwNlqIGYmiNmPFTlBFcphW+7nnsnPBds7zoOBGOMeHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750748743; c=relaxed/simple;
	bh=tN67BDAOSxZdQPOy30D76pcs+GGsTpdAwHuepvVa+oc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dESHKtH7OiCrJIvNp1lq1MNVqqJYw8rbR65semPoLsYqlux0YaCAjlwfSdyyxhLMdxcVp4NfA1+jNAL9fDegXtOPFC6B4s7rPnrX1PASXPhTjwJIOmqDjTvFVtMDGKp4adG7mOSg1vp+doxnniHqMHQw31jMWtm2eMbZkEMjrYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=dnjygAVk; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <8dbd9d73-1177-42fc-aa84-78139d957378@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1750748734;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SUoi+2OlC2aQa5hyo+5HNZumGUBskm0Qpw9bQKHsVSE=;
	b=dnjygAVk4vzQYp03vkOa3a/jagrfvfloHduNqtBC9nF8NxTfVQMBFtVkDqC+ctr+yr7FS6
	X8j3u/1KgtNTnRWRNczjd4n0gCzyX2pd+m472o/GmAxZfuGOKJa0226RNEgvge/a+mda94
	2GjSiq6KCIiC6/OE2cp1l0AjqzqcRe1oX/GWNll4Advsu4Ctl/zFK/8GNb1iz1d0v6YG24
	+SALCjDHVwM29b89svD/ez2vgawIxKLlNSEyDorAcnee3PKGZ5ntMJTY9Bx+Vw+SghyRDs
	2CN+gCd9Kh6DQe4nl+0ykxBO0rdp0JCq6Zx/RoMIb2bQwLvGuQJ91nUGH/Qdag==
Date: Tue, 24 Jun 2025 09:05:31 +0200
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
 <722c3acd-6735-4882-a4b1-ed5c75fd4339@manjaro.org>
 <2025060532-cadmium-shaking-833e@gregkh>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <2025060532-cadmium-shaking-833e@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 6/5/25 10:46, Greg KH wrote:
> I have no context here, sorry...

Seems with 5.10.239-rc1 it compiles again just fine ...

-- 
Best, Philip

