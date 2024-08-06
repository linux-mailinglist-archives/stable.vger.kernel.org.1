Return-Path: <stable+bounces-65468-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EE436948989
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 08:39:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8771BB227CD
	for <lists+stable@lfdr.de>; Tue,  6 Aug 2024 06:39:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9AE311BBBEB;
	Tue,  6 Aug 2024 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zv6CZQIW"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B700149DF0
	for <stable@vger.kernel.org>; Tue,  6 Aug 2024 06:38:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722926336; cv=none; b=a7lAP3Fa7W9npItGYZzUdCaTPNP/FTlI0p/gP2FUE62KTeLtpPvnlPCAJVV0XbQWl5XIo+0dNUR67jPi8BSYby9XyVVGnOwIvNhXqN1neR7IZYdSyKt8lj+qXNweLwYSzpxNBGEkD6bJSHiSgO2H3/d6jl1VE/QyANlLJzDHXlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722926336; c=relaxed/simple;
	bh=Fi+lZKOUhW5Q57CjW0zk+vxyeKJfgoYlfcviUnvH59U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Dvniy4R2HNTctSq6zIU/17qHJN45AA91j0qFIsrOvFvF18P9nHXprxGXopu9HUzXQylavnxW9lrEhjcmBOzMRLuex28UF12Or8kc2xjCKeI+DwkGtko3HkfsHK59xCDr07xiS6nKm62YY7hBKEHG71YQKj/yES0sHMA32w4O7Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zv6CZQIW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F45AC32786;
	Tue,  6 Aug 2024 06:38:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1722926335;
	bh=Fi+lZKOUhW5Q57CjW0zk+vxyeKJfgoYlfcviUnvH59U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=zv6CZQIWyRCLPJ7K95vQ8cS+NpDmVhm2d7cp97T1o0xDLC0/f/33XZX+pyrTTv//0
	 1rUaztKb4F3cBlOKRzWDbGLAJCfClbycF8TcsxvBCwJFZrc9WqYD5/sHN3bSqSKISZ
	 kms9tRQD5NPDdbGxDZnCvN7wET1avrfF+Psj1/1I=
Date: Tue, 6 Aug 2024 08:38:51 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Andi Shyti <andi.shyti@linux.intel.com>
Cc: intel-gfx <intel-gfx@lists.freedesktop.org>,
	dri-devel <dri-devel@lists.freedesktop.org>, stable@vger.kernel.org,
	Jani Nikula <jani.nikula@linux.intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Tvrtko Ursulin <tursulin@ursulin.net>, Jann Horn <jannh@google.com>,
	Chris Wilson <chris.p.wilson@linux.intel.com>,
	Krzysztof Niemiec <krzysztof.niemiec@intel.com>,
	Andi Shyti <andi.shyti@kernel.org>
Subject: Re: [PATCH v2 0/2] Fix mmap memory boundary calculation
Message-ID: <2024080640-landfall-doozy-e0d2@gregkh>
References: <20240805102554.154464-1-andi.shyti@linux.intel.com>
 <ZrFMopcHlT6G7p3V@ashyti-mobl2.lan>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZrFMopcHlT6G7p3V@ashyti-mobl2.lan>

On Mon, Aug 05, 2024 at 11:05:22PM +0100, Andi Shyti wrote:
> Hi Greg,
> 
> > Andi Shyti (2):
> >   drm/i915/gem: Adjust vma offset for framebuffer mmap offset
> >   drm/i915/gem: Fix Virtual Memory mapping boundaries calculation
> 
> I have forgotten to Cc the stable mailing list here. These two
> patches need to be merged together even if only the second patch
> has the "Fixes:" tag.
> 
> Is there anything I should still do here?
> 
> I could have used the "Requires:" tag, but the commit id would
> change in between merges and rebases.

<formletter>

This is not the correct way to submit patches for inclusion in the
stable kernel tree.  Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for how to do this properly.

</formletter>

