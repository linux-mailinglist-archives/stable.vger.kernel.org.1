Return-Path: <stable+bounces-76744-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C3E97C686
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 11:04:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A9CA51C2031A
	for <lists+stable@lfdr.de>; Thu, 19 Sep 2024 09:04:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACC59194C92;
	Thu, 19 Sep 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="QYtk649D"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B32812E48
	for <stable@vger.kernel.org>; Thu, 19 Sep 2024 09:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726736667; cv=none; b=P+Xl8K3SAItdqfSTGwWY0npebPYOpp0eL+ie8L2Jip14otW2LB9dbQPR+o8niVXbgVr6kaM3K8KORGzSl9MjEb/j5NdxU+2MibZ06V8L85trrMB9bWY6ohTkvJFlMZYvgCogVFZavY9GoQP9zhpDsjLZbTUXdONW24aV743RVF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726736667; c=relaxed/simple;
	bh=zfFDPQ5o/x1KGXrYGc0/sVOiOCfx7QtkeQf0Zwk+lwo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Obg3KRy0Dqw7p2M8tprJz2GFV58DWAVeXSM8dnCk3q5n963+MaSaQXlKi2Guo8dDAEkg7oub7V+n+NGlrNWaFeBcbv/H/mpVvlH7kgQeQL3391oCfZGvO+vhUoW4i21Us7VB+KaeAImEg3Twbt5nngzgUM1rKqirygHG8Y8Crv0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=QYtk649D; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE313C4CEC4;
	Thu, 19 Sep 2024 09:04:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726736667;
	bh=zfFDPQ5o/x1KGXrYGc0/sVOiOCfx7QtkeQf0Zwk+lwo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=QYtk649D4PDeKFONuJXYv+JpBQhLW/n3TKikkhaP5E6vDQSbre/CbO0aoXMXgxmW6
	 YYvUIuv0B7ZCcSLyxX8/ZrG5xfNSwqx6WlWDVGw8EygyfyfLM73ffz/kjGv+6+lLwg
	 XDJqI/ofOyToCOIeb23i8+NPerjAH8h2oWt/6bTQ=
Date: Thu, 19 Sep 2024 11:04:23 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Wan, Qin (Thin Client RnD)" <qin.wan@hp.com>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	"Gagniuc, Alexandru" <alexandru.gagniuc@hp.com>
Subject: Re: Request to apply patches to v6.6 to fix thunderbolt issue
Message-ID: <2024091925-elixir-joylessly-9f33@gregkh>
References: <MW4PR84MB151669954C1D210A0FED92128D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
 <MW4PR84MB1516C1E8175FF8931ACF8AB18D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <MW4PR84MB1516C1E8175FF8931ACF8AB18D632@MW4PR84MB1516.NAMPRD84.PROD.OUTLOOK.COM>

On Thu, Sep 19, 2024 at 08:38:52AM +0000, Wan, Qin (Thin Client RnD) wrote:
> Hello,
> 
>    There is an issue found on v6.6.16: Plug in thunderbolt G4 dock with monitor connected after system boots up. The monitor shows nothing when wake up from S3 sometimes. The failure rate is above 50%.
>    The kernel reports “UBSAN: shift-out-of-bounds in drivers/gpu/drm/display/drm_dp_mst_topology.c:4416:36”. The call stack is shown at the bottom of this email.
>    This failure is fixed in v6.9-rc1. 
>    We request to merge below commit to v6.6.
> 
>   6b8ac54f31f985d3abb0b4212187838dd8ea4227
>  thunderbolt: Fix debug log when DisplayPort adapter not available for pairing
> 
>  fe8a0293c922ee8bc1ff0cf9048075afb264004a
>  thunderbolt: Use tb_tunnel_dbg() where possible to make logging more consistent
> 
>  d27bd2c37d4666bce25ec4d9ac8c6b169992f0f0
>  thunderbolt: Expose tb_tunnel_xxx() log macros to the rest of the driver
> 
>   8648c6465c025c488e2855c209c0dea1a1a15184
>  thunderbolt: Create multiple DisplayPort tunnels if there are more DP IN/OUT pairs
> 
>  f73edddfa2a64a185c65a33f100778169c92fc25
>  thunderbolt: Use constants for path weight and priority
> 
>   4d24db0c801461adeefd7e0bdc98c79c60ccefb0
>   thunderbolt: Use weight constants in tb_usb3_consumed_bandwidth()
> 
>   aa673d606078da36ebc379f041c794228ac08cb5
>   thunderbolt: Make is_gen4_link() available to the rest of the driver
> 
>   582e70b0d3a412d15389a3c9c07a44791b311715
>    thunderbolt: Change bandwidth reservations to comply USB4 v2
> 
>    2bfeca73e94567c1a117ca45d2e8a25d63e5bd2c
> 　thunderbolt: Introduce tb_port_path_direction_downstream()
> 　
> 　956c3abe72fb6a651b8cf77c28462f7e5b6a48b1
> 　thunderbolt: Introduce tb_for_each_upstream_port_on_path()
> 　
> 　c4ff14436952c3d0dd05769d76cf48e73a253b48
> 　thunderbolt: Introduce tb_switch_depth()
> 　
> 　81af2952e60603d12415e1a6fd200f8073a2ad8b
> 　thunderbolt: Add support for asymmetric link
> 　
> 　3e36528c1127b20492ffaea53930bcc3df46a718
> 　thunderbolt: Configure asymmetric link if needed and bandwidth allows
> 　
> 　b4734507ac55cc7ea1380e20e83f60fcd7031955
> 　thunderbolt: Improve DisplayPort tunnel setup process to be more robust

Can you send these as a backported series with your signed-off-by to
show that you have tested these to verify that they work properly in the
6.6 kernel tree?  That will make them much easier to apply, and track
over time.

Also, you should cc: the relevant maintainers/developers of those
changes to allow them to comment if they should be backported or not.

thanks,

greg k-h

