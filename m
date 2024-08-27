Return-Path: <stable+bounces-70330-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A77469609FE
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 14:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DA78E1C22303
	for <lists+stable@lfdr.de>; Tue, 27 Aug 2024 12:24:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604571B2507;
	Tue, 27 Aug 2024 12:24:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x4uTMl7D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EF2F1B14E8
	for <stable@vger.kernel.org>; Tue, 27 Aug 2024 12:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724761457; cv=none; b=JnRUa8m7io2JniRwOy6FtGOYnpCFIVzs6I5GKGqjLK206QwDj2OoPw2O98QJRQ64xekadWAkS1sLbq4DA9OFjipzMqpzNxL2gKMbNVMYS0z4MjGkpGb7gzn+feT12PJ5mnRR3Ni6sfrdzY17hUgvndBwpXVYJzDLBIC7wCS96UM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724761457; c=relaxed/simple;
	bh=zfTElYcgaiZ8VSyHl+ymj+C4SExhDElZDGHw3/4FS14=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dc6liwNNqH4kfS0OW7X+3mUBwy7rmMCyxMjkD47K6UnsDZFVruT2jn36wTc9z2qMhK1ktHqhVEFB5YzkKCvxuxxRY+RPPQAG2lJg3/S7AOSU6K8R6OzhgqGKOtDS06LrpoQ1rAcxJdWncZgPSspYMz8i2Nl2Vuzt2llyDzu9mrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x4uTMl7D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 342E9C61042;
	Tue, 27 Aug 2024 12:24:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724761456;
	bh=zfTElYcgaiZ8VSyHl+ymj+C4SExhDElZDGHw3/4FS14=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=x4uTMl7DZAwNpKjX8HM9sJuvxS3uFR7Mw9QwJXju7Y5sUt2WZtftKR3mNlNrNTUFj
	 UJ9UNjp97cP2kCtVe3gp8kEdfxC6qPKSwGmwrLfcfeyKPvZoKS68tLPXF+iELG4O5B
	 jbTmm5ApfbtVLnVVrJF30kaVshOSj1Fn5GgdM+nw=
Date: Tue, 27 Aug 2024 14:24:12 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Alex Deucher <alexander.deucher@amd.com>
Subject: Re: VCN power consumption improvement for 6.10.y
Message-ID: <2024082705-surface-doornail-3a27@gregkh>
References: <0cc223ce-5350-4780-94d5-513079531cc4@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0cc223ce-5350-4780-94d5-513079531cc4@amd.com>

On Mon, Aug 26, 2024 at 10:56:15AM -0500, Mario Limonciello wrote:
> Hi,
> 
> The following patches in 6.11-rc1 help VCN power consumption on a lot of
> modern products.  Can we please take then to 6.10.y so more people can get
> the power savings?
> 
> commit ecfa23c8df7e ("drm/amdgpu/vcn: identify unified queue in sw init")
> commit 7d75ef3736a0 ("drm/amdgpu/vcn: not pause dpg for unified queue")

Both now queued up, thanks.

greg k-h

