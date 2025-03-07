Return-Path: <stable+bounces-121419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 45401A56E25
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 17:45:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7FBDE1646C2
	for <lists+stable@lfdr.de>; Fri,  7 Mar 2025 16:45:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0D323E23C;
	Fri,  7 Mar 2025 16:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="I+/FTPV5"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C3117583;
	Fri,  7 Mar 2025 16:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741365899; cv=none; b=nNLxBE/AwBnQV4qfGc1v3bs7g8ORqlmjLSAASr7SwOQiQbUpsP331KH+d+Mfddu7uUm808THY7jHIFLqpzZVK0GhX/DgKYGnY1WTh2aVJfkWYLg971+fMUbuCisULY+OL0M5LcCPmz+jfFx8rjZ7FOKSHQliglUFdKzC3Qj5ql0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741365899; c=relaxed/simple;
	bh=b9OeFhVkZrdF4dO27LuF8Aa97trHlf5Lv6E9F2mrn10=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AR4D8li6CJEFkJWVEYlGM72xJzDmee68CE/nh6jAwPqEH5A3kROShVo1OejQDkmtnE+odJL10HMsQXiDi+VdyL8aaHBspJ0elDYeKpVin6KhVlpJzGvhGieFtc+pvOyIZdvrN5Ba9bgBBgVDegELXo5Q401yNssY84HQE8B+irc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=I+/FTPV5; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 1BBD940E0215;
	Fri,  7 Mar 2025 16:44:48 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id FuxLnAShfuos; Fri,  7 Mar 2025 16:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1741365884; bh=UBrYC+afqnFhobr0UxKVztdEDLIcAI3rVYE7/7BdYlo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=I+/FTPV5ssRkeN+f9HDedOx1OMmZPgHlE1/0f+9c0eQhlPJyLCxgx5f3PQQ43U7t1
	 TQ2Juz3vNLSSm7aaFoSA9nb0SDka1sK7MmU/2XCyuqa6FGDkoEdoWzjby6n6g9Rl8W
	 97u4mG8uDwOmy8IK74P+Bce+wgnDSDeI+wXi3eb+9jGdRvzRj3PMajMUXjKNt2vFr1
	 j8tMbeOOJJYewTvBOSgzuFaSn8GqHq5IHNxirbHDOTGZHu9+rDQtkVTv4O2PU097PK
	 O+PvRENbYH0Fqm3TtQapyqeJm+fyYE0BsES3Ljde/mKiIAhSYrZbC61RKwZ22rAH1U
	 s9k/1LNSlr3tpHhWJftkL0qAH1TjjU6yPtsqvHxAkyKp4qI7hm+UDn7ZCJgmrFImbt
	 7JJsxAvB1OHd1WBCpoA4hCIidv65LOi+8d9d9cfYUPQJ6nCx8dSZLN43jp677KDD5e
	 Qv7jCxugPXHUY4IHxAGf9CDjTi2oej/XA1SibT1mVh++9jod+Nu6J61chehlDb2AqW
	 rg+5xYZ6vTJtqQgaceNmmCznZP3OjQCetfO2Tm4vPcpHJ8n8JcWix3glrjkXfndfGv
	 HyLdXBYZDwx2fAx49X/2pVhP1yV4emthEUMagEgpqyOeG532PyNkf7xVYfQN0YlHNZ
	 Vo4+TioaVlt0yMApB49cWPDM=
Received: from zn.tnic (pd95303ce.dip0.t-ipconnect.de [217.83.3.206])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id CA44940E0214;
	Fri,  7 Mar 2025 16:44:34 +0000 (UTC)
Date: Fri, 7 Mar 2025 17:44:29 +0100
From: Borislav Petkov <bp@alien8.de>
To: Dave Hansen <dave.hansen@intel.com>
Cc: Florent Revest <revest@chromium.org>, linux-kernel@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, hpa@zytor.com, stable@vger.kernel.org
Subject: Re: [PATCH] x86/microcode/AMD: Fix out-of-bounds on systems with
 CPU-less NUMA nodes
Message-ID: <20250307164429.GCZ8sibd8HT8R7gfs9@fat_crate.local>
References: <20250307131243.2703699-1-revest@chromium.org>
 <2cf9798f-1a89-46e1-b1a4-7deec9cb7e40@intel.com>
 <CABRcYmLcXosu62EbTMQNGCEa+mmNtRKCQX8oL=WDrgP-UH6B_g@mail.gmail.com>
 <c43a1936-d8a6-42f4-bcfe-d4de56b38f10@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <c43a1936-d8a6-42f4-bcfe-d4de56b38f10@intel.com>

On Fri, Mar 07, 2025 at 08:32:20AM -0800, Dave Hansen wrote:
> On 3/7/25 07:58, Florent Revest wrote:
> > One thing I'm not entirely sure about is that
> > for_each_node_with_cpus() is implemented on top of
> > for_each_online_node(). This differs from the current code which uses
> > for_each_node(). I can't tell if iterating over offline nodes is a bug

You better not have offlined nodes when applying microcode. The path you're
landing in here has already hotplug disabled, tho.

> > or a feature of load_microcode_amd() so this would be an extra change
> > to the business logic which I can't really explain/justify.
> 
> Actually, the per-node caches seem to have gone away at some point too.
> Boris would know the history. This might need a a cleanup like Boris
> alluded to in 05e91e7211383. This might not even need a nid loop.

Nah, the cache is still there. For now...

for_each_node_with_cpus() should simply work unless I'm missing some other
angle...

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

