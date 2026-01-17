Return-Path: <stable+bounces-210147-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id A1632D38E6F
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 13:17:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E57313016F99
	for <lists+stable@lfdr.de>; Sat, 17 Jan 2026 12:17:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8FA32FE589;
	Sat, 17 Jan 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="yh2KZUeQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784041D86DC;
	Sat, 17 Jan 2026 12:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768652235; cv=none; b=fAi0OC3UUjFx4+eVNpA4/Wip7CaRMLeAuRJ7/cc1+0H898th6+Yn3acgsUfsZJ9EhgZ9gEu1E9F9oDA+CbpTwKUTOVrYILpVemh4vTR2DlYj0DXdXVZ68AcA0vqdbjxpRBEt/4xF26WP5PlghtrA1GthEaUfXdkZndN/6bHwYY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768652235; c=relaxed/simple;
	bh=AeGXi/KeHcctgxucDBma0bVaekQNHkcfrS+In/uEdxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DNvV2iH5vwUxfG777ECLAw3ZvkGi7eW+cPtOGIFaLjKv2VegZLsCyu7oSLO27ZxoGQI01f1PGSEErn1mi3KJzLY/EYpj2ptcUVoZA5sEkUzGYJHAdBLanuz4bWc64gSHb+11766KLzT24au4QODXcOvcDxvTcZLZbvRjG8NA1/I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=yh2KZUeQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AEF1C4CEF7;
	Sat, 17 Jan 2026 12:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1768652235;
	bh=AeGXi/KeHcctgxucDBma0bVaekQNHkcfrS+In/uEdxk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=yh2KZUeQx8Ybe6A11vjFv0l6lrTc2g1AM3LnjM/+swJSzK076nvDV32aD3YTWBXVp
	 C6TyRj5IympdT5VZQKItI64n2m7+v+ijZ4aZ5K3kUdwtxQLbOQ+rxOuv21tOFYp7rl
	 0OPShqrpcYKNazCmFg3p3rZ+8mLfzPxYSKaYFWvY=
Date: Sat, 17 Jan 2026 13:17:11 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: Weigang He <geoffreyhe2@gmail.com>, mathias.nyman@intel.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] usb: xhci: fix missing null termination after
 copy_from_user()
Message-ID: <2026011731-reabsorb-obtuse-8d2d@gregkh>
References: <20260117094631.504232-1-geoffreyhe2@gmail.com>
 <2026011725-ecosystem-proved-a6ba@gregkh>
 <20260117120632.75e3c394@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260117120632.75e3c394@pumpkin>

On Sat, Jan 17, 2026 at 12:06:32PM +0000, David Laight wrote:
> On Sat, 17 Jan 2026 10:58:41 +0100
> Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > On Sat, Jan 17, 2026 at 09:46:31AM +0000, Weigang He wrote:
> > > The buffer 'buf' is filled by copy_from_user() but is not properly
> > > null-terminated before being used with strncmp(). If userspace provides
> > > fewer than 10 bytes, strncmp() may read beyond the copied data into
> > > uninitialized stack memory.  
> > 
> > But that's fine, it will not match the check, and so it will stop when
> > told, so no overflow happens anywhere.
> 
> That's not entirely true.
> If the user passes "complianc" (without a '\0') and the on-stack buf[9]
> happens to be 'e' then the test will succeed rather than fail.

Ok, fair enough, but you are root doing this so you can do much worse
things to the system than this :)

> But the only thing that will get upset is KASAN.

Agreed.

> More 'interestingly':
> - why is it min_t() not min(), everything is size_t.
> - why sizeof(buf) - 1, reading into the last byte won't matter.
> - why buf[32] not buf[10], even [16] would be plenty for 'future expansion'.

It's debugfs, who are we to judge :)

greg k-h

