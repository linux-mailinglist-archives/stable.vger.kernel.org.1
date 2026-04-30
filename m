Return-Path: <stable+bounces-242070-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CB2FEwl82lFxgEAu9opvQ
	(envelope-from <stable+bounces-242070-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:47:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CD5E14A028D
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 11:47:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6746B30338A7
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 09:44:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BE963A7F70;
	Thu, 30 Apr 2026 09:44:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VAXGIBTq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E00F3A7828;
	Thu, 30 Apr 2026 09:44:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777542264; cv=none; b=GiZeDZWRkAdR9Z7lzLw2Jb14rJm1SpkHzdfMe4LVul0Qown9LxYRh+ZKjPcd3Hp3uN+5nSnNd3ns86QjYQ0lpo5s9Old5Saboeon6eCL4LnexegX7vpmraSGK6OzOc98X5vqIRAuxAndkrPl9G6OCNmub+4Km00PndhRqy0f7AU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777542264; c=relaxed/simple;
	bh=lXwsPC/TJRKnaOX5gB0Qhro+457hdZ8htLlfMqRU7+A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kUbeTHbHNUjYLRqErj5EeN8h0yN73mZSSbqbY9qt5+n3ZrmZK1/dFLLIepFYYivTukAC8zR3LWUC7QYXL3Z0ye54Tha3ugxeTNvOLTvSqnO+CkOjHx0tr4ePpXCOyouV8E/ln4emNcMfzuU7zgU7c80a2ySq9EwufGQIr7MkVIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VAXGIBTq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6ABBAC2BCB4;
	Thu, 30 Apr 2026 09:44:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777542263;
	bh=lXwsPC/TJRKnaOX5gB0Qhro+457hdZ8htLlfMqRU7+A=;
	h=From:To:Cc:Subject:Date:From;
	b=VAXGIBTqTUSIQ+Qo/yE6j2/v2A6ps8FqRROGuHG4+RhiuBGKlsZ2pk6ujCixSsOFl
	 qJLuvmwBYp6hpfQmHtSdPxnpuHiRAzmXLLX7+13ZLb3Mz2tIpwvKj9yRgP7+LoUl5b
	 iKOHDihXtLVprFkvP2q8bg9oRofYgzOCOV/5LUQM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.12.85
Date: Thu, 30 Apr 2026 11:43:42 +0200
Message-ID: <2026043043-thermos-remodeler-5481@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD5E14A028D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242070-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.970];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

I'm announcing the release of the 6.12.85 kernel.

All users of the 6.12 kernel series must upgrade.

The updated 6.12.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.12.y
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
      Linux 6.12.85

Herbert Xu (4):
      crypto: algif_aead - Revert to operating out-of-place
      crypto: authencesn - Do not place hiseq at end of dst for out-of-place decryption
      crypto: authencesn - Fix src offset when decrypting in-place
      crypto: af_alg - Fix page reassignment overflow in af_alg_pull_tsgl

Juergen Gross (2):
      xen/privcmd: fix double free via VMA splitting
      Buffer overflow in drivers/xen/sys-hypervisor.c


