Return-Path: <stable+bounces-171777-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F8D1B2C2CC
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 14:12:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DA2F81BA32D0
	for <lists+stable@lfdr.de>; Tue, 19 Aug 2025 12:12:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D53433470A;
	Tue, 19 Aug 2025 12:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="k/Bhrj/X"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B6F720C000
	for <stable@vger.kernel.org>; Tue, 19 Aug 2025 12:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755605534; cv=none; b=cgAxdKUsCQ289sSyLEBajqv/JGSa2BN0tv05gZXNz2CowSqWwdo1cOFQdUoF58uaol5jYm0P+Lk6W+scCUZe6QaO6DJ1AxyveKM0XZu6IHg81K7D/IAFuyuvJoU9SRhjDCQSJS+fbKNiOiiEg0PS4aIkO+Sti8CmUhMEu/B4HYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755605534; c=relaxed/simple;
	bh=rZGFF7MpRa6/F334erwhaHaYXychRw8kTq08vrEY6Ss=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bqR++kqYbEuwffBpdl9tX6MPWs3kRLeH6Bjuze1C8pb7g6nIBvIOGMZCIopM2rSBFlJj+vBoyHsMFP8/cseEjPoTImddTq2+376XNAU3xxqhiK7ofcyWrIqRCV0pS1rSxMWtodolyDLDjU9juKFSg7pwlHSN4gN3+Jt5PLikuV4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=k/Bhrj/X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E43BC4CEF1;
	Tue, 19 Aug 2025 12:12:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755605533;
	bh=rZGFF7MpRa6/F334erwhaHaYXychRw8kTq08vrEY6Ss=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=k/Bhrj/XQTYBp3zrdwBnI4r7XrfJb9JMMtqQYGmRA3hiklz2WMGFhKGfxVXI95QXu
	 Th+zX3+TG+m8mRTpoB3oz1MT3r+AqlMx6OGFji+mwnKgWb4Qk6dfzmUYS54UAzH+3K
	 wUCBk/gEO0iHlzRUYLzcGaJ08DBy1nzd38g2SNMg=
Date: Tue, 19 Aug 2025 14:12:10 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Yann Sionneau <yann.sionneau@vates.tech>
Cc: stable@vger.kernel.org, Li Zhong <floridsleeves@gmail.com>,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
	Teddy Astie <teddy.astie@vates.tech>, Dillon C <dchan@dchan.tech>
Subject: Re: [PATCH] ACPI: processor: idle: Check acpi_bus_get_device return
 value
Message-ID: <2025081900-compost-bounce-f915@gregkh>
References: <20250819115301.83377-1-yann.sionneau@vates.tech>
 <032a8ac9-0554-49b6-a8e4-fdeb467f8327@vates.tech>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <032a8ac9-0554-49b6-a8e4-fdeb467f8327@vates.tech>

On Tue, Aug 19, 2025 at 12:03:05PM +0000, Yann Sionneau wrote:
> On 8/19/25 14:00, Yann Sionneau wrote:
> > From: Teddy Astie <teddy.astie@vates.tech>
> > 
> > Fix a potential NULL pointer dereferences if acpi_bus_get_device happens to fail.
> > This is backported from commit 2437513a814b3 ("ACPI: processor: idle: Check acpi_fetch_acpi_dev() return value")
> > This has been tested successfully by the reporter,
> > see https://xcp-ng.org/forum/topic/10972/xcp-ng-8.3-lts-install-on-minisforum-ms-a2-7945hx
> > 
> > Signed-off-by: Li Zhong <floridsleeves@gmail.com>
> > Signed-off-by: Teddy Astie <teddy.astie@vates.tech>
> > Signed-off-by: Yann Sionneau <yann.sionneau@vates.tech>
> > Reported-by: Dillon C <dchan@dchan.tech>
> > Tested-by: Dillon C <dchan@dchan.tech>
> > ---
> 
> Hello Greg, all,
> 
> This should be picked for v5.4, v5.10 and v5.15 branches as it's already 
> been backported in v6.0 and v6.1.
> 
> I already reached out about this a few weeks ago, I just waited for the 
> patch the be tested before sending it.

What is the upstream git commit id?

