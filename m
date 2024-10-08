Return-Path: <stable+bounces-81514-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF7C993E92
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 08:04:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9FAE61C230C5
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 06:04:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D07C51422AB;
	Tue,  8 Oct 2024 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a29fK5//"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F29713E023
	for <stable@vger.kernel.org>; Tue,  8 Oct 2024 06:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728367439; cv=none; b=pXHNKzdGI0b8K0COQDzWBXooiNc89UeEUKFjqKhKf2f4uLhLS2jFcPbFRdHkyrs4MrVoIhYHxDv28ARbyw1KWS5OxnphejDn0mA1DxzabLhmVIELB0Ew6PMuEBDpftBVqORtErKf1UQ3x63qJgV4rsfsuQNJVFxb9be2BpgZBfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728367439; c=relaxed/simple;
	bh=dplt03zRNMMdemW/BsCyx3ANRYogmKhsrPFD6TI4Xcw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjVi3Hgw4eJOf/LsKOAyvu4rj3rDCex1C0+Ab7DdklrrIhQINucaFtf0h3INVBGe93swvDonp+M8tmR4Cj1edGzv8djnPpL8b20PcFvfhqZQyuO6hMv0cdRzQkfyD3tna3SES6XRM8H1o8hI0ukwAEvlK0wJNtepsEzLTk6xpVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a29fK5//; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46B4FC4CED0;
	Tue,  8 Oct 2024 06:03:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728367439;
	bh=dplt03zRNMMdemW/BsCyx3ANRYogmKhsrPFD6TI4Xcw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=a29fK5//WqSSm48VTkdl3AFLy2tr8mIPKUc1C/92VATv7TnACVvPWPnVkx3BRqNbV
	 qiOmwPhM5qapBz8ujuNRoEnaRSjEt4thbLUeY2D2pl1/vfCzi1CRrw8Mt1DtqFnmMo
	 iucvACgagd+5Al0jgrFFUmrbk9WxZm3P3Qq/fq4Yr0Y2psTIGyqayJ3J73+aH+I/Wd
	 LR63ryiAjeuWbGq90zFeK7+TKNruXDqnhnVkcylTllVIqzitstEE5tNFjL4eD32tNn
	 4hGPLBU3SDcxYD17k8DM1z94xo8n3WxOPdAwGdSTP0ofyNt8jF1al+fy+MvPkdyTPX
	 haoLZ5LnpQ+DA==
Date: Tue, 8 Oct 2024 02:03:58 -0400
From: Sasha Levin <sashal@kernel.org>
To: Oleg Nesterov <oleg@redhat.com>
Cc: gregkh@linuxfoundation.org, mhiramat@kernel.org, will@kernel.org,
	stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] uprobes: fix kernel info leak via
 "[uprobes]" vma" failed to apply to 6.11-stable tree
Message-ID: <ZwTLTheTDtwO4_vs@sashalap>
References: <2024100757-gambling-blurry-b71e@gregkh>
 <20241007175741.GB1333@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20241007175741.GB1333@redhat.com>

On Mon, Oct 07, 2024 at 07:57:42PM +0200, Oleg Nesterov wrote:
>Hi Greg,
>
>On 10/07, gregkh@linuxfoundation.org wrote:
>>
>> The patch below does not apply to the 6.11-stable tree.
>
>Please see the attached patch. For v6.11 and the previous versions.

Queued up, thanks!

-- 
Thanks,
Sasha

