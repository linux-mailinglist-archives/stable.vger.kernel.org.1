Return-Path: <stable+bounces-202874-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D687CC88D2
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 16:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5CED030CDB20
	for <lists+stable@lfdr.de>; Wed, 17 Dec 2025 15:38:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D8D361DB6;
	Wed, 17 Dec 2025 15:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B0utsZBg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BF4361DA8;
	Wed, 17 Dec 2025 15:27:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765985252; cv=none; b=fedxDvFqvmoUf3MpHYn5bDxK1IXsN9wPkBnGfEiouDfwTwNN8W3pRwX9wCyPS5XQkQPm8arOQlHOdewrgJnqTU4SA5sirLZqiB49IwQxIuJn+7ox7DNc+IRU+DjSWQLErg80jC8TV8sVEPoPP960KXzhE5wQGLYQnVKQPGeiFag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765985252; c=relaxed/simple;
	bh=yHyHmJzj1N4dPdLvlWcKEa/rUqIPPBZYGsgpC88mxNc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=iJHiQ4DIXa4JpPN/ZnKQvjuTR+da8Ofk/fRTyVOzKOMETBBjjF1J3/3/6KK4QnE5aa7BesLY+vyl4S0WqnaraSY6pl3kehAZ7mAjlD73eV5/teOrH+VidRRSXCWyjO4bqJHV9aYlH+VfMOVugOBF1Wi2a9hg1gy2Yzki47e8z7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B0utsZBg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D523CC116B1;
	Wed, 17 Dec 2025 15:27:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765985251;
	bh=yHyHmJzj1N4dPdLvlWcKEa/rUqIPPBZYGsgpC88mxNc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=B0utsZBg1lREtZc9UKsb5d83kUb/0DB8MwjFbUl64CEDPTVPHqzARSF/baiAf7Fzf
	 TEz6ezejFS8zm3AaMsjBHJyb18yEihZMcdwIj6blKL3VyIT8LoOOTnYozrEMnNxPWY
	 3M5xNtcqIOLzIyF9oIWdoHa5yOrOloHu8TzIiyEE=
Date: Wed, 17 Dec 2025 16:27:23 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: stable@vger.kernel.org, stable-commits@vger.kernel.org,
	Bjorn Andersson <andersson@kernel.org>,
	Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Subject: Re: Patch "clk: qcom: rpmh: Define RPMH_IPA_CLK on QCS615" has been
 added to the 6.17-stable tree
Message-ID: <2025121715-always-expenses-f48b@gregkh>
References: <20251213100953.4148111-1-sashal@kernel.org>
 <b8087506-7cd5-48b2-9564-8788d55e0b08@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b8087506-7cd5-48b2-9564-8788d55e0b08@oss.qualcomm.com>

On Tue, Dec 16, 2025 at 01:04:33PM +0100, Konrad Dybcio wrote:
> On 12/13/25 11:09 AM, Sasha Levin wrote:
> > This is a note to let you know that I've just added the patch titled
> > 
> >     clk: qcom: rpmh: Define RPMH_IPA_CLK on QCS615
> > 
> > to the 6.17-stable tree which can be found at:
> >     http://www.kernel.org/git/?p=linux/kernel/git/stable/stable-queue.git;a=summary
> > 
> > The filename of the patch is:
> >      clk-qcom-rpmh-define-rpmh_ipa_clk-on-qcs615.patch
> > and it can be found in the queue-6.17 subdirectory.
> > 
> > If you, or anyone else, feels it should not be added to the stable tree,
> > please let <stable@vger.kernel.org> know about it.
> 
> Please drop from all queues, this depends on 
> 
> cbabc73e85be ("interconnect: qcom: qcs615: Drop IP0 interconnects")
> 
> and has no visible effect today (the IP block this resource drives is not
> enabled), however potentially handling it in two places could cause issues

Now dropped from all queues, thanks.

greg k-h

