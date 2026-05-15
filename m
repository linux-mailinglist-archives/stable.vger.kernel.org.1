Return-Path: <stable+bounces-247760-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKizIAAkB2oEsQIAu9opvQ
	(envelope-from <stable+bounces-247760-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:47:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id BF7E5550B90
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:47:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E23DC30EDF6E
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:05:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98F7130CD9E;
	Fri, 15 May 2026 13:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ssobvHlw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 435013019D8;
	Fri, 15 May 2026 13:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850330; cv=none; b=G3tSFvm7ZLrnk+mWDS9L+eHB1sZnfM9Ymw7thbziGn6qT/cj1QVRCLsm0FAD5CQ875A1kPBxX0pff8EOim8wGCUybCmyvntCOgOSKCZrl7ULgHsyP+EOAHn9RI/C4WCImAZB5d3khknFuzf6e75xKdRqD+yRljfaCRAdfSXJc5U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850330; c=relaxed/simple;
	bh=R9hBd37wfwOnoVgyRyZxK3p6S3W7DKX4+p6+kxfTgQM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=suR4pspTnVoGoIoDVkg9xb9A7mCal6YDdVm4ErrYqLTeRaHUqjph6gXMwXLr3+cRUX/XoMJJDy99/K54uoh5ENn6bkoNip/c3hVfRkj+J+mMcD1YI9CbEMB/pRwsTDZ6co6nlGjXacTdGbk3i58C6eUuwS0q1Pc8udW8C0NRjVo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ssobvHlw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 726BBC2BCB0;
	Fri, 15 May 2026 13:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850329;
	bh=R9hBd37wfwOnoVgyRyZxK3p6S3W7DKX4+p6+kxfTgQM=;
	h=From:To:Cc:Subject:Date:From;
	b=ssobvHlwhln+jl4wNIM3zsTA3u23fNgxune0n0aYcQeVeBUrH5cTFL94GRvy4rpx7
	 p8RWvXIZchKFFMZXOCwv9utyvRpKmpnm52HJnyn6onh1tTrL9SdvQL8BYjJWz65cNW
	 0Eqv8wjPglitbte6bbhz1Lrx56HJa5nnRWMJh++4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.10.256
Date: Fri, 15 May 2026 15:05:32 +0200
Message-ID: <2026051533-feast-promenade-7d8e@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: BF7E5550B90
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-247760-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.967];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

I'm announcing the release of the 5.10.256 kernel.

All users of the 5.10 kernel series must upgrade.

The updated 5.10.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.10.y
and can be browsed at the normal kernel.org git web browser:
	https://git.kernel.org/?p=linux/kernel/git/stable/linux-stable.git;a=summary

thanks,

greg k-h

------------

 Makefile                                 |    2 
 arch/x86/include/asm/cpufeatures.h       |    6 +-
 arch/x86/include/asm/msr-index.h         |    1 
 arch/x86/kernel/cpu/amd.c                |   88 +++++++++++++++++++++++++++----
 include/linux/sched.h                    |    3 +
 kernel/exit.c                            |    1 
 kernel/ptrace.c                          |   22 +++++--
 tools/arch/x86/include/asm/cpufeatures.h |    2 
 tools/arch/x86/include/asm/msr-index.h   |    3 +
 9 files changed, 110 insertions(+), 18 deletions(-)

Borislav Petkov (AMD) (4):
      x86/CPU/AMD: Add ZenX generations flags
      x86/CPU/AMD: Call the spectral chicken in the Zen2 init function
      x86/CPU/AMD: Rename init_amd_zn() to init_amd_zen_common()
      x86/CPU/AMD: Add X86_FEATURE_ZEN1

Greg Kroah-Hartman (1):
      Linux 5.10.256

Linus Torvalds (1):
      ptrace: slightly saner 'get_dumpable()' logic

Prathyushi Nangia (1):
      x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2's op cache


