Return-Path: <stable+bounces-112141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9E4A27046
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 12:33:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 581F33A2BAA
	for <lists+stable@lfdr.de>; Tue,  4 Feb 2025 11:33:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A15AD2063C8;
	Tue,  4 Feb 2025 11:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="i6D2CQzb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EA0914A4F0
	for <stable@vger.kernel.org>; Tue,  4 Feb 2025 11:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738668829; cv=none; b=klUPiHlSk0NKSnbfiBl7wKz+NLcipFcgSa2AV4Jaf5ShW41AFra1nZ9e3uJWAicmARA0By0gJ5GojfCaq5jIK/NZM5PRgkic7SgpIoI85NX2yBLgfShajQIVN++SsugRy6HNsud/+ze48FHNMv4n2zdaEInGuGXzCBzTqQaCwHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738668829; c=relaxed/simple;
	bh=xdEwh9A9HdUHMGjDLrAYWrYOCiIgzQCYXF/yYXybJhs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LN4VjV/l7VUD1h/WzzI5VWv8qIsbTzdiUciJ/67CywAyAfPOHT41OBWk1LHQ5TXD6L/MM4mxaiM1up9wIhmA6i5mJpOVmwJPXap8MG9CC1+eJ/gP5DY6bnyEJroD8tArLiuadXBGEC5P3glYkSCKA+/XSaSZb92TPIX9jrNCZ60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=i6D2CQzb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4596BC4CEDF;
	Tue,  4 Feb 2025 11:33:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1738668828;
	bh=xdEwh9A9HdUHMGjDLrAYWrYOCiIgzQCYXF/yYXybJhs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=i6D2CQzbUzj+rwdeLAxKff6526p7jlJ0att7U1uPEx97lzwCxx7GX5s8dpJIPdy/K
	 0tu1MkYFcSOyddK2rVsvzb3u7PToAARx137SkogvMha3lk4nYBgDah0skhdFNveOK9
	 NU+Fxzuik7wM/O75I0Il3yy281DunDF2k8TEJI0o=
Date: Tue, 4 Feb 2025 12:33:44 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Daniel Rosenberg <drosen@google.com>
Cc: Todd Kjos <tkjos@google.com>, stable <stable@vger.kernel.org>,
	Android Kernel Team <kernel-team@android.com>,
	Theodore Ts'o <tytso@mit.edu>
Subject: Re: f2fs: Introduce linear search for dentries
Message-ID: <2025020423-paycheck-strength-75ff@gregkh>
References: <CA+PiJmR3etq=i3tQmPLZfrMMxKqkEDwijWQ3wB6ahxAUoc+NHg@mail.gmail.com>
 <2025020118-flap-sandblast-6a48@gregkh>
 <CAHRSSExDWR_65wCvaVu3VsCy3hGNU51mRqeQ4uRczEA0EYs-fA@mail.gmail.com>
 <CA+PiJmT-9wL_3PbEXBZbFCBxAFVnoupwcJsRFt8K=YHje-_rLg@mail.gmail.com>
 <2025020432-stiffen-expire-30bd@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2025020432-stiffen-expire-30bd@gregkh>

On Tue, Feb 04, 2025 at 12:32:22PM +0100, Greg KH wrote:
> On Mon, Feb 03, 2025 at 03:07:10PM -0800, Daniel Rosenberg wrote:
> > On Sat, Feb 1, 2025 at 12:29 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> > >
> > > As the original commit that this says it fixes was reverted, should that
> > > also be brought back everywhere also?  Or did that happen already and I
> > > missed that?
> > >
> > > thanks,
> > >
> > > greg k-h
> > 
> > The revert of the unicode patch is in all of the stable branches
> > already. That f2fs patch is technically a fix for the revert as well,
> > since the existence of either of those is a problem for the same
> > reason :/
> 
> Ok, so that means that the original issue is still in mainline but now
> it is safe to bring the unicode patch back there and add it to the
> stable branches if we also take this one?

It also does not apply cleanly to 5.4.y and 5.10.y so can we get
backports for that sent here?

thanks,

greg k-h

