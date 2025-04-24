Return-Path: <stable+bounces-136605-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F114A9B251
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 17:31:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8CFA53B7CCB
	for <lists+stable@lfdr.de>; Thu, 24 Apr 2025 15:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2264913AD26;
	Thu, 24 Apr 2025 15:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QDcPFluf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5A4844C77
	for <stable@vger.kernel.org>; Thu, 24 Apr 2025 15:31:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745508677; cv=none; b=W6J/P61Fb4+6UK0ePwtNmSi9afP+21P+ldBarC+zc30JGO9K2i47ClSaE8kxoI3xnyi84prWleXY5civYcWd8p3/HGkQ8P7cTipGOTjeWb6HprOqmXFOCHUPourMeHUl90bTooUVW1P2uSJkti50+7R3yiUjh1LYcrh9T5vcTYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745508677; c=relaxed/simple;
	bh=N98xrdVQvfsV9uT+lDI5/rz+OpXyRZX+EbMx3dX9pQk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZjjJ8eVs2AfEBQ43JBXKhTs73JmqlJ43yBzuqdyBMG3H/rcWl/HdIT5wezdRu9IxoDzRPYQ3h9O37nq7LI5eGsF0A3mImZ1L/j395qN5Gn2GlB8VbEp2YD8HfBhiJFBQzMhhVt6zechsi3DPi8SyqDVx/jCQwz5+pB5IFBY+ISg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QDcPFluf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBC0BC4CEE3;
	Thu, 24 Apr 2025 15:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745508677;
	bh=N98xrdVQvfsV9uT+lDI5/rz+OpXyRZX+EbMx3dX9pQk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QDcPFlufV3ggtOsKWtC6PrwCGXu6WBPKFcACCRqVlVtssWE4Dh62C4mjjOUemQ/gL
	 6FusJSmRXWrmnERBu6N/30/06wtnj89JG/z5ad25VKUIgFNHKVBmJCSAMnOLcGEG0o
	 4/bodHrDd4g5nXfpcF45LgQH+Y3Q5ivWCgyGDdz4=
Date: Thu, 24 Apr 2025 17:31:14 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>,
	Takashi Iwai <tiwai@suse.de>
Subject: Re: Please apply commit 8983dc1b66c0 ("ALSA: hda/realtek: Fix
 built-in mic on another ASUS VivoBook model") to v6.1.y (and v6.6.y)
Message-ID: <2025042459-debit-slicing-84e2@gregkh>
References: <aApNxe237XfXGLS-@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aApNxe237XfXGLS-@eldamar.lan>

On Thu, Apr 24, 2025 at 04:42:13PM +0200, Salvatore Bonaccorso wrote:
> Hi
> 
> As per subject, can you please apply commit 8983dc1b66c0 ("ALSA:
> hda/realtek: Fix built-in mic on another ASUS VivoBook model") to
> v6.1.y?
> 
> The commit fixes 3b4309546b48 ("ALSA: hda: Fix headset detection
> failure due to unstable sort"), which is in 6.14-rc1 *but* it got
> backported to other stable series as well: 6.1.129, 6.6.78, 6.12.14
> and 6.13.3.
> 
> While 8983dc1b66c0 got then backported down to 6.12.23, 6.13.11 and
> and 6.14.2 it was not backported further down, the reason is likely
> the commit does not apply cleanly due to context changes in the struct
> hda_quirk alc269_fixup_tbl (as some entries are missing in older
> series).
> 
> For context see as well:
> https://lore.kernel.org/linux-sound/Z95s5T6OXFPjRnKf@eldamar.lan
> https://lore.kernel.org/linux-sound/Z_aq9kkdswrGZRUQ@eldamar.lan/
> https://bugs.debian.org/1100928
> 
> Can you please apply it down for 6.1.y?
> 
> Attached is a manual backport of the change in case needed.

The backport was needed and was why this wasn't applied there, thanks!

greg k-h

