Return-Path: <stable+bounces-114425-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CD5BA2DB66
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 07:50:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 103B5165AE5
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 06:50:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CAF53368;
	Sun,  9 Feb 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kX8v6eGX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20F254C9F;
	Sun,  9 Feb 2025 06:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739083798; cv=none; b=RLrzko0Sbo0simagWz6Zo3Khf8/84/n6czNIWyHozn3XQWsKpxq/ImFm7AcXlrzktFponFSevE2f6/f0YU3MBOQqxGQfAlssrNskRqakoTIFYbd4A86XXpfIb5NpUDPxxhkT6XOYcvjB4nlh4V1T64UWZ5jq+r5UDbT+sDLknj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739083798; c=relaxed/simple;
	bh=6WhwOi1PO8XaTLt/+uAUYLG4dac1oyS3ReLFZ3wljtk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nSAwQbDtFBFCLpXC91Th8WNPQs6QRnHBusrKZTogKzd+fVxKNhrVp+t/GuXbWR5nZ9WnWkJzoDHBnAQ9pq750m67s7g8UZBTd2vhM+s6C+TK5j0AcS3Uy40mGGjdCsNAkjgnLziz1l7rEXxqGaemPkLf7nK0ZelhKFrnxP2/ypA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kX8v6eGX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68352C4CEDD;
	Sun,  9 Feb 2025 06:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1739083798;
	bh=6WhwOi1PO8XaTLt/+uAUYLG4dac1oyS3ReLFZ3wljtk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=kX8v6eGXEVj0C76VGZFm66rlS47CF9w30+mjGHAQnZMIwbgRVy3mP/VaYJFS8dSun
	 4vtx+8rORGyFZ/eXDsLdFTiayzNK77mFso4cmQU7cGGojwmY1vrVxVUdXzU6vOfHt2
	 OTHEAKq94yVxrwGZJuyjbdl03rntNM3XsB1DW67A=
Date: Sun, 9 Feb 2025 07:49:54 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jared Finder <jared@finder.org>
Cc: kees@kernel.org, gnoack@google.com, hanno@hboeck.de, jannh@google.com,
	jirislaby@kernel.org, linux-hardening@vger.kernel.org,
	linux-kernel@vger.kernel.org, regressions@lists.linux.dev,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] tty: Permit some TIOCL_SETSEL modes without
 CAP_SYS_ADMIN
Message-ID: <2025020909-reshape-dynasty-0587@gregkh>
References: <202501100850.5E4D0A5@keescook>
 <cd83bd96b0b536dd96965329e282122c@finder.org>
 <2025020812-refusing-selection-a717@gregkh>
 <fceb96ee879249d18be0261e57388542@finder.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fceb96ee879249d18be0261e57388542@finder.org>

On Sat, Feb 08, 2025 at 08:03:27AM -0800, Jared Finder wrote:
> On 2025-02-08 07:28, Greg KH wrote:
> > On Sat, Feb 08, 2025 at 07:18:22AM -0800, Jared Finder wrote:
> > > Hi, I'm the original reporter of this regression (noticed because it
> > > impacted GNU Emacs) and I'm wondering if there's any traction on
> > > creating an
> > > updated patch? This thread appears to have stalled out. I haven't
> > > seen any
> > > reply for three weeks.
> > 
> > It's already in 6.14-rc1 as commit 2f83e38a095f ("tty: Permit some
> > TIOCL_SETSEL modes without CAP_SYS_ADMIN").
> 
> Great! Is this expected to get backported to 6.7 through 6.13? I would like
> to note the expected resolution correctly in Emacs' bug tracker.

Yes, it should show up in the next round of stable kernel updates later
this week.

But note, it will only show up in the 6.12.y and 6.13.y kernels, as all
others in your range are end-of-life and shouldn't be used by anyone at
this point in time.

thanks,

greg k-h

