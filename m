Return-Path: <stable+bounces-236114-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qNEKF7z83Gk3YwkAu9opvQ
	(envelope-from <stable+bounces-236114-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:25:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 563393ED4D3
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:24:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5C7A330091E9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 14:24:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9CB13CEB8D;
	Mon, 13 Apr 2026 14:24:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from vmicros1.altlinux.org (vmicros1.altlinux.org [194.107.17.57])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C112637D11D;
	Mon, 13 Apr 2026 14:24:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=194.107.17.57
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776090294; cv=none; b=EZCjF583M84nzfMymL4s+9/gBDmeoxHDAHnKsrTu2aElIZ95ZR7lMLk0w8ozS2hYgXvNjyVKmMK5U/F1mtg3D3ET39ShPcxDrlBKlqKMbSUOZqaYHp+qLynr5tW8Cd8JzaLIqxM6GAtI+Opd54nCXRvtakEZd3gl8dh3nZJFzIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776090294; c=relaxed/simple;
	bh=2uK4wQtHsedmlpEk6CEszlGuENIpDrO17Sn0LEEXCVM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=N9mw75vku4ZyHXSR2zbsD8bbRD9nhtmAlfISrvPPPeyh976Ibd+Nkar8vvLgcS08p9fuXsHcu603UjSKH9HSJh5QVVMYSionsEm2TookbZ6w8VJFlUeiaaZOTSjXoExJmhgqVdDNMebWll6UvQmJZIfJoZW0hfGmlZkWnuJ3GXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=194.107.17.57
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from imap.altlinux.org (imap.altlinux.org [194.107.17.38])
	by vmicros1.altlinux.org (Postfix) with ESMTP id 2ACB172C8CC;
	Mon, 13 Apr 2026 17:17:30 +0300 (MSK)
Received: from altlinux.org (unknown [193.43.10.9])
	by imap.altlinux.org (Postfix) with ESMTPSA id 14E8336D00D0;
	Mon, 13 Apr 2026 17:17:30 +0300 (MSK)
Date: Mon, 13 Apr 2026 17:17:29 +0300
From: Vitaly Chikunov <vt@altlinux.org>
To: Thorsten Leemhuis <regressions@leemhuis.info>
Cc: linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	gregkh@linuxfoundation.org, regressions@lists.linux.dev, 
	Matt Roper <matthew.d.roper@intel.com>, Sasha Levin <sashal@kernel.org>, 
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Subject: Re: [regression] Re: Linux 6.12.75
Message-ID: <adz2d7M3DKb-6jm9@altlinux.org>
References: <20260304131402.83200-1-sashal@kernel.org>
 <20260304131402.83200-2-sashal@kernel.org>
 <ac4lw9tTNn4baO_h@altlinux.org>
 <c54a0b91-cfbf-463e-964d-bf9a2e524189@leemhuis.info>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <c54a0b91-cfbf-463e-964d-bf9a2e524189@leemhuis.info>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DMARC_NA(0.00)[altlinux.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-236114-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vt@altlinux.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCPT_COUNT_SEVEN(0.00)[8];
	R_DKIM_NA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,gitlab.freedesktop.org:url]
X-Rspamd-Queue-Id: 563393ED4D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Thorsten, Sasha,

On Mon, Apr 13, 2026 at 01:33:18PM +0200, Thorsten Leemhuis wrote:
> On 4/2/26 10:44, Vitaly Chikunov wrote:
> > Sasha,
> > 
> > 1. I cannot find this commit posted on lore.kernel.org to report to
> > exact patch.
> > 
> > | From: Matt Roper <matthew.d.roper@intel.com>
> > | Date: Tue, 10 Sep 2024 16:47:29 -0700
> > | Subject: [PATCH 6.12/sisyphus] drm/xe: Switch MMIO interface to take xe_mmio
> > |  instead of xe_gt
> > | 
> > | [ Upstream commit a84590c5ceb354d2e9f7f6812cfb3a9709e14afa ]
> > | 
> > | Since much of the MMIO register access done by the driver is to non-GT
> > | registers, use of 'xe_gt' in these interfaces has been a long-standing
> > | design flaw that's been hard to disentangle.
> > [...]
> > 
> > 2. After this patch applied to 6.12.75 there is kernel NULL pointer
> > dereference BUG on MSI MAG H670 12th Gen Intel(R) Core(TM) i5-12600K
> > with ASRock Intel Arc B580 Challenger [Alchemist], 12GB:
> > [...]
> > The commit is found not by a git bisect (since it's reported by end
> > user and I cannot reproduce it on my hardware) but (by analyzing dmesg)
> > with:
> > [...]
> > Then finding the suspecting commit:
> > 
> >   $ git log --oneline -G'XE_LUNARLAKE' v6.12.74..v6.12.75
> >   26a40327c25c drm/xe: Switch MMIO interface to take xe_mmio instead of xe_gt
> > 
> > 6.18 and above are not affected by the bug. Also, they have another commit
> > modifying the line which is not present in 6.12 branch:
> > [...]
> > Related drm/xe bug report https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7661
> Nobody reacted to this and it seems the gitlab ticket is stalled, too.
> So let me ask: can this be resolved by reverting 26a40327c25c in 6.12.y?

As of me, this is not easy to revert, as it depends on many other
commits, and git does not have tooling to determine all dependant
commits for revert. I hope someone from drm subsystem notices this to
work on it, or Sasha can pull missing commits or revert this (obviously,
he have tooling for this, but I was unable to find it). [I found
obsolete references to deps but is seems not used for years and Python
git-deps tool seems broken.]

What I found is, offending commit is picked due to

  Stable-dep-of: 4a9b4e1fa52a ("drm/xe/mmio: Avoid double-adjust in 64-bit reads")

Which, perhaps, needs to be reverted.

Offending commit 26a40327c25c is not tracked in lore.
It's part of 9 piece patchset, perhaps they are logically dependent too,
so need to be reverted together.

The possible fix is part of 6 piece patchset, which does not cherry-pick
easily due to conflicts.

If someone can produce correct fix we can participate in the tests.

Thanks,

> 
> Ciao, Thorsten

