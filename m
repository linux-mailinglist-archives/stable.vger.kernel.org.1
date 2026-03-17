Return-Path: <stable+bounces-226538-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2EcaEfSPuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226538-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:31:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id D43F82AFC07
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 77A0131CA75F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:05:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C5E93A4F46;
	Tue, 17 Mar 2026 17:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hPI8F/y+"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E2B2FFDEA;
	Tue, 17 Mar 2026 17:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773767133; cv=none; b=m7D3ZIx33WVwYlNAC4OahUqWJroqBUTvoXPtG0+aHQqZUF9f8LflcLIxDZqFtMoY+rVBH7nxqqM3tsG5RaE143t/J9beNrlILT0NTL4obf/BiJKnx0Z8daIZyOcvca6ISo+ki3OtT0DiceG3XZdQQlSLN7F59pmrM0mpDy+FhpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773767133; c=relaxed/simple;
	bh=13CM0XThkCTHlt9uvhoYpLV0KYhmXkyF9dmqUPRAj6c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OgLmahtOlhZ+8t2l4zz2jfNnoUqm9kzHhBoTQy/P91sSQc539rD6aTn1yVE4Ev8d1lyP3ewIC1fXajybSnlVw4OrgPqgmOnwrigjQg+mRxBQzInNp9ndmQ+jNAv2k9QJSeOs0WdUixmn53HdJThWCtUjTAAf1B4EeGJ1ODjXSZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hPI8F/y+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E799C4CEF7;
	Tue, 17 Mar 2026 17:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773767133;
	bh=13CM0XThkCTHlt9uvhoYpLV0KYhmXkyF9dmqUPRAj6c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hPI8F/y+qa9EztIw5/bub2AkJkh9hsoi4NJPQmUkmNcptMU5IYr02g9Ht77/zApzP
	 2zgsUf59nNCENAuCNQ6SkS+iPCeNGgPU+pSQnZFGqQghFhKY8EYo4jBd0usq5vCM+x
	 cjulLiKX+J/Wy53rlfuCpyO1aFyjxI/T0NzGC9f4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Hari Bathini <hbathini@linux.ibm.com>,
	Sourabh Jain <sourabhjain@linux.ibm.com>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 021/333] powerpc/crash: adjust the elfcorehdr size
Date: Tue, 17 Mar 2026 17:30:50 +0100
Message-ID: <20260317163000.146891694@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226538-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:mid,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D43F82AFC07
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Sourabh Jain <sourabhjain@linux.ibm.com>

[ Upstream commit 04e707cb77c272cb0bb2e2e3c5c7f844d804a089 ]

With crash hotplug support enabled, additional memory is allocated to
the elfcorehdr kexec segment to accommodate resources added during
memory hotplug events. However, the kdump FDT is not updated with the
same size, which can result in elfcorehdr corruption in the kdump
kernel.

Update elf_headers_sz (the kimage member representing the size of the
elfcorehdr kexec segment) to reflect the total memory allocated for the
elfcorehdr segment instead of the elfcorehdr buffer size at the time of
kdump load. This allows of_kexec_alloc_and_setup_fdt() to reserve the
full elfcorehdr memory in the kdump FDT and prevents elfcorehdr
corruption.

Fixes: 849599b702ef8 ("powerpc/crash: add crash memory hotplug support")
Reviewed-by: Hari Bathini <hbathini@linux.ibm.com>
Signed-off-by: Sourabh Jain <sourabhjain@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Link: https://patch.msgid.link/20260227171801.2238847-1-sourabhjain@linux.ibm.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/powerpc/kexec/file_load_64.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kexec/file_load_64.c b/arch/powerpc/kexec/file_load_64.c
index e7ef8b2a25546..5f6d50e4c3d45 100644
--- a/arch/powerpc/kexec/file_load_64.c
+++ b/arch/powerpc/kexec/file_load_64.c
@@ -450,6 +450,11 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	kbuf->buffer = headers;
 	kbuf->mem = KEXEC_BUF_MEM_UNKNOWN;
 	kbuf->bufsz = headers_sz;
+
+	/*
+	 * Account for extra space required to accommodate additional memory
+	 * ranges in elfcorehdr due to memory hotplug events.
+	 */
 	kbuf->memsz = headers_sz + kdump_extra_elfcorehdr_size(cmem);
 	kbuf->top_down = false;
 
@@ -460,7 +465,14 @@ static int load_elfcorehdr_segment(struct kimage *image, struct kexec_buf *kbuf)
 	}
 
 	image->elf_load_addr = kbuf->mem;
-	image->elf_headers_sz = headers_sz;
+
+	/*
+	 * If CONFIG_CRASH_HOTPLUG is enabled, the elfcorehdr kexec segment
+	 * memsz can be larger than bufsz. Always initialize elf_headers_sz
+	 * with memsz. This ensures the correct size is reserved for elfcorehdr
+	 * memory in the FDT prepared for kdump.
+	 */
+	image->elf_headers_sz = kbuf->memsz;
 	image->elf_headers = headers;
 out:
 	kfree(cmem);
-- 
2.51.0




