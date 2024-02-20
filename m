Return-Path: <stable+bounces-20884-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A52A785C5C3
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 21:27:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5FFB0282799
	for <lists+stable@lfdr.de>; Tue, 20 Feb 2024 20:27:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D266414AD10;
	Tue, 20 Feb 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="AD9TOdBr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70DB4137C41;
	Tue, 20 Feb 2024 20:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708460873; cv=none; b=IznzjKtqzm2WapX6cKFsDxq95d+/USmYq0xzZm6ghnt3qL1e50sjjvS0ID7VNkihxfD3BdvtAvsqDDe0lFTNiTwu+Pb53toCQ9recCBWpEnmG9Tb3di+CZNUA1V4bLB2N5bSigHXGdKK70YnIF2835Pl59JA8xVTFU1/WIuPPIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708460873; c=relaxed/simple;
	bh=TsvFKFz3wRTd8DYn1XhKWst0S8r7DOuRv0SpGXlwJ00=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=PHPBPGNt+dmXRCsRexdx0dWtaOzTX9xQh8dT7+VvpIK9prhSp7NRhBxj6SglfonGYnk5uFWNGKukNynWQ/a33Z2APwfh+6VjqPEm4ofBLTZlDDhaIm1MDcNYm2cIbsNw2L+1gL2BAHvWzXe4m2uG31OQTybFH6F8+OG99W81uV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=AD9TOdBr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A6CC433C7;
	Tue, 20 Feb 2024 20:27:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1708460872;
	bh=TsvFKFz3wRTd8DYn1XhKWst0S8r7DOuRv0SpGXlwJ00=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AD9TOdBrP7PwrvU/gp/NPzsp+80VT395aj8UXDMP9t8CBHbVlXI0W4c3VraOno6sM
	 JFv8SdpGT+aYh9t3wFILLXpw5O/JADnRmYD/BQWDOdtH44xFwX3qqYuJyTdIqEl1TN
	 +45tKu8Zwk9lauW/BkfHeGpPp0WzFbOCEgEvo1+g=
Date: Tue, 20 Feb 2024 21:27:49 +0100
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Salvatore Bonaccorso <carnil@debian.org>
Cc: Paulo Alcantara <pc@manguebit.com>,
	Jan =?utf-8?B?xIxlcm3DoWs=?= <sairon@sairon.cz>,
	Leonardo Brondani Schenkel <leonardo@schenkel.net>,
	stable@vger.kernel.org, regressions@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	Mathias =?iso-8859-1?Q?Wei=DFbach?= <m.weissbach@info-gate.de>
Subject: Re: [REGRESSION 6.1.70] system calls with CIFS mounts failing with
 "Resource temporarily unavailable"
Message-ID: <2024022058-scrubber-canola-37d2@gregkh>
References: <8ad7c20e-0645-40f3-96e6-75257b4bd31a@schenkel.net>
 <7425b05a-d9a1-4c06-89a2-575504e132c3@sairon.cz>
 <446860c571d0699ed664175262a9e84b@manguebit.com>
 <2024010846-hefty-program-09c0@gregkh>
 <88a9efbd0718039e6214fd23978250d1@manguebit.com>
 <Zbl7qIcpekgPmLDP@eldamar.lan>
 <Zbl881W5S-nL7iof@eldamar.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zbl881W5S-nL7iof@eldamar.lan>

On Tue, Jan 30, 2024 at 11:49:23PM +0100, Salvatore Bonaccorso wrote:
> Hi Paulo, hi Greg,
> 
> On Tue, Jan 30, 2024 at 11:43:52PM +0100, Salvatore Bonaccorso wrote:
> > Hi Paulo, hi Greg,
> > 
> > Note this is about the 5.10.y backports of the cifs issue, were system
> > calls fail with "Resource temporarily unavailable".
> > 
> > On Mon, Jan 08, 2024 at 12:58:49PM -0300, Paulo Alcantara wrote:
> > > Greg Kroah-Hartman <gregkh@linuxfoundation.org> writes:
> > > 
> > > > Why can't we just include eb3e28c1e89b ("smb3: Replace smb2pdu 1-element
> > > > arrays with flex-arrays") to resolve this?
> > > 
> > > Yep, this is the right way to go.
> > > 
> > > > I've queued it up now.
> > > 
> > > Thanks!
> > 
> > Is the underlying issue by picking the three commits:
> > 
> > 3080ea5553cc ("stddef: Introduce DECLARE_FLEX_ARRAY() helper")
> > eb3e28c1e89b ("smb3: Replace smb2pdu 1-element arrays with flex-arrays")
> > 
> > and the last commit in linux-stable-rc for 5.10.y:
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit?id=a280ecca48beb40ca6c0fc20dd5a7fdd9b3ee0b7
> > 
> > really fixing the issue?
> > 
> > Since we need to release a new update in Debian, I picked those three
> > for testing on top of the 5.10.209-1 and while testing explicitly a
> > cifs mount, I still get:
> > 
> > statfs(".", 0x7ffd809d5a70)             = -1 EAGAIN (Resource temporarily unavailable)
> > 
> > The same happens if I build
> > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit?id=a280ecca48beb40ca6c0fc20dd5a7fdd9b3ee0b7
> > (knowing that it is not yet ready for review).
> > 
> > I'm slight confused as a280ecca48be ("cifs: fix off-by-one in
> > SMB2_query_info_init()") says in the commit message:
> > 
> > [...]
> > 	v5.10.y doesn't have
> > 
> >         eb3e28c1e89b ("smb3: Replace smb2pdu 1-element arrays with flex-arrays")
> > 
> > 	and the commit does
> > [...]
> > 
> > and in meanwhile though the eb3e28c1e89b was picked (in a backported
> > version). As 6.1.75-rc2 itself does not show the same problem, might
> > there be a prerequisite missing in the backports for 5.10.y or a
> > backport being wrong?
> 
> The problem seems to be that we are picking the backport for
> eb3e28c1e89b, but then still applying 
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git/commit?id=a280ecca48beb40ca6c0fc20dd5
> 
> which was made for the case in 5.10.y where eb3e28c1e89b is not
> present.
> 
> I reverted a280ecca48beb40ca6c0fc20dd5 and now:
> 
> statfs(".", {f_type=SMB2_MAGIC_NUMBER, f_bsize=4096, f_blocks=2189197, f_bfree=593878, f_bavail=593878, f_files=0, f_ffree=0, f_fsid={val=[2004816114, 0]}, f_namelen=255, f_frsize=4096, f_flags=ST_VALID|ST_RELATIME}) = 0

So this works?  Would that just be easier to do overall?  I feel like
that might be best here.

Again, a set of simple "do this and this and this" would be nice to
have, as there are too many threads here, some incomplete and missing
commits on my end.

confused,

greg k-h

