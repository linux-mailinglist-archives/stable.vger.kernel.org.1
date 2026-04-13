Return-Path: <stable+bounces-235987-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uO1VMXvJ3GmcWQkAu9opvQ
	(envelope-from <stable+bounces-235987-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:46:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 43FED3EAC86
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 12:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DD657300C981
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 10:46:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8CC4313E15;
	Mon, 13 Apr 2026 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Fq+vkzhd"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B44F21B185
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 10:46:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776077176; cv=none; b=Eu/eI8x1XsfzNx4aMF50iiqRgthPfdLezC7mrsoW2P4VFTgX4H/nxRjY/43yMmLr9La9mM9ElyYYfbzJP4J0xwZd7EdIJ0zA9FnXKH0RaH9QPYc/ojxzA+jn/RfD0yQdU8GHdCw/zCiBwh1EAU57CIDlQAdaiWlXzvWTOtDf1S4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776077176; c=relaxed/simple;
	bh=/9jf9OvoLi8GIV9s/avZs5Lx1pyFmO74OPDNOQedqjM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OmUvGFwkKBpi/kpDbu6f+EnkzFLCrFDznp6pp1PH6weXTUB6kgmdO6rn1LA4IPEtFAS28G6cFNCYiB7wjMjSJLVK5U3j0SgupZait2Qe7kCf817dBkomvwrBvyc3S/UAklI8czEMJbwrWepk7Op0FcV1pU5cbU44kIuvKXXKcy0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Fq+vkzhd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CC5C116C6;
	Mon, 13 Apr 2026 10:46:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776077176;
	bh=/9jf9OvoLi8GIV9s/avZs5Lx1pyFmO74OPDNOQedqjM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Fq+vkzhdbjwqHCrguuX7dy20B4KAToAsGyfh2C3imRsa+zRrN5UlgfFwdNJtcW+uQ
	 /0/EiHV3eOfuvfSIew3CXNEYDQrKp5c+/r7SV+fzd+3UK9GsL/7tLc9oLgDv/Jjouw
	 gt41gUp78WJZiQdw1bKcMXF+Li9FbeUaVEEGzL/M=
Date: Mon, 13 Apr 2026 12:46:13 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc: stable@vger.kernel.org, Peri-Dev <oss-upstream-dev@lm.renesas.com>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	Tong Duc Duy <duy.tong-duc@banvien.com.vn>,
	Thuan Nguyen <thuan.nguyen-hong@banvien.com.vn>,
	Duy Nguyen <duy.nguyen.rh@renesas.com>,
	Chu Quoc Khanh <khanh.chu@banvien.com.vn>,
	Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: Re: [Renesas Linux Kernel Test Report] DU/Device Tree: Missing pin
 control for DSI-eDP IRQ
Message-ID: <2026041351-skyward-constrain-e6e2@gregkh>
References: <PUZPR03MB71159178A9463AF8E5C1B4709F582@PUZPR03MB7115.apcprd03.prod.outlook.com>
 <87wlyfeks1.wl-kuninori.morimoto.gx@renesas.com>
 <20260410085604.GD2712636@killaraus.ideasonboard.com>
 <87lder39bh.wl-kuninori.morimoto.gx@renesas.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87lder39bh.wl-kuninori.morimoto.gx@renesas.com>
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235987-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,renesas];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,linuxfoundation.org:dkim]
X-Rspamd-Queue-Id: 43FED3EAC86
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, Apr 13, 2026 at 02:04:02AM +0000, Kuninori Morimoto wrote:
> 
> Hi Greg
> Cc Geert, Laurent
> 
> Linux LTS v6.6 / v6.12 backported this commit
> 
> 	9133bc3f0564890218cbba6cc7e81ebc0841a6f1
> 	("drm/bridge: ti-sn65dsi86: Add support for DisplayPort mode with HPD")
> 
> Because of that, Renesas needs this commit.
> 
> 	8219a455efd4ba11c1d30c1bbc9ce853466c19bf
> 	("arm64: dts: renesas: white-hawk-cpu-common:
> 	 Add pin control for DSI-eDP IRQ")
> 
> Could you please backport it too ?

It does not apply properly to 6.6.y or 6.1.y, so can you provide working
backports there?

I've added it to 6.12.y now.

thanks,

greg k-h

