Return-Path: <stable+bounces-70149-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5819A95ECD1
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 11:13:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id BDDD7B20D00
	for <lists+stable@lfdr.de>; Mon, 26 Aug 2024 09:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B51E13DDB6;
	Mon, 26 Aug 2024 09:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tIbUgswR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083DA81741;
	Mon, 26 Aug 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724663589; cv=none; b=BnFqK2n6IqsHdwliwKzcGRPN9FvWvlCZe3ejK+yy3r6TFPe9wpf+5Sme634/esqgXqObLZ9UlAvdlyNY0+BF+mhK7479pvBkfblcHuXK1fr6to4NB4t5RUxr+WmrwuOvsclHiQfuL8tTcnlcKY4NV+T7BVIAg+iX+1Vn7WC+864=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724663589; c=relaxed/simple;
	bh=a6WJnA2f0U1PEyQ6t4Zt7CqfzEq0TRdO1xLeccCNoeg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oEtFEMpG15zbUWjQGJJPA+QshIYmenX/34ereHssvanxKWFsrWKnZEgLqKqiqrykqswjc34NKIFlXox7VhUnb4mYoIO6LGSS2Q66+3Vl2Q+dBk7/vttb9IjzALEfpgVtMB9xetpYC6gluGuYpvUP4tkQ7GWQXTO7X8YyYu4I1Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tIbUgswR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C65D4C4DDF1;
	Mon, 26 Aug 2024 09:13:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724663588;
	bh=a6WJnA2f0U1PEyQ6t4Zt7CqfzEq0TRdO1xLeccCNoeg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tIbUgswRPLJnS015P5G2FjbNzvN+4bsEKsQo5akaaXs7F/7KLBc2hA4EzD9leJMYV
	 8rgMbn1L4kAu+H5rIwOm8PCi+R0dqTYymYCts+OWn9l+Z+q4eMKqMsQFABSehNspeg
	 cj1S9xDXHtJ/OMmesOsOe58LaKA1qd6KqFGzGkSUeWIiREveH06n6FPDV5PgITbWJU
	 y33ouC4JoyegtKNZh/mjLjTZrMJXmExL1z8IIS0Hb6MHqVqNFPMcLxDFok8gF4wV5G
	 CubtzkDE8HRlhFRmrB43SvO3VCjXEN1Hlx7rJYES9vkepvgxPvJwnhyPItQ1DyjFcG
	 lrHiw5TkTiVYw==
Date: Mon, 26 Aug 2024 11:13:04 +0200
From: Danilo Krummrich <dakr@kernel.org>
To: Jann Horn <jannh@google.com>
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Russ Weight <russ.weight@linux.dev>,
	Danilo Krummrich <dakr@redhat.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH v2] firmware_loader: Block path traversal
Message-ID: <ZsxHIO33o9CYRgxq@pollux>
References: <20240823-firmware-traversal-v2-1-880082882709@google.com>
 <Zskp364_oYM4T8BQ@pollux>
 <CAG48ez3A=NZ9GqkQv9U6871ciNc+Yy=AvPfm3UgeXfMyh=0+oQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAG48ez3A=NZ9GqkQv9U6871ciNc+Yy=AvPfm3UgeXfMyh=0+oQ@mail.gmail.com>

On Sat, Aug 24, 2024 at 03:34:20AM +0200, Jann Horn wrote:
> On Sat, Aug 24, 2024 at 2:31 AM Danilo Krummrich <dakr@kernel.org> wrote:
> > On Fri, Aug 23, 2024 at 08:38:55PM +0200, Jann Horn wrote:
> > > Fix it by rejecting any firmware names containing ".." path components.
> [...]
> > > +/*
> > > + * Reject firmware file names with ".." path components.
> > > + * There are drivers that construct firmware file names from device-supplied
> > > + * strings, and we don't want some device to be able to tell us "I would like to
> > > + * be sent my firmware from ../../../etc/shadow, please".
> > > + *
> > > + * Search for ".." surrounded by either '/' or start/end of string.
> > > + *
> > > + * This intentionally only looks at the firmware name, not at the firmware base
> > > + * directory or at symlink contents.
> > > + */
> > > +static bool name_contains_dotdot(const char *name)
> > > +{
> > > +     size_t name_len = strlen(name);
> > > +     size_t i;
> > > +
> > > +     if (name_len < 2)
> > > +             return false;
> > > +     for (i = 0; i < name_len - 1; i++) {
> > > +             /* do we see a ".." sequence? */
> > > +             if (name[i] != '.' || name[i+1] != '.')
> > > +                     continue;
> > > +
> > > +             /* is it a path component? */
> > > +             if ((i == 0 || name[i-1] == '/') &&
> > > +                 (i == name_len - 2 || name[i+2] == '/'))
> > > +                     return true;
> > > +     }
> > > +     return false;
> > > +}
> >
> > Why do you open code it, instead of using strstr() and strncmp() like you did
> > in v1? I think your approach from v1 read way better.
> 
> The code in v1 was kinda sloppy - it was probably good enough for this
> check, but not good enough to put in a function called
> name_contains_dotdot() that is documented to exactly search for any
> ".." components.
> 
> Basically, the precise regex we have to search for is something like
> /(^|/)\.\.($|/)/
> 
> To implement that by searching for substrings like in v1, we'd have to
> search for each possible combination of the capture groups in the
> regex, which gives the following four (pow(2,2)) patterns:
> 
> <start>..<end>
> <start>../
> /..<end>
> /../

I see.

> 
> So written like in v1, that'd look something like:
> 
> if (strcmp(name, "..") == 0 || strncmp(name, "../", 3) == 0 ||
> strstr(name, "/../") != NULL || (name_len >= 3 &&
> strcmp(name+name_len-3, "/..") == 0)))
>   return true;

I think I still slightly prefer this variant, but I think either one is fine.

With one or the other and dev_warn() fixed,

Reviewed-by: Danilo Krummrich <dakr@kernel.org>

> 
> Compared to that, I prefer the code I wrote in v2, since it is less
> repetitive. But if you want, I can change it to the expression I wrote
> just now.
> 

