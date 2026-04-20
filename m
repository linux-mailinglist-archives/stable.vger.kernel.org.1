Return-Path: <stable+bounces-239916-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPs4OupR5mlduwEAu9opvQ
	(envelope-from <stable+bounces-239916-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:18:50 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A680F42F4D0
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 18:18:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 47B4A30508A9
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 16:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73A38344D8C;
	Mon, 20 Apr 2026 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="c8/5WXE+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3597634107F;
	Mon, 20 Apr 2026 16:12:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776701542; cv=none; b=QjUj7O4UU/PKqYmQLF1NWUGutpomd0Y2uzZouBetkFVPZ0pFdewDY9aGWcjEWzbarF+Tj4tf8RJnevxNKo4rYQLcCYV/TO6GF6WpXk+k4V45wNg17e3BYdimwPe/wfdS9jPnBrBunwJVdSPCrRlgprlwoWQuKSzR6hWhzq5jvkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776701542; c=relaxed/simple;
	bh=sk906yPYLxa6JuPRnJ4CT5tTgU0FqyNldH/k6hxXFkA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zfz8CgYg6l6CfoLn6t/5s+W4n+gA+s4r210UoP/Xacskw42RRIdbCpP4EUlCmkBJhXRPVx8gkGFrCwi/VAEWnNFR3OP/GYVpGRJF3kV6LKO/G06CA82FHRnBOEeHsXTOomLo1RwluahlqtmixEnu7bZ74n8Sulj5ebKZy8uN0M4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=c8/5WXE+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1622C19425;
	Mon, 20 Apr 2026 16:12:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776701542;
	bh=sk906yPYLxa6JuPRnJ4CT5tTgU0FqyNldH/k6hxXFkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=c8/5WXE+R8QmT9jmQPe+VG87errv9KnrbaTJ7fxcvc/eueSLCOTaTWjPJAXnuANvB
	 6vJXyj2tRfoLI0Um5meXkJmKLqvYzbc52mdatTqLbn0X7nL/IdSXcIskEtpzUlrSXi
	 +4sDHN30VoPzDS1Qhjg69uKM6slob7hKhVXOp87k=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Harin Lee <me@harin.net>,
	Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.12 122/162] ALSA: ctxfi: Limit PTP to a single page
Date: Mon, 20 Apr 2026 17:42:34 +0200
Message-ID: <20260420153931.461101896@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420153927.006696811@linuxfoundation.org>
References: <20260420153927.006696811@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-239916-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[harin.net:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,suse.de:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A680F42F4D0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Harin Lee <me@harin.net>

commit e9418da50d9e5c496c22fe392e4ad74c038a94eb upstream.

Commit 391e69143d0a increased CT_PTP_NUM from 1 to 4 to support 256
playback streams, but the additional pages are not used by the card
correctly. The CT20K2 hardware already has multiple VMEM_PTPAL
registers, but using them separately would require refactoring the
entire virtual memory allocation logic.

ct_vm_map() always uses PTEs in vm->ptp[0].area regardless of
CT_PTP_NUM. On AMD64 systems, a single PTP covers 512 PTEs (2M). When
aggregate memory allocations exceed this limit, ct_vm_map() tries to
access beyond the allocated space and causes a page fault:

  BUG: unable to handle page fault for address: ffffd4ae8a10a000
  Oops: Oops: 0002 [#1] SMP PTI
  RIP: 0010:ct_vm_map+0x17c/0x280 [snd_ctxfi]
  Call Trace:
  atc_pcm_playback_prepare+0x225/0x3b0
  ct_pcm_playback_prepare+0x38/0x60
  snd_pcm_do_prepare+0x2f/0x50
  snd_pcm_action_single+0x36/0x90
  snd_pcm_action_nonatomic+0xbf/0xd0
  snd_pcm_ioctl+0x28/0x40
  __x64_sys_ioctl+0x97/0xe0
  do_syscall_64+0x81/0x610
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

Revert CT_PTP_NUM to 1. The 256 SRC_RESOURCE_NUM and playback_count
remain unchanged.

Fixes: 391e69143d0a ("ALSA: ctxfi: Bump playback substreams to 256")
Cc: stable@vger.kernel.org
Signed-off-by: Harin Lee <me@harin.net>
Link: https://patch.msgid.link/20260406074857.216034-1-me@harin.net
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/ctxfi/ctvmem.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/pci/ctxfi/ctvmem.h
+++ b/sound/pci/ctxfi/ctvmem.h
@@ -15,7 +15,7 @@
 #ifndef CTVMEM_H
 #define CTVMEM_H
 
-#define CT_PTP_NUM	4	/* num of device page table pages */
+#define CT_PTP_NUM	1	/* num of device page table pages */
 
 #include <linux/mutex.h>
 #include <linux/list.h>



