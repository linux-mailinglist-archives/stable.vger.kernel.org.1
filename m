Return-Path: <stable+bounces-192161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 627BDC2AB76
	for <lists+stable@lfdr.de>; Mon, 03 Nov 2025 10:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC22818907E8
	for <lists+stable@lfdr.de>; Mon,  3 Nov 2025 09:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79B8F2E92B2;
	Mon,  3 Nov 2025 09:24:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Yd4Mt1Ss"
X-Original-To: stable@vger.kernel.org
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEB9F38D;
	Mon,  3 Nov 2025 09:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=90.155.92.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762161886; cv=none; b=NA+8alGdaClm2xwfMM6L8WMzC/fhR/Cu0IZoR7BlovtCix1YTOkbrI83bibpcMpdg2s3A6T7RScc/McEDaDtYutT/1et0DjEIr4ELPilNv9C7rnJTIh/IwiutrPFOpShJlMAfHUtBeCyYmGywV9XCSJYdABfhTxC/8n1bSVWIWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762161886; c=relaxed/simple;
	bh=NLpkZ8bTE+74icQ8CMI6R8oaKaTgGy0pQO09I45Qet0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Y3noqRwa5bFecG1UY5sGK3oMu3l9NQOTSATJTFZ36z76witVD8UUU+hbLQubLYr9h2XGbymkSiTmaCmxdwJMpSDMgG8RI1jF7U1kW1E0A19sCxuXHIycNTK8KT9/zptVKFOF6ZmC7klHB5op01f9Cm18LDmJudwaU69LaRuoosA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org; spf=none smtp.mailfrom=infradead.org; dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b=Yd4Mt1Ss; arc=none smtp.client-ip=90.155.92.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=XWeojflGB1MzD7+Mi+vtNtY6DeSFIY2a0vDpY04LqDY=; b=Yd4Mt1SsVZogo8v1mbnWiT6UZ0
	RiGoalpgZi4sy85d+V298cwmHTqZeZP1PjG4aD0RfTi/d98+4zz/FKUAvXEjXAsOZyC7k7Lk7xuYm
	2DbFXW8aoOc9WLPezimhsWxi3XiRSaxKDrHPNI7qn77NKVz0eJTWFf8GtYF5RbXa+PMLubgAt2iSW
	ukrpBD0AGqOIGRCR5eqSlNKbRpa1oBwdjtG78XjRZre4sHUs3cbOrcnVjRiu7z6DTEgjCU80p8Luy
	fXWioqnnOagusK6eBKTwBJHoDk9toSm+Cufg22DVaIHg7UTKz6qS9mp/NsBFNM0JYCm8AY3dWgFMI
	aQhrdATQ==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFpw7-0000000EyiL-3ITR;
	Mon, 03 Nov 2025 08:29:12 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 24A0330023C; Mon, 03 Nov 2025 10:24:41 +0100 (CET)
Date: Mon, 3 Nov 2025 10:24:41 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Harvey Tite <HarvT@pm.me>
Cc: dapeng1.mi@linux.intel.com, linux-kernel@vger.kernel.org,
	linux-perf-users@vger.kernel.org, octavia.togami@gmail.com,
	regressions@lists.linux.dev, stable@vger.kernel.org
Subject: Re: [REGRESSION] bisected: perf: hang when using async-profiler
 caused by perf: Fix the POLL_HUP delivery breakage
Message-ID: <20251103092441.GX3245006@noisy.programming.kicks-ass.net>
References: <9f94b9b5-0a8a-4f37-8355-0b5461d6ad30@pm.me>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f94b9b5-0a8a-4f37-8355-0b5461d6ad30@pm.me>

On Mon, Nov 03, 2025 at 01:24:44AM +0000, Harvey Tite wrote:
> 
> Hello hope everyone is well, just following up on this bug report, this 
> appears to have been patched here 
> https://lore.kernel.org/lkml/20251015051828.12809-1-dapeng1.mi@linux.intel.com/ 
> thanks to Dapeng Mi; however, the patch email does not appear to have 
> CCed the regressions or stable list.

Bah, it looks like I failed to actually apply the patch :/

Let me go do so now. It has a Fixes tag, that generally makes it so that
stable picks it up.

