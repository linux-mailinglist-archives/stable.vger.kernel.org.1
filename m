Return-Path: <stable+bounces-104508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F19DC9F4DBE
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 15:30:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C19F91892B86
	for <lists+stable@lfdr.de>; Tue, 17 Dec 2024 14:30:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F941F4E3D;
	Tue, 17 Dec 2024 14:30:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b="EhcwMDwA"
X-Original-To: stable@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8823F1F4E43
	for <stable@vger.kernel.org>; Tue, 17 Dec 2024 14:30:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734445836; cv=pass; b=Dcqt8em6w3Z09MT+BVKHRJNOM+/CUHtLUKAXQlsSD9mS6a5I1YJ4hFAF71NmfEYkkKKU1yVzPKb0y41UZRt/OaiTKt71C5BcBXL4gtKHgySHy99jZnP9vw2FCaEL/3iJD92xZFgmq47ZFWKlITeQO7cVEhFNaE2cUF8rfaxbWMU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734445836; c=relaxed/simple;
	bh=fruQXCF6KTFOrpcWHMIPtKjUstcqX+WDjwatZjvsE7w=;
	h=Date:From:To:Cc:Message-ID:In-Reply-To:References:Subject:
	 MIME-Version:Content-Type; b=sOfLboAc1OnxtgP9r3H3RKluiiAPE9l+iRgK4TapFgpfhqsX6pzhGSys4X8YgO+vZOX9uL8InG0Aeq3/odwmYWd+navszQjPVu/RrYKaemzlhf1coYDtfTF4dKmHd2QAG3u4OoK63vE4AmaBQYXLRlqcSzL8vIP76RChRxaZSZw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=gus@collabora.com header.b=EhcwMDwA; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1734445822; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=imdBLXfn/iBetUHgUnFZX0EL4dQZ+744kLNTJ2A+cwygpIq+74hVi4HfoiII72A83rFXUS5usfKVza5+2dzV5dpdauXQKZtrxFiRD3p0kWRE6JNx6a+pAZRrAMorGoGjkUZC0JmJb7REN5jvpVMlB5O0aXslN1KBvtJ7mspGHBI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1734445822; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=9F3o0PDXckrveXwOcf4uxqjhIm5/PDfN4FzpORJBiLk=; 
	b=DtGyM2F6DZ8P2/Vo9iWXtZh7zRthvJZGElOskBIujqC2W5Cn2HrdsBKnDPl+Q4Om9HsdKfQlt0DX+cihn18JkV2ltXyvowjVmqq0gvsNdJl74ZMD2RdhuyknyYr+a6fTsVNzEVijJEfinjuWKR8IbhkmkVkBgpdlMQMnIyWfHSQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=gus@collabora.com;
	dmarc=pass header.from=<gus@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1734445822;
	s=zohomail; d=collabora.com; i=gus@collabora.com;
	h=Date:Date:From:From:To:To:Cc:Cc:Message-ID:In-Reply-To:References:Subject:Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=9F3o0PDXckrveXwOcf4uxqjhIm5/PDfN4FzpORJBiLk=;
	b=EhcwMDwATjQyjzQdaxq7HNwOD7Iy72Oa5V0NAirgU3rHrZQ5Hk3fM5hnoezthGT+
	FtXw27QI6laE/cRjDAryYlYJ0WMPC8JsSKJ+2UYlNYgI2dxy0uD5y4+/A4ODOxcYJOo
	NVpnFnhbnonQ/l8Zr3Ag5+jtNL5YE3G2Fv+Bdz1k=
Received: from mail.zoho.com by mx.zohomail.com
	with SMTP id 1734445819769597.4882383729658; Tue, 17 Dec 2024 06:30:19 -0800 (PST)
Date: Tue, 17 Dec 2024 11:30:19 -0300
From: Gustavo Padovan <gus@collabora.com>
To: "Greg KH" <gregkh@linuxfoundation.org>
Cc: "sashal" <sashal@kernel.org>,
	"kernelci lists.linux.dev" <kernelci@lists.linux.dev>,
	"stable" <stable@vger.kernel.org>,
	"Engineering - Kernel" <kernel@collabora.com>,
	"Muhammad Usama Anjum" <usama.anjum@collabora.com>
Message-ID: <193d506e75f.b285743e1543989.3693511477622845098@collabora.com>
In-Reply-To: <2024121731-famine-vacate-c548@gregkh>
References: <193d4f2b9cc.10a73fabb1534367.6460832658918619961@collabora.com> <2024121731-famine-vacate-c548@gregkh>
Subject: Re: add 'X-KernelTest-Commit' in the stable-rc mail header
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail



---- On Tue, 17 Dec 2024 11:15:58 -0300 Greg KH  wrote ---

 > On Tue, Dec 17, 2024 at 11:08:17AM -0300, Gustavo Padovan wrote: 
 > > Hey Greg, Sasha, 
 > > 
 > > 
 > > We are doing some work to further automate stable-rc testing, triage, validation and reporting of stable-rc branches in the new KernelCI system. As part of that, we want to start relying on the X-KernelTest-* mail header parameters, however there is no parameter with the git commit hash of the brach head. 
 > > 
 > > Today, there is only information about the tree and branch, but no tags or commits. Essentially, we want to parse the email headers and immediately be able to request results from the KernelCI Dashboard API passing the head commit being tested. 
 > > 
 > > Is it possible to add 'X-KernelTest-Commit'? 
 >  
 > Not really, no.  When I create the -rc branches, I apply them from 
 > quilt, push out the -rc branch, and then delete the branch locally, 
 > never to be seen again. 
 >  
 > That branch is ONLY for systems that can not handle a quilt series, as 
 > it gets rebased constantly and nothing there should ever be treated as 
 > stable at all. 
 >  
 > So my systems don't even have that git id around in order to reference 
 > it in an email, sorry.  Can't you all handle a quilt series? 

We have no support at all for quilt in KernelCI. The system pulls kernel
branches frequently from all the configured trees and build and test them,
so it does the same for stable-rc.

Let me understand how quilt works before adding a more elaborated
answer here as I never used it before.

- Gus


