Return-Path: <stable+bounces-246449-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yJpfEBNwA2p15wEAu9opvQ
	(envelope-from <stable+bounces-246449-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:23:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 70A4652777A
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:23:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 70FBE3236F3B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:07:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3947342509;
	Tue, 12 May 2026 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VxP9BQpc"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B56D03EDE45;
	Tue, 12 May 2026 18:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778609256; cv=none; b=HxQz6lEjo4rWw0apLs534LxmYxsXUzZmBPm9ST7yTu6BMNoxXSVF0Kw/hbaFtmRd5F6fgRqDmOB+92eYOjWojwoSt1g+v52jIAsSk1SWHHG1oKiGfT++C8jTOTUFTG6BTGi23WDAuzj341jwtAnkQhS+IBJgk7HnGtSAlMJmuQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778609256; c=relaxed/simple;
	bh=C+v71hdQin6KItS7BeYdVxPUNM7TSpUBh0j/RQdRjrg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cB7x1N9g/EQgrmBjcHwzmQvm9eJQyw3+UBzbYVZyRLHelLEzYgIhHkRmRqDKn99NgCH8HzzNF74tLBbVolZEmb+bm7AR8rg7BGUbS6pZ8ZoZYGTbVbErLT0tZ007TgbM6+IdEpKqsDpaQ0geucsVSojCcOmQNkfA+1PAu0mtphU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VxP9BQpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D466C2BCB0;
	Tue, 12 May 2026 18:07:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778609256;
	bh=C+v71hdQin6KItS7BeYdVxPUNM7TSpUBh0j/RQdRjrg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VxP9BQpcqDeVHI87j4xxiEBdPPRuRBxVG84amHxJ4hr9UHSb7hUHIY8XgHt5R/H/+
	 mETW9pCZPcEBlHFIqTLjkjU6UPIfoNzbH1UtIvdHpO26nUAm2ocnc0tRbDXL3TdlHD
	 EJbCiiiTMWN5/K7Wr7pErn/NYAMFwpzScTWvDlCA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ivan Hu <ivan.hu@canonical.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 7.0 126/307] x86/efi: Fix graceful fault handling after FPU softirq changes
Date: Tue, 12 May 2026 19:38:41 +0200
Message-ID: <20260512173942.788387824@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173940.117428952@linuxfoundation.org>
References: <20260512173940.117428952@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 70A4652777A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246449-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ivan Hu <ivan.hu@canonical.com>

commit 088f65e206087bf903743bd18417261d7a4c9644 upstream.

Since commit d02198550423 ("x86/fpu: Improve crypto performance by
making kernel-mode FPU reliably usable in softirqs"), kernel_fpu_begin()
calls fpregs_lock() which uses local_bh_disable() instead of the
previous preempt_disable(). This sets SOFTIRQ_OFFSET in preempt_count
during the entire EFI runtime service call, causing in_interrupt() to
return true in normal task context.

The graceful page fault handler efi_crash_gracefully_on_page_fault()
uses in_interrupt() to bail out for faults in real interrupt context.
With SOFTIRQ_OFFSET now set, the handler always bails out, leaving EFI
firmware page faults unhandled. This escalates to die() which also sees
in_interrupt() as true and calls panic("Fatal exception in interrupt"),
resulting in a hard system freeze. On systems with buggy firmware that
triggers page faults during EFI runtime calls (e.g., accessing unmapped
memory in GetTime()), this causes an unrecoverable hang instead of the
expected graceful EFI_ABORTED recovery.

Fix by replacing in_interrupt() with !in_task(). This preserves the
original intent of bailing for interrupts or NMI faults, while no longer
falsely triggering from the FPU code path's local_bh_disable().

Fixes: d02198550423 ("x86/fpu: Improve crypto performance by making kernel-mode FPU reliably usable in softirqs")
Cc: <stable@vger.kernel.org>
Signed-off-by: Ivan Hu <ivan.hu@canonical.com>
[ardb: Sashiko spotted that using 'in_hardirq() || in_nmi()' leaves a
       window where a softirq may be taken before fpregs_lock() is
       called, but after efi_rts_work.efi_rts_id has been assigned,
       and any page faults occurring in that window will then be
       misidentified as having been caused by the firmware. Instead,
       use !in_task(), which incorporates in_serving_softirq(). ]
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/platform/efi/quirks.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/x86/platform/efi/quirks.c
+++ b/arch/x86/platform/efi/quirks.c
@@ -771,7 +771,7 @@ void efi_crash_gracefully_on_page_fault(
 	 * If we get an interrupt/NMI while processing an EFI runtime service
 	 * then this is a regular OOPS, not an EFI failure.
 	 */
-	if (in_interrupt())
+	if (!in_task())
 		return;
 
 	/*



