Return-Path: <stable+bounces-77861-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0738987E1F
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 08:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 22235283FDE
	for <lists+stable@lfdr.de>; Fri, 27 Sep 2024 06:07:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BFB715C133;
	Fri, 27 Sep 2024 06:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="gtXqCfDX"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1999F2E630
	for <stable@vger.kernel.org>; Fri, 27 Sep 2024 06:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727417256; cv=none; b=nmipnSuLr5XGXfXcNP626au2IxZLsx/+EVBisxiGjtfr6zT45pFPtLE2XhAaNTu4VPFWX5joOw9PL6VOVMxQVpQby4lQMqrlKLtI5JQeoocKk3pZqvIBRI67c5rkqCdww8REw5/4JgBA8G8IUact8AfjCjXg/EzfgN/eIfHAzfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727417256; c=relaxed/simple;
	bh=C8OJP7Ynkx0f8zifCJV0+ApMB1Fp/I+nMF+cnqbgY/U=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DYAXJCG3SYpXU/TVeCaaV4qVu2UfmkZLT8X79ECSdrM+JYDR/p5xbxZZqE24BQwN0daUW1sRm5RYpyZXOL4+CXiMfWYMjTB+gx+5NKBT84bQE6c07SkmkLmGqy48ZQy9Ge/DEjh9S284XHncYS8T1R8nvzElNK1YdHvEJx3za/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=gtXqCfDX; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E0BC4CEC4;
	Fri, 27 Sep 2024 06:07:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727417255;
	bh=C8OJP7Ynkx0f8zifCJV0+ApMB1Fp/I+nMF+cnqbgY/U=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gtXqCfDXsqgKTnvoBSKkyzlfzsyb01XxIggvzqJebztn3bPFwtcjnmDptAP0+Iri+
	 uVuKW5j8+aXpCE6bpO3TtVzYnWXlG6+0UE4iZ4TlxszxL55dmvg21DjWENXtQ3hQjs
	 yal/lS2bg0x52sY4g+htxr0rp+iVGBhIWd2SVjaI=
Date: Fri, 27 Sep 2024 08:07:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>, qin.wan@hp.com
Subject: Re: Request to apply patches to v6.6 to fix thunderbolt issue
Message-ID: <2024092710-monsieur-deferral-71b7@gregkh>
References: <MW4PR84MB151669954C1D210A0FED92128D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
 <MW4PR84MB1516C1E8175FF8931ACF8AB18D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
 <2024091925-elixir-joylessly-9f33@gregkh>
 <ZvWIQW5o5sTKvfJE@jam-buntu>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZvWIQW5o5sTKvfJE@jam-buntu>

On Thu, Sep 26, 2024 at 07:35:38PM +0000, Gagniuc, Alexandru wrote:
> On Thu, Sep 19, 2024 at 11:04:23AM +0200, Greg KH wrote:
> > On Thu, Sep 19, 2024 at 08:38:52AM +0000, Wan, Qin (Thin Client RnD) wrote:
> > > Hello,
> > > 
> > >    There is an issue found on v6.6.16: Plug in thunderbolt G4 dock with monitor connected after system boots up. The monitor shows nothing when wake up from S3 sometimes. The failure rate is above 50%.
> > >    The kernel reports “UBSAN: shift-out-of-bounds in drivers/gpu/drm/display/drm_dp_mst_topology.c:4416:36”. The call stack is shown at the bottom of this email.
> > >    This failure is fixed in v6.9-rc1. 
> > >    We request to merge below commit to v6.6.
> > > 
> > >   6b8ac54f31f985d3abb0b4212187838dd8ea4227
> > >  thunderbolt: Fix debug log when DisplayPort adapter not available for pairing
> > > 
> > >  fe8a0293c922ee8bc1ff0cf9048075afb264004a
> > >  thunderbolt: Use tb_tunnel_dbg() where possible to make logging more consistent
> > > 
> > >  d27bd2c37d4666bce25ec4d9ac8c6b169992f0f0
> > >  thunderbolt: Expose tb_tunnel_xxx() log macros to the rest of the driver
> > > 
> > >   8648c6465c025c488e2855c209c0dea1a1a15184
> > >  thunderbolt: Create multiple DisplayPort tunnels if there are more DP IN/OUT pairs
> > > 
> > >  f73edddfa2a64a185c65a33f100778169c92fc25
> > >  thunderbolt: Use constants for path weight and priority
> > > 
> > >   4d24db0c801461adeefd7e0bdc98c79c60ccefb0
> > >   thunderbolt: Use weight constants in tb_usb3_consumed_bandwidth()
> > > 
> > >   aa673d606078da36ebc379f041c794228ac08cb5
> > >   thunderbolt: Make is_gen4_link() available to the rest of the driver
> > > 
> > >   582e70b0d3a412d15389a3c9c07a44791b311715
> > >    thunderbolt: Change bandwidth reservations to comply USB4 v2
> > > 
> > >    2bfeca73e94567c1a117ca45d2e8a25d63e5bd2c
> > > 　thunderbolt: Introduce tb_port_path_direction_downstream()
> > > 　
> > > 　956c3abe72fb6a651b8cf77c28462f7e5b6a48b1
> > > 　thunderbolt: Introduce tb_for_each_upstream_port_on_path()
> > > 　
> > > 　c4ff14436952c3d0dd05769d76cf48e73a253b48
> > > 　thunderbolt: Introduce tb_switch_depth()
> > > 　
> > > 　81af2952e60603d12415e1a6fd200f8073a2ad8b
> > > 　thunderbolt: Add support for asymmetric link
> > > 　
> > > 　3e36528c1127b20492ffaea53930bcc3df46a718
> > > 　thunderbolt: Configure asymmetric link if needed and bandwidth allows
> > > 　
> > > 　b4734507ac55cc7ea1380e20e83f60fcd7031955
> > > 　thunderbolt: Improve DisplayPort tunnel setup process to be more robust
> > 
> > Can you send these as a backported series with your signed-off-by to
> > show that you have tested these to verify that they work properly in the
> > 6.6 kernel tree?  That will make them much easier to apply, and track
> > over time.
> > 
> 
> We used the below command to apply the patches. Is this helpful, or is 
> resubmitting the series still required? If so, what script do you use to add
> the "upstream commit" lines to the commit message?
> 
> git cherry-pick 6b8ac54f31f9 fe8a0293c922 d27bd2c37d46 8648c6465c02 \
>                 f73edddfa2a6 4d24db0c8014 aa673d606078 582e70b0d3a4 \
>                 2bfeca73e945 956c3abe72fb c4ff14436952 81af2952e606 \
>                 3e36528c1127 b4734507ac55

It's a bit helpful, but I would still like to see the full series from
you, with your signed-off-by to prove that you tested this all properly
and take responsibility for the backports :)

I do have a script, called 'c2p' in the stable-queue/scripts/ directory
that adds the needed "upstream commit" information, but odds are it's
easier for you to do that by hand instead of trying to get that to work
with your directory structures.

> It's commit 709f7c7172ae ("thunderbolt: Improve DisplayPort tunnel setup
> process to be more robust") which solves the issue, and the pthers are
> dependencies.

Odd, you don't have that commit id in the above 'git cherry-pick' list,
so how could it be the solution here?

confused,

greg k-h

