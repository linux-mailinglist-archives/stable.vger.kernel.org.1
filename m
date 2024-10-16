Return-Path: <stable+bounces-86515-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD37E9A0D81
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 16:58:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E59BA1C2605C
	for <lists+stable@lfdr.de>; Wed, 16 Oct 2024 14:58:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C712620E009;
	Wed, 16 Oct 2024 14:58:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="OtoWv12r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A7E420C492;
	Wed, 16 Oct 2024 14:58:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729090713; cv=none; b=npNJcZHa1Fsa5DccZqNbRNiRUwT+oZ7eNo1bMEnjs77cT0KiVnuxFs8IhdZ+yo56L/JGryg2e8ieAcXEkjxzgMP5mUKvvNa85AlaD4p1sHPBr76A0abTx7gKgl318DYoToVpLaF5/Kv1aUitCLb3mPf4giJ0cL7jD+eah75/Cjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729090713; c=relaxed/simple;
	bh=U0kK9JB00GjDzBymAbtn/1sXD+If6peJW3l71eQh98s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QwHadSTdEqT2wIcY3nqeXJ4b68wIIHurcNIoyMROxVN0ad4G+n0myOgfyRZOYYtWy/RGQwRTdctsr3mrZSYAVLQ2hG9Wt1BLTgvGqu80G3YjUUI7QDNVs835D8gbE2WwkhPU7ee9mCkSTazs2fjTpbJeY/y+OAyRpVYa/ahqakM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=OtoWv12r; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED2B2C4CECF;
	Wed, 16 Oct 2024 14:58:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729090712;
	bh=U0kK9JB00GjDzBymAbtn/1sXD+If6peJW3l71eQh98s=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=OtoWv12raGMw7ZVMCR3YdQEt7FsEHe3zD9LD2a9Poperw/umds/47uCHBzqL4mzh1
	 fUANp9HXdNDe2R898rIz9gZNsrK3SW9plQjuLuBnSI1UymdBFCkrqTgycFBEKAIBj9
	 Z1suynLY7R4BcFzsTUrJoXYXBlW8istUXrBCDnv8=
Date: Wed, 16 Oct 2024 16:58:29 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Joel GUITTET <jguittet.opensource@witekio.com>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>,
	Jay Buddhabhatti <jay.buddhabhatti@amd.com>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Sasha Levin <sashal@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: Bad commit backported on the v5.15.y branch ?
Message-ID: <2024101632-outspoken-tabby-8ad9@gregkh>
References: <AM9P192MB1316ABE1A8E1D41C4243F596D7792@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
 <06bab5c5-e9fd-4741-bab7-6b199cfac18a@leemhuis.info>
 <AM9P192MB131641B00A0EB08E81A24801D7462@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
 <2024101626-savings-ensnare-1ac2@gregkh>
 <AM9P192MB13167529B6C73DC8686C2F86D7462@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <AM9P192MB13167529B6C73DC8686C2F86D7462@AM9P192MB1316.EURP192.PROD.OUTLOOK.COM>

On Wed, Oct 16, 2024 at 01:13:42PM +0000, Joel GUITTET wrote:
> > Because it has a "Fixes:" tag on it.  Is that tag not correct?
> 
> understood why it's backported. Probably yes. Or maybe another commit should be introduced to not create a new issue.

Perhaps, but I have no clue what is going on here, sorry.

Is this an issue in Linus's tree?  Is it in the other stable releases?
If not, are we missing a change?  Or does the issue show up there as
well?

> > What "original message"?
> 
> My original message in this mailing list, see below commands that show the problem (last line is wrong):
> 
> cat /sys/devices/system/cpu/cpufreq/policy0/scaling_available_frequencies
> 299999 399999 599999 1199999
> 
> echo 399999 > /sys/devices/system/cpu/cpufreq/policy0/scaling_setspeed
> 
> cat /sys/devices/system/cpu/cpufreq/policy0/scaling_cur_freq
> 399999
> 
> cat /sys/devices/system/cpu/cpufreq/policy0/cpuinfo_cur_freq
> 299999 ====> Should be 399999

Ok, so someone needs to tell me what to do here as I'm confused :)

thanks,

greg k-h

