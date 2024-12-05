Return-Path: <stable+bounces-98865-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A9CC9E612B
	for <lists+stable@lfdr.de>; Fri,  6 Dec 2024 00:16:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D2FCA1883F76
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 23:16:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 629DC1BC099;
	Thu,  5 Dec 2024 23:16:03 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail.itouring.de (mail.itouring.de [85.10.202.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07DE918FDDA;
	Thu,  5 Dec 2024 23:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.10.202.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733440563; cv=none; b=gB42FCg56xqdWFnYaQ1TGlHOOFDy0ZVqkEabfJw58jt9k0tM+NZqEADtK4PHTrDSoO8qDnpgiedXzWdK5v3aCNi2bVMqDbrFLi1egq6HiNkuW1fgTKG6NsoldJCD2DCbcH5rgZbURCIR6difWw4H5/hHB+J2CQ9wtdjciUzKofw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733440563; c=relaxed/simple;
	bh=lmPFtm7sX2BDaxCzN+zLJFv35aQt4f7KGvOEqyRGoNg=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=ugFTH30a2tOc0Wp3a3jxs5X9Hx6P5KjceGO7FSkczJRZgoo1152a3mysrMrN1QDV0m05HpzYS2SwZYv/0SsMLQCyB0TLeOc8IEusKYW7SBFamv9cZNDy9EhOXHkEhzdGVpbuIyGniljJz/n4wJk2yqiMq0he9oMKJatJg2tYHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com; spf=pass smtp.mailfrom=applied-asynchrony.com; arc=none smtp.client-ip=85.10.202.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=applied-asynchrony.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=applied-asynchrony.com
Received: from tux.applied-asynchrony.com (p5b34725d.dip0.t-ipconnect.de [91.52.114.93])
	by mail.itouring.de (Postfix) with ESMTPSA id 6D14CC4BC;
	Fri, 06 Dec 2024 00:07:29 +0100 (CET)
Received: from [192.168.100.221] (hho.applied-asynchrony.com [192.168.100.221])
	by tux.applied-asynchrony.com (Postfix) with ESMTP id 203EF60187F25;
	Fri, 06 Dec 2024 00:07:29 +0100 (CET)
Subject: Re: Linux 6.12.2
To: Genes Lists <lists@sapience.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org
References: <2024120529-strained-unbraided-b958@gregkh>
 <bad6ec6fc4e8d43198c0873f2e92d324dc1343eb.camel@sapience.com>
From: =?UTF-8?Q?Holger_Hoffst=c3=a4tte?= <holger@applied-asynchrony.com>
Organization: Applied Asynchrony, Inc.
Message-ID: <01a7263b-3739-582e-aade-6d9d9495500d@applied-asynchrony.com>
Date: Fri, 6 Dec 2024 00:07:29 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <bad6ec6fc4e8d43198c0873f2e92d324dc1343eb.camel@sapience.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit

On 2024-12-05 23:04, Genes Lists wrote:
> On Thu, 2024-12-05 at 14:53 +0100, Greg Kroah-Hartman wrote:
>> I'm announcing the release of the 6.12.2 kernel.
>>
> 
> 6.12.1 works fine but 6.12.2 generates lots of errors during
> boot. Tried on several machines all exhibit the same issue. This one is
> an older lenovo laptop. They do boot and appear to be working but the
> boot errors are worrisome.
> 
> It's been several hours since 12.2.2 was released, so others may not
> have a problem?

As Linus has indicated in:
https://lore.kernel.org/stable/CAHk-=whGd0dfaJNiWSR60HH5iwxqhUZPDWgHCQd446gH2Wu0yQ@mail.gmail.com/

the problem is the missing commit b23decf8ac91 ("sched: Initialize idle tasks
only once"). Applying that on top of 6.12.2 fixes the problem.

We just encountered this issue in Gentoo as well when releasing a new kernel
and adding that patch has resolved the issue.

> Thought it best to share before I start to work on bisect. config and
> dmesg outputs attached.

No need to, just add b23decf8ac91 :)

cheers
Holger

