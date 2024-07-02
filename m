Return-Path: <stable+bounces-56335-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E4DDC9239C2
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 11:23:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5A48281353
	for <lists+stable@lfdr.de>; Tue,  2 Jul 2024 09:23:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E0150994;
	Tue,  2 Jul 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="w3RCObYu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A23EB14039D;
	Tue,  2 Jul 2024 09:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719912188; cv=none; b=B6TIgeuYTOrzvu2+cERHYFLXzp0ieTfN8ROeXvCct5xKLyX0dKUIBBoA09hJeu50arjj7IaTFrhBZ8scmlT/wLTntR138f4HJIoFKlBDU5ty828EMbyP/0aFiqEC9bWbZYCFJMQiKgL+6omHkXvBA4IW1dyERFC/+JiDKUJUmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719912188; c=relaxed/simple;
	bh=fvBgyHVx8lerUt4pRwq0j/4HkKCsNdFkbt0Du2sotNw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=i8l3YV9MNXJS//RIY43G61JodBhHkDwbDcndU1y+VPl5bRFXoCTVATtRPYvWZAD0aZmui36C0UBDUeeo3v1LsK77Sju4ieEyxucno6VQZGiiECyOH9TIsHuyCL7jZsVj3iPL11YJRZ0SVVTLrcdNmG26qnMBmYPjwV8rhQM78nU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=w3RCObYu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B319DC116B1;
	Tue,  2 Jul 2024 09:23:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1719912188;
	bh=fvBgyHVx8lerUt4pRwq0j/4HkKCsNdFkbt0Du2sotNw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=w3RCObYuv7sGeSSQFKrzyzEXwOKh998P2r5kCgX3h4h4Bq1P8JSX0Ae8EynVpBhQ5
	 HpiYGrqb/14rhvNjqEQY0N/OZT3kz+6QjzDudw2n0S0iu9M84DNjuFndkFahcqDrGz
	 Wra9UnXl17nqgs3vA//QRwyBVRkjzCuSolM1HgS0=
Date: Tue, 2 Jul 2024 11:23:05 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: Lars Wendler <wendler.lars@web.de>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	"Huang, Ray" <Ray.Huang@amd.com>,
	"Yuan, Perry" <Perry.Yuan@amd.com>,
	"Shenoy, Gautham Ranjal" <gautham.shenoy@amd.com>,
	"Du, Xiaojian" <Xiaojian.Du@amd.com>,
	"Meng, Li (Jassmine)" <Li.Meng@amd.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: linux-6.6.y: Regression in amd-pstate cpufreq driver since 6.6.34
Message-ID: <2024070258-popper-unheard-3592@gregkh>
References: <20240701112944.14de816f@chagall.paradoxon.rec>
 <SJ2PR12MB8690E3E2477CA9F558849835ECD32@SJ2PR12MB8690.namprd12.prod.outlook.com>
 <7f1aaa11-2c08-4f33-b531-331e50bd578e@amd.com>
 <20240701174539.4d479d56@chagall.paradoxon.rec>
 <fd892ad7-7bf9-4135-ba59-6b70e593df4e@amd.com>
 <20240701181349.5e8e76b8@chagall.paradoxon.rec>
 <18882bfe-4ca5-495c-ace5-b9bcab796ae5@amd.com>
 <2024070251-victory-evacuate-1b56@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024070251-victory-evacuate-1b56@gregkh>

On Tue, Jul 02, 2024 at 11:15:14AM +0200, Greg Kroah-Hartman wrote:
> On Mon, Jul 01, 2024 at 04:53:20PM -0500, Mario Limonciello wrote:
> > On 7/1/2024 11:13, Lars Wendler wrote:
> > > Hello Mario,
> > > 
> > > Am Mon, 1 Jul 2024 10:58:17 -0500
> > > schrieb Mario Limonciello <mario.limonciello@amd.com>:
> > > 
> > > > > I've tested both, 6.9.7 and 6.10-rc6 and they both don't have that
> > > > > issue. I can disable CPU boost with both kernel versions.
> > > > 
> > > > Thanks for checking those.  That's good to hear it's only an issue in
> > > > the LTS series.
> > > > 
> > > > It means we have the option to either drop that patch from LTS kernel
> > > > series or identify the other commit(s) that helped it.
> > > > 
> > > > Can you see if adding this commit to 6.6.y helps you?
> > > > 
> > > > https://git.kernel.org/superm1/c/8164f743326404fbe00a721a12efd86b2a8d74d2
> > > 
> > > that commit does not fix the regression.
> > > 
> > 
> > I think I might have found the issue.
> > 
> > With that commit backported on 6.6.y in amd_pstate_set_boost() the policy
> > max frequency is nominal  *1000 [1].
> > 
> > However amd_get_nominal_freq() already returns nominal *1000 [2].
> > 
> > If you compare on 6.9 get_nominal_freq() doesn't return * 1000 [3].
> > 
> > So the patch only makes sense on 6.9 and later.
> > 
> > We should revert it in 6.6.y.
> > 
> > 
> > 
> > Greg,
> > 
> > 
> > Can you please revert 8f893e52b9e0 ("cpufreq: amd-pstate: Fix the
> > inconsistency in max frequency units") in 6.6.y?
> 
> Sure, but why only 6.6.y?  What about 6.1.y, should it be reverted from
> there as well?

And have now done so.

