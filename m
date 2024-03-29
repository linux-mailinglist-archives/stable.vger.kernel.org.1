Return-Path: <stable+bounces-33730-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 51436891F6F
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 16:05:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E65081F30E2A
	for <lists+stable@lfdr.de>; Fri, 29 Mar 2024 15:05:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37DDE13BAC3;
	Fri, 29 Mar 2024 13:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ErF6txmk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBB2D142627
	for <stable@vger.kernel.org>; Fri, 29 Mar 2024 13:25:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718753; cv=none; b=aYYr8QF9j7SuEMAmSutFkVtVburbJ5rWhbrPEgdZ2E6guuBaNRMN+up2iapMNGtfRTC0Mgt413jo49sdSm8C86BgjS+0d/t0nPxXbA60gD/bYRa3AH/HGJOoOVUBr9OKRT/y0M52ksLDV9VT8NJpNVi1Le1rfchjgZZ7lN/ayO8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718753; c=relaxed/simple;
	bh=kcpcK2qfbmklh/B3XqrbduqGt8KdImnT+lBCuXNJTyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=s7Do2D3+Zgd+2CfPBuW/XtvsGJ966fSk7VG+jc3cL/iLbvUQqyr789+jEpm5P/iTbhzpg7n6/drmQMWfpJeUXDJoEFPBgt6FyhoOUUEVCr2Si5G64XtXOw5MRNQlleLvB0fWyMFLnqv0ZJQAO4q8cLCDXIE/aIqNqBLiW3jmtnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ErF6txmk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19200C433F1;
	Fri, 29 Mar 2024 13:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1711718752;
	bh=kcpcK2qfbmklh/B3XqrbduqGt8KdImnT+lBCuXNJTyw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ErF6txmkHLsim1Oun6c9mtZy06HBkBno3Tz0A3omEQXQ7LFZuO4qWr/hp28lBD3IZ
	 MXSAg7iTQOf5JspfuXMii/WrcodGC2ShsD3sPtWBwFOFMR25t4hALlbWH56Qb+kgpn
	 ulu4dc+3BcqckFEt5BU+MZSHF+z4DvXyUddNp3gQ=
Date: Fri, 29 Mar 2024 14:25:49 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: "Liang, Kan" <kan.liang@linux.intel.com>
Cc: stable@vger.kernel.org, andrew.brown@intel.com,
	dave.hansen@linux.intel.com, Ian Rogers <irogers@google.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Hector Martin <marcan@marcan.st>, Marc Zyngier <maz@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>,
	Namhyung Kim <namhyung@kernel.org>
Subject: Re: [PATCH stable 6.6 and 6.7 2/2] perf top: Uniform the event name
 for the hybrid machine
Message-ID: <2024032944-regain-striking-b711@gregkh>
References: <20240308151239.2414774-1-kan.liang@linux.intel.com>
 <20240308151239.2414774-2-kan.liang@linux.intel.com>
 <2024032918-spruce-sapling-c829@gregkh>
 <ed2715c2-d572-44c9-8b6c-0f897e5c8108@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ed2715c2-d572-44c9-8b6c-0f897e5c8108@linux.intel.com>

On Fri, Mar 29, 2024 at 09:16:09AM -0400, Liang, Kan wrote:
> Hi Greg,
> 
> On 2024-03-29 9:09 a.m., Greg KH wrote:
> > On Fri, Mar 08, 2024 at 07:12:39AM -0800, kan.liang@linux.intel.com wrote:
> >> From: Kan Liang <kan.liang@linux.intel.com>
> >>
> >> [The patch set is to fix the perf top failure on all Intel hybrid
> >> machines. Without the patch, the default perf top command is broken.
> >>
> >> I have verified that the patches on both stable 6.6 and 6.7. They can
> >> be applied to stable 6.6 and 6.7 tree without any modification as well.
> >>
> >> Please consider to apply them to stable 6.6 and 6.7. Thanks]
> > 
> > Already in the 6.6.23 and 6.7.11 releases.
> > 
> 
> Thanks. I see this one (2/2) is merged.
> Could you please also apply the first patch (1/2) as well? Without the
> first one, the perf top still fails.

Already done, thanks.

