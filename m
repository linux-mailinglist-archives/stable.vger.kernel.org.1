Return-Path: <stable+bounces-200941-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CD920CBA1D6
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 01:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 52D1230AEEA1
	for <lists+stable@lfdr.de>; Sat, 13 Dec 2025 00:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8D120B800;
	Sat, 13 Dec 2025 00:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b="ARMTVkV9"
X-Original-To: stable@vger.kernel.org
Received: from violet.fr.zoreil.com (violet.fr.zoreil.com [92.243.8.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34AE73FFD;
	Sat, 13 Dec 2025 00:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=92.243.8.30
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765585393; cv=none; b=p34YaDy2dXjYGN4U1poPtCVYI2YUMNgGFlKeayTxuWfiICViA52B53DAPwlN2F1wGsYZBW9J4pm21OqnlkBNB+lbEiRncuxcQU/66mKHSWOuWPw5EMVH+VzyLZw2eJI44KA22kUBbthQuPoohap7uM4/JEkGCCupoM4WiOYtvks=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765585393; c=relaxed/simple;
	bh=eXYZ8fT2wVsXsmSVyrZXf8+T7Hpj+3tRLLQ9MsogmVE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OhOt0ypY11hp+GafskfPgR3GWylT4FQ4CHMazDgk2HfHdc/jJud7nr9ziZRSrtm9uD0mW8c3KttWnBklrEB4Su0bXfbn73v8lvyGR4GLiKh+bqyvJp/6V5kHLu7h5DO0mDPY8/mepY7BVwXbKC9aWDCRnbuX+05sYDrVlz4QRIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com; spf=pass smtp.mailfrom=fr.zoreil.com; dkim=pass (1024-bit key) header.d=fr.zoreil.com header.i=@fr.zoreil.com header.b=ARMTVkV9; arc=none smtp.client-ip=92.243.8.30
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=fr.zoreil.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fr.zoreil.com
Received: from violet.fr.zoreil.com ([127.0.0.1])
	by violet.fr.zoreil.com (8.17.1/8.17.1) with ESMTP id 5BD0LUHv790219;
	Sat, 13 Dec 2025 01:21:30 +0100
DKIM-Filter: OpenDKIM Filter v2.11.0 violet.fr.zoreil.com 5BD0LUHv790219
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=fr.zoreil.com;
	s=v20220413; t=1765585290;
	bh=h75iuVO7L+TRH0e2OFj132onsNksrZx95PpxfQH85QQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ARMTVkV92BhcsBQtB8G2qv9sfa4xHWV9KZAVVU0MVex0QOUFglfBvo+vx80mgOCFD
	 6PJZRKKzVYyBMpH3Xu4XGwmKKcnQeYO/6GZ32H+zvOJGQUCmm2kciuq1n3Ny8qUJN4
	 DLKd/0Z8iri6Zglh3MOm8yko10+ZDRpIaaJ5wG30=
Received: (from romieu@localhost)
	by violet.fr.zoreil.com (8.17.1/8.17.1/Submit) id 5BD0LTRF790218;
	Sat, 13 Dec 2025 01:21:29 +0100
Date: Sat, 13 Dec 2025 01:21:29 +0100
From: Francois Romieu <romieu@fr.zoreil.com>
To: David Laight <david.laight.linux@gmail.com>
Cc: Simon Horman <horms@kernel.org>, Ilya Krutskih <devsec@tpz.ru>,
        Andrew Lunn <andrew+netdev@lunn.ch>, oe-kbuild-all@lists.linux.dev,
        Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, lvc-project@linuxtesting.org,
        stable@vger.kernel.org
Subject: Re: [PATCH v2] net: fealnx: fix possible 'card_idx' integer overflow
 in
Message-ID: <20251213002129.GA790186@electric-eye.fr.zoreil.com>
References: <20251211173035.852756-1-devsec@tpz.ru>
 <202512121907.n3Bzh2zF-lkp@intel.com>
 <aTwqqxPgMWG9CqJL@horms.kernel.org>
 <20251212173603.46f27e9b@pumpkin>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251212173603.46f27e9b@pumpkin>
X-Organisation: Land of Sunshine Inc.

David Laight <david.laight.linux@gmail.com> :
[...]
> And I just don't understand the assignment: option = dev->mem_start;

One can overload the driver 'option' settings through the kernel 'ether'
option which was typically used in the pre-PCI ISA era for non-modular
kernels.

-- 
Ueimor

