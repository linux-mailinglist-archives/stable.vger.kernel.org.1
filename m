Return-Path: <stable+bounces-248888-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AN37EhhnB2ps1wIAu9opvQ
	(envelope-from <stable+bounces-248888-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:34:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 01F225564A8
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 20:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9DC10300E245
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 18:06:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E83563FDBFF;
	Fri, 15 May 2026 18:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b="CZDlWgXL"
X-Original-To: stable@vger.kernel.org
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AF73F8ED7
	for <stable@vger.kernel.org>; Fri, 15 May 2026 18:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778868401; cv=none; b=SICg0bPq9wcTpOOd4HWldO3dz51Q+Wqh36rB9ZxQgWl+0fIi0JdYHjWndET6Hmg6p3mdC1v0KUPv2n2jAxE55GhAgqid67XSF3ChFTkuXFnhV63bnAIXVNPA4A6Iu8kjSgiJXd/S0b/fmlUuNl8EU5WNvDEr6/fqSz8eugQNOa0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778868401; c=relaxed/simple;
	bh=AXezpO4nEn/GLJQ6Sx9eEO7b4j2SxRLhdWMBUWakUTE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uRUUj5v46s0E+f7gLlyJ9nLjA5QTkUKT7E+nwhdggkhexlNx237kxQisVf+NzP9iTNupAc0yUH+aZgwj2+lvbZtjgl9nXncj7HOCGzvrmPvWK/TtU0lpnjgKcIL2tps+Hi+YgsnS7JA6ZICOHZBD8gEWotomMBfcgMcZyGEMscE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca; spf=pass smtp.mailfrom=ziepe.ca; dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.b=CZDlWgXL; arc=none smtp.client-ip=209.85.222.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ziepe.ca
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ziepe.ca
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-90b2fcf90a0so5663085a.1
        for <stable@vger.kernel.org>; Fri, 15 May 2026 11:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google; t=1778868399; x=1779473199; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rcOSrIvcAcDO9WkkqWoNEexjLGDP5koDwQkJhDioOAo=;
        b=CZDlWgXL8SglPS3XV1i62d6mdrorGbhVhs/tOz3OSqkDB9wu/KsWKyHCnaamre9S4v
         gdB1QZJ/LB8xRvZRZwhKldnI9qzxgqp97c58LSpyPNyqk9AXq8eXFUbU+8HiilTEwv01
         SE31+B2eBx8AUAJ7ePK0MB0nKlN0q+IeIqwBLZMr1O5SkbVDnDd6b6XAnO/bxQLDIJ5K
         wyperO/xrj3E4HM670zlDPgIWHv8UGPXBs6QjUhjK4hFewDELnNOo/QxO3/ErBuZ0n1x
         qTqFLncpBMLCtpddzDCKN7m4K/Db31a/U64XObeZ2FM+BX0eceZ1DdEDApHFvP49iP7u
         1edg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778868399; x=1779473199;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rcOSrIvcAcDO9WkkqWoNEexjLGDP5koDwQkJhDioOAo=;
        b=Te2r+HHk2+fLwIAPFq/eX+yemuXCHs3tJcfYWV7u7lhoHUPUqNFrCKvlxNw/39OA4h
         iijHJZPOVo1ZoHnuEr1JN/E8kyHWNY79d8ECvJSfcOhRpKmZofRi+U3j4VNDG2KzkU7q
         r4uMK1AQOU6NUe59fswTiing6JnXd8tD3zq7T0h7z+3OD+KzzhkJvCdYTZeK4rK7MjRF
         6k6iJNZPu2wLVIvrcFeZrwfCI36cwrjjNk7Ry0Xr9dFCdOFgkbjKOBcPqAGWXHvmmpWK
         16F4k0wVRu/VIqlee6TyGRTLwXH94HMjhhi4AUY9XI30O/b2Lfk09c2hsFUao8oZZXun
         U4Qw==
X-Forwarded-Encrypted: i=1; AFNElJ/BaT0C+PrNtAXZpQcbQejU3HvXMRB16FqzsfPcrsPxHzCj0Qxv/S2qkRKJuMsgjTgU2MjhxHw=@vger.kernel.org
X-Gm-Message-State: AOJu0YyO9sfcyS3m2gsAy89GUexKmn5rgLAXeTGhXopKsyvEidBh0DLY
	8PFtvVgZJF2CDjfXzIsOeNPd86g8kx6oy7UgW0bC6nV8Xpiz8Z6uTbKiZOLyxLBPNE0=
X-Gm-Gg: Acq92OF0z90OcVj5xlwAMtSf9HUcOtIfjyrfEINqtVYnIc85PW6kOTjooAI04rzyOqn
	gAbbp9A+RMi2ZZgmDGzepemDyMUG5t05m3xxAS47wyeovDtGaS/mZChzQLS0bPfDA+RXst2SVZT
	/Zaaz305XgYYLgBEf/BXICYR2qcLwSmIX/FDR9IJaQ3XfP+9F9i84XSnbwzZMYdBfb8MdxKTVVZ
	L5A0GDm4q1f/gZYkwRQ6IflI2dKICAMoVXctbmrfL2YSgGTFt2sRAyAEwMJTI0olx5GVjueHa6W
	/5CaKko1p2pdv3vSoSzqwLO0alhjPdLQ6CYNu/Jd6yxcmT4ax7qQQ+qI1dTR8pI4rL+DZFCa/es
	PoVogiTkpwP1DGmG+zT055EpmQLqHeVuJmfJMsvgendYWxMHf4dDfKHyM4Y/ZsLpB6EqaWofytR
	cg8IAxBT2chHA/6s16XwktRcpmDvpOz3bDVjNNuSXA8dUEvyvXI1zULGxKM+hXFhsMKskRjhW59
	6stuQ==
X-Received: by 2002:a05:620a:a092:b0:8ef:6b87:5c52 with SMTP id af79cd13be357-910b14f8cb0mr1004416585a.38.1778868399150;
        Fri, 15 May 2026 11:06:39 -0700 (PDT)
Received: from ziepe.ca (crbknf0213w-47-54-130-67.pppoe-dynamic.high-speed.nl.bellaliant.net. [47.54.130.67])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-8c90c35cdb1sm58747396d6.46.2026.05.15.11.06.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 11:06:38 -0700 (PDT)
Received: from jgg by wakko with local (Exim 4.97)
	(envelope-from <jgg@ziepe.ca>)
	id 1wNwvm-00000007s92-0MaY;
	Fri, 15 May 2026 15:06:38 -0300
Date: Fri, 15 May 2026 15:06:38 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>,
	Miguel Ojeda <ojeda@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org,
	stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>,
	Kees Cook <kees@kernel.org>, linux-arm-kernel@lists.infradead.org,
	iommu@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [v2] iommu, debugobjects: avoid gcc-16.1 section
 mismatch warnings
Message-ID: <20260515180638.GH7702@ziepe.ca>
References: <20260513145425.1579430-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260513145425.1579430-1-arnd@kernel.org>
X-Rspamd-Queue-Id: 01F225564A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[ziepe.ca:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-248888-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[ziepe.ca:+];
	DMARC_NA(0.00)[ziepe.ca];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[jgg@ziepe.ca,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,ziepe.ca:mid,ziepe.ca:dkim,arndb.de:email]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 04:53:54PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> gcc-16 has gained some more advanced inter-procedual optimization
> techniques that enable it to inline the dummy_tlb_add_page() and
> dummy_tlb_flush() function pointers into a specialized version of
> __arm_v7s_unmap:
> 
> WARNING: modpost: vmlinux: section mismatch in reference: __arm_v7s_unmap+0x2cc (section: .text) -> dummy_tlb_add_page (section: .init.text)
> ERROR: modpost: Section mismatches detected.
> 
> From what I can tell, the transformation is correct, as this is only
> called when __arm_v7s_unmap() is called from arm_v7s_do_selftests(),
> which is also __init. Since __arm_v7s_unmap() however is not __init,
> gcc cannot inline the inner function calls directly.

The selftests should be moved into a kunit like was done for pgtable-arm:

commit 699b059962add22b2a324645b6ae2a607fc1a93e
Author: Mostafa Saleh <smostafa@google.com>
Date:   Mon Nov 3 12:33:50 2025 +0000

    iommu/io-pgtable-arm: Move selftests to a separate file
    
    Clean up the io-pgtable-arm library by moving the selftests out.
    Next the tests will be registered with kunit.
    

Then you won't have these section problems because the code will be in
another module :)

Jason

