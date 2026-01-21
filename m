Return-Path: <stable+bounces-210681-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAkfEmdycGktYAAAu9opvQ
	(envelope-from <stable+bounces-210681-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:29:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id B51D35211E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:29:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 888613456D8
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 03:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACD89288D0;
	Wed, 21 Jan 2026 03:49:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="JfGw/LIj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E473064A0;
	Wed, 21 Jan 2026 03:49:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768967376; cv=none; b=O1upML8jCysNmQO96OdQtWpGQNP9mUGsjm+l99oXvsr4xTX1mrZtD1YYmkBdZNK81NP8HExPNo7bmAjxSgpzNIdA2DblP1iYM6tgptYzmH6kDfyvFc5U2HAwTfORp7oZHQciw8PmRMCIGocBcUxON3aJDg4cDrB+4t+CfJ2hEJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768967376; c=relaxed/simple;
	bh=KDqL40jpEvn1kofNO4on5/65cyTFW3AW8yICbVZ4rPA=;
	h=Date:To:From:Subject:Message-Id; b=FhpsdlKRE2K1ip4sS9cZuOys1yAjfq2V+AbEjW8r+1sqf2ioSzRSV0NyOioP5WK7Ryg9uz5SNhardjz+6n73iuWT2n+19LfiZbP7zZSz4W0et4E9q8RTZZtnxIyQjXM6vhyYcIdNyCT9WDGlgq5WoE4NVoWVVy7QrveNtlnXwLg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=JfGw/LIj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94E60C16AAE;
	Wed, 21 Jan 2026 03:49:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1768967375;
	bh=KDqL40jpEvn1kofNO4on5/65cyTFW3AW8yICbVZ4rPA=;
	h=Date:To:From:Subject:From;
	b=JfGw/LIjqJhMqaXqemivje6DFptMNGIRCOO4sV8t/ULMkpLEVB2HkWr0K2GBjgJxM
	 NBXk4Cu8bJ++hPbmSR5cn7LTuEUvP6gVbe8a0ABZzhG7khMaVn/cOpzuW0kP+oqURt
	 GPU/oy6H5hvIxm9XH58Ja8g6IkhH8pxoM5zweUBA=
Date: Tue, 20 Jan 2026 19:49:35 -0800
To: mm-commits@vger.kernel.org,zohar@linux.ibm.com,yifei.l.liu@oracle.com,tglx@linutronix.de,stable@vger.kernel.org,sourabhjain@linux.ibm.com,sohil.mehta@intel.com,rppt@kernel.org,paul.x.webb@oracle.com,noodles@fb.com,mingo@redhat.com,joel.granados@kernel.org,jbohac@suse.cz,hpa@zytor.com,henry.willard@oracle.com,guoweikang.kernel@gmail.com,graf@amazon.com,bp@alien8.de,bhe@redhat.com,ardb@kernel.org,harshit.m.mogalapalli@oracle.com,akpm@linux-foundation.org
From: Andrew Morton <akpm@linux-foundation.org>
Subject: [merged mm-nonmm-stable] x86-kexec-add-a-sanity-check-on-previous-kernels-ima-kexec-buffer.patch removed from -mm tree
Message-Id: <20260121034935.94E60C16AAE@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Spamd-Result: default: False [5.54 / 15.00];
	R_BAD_CTE_7BIT(3.50)[unknown];
	SUSPICIOUS_RECIPS(1.50)[];
	BROKEN_CONTENT_TYPE(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux-foundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[linux-foundation.org];
	GREYLIST(0.00)[pass,body];
	TAGGED_FROM(0.00)[bounces-210681-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[vger.kernel.org,linux.ibm.com,oracle.com,linutronix.de,intel.com,kernel.org,fb.com,redhat.com,suse.cz,zytor.com,gmail.com,amazon.com,alien8.de,linux-foundation.org];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[akpm@linux-foundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linux-foundation.org:+];
	TO_DN_NONE(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[22];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: B51D35211E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


The quilt patch titled
     Subject: x86/kexec: add a sanity check on previous kernel's ima kexec buffer
has been removed from the -mm tree.  Its filename was
     x86-kexec-add-a-sanity-check-on-previous-kernels-ima-kexec-buffer.patch

This patch was dropped because it was merged into the mm-nonmm-stable branch
of git://git.kernel.org/pub/scm/linux/kernel/git/akpm/mm

------------------------------------------------------
From: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: x86/kexec: add a sanity check on previous kernel's ima kexec buffer
Date: Tue, 30 Dec 2025 22:16:09 -0800

When the second-stage kernel is booted via kexec with a limiting command
line such as "mem=<size>", the physical range that contains the carried
over IMA measurement list may fall outside the truncated RAM leading to a
kernel panic.

    BUG: unable to handle page fault for address: ffff97793ff47000
    RIP: ima_restore_measurement_list+0xdc/0x45a
    #PF: error_code(0x0000) – not-present page

Other architectures already validate the range with page_is_ram(), as done
in commit cbf9c4b9617b ("of: check previous kernel's ima-kexec-buffer
against memory bounds") do a similar check on x86.

Without carrying the measurement list across kexec, the attestation
would fail.

Link: https://lkml.kernel.org/r/20251231061609.907170-4-harshit.m.mogalapalli@oracle.com
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Fixes: b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
Reported-by: Paul Webb <paul.x.webb@oracle.com>
Reviewed-by: Mimi Zohar <zohar@linux.ibm.com>
Cc: Alexander Graf <graf@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Baoquan He <bhe@redhat.com>
Cc: Borislav Betkov <bp@alien8.de>
Cc: guoweikang <guoweikang.kernel@gmail.com>
Cc: Henry Willard <henry.willard@oracle.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Jiri Bohac <jbohac@suse.cz>
Cc: Joel Granados <joel.granados@kernel.org>
Cc: Jonathan McDowell <noodles@fb.com>
Cc: Mike Rapoport <rppt@kernel.org>
Cc: Sohil Mehta <sohil.mehta@intel.com>
Cc: Sourabh Jain <sourabhjain@linux.ibm.com>
Cc: Thomas Gleinxer <tglx@linutronix.de>
Cc: Yifei Liu <yifei.l.liu@oracle.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---

 arch/x86/kernel/setup.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/arch/x86/kernel/setup.c~x86-kexec-add-a-sanity-check-on-previous-kernels-ima-kexec-buffer
+++ a/arch/x86/kernel/setup.c
@@ -439,9 +439,15 @@ int __init ima_free_kexec_buffer(void)
 
 int __init ima_get_kexec_buffer(void **addr, size_t *size)
 {
+	int ret;
+
 	if (!ima_kexec_buffer_size)
 		return -ENOENT;
 
+	ret = ima_validate_range(ima_kexec_buffer_phys, ima_kexec_buffer_size);
+	if (ret)
+		return ret;
+
 	*addr = __va(ima_kexec_buffer_phys);
 	*size = ima_kexec_buffer_size;
 
_

Patches currently in -mm which might be from harshit.m.mogalapalli@oracle.com are



