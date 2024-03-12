Return-Path: <stable+bounces-27507-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0E3F879B52
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 19:27:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D20081C2163A
	for <lists+stable@lfdr.de>; Tue, 12 Mar 2024 18:27:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 382DF139574;
	Tue, 12 Mar 2024 18:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xE9SJmRD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E324B273FC
	for <stable@vger.kernel.org>; Tue, 12 Mar 2024 18:27:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710268054; cv=none; b=ZIw5mDmJNmP+ZuoEish8CyDZIArj26TpICDtF64YqfPeg5jP7jv1TVIRWtussaXt6ZTv2eT1Ov2sM5BN/GZfrR3tOObke4qf7qoJ5dddggHri9xeCmiqtMq6tv0X5roy1+gY35C0/X8VDaEQ/bUpUIzOr5SkQB9ylJj8NFuUZo0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710268054; c=relaxed/simple;
	bh=6j1vQsO9xW5LJXtMbTsNvvOVosivZMl7G7AVmO52VDg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XjAyBxi1Tpw4QzKDUhimqV0Tu2C3cQW0uIyYu2z8tqypvZMJhsiU07/AMmevQOCRXrBvi6/7ODhW7a6ksJZneUVh3+T28ec0d6fCczMx8S240mqWqGGpeya523/wdxkWIKjMxPuaVZhGo08vK5/doafpWdgTIVWZSrwo9Eb+AhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xE9SJmRD; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E542DC433C7;
	Tue, 12 Mar 2024 18:27:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1710268053;
	bh=6j1vQsO9xW5LJXtMbTsNvvOVosivZMl7G7AVmO52VDg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=xE9SJmRDaaU+gP813k1so81EMaWXdJ7LySEXp1YizSLT33fcfEgqlrIusXyhOl/Hh
	 WwOKymMWNSa95RO2IV5AbQzh1BZfx/2ltAQQiNrXrW8pX0lbTFoXxCwxAR6EHF4d8U
	 REdZQBqqBMoulyrJUY90OwPptRxdNRpPxvHESDl0=
Date: Tue, 12 Mar 2024 19:27:30 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Sasha Levin <sashal@kernel.org>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Josh Poimboeuf <jpoimboe@kernel.org>
Subject: Re: [PATCH 0/4] RFDS backport 6.8.y
Message-ID: <2024031216-detoxify-unthawed-42c5@gregkh>
References: <20240312-rfds-backport-6-8-y-v1-0-d4ab515a4b4f@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240312-rfds-backport-6-8-y-v1-0-d4ab515a4b4f@linux.intel.com>

On Tue, Mar 12, 2024 at 10:55:27AM -0700, Pawan Gupta wrote:
> This is a backport of recently upstreamed mitigation of a CPU
> vulnerability Register File Data Sampling (RFDS) (CVE-2023-28746). It
> has a dependency on "Delay VERW" series which is already present in
> v6.8.
> 
> v6.8 just got released so the backport was very smooth.

All now queued up, thanks.

greg k-h

