Return-Path: <stable+bounces-143054-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8755DAB17AB
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 16:47:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 739E03AFBBC
	for <lists+stable@lfdr.de>; Fri,  9 May 2025 14:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67ECC230BD9;
	Fri,  9 May 2025 14:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NBDafEHq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEB522836C;
	Fri,  9 May 2025 14:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746802004; cv=none; b=rsVMiN7w5GjQNo7VCkQSnyIcwYo5m1vJQj1qrs8TWw/izavDC2F2jd8iUmfqogx9eyMXXoLkwh13niMw240zB/ssQ2S7lEHtFExocwk8t/gIPPYdQ6x7LMdIlEtF8LSvgMpNclu1dZlhRPtGXtUVm/aVf5+IRjXZpGSEOFmuUkU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746802004; c=relaxed/simple;
	bh=ITyllf7NjzMckWcbcZTSZV9MLgSZOrnT/AnyMYDomsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qzxTR8rYdaYRbUrbc8gWefs2esiovbQMyi3Kpl3V4gXGgVHif6ZcBKsUz/djGN/DwWV6WIOW4WhT6X50caHkEHM+S7A/rOL2iQmZnoMuI6HZxbBw6XDZktB2BiQZjmg5WknayYeTEYGraFzzJ33DiLWty6ZQSTavN+lB+jB9xqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NBDafEHq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC543C4CEE4;
	Fri,  9 May 2025 14:46:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1746802001;
	bh=ITyllf7NjzMckWcbcZTSZV9MLgSZOrnT/AnyMYDomsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=NBDafEHqIKTGoT+qTKao2amsX3Yl1IIyCvOGO+Fr5EGgH7POZKUrFRbSibAsoj7uu
	 WAiTj13BWziflZ64/a2ds3d9GOMeppEDIapGu0raybNNf4Bd5Cl+Nl48TvgNbAzwsW
	 OTxNT5k2NZcRZL5EQ4FNPBXnsgDdiLIohtR1CZTk=
Date: Fri, 9 May 2025 16:44:56 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: RD Babiera <rdbabiera@google.com>
Cc: heikki.krogerus@linux.intel.com, badhri@google.com,
	linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v1] usb: typec: tcpm: apply vbus before data bringup in
 tcpm_src_attach
Message-ID: <2025050933-flanking-poison-1d8a@gregkh>
References: <20250429234743.3749129-2-rdbabiera@google.com>
 <2025050116-hardy-twins-913e@gregkh>
 <CALzBnUF7zb6F2iq_1xaF=1vbSkrpvPkPd0Ses0iWDG-n4fxHQQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALzBnUF7zb6F2iq_1xaF=1vbSkrpvPkPd0Ses0iWDG-n4fxHQQ@mail.gmail.com>

On Tue, May 06, 2025 at 10:57:10AM -0700, RD Babiera wrote:
> On Thu, May 1, 2025 at 8:41 AM Greg KH <gregkh@linuxfoundation.org> wrote:
> 
> > Does not apply to my tree, can you rebase against usb-next and resend?
> 
> This patch is rebased against usb-next/usb-next, but I think I do need to rebase
> against usb-linus. commit 8a50da849151e7e12b43c1d8fe7ad302223aef6b is
> present in usb-next but not usb-linus, and my patch as it is now is
> dependent on it.
> 
> Would you prefer that I rebase against usb-linus and resubmit given
> I'm submitting
> as a stable fix? It looks like the conflicting patch would be up for
> the 6.16 merge
> window.

It depends on when you want it merged, for 6.15-final, or 6.16-final.
Your choice.

thanks,

greg k-h

