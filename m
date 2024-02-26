Return-Path: <stable+bounces-23598-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C344D86695F
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 05:28:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C280D1C212DD
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 04:28:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119A0199DC;
	Mon, 26 Feb 2024 04:28:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="ceAQ1rFW"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BFCB1947E
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 04:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921722; cv=none; b=TN/FgJlmsYm2Q3KtoFCk/qPMv+Jynzel45tuEe3ovxhuVuqlrmgLf/nuVTCXrz1wEABddMar/qjTsEx0YbPm8Yk27BO4EAXX3I0J/LPln0FoVYYboLatnEJ4evZK8uADqySuHUv6lBezta2JCdHxuETieJxc9VtHy0i5vpvGJWo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921722; c=relaxed/simple;
	bh=AF+uR3pQ9Hx8cz0BuZcu8o2LVnFFSm7wOphYeYVsrJE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UgFP969jwd0H4rm1eQP4P92jNTDYKcsw0860I03UJ/3EOFlJNm07i58reBg/Bkxf8iTezV38I+Pd+MJEnWHqRtz/sydOARPALMr6C93d118ZNGJnoUgWtxBdZPb5pKvlwZBtGpSspuGX/mi9znMKK1u1npxnWXYPY5UX6Le1+Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=ceAQ1rFW; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <fa878f45-3b59-40e5-b909-29dc0b1acd11@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708921716;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DCCNqyfBm5Bv5Uz2neWfDS1ewcwWAynnTOpcYHGEalI=;
	b=ceAQ1rFW2za8QbKvRre7xNZfrdkav9THDQU2PktbZCEbm6pgxXxac3UoIfRu4QXBlB1P4e
	kT8YCB3wYgPlQYRj+21i7AomrA1yWTDAdCs0C3F0Ox3eHZMheislxcQVowLWjH9tqQJsU1
	E5JkXdsAzfapcfTQDINyO4kX8dXOxvBjcmZqyVQCXrOAcwP7iXGKzNC9chD2iXpE2Ug0zY
	16HXwbeQ+0VCbvK2PncR/bcZt9XGvUfnRnfwXpPMcGX1j3Bk/zGO8quH6i/Jc4JGhjA0Yk
	83YlvAmapjPRQDpCQ48JGGWl00RsfLBxIf2mIC6vilOdWqr4p1rUq0jm2moU+g==
Date: Mon, 26 Feb 2024 11:28:33 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: =?UTF-8?Q?Re=3A_=5BRegression=5D_5=2E4=2E269_fails_to_build_due_to_?=
 =?UTF-8?Q?security/apparmor/af=5Funix=2Ec=3A583=3A17=3A_error=3A_too_few_ar?=
 =?UTF-8?B?Z3VtZW50cyB0byBmdW5jdGlvbiDigJh1bml4X3N0YXRlX2xvY2tfbmVzdGVk4oCZ?=
Content-Language: en-US
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 'Roman Gilg' <romangg@manjaro.org>, Mark Wagie <mark@manjaro.org>
References: <0ca1f9f0-6a09-4beb-bbdb-101b3fc19c45@manjaro.org>
 <2024022453-showcase-antonym-f49b@gregkh>
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <2024022453-showcase-antonym-f49b@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 24/02/2024 16:11, Greg Kroah-Hartman wrote:
> 
> Odd line wrapping :(
> 
> Anyway, what config options are you using?  I can't see this here and
> none of the CI systems caught it either.
> 
> thanks,
> 
> greg k-h

The config should be this one:

https://gitlab.manjaro.org/packages/core/linux54/-/blob/cb28712a0dd32966c25b3d1463db29fec4c4157f/config

Latest functional build was 5.4.268:

https://github.com/manjaro-kernels/linux54/releases

Full build log of 5.4.269 can be found here:

https://pipelinesghubeus25.actions.githubusercontent.com/IX0HkTGyy7sqAEfMIwU74grK3vJhhYEQ6R3IOeb6PZvzd3ERQo/_apis/pipelines/1/runs/193/signedlogcontent/2?urlExpires=2024-02-26T04%3A26%3A26.8692425Z&urlSigningMethod=HMACV1&urlSignature=Wmey7xXmswXsqnn%2Fd1SD2cQ%2FM2A62bQ8rW3M0sOJntc%3D

I will check if reverting the patch I think might create this issue 
might fix it. Let's see ...

-- 
Best, Philip


