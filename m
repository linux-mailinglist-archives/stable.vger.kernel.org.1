Return-Path: <stable+bounces-23900-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 481FC86912C
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 14:01:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 74A801C2767D
	for <lists+stable@lfdr.de>; Tue, 27 Feb 2024 13:01:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDB2C13AA2B;
	Tue, 27 Feb 2024 13:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XknqqKSH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA541E867;
	Tue, 27 Feb 2024 13:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709038870; cv=none; b=fVmHTtb0ulsFy/YFwZnGdNuiPTPAY6yjbFPWG2vLTZp9ZGkfzasZtiaCJbvd0zkfdQwnRugQ3CT5oTf3ZsXXwSHAemCvjqzES0AC9r4a3VI5c1FUQy5sps7PCbEv6v0oGJh8RAFZJM4SwNCeFCPm2lFaEHFFW9y1HQxHY/CkZ/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709038870; c=relaxed/simple;
	bh=yPhZdc0GCftKPIVsy1NzwzyYs7onmIdEjnjA5xLT6qk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Qy7Un0E2oXdNYMePtu1paVIQMG+MTGDpbmSkdqzH4B9LbtiadIDoVZT3Fc4giBLkQWfrhFEF9Zv/R8H/yIJPlv8Ujrq1FVh+ba92NjONc7HdZA61SeQvRa/R4ojSTmxCulBZnBt3EhLUrc/FBuCjIaK2Le27gzhXHVq/E94wrb8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XknqqKSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3E0C433C7;
	Tue, 27 Feb 2024 13:01:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1709038869;
	bh=yPhZdc0GCftKPIVsy1NzwzyYs7onmIdEjnjA5xLT6qk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XknqqKSHPGnF3+JxsKV9O+iMEqNi9v/tLr/raiUvKs+z6KY4cESqcEsh9Fql0/3Oy
	 7gBbSTfIuVgNolnH6pAdHTXwV5w8tMJgkCHUSUmW2Q+s57aGkqW/jzOP3oi9MzFE6a
	 2ZrDP7g6Raun8RkNoE/Db93ksmn5aStcBnDVx9U4=
Date: Tue, 27 Feb 2024 14:01:06 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Matthieu Baerts <matttbe@kernel.org>
Cc: stable@vger.kernel.org, MPTCP Upstream <mptcp@lists.linux.dev>,
	Geliang Tang <tanggeliang@kylinos.cn>,
	Mat Martineau <martineau@kernel.org>,
	"David S . Miller" <davem@davemloft.net>
Subject: Re: [PATCH 6.6.y] mptcp: add needs_id for netlink appending addr
Message-ID: <2024022704-disjoin-nearby-7216@gregkh>
References: <2024022654-senate-unleaded-7ae3@gregkh>
 <20240226215620.757784-2-matttbe@kernel.org>
 <2024022723-outshoot-unkind-734f@gregkh>
 <2c80d410-b480-4043-b17f-2aaa357e5d41@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2c80d410-b480-4043-b17f-2aaa357e5d41@kernel.org>

On Tue, Feb 27, 2024 at 12:04:22PM +0100, Matthieu Baerts wrote:
> Hi Greg,
> 
> On 27/02/2024 11:22, Greg KH wrote:
> > On Mon, Feb 26, 2024 at 10:56:21PM +0100, Matthieu Baerts (NGI0) wrote:
> >> From: Geliang Tang <tanggeliang@kylinos.cn>
> >>
> >> Just the same as userspace PM, a new parameter needs_id is added for
> >> in-kernel PM mptcp_pm_nl_append_new_local_addr() too.
> >>
> >> Add a new helper mptcp_pm_has_addr_attr_id() to check whether an address
> >> ID is set from PM or not.
> >>
> >> In mptcp_pm_nl_get_local_id(), needs_id is always true, but in
> >> mptcp_pm_nl_add_addr_doit(), pass mptcp_pm_has_addr_attr_id() to
> >> needs_it.
> >>
> >> Fixes: efd5a4c04e18 ("mptcp: add the address ID assignment bitmap")
> >> Cc: stable@vger.kernel.org
> >> Signed-off-by: Geliang Tang <tanggeliang@kylinos.cn>
> >> Reviewed-by: Mat Martineau <martineau@kernel.org>
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> Signed-off-by: David S. Miller <davem@davemloft.net>
> >> (cherry picked from commit 584f3894262634596532cf43a5e782e34a0ce374)
> >> Signed-off-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
> >> ---
> >> Notes:
> >>  - conflicts in pm_netlink.c because the new helper function expected to
> >>    be on top of mptcp_pm_nl_add_addr_doit() which has been recently
> >>    renamed in commit 1e07938e29c5 ("net: mptcp: rename netlink handlers
> >>    to mptcp_pm_nl_<blah>_{doit,dumpit}").
> >>  - use mptcp_pm_addr_policy instead of mptcp_pm_address_nl_policy, the
> >>    new name after commit 1d0507f46843 ("net: mptcp: convert netlink from
> >>    small_ops to ops").
> >> ---
> >>  net/mptcp/pm_netlink.c | 24 +++++++++++++++++++-----
> >>  1 file changed, 19 insertions(+), 5 deletions(-)
> > 
> > Don't we also need a 5.15.y version of this commit?
> 
> Good point, yes, according to the 'Fixes' tag, we need it as well for
> 5.15.y.
> 
> It looks like no "FAILED: patch" notification has been sent for this
> patch for the 5.15-stable tree. Is it normal?

Hm, odd, I don't know why I didn't send that out, that's a fault on my
side, sorry about that.

So yes, we do need this, I've just now sent the email if you trigger off
of that :)

> I'm asking this because I rely on these notifications to know if I need
> to help to fix conflicts. I don't regularly track if patches we sent
> upstream with 'Cc: stable' & 'Fixes' tags have been backported. It is
> just to know if we need to modify our way of working :)

No, your way of working is WONDERFUL from my side at least, I have no
complaints at all!

thanks,

greg k-h

