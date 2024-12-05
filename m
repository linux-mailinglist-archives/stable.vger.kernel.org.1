Return-Path: <stable+bounces-98802-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CDBB79E5629
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 14:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A578188280E
	for <lists+stable@lfdr.de>; Thu,  5 Dec 2024 13:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB1C61D5AD3;
	Thu,  5 Dec 2024 13:02:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from manchmal.in-ulm.de (manchmal.in-ulm.de [217.10.9.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91AE3E56C
	for <stable@vger.kernel.org>; Thu,  5 Dec 2024 13:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.9.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733403763; cv=none; b=u+PwITd84hP79Wb9iDF5VPNCkhgb9LdMmHh8XCjhZIhWONkiCjWAjz8AgBHsW906AlSWZLtGmcxn61YdFPOipV4eftdDHZRRU3bdgoFLaUUMC4KEm3IQ58VxD1ZFlOFmpHd6HUozxIN47G83W4apIEfwU6/88oVry+UhXlI+oeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733403763; c=relaxed/simple;
	bh=WgpvGL5BxCJsjOvjeJemyfuhES6b1p6rzsUs9Z0zQ3g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mmZwURcZQksepd4lsoXWB+5a2IaIPnxjkW+SwLKV2Sx2KXDf3kJx4XuUzshYKbqL/YYL1v/2YS0elt8y6CughLxeO/rZDP0G/RIrsXrEzikyccQPQ9aMhEJrIIDpYvVwUFsfuoJPZpP9pMm3+xmWDJmEzcbEb6uX7LCu3rQpUC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de; spf=pass smtp.mailfrom=manchmal.in-ulm.de; arc=none smtp.client-ip=217.10.9.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=manchmal.in-ulm.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manchmal.in-ulm.de
Date: Thu, 5 Dec 2024 14:02:29 +0100
From: Christoph Biedl <linux-kernel.bfrz@manchmal.in-ulm.de>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Alex Deucher <alexdeucher@gmail.com>, Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	"Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>
Subject: Re: drm/amd/display: Pass pwrseq inst for backlight and ABM
Message-ID: <1733403204@msgid.manchmal.in-ulm.de>
References: <CADnq5_PCqgDS=2Gh3QScfhutgY4wf4hoS15fW5Ox-nziXWGnBg@mail.gmail.com>
 <1733138635@msgid.manchmal.in-ulm.de>
 <2024120231-untimely-undivided-e1d7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2024120231-untimely-undivided-e1d7@gregkh>

Greg KH wrote...

> On Mon, Dec 02, 2024 at 12:33:48PM +0100, Christoph Biedl wrote:

> > tl;dr: Was it possible to have this in 6.1.y?
(...)
> Why not just move to 6.6.y instead?  What's preventing that from
> happening?

Reasons are mostly political, also switching series this is a bigger
change that naturally requires way more careful testing for regressions.
It will happen somewhen in the next year anyway, a cherry-picked fix
could have been shipped now-ish. But it seems this is not an option.

    Christoph


