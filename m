Return-Path: <stable+bounces-45621-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FF5A8CCC4D
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 08:34:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2B3FA2823A8
	for <lists+stable@lfdr.de>; Thu, 23 May 2024 06:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A04713C3FC;
	Thu, 23 May 2024 06:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qj4PLV3H"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37BBD1869
	for <stable@vger.kernel.org>; Thu, 23 May 2024 06:34:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716446084; cv=none; b=it+ENfgDOO5PiXhV40EDGaGK35PKGO+lpJud8lHp4jXzd7EV69lDO43znTKpw21CTrAvaNg/KUnSgblW/o88CBWr6B7s/6ppZY9DfLI+Qsp7kBetqX+Ob5beFt8y4OHk/kX1dLa6RU0M/9JqL+/bcYP2RweFcN6eAdAj68ulkcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716446084; c=relaxed/simple;
	bh=XxVSYbHZ+H/p/wEVBPhFkeHIAS4bvPHUHG/AfTbTDl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J9aJ6w23DuPEJkYrWAguh9laj7rgyYzZKL0ed0aQKoWmPQxDMgTQ6Pc4Ba6PkRISY6hM7ab2g3nLnZMFkOoq9AE69F5qsRUAC0m2UAtjDdE28qEdw4z4nH+koCOvC8ZPAqn/8Lb64GPVspbsUx01c9N/l3cNQo2sIP1FRUySXoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qj4PLV3H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33804C2BD10;
	Thu, 23 May 2024 06:34:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1716446083;
	bh=XxVSYbHZ+H/p/wEVBPhFkeHIAS4bvPHUHG/AfTbTDl0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qj4PLV3HfkRjRQvaCMLX5FImOPh0tTMCsbpqbwyjmQ9PuQCJMuRKK4DRfMAdT+H64
	 /pyVc6TFgQ1Ff0VO5zYnQCh7NihLZ5ubHevsFD67z9IPgAHJ09ei56lxzlYf5BLgaN
	 tDPpQVlYjfjJ5j3Xrko/muiRpAeisWvFzfXLZ7Ss=
Date: Thu, 23 May 2024 08:34:40 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Cc: stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
	dave.hansen@linux.intel.com,
	Daniel Sneddon <daniel.sneddon@linux.intel.com>,
	xen-devel@lists.xenproject.org, security@debian.org,
	Salvatore Bonaccorso <carnil@debian.org>, benh@debian.org,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	"H. Peter Anvin" <hpa@zytor.com>, Juergen Gross <jgross@suse.com>,
	Deep Shah <sdeep@vmware.com>,
	"VMware, Inc." <pv-drivers@vmware.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Stefano Stabellini <sstabellini@kernel.org>,
	Andrew Cooper <andrew.cooper3@citrix.com>,
	David Woodhouse <dwmw2@infradead.org>,
	Nikolay Borisov <nik.borisov@suse.com>,
	Josh Poimboeuf <jpoimboe@kernel.org>, Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 5.10] x86/xen: Drop USERGS_SYSRET64 paravirt call
Message-ID: <2024052333-squishy-phony-d2e2@gregkh>
References: <20240522-verw-xen-pv-fix-v1-1-45add699c0e4@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240522-verw-xen-pv-fix-v1-1-45add699c0e4@linux.intel.com>

On Wed, May 22, 2024 at 06:20:15PM -0700, Pawan Gupta wrote:
> From: Juergen Gross <jgross@suse.com>
> 
> commit afd30525a659ac0ae0904f0cb4a2ca75522c3123 upstream.

Now queued up, thanks.

greg k-h

