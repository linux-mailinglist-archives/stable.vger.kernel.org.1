Return-Path: <stable+bounces-223058-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KP/4FsAxqGm+pQAAu9opvQ
	(envelope-from <stable+bounces-223058-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:21:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CA76F200500
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 71BBE30928E7
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:15:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E920F282F2F;
	Wed,  4 Mar 2026 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AUbfUmNr"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F4507081A;
	Wed,  4 Mar 2026 13:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630127; cv=none; b=CpxcQu4EpFQiWb53UZLzMZZpcFnC6NYYcajzxUfycdDcEELTfRw3/iI/KLbedow/7L/RRLR4M24BNM4oOOcrSycJp13uxM6RLXgmvkqppkPeHk2ZGGqp8LwkklhaiMfd9tQYefuD7prJSsOEp/pPgUd2F0drmCg9yWIJuSG4nPo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630127; c=relaxed/simple;
	bh=MJWFr5rNhOYvvvO1Z0GK77QgQ5iSU6FzBWxi5BLSBbw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CapxGyH/tKLNeEYh1DQlm8tlYR7fRMPwh3zB6IXG+/BR+Et+oeoYVxKiA8m0U9EEsvCo7fpRy2pQ2DjhhhYYzIraWIXmnZthMU1P4gacKMHuo2Het/I/GKEHwMowhmwqZz55bzUcz1huSCkkimIeglGAFj4LvXpw5wSw/TCLmdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AUbfUmNr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C35D0C2BC87;
	Wed,  4 Mar 2026 13:15:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772630127;
	bh=MJWFr5rNhOYvvvO1Z0GK77QgQ5iSU6FzBWxi5BLSBbw=;
	h=From:To:Cc:Subject:Date:From;
	b=AUbfUmNr1pgFngyndksTGLENbVLLgYrqqngHAFdFY1PP5KsauLIByMxV70b1L0wUS
	 tWAzRTouZVjwBqGcqYwsxPfrfyXSLFpXjcrtgyhoOVi93JF1yJnClitRj8jNiJeh6u
	 hXXtJTjazOs2BuRUIkkoxllz47zYOIReOjvqKGwA1UByImcnIC9+lXB+ig71JKL05M
	 /67bFFmhWFdlQLQg7FZQmzBvKgEumSHsFb6jz6zVTlO8K1T7manduB2Pln3DutFiME
	 TGry55WbnTvSkeEXlOH9KBxPabfFa10kUXt4DR2z3Bo4/qo4XqqQbHZud2d48qxGsa
	 wQPMJNsz3fKBQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.1.165
Date: Wed,  4 Mar 2026 08:15:24 -0500
Message-ID: <20260304131525.84627-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CA76F200500
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223058-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 6.1.165 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmoMGsACgkQ3qZv95d3
LNy7eg/9GRLK+a+gkqqYV/lax4i5TpMFVQkAVmj9PkM8NlqXzwONZfx40tEqTPGt
Q3KBJYHLhApQeuOQ2BDFLU+6nBnE1Qj21pGwms6OenW/p04L05urS7JLUdR63JtW
S0CtWjXHHtC50UnvMahqo2LfaX1h+XHT0uIq1iJmg4tEjytLRyfLonUHJI8aknW+
CbFwEEYa4oqgrq2x247vymkjDMV6rlPbEVo4suCvfBp/oEszw5FGE0g8Ioq5X8PZ
IyL9rvq8YIAE64mNor2NUgWUyQlVByg0uaV/7uU8B1Iv2exlkFOGGQTimWlHrBKx
2gYH8ujvp/j1W049B3l9+T/cn32I70whM0iYGBJJL55+cAMTSQpI7yPsuxeiU0lj
lx0uoYISCmSQ20o1l98G1AxolF9Qh+c51p/sIkGf/vAc/tFqWHDbIM4mt4akcqnI
wuNpz/VzS31+HxsGFyM5Q1mooaZWmf1ml1e4M7aa9Sk/09mf72z3BsGwokfsaBwg
vUfSLFHcAnK/jieQxgkCk+XTO+7loIu8WEWCantNvh75PXs0g6r2nN8j8d5l2bQ3
H09VteRjnYIqTDkA63q9w3EjlCzWgtVPYuwlEML9w01DSXZHjt/gcvvcMBNo7mZa
RyRr8wMEggff0UkNeUaI0YSZkcJ8piBIJHcjQDiboasRYN5+Hm8=
=TOKY
-----END PGP SIGNATURE-----

