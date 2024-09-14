Return-Path: <stable+bounces-76149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CCE97979334
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 21:15:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7A4961F223E1
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 19:15:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2D8A78C89;
	Sat, 14 Sep 2024 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DWH9f6/t"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F2B1748D;
	Sat, 14 Sep 2024 19:15:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726341329; cv=none; b=rf1RZraJ5eHV8D8MyccbHGDvKiz+8F6o00AanBWdpjFKKO/UJudOjQMWR7wtAnxxY8xxTH8i1Dz1sftLVlr/VOgcCUmaBhq+ZejvM6OPZYQny5tF5jhrdTx0PzMJ+OzZJq+3d81EKp55h2zgts4zXz2OPgjOkPqvGSmaDZMrBAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726341329; c=relaxed/simple;
	bh=TCDg6hoUXv4oc+Lmjy4by1NP/bztbgqMDFnQQQEyxh8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+ViSbGNXmg8zI3EPfdscYCB84ZDLhR2bMskibxfGfKvVYLhzPgoTGZXQ4+n0KVFerVDX/zwz0+/5Kx5syzzCVf2Qftu7EGTFNcjwk8xrCE1MaWl2m0XylXczG4Pj7yHtlg3gWRo3LgAohiWIbYI+myqYck3V1YrKWcLP2P4uck=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DWH9f6/t; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 871F4C4CEC0;
	Sat, 14 Sep 2024 19:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726341328;
	bh=TCDg6hoUXv4oc+Lmjy4by1NP/bztbgqMDFnQQQEyxh8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DWH9f6/t3PNS+sUEHILEGwUFzslyY6GM84INdyU3GTrruc2kzpncb18uqUgCnt5pl
	 Nfdzbgxe4KoHk5NIMlTqlvhfwFhMCpH15nC+Ze7Cy/x9SnvMeWYhBJ7DwHJL6Lj+Ya
	 mzlevX4qQickwpkOVfq/IzFKPn/RzM4uQMK/xVfKAh/amLFxYWCXDeSGQHYuQqdc/B
	 Bru/dutMRq108kqr39jCVj/jiQ0qOZDzbhfTnEGcjgAktDFu0VzP/h6Eq/v02xW+vc
	 OaMUe5B56f2t/VJFczo/89TPOAOQaZgRc2e6Ec9OtxWe/6KKmucwxv8uJ5J0BLb9tt
	 afdj72TzZXnwg==
Date: Sun, 15 Sep 2024 00:45:25 +0530
From: Vinod Koul <vkoul@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: =?iso-8859-1?Q?P=E9ter?= Ujfalusi <peter.ujfalusi@linux.intel.com>,
	yung-chuan.liao@linux.intel.com,
	pierre-louis.bossart@linux.intel.com,
	krzysztof.kozlowski@linaro.org, alsa-devel@alsa-project.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH stable-6.10 regression] Revert "soundwire: stream: fix
 programming slave ports for non-continous port maps"
Message-ID: <ZuXgzRSPx7hN6ASO@vaman>
References: <20240910124009.10183-1-peter.ujfalusi@linux.intel.com>
 <febaa630-7bf4-4bb8-8bcf-a185f1b2ed65@linux.intel.com>
 <2024091130-detail-remix-34f7@gregkh>
 <ZuQnPnRsXaUEBv6X@vaman>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZuQnPnRsXaUEBv6X@vaman>

On 13-09-24, 17:21, Vinod Koul wrote:
> On 11-09-24, 14:31, Greg KH wrote:
> > On Tue, Sep 10, 2024 at 04:02:29PM +0300, Péter Ujfalusi wrote:
> > > Hi,
> > > 
> > > On 10/09/2024 15:40, Peter Ujfalusi wrote:
> > > > The prop->src_dpn_prop and prop.sink_dpn_prop is allocated for the _number_
> > > > of ports and it is forced as 0 index based.
> > > > 
> > > > The original code was correct while the change to walk the bits and use
> > > > their position as index into the arrays is not correct.
> > > > 
> > > > For exmple we can have the prop.source_ports=0x2, which means we have one
> > > > port, but the prop.src_dpn_prop[1] is accessing outside of the allocated
> > > > memory.
> > > > 
> > > > This reverts commit 6fa78e9c41471fe43052cd6feba6eae1b0277ae3.
> > > 
> > > I just noticed that Krzysztof already sent the revert patch but it is
> > > not picked up for stable-6.10.y
> > > 
> > > https://lore.kernel.org/lkml/20240909164746.136629-1-krzysztof.kozlowski@linaro.org/
> > 
> > Is this in Linus's tree yet?  That's what we are waiting for.
> 
> Yes I was waiting for that as well, the pull request has been sent to
> Linus, this should be in his tree, hopefully tomorow..

It is in Linus's tree now. Greg would you like to drop commit
6fa78e9c41471fe43052cd6feba6eae1b0277ae3 or carry it and the
revert...?

What is the usual process for you to handle reverts?
-- 
~Vinod

