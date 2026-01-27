Return-Path: <stable+bounces-211902-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2AjyDrA+eWkmwAEAu9opvQ
	(envelope-from <stable+bounces-211902-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 23:39:44 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B7509B24C
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 23:39:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 07E9F3004CA2
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 22:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB9822D94AC;
	Tue, 27 Jan 2026 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FoVO8MSg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5DC2566D3;
	Tue, 27 Jan 2026 22:39:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769553578; cv=none; b=nH7jYOjpJBj0BtsT+GKgUVW5Rp3u55UNn+DMJ1zz7XEApsM/4rNYAplmoctk+KIgvg4Ai2wkvvaw9gWEsq5KnPVEhg1RIc04sakw739Re6ksZK//QkA/q5TZkqClzCYdpniHapCSTIby/ggsiESqwqxQKxaQk6979fscjaxsOdI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769553578; c=relaxed/simple;
	bh=vAKGXi5/xv7/iqoFOU9jUpxzNmiM/3g3ieVqB/OwEa0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=TUppYKrbjOCGWb3eX5FR5fcywZgrg88CGOqEuX70eY5O5+qZFjBYr+fsB99MteS4LvmVvpNWrDsNJWp75gTIJPpKTjQ7D6mEesfA8RdZRE7aYPEVKufBY7IN/as8PCQq3gF7jYzMPtN9kyicwwxhhsQN0hgiRb2unPt/4kWaDxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FoVO8MSg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AB37C116C6;
	Tue, 27 Jan 2026 22:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769553578;
	bh=vAKGXi5/xv7/iqoFOU9jUpxzNmiM/3g3ieVqB/OwEa0=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=FoVO8MSgRtWBjpFwVkIoBs/XdmtkFtcYqTapvPYeUl/4q0Ytd402KQzmGFYFB2soB
	 fh3cXFsEVQ9UCCAUuZZI6u36OwuRn4ncCSg8TJB1JYzafBqPPCK/gUcdSkJKtHMHF4
	 98Kor5SUQB/AcfKWWHNBwcbo8ripvA29K6ldTR1Ib4RQjI7LGSsRQ9DrUSWzUByx3D
	 Z7yejHKtepwmR7o39+Js+QHE/sWy3Ihvt/DhQ4Hxr8zkdge2edMyZIh3w4AOe6dXWb
	 mxcqUgT46OIIdRbGV+5JwK3Y73t972sro7QrM02jYJ3rbupgO2SXUcy7jG7i0mL7e2
	 OJcDa3ywisH8w==
Date: Tue, 27 Jan 2026 16:39:37 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc: linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
	Dominik Brodowski <linux@dominikbrodowski.net>,
	LKML <linux-kernel@vger.kernel.org>,
	Malte =?utf-8?B?U2NocsO2ZGVy?= <malte+lkml@tnxip.de>,
	stable@vger.kernel.org
Subject: Re: [PATCH 02/23] PCI: Rewrite bridge window head alignment function
Message-ID: <20260127223937.GA384008@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6405c825-6d8e-043c-38f1-e7e1a4ebf44a@linux.intel.com>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-211902-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,lkml];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5B7509B24C
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 01:22:22PM +0200, Ilpo Järvinen wrote:
> On Mon, 26 Jan 2026, Bjorn Helgaas wrote:
> > On Fri, Dec 19, 2025 at 07:40:15PM +0200, Ilpo Järvinen wrote:
> > > The calculation of bridge window head alignment is done by
> > > calculate_mem_align() [*]. With the default bridge window alignment, it
> > > is used for both head and tail alignment.
> ...

> > > Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")
> > 
> > check_commits complains that this SHA1 doesn't exist:
> > 
> >   In commit
> > 
> >     a21a27a0e893 ("PCI: Rewrite bridge window head alignment function")
> > 
> >   Fixes tag
> > 
> >     Fixes: 5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")
> > 
> >   has these problem(s):
> > 
> >     - Target SHA1 does not exist
> > 
> > https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=5d0a8965aea9
> > does find it, but says it's not reachable.
> > 
> > It's so old (2002) that I'm not sure it's worth including it as a
> > Fixes: tag.
> 
> Hi,
> 
> The commit is in the history repo, and yes, even the git web ui for some 
> reason says it's not reachable by any branch:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/history/history.git/commit/?id=5d0a8965aea93bd799ebcd671e562d90f3ec2711
> 
> ...But it's part of a tag for sure:
> 
> $ git describe --contains 5d0a8965aea93bd799ebcd671e562d90f3ec2711
> v2.5.15~11^2~5^2~10

Thanks, I made it a Link tag instead:

  Link: https://git.kernel.org/history/history/c/5d0a8965aea9 ("[PATCH] 2.5.14: New PCI allocation code (alpha, arm, parisc) [2/2]")

