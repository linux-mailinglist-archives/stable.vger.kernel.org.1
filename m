Return-Path: <stable+bounces-223220-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBvvLrSfqWnGAwEAu9opvQ
	(envelope-from <stable+bounces-223220-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:22:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id E1ECE214689
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 16:22:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id ACCD23078A19
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 650A23BED25;
	Thu,  5 Mar 2026 15:11:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aE65+XGe"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 259BA3BE142;
	Thu,  5 Mar 2026 15:11:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772723485; cv=none; b=geW1LeB07KuPTbhgqutn8ba3xh1sVINYA140ohEh+JZYHCN7cNMpyoATYS7KXgc6SAT/XRl/NuV1wuN2zUWxQC546mXnTHB4DXWRJrB/HbyYH5vvkMQzYvS2vMt5Ub8oOCTQBIdX58Z5f8fztlvYNramlJczGVF8E3n8Z43AYOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772723485; c=relaxed/simple;
	bh=zOdr1n6Jvz+TdEIy9dtxHrixte9Xb/aw7TNi7HLDY5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dq/WEvuDdHvklV/J7gE61NpDjKKEOIy6IwO4d47mTfmPK2mQhDA0k3eV7OySVJzpT7uuUhvhBqNwKyqQ2wZhJcq4WQV+FoK+oNPTK6K+xAEz74W8gkRxA/NwZyEmN5VLhINdkl41/RiYQKtdPAV/qdJ16pDiwRgPRMnu3qc5ZI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aE65+XGe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15CB8C2BC9E;
	Thu,  5 Mar 2026 15:11:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772723484;
	bh=zOdr1n6Jvz+TdEIy9dtxHrixte9Xb/aw7TNi7HLDY5M=;
	h=From:To:Cc:Subject:Date:From;
	b=aE65+XGe4aMRdAvmD6xP10W/WVVQI53n8uRWKD8SVa1qj+kQodW3/cweOSSQ+NS1T
	 619wOIN91RAtL0d/OU3fQlw+jJQBB9DLpx28+t5TXE/hgF2VC5kpE6ewsbbfhuPh3t
	 eAkgnaznEre3Xe1USKiH7LbaymYGoAW7Qma/7sbDStHwVpvd4AsdAWXI8/Z7c48VrI
	 eJymc3/V6Qy9DgFwUooJ/B7XOn3R0D2kvD6g/k+zpWPPF0hmwaIGXVMvzeMsPGmtok
	 15bcieuBGm90gnJeAbaIHOz5RbvZk4zYx8/JukZkpVXlPq45mhUDKHf7UpSe1/dEJm
	 9NcE/756jGkRw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	gregkh@linuxfoundation.org
Subject: Linux 6.6.129
Date: Thu,  5 Mar 2026 10:11:21 -0500
Message-ID: <20260305151122.672890-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E1ECE214689
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-223220-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA512

I'm announcing the release of the 6.6.129 kernel.

Only upgrade if you've observed a build failure with 6.6.128.

The updated 6.6.y git tree can be found at:
        git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
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
      Linux 6.6.129

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE4n5dijQDou9mhzu83qZv95d3LNwFAmmpnQoACgkQ3qZv95d3
LNyuCg//WOFOI05F7Vu/1IbCnSgCxv3YzZf33YYT6K8DhnXw3UgK2zhxsDbwoXWe
w++m5/AE1G8q8YD99+ANYW+3otF88y2warCBmpmZoC//MYBlCPLMQZbMt8yH0+/r
6TZnWNKTba8C8TFWHThPidmJe+7uYd8t7lnAaIOYmDFDJt+xPaJeTZGYXTQxaU20
yZh5sZd/Lxp/oAtP9V+kcUe74ZR2cEVtQJd/Nk/Bt1cXZojzwFwQa8QdQVA/cpId
vUMrZIA1NV/zjuZQ46/GxEFxYBoEHnzahKApgEHd/4/WneQHmgjz+Rw5a1QHQ0zy
jOx58afAHzQBDFZjsCXUl3/T66JYIMPTcWu93onGsgrDFoFL801pYHNJtC8TmF6D
qFDoTU/Vh8pIE6F9ohasgx6+K0DB6F6VyczngJenR9gz/pV1BpYdQaDQOAAsTwBs
SuYFx1AMdjx3Al1CR3KQkiSh+/OViCE/5GwlE51kERVPoc43q3AiMeqBfTJJW4fK
pVO/0ZjZows6MnKXyjBOz85BV3/yefMnc2nSBE05QwnUp8aBFOkoP1nQVcl/8Tx4
5wAjG9zm8VxMN+b3uqGD3gP5b3FbiTLecl54cpVFQ21uX089g2hEVqOw7R+Zu1zv
w5UlbRvkae+jGw9y8jRZVTWJtS5hIUv5NzqW4X3aPePme0szluM=
=/5a/
-----END PGP SIGNATURE-----

