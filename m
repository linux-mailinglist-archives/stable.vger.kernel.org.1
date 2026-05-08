Return-Path: <stable+bounces-244775-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qK9iLCz5/WlilQAAu9opvQ
	(envelope-from <stable+bounces-244775-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:54:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 194814F8268
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:54:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 214FC305ECE9
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D5DF3ED11F;
	Fri,  8 May 2026 14:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="duivQ46P"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B3B3E5569;
	Fri,  8 May 2026 14:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778251808; cv=none; b=ID4TSIr6RlGK/kXsH81F6moCuyNGnnmtDDNIQeBUl9cJl+X/nnnEYhB6FKCeJJFlcYA6OOTNB8HgMJdQn5KhQzA1QI52Ihf/aOfcl4UcNoB57xWs5+XZcPDzQAXxrqoVDQP7CugDZsGRDfct9xxkiqjiKD1/kGfb+Cp/5hqNMp8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778251808; c=relaxed/simple;
	bh=CTYsjn9j7HPswqjr72KNgPMd179vLiHUacKchH9ACLA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=tBqarIzbCUD5VKGEIoD70OHR+s1qeg3k1Ics6/hrPR3QaM948x+eZmhpVmtaJja33cx/7OG6ZMw9rNHGt6WVuh2n0u4Wv8j/b+G6cLuaDUiMdhIvaqrFUlCEzpW//EfniMNqK99LETRn4s12foOoDUNzaGweM0kHG1Rte3WwUys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=duivQ46P; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D4FC2BCB0;
	Fri,  8 May 2026 14:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778251807;
	bh=CTYsjn9j7HPswqjr72KNgPMd179vLiHUacKchH9ACLA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=duivQ46PmBZxhC+QyFzzRjaMvnBpl8XeB1PfRZLG9L6dthK1S/Jkv32Xapwb67s02
	 6qYdVQUdtdgOklXX0st0WILaMskh9C4maMrivwkxW7azy8U3oEQ1SRCpGggGIoR9t3
	 Wc17NDNnOQGcSNBNJQYnr5hFTLODWX/HQz73ajVE=
Date: Fri, 8 May 2026 16:50:05 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Ben Hutchings <benh@debian.org>
Cc: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>,
	Dominik Grzegorzek <dominik.grzegorzek@oracle.com>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"lwn@lwn.net" <lwn@lwn.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"jslaby@suse.cz" <jslaby@suse.cz>
Subject: Re: Linux 5.15.205
Message-ID: <2026050840-washcloth-showdown-b66f@gregkh>
References: <2026050835-appealing-stallion-a207@gregkh>
 <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
 <2026050829-gladiator-displease-57af@gregkh>
 <CALUEkOdFEFJ_U1va62B=tWspd2YfLJ-qk72r380wrLRGYfYKPg@mail.gmail.com>
 <2026050855-valley-slashed-c382@gregkh>
 <CALUEkOfBS7qsN-7ERMS+2wcPEixXAGmquREu7uv8ecXn6d7haw@mail.gmail.com>
 <2026050815-length-yummy-f8b6@gregkh>
 <036ef29e143799f9117792463d640916490fa61a.camel@debian.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <036ef29e143799f9117792463d640916490fa61a.camel@debian.org>
X-Rspamd-Queue-Id: 194814F8268
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244775-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,oracle.com,linux-foundation.org,lwn.net,vger.kernel.org,suse.cz];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 04:38:45PM +0200, Ben Hutchings wrote:
> On Fri, 2026-05-08 at 16:30 +0200, gregkh@linuxfoundation.org wrote:
> > On Fri, May 08, 2026 at 04:07:31PM +0200, Massimiliano Pellizzer wrote:
> > > On Fri, May 8, 2026 at 3:50 PM gregkh@linuxfoundation.org
> > > <gregkh@linuxfoundation.org> wrote:
> > > > 
> > > > On Fri, May 08, 2026 at 03:13:51PM +0200, Massimiliano Pellizzer wrote:
> > > > > On Fri, May 8, 2026 at 2:44 PM gregkh@linuxfoundation.org
> > > > > <gregkh@linuxfoundation.org> wrote:
> > > > > > 
> > > > > > On Fri, May 08, 2026 at 12:05:02PM +0000, Dominik Grzegorzek wrote:
> > > > > > > Hi,
> > > > > > > 
> > > > > > > I may be mistaken, but I think there might be a small typo in this hunk in net/ipv4/ip_output.c:
> > > > > > > 
> > > > > > > skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
> > > > > > > 
> > > > > > > Would this need to be:
> > > > > > > 
> > > > > > > skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
> > > > > > > 
> > > > > > > My understanding is that SKBFL_SHARED_FRAG is a bit in skb_shared_info->flags, and skb_has_shared_frag() checks skb_shinfo(skb)->flags.
> > > > > > 
> > > > > > Adding Ben who did the 5.10 backport so he can comment on this.
> > > > > > 
> > > > > > thanks,
> > > > > > 
> > > > > > greg k-h
> > > > > > 
> > > > > 
> > > > > Hi,
> > > > > 
> > > > > The new released kernel 5.15.205 is still vulnerable to CVE-2026-43284.
> > > > > 
> > > > > ```
> > > > > $ ./run.sh
> > > > > === Stage 1 — overwrite 'systemd-timesync' line (89 bytes) with
> > > > > 'sick::0:0:<pad>:/:/bin/bash'
> > > > > === Stage 2 — verify
> > > > > sick::0:0:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX:/:/bin/bash
> > > > > === Stage 3 — su - sick (empty password via PAM nullok)
> > > > > [i] state saved to /var/tmp/.cf2.state — run './run.sh --clean' to revert
> > > > > # uname -r
> > > > > 5.15.205
> > > > > ```
> > > > > 
> > > > 
> > > > Does the patch below fix this up?
> > > > 
> > > > thanks,
> > > > 
> > > > greg k-h
> > > > 
> > > > ------------------
> > > > 
> > > > 
> > > > diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
> > > > index 68509e1f89b5..5d8f8a5901bc 100644
> > > > --- a/net/ipv4/ip_output.c
> > > > +++ b/net/ipv4/ip_output.c
> > > > @@ -1443,7 +1443,7 @@ ssize_t   ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
> > > >                         goto error;
> > > >                 }
> > > > 
> > > > -               skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
> > > > +               skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
> > > > 
> > > >                 if (skb->ip_summed == CHECKSUM_NONE) {
> > > >                         __wsum csum;
> > > 
> > > Yes, this works.
> > 
> > Wait, is this also needed in the 6.1.y backport as well?
> > 
> > Ben, I'm guessing you tested the 6.1.y backport, right?
> 
> Yes, but on 6.1 the PoC never succeeded for me even without the patch. 
> (On 5.10 and 6.12 it does.)  So unfortunately that testing could not
> show whether my attempted fix was correct.
> 
> Sorry for screwing this one up.

Not a problem, thanks for doing the backport at all!  I'll go do a new
6.1.y release now.

Releases for everyone!!!

thanks,

greg k-h

