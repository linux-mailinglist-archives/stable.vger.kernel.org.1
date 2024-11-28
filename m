Return-Path: <stable+bounces-95747-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63F2B9DBB75
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 17:44:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CBB1EB229DE
	for <lists+stable@lfdr.de>; Thu, 28 Nov 2024 16:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5D1B1BDABE;
	Thu, 28 Nov 2024 16:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="bDT4CLgN"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91BD01C173C;
	Thu, 28 Nov 2024 16:43:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732812236; cv=none; b=q8AmEO/sKkdBZ6IVUN5osKzZeTZlco6epzN9GzhR0iwGd2thCYQmdCZ0JQ1UCEPjgFs9tO33Ewepo9UZlKoUQ9VtCKbrTO0qk8chYjgxY6M8OsX2B2Y7GZQuqpE4FNr4IytcB/+FF2uxukOt2Qmi0D1gezoYzfPdpcm7LpTFilQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732812236; c=relaxed/simple;
	bh=WkKkP9VK19grXsdbi+La067oaeO0fCjhwxaKtyL/YiI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Yv91hlpBgUOabCUISwQ9kXZFFJwgGfpvp4dCcRmgP7GqdHNkpGUq/94tF+7rrE4IPs5B4rLiukhS2Ql3qQRXpnvWgqJI61calLxO6uyusvZa1QTI8qcyHDF2+YZHbBr9tjSq7XeABVRvUrRIdmrAPeBytdhe5b7DZcgCxt7PqPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=bDT4CLgN; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id EBAE440E0276;
	Thu, 28 Nov 2024 16:43:51 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id TJXKOvBIsjJ9; Thu, 28 Nov 2024 16:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1732812227; bh=t5VPGfRICgOVWK7ZjQmKkU7K5Wtzyspkwf97k0l8fok=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=bDT4CLgNF1K2X78JtO7EYwUhkiFgAwHWv70TYIiBuW/aY+vRgyGol1Am1FDqx9Q0K
	 OdPKlxsZSfaDry0yz9ngd0oeAN7UDQaCMHoOhsWBK4XjNgG6c9WUb6K7eV3Fv0e7aR
	 C7ajqIrDQpDcbqhcdJ72157TSjjWg0D25Rq5HfJuwSd1N5u378U5T0qigBNh1VU7Bl
	 WDyVa6UpTXe8OdjvZU8wmy7MQihy2xT6L51PX9AlVPElquxQ8//e7Q6OnALyu7/5Ig
	 OcILaX1f1WgRy6a5awJvQZSjOgHXHCYwc0Vkx67E0uB/FMHulb0uKOIgOWS/pzX3Lp
	 syJ8fhBACjhQLjizU7ffcJteEvDlD61cSJn5icAthcakGj/dZvgvBdk3vPQ+ole/t7
	 2/ey9ix45KTwKnMwfRGAGsTV2BW6YwYaFV/igR0bvM5hC4BzvE02j52sNp78GWISsj
	 CZaDn6m6gkanJCZXxyq455JVwxd0+4VlbP5moqll5hndYWI2LqtPyKhOR62tLnRsMk
	 Phpr/bb7Ff9GVGCclOi7zdNNu3Pv2tsdjwuOtSqdEQrU+51JSiv+qdZd6y7diwg1r+
	 VUY+QJHrQw3U3tESKOVKBn1iRxphJYAmtBAX59ZjNfwJhqmH11uRmtSEFVpXIqm9sP
	 L2ZW5nvXlAHXlVLcWVzom8WQ=
Received: from zn.tnic (p200300ea9736a177329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9736:a177:329c:23ff:fea6:a903])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id B0B5D40E0269;
	Thu, 28 Nov 2024 16:43:21 +0000 (UTC)
Date: Thu, 28 Nov 2024 17:43:10 +0100
From: Borislav Petkov <bp@alien8.de>
To: Sasha Levin <sashal@kernel.org>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org,
	tglx@linutronix.de, mingo@redhat.com, dave.hansen@linux.intel.com,
	x86@kernel.org, puwen@hygon.cn, seanjc@google.com,
	kim.phillips@amd.com, jmattson@google.com, babu.moger@amd.com,
	peterz@infradead.org, rick.p.edgecombe@intel.com, brgerst@gmail.com,
	ashok.raj@intel.com, mjguzik@gmail.com, jpoimboe@kernel.org,
	nik.borisov@suse.com, aik@amd.com, vegard.nossum@oracle.com,
	daniel.sneddon@linux.intel.com, acdunlap@google.com,
	Erwan Velu <erwanaliasr1@gmail.com>, pavel@denx.de
Subject: Re: [PATCH AUTOSEL 5.15 11/12] x86/barrier: Do not serialize MSR
 accesses on AMD
Message-ID: <20241128164310.GCZ0idnhjpAV6wFWm6@fat_crate.local>
References: <20240115232718.209642-1-sashal@kernel.org>
 <20240115232718.209642-11-sashal@kernel.org>
 <20241128115924.GAZ0hbHKsbtCixVqAe@fat_crate.local>
 <Z0iRzPpGvpeYzA4H@sashalap>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Z0iRzPpGvpeYzA4H@sashalap>

On Thu, Nov 28, 2024 at 10:52:44AM -0500, Sasha Levin wrote:
> You've missed the 5.10 mail :)

You mean in the flood? ;-P

> Pavel objected to it so I've dropped it: https://lore.kernel.org/all/Zbli7QIGVFT8EtO4@sashalap/

So we're not backporting those anymore? But everything else? :-P

And 5.15 has it already...

Frankly, with the amount of stuff going into stable, I see no problem with
backporting such patches. Especially if the people using stable kernels will
end up backporting it themselves and thus multiply work. I.e., Erwan's case.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

