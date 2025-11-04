Return-Path: <stable+bounces-192304-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AADC8C2F042
	for <lists+stable@lfdr.de>; Tue, 04 Nov 2025 03:46:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B2253B2F23
	for <lists+stable@lfdr.de>; Tue,  4 Nov 2025 02:46:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC922258EC8;
	Tue,  4 Nov 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DQ7eSTIa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D5D018871F
	for <stable@vger.kernel.org>; Tue,  4 Nov 2025 02:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762224408; cv=none; b=SwxpHry8oIfnt//8YnUYc1Mvu8psFFPGwFbNT/g9kPZx63JOZO6RZZKdBVbkYFe8GjjBS/cEArRPmDNL/+U/c2wuoaoj/z5wpAfN9YGpva86vExZff0LJHoXg91ddFdWMle01BVDUjHEnTTg1uym0bOZnTdbS5YXJauCWpqsVDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762224408; c=relaxed/simple;
	bh=ICCGN4w9XYqNwOUuirAm/Jm7/UWSewDBz0HTxWC2C/4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IZBuaLUrmOKh3J6yVBoKOF/a3xJGBefTcFkOXRbJeSEkIbOtDh8oJCZqb9d6gmhHN5Rw9mm5iSNYwJXr9gHb+BmeuwD9P/oxNv7B0rFE9CgHE2nxJKDuJ8tlWoKp9yzmqbqUuRkb2JsNUoTw+XpqwwIlfcf7UiVaSEUAEXpxRkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DQ7eSTIa; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2A5FC4CEE7;
	Tue,  4 Nov 2025 02:46:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1762224407;
	bh=ICCGN4w9XYqNwOUuirAm/Jm7/UWSewDBz0HTxWC2C/4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=DQ7eSTIa36hNUBly/YAU3sAMhfPKITyBtrQlM+yP5Uee84npAyIhltxegZ26eXFc1
	 q+wHeWJCuEVI0R5Mz/v8eKd21r6y4PJ/RuDfNBQvU8nv5WwNfiDSF30eMbUrIr44st
	 vFuZ81uBCNizJ++YFFmBpnwyL/49PUGAP36vBO+U=
Date: Tue, 4 Nov 2025 11:46:45 +0900
From: Greg KH <gregkh@linuxfoundation.org>
To: John Stultz <jstultz@google.com>
Cc: stable@vger.kernel.org, Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: v6.6-stable: Fair-scheduler changes from the android15-6.6 branch
Message-ID: <2025110425-blog-cavalier-f6af@gregkh>
References: <CANDhNCraMOo6ND7zHjyM+BmGAvqb1ZAzL7Wp4XX82GRDhdYovQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANDhNCraMOo6ND7zHjyM+BmGAvqb1ZAzL7Wp4XX82GRDhdYovQ@mail.gmail.com>

On Mon, Nov 03, 2025 at 06:35:33PM -0800, John Stultz wrote:
> Recently I found there were a few cases where changes from upstream
> were merged into the android15-6.6 branch to address issues, however
> those changes didn't actually make it into the -stable tree.
> 
> Specifically:
> 50181c0cff31 sched/pelt: Avoid underestimation of task utilization
> 3af7524b1419 sched/fair: Use all little CPUs for CPU-bound workloads

Odd, that second one was backported to 6.1 and older kernels, but
skipped 6.6.y.  Both now queued up, thanks!

greg k-h

