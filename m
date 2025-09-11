Return-Path: <stable+bounces-179245-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F080AB52BE7
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 10:37:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0D1061C83B98
	for <lists+stable@lfdr.de>; Thu, 11 Sep 2025 08:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 041C12E5B1F;
	Thu, 11 Sep 2025 08:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="onzkfL6g"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD8CE2E283A;
	Thu, 11 Sep 2025 08:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757579842; cv=none; b=FtrsK2R115sCsPiu2rx649zJ2b5g6Qsbot4lOKgeenWjLUtKBhyU6RBeZDGOdBVflkQZkWVF2z9qLZOLqasrBH6FmeDFXqp+fRqjGOS090ydHTkpn4W+UYgNHAc/V6BX959z2HjN5xZMrbYmTv4GLrGfxXoZYrwfdduM8n/1z6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757579842; c=relaxed/simple;
	bh=XslGsUoupOrtKg0lfUcpg0DWyp4IyzJwG6qK2UD+EvA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dbW6m0th6SUQWYGa6ebtXyyJliODSoqZLTFzohCj8VeaWDqqUggZTs0IG9EWh7vUWBuNcH27I5fU9wnxm9NGIIISeKJc8GN7g4ruEGeCqSBi3waGtOVo4bx9v82oy9NyAiVyvsfyBO2bUB7jzfl8wN1nbi83DE3uVlczAVET0EA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=onzkfL6g; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 10E4BC4CEF1;
	Thu, 11 Sep 2025 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1757579842;
	bh=XslGsUoupOrtKg0lfUcpg0DWyp4IyzJwG6qK2UD+EvA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=onzkfL6g4ORhBQHe5opjlNM4i/9UWLfnOlBcbo6tco7YIiVmFxoBXNzNlvZouFfhM
	 cElFlnyK2WOHyP/Tf/ViME1lb6m2jIPpF/8y22493TMwBHxZgTFlKq13ZFrf/U3bjr
	 gnlCTs9l2sHTZEsaoiT4R7IZ2Tdp9+IXckb1vcuY=
Date: Thu, 11 Sep 2025 10:37:19 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Farber, Eliav" <farbere@amazon.com>
Cc: "jesse.brandeburg@intel.com" <jesse.brandeburg@intel.com>,
	"anthony.l.nguyen@intel.com" <anthony.l.nguyen@intel.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"vitaly.lifshits@intel.com" <vitaly.lifshits@intel.com>,
	"post@mikaelkw.online" <post@mikaelkw.online>,
	"intel-wired-lan@lists.osuosl.org" <intel-wired-lan@lists.osuosl.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"Chocron, Jonathan" <jonnyc@amazon.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH 5.10.y] e1000e: fix EEPROM length types for overflow
 checks
Message-ID: <2025091122-obsolete-earthen-8c9b@gregkh>
References: <20250910173138.8307-1-farbere@amazon.com>
 <2025091131-tractor-almost-6987@gregkh>
 <f524c24888924a999c3bb90de0099b78@amazon.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f524c24888924a999c3bb90de0099b78@amazon.com>

On Thu, Sep 11, 2025 at 06:13:33AM +0000, Farber, Eliav wrote:
> > On Wed, Sep 10, 2025 at 05:31:38PM +0000, Eliav Farber wrote:
> >> Fix a compilation failure when warnings are treated as errors:
> >>
> >> drivers/net/ethernet/intel/e1000e/ethtool.c: In function ‘e1000_set_eeprom’:
> >> ./include/linux/overflow.h:71:15: error: comparison of distinct pointer types lacks a cast [-Werror]
> >>    71 |  (void) (&__a == __d);   \
> >>       |               ^~
> >> drivers/net/ethernet/intel/e1000e/ethtool.c:582:6: note: in expansion of macro ‘check_add_overflow’
> >>   582 |  if (check_add_overflow(eeprom->offset, eeprom->len, &total_len) ||
> >>       |      ^~~~~~~~~~~~~~~~~~
> >>
> >> To fix this, change total_len and max_len from size_t to u32 in 
> >> e1000_set_eeprom().
> >> The check_add_overflow() helper requires that the first two operands 
> >> and the pointer to the result (third operand) all have the same type.
> >> On 64-bit builds, using size_t caused a mismatch with the u32 fields
> >> eeprom->offset and eeprom->len, leading to type check failures.
> >>
> >> Fixes: ce8829d3d44b ("e1000e: fix heap overflow in e1000_set_eeprom")
> >> Signed-off-by: Eliav Farber <farbere@amazon.com>
> >> ---
> >>  drivers/net/ethernet/intel/e1000e/ethtool.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/net/ethernet/intel/e1000e/ethtool.c 
> >> b/drivers/net/ethernet/intel/e1000e/ethtool.c
> >> index 4aca854783e2..584378291f3f 100644
> >> --- a/drivers/net/ethernet/intel/e1000e/ethtool.c
> >> +++ b/drivers/net/ethernet/intel/e1000e/ethtool.c
> >> @@ -559,7 +559,7 @@ static int e1000_set_eeprom(struct net_device 
> >> *netdev,  {
> >>       struct e1000_adapter *adapter = netdev_priv(netdev);
> >>       struct e1000_hw *hw = &adapter->hw;
> >> -     size_t total_len, max_len;
> >> +     u32 total_len, max_len;
> >>       u16 *eeprom_buff;
> >>       int ret_val = 0;
> >>       int first_word;
> >> --
> >> 2.47.3
> >>
> >
> > Why is this not needed in Linus's tree?
> Kernel 5.10.243 enforces the same type, but this enforcement is
> absent from 5.15.192 and later:
> /*
>  * For simplicity and code hygiene, the fallback code below insists on
>  * a, b and *d having the same type (similar to the min() and max()
>  * macros), whereas gcc's type-generic overflow checkers accept
>  * different types. Hence we don't just make check_add_overflow an
>  * alias for __builtin_add_overflow, but add type checks similar to
>  * below.
>  */
> #define check_add_overflow(a, b, d) __must_check_overflow(({	\

Yeah, the min() build warning mess is slowly propagating back to older
kernels over time as we take these types of fixes backwards.  I count 3
such new warnings in the new 5.10 release, not just this single one.

Overall, how about fixing this up so it doesn't happen anymore by
backporting the min() logic instead?  That should solve this build
warning, and keep it from happening again in the future?  I did that for
newer kernel branches, but never got around to it for these.

thanks,

greg k-h

