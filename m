Return-Path: <stable+bounces-35576-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id F18B2894E84
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 11:21:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 908821F22574
	for <lists+stable@lfdr.de>; Tue,  2 Apr 2024 09:21:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5059F5731E;
	Tue,  2 Apr 2024 09:21:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="P9zSsXeP"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C11617C7C
	for <stable@vger.kernel.org>; Tue,  2 Apr 2024 09:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712049664; cv=none; b=ERXxqeZKaSWDwv0MvLyf5lISytA8FAgIMGA04ykwr5GnIwjhkyOWJ0lZzd4kPcPrejW39gMiI0Wdbty96e7KYue8U/2jEKQh1LKIiZIsHI+jOhCcVKRiNwCZAvRN5920UkFmraTk9IUR9JCqyQx5+6NKe/my+GTEfCK3IVsew60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712049664; c=relaxed/simple;
	bh=kU4w9mZPkArpd/1WTe+18dIYLHxqOq2xXdxJatGF8aE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=svEkP84TR5dUpZJXoNn95FapbZVGPel7ZHKi2slzjsQKIHFnfUvTf0fVgQdoIfzTyQFSFYJkHrW64Lh7DI74SHI18RPGBfOInae/SQj2pKUJPVWhMj+KcUmC815DQbf8WFnRthzlKvV1cyD0BnfCTkcgxn0YCRI5EwnhnybSCsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=P9zSsXeP; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <b03bb68c-0244-4780-8e65-8aa3b15aab0b@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1712049658;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XjSVpZBaGmwIAT1/iQs1HK4kXx1CR1ldX0l8Um+nGRU=;
	b=P9zSsXePkCUpllTsdbisEss7tT+1wD0p8Pq5Vff4aRUjwmJqrdH6xV0/LFzHqmLNoxxjOh
	Tr/HeBFOtqQ9Ks3JLjWNwqCdUCKcBGLeC6Yes/vwS83GbRmuXrrFCvNLMXrDkClBMoqHXJ
	/6DRlwE9sBB2TMp9aB75rtl4O+TYZKwyL086+QbZZ0FIFcxp01Estn7FocxXJau2iYXwo2
	NGMQFEsm1hK80+LERX5eMaIMlp3BrNUKWjXAlAfRjbzIow29X11MJjvAWfzdKhLueQ/+46
	YyrGgCNu9wD2N2spMzb1fnoVFllEhxzNPhDJujWoLCShE67qxAOX0b8Hugeb1g==
Date: Tue, 2 Apr 2024 16:20:52 +0700
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Regression] 6.8 - i2c_hid_acpi: probe of i2c-XXX0001:00 failed
 with error -110
To: Hans de Goede <hdegoede@redhat.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
References: <9a880b2b-2a28-4647-9f0f-223f9976fdee@manjaro.org>
 <a587f3f3-e0d5-4779-80a4-a9f7110b0bd2@manjaro.org>
 <2ae8b161-b0e6-404a-afab-3822b8b223f4@redhat.com>
 <fea82ffc-a8fe-4fab-b626-71ddd23d9da7@manjaro.org>
 <122c6af1-b850-4c21-927e-337d9cef6d9c@redhat.com>
 <b41ea2c9-9bf3-4491-ac20-00edfc130a87@manjaro.org>
 <599f96d2-31d6-49ac-9623-1dd03c5407a2@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <599f96d2-31d6-49ac-9623-1dd03c5407a2@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 02/04/2024 15:52, Hans de Goede wrote:
> Hi Philip,
> 
> Someone else has hit the same problem and has correctly pinpointed
> it to another commit (in the same series) and submitted a fix
> upstream:
> 
> https://lore.kernel.org/linux-input/20240331182440.14477-1-kl@kl.wtf/T/#u
> 
> I'll be reviewing this patch shortly.
> 
> Regards,
> 
> Hans

Hi Hans,

I already tested that patch and it works.

-- 
Best, Philip


