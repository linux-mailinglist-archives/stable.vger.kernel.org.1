Return-Path: <stable+bounces-50251-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 92A2B9052EE
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 14:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 445E01F218FA
	for <lists+stable@lfdr.de>; Wed, 12 Jun 2024 12:50:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9E86176256;
	Wed, 12 Jun 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="fF7h67g8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B8B416FF58
	for <stable@vger.kernel.org>; Wed, 12 Jun 2024 12:50:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718196610; cv=none; b=CZWvn8lKxzN1zQjA6y2aoTWLTXXqcMlv7e9ENnm3XtnzVvLuCqYAStyFf5hfa2TsDFsefo2ThBcFytKbvqh1WT2P+x2IM6EziNfm7M7d7sfIdFh6Sx8Gf9qjEgX4Wu7huwKd/1XUdgaznhvigHi0ajy3QuZDV22vVNeQawCYJCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718196610; c=relaxed/simple;
	bh=Zq8vvWMH3tcOh/BTIzyhAiLUPRxLhMxSTP7U2fso7JU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RGdyy80dllBRB4Acgzdo3emMHtmnAZybAQ3HzvJbgRh/OUGeUYmXy+hNNWfAKraundAl2K2IiRD2W61ZXircJQjD+a8G8Iyz65Woi5OwRFlmkHUl2E2KVJmoS063kLVRF8ErUPElePGXOjxBQV2DOA9pnrCuNGneTTcIQk1ACJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=fF7h67g8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD1E2C4AF1C;
	Wed, 12 Jun 2024 12:50:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718196610;
	bh=Zq8vvWMH3tcOh/BTIzyhAiLUPRxLhMxSTP7U2fso7JU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fF7h67g8dnFKGPN92JQLszeUJuKcy4/6mpVNDgXtDNrpo+xmWkMpVlTYzP+LzpSmj
	 IVZjen/P0zVMKSTxn5AlA9gGd4NlFTGNRfps8s99uJaeJ9owR7pfERCw8zcBz8c8YW
	 lOHiKG3yF7jZQ70EvkeC+vgcfmKUDtu25FNTawhY=
Date: Wed, 12 Jun 2024 14:50:07 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thomas Voegtle <tv@lio96.de>
Cc: stable@vger.kernel.org, David Howells <dhowells@redhat.com>,
	Steve French <stfrench@microsoft.com>
Subject: Re: 6.6.y: cifs broken since 6.6.23 writing big files with vers=1.0
 and 2.0
Message-ID: <2024061242-supervise-uncaring-b8ed@gregkh>
References: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e519a2f6-eb49-e7e6-ab2e-beabc6cad090@lio96.de>

On Tue, Jun 11, 2024 at 09:20:33AM +0200, Thomas Voegtle wrote:
> 
> Hello,
> 
> a machine booted with Linux 6.6.23 up to 6.6.32:
> 
> writing /dev/zero with dd on a mounted cifs share with vers=1.0 or
> vers=2.0 slows down drastically in my setup after writing approx. 46GB of
> data.
> 
> The whole machine gets unresponsive as it was under very high IO load. It
> pings but opening a new ssh session needs too much time. I can stop the dd
> (ctrl-c) and after a few minutes the machine is fine again.
> 
> cifs with vers=3.1.1 seems to be fine with 6.6.32.
> Linux 6.10-rc3 is fine with vers=1.0 and vers=2.0.
> 
> Bisected down to:
> 
> cifs-fix-writeback-data-corruption.patch
> which is:
> Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c
> and
> linux-stable commit e45deec35bf7f1f4f992a707b2d04a8c162f2240
> 
> Reverting this patch on 6.6.32 fixes the problem for me.

Odd, that commit is kind of needed :(

Is there some later commit that resolves the issue here that we should
pick up for the stable trees?

thanks,

greg k-h

