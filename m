Return-Path: <stable+bounces-195154-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 328D2C6D2C0
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 08:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sto.lore.kernel.org (Postfix) with ESMTPS id B198529300
	for <lists+stable@lfdr.de>; Wed, 19 Nov 2025 07:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 630792FD7B8;
	Wed, 19 Nov 2025 07:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="t3NbtU5e"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E60362DEA9E;
	Wed, 19 Nov 2025 07:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763537777; cv=none; b=WLXpHRj832ChA0Pwk/jp7DcwKXTnh6Wtn2gtepJQaFMJp/UGZxfurn2fBgw4/SaotNACaQVr49PbSnr226NU3RHupMCCRZIVpl52PuQrrIU4B+53UQVYU5l1p1bWLLTonNG39hbRkLAZhAwtpwIOWdXT3YbbySy5WhWaUDxPMgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763537777; c=relaxed/simple;
	bh=1Wyir4dUb411OJQcXtSbnzdCRtoxa2Xp8KUJcJ3isiE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pL0THxQT54/wWDeMlsM1yqSy/d2HKRXDcUPVLLyiwo5FWDLvmNEnk4tgjzmHO1IYaT3DVXtUPv4z6p905qQUvu60Ylvo59xsBS1OfXL4yqiwD/FSS6escQvF8jgyOqesk4hXaBvjre/EjM5Lw3BKXXQLbamVwOr7IHSZoMvFR5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=t3NbtU5e; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B18C1C2BC86;
	Wed, 19 Nov 2025 07:36:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763537774;
	bh=1Wyir4dUb411OJQcXtSbnzdCRtoxa2Xp8KUJcJ3isiE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=t3NbtU5eN3FF6zsiJiXq1AUAzSh7rwLD677imzgwtElqgiiZBB12fdPuxr3vmbCln
	 UnAvNFc26kqOfagNuvvLFcPyJfcFOenRr7BKPOzgQOgJYV/1VUSTDeaTOp1EvpIGlA
	 KOX9ejJhtRoMceQOxstmIpYyZSno0JPW9NgO7tNo=
Date: Wed, 19 Nov 2025 02:36:09 -0500
From: Greg KH <gregkh@linuxfoundation.org>
To: Pratyush Yadav <pratyush@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Graf <graf@amazon.com>, Mike Rapoport <rppt@kernel.org>,
	Pasha Tatashin <pasha.tatashin@soleen.com>,
	kexec@lists.infradead.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: add test_kho to KHO's entry
Message-ID: <2025111944-tracing-unwieldy-1769@gregkh>
References: <20251118182416.70660-1-pratyush@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251118182416.70660-1-pratyush@kernel.org>

On Tue, Nov 18, 2025 at 07:24:15PM +0100, Pratyush Yadav wrote:
> Commit b753522bed0b7 ("kho: add test for kexec handover") introduced the
> KHO test but missed adding it to KHO's MAINTAINERS entry. Add it so the
> KHO maintainers can get patches for its test.
> 
> Cc: stable@vger.kernel.org

Why is this a patch for stable trees?

