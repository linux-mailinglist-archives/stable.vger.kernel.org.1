Return-Path: <stable+bounces-235377-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wALJI6mI12mwPQgAu9opvQ
	(envelope-from <stable+bounces-235377-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:08:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 00F633C9831
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 13:08:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 91EA2301FF94
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 11:07:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9C0F3BE659;
	Thu,  9 Apr 2026 11:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="aMq3y8kY"
X-Original-To: stable@vger.kernel.org
Received: from out-188.mta0.migadu.com (out-188.mta0.migadu.com [91.218.175.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9533BADB4
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 11:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775732847; cv=none; b=olbOxKs+8SZjTfyeHiNI3pUZjDChWm33SA1jAvrl6TYRkva484L64eHQacX2pKhxCa6xvqots+hW9uZ6lyWSphvJOYQ6UJizKzaGRfIoIaY5Ln2qtf9vsljQ7szfDFioAf8flmp3hAGgSnBk80XDUao8YyTLSGm7r83a+JRiFeg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775732847; c=relaxed/simple;
	bh=9JKGx38FSGG6Nz7wxP/TB3E0ebPEyEU8JlSvdZZ7I+o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a34at8Dhj/8pO/zMb5orJm3x6DXK1ehGBKj/OP0BmLX6wwsglQpjtDQiBOUKDQ+HUQr5tKwRPrDqEM8VtWNNRSijNsMcqp9HrfA9g2q3b//PrKUu3O1/lB9hR/QFzXdN5myLC8/rOqYyHg8B+RoP7fN9jJIMWGxgw5sydZYr//Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=aMq3y8kY; arc=none smtp.client-ip=91.218.175.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 9 Apr 2026 13:07:20 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775732844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3MOpz5+g3vfa9VgxYUiXiTPDPttF9omv9Zm7Y7PMt3M=;
	b=aMq3y8kYSk6U9TF0ya6Y/9TkYR10vSjPrmQ8LQXBHvijn1e+4kwhrbKyShdznxhl1jF8AL
	1PmEl4vGdt5H3N4MydL5ojRcIdlIj4i7jeZPY1QseRpWoe33wkgR5u8Dq+xLzotpDVN1EU
	L1adr84WH1v7z77OOjzhsSnHHhUQ+kc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>,
	Andrew Morton <akpm@linux-foundation.org>,
	Changyuan Lyu <changyuanl@google.com>,
	Alexander Graf <graf@amazon.com>, Baoquan He <bhe@redhat.com>,
	stable@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86/boot: Fix NULL dereference for missing
 hugepagesz/hugepages value
Message-ID: <adeIaDdxslGShgq8@linux.dev>
References: <20260302205901.39610-1-thorsten.blum@linux.dev>
 <20260313204243.GIabR2w3PqVcFxg66B@fat_crate.local>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313204243.GIabR2w3PqVcFxg66B@fat_crate.local>
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235377-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[thorsten.blum@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:email,linux.dev:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 00F633C9831
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Mar 13, 2026 at 09:42:43PM +0100, Borislav Petkov wrote:
> On Mon, Mar 02, 2026 at 09:58:59PM +0100, Thorsten Blum wrote:
> > In parse_gb_huge_pages(), 'val' can be NULL if '=' is missing from the
> > boot parameter. The code passes 'val' to memparse() and
> > simple_strtoull(), which can dereference NULL.
> > 
> > Reject 'hugepagesz' and 'hugepages' when no value has been provided and
> > log a warning.
> > 
> > Fixes: 9b912485e0e7 ("x86/boot/KASLR: Add two new functions for 1GB huge pages handling")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
> > ---
> >  arch/x86/boot/compressed/kaslr.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> > 
> > diff --git a/arch/x86/boot/compressed/kaslr.c b/arch/x86/boot/compressed/kaslr.c
> > index 3b0948ad449f..88ccc3b2c5aa 100644
> > --- a/arch/x86/boot/compressed/kaslr.c
> > +++ b/arch/x86/boot/compressed/kaslr.c
> > @@ -205,6 +205,11 @@ static void parse_gb_huge_pages(char *param, char *val)
> >  	char *p;
> >  
> >  	if (!strcmp(param, "hugepagesz")) {
> > +		if (!val) {
> > +			warn("Missing value in hugepagesz= boot parameter\n");
> > +			return;
> > +		}
> > +
> >  		p = val;
> >  		if (memparse(p, &p) != PUD_SIZE) {
> >  			gbpage_sz = false;
> > @@ -218,6 +223,11 @@ static void parse_gb_huge_pages(char *param, char *val)
> >  	}
> >  
> >  	if (!strcmp(param, "hugepages") && gbpage_sz) {
> > +		if (!val) {
> > +			warn("Missing value in hugepages= boot parameter\n");
> > +			return;
> > +		}
> > +
> >  		p = val;
> >  		max_gb_huge_pages = simple_strtoull(p, &p, 0);
> >  		return;
> 
> The intent is good even if it is not working fully yet, see below.

I fixed this with [*], which prevents parse_gb_huge_pages() from being
called with a NULL pointer in the first place. Please drop this patch.

> [...]

Thanks,
Thorsten

[*] https://lore.kernel.org/lkml/20260409105437.108686-4-thorsten.blum@linux.dev/

