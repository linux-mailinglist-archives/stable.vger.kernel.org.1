Return-Path: <stable+bounces-223218-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2NQiK6GdqWnGAwEAu9opvQ
	(envelope-from <stable+bounces-223218-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:13:37 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 57554214420
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:13:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3A9B63010B5E
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:11:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DCFF3BE159;
	Thu,  5 Mar 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AanIvcxG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FAC939A056;
	Thu,  5 Mar 2026 15:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723431; cv=none; b=lg6rea2kVvaniY84JKZsPkn/0e0RNyaFzDQiEBTOXXHzTem43v9KZaDCEQLkUxU+RsLxTtY9vplx6Jv7pff+sOQJ224iXFnvy/fZb9hVH6oghp4Id1blD1muSXO2orT3UES3jsUy+BIVaTy5v//BMCvJ4j9XTAX68DnLYwtFGDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723431; c=relaxed/simple;
	bh=AkIKthFC3seyjQHFCISfUgPvjeZra1+Ur0x0UR4LTCw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=grO9/L0oc+SKbT2D5Gf1HrdOXwjM4WxYZbBPSwVepEi/qF2hXmtLqsmK/ZfLphnpAJxdVcgLK8DI9y8uNSIFvfFD+vPtj5NfaWK9l1YRZfqsFayWE3ewsaYta5oVQ601nS6eI1azOaFjgcM72eOCu5Tdn8x/z5aMvZwChGkrALo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AanIvcxG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21241C116C6;
	Thu,  5 Mar 2026 15:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772723430;
	bh=AkIKthFC3seyjQHFCISfUgPvjeZra1+Ur0x0UR4LTCw=;
	h=From:To:Cc:Subject:Date:From;
	b=AanIvcxGJ91mJRGbgHWgw/I/Q46d83BImSDH+NcCzv/d61FPOAs8zIxXO8bXCdDbS
	 wHqvwu3WHMXxfHInzlkgpQ/czHoN3a0mNEFx3Db1eyRLd8r4pdgL/dmFUrCsFLDW//
	 jy6Fehm6eLRYpw3zoZ2sqskc16lblQK7cRIQKeUty38j4Sc/AdNDwWEbYueLnkA5f8
	 EmnEIvzLvKmkpijS5ZbpZRY2WXr7VifKKVh2zW1Z3TCfwPAZe2E3deif/DJdne5Y/r
	 t/IXxjTC8xb+bXtS8iU5owmpYLZrmXDybnlID76fGsSYNxJg0e9O5GFtAV8UhFPTdk
	 uC8pNkGsfzd1w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.12.76
Date: Thu,  5 Mar 2026 10:10:27 -0500
Message-ID: <20260305151028.671440-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 57554214420
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223218-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 6.12.76 kernel.

Only upgrade if you've observed a build failure with 6.12.75.

The updated 6.12.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------


 Makefile                | 2 +-
 arch/x86/kernel/setup.c | 6 ------
 2 files changed, 1 insertion(+), 7 deletions(-)

Sasha Levin (2):
      Revert "x86/kexec: add a sanity check on previous kernel's ima kexec buffer"
      Linux 6.12.76

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmpnLsACgkQ3qZv95d3
LNwXXhAAhqrmS010AOI+mAJc/zlNozEJKL9EObff0hXE8QyWLXgDsaz+bHOgqajI
NNvad5SOgou6y9pGJQjrBVORqSHDHb3VFySP+sBQSOoHht0bRkc8oz61HNQMxszx
4c1tprm94eSawQc2SjbB+cMNVporcu5DA9nrotrMtzNmGjyA3L7oZ6Oe4abFQTJm
av/gMDmkuLVWbEcf3tCZuAHXBX2EYD6536RfimXz+MTl5YIF6lEFnSStaMFgySJm
aLepvE6mccn31V5DzKQrjjC17AKOi2AFDY9skTTsgIbS7gZK8fkuOJQGS5SOVPPG
z9EmNYSsuwhSS7BVVyouam5AEbwkWXiPvYkNf2CvHdVATvQcuUIqDtfkxFhOsCEL
5i6bp9d+Dye3qdyJMXdT+8/5GEo8UJDc6m0uz3+uZ904taD6ZzYB7g6/JgmqKWPz
dKBLg4uSam0rMn3TJbqVMe5zvRmBf0EzhP8qNve2YGeBhZYPRZgXj9iXNQoLq52P
ID8tXO/I47gzXOGD1xItNaXrWuHze0bNsuEDQc1gJxRoy7Ef9TJ8/unr+b3+ra/B
kzwN+e4MVxXxa0O5lLximHWGCQOisPc9js+Y8quasNX0LqcUSNGc5eigIFAOacMx
SskQ9uOlv+D/oxk3pn+JoF+TvsqwkgBM+ypUfyiBzJRXouzqWao=
=6dxV
-----END PGP SIGNATURE-----

