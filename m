Return-Path: <stable+bounces-76127-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DC04978EC8
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 09:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3BF1C1F25B81
	for <lists+stable@lfdr.de>; Sat, 14 Sep 2024 07:10:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B956F19E81D;
	Sat, 14 Sep 2024 07:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T+JTaSxZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43AE63D62;
	Sat, 14 Sep 2024 07:09:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726297795; cv=none; b=Rfa0ku2Z37El80E5ON+EOosOZ55SVBqYVUfCQFWd0lubmwajo8gSFeO7nn7gayfMaZW0yZeUHMFn4t36Ad4SJFenRpA54lJEygqYzUeg1MfDthd+ldn9XX0XiL/ml27kDRg8Ln7nNaEd7BXS7ASARplNRSV4kaB+oYx4cbywTRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726297795; c=relaxed/simple;
	bh=jFC0cHMwcLTSAMH6eRj34U0dZYRZF81EyCtQTqYQKVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Bym9zTMFzH8ETCxmyfez07DpS001H5xsXgJxh+h37QSWbUoQvHv6xbCGXMn4+u1gELbJy+a3jT1SfRzkuInSJuDkl4pFHYgy3td0GBPOMJRyUMu62a1EAzDL3Ppxbx+0T0pZhrIoloyttvo120VVZVHAXGCKxD378TiH1WewC7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T+JTaSxZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 360CEC4CEC0;
	Sat, 14 Sep 2024 07:09:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1726297794;
	bh=jFC0cHMwcLTSAMH6eRj34U0dZYRZF81EyCtQTqYQKVM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=T+JTaSxZfebUJ6wOe14pqhtfnt1iiiAkeSKihdwn+M11cYhjFDisL3+M2tEgiSkU+
	 SeY4wCVsAZT3HX6ZXh4ntdr7CCt/GMg1G2O7BMaM4gb0H6i8mNtdi3XNAQhYyqqjeu
	 BUqF71EA4xyyKujg9enkhQ4GAJmFULNiAaV4jQxo=
Date: Sat, 14 Sep 2024 09:09:51 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: "stable@vger.kernel.org" <stable@vger.kernel.org>,
	Linux kernel regressions list <regressions@lists.linux.dev>,
	Sasha Levin <sashal@kernel.org>,
	LKML <linux-kernel@vger.kernel.org>
Subject: Re: Bug 219269 - v6.10.10 kernel fails to build when CONFIG_MODULES
 is disabled
Message-ID: <2024091428-unison-relocate-4c2b@gregkh>
References: <bd49aa81-338f-4776-8c45-7c79945c0a81@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <bd49aa81-338f-4776-8c45-7c79945c0a81@leemhuis.info>

On Sat, Sep 14, 2024 at 07:02:26AM +0200, Thorsten Leemhuis wrote:
> Hi Greg! I noticed a bug report in bz:
> https://bugzilla.kernel.org/show_bug.cgi?id=219269
> 
> > Fair enough, you get a compiler warning:
> > 
> > kernel/trace/trace_kprobe.c: In function ‘validate_probe_symbol’:
> > kernel/trace/trace_kprobe.c:810:23: error: implicit declaration of function ‘find_module’; did you mean init_module’? [-Wimplicit-function-declaration]
> >   810 |                 mod = find_module(modname);
> >       |                       ^~~~~~~~~~~
> >       |                       init_module
> > kernel/trace/trace_kprobe.c:810:21: error: assignment to ‘struct module *’ from ‘int’ makes pointer from integer without a cast [-Wint-conversion]
> >   810 |                 mod = find_module(modname);
> >       |    
> > 
> > but there is no find_module symbol when CONFIG_MODULES is disabled.
> 
> I *very briefly* looked into this. I might be wrong, but looked a bit
> like "tracing/kprobes: Add symbol counting check when module loads"
> caused this and backporting b10545b6b86b7a ("tracing/kprobes: Fix build
> error when find_module() is not available") [v6.11-rc1] would fix this
> (which applies cleanly).
> 
> Shall I ask the reporter to confirm or is that already enough for you?

This is enough, now queued up, thanks.

greg k-h

