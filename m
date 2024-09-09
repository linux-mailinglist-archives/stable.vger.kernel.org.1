Return-Path: <stable+bounces-74043-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D4008971DBF
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 17:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8ACF71F23F83
	for <lists+stable@lfdr.de>; Mon,  9 Sep 2024 15:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D6BE1CAA6;
	Mon,  9 Sep 2024 15:14:55 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1554B2263A;
	Mon,  9 Sep 2024 15:14:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725894895; cv=none; b=SQc7obz/aA8HDXi6k0eHDC7PGsti0se5WXkkuafI/PsUJkTGcQkmJrL0+wRp3JvhQwujkO61FKJL3a5EJ998mgcQapvZ4DsHqLo8SmXwwuxK0YISCB35NQMiHvROcbapmrpLyv1iL9VKKIhO7Ep1SE/0A8KkN78tN7eGvbqHiAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725894895; c=relaxed/simple;
	bh=J5GevXB0W5oGxhLcbHeweH1ds9xojIQf7AHzLkMawxM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WOj5RboKeRY69m7SkWJxBLRvpMdqk1JgonDqc6ba9LN3G9y4UNv6w3fMHOO2S62WYyXB1mSpGFWDup1W0V3/CcG5VdEAfpMOjO9dtmFocRdVOGcYfXJdve2hrXFTd1XvS7ms2/1a6p9gq0MpFaVj0VzO1+YZQY5obyeaTOkcY9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0DACFFEC;
	Mon,  9 Sep 2024 08:15:21 -0700 (PDT)
Received: from bogus (e107155-lin.cambridge.arm.com [10.1.198.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7B8E3F73B;
	Mon,  9 Sep 2024 08:14:49 -0700 (PDT)
Date: Mon, 9 Sep 2024 16:14:47 +0100
From: Sudeep Holla <sudeep.holla@arm.com>
To: Mark Brown <broonie@kernel.org>
Cc: Szabolcs Nagy <nsz@port70.net>,
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
	Szabolcs Nagy <szabolcs.nagy@arm.com>, netdev@vger.kernel.org,
	davem@davemloft.net, kuba@kernel.org, edumazet@google.com,
	pabeni@redhat.com, mst@redhat.com, jasowang@redhat.com,
	arefev@swemel.ru, alexander.duyck@gmail.com,
	Willem de Bruijn <willemb@google.com>, stable@vger.kernel.org,
	Jakub Sitnicki <jakub@cloudflare.com>, Felix Fietkau <nbd@nbd.name>,
	Yury Khrustalev <yury.khrustalev@arm.com>,
	Sudeep Holla <sudeep.holla@arm.com>
Subject: Re: [PATCH net v2] net: drop bad gso csum_start and offset in
 virtio_net_hdr
Message-ID: <Zt8Q5wTHofvERY8p@bogus>
References: <20240729201108.1615114-1-willemdebruijn.kernel@gmail.com>
 <ZtsTGp9FounnxZaN@arm.com>
 <66db2542cfeaa_29a385294b9@willemb.c.googlers.com.notmuch>
 <66de0487cfa91_30614529470@willemb.c.googlers.com.notmuch>
 <20240909094527.GA3048202@port70.net>
 <0b14a8a8-4d98-46a3-9441-254345faa5df@sirena.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0b14a8a8-4d98-46a3-9441-254345faa5df@sirena.org.uk>

On Mon, Sep 09, 2024 at 12:14:28PM +0100, Mark Brown wrote:
> On Mon, Sep 09, 2024 at 11:45:27AM +0200, Szabolcs Nagy wrote:
> 
> > fvp is closed source but has freely available binaries
> > for x86_64 glibc based linux systems (behind registration
> > and license agreements) so in principle the issue can be
> > reproduced outside of arm but using fvp is not obvious.
> 
> > hopefully somebody at arm can pick it up or at least
> > report this thread to the fvp team internally.
> 
> FWIW there's a tool called shrinkwrap which makes it quite a lot easier
> to get going:
> 
>    https://gitlab.arm.com/tooling/shrinkwrap
> 
> though since the models are very flexibile valid configurations that
> people see issues with aren't always covered by shrinkwrap.

It is fairly trivial to change the default config and use virtio-net to
reproduce this issue. If anyone tries the above tool, they can apply below
diff and should be able to reproduce the issue.

--
Regards,
Sudeep

diff --git i/config/FVP_Base_RevC-2xAEMvA-base.yaml w/config/FVP_Base_RevC-2xAEMvA-base.yaml
index 86d8cf9cb0f8..9951c5a948bb 100644
--- i/config/FVP_Base_RevC-2xAEMvA-base.yaml
+++ w/config/FVP_Base_RevC-2xAEMvA-base.yaml
@@ -39,8 +39,10 @@ description: >-
     # Networking. By default use user-space networking, mapping port 22 in the
     # FVP to a user-specified port on the host (see rtvar:LOCAL_NET_PORT). This
     # enables ssh.
-    -C bp.smsc_91c111.enabled: 1
-    -C bp.hostbridge.userNetworking: 1
+    -C bp.smsc_91c111.enabled: 0
+    -C bp.hostbridge.userNetworking: 0
+    -C bp.virtio_net.enabled: 1
+    -C bp.virtio_net.hostbridge.userNetworking: 1
     -C bp.hostbridge.userNetPorts: ${rtvar:LOCAL_NET_PORT}=22

     # FVP Performance tweaks.


