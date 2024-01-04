Return-Path: <stable+bounces-9682-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A9EE682432F
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 14:58:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 398DBB20D56
	for <lists+stable@lfdr.de>; Thu,  4 Jan 2024 13:58:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0F0F2233E;
	Thu,  4 Jan 2024 13:58:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nw2yu0IS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69DCB1DFFD
	for <stable@vger.kernel.org>; Thu,  4 Jan 2024 13:58:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C70CC433C7;
	Thu,  4 Jan 2024 13:58:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1704376725;
	bh=kUAhvV5Rtj8FmvIgEpCZ+OIBaqt3tBUq1CbPUeHc7LY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Nw2yu0ISm0HwuyuchMlVcDXZbbROdxImitr94F0THRNKy10y2t/TgjWzFz7lh4rKg
	 wu0M6Zj9xbh4dTzzj2NwEWU22QLndFBKEMmxjnRB2GbDBs0bmYvsYmzKWLWSOMaSY5
	 X8zDiJI+VPc3/xHniZepE7pggBPYsYvv9zEo4hfw=
Date: Thu, 4 Jan 2024 14:58:43 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Hamza Mahfooz <hamza.mahfooz@amd.com>
Cc: Joshua Ashton <joshua@froggi.es>, amd-gfx@lists.freedesktop.org,
	Melissa Wen <mwen@igalia.com>,
	Harry Wentland <harry.wentland@amd.com>,
	Xaver Hugl <xaver.hugl@gmail.com>,
	"Deucher, Alexander" <Alexander.Deucher@amd.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH] drm/amd/display: Fix sending VSC (+ colorimetry) packets
 for DP/eDP displays without PSR
Message-ID: <2024010434-arbitrary-muzzle-9058@gregkh>
References: <20240101182836.817565-1-joshua@froggi.es>
 <8db3e45e-037a-4dc5-aabb-519091b1a69e@amd.com>
 <aa5dee62-cec8-464c-aeac-38fdac0a4a80@froggi.es>
 <fbed675b-7f82-4f33-a9fe-1947425a649a@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fbed675b-7f82-4f33-a9fe-1947425a649a@amd.com>

On Thu, Jan 04, 2024 at 08:54:19AM -0500, Hamza Mahfooz wrote:
> On 1/3/24 14:17, Joshua Ashton wrote:
> > Thanks! Is it possible for us to get this backported too?
> 
> Sure thing.
> 
> Cc: stable@vger.kernel.org

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

