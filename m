Return-Path: <stable+bounces-240871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qBnmL/R062kQNAAAu9opvQ
	(envelope-from <stable+bounces-240871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:49:40 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 62DDA45FB66
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 15:49:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1C6E2302C907
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:40:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 429913D5236;
	Fri, 24 Apr 2026 13:40:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="2WgvMLzR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06BD53290A5;
	Fri, 24 Apr 2026 13:40:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777038056; cv=none; b=eEFWqBX9HUQ62BEhTR4swu4JVbjSg53LKJuEgEBM1gPABEaUhA2UC4mBf403jmY+yf6FFtb3i5q9IvdO+P9C6fCxamvxq+od/rtyzbvZrpZ/nc/Au4w0nW1aZuFFTrlvztOW1gHsDQKc3NJI8HGHfqp63ZkAdnkPi2hTrgT5QQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777038056; c=relaxed/simple;
	bh=5ziXFRuq4KWUoBfixT5OEjRUhIeHiRv5OYOoiZBYdWU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FbEPjfUJjMdKioBVweXNFjnZYtffYUrzIu/kpNrK0D7+exjqT1vsjJ7wZcZuvuZk+2EHmEPJPa54WE9Dw1o2G6dfDS8nyYZcQWYGuQL4tER1uBDdRquENvGg/rKqgLok2lwE4wr+utjYq5ZQx8yXV5Lpy9i4zfW0u9fWom6f/7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=2WgvMLzR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56F18C19425;
	Fri, 24 Apr 2026 13:40:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777038055;
	bh=5ziXFRuq4KWUoBfixT5OEjRUhIeHiRv5OYOoiZBYdWU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=2WgvMLzRV+PuAJbAT/G4KO6ktujjMi36sWuoaqjr6VflJ+HuChoki5MVGh/Ja2QAH
	 msKB24CbzD1M6PfnZoPTn6m0IkYkITqPHcgKvHOzvTp6s0/hLzEHmjS7D4zj/fhYFF
	 o+HRTYFfiPCV3RgLiI7uaoGfFW+Y4Niv02UtWE4Y=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Alexander Potapenko <glider@google.com>,
	Sebastian Alba Vives <sebasjosue84@gmail.com>,
	Sean Christopherson <seanjc@google.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.6 162/166] crypto: ccp: Dont attempt to copy CSR to userspace if PSP command failed
Date: Fri, 24 Apr 2026 15:31:16 +0200
Message-ID: <20260424132606.936761393@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424132532.812258529@linuxfoundation.org>
References: <20260424132532.812258529@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 62DDA45FB66
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,google.com,gmail.com,gondor.apana.org.au];
	TAGGED_FROM(0.00)[bounces-240871-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,apana.org.au:email,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sean Christopherson <seanjc@google.com>

commit abe4a6d6f606113251868c2c4a06ba904bb41eed upstream.

When retrieving the PEK CSR, don't attempt to copy the blob to userspace
if the firmware command failed.  If the failure was due to an invalid
length, i.e. the userspace buffer+length was too small, copying the number
of bytes _firmware_ requires will overflow the kernel-allocated buffer and
leak data to userspace.

  BUG: KASAN: slab-out-of-bounds in instrument_copy_to_user ../include/linux/instrumented.h:129 [inline]
  BUG: KASAN: slab-out-of-bounds in _inline_copy_to_user ../include/linux/uaccess.h:205 [inline]
  BUG: KASAN: slab-out-of-bounds in _copy_to_user+0x66/0xa0 ../lib/usercopy.c:26
  Read of size 2084 at addr ffff898144612e20 by task syz.9.219/21405

  CPU: 14 UID: 0 PID: 21405 Comm: syz.9.219 Tainted: G     U     O        7.0.0-smp-DEV #28 PREEMPTLAZY
  Tainted: [U]=USER, [O]=OOT_MODULE
  Hardware name: Google, Inc. Arcadia_IT_80/Arcadia_IT_80, BIOS 12.62.0-0 11/19/2025
  Call Trace:
   <TASK>
   dump_stack_lvl+0xc5/0x110 ../lib/dump_stack.c:120
   print_address_description ../mm/kasan/report.c:378 [inline]
   print_report+0xbc/0x260 ../mm/kasan/report.c:482
   kasan_report+0xa2/0xe0 ../mm/kasan/report.c:595
   check_region_inline ../mm/kasan/generic.c:-1 [inline]
   kasan_check_range+0x264/0x2c0 ../mm/kasan/generic.c:200
   instrument_copy_to_user ../include/linux/instrumented.h:129 [inline]
   _inline_copy_to_user ../include/linux/uaccess.h:205 [inline]
   _copy_to_user+0x66/0xa0 ../lib/usercopy.c:26
   copy_to_user ../include/linux/uaccess.h:236 [inline]
   sev_ioctl_do_pek_csr+0x31f/0x590 ../drivers/crypto/ccp/sev-dev.c:1872
   sev_ioctl+0x3a4/0x490 ../drivers/crypto/ccp/sev-dev.c:2562
   vfs_ioctl ../fs/ioctl.c:51 [inline]
   __do_sys_ioctl ../fs/ioctl.c:597 [inline]
   __se_sys_ioctl+0x11d/0x1b0 ../fs/ioctl.c:583
   do_syscall_x64 ../arch/x86/entry/syscall_64.c:63 [inline]
   do_syscall_64+0xe0/0x800 ../arch/x86/entry/syscall_64.c:94
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
   </TASK>

WARN if the driver says the command succeeded, but the firmware error code
says otherwise, as __sev_do_cmd_locked() is expected to return -EIO on any
firwmware error.

Reported-by: Alexander Potapenko <glider@google.com>
Reported-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
Fixes: e799035609e1 ("crypto: ccp: Implement SEV_PEK_CSR ioctl command")
Cc: stable@vger.kernel.org
Signed-off-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/ccp/sev-dev.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

--- a/drivers/crypto/ccp/sev-dev.c
+++ b/drivers/crypto/ccp/sev-dev.c
@@ -674,7 +674,10 @@ cmd:
 
 	ret = __sev_do_cmd_locked(SEV_CMD_PEK_CSR, &data, &argp->error);
 
-	 /* If we query the CSR length, FW responded with expected data. */
+	/*
+	 * Firmware will returns the length of the CSR blob (either the minimum
+	 * required length or the actual length written), return it to the user.
+	 */
 	input.length = data.len;
 
 	if (copy_to_user((void __user *)argp->data, &input, sizeof(input))) {
@@ -682,6 +685,9 @@ cmd:
 		goto e_free_blob;
 	}
 
+	if (ret || WARN_ON_ONCE(argp->error))
+		goto e_free_blob;
+
 	if (blob) {
 		if (copy_to_user(input_address, blob, input.length))
 			ret = -EFAULT;



