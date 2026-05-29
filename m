Return-Path: <stable+bounces-256626-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KbHDCiKGWoJxggAu9opvQ
	(envelope-from <stable+bounces-256626-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:44:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 531F760263B
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 14:44:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC06A30161B4
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 12:44:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F063E0C7A;
	Fri, 29 May 2026 12:44:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U8WWKG0j"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1F0C3E1682;
	Fri, 29 May 2026 12:44:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780058654; cv=none; b=d8JSLxzUX7o+FZsQ4fpq65HJ6RGg4N0yvrKTEx12LMLSgziOo52bFkgZr0kmtgYSq8JfIDUDn33GVkmhij3etQrVchr5lK/P6HUKXVRORjNd4EBBhmTlnWfsIxRxnLMe4omki1mGDb/NN5AeFuwrF8wSaHxR7hqy0ND3vX4j5zw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780058654; c=relaxed/simple;
	bh=fydvVjAVH3DpTajNCPdBLazp9UBSP9CcGOVs/7y7MoU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MmbI8QZYxZRbcEtY3LvU1OZtYwsB/1OL8cNtfqOcVAqsdtyDNBzor2CBaYDP1YYNZ/2sqnp6dMqmTLafte9k6h5EhP6tlPZTy+lgDKYFkpgH16ATPSpTx73+PTPP3GA10Y8TZ12n6IMWVGjGHD2kSmwS9QI+PtbhNzu2Y6LNIhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U8WWKG0j; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C89E11F0089A;
	Fri, 29 May 2026 12:44:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780058653;
	bh=fydvVjAVH3DpTajNCPdBLazp9UBSP9CcGOVs/7y7MoU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U8WWKG0jeIR6rUgaEri6hTUz3bR8Xk6PLCeTGm4auIhwl6sIQ7RKJovP25vLeLHbr
	 iDzce+EUF6qYXyxrk+6Pdq2lrl9YBLyBFN3MpXakauENvJz7Y7ZPMjLDMod3aaTsoC
	 PWl9279p44VBvXHEIwHvFF4O/BKpGNEAxoAH+CvgBpNrgOxtkYAeEGWC57YNkTsWi8
	 J62QNmT0AhRwls0wuWuTWLcQpDki8oxrJccdpLHQUwluLfnKILRU7UX8j4Vjvci6Ta
	 iOUYFkhjUyJ9eI8rsy20Xm4+T5He1lO6mH5U0CTmYly/boNikD0h5PhNXS6KMyrc0p
	 fVKpOxxs0N5FA==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	Josef Bacik <josef@toxicpanda.com>,
	David Sterba <dsterba@suse.com>,
	Daniel Vacek <neelx@suse.com>
Subject: Re: [PATCH 6.18 299/377] btrfs: dont search back for dir inode item in INO_LOOKUP_USER
Date: Fri, 29 May 2026 08:44:05 -0400
Message-ID: <20260529120000.btrfs-inolookup-keep@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPjX3Ff-a8JHxeMr1Hk83BmQX9YLGNR+g+7waygn43ZD7pWMHg@mail.gmail.com>
References: <20260528194638.371537336@linuxfoundation.org> <20260528194647.015775177@linuxfoundation.org> <CAPjX3Ff-a8JHxeMr1Hk83BmQX9YLGNR+g+7waygn43ZD7pWMHg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256626-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 531F760263B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026 at 08:39:10AM +0200, Daniel Vacek wrote:
> This is not a bugfix, rather, it is a cleanup.
> Even though it's kinda small and limited to a single function, I'm not
> sure it's worth the stable backport.
> Is there any specific reason you picked this patch?

You're right that it's a cleanup on its own. It wasn't selected as a
standalone backport - it was pulled in as a dependency (it carries
Stable-dep-of: 1e92637722ae "btrfs: check for subvolume before deleting
squota qgroup") so that the squota qgroup fix applies cleanly.

--
Thanks,
Sasha

