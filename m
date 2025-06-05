Return-Path: <stable+bounces-151490-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5712EACE993
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 08:02:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D284176EE1
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 06:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CE61A5BB1;
	Thu,  5 Jun 2025 06:02:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b="aq3IYb8G"
X-Original-To: stable@vger.kernel.org
Received: from mail.manjaro.org (mail.manjaro.org [116.203.91.91])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF342AF19
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 06:02:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=116.203.91.91
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749103354; cv=none; b=Ug0yvsqlh6QuX7HSRCXbAAwklH0L9ySV2DDr9ezofdL0F5POOXCteCX2mMK8/WGcaP6+NEYGeVDEPCtWdUlApTNbSucnCOmeHhPJpWz/rN9VM7bhztm+ic+hxOV6eAT9T8MDi8NmaqBLC8xiZDHsEWgE+EbcWFWrhNIpfsBjXHk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749103354; c=relaxed/simple;
	bh=vwScGiCiq/hz+xTj9GxdpLPgzVvhG9F4SmG8AEjmTLA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=WMhcfPpWYjenv/KZ0GqhA2CJK37QQAz7HZg6VLfCnYKnTxEJKAqfB4SMB9mVfwg959TCgGkkbojt06Gm+oVhpLhxarkN3uIeEyISEwKkSLaDNv5DnP2WADkgdGZpJjr+1VSZqGObFGuqVX0eUUiPGgVGEYjso8JBFxWBIPV6scw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org; spf=pass smtp.mailfrom=manjaro.org; dkim=pass (2048-bit key) header.d=manjaro.org header.i=@manjaro.org header.b=aq3IYb8G; arc=none smtp.client-ip=116.203.91.91
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manjaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manjaro.org
Message-ID: <242541ee-4c8f-4d8f-973e-759a6027ce90@manjaro.org>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manjaro.org; s=2021;
	t=1749103350;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5395yabzN7VY8gjj/cgXwc9iL5MpEkMFEg6t/d8BCyE=;
	b=aq3IYb8GLUMEa/9bckrkTnX6sSzas9TjtE5/I4nlX4Z7Hv0gD49i9/zDLGtxbzFQBj0BgP
	4Z9z2EoP3W22nraHCYSom3Hl9nEm5O8o8NXVkEKLTvJXUJ/q+lhqpRMzIi+BWNGrp2k6QB
	0nCpXAzlKIcdA+8e1B/KdEtpfOctDmTHK+1N4dlMOmSjV96rMLiifq00Oxtx7TPDreo2m8
	aDwNkDOYMZdCGUCvBfGr/LWcR4ltgXBYRqaYGYnyCe2dj0vikverbuL5hlGWuMJppQh9sN
	C7SGp83RG4xuRar8ESdu0AAynw/9YeFLTP87TshI+3DR1jIUnoDXeQIJ45QdBw==
Date: Thu, 5 Jun 2025 08:02:29 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [Compiler Error] 5.10.238 - Werror=incompatible-pointer-types
From: =?UTF-8?Q?Philip_M=C3=BCller?= <philm@manjaro.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <3af41509-a243-4b64-8c49-af7263be22ef@manjaro.org>
 <19a68e9f-584c-4d9e-aace-c3764725aa0a@manjaro.org>
Content-Language: en-US
Organization: Manjaro Community
Disposition-Notification-To: =?UTF-8?Q?Philip_M=C3=BCller?=
 <philm@manjaro.org>
In-Reply-To: <19a68e9f-584c-4d9e-aace-c3764725aa0a@manjaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results: ORIGINATING;
	auth=pass smtp.auth=philm@manjaro.org smtp.mailfrom=philm@manjaro.org

Sorry for the noise. Was a downstream issue. After removing some 
outdated patches it worked on all affected series.

-- 
Best, Philip

