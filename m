Return-Path: <stable+bounces-223054-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yP+fBmswqGlPpQAAu9opvQ
	(envelope-from <stable+bounces-223054-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:15:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 667912003D3
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:15:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9038F30847C9
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33DE928506A;
	Wed,  4 Mar 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D8OYMzWs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E58CD2857F6;
	Wed,  4 Mar 2026 13:14:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772630045; cv=none; b=p+2s90bU0D15bhbW/bLW2/Mcv+9owp86NHrYJ1Z15qdR9yRUQ6rx9QWP0s/kJVZ6qCE4/BvGrE0MYzbUgW5RoRZfFuPwTb43svSNCcTDYugjGIgurYhYWqEvkWywZcIQVTjx+rNKtkLf529uNgvKqnLnnDHSRlSgSgg0+7hK1L8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772630045; c=relaxed/simple;
	bh=t3JN//GaX1jn8cPW2yHQGXLmPTrIbzPMlgHZakef29c=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WDUvNUuC6EL0J5rMQyubFBTbUcpwGjxRy66BZJbSuzMUzs8XYd8sUlgN24M3Df1yBqqmBflev8rjGPaRRZMWs6LUsoP96x8AbCZf3lyruAuLKuJlCElP34fIbAf169zedNhXe967BGy3wR0NkhA826sEM7IhdNk/641336MktFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D8OYMzWs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FC5CC19423;
	Wed,  4 Mar 2026 13:14:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772630044;
	bh=t3JN//GaX1jn8cPW2yHQGXLmPTrIbzPMlgHZakef29c=;
	h=From:To:Cc:Subject:Date:From;
	b=D8OYMzWsd0s8Vcjna3lOZxgZxlCVjjQ3PTVD/cE7sXHtBpcgT6Z8F2CQJPOsWEze3
	 x4tV55Yy4hQkma6cSFqT4Zbx1R/s8UKOCtHTojdwrmUsmfxwJMAFj+nCIOOGf4gReX
	 oHffwznNohVRx/xP3eWylck//VRE5EOxNVlDXdTYSWtLal2/J0s14tZzLcpT8u0cfn
	 Gp2XV99yLUTas+P0bHEer7kesM6FLCaL0N8B6XdoIXRX7qGPWnTVSBAgQ/wog1I/rl
	 T6U9rowaqPMRdz+W5w7YCBPDDVuc04XUWEMQf4OwSqVUNnsfkUdUGc5BSp7+CcGgHi
	 4QzvqiTPNL77w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.12.75
Date: Wed,  4 Mar 2026 08:14:01 -0500
Message-ID: <20260304131402.83200-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 667912003D3
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
	TAGGED_FROM(0.00)[bounces-223054-lists,stable=lfdr.de];
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

I'm announcing the release of the 6.12.75 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmoMBYACgkQ3qZv95d3
LNwN5A//a0R4DF5M/Blyz0BLhBR4JVYcqttz+5x+Sd+RjD+n5HzWwa/8TvGva2HG
sKligVyjEVVN7YbSrYhAO+nzM7qH2JoWm/PYHwkumVIOGR5eZ7Mgd31kAZMWSXb+
6jhrBsys8F1IfjZj2Kaj/jq3cVlLaf7WeGrZdtaASFoNzhDrEBr0tCMEdbVsEiUm
oaLd4Ep0hB9pRqN66Xgj8uTpH0E9HPqqgLy1QyX4Fta5XAS11Wm7Bt8tvHilJQvP
O6CCNfHM9NTSJ0c612hrBRf8cVJl1X5kYvSYccDCw2Usm6Darl+s43w/RzFt6TtW
/WaakJLwAxCizctILYQGdMtBAmuUMp00OIdd/7Vw9aytnXuY/4yi4s26h0jrYgaA
ok4BEsIDZ2/r3ZaX9TI6w/se6g1IdD1AwMm8pjaEIGylbIb46NRCPdb6vU0vvqd9
Nz4q+l5std27BLg6hWlh9KbkMeiacdUDyASf8gn9GkaEE+zyU+LhxK4024cwHVbt
+lBE7N4+TjT9BYBrdyv7KGEFUGv19E/TuPji91w1DB+gB0UKGb/E1/fPI/ExS0Iu
Y1DURBrvT4AtB3Ve9mPkY2YNE34sB0zs/3QOnDb7UGmTJBVbxnzye6qyIERKQUGa
LM73p8f2867zVYyj/okgDmVNiTA1uaMg2g6qasXP+oCKrZlCJ2g=
=FyPR
-----END PGP SIGNATURE-----

