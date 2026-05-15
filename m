Return-Path: <stable+bounces-247762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAIMM2saB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:06:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 616815502DA
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:06:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1D5F03019E58
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:06:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35D1730FF20;
	Fri, 15 May 2026 13:05:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ZS6fpqgl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC46F30F95C;
	Fri, 15 May 2026 13:05:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850339; cv=none; b=kVZ94q9cmxH4i71aZUtZiM8eNf6nFhqd+Ysv8HKWgZjS3XtUH4ldyy4u+BxeDzddAlf4Z3eyKu6tixpWkyzy0UNdwF0iEbbbMFE52Tqs3xlcdLA8Qvsgd0tU/oq68BwmC8ZGHNvIyWZWEPc74BbZNIdv9OZobuWOZYmDbM8/sD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850339; c=relaxed/simple;
	bh=dY4fUgD99oMXO7QdB8T63AZ8RIYaCPziuccFrf0v4jM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NQ1WOeRCJKlSCtv7Z0BI2vGLBFUwF19q/2zveJsOV2MFyqg5PsM9Q3prj+lk4KBMRmiw8XJ6ywahhAQETRzq2yiT8oPhViGVIvFc4mlf+j3hBf6ooK6+pG4Wl5hhHmwwksShHGfWae+AZF0lPJBVLXzZFA2366EbBflmeL/pwkE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ZS6fpqgl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DEEBC2BCF5;
	Fri, 15 May 2026 13:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850338;
	bh=dY4fUgD99oMXO7QdB8T63AZ8RIYaCPziuccFrf0v4jM=;
	h=From:To:Cc:Subject:Date:From;
	b=ZS6fpqgl6ISkrokeTCSXST6Btz+Pj0butizoaLRwEIMbk2yYYN8WZhX3kqVtH1X5I
	 /euPpLxGCps+qts8vIPaMZwZHn1ngQfWG6182pVZrxGlJgUL+/zrx1cNS/a8E+B1xI
	 BiJeE+JzZjYVTVOsCjiUyAL6xjlSFCJFLyKQr5Lw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 5.15.207
Date: Fri, 15 May 2026 15:05:38 +0200
Message-ID: <2026051539-defiling-pesky-95a5@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 616815502DA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247762-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.968];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

I'm announcing the release of the 5.15.207 kernel.

All users of the 5.15 kernel series must upgrade.

The updated 5.15.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-5.15.y
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
      Linux 5.15.207

Linus Torvalds (1):
      ptrace: slightly saner 'get_dumpable()' logic

Prathyushi Nangia (1):
      x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2's op cache


