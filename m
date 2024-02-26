Return-Path: <stable+bounces-23599-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 72A67866962
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 05:31:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0260EB2169B
	for <lists+stable@lfdr.de>; Mon, 26 Feb 2024 04:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD93320A;
	Mon, 26 Feb 2024 04:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="SPU7WXYR"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A3A125DB
	for <stable@vger.kernel.org>; Mon, 26 Feb 2024 04:31:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708921868; cv=none; b=q3C8OhhQgbTY8rOIXrWREhESovh2egWw+ZhFVzqn3XjQqSJkaAG2T0j+aa/WEW7fGzCzmef/bm6TbYXRnqw4saqIJiy1+9lMwF0XHO5QxfP3YhWYfTTbt17ZomtaS1TksiZfz2fwDN+eys5HNGg01cnwDQckU0UCOXp0EEEMIAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708921868; c=relaxed/simple;
	bh=n+ptJMkQ8lDESk31z6MeXClp7ZjxB3MbOI/JzboBL0M=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Pv2HQaBvpGVN4JRYjQcqrag+nkiZIIEf4Nm5oTjhrg7qy8WNFIxx2wS8CKDjlX2738urpAlfnAKy2ucdEBy21IUXp1Vd/iVV1HzDNy0cifHKloj7ooqBcHAGng/pV/Ib+qUcEHtrjUSf82JTN/yf304zPAvZspIbQ2jdudo4D2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=SPU7WXYR; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <38163fd8-1171-4c73-93b5-a66e2c292a15@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1708921864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Df9XJpdWXvibF0Psk3yqeOm6VjbIc40eT3KnIa51Q3g=;
	b=SPU7WXYRjf09rqJEpSTXs+FkWMrdaE34wDT3PLpgqsEoyIpAbStoJUWg9hUxEQztFE2ycS
	0VUyO+zPqrSjL2eHwbfetCsTW3aQHFoN1q5q2rXgy0ccJVuJMus+rHgVRBhec6t3hI9s6p
	lCa3T829AaVuuoWUeAuhqg473SPlUdbM0n/zdgGFKpD9dTzmTS/8UBenAgRFdDkMPEPAPV
	4h0JSGLz7OptZ7DLkSY6TuEaivt6nwP8Fvdqp+MqlJGJ6rN5aESiMudw/yr/+5nc05lQ51
	D3+4JDLkZ1z7pluLP2dlSb1WxNvqnPqqtTSrOo+OAa0vGdQ8ttHU0wCiROQPRg==
Date: Mon, 26 Feb 2024 11:31:00 +0700
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
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
 'Roman Gilg' <romangg@manjaro.org>, Mark Wagie <mark@manjaro.org>
References: <0ca1f9f0-6a09-4beb-bbdb-101b3fc19c45@manjaro.org>
 <2024022453-showcase-antonym-f49b@gregkh>
 <fa878f45-3b59-40e5-b909-29dc0b1acd11@manjaro.org>
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <fa878f45-3b59-40e5-b909-29dc0b1acd11@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

On 26/02/2024 11:28, Philip Müller wrote:
> Full build log of 5.4.269 can be found here:
> 
> https://pipelinesghubeus25.actions.githubusercontent.com/IX0HkTGyy7sqAEfMIwU74grK3vJhhYEQ6R3IOeb6PZvzd3ERQo/_apis/pipelines/1/runs/193/signedlogcontent/2?urlExpires=2024-02-26T04%3A26%3A26.8692425Z&urlSigningMethod=HMACV1&urlSignature=Wmey7xXmswXsqnn%2Fd1SD2cQ%2FM2A62bQ8rW3M0sOJntc%3D

Seems github has some session tokens which expire. Log download should 
be possible thru here:

https://github.com/manjaro-kernels/linux54/suites/21057183037/logs?attempt=1

-- 
Best, Philip


