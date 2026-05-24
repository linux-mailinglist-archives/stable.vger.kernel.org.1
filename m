Return-Path: <stable+bounces-254007-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKrWGnvZEmrA4gYAu9opvQ
	(envelope-from <stable+bounces-254007-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:56:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C78675C2216
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:56:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 71A823004F45
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 10:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6A9735C190;
	Sun, 24 May 2026 10:56:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="rYbYo1q6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BBAB274B39;
	Sun, 24 May 2026 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779620213; cv=none; b=LsQpEthLIT8zlpFvjAjaomAwixGKIZbAsEzpBNPFPrZRAiit+eTy53Fhn8kmHE+S6QkmNrBcqyJj4wtxLLXXlANB440CKzjq2vrjWatJkIAYXb82h/oTSzZ7GJV0SREqkRuqwS6XhoCua0+K+bT8kbqa+4wWGHYYr0vFgwf55z0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779620213; c=relaxed/simple;
	bh=Ci9H5AWAHmUR+9Q+XhX9HcahFKPcI9tKp54vB14hXWc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MzICZ7seU1qxY8zvf6BH35NWPA1XZqHRnlVnz/sw9JW11xRccCdpjQlWHe+pFZnu1UxYFMZZrMbXV393K/F6tstge2+YWu7hta/7fROgnVu9EKuLRUsD04gjwpwugYfUksnf8FsUrjmZYgFCFRAwJJOw71hFyathd/M81TvnP/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=rYbYo1q6; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1F71F000E9;
	Sun, 24 May 2026 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779620212;
	bh=Ip3kL+bC9QSUofm9s8A4cBC2Sflg0xYclxuunhFVW94=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=rYbYo1q6ClbCCliaLoLMG0+h8rqFPvEQjzIqUSZtCY8we/SvGhaNLIfQ68sTlNU2j
	 23b2+g/nDFOSVttsz5pG6XtvzFIRNZPKCEdFI1hdiykGAWhzw/SSHU7g5cYow3ZBSy
	 pjLLKhhI/PAP1fWq5KyjflrLtnFkUppOQKz9UBaU=
Date: Sun, 24 May 2026 12:56:54 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: "Artem S. Tashkinov" <aros@gmx.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Sasha Levin <sashal@kernel.org>, stable@vger.kernel.org
Subject: Re: [RFC/PROPOSAL] Shifting the x.y.z Stable Tree to a Continuous,
 Signed Patch-Stream Model
Message-ID: <2026052444-unlawful-eskimo-9c41@gregkh>
References: <cdb0dd2f-f331-46ed-8439-1609173f083a@gmx.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cdb0dd2f-f331-46ed-8439-1609173f083a@gmx.com>
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254007-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[gmx.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.958];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: C78675C2216
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 24, 2026 at 01:38:55PM +0400, Artem S. Tashkinov wrote:
> Hi all,
> 
> The relentless cadence of critical vulnerability disclosures and public
> exploits over the past month—including Copy Fail (CVE-2026-31431), Dirty
> Frag (CVE-2026-43284/500), Fragnesia (CVE-2026-46300), and the ptrace exit
> race (CVE-2026-46333)—has highlighted a severe structural bottleneck in how
> we package and distribute stable backports.

Who is "we"?

And there's nothing really "new" here, these issues are all normal,
remember, we resolve, on average, 13 CVEs a day, most much more severe
than the ones that happened to get marketing names that you list here
(and how many systems have untrusted users?)

> When fatal logic flaws or memory corruptions strike core subsystems, our
> current point-release model fractures. Spinning up whole new point releases
> (7.0.4, 7.0.5, 7.0.7) in a matter of days just to address incomplete fixes,
> subsystem regressions, or independent public disclosures (such as the recent
> GRO managed-frag UAF exploit dropped directly to GitHub gists by
> researchers) creates massive administrative fatigue for maintainers and
> downstream teams alike.

it takes just a minute to "spin up" a point release, what is difficult
about that?  If needed, just let us know and we can easily do so.

> Upstream has long maintained that the stable tree is effectively a
> continuous stream of fixes, and that users should track the tip of the
> stable branch rather than cherry-picking. It is time our release
> infrastructure matches this reality.
> 
> ### The Proposal
> 
> I propose transitioning the stable tree (`linux-x.y.y`) away from
> manual,discrete point-release tarballs (`x.y.z`). Instead, we should treat
> the stable sub-version purely as an append-only, continuous, git-native
> patch stream.

That's what we do today, we just happen go "jump" on a weekly basis.

> Major releases (e.g., 7.0, 7.1) remain the foundational code boundaries, but
> sub-versions are eliminated as monolithic manual artifacts.
> 
> ### The Implementation: How It Works
> 
> To ensure downstream distributions, enterprise compliance engines, and
> automated testing rings can still securely ingest code, we can replace the
> manual tarball with a decoupled, automated asset pipeline:
> 
> 1. **The Git-First Stream:** The stable branch (`linux-7.0.y`) remains the
> single source of truth. Commits are pushed as soon as they pass stable
> criteria and automated sanity testing.

Again, that's what we do today.

> 2. **The Signed Patch-Stream Archive:** Instead of packaging the entire 30M+
> line source code tree into a new tarball for every quick fix, upstream
> infrastructure maintains a rolling, cumulative patch sequence for the major
> cycle:
> 
> linux-7.0-stable.series = \sum (patch_1 + patch_2 + ... + patch_n)
> 
> Every time a fix is merged to the stable branch, the patch is appended to a
> publicly accessible, cryptographically signed manifest file
> (`linux-7.0-stable-patches.tar.bz2` or a standard `series` file) alongside a
> detached signature.

Who would use/need such a thing?  What's wrong with the 2 systems we
have today that this would somehow help out with?

> 3. **Automated Snapshot Tags:** If the industry strictly requires an
> immutable archive for compliance,

What "compliance"?

> point-release numbers can be replaced by
> automated, time-stamped git tags and machine-generated source snapshots cut
> on a strict, automated interval (e.g., every 48 hours), removing human
> maintainers entirely from the release timing.

That's probably not a good idea anyway.  Are you doing continous testing
of the stable queue?  If so, great, just take from there today.
Everyone adds patches on top of releases anyway, what's a few more if it
happens to resolve specific issues for a day or so before a .y release
can be cut?

> ### Why This Benefits the Ecosystem
> 
> * **Eliminates Churn and Latency:**
> 
> When a patch introduces an edge-case regression or requires an immediate
> follow-up (a common reason for rapid point-release sequences), maintainers
> do not need to coordinate a whole new release event.

No real "coordination" happens here.

> The follow-up fix is simply patch $n+1$. Downstream CI pipelines
> ingest it natively via standard git fetches.

Again, we do that today.

> * **Maintains Git-Native Debugging:**
> 
> Debugging stable regressions via `git bisect` has always been patch-based,
> not release-based. Since point releases are meant strictly for backported
> bug fixes, removing the arbitrary `x.y.z` release tags changes nothing about
> a developer's ability to isolate a regression. If anything, it prevents
> downstream vendors from pulling out-of-order patches that complicate
> bisection across distros.

Who bisects across distros?

> * **Eases Downstream Automation:**
> 
> Modern tracking distributions (Arch, Fedora snapshotting, etc.) can switch
> to trunk-based intake, automatically building from the signed tip.

Have you asked them if they need/want this?

> For enterprise distributions (RHEL, Ubuntu LTS) where constant kernel
> packaging and reboots are untenable,

Why are reboots for these systems untenable?  Why not fix that root
problem instead?

> a fluid patch stream allows vendor
> security teams to more rapidly feed live-patching infrastructure (`kpatch`,
> `kgraft`), applying critical CVE fixes directly to runtime memory without
> changing the base package version.

They can do that today, and do do that today.  So again, what distro
needs this?

> * **Bridges the Compliance Gap:**
> 
> Embedded, automotive, or medical compliance pipelines
> that legally require a static, verifiable code artifact can validate their
> software against the base major release tarball ($7.0.0$) plus the
> cryptographically signed, append-only stable patch series manifest.

Do they really need that?  Again, they can have that today, nothing new
here.

> The manual compilation, testing, and cutting of sub-version tarballs is an
> administrative artifact of the late 1990s.

Weekly releases is not an artivact of the 1990s :)

> Shifting to an explicit, signed
> patch-stream architecture acknowledges the velocity of modern vulnerability
> research, strips away artificial latency, and frees our stable maintainers
> to focus on code quality rather than release management overhead.

Again, we have that today, on a weekly basis.

greg k-h

