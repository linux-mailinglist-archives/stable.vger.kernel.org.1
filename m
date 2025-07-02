Return-Path: <stable+bounces-159207-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 675C5AF0E74
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 10:50:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2429D4A00D3
	for <lists+stable@lfdr.de>; Wed,  2 Jul 2025 08:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD1123C51E;
	Wed,  2 Jul 2025 08:50:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i2uuhOkB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cFjhV2Fn";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="i2uuhOkB";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="cFjhV2Fn"
X-Original-To: stable@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E2A623C4E5
	for <stable@vger.kernel.org>; Wed,  2 Jul 2025 08:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751446234; cv=none; b=ilvUy2LgwA7u0BcMRGMCNiRf0H6TB7RAwKM1YBdFDw2OqtMeWH78Z5dZGRTuI6ojPGyEsR8koCTwa6sPpIOAPHRFjVXiJeFM2hr9Hzk4r9+lCrQuRUmbK+1JBKb4+p89BiBOWgTpmLu48BN9fFIyTXvWVAc5WLTtk+34tQ8HGIk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751446234; c=relaxed/simple;
	bh=zzDkSI9R25eVLahJ2BbWU8Vqi8n7G8j8PUZU2tqjb3Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=C19Iom7IubIzvyAFXEEUvuT0dAoPyrAHVXred/RpTOM+HMKzwiD++t3S13jIxKOzWR2T7xoVjjeIIh17lbrMK3RlY1DrpbKNorLEcJt21HHMo4c5eQezMKnBrJRULRJzxrXPPYF+IekzzvbjuqEXiEgCzGmwKZYc6Bh40fU/s6k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i2uuhOkB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cFjhV2Fn; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=i2uuhOkB; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=cFjhV2Fn; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id ADC70210F2;
	Wed,  2 Jul 2025 08:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751446230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdXar4DNswhxGVw1NPqLE991gP8Ek/4mxCvFBmnXOFU=;
	b=i2uuhOkB23fvR4vQHS1IlytYsD5c3mu25psQx36URpgVr9eLaMCLpMkqmXNzOVyRhQihUZ
	yMqTOrch/JnCp6T77W8knQQiUwlFrF3lovzNqTo+ESR5ifd2j0FK+gK1SzLW5khf1OALGk
	YVe4cth19GU2wxrQcEbjZOyRYpsy1Y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751446230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdXar4DNswhxGVw1NPqLE991gP8Ek/4mxCvFBmnXOFU=;
	b=cFjhV2FnJ+e7e3iwz72tWC8muxH+/oBMovp6jSgTX7HFwkvGWVEC4WO0byaGlikDwVXt6R
	2wq+oSEOMtL7bODA==
Authentication-Results: smtp-out1.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1751446230; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdXar4DNswhxGVw1NPqLE991gP8Ek/4mxCvFBmnXOFU=;
	b=i2uuhOkB23fvR4vQHS1IlytYsD5c3mu25psQx36URpgVr9eLaMCLpMkqmXNzOVyRhQihUZ
	yMqTOrch/JnCp6T77W8knQQiUwlFrF3lovzNqTo+ESR5ifd2j0FK+gK1SzLW5khf1OALGk
	YVe4cth19GU2wxrQcEbjZOyRYpsy1Y0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1751446230;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cdXar4DNswhxGVw1NPqLE991gP8Ek/4mxCvFBmnXOFU=;
	b=cFjhV2FnJ+e7e3iwz72tWC8muxH+/oBMovp6jSgTX7HFwkvGWVEC4WO0byaGlikDwVXt6R
	2wq+oSEOMtL7bODA==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 215911369C;
	Wed,  2 Jul 2025 08:50:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id bgBcBdbyZGi2VAAAD6G6ig
	(envelope-from <osalvador@suse.de>); Wed, 02 Jul 2025 08:50:30 +0000
Date: Wed, 2 Jul 2025 10:50:24 +0200
From: Oscar Salvador <osalvador@suse.de>
To: Jann Horn <jannh@google.com>
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
	Andy Lutomirski <luto@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>,
	Muchun Song <muchun.song@linux.dev>,
	Vitaly Chikunov <vt@altlinux.org>, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, Dave Hansen <dave.hansen@intel.com>,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] x86/mm: Disable hugetlb page table sharing on 32-bit
Message-ID: <aGTy0GPyc5o_uDgq@localhost.localdomain>
References: <20250702-x86-2level-hugetlb-v2-1-1a98096edf92@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250702-x86-2level-hugetlb-v2-1-1a98096edf92@google.com>
X-Spamd-Result: default: False [-4.30 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	ARC_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_TLS_ALL(0.00)[];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	FUZZY_BLOCKED(0.00)[rspamd.com];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	RCVD_COUNT_TWO(0.00)[2];
	DBL_BLOCKED_OPENRESOLVER(0.00)[localhost.localdomain:mid,suse.de:email,intel.com:email,imap1.dmz-prg2.suse.org:helo]
X-Spam-Level: 
X-Spam-Flag: NO
X-Spam-Score: -4.30

On Wed, Jul 02, 2025 at 10:32:04AM +0200, Jann Horn wrote:
> Only select ARCH_WANT_HUGE_PMD_SHARE on 64-bit x86.
> Page table sharing requires at least three levels because it involves
> shared references to PMD tables; 32-bit x86 has either two-level paging
> (without PAE) or three-level paging (with PAE), but even with
> three-level paging, having a dedicated PGD entry for hugetlb is only
> barely possible (because the PGD only has four entries), and it seems
> unlikely anyone's actually using PMD sharing on 32-bit.
> 
> Having ARCH_WANT_HUGE_PMD_SHARE enabled on non-PAE 32-bit X86 (which
> has 2-level paging) became particularly problematic after commit
> 59d9094df3d7 ("mm: hugetlb: independent PMD page table shared count"),
> since that changes `struct ptdesc` such that the `pt_mm` (for PGDs) and
> the `pt_share_count` (for PMDs) share the same union storage - and with
> 2-level paging, PMDs are PGDs.
> 
> (For comparison, arm64 also gates ARCH_WANT_HUGE_PMD_SHARE on the
> configuration of page tables such that it is never enabled with 2-level
> paging.)
> 
> Reported-by: Vitaly Chikunov <vt@altlinux.org>
> Closes: https://lore.kernel.org/r/srhpjxlqfna67blvma5frmy3aa@altlinux.org
> Suggested-by: Dave Hansen <dave.hansen@intel.com>
> Tested-by: Vitaly Chikunov <vt@altlinux.org>
> Fixes: cfe28c5d63d8 ("x86: mm: Remove x86 version of huge_pmd_share.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Jann Horn <jannh@google.com>

Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks!

-- 
Oscar Salvador
SUSE Labs

