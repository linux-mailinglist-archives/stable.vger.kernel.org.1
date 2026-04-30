Return-Path: <stable+bounces-242062-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id rEuxGVck82kkxgEAu9opvQ
	(envelope-from <stable+bounces-242062-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:43:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BEA1A4A00B2
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 315373015D2D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 081EE3A6403;
	Thu, 30 Apr 2026 09:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oBPG/UtK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B178B3A1D07;
	Thu, 30 Apr 2026 09:43:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542225; cv=none; b=ILtd9U4wO0y/E63E500iccQABOsHqMAcA9txaXPufnlGhdUoNxAZ2DrcqVU/svIg+wG5aAUFnQkvGi63i8MNJtb5+jKYM+aKuFdLTrCEAn0zg2q4oeBvuKhnc/LqLEPuU8W+qJB1MpX4wD3ZuTwhdw3cb4c2jTy79BK9zll6GZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542225; c=relaxed/simple;
	bh=a6zyo1N5ot/m1ZANSgPay9u6WQZWgy3B2Eij1w5aZrg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lceNB8Y/V6qBPk7JMCzipUw3/Zl7d0YiXXfPf9ziK2uvR5UOQ0dGsqH703by8/Zrl+ZlWKtKkO3lNuvpeKGlnDg5eVvHex4YadzP1rx8IB9IPH4gCEMy8sDO3D/QbCvb/TnINVUqdQvr+5h6hS4i9JwSjFnNAUMPadPZkcGDzq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oBPG/UtK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 300D1C2BCB3;
	Thu, 30 Apr 2026 09:43:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777542225;
	bh=a6zyo1N5ot/m1ZANSgPay9u6WQZWgy3B2Eij1w5aZrg=;
	h=From:To:Cc:Subject:Date:From;
	b=oBPG/UtKey/SSBG01I0lBrFKAfLlXK8DDFF9l0eUA2Z0FK0imxXfr4i7mRLzJ9xli
	 2ZYsByOQfxeL8dKkg+0FlUcr3pvHTpW1cJrbr1v0/oBk25sqOaIQCOqxj2C2dOfZmI
	 S3i2cjxoJULjsOCesuR4HykV9d9Qs0zLhX48YbqA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.254
Date: Thu, 30 Apr 2026 11:43:02 +0200
Message-ID: <2026043003-enlisted-driven-a63f@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BEA1A4A00B2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242062-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.959];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

I'm announcing the release of the 5.10.254 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                     |    2 
 crypto/Kconfig               |    2 
 crypto/af_alg.c              |  137 ++++++++++++-----------------
 crypto/algif_aead.c          |  203 ++++++++-----------------------------------
 crypto/algif_skcipher.c      |    6 -
 crypto/authenc.c             |   32 ------
 crypto/authencesn.c          |   84 ++++++-----------
 crypto/scatterwalk.c         |   98 ++++++++++++++++++++
 drivers/xen/privcmd.c        |    7 +
 drivers/xen/sys-hypervisor.c |    8 +
 include/crypto/if_alg.h      |    5 -
 include/crypto/scatterwalk.h |   32 ++++++
 lib/crypto/chacha.c          |    4 
 13 files changed, 286 insertions(+), 334 deletions(-)

Douya Le (1):
      crypto: algif_aead - snapshot IV for async AEAD requests

Eric Biggers (3):
      crypto: scatterwalk - Backport memcpy_sglist()
      crypto: algif_aead - use memcpy_sglist() instead of null skcipher
      crypto: authenc - use memcpy_sglist() instead of null skcipher

Greg Kroah-Hartman (1):
      Linux 5.10.254

Herbert Xu (5):
      crypto: algif_aead - Revert to operating out-of-place
      crypto: authencesn - Do not place hiseq at end of dst for out-of-place decryption
      crypto: authencesn - Fix src offset when decrypting in-place
      crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl
      crypto: algif_aead - Fix minimum RX size check for decryption

Juergen Gross (2):
      xen/privcmd: fix double free via VMA splitting
      Buffer overflow in drivers/xen/sys-hypervisor.c

Randy Dunlap (1):
      crypto: doc - fix kernel-doc notation in chacha.c and af_alg.c


