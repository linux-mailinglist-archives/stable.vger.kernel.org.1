Return-Path: <stable+bounces-237884-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WKf+M0VH3mn+pwkAu9opvQ
	(envelope-from <stable+bounces-237884-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:55:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3383FAC89
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 15:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 080AB301176F
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 13:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D2763E5EF9;
	Tue, 14 Apr 2026 13:53:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ss8aGQ4h"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 413013E0C66;
	Tue, 14 Apr 2026 13:53:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776174790; cv=none; b=UvhmggCKU7zA9DJ6xycj6vVrsdrclkryS+TqvAq0P4Tja1uti1tk4iqU/rr2jGffeRk3efoGFaZMM8+72QQ4C7S3EPcdIs0IkUkNgJdnWbKc52MaEZaAscIMvpyXmfhSKcnewCJV6yUwFhygBm2Xtrh+OjIGaNjvsvAb7UQTKxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776174790; c=relaxed/simple;
	bh=sRbhIuAcDY6yggi3+LKm5RYWObBMWAgWpoMQP46FDug=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W567tvUo0YoChmTdSdUe6jl7vBVKxAA6KMLWuSGOpEGH89MjgLU8AINyyGC3dPNuLXTL2nG3rjSn1RLa59CY3cE31ahZqWWj1i7upuP5BR9MDLb6FNImq4zye4LxZRgkZub4tLrF0Tgv8ajIiqpYxgHVqcniC9BAwLGf/V74UxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ss8aGQ4h; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8AFC19425;
	Tue, 14 Apr 2026 13:53:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776174789;
	bh=sRbhIuAcDY6yggi3+LKm5RYWObBMWAgWpoMQP46FDug=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ss8aGQ4hrZG4xuON+4I6bQsgSMliKleYLDkVEVoBVa/ArjvGtZOpufYkK5l4bir9C
	 K3NmP9fvOTeynGkHpkYmeYPrkIJpkkjkqPB6VYmiwhZFRyKL1ecpzdcgR2f8QcfvA4
	 z0rwMDZqeAbIptpEH8WkdpgSKwBM2wnW+UKM0ou0=
Date: Tue, 14 Apr 2026 15:52:37 +0200
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: Quentin Schulz <quentin.schulz@cherry.de>
Cc: Jonathan Corbet <corbet@lwn.net>, Sasha Levin <sashal@kernel.org>,
	CVE Assignment Team <cve@kernel.org>, workflows@vger.kernel.org,
	stable@vger.kernel.org, Heiko Stuebner <heiko@sntech.de>
Subject: Re: How to backport (with conflict resolution) CVE-fixing commits to
 stable releases?
Message-ID: <2026041455-correct-quickly-c677@gregkh>
References: <ca758574-b32f-4614-88c7-266acf9044c3@cherry.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ca758574-b32f-4614-88c7-266acf9044c3@cherry.de>
X-Spamd-Result: default: False [3.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	SUBJECT_ENDS_QUESTION(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237884-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,cve.org:url]
X-Rspamd-Queue-Id: 4E3383FAC89
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Apr 14, 2026 at 01:40:33PM +0200, Quentin Schulz wrote:
> Hi all,
> 
> I would like to backport https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/commit/?id=a7ac22d53d0990152b108c3f4fe30df45fcb0181
> to linux-6.12.y. It is not a conflict-less cherry-pick as many commits have
> been made to that file between 6.12 and 6.19 when it was fixed, which makes
> git-cherry-pick conflict. I believe I have a patch that implements the same
> logic (moving code around, just that that code is different since it was
> modified after 6.12) in linux-6.12.y that does the original commit in 6.19.

Then backport all of the needed fixes, that's the simplest way, just
send a series of patches.

> My understanding is that this means this patch fits Option 3: https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html#option-3.
> 
> 1) It is not specified there what to do with git trailer tags, e.g.
> Reviewed-by, Acked-by, Tested-by. I'm assuming https://www.kernel.org/doc/html/latest/process/submitting-patches.html#using-reported-by-tested-by-reviewed-by-suggested-by-and-fixes

You keep them as-is.

See the many backports that are sent to the stable@vger.kernel.org list
for many examples of this.

> 2) I'm also wondering if we should strip the Signed-off-by tags used in the
> original patch's delivery path to Linus. After all, it'll go through a
> different path: to stable "directly". For this specific commit, it doesn't
> matter as the Signed-off-by are for all authors including the maintainer as
> last, but the question remains, I don't believe it's always the case the
> last author Signed-off-by is the same as the maintainers' first and last
> Signed-off-by in the delivery path. What should we do?

Keep the originals please.

> 3) Finally, the last question I have is whether it's required/recommended,
> and if so, how, to tell maintainers of
> https://git.kernel.org/pub/scm/linux/security/vulns.git that this patch is
> for CVE X, in my case https://git.kernel.org/pub/scm/linux/security/vulns.git/tree/cve/published/2026/CVE-2026-22986.dyad.
> Maybe their tooling will automatically pick it up once merged, but I
> couldn't find documentation either in

Maintainers, and stable backports, don't care about CVEs, keep the
wording in the changelog identical and properly mark what the commit id
is that you are backporting.  Again, there are many thousands of
examples on the stable mailing list if you want to look in the archives.

By keeping the original git id, the CVE scripts will properly pick this
up when a commit that has been assigned to a CVE in the past is
backported to older kernels, and then the json records will be
automatically updated when the release happens, and pushed out to
cve.org.  There's nothing special you need to do here at all.

Hope this helps,

greg k-h

