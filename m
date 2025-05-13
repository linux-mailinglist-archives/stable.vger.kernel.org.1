Return-Path: <stable+bounces-144177-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B95DCAB5810
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 17:08:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 72350866CCC
	for <lists+stable@lfdr.de>; Tue, 13 May 2025 15:05:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E451DED53;
	Tue, 13 May 2025 15:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b="5DFkcsrl"
X-Original-To: stable@vger.kernel.org
Received: from antaris-organics.com (mail.antaris-organics.com [91.227.220.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C5231A83E8;
	Tue, 13 May 2025 15:05:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.227.220.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747148730; cv=none; b=R7FZyHmkSyUp3z28ZZhVXWRSYFH88gixU6xqCW7uJ4tBtjYp8k9TQTmfDA4yvZ1kmaBPS49MWNzYJCQjWDyEE0aQGan6hljdy1dvmHG1EXcih39QE9g4Qf8YhymAOsTlvmjaFj0gNSFM/zOH3UYNQwnt/WRPup5LnY1TLMtaWvw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747148730; c=relaxed/simple;
	bh=TVeymOuDvJEn4UF7fszSyrQBpu3zvuRhfrcGQXCDx24=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MXHMJ1kbaEjuHixn2O4GE3Bt8HaHAH1SgXICBACPdRpiqjOxbAkd/BKocABXv/CK1gKqJ2soSiDVx9RHjf1PBgecWgcuxSpV6wlh+oX5GMGlNk7PZZkvdtLN93SFsHQCt48MM1wgJ33rwGu0XlCUA46fP0pWjsiha80r5MVPJPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com; spf=pass smtp.mailfrom=mareichelt.com; dkim=pass (2048-bit key) header.d=mareichelt.com header.i=@mareichelt.com header.b=5DFkcsrl; arc=none smtp.client-ip=91.227.220.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=mareichelt.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mareichelt.com
Date: Tue, 13 May 2025 16:58:40 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mareichelt.com;
	s=202107; t=1747148321;
	bh=TVeymOuDvJEn4UF7fszSyrQBpu3zvuRhfrcGQXCDx24=;
	h=Date:From:To:Subject:Message-ID:References:MIME-Version:
	 Content-Type:In-Reply-To:Cc:Cc:content-type:content-type:date:date:
	 From:from:in-reply-to:in-reply-to:message-id:mime-version:
	 mime-version:references:reply-to:Sender:Subject:Subject:To:To;
	b=5DFkcsrlyd/msoKennlZmCQth7Kg/++ojJRZl2WlEQlizyzn0QheFCYpMI6o44ghU
	 ZxI7FmNlDKo4DNU4FumkvkUx/ZfYNve7XiYXZeW8BTnZK+rFWUqiA+DsNxfX4bTrxR
	 TUC54le7KfhHW+t1IK/uOtzFxj2rqkX7JymZwMxKRXtGtM8sc3fbCpf82YcispK3jP
	 H/osN/HIwxLTCQ96ERyrbsLsYdnBVHl+e9aRcnkYjAYJHJfS9Ow8Gx0reUPGJqmwo1
	 mVv9BvWJhUlqqeWlKYmpjbwBXZdTGL7YBFdPzz+L4g1nmjQR106AlFMlbc6LNoaVJb
	 ebXuQjrjPLGgA==
From: Markus Reichelt <lkt+2023@mareichelt.com>
To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6.14 000/197] 6.14.7-rc1 review
Message-ID: <20250513145840.GB4298@pc21.mareichelt.com>
Mail-Followup-To: stable@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20250512172044.326436266@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250512172044.326436266@linuxfoundation.org>

* Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> This is the start of the stable review cycle for the 6.14.7 release.
> There are 197 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 May 2025 17:19:58 +0000.
> Anything received after that time might be too late.

Hi Greg

6.14.7-rc1 compiles, boots and runs here on x86_64 (AMD Ryzen 5 7520U,
Slackware64-current), no regressions observed.

Tested-by: Markus Reichelt <lkt+2023@mareichelt.com>

