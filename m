Return-Path: <stable+bounces-125945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 85D3DA6DF7C
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 17:22:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83D5C166603
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:22:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E5A262813;
	Mon, 24 Mar 2025 16:22:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ECNkAAKd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FA11DDE9
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 16:22:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742833363; cv=none; b=RPWg+NDg/Yh/VBKk8fWFZ0FAwn+uEGgcI2O8FE5XTUZutGZv2U9IlAYqH05fx/mffqC9h4fTqcD/PoQzcRukkUuTs5o36uuDMvGTDUj23AO8Dh+Ra8omwIg4pDXxNjxbZ06ecQlIY9mD0Yq6SKi6xmAcat7k2arBwT0hskd37as=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742833363; c=relaxed/simple;
	bh=YaQsrkk3lS2G7XM6vruUrz167lhMR8ZZ/MooN4GPg1E=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pvBGT1Q/IcM0hraLEOQEL8+yx/bD6kAUgp9TLrEjeaS5U7kWw5apab4N+h4Y5B5Wi4uPjYH+xZbWDQ8FWyZffnUZxVhpcwdylQ8VCzxrFmnZ0Xy0Q4iXrsvSfg5+XlCO3xWs9fAeM6qWomano/BenZwUahosSZsiHaTQzSRSc58=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ECNkAAKd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8CCC4CEDD;
	Mon, 24 Mar 2025 16:22:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742833362;
	bh=YaQsrkk3lS2G7XM6vruUrz167lhMR8ZZ/MooN4GPg1E=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ECNkAAKdl4co7RBy6Hh1UMy1CaW/0l/2rGGmGoKt5j28HqO+7lh1arecjpivO+jgc
	 dMCGn7HqgSM/cG2gWjcQvlDV4v3ry0a43bJc2yUtO4ZsIIhn3uoVBXg0JY56MyxiiN
	 VUVNwnHPfAeGwZvQMF8DO21CiE3HWtqwdxVbHUKo=
Date: Mon, 24 Mar 2025 09:21:20 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: alex.hung@amd.com, alexander.deucher@amd.com, chiahsuan.chung@amd.com,
	daniel.wheeler@amd.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/amd/display: Use HW lock mgr for PSR1
 when only one eDP" failed to apply to 6.6-stable tree
Message-ID: <2025032408-keep-amplifier-ec1e@gregkh>
References: <2025032441-constrain-eastbound-09d8@gregkh>
 <69bf7189-358b-40ca-9b4d-60b61e1b89d7@amd.com>
 <2025032442-quotable-consent-ac5e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2025032442-quotable-consent-ac5e@gregkh>

On Mon, Mar 24, 2025 at 08:59:49AM -0700, Greg KH wrote:
> On Mon, Mar 24, 2025 at 10:52:49AM -0500, Mario Limonciello wrote:
> > On 3/24/2025 10:37, gregkh@linuxfoundation.org wrote:
> > > 
> > > The patch below does not apply to the 6.6-stable tree.
> > > If someone wants it applied there, or to any other stable or longterm
> > > tree, then please email the backport, including the original git commit
> > > id to <stable@vger.kernel.org>.
> > > 
> > > To reproduce the conflict and resubmit, you may use the following commands:
> > > 
> > > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > > git checkout FETCH_HEAD
> > > git cherry-pick -x acbf16a6ae775b4db86f537448cc466288aa307e
> > > # <resolve conflicts, build, test, etc.>
> > > git commit -s
> > > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032441-constrain-eastbound-09d8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> > > 
> > > Possible dependencies:
> > > 
> > > 
> > > 
> > > thanks,
> > > 
> > > greg k-h
> > > 
> > 
> > Hi,
> > 
> > Here is them missing dependency commit.  Cherry-picking this first will let
> > the fix apply cleanly on 6.6.y:
> > 
> > commit bfeefe6ea5f1 ("drm/amd/display: should support dmub hw lock on
> > Replay")
> 
> That worked, thanks!

Nope, did not work for 6.1.y, that failed there :(


