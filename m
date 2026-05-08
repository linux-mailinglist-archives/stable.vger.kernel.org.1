Return-Path: <stable+bounces-244760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNNvFJns/WlJkwAAu9opvQ
	(envelope-from <stable+bounces-244760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:00:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0B64F780F
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:00:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id B799D3019025
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 13:50:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EAEB8397E75;
	Fri,  8 May 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TOD1JuZg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADE881607A4;
	Fri,  8 May 2026 13:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778248225; cv=none; b=rAMUVEQ8FuTpLhwaAu44J/T3ZcO3o/1lgpKwuoabJmU/QjaM/lPy9w+8xGZ7s19mmNOqwspIMqtK95bw6WFa0+2QIhFB+93KlfuhV7rNXD89qgtTIzbCQPlGuvcsENzJmgf+RCV86BiaLGfjWaduOkV2L5JCrnfn7RRZthLYW4g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778248225; c=relaxed/simple;
	bh=7NpXkmouHC7p55aI6K3LkzT0xY0iVoR2mYEEnKe9JeA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MUZjXlE7QHLEAFczFJEXU77EOqVGoCuCEfTvjykydrRXMRFKP3r4OJ5iFZZPVfNQADC2+r4NDEFxCO9YZyzBVAwHe2RHXdqIP8zDbUSTelrE72U0kng/BaCm8wmy2qv39pYDInKNjjToyRrOcEKsy+hTFJDR9ttVG8JwlrqTpX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TOD1JuZg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EF5F2C2BCB0;
	Fri,  8 May 2026 13:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778248225;
	bh=7NpXkmouHC7p55aI6K3LkzT0xY0iVoR2mYEEnKe9JeA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=TOD1JuZgQj8azTur7CrCPUu1JSXYiSQlAcS3CTY6rwfmHtNmdi/KjwqnID2QtcLyf
	 TEXyUIBKeaBz7HFhzPmEG34DAOVz/HTnGzp8BKG+qRw5198xQcZedmITL3uIlqJ4oK
	 gKXTaQBeSgCnZ90gCN653bgVWLeIaSIFbI3APJmY=
Date: Fri, 8 May 2026 15:50:23 +0200
From: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Cc: Dominik Grzegorzek <dominik.grzegorzek@oracle.com>,
	Ben Hutchings <benh@debian.org>,
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>,
	"lwn@lwn.net" <lwn@lwn.net>,
	"stable@vger.kernel.org" <stable@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"jslaby@suse.cz" <jslaby@suse.cz>
Subject: Re: Linux 5.15.205
Message-ID: <2026050855-valley-slashed-c382@gregkh>
References: <2026050835-appealing-stallion-a207@gregkh>
 <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
 <2026050829-gladiator-displease-57af@gregkh>
 <CALUEkOdFEFJ_U1va62B=tWspd2YfLJ-qk72r380wrLRGYfYKPg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CALUEkOdFEFJ_U1va62B=tWspd2YfLJ-qk72r380wrLRGYfYKPg@mail.gmail.com>
X-Rspamd-Queue-Id: 4F0B64F780F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [4.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	FROM_DN_EQ_ADDR(1.00)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,body];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244760-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

On Fri, May 08, 2026 at 03:13:51PM +0200, Massimiliano Pellizzer wrote:
> On Fri, May 8, 2026 at 2:44 PM gregkh@linuxfoundation.org
> <gregkh@linuxfoundation.org> wrote:
> >
> > On Fri, May 08, 2026 at 12:05:02PM +0000, Dominik Grzegorzek wrote:
> > > Hi,
> > >
> > > I may be mistaken, but I think there might be a small typo in this hunk in net/ipv4/ip_output.c:
> > >
> > > skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
> > >
> > > Would this need to be:
> > >
> > > skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
> > >
> > > My understanding is that SKBFL_SHARED_FRAG is a bit in skb_shared_info->flags, and skb_has_shared_frag() checks skb_shinfo(skb)->flags.
> >
> > Adding Ben who did the 5.10 backport so he can comment on this.
> >
> > thanks,
> >
> > greg k-h
> >
> 
> Hi,
> 
> The new released kernel 5.15.205 is still vulnerable to CVE-2026-43284.
> 
> ```
> $ ./run.sh
> === Stage 1 — overwrite 'systemd-timesync' line (89 bytes) with
> 'sick::0:0:<pad>:/:/bin/bash'
> === Stage 2 — verify
> sick::0:0:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX:/:/bin/bash
> === Stage 3 — su - sick (empty password via PAM nullok)
> [i] state saved to /var/tmp/.cf2.state — run './run.sh --clean' to revert
> # uname -r
> 5.15.205
> ```
> 

Does the patch below fix this up?

thanks,

greg k-h

------------------


diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index 68509e1f89b5..5d8f8a5901bc 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -1443,7 +1443,7 @@ ssize_t	ip_append_page(struct sock *sk, struct flowi4 *fl4, struct page *page,
 			goto error;
 		}
 
-		skb_shinfo(skb)->tx_flags |= SKBFL_SHARED_FRAG;
+		skb_shinfo(skb)->flags |= SKBFL_SHARED_FRAG;
 
 		if (skb->ip_summed == CHECKSUM_NONE) {
 			__wsum csum;

