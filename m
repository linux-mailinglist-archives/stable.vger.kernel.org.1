Return-Path: <stable+bounces-188119-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45A0CBF188B
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 15:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31D253B9D69
	for <lists+stable@lfdr.de>; Mon, 20 Oct 2025 13:27:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EF953191B5;
	Mon, 20 Oct 2025 13:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="geE3YmbZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0404219992C
	for <stable@vger.kernel.org>; Mon, 20 Oct 2025 13:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760966865; cv=none; b=uS/zVNx67rnddpu/y8QizyRxkL0eK/3Um5KQs3UqTea7ZfYpV7sq62LtUnCAWbnyrLaGqVnx876wFsi2j5tdzn70K1xihkwaDV8nz1YaUGsKtA6653WDDQAWXr3iK7cEvhQ7OVAoXEOTAhOUXggmkoMFxGUqYaVV6MkEC8+YLjM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760966865; c=relaxed/simple;
	bh=h2/GbkF3PfBPYeYqEo7zZjBBKRfhelNEtPM6jgbzd44=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=gWsNJTS8T+AFmqcGF/k0xDXxzn+ksxVHTlAs4i6PSqOtjylfYdjff3zKcA1QpUpefYgwg+0PqrYdjdArQuMImZQP1wJ5tUPH5QdZ1aciKJuLvFHCmtBP+hYRnNyUPVERdN8kXv5wq3lY+zyCxZLKkBC1mlZTTD+H9vRskL3uwlA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=geE3YmbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E0EAC4CEF9;
	Mon, 20 Oct 2025 13:27:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760966864;
	bh=h2/GbkF3PfBPYeYqEo7zZjBBKRfhelNEtPM6jgbzd44=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=geE3YmbZsDrnbMKcqhTDwk5lgd8uoWtuKTLj9vctsqlKlgqEvqEfE4U6c6zPs/aJq
	 v2yTfjsN/PTF2mIYbcMFujhiu7DzZwdJwu3cffBScOVeqXR7dvACC2AhAiNv3IZUg7
	 0V4E70fhvz6LwY6qiObd7onV9JoGEMfIuHloBWN0=
Date: Mon, 20 Oct 2025 15:27:41 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Benjamin Tissoires <bentiss@kernel.org>
Cc: stable@vger.kernel.org, Jiri Kosina <jkosina@suse.com>
Subject: Re: [PATCH 6.12.y] HID: multitouch: fix sticky fingers
Message-ID: <2025102027-capsule-bottle-6760@gregkh>
References: <2025102008-likewise-rubbing-d48b@gregkh>
 <20251020124315.2908333-1-bentiss@kernel.org>
 <teds5da4vofr4oc2ddlbxxgfidyc5oavagav2ksddkd7jl4ivw@mw554wr4vy4s>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <teds5da4vofr4oc2ddlbxxgfidyc5oavagav2ksddkd7jl4ivw@mw554wr4vy4s>

On Mon, Oct 20, 2025 at 02:52:24PM +0200, Benjamin Tissoires wrote:
> On Oct 20 2025, bentiss@kernel.org wrote:
> > From: Benjamin Tissoires <bentiss@kernel.org>
> > 
> > commit 46f781e0d151844589dc2125c8cce3300546f92a upstream.
> > 
> > The sticky fingers quirk (MT_QUIRK_STICKY_FINGERS) was only considering
> > the case when slots were not released during the last report.
> > This can be problematic if the firmware forgets to release a finger
> > while others are still present.
> > 
> > This was observed on the Synaptics DLL0945 touchpad found on the Dell
> > XPS 9310 and the Dell Inspiron 5406.
> > 
> > Fixes: 4f4001bc76fd ("HID: multitouch: fix rare Win 8 cases when the touch up event gets missing")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > Signed-off-by: Jiri Kosina <jkosina@suse.com>
> > Signed-off-by: Benjamin Tissoires <bentiss@kernel.org>
> > ---
> 
> Greg,
> 
> This backport also applies cleanly up to 5.10. Though I'm not sure we
> want to go that far in the history TBH.
> 
> Can you also take this version and apply it to 6.1+? (or do you want me
> to send individual rebases for each tree?)

I've taken it back to 5.10.y as-is, thanks!

greg k-h

