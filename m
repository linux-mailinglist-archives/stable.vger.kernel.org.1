Return-Path: <stable+bounces-274036-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8/htEXlvVWqQoQAAu9opvQ
	(envelope-from <stable+bounces-274036-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:06:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 84EBE74F9D1
	for <lists+stable@lfdr.de>; Tue, 14 Jul 2026 01:06:32 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Dn0tNPxq;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274036-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-274036-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0A515302D4DD
	for <lists+stable@lfdr.de>; Mon, 13 Jul 2026 23:06:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24D263B8950;
	Mon, 13 Jul 2026 23:06:26 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF66C3368B1;
	Mon, 13 Jul 2026 23:06:24 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783983985; cv=none; b=COgldTauXICPoljufi2KQjHafUel7iGiAM64JdR5t0atzvvfY4B9H8+hK4gllxIgI3vidB1/EogHJG7o7UE09aEjkmcfwOBOsXc29BnvVXBQEcx6N/KoKY5IZvStqP8SO0CaKGFDBa+1a+SG36VT7c9xRuY/4xGPC94Uk9omrDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783983985; c=relaxed/simple;
	bh=0PLOsS4FFVYlRgVm1kIZDCenD6z1ZGWG7lEfdX5fqNU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=V16w8HSaDYrGMdZEVH6asJ0xYsaD6vtUGUsgQVPa6MiebtW9YKbE5B4/7Cu/JoDO0+FSxli9KPY5Yx7lNjx8Xp6lemNTz2gYra5yX3OwQPvDWFUfJMWhBzQlmpgRRzp/2QuRZ4lX+YMZkpmdhLYI1sPh0orhJtQ4s73T3CZDg7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Dn0tNPxq; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C54C1F000E9;
	Mon, 13 Jul 2026 23:06:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783983984;
	bh=FtIalFibIBtfNJD/gl/cjbxIZv6lFzzxbDuNWRXzgOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Dn0tNPxqlFf0MueHFMs82O+varatzgA1Tqxtu8UhjCouM0zlkzO6zfV8ZEQd4KvvL
	 r9Xu9+MLG3iPs8mIGZQBrvV/7Rrz+I4YrYVqHEi4kxRh1hPVyTTDbzJwPjyisGuGpw
	 TDNWv5Pnly8HSlxsNON/ebFmfAcunEBxCaHcZneahib8LYzIcYolVSD9v7InXfVxtp
	 8S+gW5QiNPPKVcdTG3isVjcYlzoV9osf5PnuQzFDmPjJh7mwKWBkzR2NxDnoBSqJdd
	 jwbo2+Lyy3OsZujP2IgaB5lKTGlHEHfEqeOG0animS2zYntQV89gBIdq+Qy20Kuaqu
	 T/3Fx3fz+GCJQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Danilo Krummrich <dakr@kernel.org>
Cc: gregkh@linuxfoundation.org,
	rafael@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	a.hindborg@kernel.org,
	aliceryhl@google.com,
	tmgross@umich.edu,
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	lyude@redhat.com,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>
Subject: Re: [PATCH] rust: devres: fix race between concurrent revokers
Date: Tue, 14 Jul 2026 01:05:23 +0200
Message-ID: <20260713230522.2023240-2-dakr@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260628174451.2275679-1-dakr@kernel.org>
References: <20260628174451.2275679-1-dakr@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS(0.00)[m:dakr@kernel.org,m:gregkh@linuxfoundation.org,m:rafael@kernel.org,m:ojeda@kernel.org,m:boqun@kernel.org,m:gary@garyguo.net,m:bjorn3_gh@protonmail.com,m:a.hindborg@kernel.org,m:aliceryhl@google.com,m:tmgross@umich.edu,m:daniel.almeida@collabora.com,m:tamird@kernel.org,m:acourbot@nvidia.com,m:work@onurozkan.dev,m:lyude@redhat.com,m:driver-core@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:rust-for-linux@vger.kernel.org,m:stable@vger.kernel.org,m:sashiko-bot@kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[20];
	FORGED_SENDER(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-274036-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linuxfoundation.org,kernel.org,garyguo.net,protonmail.com,google.com,umich.edu,collabora.com,nvidia.com,onurozkan.dev,redhat.com,lists.linux.dev,vger.kernel.org];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 84EBE74F9D1

On Sun, 28 Jun 2026 19:44:38 +0200, Danilo Krummrich wrote:=0D
> [PATCH] rust: devres: fix race between concurrent revokers=0D
=0D
Applied, thanks!=0D
=0D
  Branch: driver-core-testing=0D
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-=
core.git=0D
=0D
[1/2] rust: devres: fix race between concurrent revokers=0D
      commit: acc516dfa197=0D
[2/2] rust: devres: ensure revocation is complete before device finishes un=
binding=0D
      commit: a10639966fd7=0D
=0D
The patches will appear in the next linux-next integration (typically withi=
n 24=0D
hours on weekdays).=0D
=0D
The patches are in the driver-core-testing branch and will be promoted to=0D
driver-core-next after validation.=0D

