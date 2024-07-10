Return-Path: <stable+bounces-58981-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9AA2F92CE30
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 11:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4CE621F241CF
	for <lists+stable@lfdr.de>; Wed, 10 Jul 2024 09:29:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F16DE18FA0A;
	Wed, 10 Jul 2024 09:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b="b19vBv3x"
X-Original-To: stable@vger.kernel.org
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4460B84A28;
	Wed, 10 Jul 2024 09:29:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=65.109.113.108
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720603778; cv=none; b=CXfiubb3zTLQ8yzPsT4S0OUPj5qmUW8Fufq5OBGIX1MbqZj5ysxFmVvZaga6pRbwwyS4lKPISzMH2rr945dO4r8n09cK0wOrhX7FFZb3zg27hSY8k745ve2oPzRxNts6RECiGPMX6QLxKwWTopuHH/l8oVBBcHKXylX8/nfwZ3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720603778; c=relaxed/simple;
	bh=qrk8NXyiTW0nBxvzS9xj4sUy4pCeUTbEIIlK+lDgQWw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=khpJTDWrjK9jc+/OQYSuOu0xGAZuCoLEJGE+dNCvCHReFcNr7gwO1QeuT87noBEVshye9vYmCfsa+VzvWAlce9HoAbnIZ07vFhI626g24JUkMq/v7rd/im8f/YTSgdUERmoYSua/B49UyShg2Evqsf7Aedy5zWslNd6tfkxfL4k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de; spf=pass smtp.mailfrom=alien8.de; dkim=pass (4096-bit key) header.d=alien8.de header.i=@alien8.de header.b=b19vBv3x; arc=none smtp.client-ip=65.109.113.108
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=alien8.de
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 24C5D40E019C;
	Wed, 10 Jul 2024 09:29:35 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id tNn6bnHpsR2I; Wed, 10 Jul 2024 09:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1720603771; bh=B5ftZJIE3FPYjKompJae1w7F5CeyPFIf+KZ7NWfDTrc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=b19vBv3xz/d1WcEHMfng1K+26ZNzgkioWOvew28E0Ch91cW4MZJb0iTDS0ceE2Vi9
	 WpsXb15D0PS6Eu+3ZmYdFuipLIXhgMXqBTCoSt8cREmkjZ39K+RQPS0c/K6bNJEkXM
	 0Yg1uwOVDl2fjJ2ElI7dyhBQ2tDPzOZ1vgVoaKnVQfyDvVGosQ1sPcZat1JDaabh/s
	 fL8hU6yvP0C2bHZu7zGNzVFs3fZpewi5CbqW60lfl4bdANg61BUxAnvbVtRIYWjbVR
	 6qq1n5n84/GqFhkZQ0TeiwToaNL7h2DBckIMr56sTAnlf1IWY1EzQ8jINRzz/PrWK0
	 F2VNapYf7OzrdSxK2cmKdMuMyt1Q7M/ePD5IS31OSceXLu1bDVVeHSKLLiUf6Ac5VY
	 X4ExU9hznYW9S2To+GCXA+oRdjBLPg3SPAiICx+PvyZvRG38yZ44JbmcuTydtm9dzP
	 GvI5cE8e3M+Ky4P8cTHurqNIuT5zeDOFjKIsaWyfKBERsogKQb6MVgDpB3cr5IVxIA
	 uEn0qmXDtESVH+eMOM90SS+xzfLsSlejbDiA0CNTji7jna4b7l+WOaHJRM9EYvbfKk
	 TPhIyKPxL5Cz3UpXnO2EpsECTUr4+P8qJGWOEG+fGDzw9pN0m8+WnMEPgCAxZdKyIi
	 wOvXqfRWdGZFrOvtk9h1LEMk=
Received: from zn.tnic (p5de8ee85.dip0.t-ipconnect.de [93.232.238.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id ADBB140E0027;
	Wed, 10 Jul 2024 09:29:17 +0000 (UTC)
Date: Wed, 10 Jul 2024 11:29:12 +0200
From: Borislav Petkov <bp@alien8.de>
To: Dexuan Cui <decui@microsoft.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>,
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"open list:X86 TRUST DOMAIN EXTENSIONS (TDX)" <linux-coco@lists.linux.dev>,
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>,
	Michael Kelley <mikelley@microsoft.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Rick Edgecombe <rick.p.edgecombe@intel.com>,
	Kai Huang <kai.huang@intel.com>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Re: [PATCH] x86/tdx: Support vmalloc() for tdx_enc_status_changed()
Message-ID: <20240710092912.GCZo5UaD-JZeuMpIwK@fat_crate.local>
References: <20240708183946.3991-1-decui@microsoft.com>
 <20240708191703.GJZow7L9DBNZVBXE95@fat_crate.local>
 <SA1PR21MB1317816DFCE6EF38A92CF254BFDA2@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240709110656.GEZo0Z0EoI4xmHDx9b@fat_crate.local>
 <SA1PR21MB13173395ACC3C0FD6D62E36EBFA42@SA1PR21MB1317.namprd21.prod.outlook.com>
 <20240710081501.GAZo5DBW3nvdzp34AI@fat_crate.local>
 <SA1PR21MB1317C5633D8F537A73A1CE17BFA42@SA1PR21MB1317.namprd21.prod.outlook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <SA1PR21MB1317C5633D8F537A73A1CE17BFA42@SA1PR21MB1317.namprd21.prod.outlook.com>

On Wed, Jul 10, 2024 at 09:20:46AM +0000, Dexuan Cui wrote:
> I didn't expect that 'diff' could generate so many lines of changes :-)

It is not about the number of changed lines - it is about *what* gets changed.

A single character change can invalidate the tags of a patch and a huge
diffstat solely cleaning up whitespace will not, even though we prefer if
those get done in a separate patch to ease review.

I'm sure you can think of examples.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

