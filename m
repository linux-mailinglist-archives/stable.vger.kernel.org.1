Return-Path: <stable+bounces-151508-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C539ACEC4A
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 10:46:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186BC188BACD
	for <lists+stable@lfdr.de>; Thu,  5 Jun 2025 08:47:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BB3F149C55;
	Thu,  5 Jun 2025 08:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vJeNWJCC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B1DC4A0C
	for <stable@vger.kernel.org>; Thu,  5 Jun 2025 08:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749113207; cv=none; b=IVhbF/TQLiIkhL7Joez5WqpazawF/AjBUAuw+andCOlNYYB7NCYe21oJ6O4mUCep2z5Nry6vzxPGKEk/gNpFTOgFRwNZWqqh62U+1vckiPngpEG2mwZO1X1u0p2tWts3r/RurZ81zKu1H0nc4C/VKbN318Au2JD9/GKz67K/yf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749113207; c=relaxed/simple;
	bh=GO8e+m4rkhI4M8kpKGP+rRnIQgBoy9dIuSKtRvTRYDA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T3Rc+7RZ3+ez+3KTA/qXsXN5TX7zgN6QZk5e/DQxBPdXZUwqbAbJ2bHsl7mLun5Ussnu2eG6LTaTT9DaVc5XbyYCUGNwEnBipB7jnBMK6LPNt5Y86zsvvmuL1Ogz+zf5rN1lZSC9Dh+WRrm3IKFo9NtgruZaKeWIZofnslg1YHw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vJeNWJCC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D37EC4CEE7;
	Thu,  5 Jun 2025 08:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1749113206;
	bh=GO8e+m4rkhI4M8kpKGP+rRnIQgBoy9dIuSKtRvTRYDA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJeNWJCCL8xxkZC7NNQO6xQc6B/SLF9hIVn7bRQiQAVf+kQdhDvqdJt6ASpYc6khr
	 g82r7BvP54jZls1XLx5YRDQ9nkhkwgDR0gT3L9/WIwL4Jh5kW25yh9PpVmtTPwQ8rK
	 uoUuzPRRACvigTeoxpXUay0Rl73mFJmgwJnj3F6A=
Date: Thu, 5 Jun 2025 10:46:43 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Philip =?iso-8859-1?Q?M=FCller?= <philm@manjaro.org>
Cc: Laura Nao <laura.nao@collabora.com>, stable@vger.kernel.org,
	Uday M Bhat <uday.m.bhat@intel.com>
Subject: Re: 5.10 kernel series fails to build on newer toolchain: FAILED
 unresolved symbol filp_close
Message-ID: <2025060532-cadmium-shaking-833e@gregkh>
References: <34d5cd2e-1a9e-4898-8528-9e8c2e32b2a4@manjaro.org>
 <20250320112806.332385-1-laura.nao@collabora.com>
 <0e228177-991c-4637-9f06-267f5d4c0382@manjaro.org>
 <2025040121-strongbox-sculptor-15a1@gregkh>
 <722c3acd-6735-4882-a4b1-ed5c75fd4339@manjaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <722c3acd-6735-4882-a4b1-ed5c75fd4339@manjaro.org>

On Thu, Jun 05, 2025 at 09:44:49AM +0200, Philip Müller wrote:
> On 4/1/25 11:17, Greg KH wrote:
> > On Fri, Mar 28, 2025 at 07:06:10AM -0400, Philip Müller wrote:
> > > Yes, I can confirm that with the current stable-queue patches on top of
> > > 5.10.235 it compiles. I only had to not apply the following patch
> > > 
> > > ASoC: Intel: sof_sdw: Add support for Fatcat board with BT offload enabled
> > > in PTL platform
> > 
> > I've dropped this commit from the queue now, thanks.
> > 
> > greg k-h
> 
> Somehow the issue came back with 5.10.238 ...

I have no context here, sorry...

