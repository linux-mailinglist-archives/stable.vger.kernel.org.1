Return-Path: <stable+bounces-247764-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UDBQFqkaB2rnrgIAu9opvQ
	(envelope-from <stable+bounces-247764-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:07:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E54E0550316
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 15:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E9074301064D
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 13:06:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4A8C31714B;
	Fri, 15 May 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ugCZh2jS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673F6318BA6;
	Fri, 15 May 2026 13:05:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778850345; cv=none; b=FCWYeLo/sYEL6RfGygkmwtvqFur+YZif6cR65KdlZsi2YBipjy7vFgRkKrp0q80pN4A8oD28Z8PH1bS/tQg1kTT7/QclhLk8IowZn5IHJxAg2KI2Pea1mxPj0lcVmJTJrXgkOuV0/flOw7ooloJQCQTBssn8iU1en2N2WuPu0Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778850345; c=relaxed/simple;
	bh=Ehai9U6gUNWjixitkrA18McrvLwqEu8d5Iyal1RCAXM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qnqYo3IAofI1gj6qtV56LwlneFo0k9X+2IL79poSGQwHLMGswsvGfMsJEPa93MNoAYzAPjldfSog/LgTtp2waH6CDf254Cmeg+XHoko/WWAx6X2ePBr5XKNz3Dhm6QXjerYmkz3vqUxvkY+0oqgv3d6kh2ZTY5a0ZOZ1q4S6nKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ugCZh2jS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDC52C2BCB0;
	Fri, 15 May 2026 13:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778850345;
	bh=Ehai9U6gUNWjixitkrA18McrvLwqEu8d5Iyal1RCAXM=;
	h=From:To:Cc:Subject:Date:From;
	b=ugCZh2jSoVUbMWqS8Uc8ig5yXobMYTn5zbCbAVIvkYrzl/46iuuhDxKtsLzj0jujM
	 NaK08f69zfZUJsGSfH6ZGe9I3gHRk0AxPHXZZKk8my/k89KI6OdK9qrL3/Yj2nw0IM
	 HwJ+ToyZzqUgfTM4T2BuTfzmbKVfcmk/rJdtyk2g=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Linux 6.1.173
Date: Fri, 15 May 2026 15:05:45 +0200
Message-ID: <2026051546-glancing-regress-8a03@gregkh>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: E54E0550316
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
	TAGGED_FROM(0.00)[bounces-247764-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-0.969];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

I'm announcing the release of the 6.1.173 kernel.

All users of the 6.1 kernel series must upgrade.

The updated 6.1.y git tree can be found at:
	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable.git linux-6.1.y
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
      Linux 6.1.173

Linus Torvalds (1):
      ptrace: slightly saner 'get_dumpable()' logic

Prathyushi Nangia (1):
      x86/CPU/AMD: Prevent improper isolation of shared resources in Zen2's op cache


