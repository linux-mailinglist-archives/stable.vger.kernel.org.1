Return-Path: <stable+bounces-154804-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF1CAAE0686
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 15:07:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3B9051885D73
	for <lists+stable@lfdr.de>; Thu, 19 Jun 2025 13:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B3C7B2451F0;
	Thu, 19 Jun 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CcqQIO0i"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63ABF229B29;
	Thu, 19 Jun 2025 13:07:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750338428; cv=none; b=ItAqSxvh5GnlpQNik0zPS1Q8/Bzg+wgG8khTgoIA7WK2TJ8Q/lENQJ03+nHg9+wv8/UCeY5Fu6HH5hXMjiGtTR/Mu8/szIHNpbJyo+4dhHvL9766bF4mx0qWaverYxN/r9hwJpBW3AJmM+9Dp2isNYRsK2IvO/p+QaDJZZNbZz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750338428; c=relaxed/simple;
	bh=wYjI4NswrHuRyR7M4WS61T/lIW6CAoZV8DtQQm4+Yr4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=XVPC9CqfaLuIVAQ6yTiKlLWTFCV3B4GI/5NzCBxC3e9FixMudvFPriAfncKKPVASh0JGr3ZuNpZCN1yDPufTE9YG6kK/YMUZMcbVB4c/VtSa6To6SaKnwlH170HSOUF1aaTCIYShfi3ECRo09/vuWJdq5EE1CxveYZXj4XQj6E8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CcqQIO0i; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F05AC4CEEA;
	Thu, 19 Jun 2025 13:07:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750338428;
	bh=wYjI4NswrHuRyR7M4WS61T/lIW6CAoZV8DtQQm4+Yr4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CcqQIO0ixQ7UmH0za/EE2gqtoyZC+uZYArucJRQv1GR1IbRS9bF00i6zV1fBiadZ4
	 SrA9B6gl5G0e3uLuaZJV8pftTene3KOg/+DIj2pOZvIuT358lrVd4mqZSGq+g8DYRf
	 GIA9aqnXbdIdZUf+Sf2IQfzsHNQq1tZMrBqor4qU=
Date: Thu, 19 Jun 2025 15:07:05 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Mathias Nyman <mathias.nyman@linux.intel.com>
Cc: Roy Luo <royluo@google.com>, Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	"mathias.nyman@intel.com" <mathias.nyman@intel.com>,
	"quic_ugoswami@quicinc.com" <quic_ugoswami@quicinc.com>,
	"michal.pecio@gmail.com" <michal.pecio@gmail.com>,
	"linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH v1 1/2] usb: xhci: Skip xhci_reset in xhci_resume if xhci
 is being removed
Message-ID: <2025061950-obsessed-angelic-526b@gregkh>
References: <20250522190912.457583-1-royluo@google.com>
 <20250522190912.457583-2-royluo@google.com>
 <20250523230633.u46zpptaoob5jcdk@synopsys.com>
 <b982ff0e-1ae8-429d-aa11-c3e81a9c14e5@linux.intel.com>
 <20250529011745.xkssevnj2u44dxqm@synopsys.com>
 <459184db-6fc6-453b-933d-299f827bdc55@linux.intel.com>
 <20250605001838.yw633sgpn2fr65kc@synopsys.com>
 <CA+zupgwLkq_KSN9aawNtYpHzPQpAtQ0A9EJ9iaQQ7vHUPmJohA@mail.gmail.com>
 <d7223d48-f491-494f-8feb-b92a29e9af53@linux.intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d7223d48-f491-494f-8feb-b92a29e9af53@linux.intel.com>

On Thu, Jun 19, 2025 at 03:44:25PM +0300, Mathias Nyman wrote:
> > Thanks Thinh and Mathias for the review.
> > Please let me know if any further changes are needed before these
> > patches can be accepted.
> > I just want to make sure they're still on your radar.
> > 
> > Thanks,
> > Roy
> > 
> 
> I think Greg just picked up these two.

I did, if I need to revert them, please let me know.

thanks,

greg k-h

