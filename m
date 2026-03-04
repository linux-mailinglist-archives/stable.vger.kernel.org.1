Return-Path: <stable+bounces-223060-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKatAwcxqGm+pQAAu9opvQ
	(envelope-from <stable+bounces-223060-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:17:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62BA520048E
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:17:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE656308F8DB
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:15:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 45D022853E0;
	Wed,  4 Mar 2026 13:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ic+2btbZ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF1857081A;
	Wed,  4 Mar 2026 13:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630139; cv=none; b=siH2JHx0sI4FykePxuXKxpu+gzEr/8XCzVKLWFCfsxnRREMJXctMcqib7B2EvpyP2g5K0XfHAlIAa0YVwtq++ZSKbhcytOuLCZsE1dKWG94JNj4fLwe3qAHVz0rgCRyK8y/NZhsa83OXcZYzq0LM/4oE+xcq7iNmwHTuF2B/ABU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630139; c=relaxed/simple;
	bh=RYD9I683lHGmOQkTwjCj+rGYi+A5mk85EcdwfXZXcII=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gK2hBVRZ3fI5lqT/KjPpqtTdiP+joexC8nqMl9YMHFv4gRxIIp1bFonjsHGYTlV7J3fZGTkR7r2ITEgOsi5lQnYANj9BiFEwlKULHoD/Npz26O6BrOUdgFkfAopE0iIt/f69kz91kMgQ0YEyPRDR8/bkhtS0mz+Tv8/VSVPoEiE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ic+2btbZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99DC9C19423;
	Wed,  4 Mar 2026 13:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772630138;
	bh=RYD9I683lHGmOQkTwjCj+rGYi+A5mk85EcdwfXZXcII=;
	h=From:To:Cc:Subject:Date:From;
	b=ic+2btbZNoOjLrZuJzvH3Krt37PtGvQygk+vkTpO7xF32VpZRiICOmjZB3cDMIf8y
	 ehF97bNeN12rKmT6yH3nznikzAc4epo5ZadlMjZ5n5d3AXom3adiSU5pSHMK9Mypy7
	 fePWJ9pvEwJdUfZdfSJSXIIWFTJtcvP5Rstxh3RUIBEYTUoAy556RRBSKK+ATwjHyj
	 Iqc259qITP5a5XFeskeTfM0x461utqce3EqNczsJWHwUHPP2iMPdbGHsD9eytMhmq5
	 y+Ld3adztci2SBWjWgSz8iz1fkZz8XRkzDX47lnM9VpRV+ZOCCb3GKQfpbSmJQgwAy
	 LhdfstY/NpsFg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 5.15.202
Date: Wed,  4 Mar 2026 08:15:34 -0500
Message-ID: <20260304131535.84850-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 62BA520048E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223060-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 5.15.202 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmoMHUACgkQ3qZv95d3
LNzc1g//YEAp/PUTdX16PKW7e/3S9CDaSBOdVgY3xb372XT++rd/Ty2qN/eNH8u8
rc27fv4CpLHfIYKP6AeCg7JCQRCvD7f8yPD0ii/VCOAjVGTYYxzOLCc2Ey8/asOv
++x574wjxA56zsR2jHdqbiBeIgO61Q0GiHjLs+SEiS4El0A10oIfwB1Fl+lChtUF
bj7x0FtInpgRj9dYpDFOrVbGx8M7D9JzxlRXnRN8VJ1gLlWoGnZe4OQr48/2Z3D7
PAHpIJWpK0rIJT1KZJgi2AVFFybmBUo+7E0Sd85pdwXsDkLVQlIzdPeD//3PIjk5
hMVyxIglfIIJoepq92CVANEJ5tNtg5xW/q6KHrFLyTaDJ5L/FewsXu4y3g64AQSu
UG5bh8To3cLeUoiTHBVmR1acYYQINJHeCvjyEUByZN2xVEUZGdGfmPEgyS9pEJah
rbztIJHi7WtOmoEwoPv3Gxzu9n/yavDCi7ZBPvJOl3baP4GO+2dY5dmNawh/tu0N
DukXp0vRG2Gh5DoKXGm10JgfP+ippa5jPQcIqyjZ+ygDxM7vhyb5eoTCYjLuShZa
ywO/bnyVzZ8kXpXZUktvyh2fPn0ZKOVkJRGRkRSowJkUUr/oaDjK4v8i/hDQX+ku
vW8fX+HWXnj0WvMYKsxRCgdEo/KVYSeZyt5vv4fqIHap6bbTS6I=
=TS4J
-----END PGP SIGNATURE-----

