Return-Path: <stable+bounces-223056-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6GlgArYwqGm+pQAAu9opvQ
	(envelope-from <stable+bounces-223056-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:16:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A74E020043E
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:16:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6B11E305309D
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:15:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A00B2DEA7B;
	Wed,  4 Mar 2026 13:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lx65ORKo"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB502C032E;
	Wed,  4 Mar 2026 13:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630117; cv=none; b=XikjgubiGL/dUKXOdGe9R5h5WjARqFO/TnNJiRQWZpSiLSuZME9edtOWQMe9gW0+1N1LZS70TlIeocBkTxVAAQuXD+yfgd5xVu8accBHCVYO4gS/Bnrl3S+tOqPq0YqD7vbhgXcE7jDfpv37gRPiMWR/f7srT4kF1w9z3yxY5aQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630117; c=relaxed/simple;
	bh=y9GOUPi8TT2dnFdgTA9l/8s0H7EGHBdRuMh6a5QxSNY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TWdIaaT7CvcO0O1gsqQmGsnXZPwZcqS8AOIx/rdJtrMSfZRWsYxUtXwCEW5WoQ2VaTg/g/+fd7hN4PGeg4D4F4Jew+iZ+YvtA/oSJNI6cjNMjiqs2zhsuqv+EZZ3YD08se7S+V3wnE5Si7xr6YkEgd4W8colSBrDE+iAKTv5Elg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lx65ORKo; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5CE6C19423;
	Wed,  4 Mar 2026 13:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772630116;
	bh=y9GOUPi8TT2dnFdgTA9l/8s0H7EGHBdRuMh6a5QxSNY=;
	h=From:To:Cc:Subject:Date:From;
	b=lx65ORKo1OX4BzGU7uG8qHpRVJpsxoblgZ6C+SA0Oq2hoaUOObvQU8icJCNMuLBDj
	 VhvpwI08ysk1vLe/nzLfjj+Lo36vYIghk4SJ4FTX1Knv9ixZwKQ0GuD1bKvkHnhAYi
	 k5y/2MU5KI4Ridbpi5HIbXPER0HHt/8182Ko8e50B++GcQ9KaK8dveLCk+azYZSXYy
	 lwRxJUiQbdIb9Gpb5JkIlQm+sxypgPQv10cGLcBvrYAfUelB2z7vQRAxVx1jYtYs3D
	 ShW4iH8e2a9QRPsVfk2J8+XNV7/TXcmRf9lhYD3PfsJDlju0daB+VxnO9G9B9BHEBh
	 oCzSgzV44rZNw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.6.128
Date: Wed,  4 Mar 2026 08:15:11 -0500
Message-ID: <20260304131514.84409-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: A74E020043E
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
	TAGGED_FROM(0.00)[bounces-223056-lists,stable=lfdr.de];
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

I'm announcing the release of the 6.6.128 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmoMFoACgkQ3qZv95d3
LNw8SBAAqlT802VCBW1Z6+VJS+551Qn4B3Gi6TgWkiw2AknbikH4M0phsHmyt8st
KAFUQtOj8ByhPsgcX3fBz4AafpoADkUQH9lpAAge5DhkBXtFL1QsTPcUdzZ5meIn
nV5yx552BoU7sKpR1zsRfRj0AOWIXOLC2rLz3mOa07H2vdlw/d2YFjBLgvdSD/MG
WMegUH1Ni1Rd1A+yivrgREi6Qhv86w77BUSWKVWqu9FV5pyhUviWH3KcZCYHTaId
+wCaXue5kRjPfmXBRschRCH5mCcLNJOuoE3fYpDqQRoApvQiVr1P62QFCBy2cLEp
YHm2E/dL1+p8rmT0LX3JrJYuksh+8ZkDID8gvrNiN4dniV22EN+D2QeCX5SJENnW
gr4SykYaWTstCf04wIwGivqzUWAIXfV7H/9waSMD1fOsdpxI8WVlKZNJI7VJ5a8C
KpoYt8vzXPjG5jOPuVd4kS9r80KxDd2a+9C6kokniYpty00O5XFccqRMPaNLaYFe
6zWyCI2HQ+zsC5HKMbCV3ok0yre05YWzuDERKYd3NPWT/tzPTjNjc+IU0SCbeIX4
YkL9c2bIZal+Znr7wnuP/qWAH+WujJryQQx+V5rqsbtWqwdLjub+fpM+XzdrIptZ
VQNwD/tvefO8pegxZuvPjNADHY55zAX73Lp238s3sg0p8YwA+so=
=46yU
-----END PGP SIGNATURE-----

