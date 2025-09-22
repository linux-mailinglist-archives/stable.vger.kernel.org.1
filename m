Return-Path: <stable+bounces-180968-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2893EB919C0
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 16:12:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 289D4188399E
	for <lists+stable@lfdr.de>; Mon, 22 Sep 2025 14:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46D642AA6;
	Mon, 22 Sep 2025 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L4cZDk7p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 994601DA23
	for <stable@vger.kernel.org>; Mon, 22 Sep 2025 14:12:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758550360; cv=none; b=nft1CCugwo6jjXHovI9mTD3B9qT6FNq5mgDJTbdBD1U6nbR/Mtkny7lhXO0zzz/EcSSSX3ysA7GhjVgXmL4K1MzF/C9esEATNSd4Vqe9Eq4TzCn/h6Ab3jLTH6ZUQ7rsgpzYgRUHOsMSF8tXLY1exuuK4Bpqzsj+N52rmqREhSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758550360; c=relaxed/simple;
	bh=CaY+tzk/I0eYVb03y0+XZXXMFKNajfzxDyDHMNmxz/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=cAqbwCnaKyYpK9w/slvJiNEFWL5r3b+iKFxXngU4LJmqsJtRUnKNjCmWPIojeP31UITZ24GovFdsM2wltOIrgv5eHsvBYvc6h3cS3l9+ecT+QVnx96KRjCG5w059MhtwtEVKv9hv8cpLdt3aHAzSRrfW/iQvylLTbCPlsvdHEcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L4cZDk7p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF32C4CEF0;
	Mon, 22 Sep 2025 14:12:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1758550360;
	bh=CaY+tzk/I0eYVb03y0+XZXXMFKNajfzxDyDHMNmxz/Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=L4cZDk7pzHd/PUmsmRwwPMEMF7zWCzOBpnxQ3vIiyRmIZ4mhWfA6HSRe5x+SzyeaB
	 mmBTHAv+8xV0f3SK0io04wy3nA3BTF0c0VVEChpSZpOFjMAn9h3zb2CqUMKnJQijeb
	 0ez4RHF0+YWTTNkVVsF/N48RkazKtdyLCEjrm5Yc=
Date: Mon, 22 Sep 2025 16:12:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Eric Hagberg <ehagberg@janestreet.com>
Cc: Jan Kara <jack@suse.cz>, stable@vger.kernel.org
Subject: Re: "loop: Avoid updating block size under exclusive owner" breaks
 on 6.6.103
Message-ID: <2025092241-fraying-crowd-1992@gregkh>
References: <CAAH4uRA=wJ1W65PUYpv=bdGFdfvXp7BFEg+=F1g3w-JFRrbpBw@mail.gmail.com>
 <oqe6w7pmfwzzxaqyaebdzrfi63atoudeaayvebmnemngum4vmi@dwd6d4cs3blx>
 <2025092102-passing-saxophone-d397@gregkh>
 <CAAH4uRCRtMwG8B3my1-b=RAbAw=j3YBx+uhybu8PKd9T=k3oHw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAAH4uRCRtMwG8B3my1-b=RAbAw=j3YBx+uhybu8PKd9T=k3oHw@mail.gmail.com>

On Mon, Sep 22, 2025 at 10:07:55AM -0400, Eric Hagberg wrote:
> This is what I applied:

<snip>

Can you turn it into a patch I can apply with the reasons why it's being
reverted and your signed-off-by line?  Same format as any other normal
kernel patch.

thanks,

greg k-h

