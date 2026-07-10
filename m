Return-Path: <stable+bounces-273288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id JsdSHZolUWoAAAMAu9opvQ
	(envelope-from <stable+bounces-273288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 19:02:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id C04B273CDBF
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 19:02:17 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=B2ul+ago;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273288-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273288-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DCA4F301FF91
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 16:58:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61D6F2BDC05;
	Fri, 10 Jul 2026 16:58:15 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3452D274FD1;
	Fri, 10 Jul 2026 16:58:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702695; cv=none; b=CnHpIztZ58Q4+n+y4FxCDYVkPzXY0Ju7wpvJnYGZjUYf4vahQprxNEfdo9YMKgwL1uYr7PjECw9nEk5G8ke0reMGeH7WqAxtzfwTphAVWssQvkAM6YE7OlF/ry2v59CFzAasPSNB9so/KDrTZxnCPhFyNaCJ3dJK4XDV2I45fXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702695; c=relaxed/simple;
	bh=fC12MveZRpBCrndepPmQnNSNipsjXEfj0RsLjRllTXo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JfCBPDy6WTIreqSq2kxlgbJvrikOwKhXPp0+n1vBdVq05ULy5GLihqRalo8kuCSB8A6KjaFo0BgdteoGRtCjTe4xnw/kUSZLSEeyi0yCCCqVjrP75VfSwwc+ybN1My/J47KUSd24TyhDo232AXQYCtoYCLRRV0KzATQMLjyXr8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B2ul+ago; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEE5E1F000E9;
	Fri, 10 Jul 2026 16:58:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783702694;
	bh=NIl7I7T4x7rHAN+aBlxi7ud/jgmJeseYicOc7Rt0810=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=B2ul+agoG+ka7LaVnYvEHPSk5fqo/8j/wU27lKTM2vL7LUabq5zLjVtO6EzMlHGJS
	 LrFi3z8TJupAK8Yzr7rQGHDv5UpGO8ijEkVq8ubjyDRKLgnZoEVh4Pm05bqdYQMxGE
	 2tmMcvvw2D4W6Le+w61PvCtWu7+v8jDM6psZ9sI0y8/Pf+4ynlAJIUCoPRvv0qXl82
	 0lOAWJxF38KqE8Va6Eg83j0YoRj0zyZfFRaYzwQPSr4lqFXfOaR1ZxY0UccgrPwat1
	 bOyRFMiUZoZ8SRTc0Hzk8ZQfp922i8rD3FTOQ5EfiW2TrvEkr1HTQxL7U19At03brz
	 0fqmDhHBK3d1w==
Date: Fri, 10 Jul 2026 17:58:01 +0100
From: Lorenzo Stoakes <ljs@kernel.org>
To: "David Hildenbrand (Arm)" <david@kernel.org>
Cc: Sean Christopherson <seanjc@google.com>, 
	Pankaj Gupta <pankaj.gupta@amd.com>, pbonzini@redhat.com, tglx@kernel.org, mingo@redhat.com, 
	dave.hansen@linux.intel.com, bp@alien8.de, x86@kernel.org, thomas.lendacky@amd.com, 
	hpa@zytor.com, yangge1116@126.com, kvm@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] KVM: SEV: drop FOLL_LONGTERM for encrypted region
 registration
Message-ID: <alEgyNCMizer6uzB@lucifer>
References: <ak-uER-RndpksnhR@lucifer>
 <58c4326d-b10d-42dc-af5d-3a5ff16c7e3e@amd.com>
 <ak_A6Yc5mBXCrtXr@lucifer>
 <adf66571-4ef4-4f8a-824f-fdd5ab5099ab@kernel.org>
 <alDtzM28CgZJn6FF@lucifer>
 <62ccb0f7-a619-41b8-944e-11ae2d0ce70c@kernel.org>
 <alEUBzV1cevuPYeD@google.com>
 <alEZIuJhv5ZXGQac@lucifer>
 <alEc0I0VysX1p5Nk@google.com>
 <ad784f05-b36c-4e91-9f17-4c5b826735d0@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad784f05-b36c-4e91-9f17-4c5b826735d0@kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:david@kernel.org,m:seanjc@google.com,m:pankaj.gupta@amd.com,m:pbonzini@redhat.com,m:tglx@kernel.org,m:mingo@redhat.com,m:dave.hansen@linux.intel.com,m:bp@alien8.de,m:x86@kernel.org,m:thomas.lendacky@amd.com,m:hpa@zytor.com,m:yangge1116@126.com,m:kvm@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FORGED_SENDER(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-273288-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ljs@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[google.com,amd.com,redhat.com,kernel.org,linux.intel.com,alien8.de,zytor.com,126.com,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp,lucifer:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: C04B273CDBF

On Fri, Jul 10, 2026 at 06:38:23PM +0200, David Hildenbrand (Arm) wrote:
> >>
> >> How long ago did I break this though? Why has it taken until now for this to be
> >> reported? :) commit 8ac268436e6d ("mm/gup: disallow FOLL_LONGTERM GUP-nonfast
> >> writing to file-backed mappings") is from May 2023 :)
> >
> > The break didn't come from your changes, it came from commit 7e066cb9b71a ("KVM:
> > SEV: Use long-term pin when registering encrypted memory regions").  I suggested
> > falling back to a non-longterm pin, but David didn't like that idea :-)
>
> Yes, a longterm pin is a longterm pin.

Yes it'd be very unwise to not use a longterm pin here!

>
> If we don't write to the memory, why do we need a write pin? To make sure that
> what we pin was actually unshared?
>
> Well, FOLL_LONGTERM does that nowadays.
>
>
> ... so is maybe dropping the FOLL_WRITE sufficient?

That solves the whole thing, as the check is gated on FOLL_WRITE anyway.

I hadn't dug into the code enough there, been scanning.

So that's a simple fix then? :)

>
> --
> Cheers,
>
> David

Cheers, Lorenzo

