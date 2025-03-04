Return-Path: <stable+bounces-120212-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43F28A4D619
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 09:22:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 524D4189302F
	for <lists+stable@lfdr.de>; Tue,  4 Mar 2025 08:22:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B72251F8BB5;
	Tue,  4 Mar 2025 08:22:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="pTtO6DWO";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="RZjuCsUd";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="y3mrGdx/";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="AwW4QRns"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEEDE1F55FA
	for <stable@vger.kernel.org>; Tue,  4 Mar 2025 08:22:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741076536; cv=none; b=i6qBHavVAgeeQkmYAzo3S4TQOC+xcc/06HbwEIhUHVi7SIGASVb0/g7wHud7ZYvlUHwwcrsGxTGFJUJzP5WJQDbUxbCiAaspyu3fRrlb2cY4lyn8cFKDdRPVg1wt/nNew4Ehtv0Q3BFtipA/cEuLL/tZtJPLxJ8C9R9BF/gyu3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741076536; c=relaxed/simple;
	bh=5oBHnXOs9QSSPIAw2gefjQYMDadCJZt5CyLNq3RF8iE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tZKj5AM1N834HE+z6KJghbE3B+iSP5XOmRfr70NKOzBTI425/A6mEY9mlb2tByU3sPX3a6sy8dFJQ3GKTwW07N1DtUAGFRx089fk8oiVjR7zE8c9vMAuFAKEng5HQIm+6ecbBAkQwbQfNxNkGLAHk32c30RJZnNSkOYaReKEpVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=pTtO6DWO; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=RZjuCsUd; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=y3mrGdx/; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=AwW4QRns; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id E7F952116B;
	Tue,  4 Mar 2025 08:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741076533; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1iGbelaTALv5TJMxtK+qrnTKCCp2cmpTL/B5DdK1Vs=;
	b=pTtO6DWOv7HVdk0DopBnr7FBs8lw+CeB94qhhMw2AzEQL9sxfuWr1xxuh2gI7tyg65XGmX
	+c42tFVFn7IWwsRc8SVNt0n6BuwUOlQWF4/M1LWtK/L9xs+DOWi6dq/FVS480S5BGvJMpy
	eHepKA2WZaFZfy9d3+PZat0r0eCGW6o=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741076533;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1iGbelaTALv5TJMxtK+qrnTKCCp2cmpTL/B5DdK1Vs=;
	b=RZjuCsUd4QbjDaC7142C8e/UHlSC76MGn1CSiUWw1dBFOm9j2W6ql1HL0oqVlHlbjAUNfi
	98ackGqGs6RjQ5CA==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b="y3mrGdx/";
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=AwW4QRns
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1741076532; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1iGbelaTALv5TJMxtK+qrnTKCCp2cmpTL/B5DdK1Vs=;
	b=y3mrGdx/kdMYr18Ca1TcbYYDL0goAAGV9UL34f4VsfPiCg1ZrWG8tMfXnCSZc6yw97BgqW
	pJNuoF1opafT1K6XudP9sCdAAbsof70pwSmB1vHWdKF4Y2/KHPSKvup/sVnGsbS5NVOuhP
	p/eBEihk36BtBbOJ4FCIKBNgEnopXOE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1741076532;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=A1iGbelaTALv5TJMxtK+qrnTKCCp2cmpTL/B5DdK1Vs=;
	b=AwW4QRnsWlUItyWFe4fUIeV27z/cVT8byjaRV6l7ZXGtlYgoLGAH4lxFqGYx4BA0GOJokC
	WyMOnHCCirCzu+Aw==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 635121393C;
	Tue,  4 Mar 2025 08:22:11 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id dfxzFTO4xmfRNgAAD6G6ig
	(envelope-from <osalvador@suse.de>); Tue, 04 Mar 2025 08:22:11 +0000
Date: Tue, 4 Mar 2025 09:22:09 +0100
From: Oscar Salvador <osalvador@suse.de>
To: Zhenhua Huang <quic_zhenhuah@quicinc.com>
Cc: anshuman.khandual@arm.com, catalin.marinas@arm.com, david@redhat.com,
	will@kernel.org, ardb@kernel.org, ryan.roberts@arm.com,
	mark.rutland@arm.com, joey.gouly@arm.com,
	dave.hansen@linux.intel.com, akpm@linux-foundation.org,
	chenfeiyang@loongson.cn, chenhuacai@kernel.org, linux-mm@kvack.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	quic_tingweiz@quicinc.com, stable@vger.kernel.org
Subject: Re: [PATCH v9] arm64: mm: Populate vmemmap at the page level if not
 section aligned
Message-ID: <Z8a4MWPpTKm2FAce@localhost.localdomain>
References: <20250304072700.3405036-1-quic_zhenhuah@quicinc.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250304072700.3405036-1-quic_zhenhuah@quicinc.com>
X-Rspamd-Queue-Id: E7F952116B
X-Spam-Score: -4.51
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.51 / 50.00];
	BAYES_HAM(-3.00)[99.99%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[18];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email,suse.de:dkim];
	DKIM_TRACE(0.00)[suse.de:+]
X-Rspamd-Server: rspamd1.dmz-prg2.suse.org
X-Spam-Flag: NO
X-Spam-Level: 

On Tue, Mar 04, 2025 at 03:27:00PM +0800, Zhenhua Huang wrote:
> On the arm64 platform with 4K base page config, SECTION_SIZE_BITS is set
> to 27, making one section 128M. The related page struct which vmemmap
> points to is 2M then.
> Commit c1cc1552616d ("arm64: MMU initialisation") optimizes the
> vmemmap to populate at the PMD section level which was suitable
> initially since hot plug granule is always one section(128M). However,
> commit ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> introduced a 2M(SUBSECTION_SIZE) hot plug granule, which disrupted the
> existing arm64 assumptions.
> 
> The first problem is that if start or end is not aligned to a section
> boundary, such as when a subsection is hot added, populating the entire
> section is wasteful.
> 
> The next problem is if we hotplug something that spans part of 128 MiB
> section (subsections, let's call it memblock1), and then hotplug something
> that spans another part of a 128 MiB section(subsections, let's call it
> memblock2), and subsequently unplug memblock1, vmemmap_free() will clear
> the entire PMD entry which also supports memblock2 even though memblock2
> is still active.
> 
> Assuming hotplug/unplug sizes are guaranteed to be symmetric. Do the
> fix similar to x86-64: populate to pages levels if start/end is not aligned
> with section boundary.
> 
> Cc: <stable@vger.kernel.org> # v5.4+
> Fixes: ba72b4c8cf60 ("mm/sparsemem: support sub-section hotplug")
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Zhenhua Huang <quic_zhenhuah@quicinc.com>

Reviewed-by: Oscar Salvador <osalvador@suse.de>


-- 
Oscar Salvador
SUSE Labs

