Return-Path: <stable+bounces-269746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id VJuqL1piQmrK5wkAu9opvQ
	(envelope-from <stable+bounces-269746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 14:17:30 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C316D9F36
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 14:17:30 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=K9dZyRX+;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269746-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269746-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88283301724F
	for <lists+stable@lfdr.de>; Mon, 29 Jun 2026 12:15:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81603FF1D6;
	Mon, 29 Jun 2026 12:15:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 678D33FE35A;
	Mon, 29 Jun 2026 12:15:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782735325; cv=none; b=suLoKPceAzk5iVGhQviUSAzrt5oxZO/TMwdM8iMkbyzBvU3pkfJ0kekxWVI/r24MRBH3glLtWoeRbcoxsGOYOcKeN1Gpe+uSc/mEEbb4tfbGpdvvv7VnK1bJ/Q9C1QyLwC9INZsud75OG/TPBMan7SRAGFEw56W16IqTAY/9WaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782735325; c=relaxed/simple;
	bh=T5WovzhCFKz4G/fb6TfdpHfesyp09NS4EQPhTFfMkUc=;
	h=MIME-Version:Content-Type:Subject:From:To:Cc:In-Reply-To:
	 References:Date:Message-Id; b=MlpvADjSq2sjgCmEyoXCOG0urKUKceRpxnLO/vDc+jdNqDtAb0gTz3WrRWSPQnS9ZTWVTOr9dwGhBmO63J7nNS9HBiq5Otq0JcAysdPl27bVyshb4Cas1eDE0cZjf5cAFfT1WsCeqKYiCWs/+OODGCEQeW0jhmHR2lDSk3XApwg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K9dZyRX+; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CAA71F000E9;
	Mon, 29 Jun 2026 12:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782735324;
	bh=Ib3bsCrjJ/YTtTkut2lMHiWjoeu6mhtWtwT28YpERNk=;
	h=Subject:From:To:Cc:In-Reply-To:References:Date;
	b=K9dZyRX+d4FAViVDAE3qeR8uiytew7r/wwvdnbw2pLzk34UOwGxvC34eg3qFspG2O
	 NwZPGN/SV7RcTKIvcggcCjVtiSROmoQnPu4ZbOkBFTh9pqawRYjuiwvnDbkm8pMtU5
	 TrURwID5TBZSmBvqrggDjQblNwwO1m3IGfP7YPmusz+ySpaF0jVqic11yFaciPmVOw
	 rXo8mlio2lp+8OYh/oH+YInPXPUG3xDjb5cIfbsRaX4/bea5SUhGcIPK3DBfT2qqH0
	 XdDJkf67UjDlghNJzE9qy33nswqMlMN5NCiksRqFsZqqYsizdTo93fMIp+m8v0RGZF
	 5RS7KB77c+Zmg==
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] mm: do file ownership checks with the proper mount
 idmap
From: Christian Brauner <brauner@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Pedro Falcato <pfalcato@suse.de>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, 
 "Matthew Wilcox (Oracle)" <willy@infradead.org>, 
 Andrew Morton <akpm@linux-foundation.org>, 
 "Liam R. Howlett" <liam@infradead.org>, 
 David Hildenbrand <david@kernel.org>, Vlastimil Babka <vbabka@kernel.org>, 
 Jann Horn <jannh@google.com>, linux-fsdevel@vger.kernel.org, 
 linux-mm@kvack.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
In-Reply-To: <s6mr3j7gew2cgerzrvqzenjctctrtnhvlynmcccxb24uszcauz@5iapd6wnbfxg>
References: <20260625153853.913949-1-pfalcato@suse.de>
 <s6mr3j7gew2cgerzrvqzenjctctrtnhvlynmcccxb24uszcauz@5iapd6wnbfxg>
Date: Mon, 29 Jun 2026 14:15:19 +0200
Message-Id: <20260629-sektor-gaben-gepokert-58db0a3528a3@brauner>
X-Mailer: b4 0.16-dev-4217c
X-Developer-Signature: v=1; a=openpgp-sha256; l=2047; i=brauner@kernel.org;
 h=from:subject:message-id; bh=T5WovzhCFKz4G/fb6TfdpHfesyp09NS4EQPhTFfMkUc=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ5Jd7Y+irtou7+09lprx08z0UfPLfnp+Z0UXejY7x5B
 j3MVxJ6O0pZGMS4GGTFFFkc2k3C5ZbzVGw2ytSAmcPKBDKEgYtTACbym4mRoUOgUez4ZoaN60N4
 24zvfXXlXOx5q3jt+X9Bzgar7yUn+TP8M4qJv2hy0aUs7NLkaVf8nEPYZ8g63L555Feby6kfSfs
 8WAE=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jack@suse.cz,m:pfalcato@suse.de,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:willy@infradead.org,m:akpm@linux-foundation.org,m:liam@infradead.org,m:david@kernel.org,m:vbabka@kernel.org,m:jannh@google.com,m:linux-fsdevel@vger.kernel.org,m:linux-mm@kvack.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[brauner@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-269746-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,suse.de:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,brauner:mid]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 36C316D9F36

On 2026-06-26 16:19:18+02:00, Jan Kara wrote:
> On Thu 25-06-26 16:38:53, Pedro Falcato wrote:
> 
> > Ever since idmapped mounts were introduced, inode ownership checks
> > (for side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were
> > done against the nop_mnt_idmap, which completely ignores the file's mount's
> > idmap. This results in odd edgecases like:
> > 
> > 1) mount/bind-mount with an idmap userA:userB:1
> > 2) userB runs an owner_or_capable() check on file that is owned by userA
> > on-disk/in-memory, but owned by userB after idmap translation
> > 3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied
> > 
> > In the case of mincore/madvise MADV_PAGEOUT, this is usually benign, because
> > file_permission(file, MAY_WRITE) will probably succeed, as it uses the proper
> > idmap internally, but it does not need to be the case on e.g a 0444 file
> > where even the owner itself doesn't have permissions to write to it.
> > 
> > Since this is clearly not trivial to get right, introduce a
> > file_owner_or_capable() that can carry the correct semantics, and switch
> > the various users in mm to it.
> > 
> > The issue was found by manual code inspection & an off-list discussion with
> > Jan Kara.
> > 
> > Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
> > Cc: stable@vger.kernel.org
> > Signed-off-by: Pedro Falcato <pfalcato@suse.de>
> 
> This looks good to me. I'm a bit curious why Christian initially (in 2021)
> used init_user_ns here instead of the file namespace... Anyway feel free to
> add:

Back when this was added only the do_mincore() codepath existed and that
was intentionally left unconverted because it exposes the cache
residency status. So it was effectively a massive side-channel.

Both fd3b1bc3c86e ("mm/madvise: fix madvise_pageout for private file mappings")
and specifically cachestat() came way after all that.

I'm otherwise fine with the change.

Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>


