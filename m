Return-Path: <stable+bounces-70354-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D5174960B5E
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 15:09:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 137951C22A67
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 13:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C472B1C32E2;
	Tue, 27 Aug 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="JkK54FaK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 839FE1C32E1
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 13:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724764093; cv=none; b=hL8fAbuDi4WiYAqQgRpSy/s57590GAbKKcLK7a7HxUKKJKISgYTaaF6Gc6NuZN4MFapcF8Sbrwr+zbzBzeyr2sh/pccszWCanqeDB2BfLmGNswFArtR6/sNx0gz4xGBQ+mi9HPY8tvC6TnIba3Ibbg0mZAdknbPVrJhCfnvurm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724764093; c=relaxed/simple;
	bh=YNI7tvyihxFxNgX89FeybS1Fu2KlsvYNg3kCzA5me6I=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkMrEX1j5W8DFLuwrxg5TFfuIDPaHM5JBYYMyBtji3m9T0kZK2yJCL4Gtxj5Y3bhQN2LMh5QTWdM1IfDxJxy7lExC8m4WmG9nVT3eXjgmlwG5iUMSm3sbywWd4Dfa0YAGStT3Y3116AqH1kcb8kwU1NPOQ3RGoKbHCUPIntEVpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=JkK54FaK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8AE4C61047;
	Tue, 27 Aug 2024 13:08:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724764093;
	bh=YNI7tvyihxFxNgX89FeybS1Fu2KlsvYNg3kCzA5me6I=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JkK54FaK1+SVqRVWjbDGilzZHVo8B0VFwXLfc7Icjqi72t+OrBSKJMYXUel3C/Cfg
	 D1umJcRQ/83+GDw6L1zW+ngpyjTPgSxmnQbT928dHTiOY3g1PpgFWOBx8LpRx8zzgZ
	 l3ELJmrZXr1lAm5qsvFzdWrwZA3BXa2gdEJnj8Lo=
Date: Tue, 27 Aug 2024 15:08:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <superm1@kernel.org>
Cc: stable@vger.kernel.org, Mario Limonciello <mario.limonciello@amd.com>
Subject: Re: [PATCH 6.1 0/2] VCN power saving improvements
Message-ID: <2024082701-radiance-ranging-e2e2@gregkh>
References: <20240826155519.2030932-1-superm1@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240826155519.2030932-1-superm1@kernel.org>

On Mon, Aug 26, 2024 at 10:55:17AM -0500, Mario Limonciello wrote:
> From: Mario Limonciello <mario.limonciello@amd.com>
> 
> This is a backport of patches from 6.11-rc1 that improve power savings
> for VCN when hardware accelerated video playback is active.
> 
> Boyuan Zhang (2):
>   drm/amdgpu/vcn: identify unified queue in sw init
>   drm/amdgpu/vcn: not pause dpg for unified queue
> 
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.c | 53 ++++++++++++-------------
>  drivers/gpu/drm/amd/amdgpu/amdgpu_vcn.h |  1 +
>  2 files changed, 27 insertions(+), 27 deletions(-)
> 
> -- 
> 2.43.0
> 
> 

Now queued up, thanks.

greg k-h

