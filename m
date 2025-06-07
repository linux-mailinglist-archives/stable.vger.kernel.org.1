Return-Path: <stable+bounces-151744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED19EAD0C33
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 11:36:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F247170789
	for <lists+stable@lfdr.de>; Sat,  7 Jun 2025 09:36:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE63A20F097;
	Sat,  7 Jun 2025 09:34:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4Ph7p9i"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3B2F20F090
	for <stable@vger.kernel.org>; Sat,  7 Jun 2025 09:34:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749288855; cv=none; b=GoSBtZVSxx8rB+4mquy7VE0fFKNrWf0zrQo4aePTepAVxG/HeZ+URXDY4OzU/0o+/PoOLKhz5KsJnVqq0Gxyx/RxghbQUTX6q6rG80Iy8RL0vslCkaTYtuDaAZmAoVQ5CKNWicOdhejv4mnML0exR8VaFfu7yuX8sxo8nPlHyhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749288855; c=relaxed/simple;
	bh=BBXcfqj7W9ynAW8o4oPW2RqOod3vAaKc+/zVa0ESOSw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=CXh7H7fooW45wdGkOYRJMziiD0tWvGjrtQEez51+qkFpWHzUfvgdVv0rrdhRMn/3O8crDnx1hDcyPGVKLvcSlUaUTnNRXjYiZNJKb6R8+7jhUprPo2yjFvbW/Re5oPkPXUkQ+mGTfj+mM198ftndU32uV+e6Fh+fjPxe6s5bXj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4Ph7p9i; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=debian.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-607cc1a2bd8so263880a12.2
        for <stable@vger.kernel.org>; Sat, 07 Jun 2025 02:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749288852; x=1749893652; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1dc8a6YSmdvRazwj130CdpnWT+qEBrZyO+e/R8x2R68=;
        b=j4Ph7p9iSwCP+BCfrh269R5y0k1zqzv7svgKdC3UeONuY+NAhy4/kUf+qIy8gx2Ycv
         bTZkr5C20UUwfRGS1M7GpQ7AbjSfIUouahLKNZw32vjXjhoan9NEWKC4IhJpF23rIS9t
         fK3msShX6nlnsRvWdLgKgX5a+RipJpIUe0PASi0Ym2uWvaFCxJWg1QtxhDbgSyXJ1FEK
         WIW/iMxIMZCghW8ZLTuobHvQ8GbfL/aCqUxss9p+/JIvVHTL9yyMV3gAzkSBRoTEYQit
         VnY16TiHD3eoLz7i3eIwmpa79OambH2iOfrMMMC2GaRsRGX34Q9x6D0DeYymHecLnyE8
         9FuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749288852; x=1749893652;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1dc8a6YSmdvRazwj130CdpnWT+qEBrZyO+e/R8x2R68=;
        b=M7MtLeeLYeu0S2O3ZU+eB6aXzYJ0RTEQbJaFzmRqNQpNHsrfbS5jG1b1vAzle+mHFW
         J1XmIGt8ynkyGCQ9nBMvyPgILS9ZTQtRJ77F1xyBVJga2JZqLxoDOfH1T5e0BmbMJSoA
         x49DFZzqoNHQhhgS+8ep9hmlpmK5KJH8lvN8H9tRoVsNedktLL2D8Z80zXqqJqHCC9CJ
         TZjllELMiRwmzPY3+8QwPNZ04TcJXvQbyjZtP2VyKCTppux6Ckr6UIkD8mE9Y+z2VWjs
         b+4frYU4Si7JSJPnOjhcyW1CKZSk8NPVWs7fUgeIIwOSbsudw916Z3kfKltFEJq0Ga9K
         f9GQ==
X-Gm-Message-State: AOJu0YyLtaJTgCWCW3qdeNuksyzvtfvOoHE6bsJdnN6lgRRpFyyVe2TX
	wvjLaQoMktbiXBlTatnPSTdzPIsbcBvtzkB7fBdrUc0xjmon9XL9QYJ4x/w9vdjU
X-Gm-Gg: ASbGncvfELNsxpSVgAeAst1oWFpKNb5EFyUT/l4lxk97G6dHxIRrrjIMrEOAuaOCRvs
	UYCaxbhCmyWtiyaOlFlLC6u1x9+B4gzAjtY3fcRAhMv5WUmrDW/bHm7KFs7WKpb4ou5erKb6D5t
	tIlUiZUWZCfx/Ae781BoE6S3mejZv+h8DWscUTLMODqe8LQ7k1d2iUfNC2l/bXOp+bnwj71GDZ9
	BlGJ6HmJPBOmOxmxq3UFvgvLYPcbfec3cQrF5CeBlMiytESSvX4cfaQvlLoJXWd5uypWBEs9rUu
	ngvP48JLwvz6YyyRr4ieqnD8SFIHv7PM6zLyJ58pT/kfH2zbmanI/DyJGYceLtyxZ7XL3UXm7ih
	QqOSPo3jNdFWDUKeH2wk=
X-Google-Smtp-Source: AGHT+IGXr6kEB4Ej+6W59yZ8Mf0PyN/6bHS3Vknjx9CoIRDuEVcibaZ3DMW1ZCsSi2WAjnY5qb9tnw==
X-Received: by 2002:a17:907:3d8a:b0:add:ed0d:a56c with SMTP id a640c23a62f3a-ade1a8128cemr595892366b.0.1749288851995;
        Sat, 07 Jun 2025 02:34:11 -0700 (PDT)
Received: from eldamar.lan (c-82-192-244-13.customer.ggaweb.ch. [82.192.244.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ade1d7542bcsm249006366b.32.2025.06.07.02.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Jun 2025 02:34:11 -0700 (PDT)
Sender: Salvatore Bonaccorso <salvatore.bonaccorso@gmail.com>
Received: by eldamar.lan (Postfix, from userid 1000)
	id 8D1F3BE2DE0; Sat, 07 Jun 2025 11:34:10 +0200 (CEST)
Date: Sat, 7 Jun 2025 11:34:10 +0200
From: Salvatore Bonaccorso <carnil@debian.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 5.15 v3 00/16] ITS mitigation
Message-ID: <aEQHkmGXOel3BcOF@eldamar.lan>
References: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250516-its-5-15-v3-0-16fcdaaea544@linux.intel.com>

Hi Pawan,

On Fri, May 16, 2025 at 04:59:28PM -0700, Pawan Gupta wrote:
> v3:
> - Added patches:
>   x86/its: Fix build errors when CONFIG_MODULES=n
>   x86/its: FineIBT-paranoid vs ITS
> 
> v2:
> - Added missing patch to 6.1 backport.
> 
> This is a backport of mitigation for Indirect Target Selection (ITS).
> 
> ITS is a bug in some Intel CPUs that affects indirect branches including
> RETs in the first half of a cacheline. Mitigation is to relocate the
> affected branches to an ITS-safe thunk.
> 
> Below additional upstream commits are required to cover some of the special
> cases like indirects in asm and returns in static calls:
> 
> cfceff8526a4 ("x86/speculation: Simplify and make CALL_NOSPEC consistent")
> 052040e34c08 ("x86/speculation: Add a conditional CS prefix to CALL_NOSPEC")
> c8c81458863a ("x86/speculation: Remove the extra #ifdef around CALL_NOSPEC")
> d2408e043e72 ("x86/alternative: Optimize returns patching")
> 4ba89dd6ddec ("x86/alternatives: Remove faulty optimization")
> 
> [1] https://github.com/torvalds/linux/commit/6f5bf947bab06f37ff931c359fd5770c4d9cbf87

AFAICS there are no backports yet for as well older stable series than
5.15, in particular 5.10.y (which is used in Debian bullseye yet). Are
you planning to make as well backports for the 5.10.y stable series?

Regards,
Salvatore

