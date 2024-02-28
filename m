Return-Path: <stable+bounces-25335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E604F86A94A
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 08:53:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 84A5E1F27B61
	for <lists+stable@lfdr.de>; Wed, 28 Feb 2024 07:53:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 009E625602;
	Wed, 28 Feb 2024 07:53:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="v0viYl+t"
X-Original-To: stable@vger.kernel.org
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [80.237.130.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 632AD2261B;
	Wed, 28 Feb 2024 07:53:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.237.130.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709106796; cv=none; b=H2pOkSy37kJ2YOvlj0U9w2iBNgUzSYs4UqhtEK6SCVSnpf5V8h/+vLfDkFbiDV+5M2v62qsnYb5qX/4AjXooY6V9fZtKEAuish/0C/KZWezuX+T2KYMhR3Dg8AE69utpJ91FXoMga9txr/u6VfxGSSfgIRZ9cx5iyi55TQn9Rnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709106796; c=relaxed/simple;
	bh=/CB87PZsQRl9/B/ojYajPpKXTTCyk5T3TFwmjwz24zM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oJBK2gUDNTXr0N8mO90B6C4UijT3pDl1MNVbmk3t3CUlxmY31v+OSjpqVvIiciP8sKeLWxtm4Ef0MHrW63HPuIaWDAW4LiiqWLGaxDVU4NrkzOA6WiO2wjlqOkHA6xNllJDSzy0KeMsYS6B1Svl13PWQ1HX7V36QoLx45frbZ4E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=v0viYl+t; arc=none smtp.client-ip=80.237.130.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=leemhuis.info; s=he214686; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:From:Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:
	Content-Type:Content-Transfer-Encoding:Content-ID:Content-Description:
	In-Reply-To:References; bh=ksrtzWPsmCGb+8bRwyY45vlNzPF39f6u8k11zRKewW8=;
	t=1709106794; x=1709538794; b=v0viYl+tbOf4uMZCFZsurNMX/CHchxr8mFc6cbb9cvwTrNf
	fbBgIHetW7mOz2NZEelHhUutJEGIMJnDqsmPka8szSvSoFkYglOWPkNNgR6EnIqXqpj6UofNs2ubg
	xu3BkiARsBj9CoDVf424M0ToV1An6EXpcI28i2evjojTofC5d6ns1I2ao/6dF92IJkrh1IlKYRlxf
	R3P/id4lQiow/Eq0gu4XU7CmFCQYoEkCFZMfQ/iKgmgKd5TDggn1ra4Twd6hXYsMMX8t5o8dYpzik
	MVeB0bjp4POLb8Q8LqeltpP/dRyIA1J4zJOJTR0S7iHKuDdj2FomZuTk7aM9weiQ==;
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
	by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
	id 1rfEka-00018X-0P; Wed, 28 Feb 2024 08:53:12 +0100
Message-ID: <1c737d18-47c0-4323-9940-92cb6b961f92@leemhuis.info>
Date: Wed, 28 Feb 2024 08:53:11 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] NULL pointer dereference drm_dp_add_payload_part2
Content-Language: en-US, de-DE
To: "Lin, Wayne" <Wayne.Lin@amd.com>,
 =?UTF-8?Q?Leon_Wei=C3=9F?= <leon.weiss@ruhr-uni-bochum.de>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
 "lyude@redhat.com" <lyude@redhat.com>
References: <38c253ea42072cc825dc969ac4e6b9b600371cc8.camel@ruhr-uni-bochum.de>
 <CO6PR12MB548918C8F66468B947A06885FC512@CO6PR12MB5489.namprd12.prod.outlook.com>
From: "Linux regression tracking (Thorsten Leemhuis)"
 <regressions@leemhuis.info>
Reply-To: Linux regressions mailing list <regressions@lists.linux.dev>
In-Reply-To: <CO6PR12MB548918C8F66468B947A06885FC512@CO6PR12MB5489.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1709106794;96426a0e;
X-HE-SMSGID: 1rfEka-00018X-0P

On 19.02.24 08:24, Lin, Wayne wrote:
> 
> Thanks for the catch! Will prepare a patch to fix it.

Did you do that? I could not find one on lore, but maybe I'm missing
something.

Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
--
Everything you wanna know about Linux kernel regression tracking:
https://linux-regtracking.leemhuis.info/about/#tldr
If I did something stupid, please tell me, as explained on that page.

#regzbot poke

> ________________________________________
> From: Leon Weiß <leon.weiss@ruhr-uni-bochum.de>
> Sent: Wednesday, February 7, 2024 16:45
> To: stable@vger.kernel.org
> Cc: regressions@lists.linux.dev; Lin, Wayne; lyude@redhat.com
> Subject: [REGRESSION] NULL pointer dereference drm_dp_add_payload_part2
> 
> Hello,
> 
> 54d217406afe250d7a768783baaa79a035f21d38 fixed an issue in
> drm_dp_add_payload_part2 that lead to a NULL pointer dereference in
> case state is NULL.
> 
> The change was (accidentally?) reverted in
> 5aa1dfcdf0a429e4941e2eef75b006a8c7a8ac49 and the problem reappeared.
> 
> The issue is rather spurious, but I've had it appear when unplugging a
> thunderbolt dock.
> 
> #regzbot introduced 5aa1dfcdf0a429e4941e2eef75b006a8c7a8ac49
> 
> 

