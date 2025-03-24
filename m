Return-Path: <stable+bounces-125940-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9812A6DF30
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 17:01:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6005E18908F8
	for <lists+stable@lfdr.de>; Mon, 24 Mar 2025 16:01:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B276225D217;
	Mon, 24 Mar 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="EwCchYpZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71FE813C3F2
	for <stable@vger.kernel.org>; Mon, 24 Mar 2025 16:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742832072; cv=none; b=iXq4BhXuzPqh8S9N/CluD+KSW+5CBz/VlvEKZBQIcLT6qnNDvqKPWzMjlcXqmiCVb2nvR3kUq35hchWWANH+8BnGFDLOb0Abn02K+ZwrBiXzdbXdmQ4FvLhSdsGhM7ZReUCfasrK+O3Mz7ub2gyv7qmML7z44C13xzZNhwo86TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742832072; c=relaxed/simple;
	bh=OoGYYQy9dzdZxqBfSzETWNBRSHcR0G88qwca7StWBmY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tk3ZmzSvanDQ7DdmM6VF+qJvKITT5ib8OImlM/EfmjHQzM0zwELqoM6y8YW4mc84UNk7eEe3KueOn5TAp3dMlU1271Qew0KkF8IQTDf6jAL7XBvw1vw1/Om4tFIjE2P4DwFojVgIn6FdhDPmoY3fCc6HdCPdm3EbQpc7jHalLzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=EwCchYpZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB8D1C4CEDD;
	Mon, 24 Mar 2025 16:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1742832072;
	bh=OoGYYQy9dzdZxqBfSzETWNBRSHcR0G88qwca7StWBmY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=EwCchYpZ6DQz3DlgdDh8heYaXfdxqY31Jqpdp1VAgQldbVvH63udpfMzJ2/LcWZTo
	 79yFky1wSXc87UxTUZm5Oxm1mZ9u5ijS0eHtWxiI99NusQpzTQMRhnAHQkqNrHDV8j
	 XbtVsPqw13vvpl5IvEzhxE0WN6hIqW9cXyF/Cexc=
Date: Mon, 24 Mar 2025 08:59:49 -0700
From: Greg KH <gregkh@linuxfoundation.org>
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: alex.hung@amd.com, alexander.deucher@amd.com, chiahsuan.chung@amd.com,
	daniel.wheeler@amd.com, stable@vger.kernel.org
Subject: Re: FAILED: patch "[PATCH] drm/amd/display: Use HW lock mgr for PSR1
 when only one eDP" failed to apply to 6.6-stable tree
Message-ID: <2025032442-quotable-consent-ac5e@gregkh>
References: <2025032441-constrain-eastbound-09d8@gregkh>
 <69bf7189-358b-40ca-9b4d-60b61e1b89d7@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <69bf7189-358b-40ca-9b4d-60b61e1b89d7@amd.com>

On Mon, Mar 24, 2025 at 10:52:49AM -0500, Mario Limonciello wrote:
> On 3/24/2025 10:37, gregkh@linuxfoundation.org wrote:
> > 
> > The patch below does not apply to the 6.6-stable tree.
> > If someone wants it applied there, or to any other stable or longterm
> > tree, then please email the backport, including the original git commit
> > id to <stable@vger.kernel.org>.
> > 
> > To reproduce the conflict and resubmit, you may use the following commands:
> > 
> > git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
> > git checkout FETCH_HEAD
> > git cherry-pick -x acbf16a6ae775b4db86f537448cc466288aa307e
> > # <resolve conflicts, build, test, etc.>
> > git commit -s
> > git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025032441-constrain-eastbound-09d8@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..
> > 
> > Possible dependencies:
> > 
> > 
> > 
> > thanks,
> > 
> > greg k-h
> > 
> 
> Hi,
> 
> Here is them missing dependency commit.  Cherry-picking this first will let
> the fix apply cleanly on 6.6.y:
> 
> commit bfeefe6ea5f1 ("drm/amd/display: should support dmub hw lock on
> Replay")

That worked, thanks!

greg k-h

