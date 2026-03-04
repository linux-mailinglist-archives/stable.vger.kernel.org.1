Return-Path: <stable+bounces-223052-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CPk5H0MwqGm+pQAAu9opvQ
	(envelope-from <stable+bounces-223052-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:14:43 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D17A7200352
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:14:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6E2113026168
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:13:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDCD228134C;
	Wed,  4 Mar 2026 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jpwacwSH"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10D71DEFE0;
	Wed,  4 Mar 2026 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630030; cv=none; b=rhiDI/divscVlgIR8zwlFcO1dM9Vu0OrKS4a0LAHxJAsTwfij5E9SrQGuFRgzg1yk3Y+IxJLcrFyu/hD0iPRN/zhaHQo00z+QwbxVHj+4AppS7vXJYaqx46TIKZxaqaXRuV/QZyEGrWtAq3K4KJYDlKklu6L5MTTvJkMUDMSBDY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630030; c=relaxed/simple;
	bh=J/buogSqpH1E9Pr8JdbdDWBWq/lKGHbBoCRzvASoklU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aL9J/HOwiydvKgQ6OhP9zypXkU0Npn8UpHWcH8qWz/dADxGnbRf2EOj3fAV81T6UWThwqE9OzgquGUCiiFYMQDWgXDxnuQmOJyNa8co4CThg0mO4kaMnGN5/+qBYqSjURBqpM7sqrE/urz4Yi34ioMk98mmlLEz1PIhCrwC/nJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jpwacwSH; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64C6EC19423;
	Wed,  4 Mar 2026 13:13:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772630030;
	bh=J/buogSqpH1E9Pr8JdbdDWBWq/lKGHbBoCRzvASoklU=;
	h=From:To:Cc:Subject:Date:From;
	b=jpwacwSHvsCa6gY0ERoB6JSpfQsUcbOKMqJfSbLlgW0HDRBppCyTH9PALQvnUB/6A
	 VB9t01mkBrMNtV1K3OmQO/aj2ypvsee3TFtyQPWLD+79Yb261iMN4rnFnGQ1lh4owZ
	 EtKviJbqO5vjOiwqIrxz7lGT84eIn1QX8DxIw9zNQpz5lGAQUNCgJYh/YQiQVjLs6S
	 rp+TNsO+twsEUQQQ1OdlJl6MSOzYqoo3hCbfU2oSy6tvilFJ3dw7V6Ulp3nfR98nT0
	 ooHNZTyJ9pnLpWkszFmdAyE0zjWYjQRiwBBXIp0snxVjXbDmsfdVTxldu/teCg/f/k
	 qVKuQFvK1OfRg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.18.16
Date: Wed,  4 Mar 2026 08:13:46 -0500
Message-ID: <20260304131347.82894-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: D17A7200352
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223052-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 6.18.16 kernel.

All users of the 6.18 kernel series must upgrade.

The updated 6.18.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.18.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmoMAEACgkQ3qZv95d3
LNx0VxAAvD/FcN7MCFwTRqmghEAAPTCI+nhl12AyXK0xJnJwSWdrSZ86NXdi4VZi
1yLm1UkiK4/jn1u3qdKnRQqFlfOPOnH4vTsrlCIsEsdrCIMarkbJNUF3iXnKZJd/
kzUAlMyP5jUZaG7wz+/HeowZl2uHXudVK7398MCr5G7jaRolEADHiQGFxEchHjXc
z0c8JxwNLSGV0klAa8lMHYLWjwMsujLvbwQePiSKHgogdBFkCBM1Ogm/cD2mezzY
mJsb1egyrpi4AyHw5P8n8gSs7WV+Ek577OrPzpYSNom4PPIJnCNzAn6oNIL8J1v4
Y6aBJ1xKqeDOfr/gAYsHGgDeLyOYbTIjk5uaHqTjTQ31ZP0nGIWCHtcCXqx8agSf
rfBqdrKuoscPrH85TWbgRDjDze0T6fm5wiwYKTjCVa8KAFpW0+zUAPA5eZsG827a
ua3P7Eosi5zULcU2voHVKnw7yLM8cfxVMbq2yHH37K27eIF296q4LSKlzbJwaiAO
txFNplFDi7lJ4OZIuxQ+m9QwX2wpSax1s3ZT+gCqUpjEUY7ov8g3Uj1jjNTI2hN+
6DuNCu7L/h+qsSbTYltkaoQyrTzgNhDDZt+RD51Df0jCbr2Lt7nI/+SllFB4StcM
WCbAKJ/XNsqFQrEZ9D47Sk0heEVlEUSlZX2+1CVWJyFZhXTHXlo=
=4vax
-----END PGP SIGNATURE-----

