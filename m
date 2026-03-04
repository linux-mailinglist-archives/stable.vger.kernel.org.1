Return-Path: <stable+bounces-223050-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8FeANwowqGlPpQAAu9opvQ
	(envelope-from <stable+bounces-223050-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:13:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C922002BB
	for <lists+stable@lfdr.de>; Wed, 04 Mar 2026 14:13:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A30E5302615A
	for <lists+stable@lfdr.de>; Wed,  4 Mar 2026 13:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6EC5281530;
	Wed,  4 Mar 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WEX0WJDe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B0AA26ED28;
	Wed,  4 Mar 2026 13:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772629998; cv=none; b=IfC38zuYXbmeg1C1pT+sypi+3VS8IXrkeNsvfU77CauMCxGVMafWZBQVmiOJSkVcF3b3NhvRZwYSu0uKR2ERz2larpuXRfzYxaj1AfP9vnl2jOGAwmgBC5NBIO/LwGbApzc0dRdXY4jI2LlICJL8iSgVZcbK3FmhovgFZGcyTis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772629998; c=relaxed/simple;
	bh=alj+m/LJxcbwrss7qk+VkFWEPorGdXjRoqof4m21o6M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A8bLm4ce0nK6NTnHcm2UCDD7DUgI55wRq3uJUTKTi2n4rN3l8at8IvylPZgXRdh9h0OXkx7opPguNysr+M/r8kNmq/iYOEMXMpERBM9d6/Rwt/NAcrOeG5lT80PaH5nLXlKxB/OtpCJ4DdjhEs0udWPF1vSmCC26TOEy60S1TkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WEX0WJDe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5521EC2BCAF;
	Wed,  4 Mar 2026 13:13:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772629998;
	bh=alj+m/LJxcbwrss7qk+VkFWEPorGdXjRoqof4m21o6M=;
	h=From:To:Cc:Subject:Date:From;
	b=WEX0WJDenTn6OtnIpdm6fdOT9Ai3B1R43airJ7roxeQ6to3/Ifdyv33hOORZW8boQ
	 r7HVKogUu3oMZKq5Hd6B1SOQAHP+7A5U8APHZsy4Ygkf5Lo513Onf/5uSavDWwvz5j
	 pZ1eBT5wjn+w2SzzDkri2UbpCURn8NRpP8FY7FadKX/x19jHMebe64PM88lfrPIqI2
	 qZrchFnvQ/A9MU3T5eD6i1KiWKvHPbRVh6gDBz9HV/R3I+yTapnjaXx1r6k5pqjMaH
	 mrXBcXI7lmyEniyrvA1faxwlxEJRVE9PAVLwSGIOqFbGkXkI8f031NjalmhXzEUooV
	 8jUQXSQC9cC8g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.19.6
Date: Wed,  4 Mar 2026 08:13:12 -0500
Message-ID: <20260304131313.82315-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 64C922002BB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223050-lists,stable=lfdr.de];
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

I'm announcing the release of the 6.19.6 kernel.

All users of the 6.19 kernel series must upgrade.

The updated 6.19.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.19.y
and can be browsed at the normal kernel.org git web browser:
        https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary


Thanks,
Sasha

- ------------



-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmoL9QACgkQ3qZv95d3
LNwG1g//S83UE9fkUIMb29SnzLY9cjILOXXkixytPJGE8TGswQix+lITAtgcFfhs
I7fx1LN0yXYY1G+OvAKh5qQ/ueKRac6bGAP69xLS6sGe+tPmPsc/ODwkJhIQsw0e
0rm0iuOS38y9+KrsyobhECMBe28vAh4zpXAoWjtXMwApgHu6WlrKro2RqSymj5Uv
SEUijafOWbfJL87eH1v7vCznm1RQ+RJRTQ4/8z8XTQmG3j/jDJyF0C5xnVxPm1Td
FrvzK2w01POPG26ly5lvcJSgBDgXVoMXPshP+mMyeR57sCnhRYpVdMWXNVOo1gn3
qL15UHM3QQII842+VxuO92tOqmn3/HrFZXc8gqm7B3YqKgxSo23sMWUzai5DEbfl
nU1TTVKRZ/alkteK6tRYgm42NsQArzVlVkrjKzcbg4raSvCZQwjZ3QgqvVH7uRVo
bqM+yafIItVekEnK8baO7o0j62IftWzahS+jvprE9KoXXdHFGiqcJXgzEAAPdqRa
KgkqBqv46nb+ApLCC7HqZ5nJ2XCpcPTkyp+AzDdIWA45ruzepJKrsL0JnxhbGSNI
Asu0yDFa1QLdsnemcSW0q6K5J83488tjOTo7tJLeKamJgfQkk6i5CJ1QTH+ST6Yd
1g/XJ+UmKgu3TSBOGLG9r1YbyGooSWsIKHf6A6ZhyWmlnVaB4nc=
=rntL
-----END PGP SIGNATURE-----

