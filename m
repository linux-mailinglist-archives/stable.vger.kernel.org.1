Return-Path: <stable+bounces-242069-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kGtiLoAm82mZxgEAu9opvQ
	(envelope-from <stable+bounces-242069-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:53:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53EED4A03C1
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:53:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E6F35300FCE4
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:44:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E25C3FB074;
	Thu, 30 Apr 2026 09:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YSRWnOme"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E49A03D8138;
	Thu, 30 Apr 2026 09:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542260; cv=none; b=Wf+MK2ykaxdeIfr8Y1YYUSofRrL+SEYknM9LXzSa7YqqQkA9WqaokYSc2XsG+2/c9ZZnW7qfD0Wqo2AvGd9x7pOCa9F7/u3/puAR2tNUZS+hKvH+vSh10FJaCeIV4w4izNeX61bJFAByUYjVlhLgW3q/RN5FEY8GsMt6ai5K00c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542260; c=relaxed/simple;
	bh=snq2zSvzgYGAx+4fdNNLP5fCUDjvTjjSDgTZ/ItXNLs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=c9fJ1A9eg6KDALSoSJr6rm8Q+73wQajm2Q++gc5oZOQcDdL0QTC+jhwFckS72tPVc8lZ59T/DTAIe6tMq9W3kGDie9+f835vLEcnt05T8PUOde+/rfGh/oGMDUHIfbQmcUxkMN16phdoh94miJqYnfCsgXsiY+KcJYGt9+J5Y14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YSRWnOme; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 326E1C2BCB3;
	Thu, 30 Apr 2026 09:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777542259;
	bh=snq2zSvzgYGAx+4fdNNLP5fCUDjvTjjSDgTZ/ItXNLs=;
	h=From:To:Cc:Subject:Date:From;
	b=YSRWnOmeY+OYvJtEDGCCeQbmzVegvCP6Rn6vYMKSD2LoOr7jEyyGJ/SU22MWlnbXh
	 zPsCZvWtyQkOb/LYGViVzPT0ZsqFX+mONJ5EwAVIGIBOQMGJfBqVIX6VtfKT6JWRpi
	 nw+H7TQCTnX0uWG2Y8yogB9nYaIL7Pmv1N3LrlRE=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.137
Date: Thu, 30 Apr 2026 11:43:27 +0200
Message-ID: <2026043028-oblivious-strung-8658@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 53EED4A03C1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242069-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MAILSPIKE_FAIL(0.00)[104.64.211.4:server fail];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim]

I'm announcing the release of the 6.6.137 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                     |    2 
 crypto/Kconfig               |    2 
 crypto/af_alg.c              |   51 ++--------
 crypto/algif_aead.c          |  203 ++++++++-----------------------------------
 crypto/algif_skcipher.c      |    6 -
 crypto/authenc.c             |   32 ------
 crypto/authencesn.c          |   84 ++++++-----------
 crypto/scatterwalk.c         |   94 +++++++++++++++++++
 drivers/xen/privcmd.c        |    7 +
 drivers/xen/sys-hypervisor.c |    8 +
 include/crypto/if_alg.h      |    5 -
 include/crypto/scatterwalk.h |   31 ++++++
 12 files changed, 229 insertions(+), 296 deletions(-)

Douya Le (1):
      crypto: algif_aead - snapshot IV for async AEAD requests

Eric Biggers (3):
      crypto: scatterwalk - Backport memcpy_sglist()
      crypto: algif_aead - use memcpy_sglist() instead of null skcipher
      crypto: authenc - use memcpy_sglist() instead of null skcipher

Greg Kroah-Hartman (1):
      Linux 6.6.137

Herbert Xu (4):
      crypto: algif_aead - Revert to operating out-of-place
      crypto: authencesn - Do not place hiseq at end of dst for out-of-place decryption
      crypto: authencesn - Fix src offset when decrypting in-place
      crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl

Juergen Gross (2):
      xen/privcmd: fix double free via VMA splitting
      Buffer overflow in drivers/xen/sys-hypervisor.c


