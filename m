Return-Path: <stable+bounces-247766-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKb/KN0aB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247766-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:08:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DA1A550360
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:08:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id ED2E3302FA43
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:06:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AF9F3264EA;
	Fri, 15 May 2026 13:05:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hJDSfD7I"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9279531E822;
	Fri, 15 May 2026 13:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850352; cv=none; b=tLO4lSEr3OtqA85H+YOpPVasdr+O2vbP+35wM+KNfN9FVi8q/QR7ON7ZMO5v/tLuWHXTvpj0WRuIOtH53R/oK0G30EA2VQqeGhTCn1jw30IzUjAkVF3w6jS+SkQPPVxlGX1WhF0x5gGpePD8sqWEvnDIQj+OMIcmJBrSA9V5gGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850352; c=relaxed/simple;
	bh=jf1jMCPO1t9qrX+IWTxo2U3+bb+D9qKolkG3PfYtA/w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=L9ZKUsAswZVx5wZC08PYvll/x1QdAjMEHFPdHH0xZsp9NyogJRITm3Us3ncfCU1W+hYdq3aiBw7DWGqquP/L638s1RM0dvHeoQh8YsrfG1Nd4bfeGyKDgN52eLvmKcQjwy4MCbRTVdg8qpOR2o09b8c/K3uFEC0Bf77rAVjtFb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hJDSfD7I; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8AEEFC2BCB0;
	Fri, 15 May 2026 13:05:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850351;
	bh=jf1jMCPO1t9qrX+IWTxo2U3+bb+D9qKolkG3PfYtA/w=;
	h=From:To:Cc:Subject:Date:From;
	b=hJDSfD7ISL4lGFSL0pDqo5KFH0YhyO9NE6DS/JLpc7ipCc9uGGv8cALgJ7oizv+F5
	 axU60vH1Rt9YGxKOoRTsItc0eInLNBEAjt8NniZ0Ks5a6K/ZxEx/fBOBCRI0ISEYc7
	 qIx+l+qjOYPSWG0OsApo7ANxSdnBO4gBGn8mNPmo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.6.139
Date: Fri, 15 May 2026 15:05:52 +0200
Message-ID: <2026051552-hypnotism-unwarlike-7452@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7DA1A550360
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247766-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.966];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

I'm announcing the release of the 6.6.139 kernel.

All users of the 6.6 kernel series must upgrade.

The updated 6.6.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.6.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                               |    2 +-
 arch/x86/include/asm/msr-index.h       |    1 +
 arch/x86/kernel/cpu/amd.c              |    3 +++
 include/linux/sched.h                  |    3 +++
 kernel/exit.c                          |    1 +
 kernel/ptrace.c                        |   22 ++++++++++++++++------
 tools/arch/x86/include/asm/msr-index.h |    3 +++
 7 files changed, 28 insertions(+), 7 deletions(-)

Greg Kroah-Hartman (1):
      Linux 6.6.139

Linus Torvalds (1):
      ptrace: slightly saner 'get_dumpable()' logic

Prathyushi Nangia (1):
      x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2's op cache


