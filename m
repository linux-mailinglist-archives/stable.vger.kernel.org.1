Return-Path: <stable+bounces-223222-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNmTI+mfqWnGAwEAu9opvQ
	(envelope-from <stable+bounces-223222-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:23:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id ECFFD2146E1
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:23:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4FD3A310D084
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4E663BED31;
	Thu,  5 Mar 2026 15:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/CMrH/w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F417637A48B;
	Thu,  5 Mar 2026 15:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723586; cv=none; b=chzdN7h/YiV3Dy2gygGMs9SkBiFje68Huv8+5r3litic/GlBDHUnjiKfw4CFiWyrpMuvXGfu9aXRCIwX+S8qudJnKP+px4vJw2ZO6sSzfyaSsZp/jFqdii0j3U4o/uIg/weKqUTFeJ+7sn/Gr2U4wUfThSKFoBWQ8S4XRY35e9Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723586; c=relaxed/simple;
	bh=ImMYnAnVA1TEIliLk12zRHyRukxarocMRhzq4s/Yr2w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GJkQ5gQ8SAxqajudOuIFq5q814WL2fVXRtH+ywsUwZi1PJ0+LeXWy2lqBMwiY5pqu6o2j+9hGd23TVAyNue1yx+7FheSgN9I/WnZWvsUAuBjSe44zneb3bfrWsqmaDvZCHGKXFU8KqGx55X95ZkLs06TGhSNXMYvLXWswBCIi8A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/CMrH/w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB713C116C6;
	Thu,  5 Mar 2026 15:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772723585;
	bh=ImMYnAnVA1TEIliLk12zRHyRukxarocMRhzq4s/Yr2w=;
	h=From:To:Cc:Subject:Date:From;
	b=X/CMrH/wsBbcTG3wYVAyuOsnqh1kW+0GjH+09/uypK/nHwDsZzwmDdOZRRHaOwjaN
	 cUIq6vM0Ei9igwJaSgzYsmyfqd+m7yvtf9BLChLr/YFRZ0/Fcct0DDOB/29st9bpDl
	 0+EENZBniQsfdCgFN/Emu9kj6A5+xAb9/oxMUzbq0MxLecws7a7MqILxmGR6I4MATy
	 WR0k9gD19fOJO1J0lzOAIjiQEzhq2eNviq/YQgfKbp9LaTM7IXhHBkBaA2XM9eyPNF
	 G9bhfcDbqic41VsSxRSw0dS1dQ8eTaGUSBBDCf7ED2J/WLZF2gJsMTxDxIWmhYQZf7
	 IAAKlBp6dg76A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.1.166
Date: Thu,  5 Mar 2026 10:13:02 -0500
Message-ID: <20260305151303.676629-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: ECFFD2146E1
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
	TAGGED_FROM(0.00)[bounces-223222-lists,stable=lfdr.de];
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

I'm announcing the release of the 6.1.166 kernel.

Only upgrade if you've observed a build failure with 6.1.165.

The updated 6.1.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
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
      Linux 6.1.166

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmpnXQACgkQ3qZv95d3
LNwr7w/9F5TY7FuvSVSYHJP0SHmbgS2BtSBoZRdEDOJWehnjVxYaS94j9wMPT+2e
Cs8tASGXMllSPEajiI7AgMXjuI3vxRwDN2vk0TvCw1Yt6dQVfPBuwftzy8KX1AC3
ljMv1yQCyyca1+PDTlRlOyU0VP1m41RlIzjq/Gg+S3rAJWMA3vlhwjAUZqB2cpmX
sFmY5QzFCVar/wdfM/csJ/1MEkig2gMJgFGWS3TyB7+ElfkSBlmtdtKZiSbI4Slr
YpTlN+t0NtcuvDwBpPaF71Fds9vpCPnEOQ+K5jHz4a6jlcbqs+8onxdjW7A8DgfT
UYPFKul19kOWJ76A1YVFNhsvhD4VAnssnq4t2TXj1n2YVBz8+0wGnPsEMouNUHWA
aA6719tnfn2+Fqkx+SFrYCYBTCexLY/EOjINmyY5vuwJO629yFev7j3atEHJpYQl
ALQX4VbaemSHyYmqR51dVNNO0y624gqw1uMW1FD4t46/BGsH9B85/yNrkjBysTJQ
8pa+5jRYWRUXF779qvUp1jVqmLH4qyMXmK3uH7aOTaVJqxHPjGWIkugLQr0Xr8aA
TVytfLpFw1zL+ujbI4HujOQUTV3KrVt5dspZ+pKYV6UD1iMEekudm/trDXAE5N2r
iJ9mnxlKwsAWBGLzjLPIKL/8w6n7ckmINPlJksdAJsEV9vmzfB0=
=diwW
-----END PGP SIGNATURE-----

