Return-Path: <stable+bounces-245572-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CO/QFBEuA2qd1QEAu9opvQ
	(envelope-from <stable+bounces-245572-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:41:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5938252171D
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:41:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 9144C3172BB8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:20:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AAD3A05CA;
	Tue, 12 May 2026 13:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UtmEWrUF"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D03243A05F2
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:16:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591799; cv=none; b=bWs+qjOKBXAl7s+YCfChNC3dLnPy5KNPSb4zIOmPRtpPaEj6Vob1d9grjaLsMGzxYbQx7ZN5o75M4BgUKkv3IMIK0Js1IL+ynlc5iiMA1qE8l6WifKMjoKIv9dY1qrpItade3ofcDbA0b4jmKEofQzPosgpUZeTaSsuowF5xA98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591799; c=relaxed/simple;
	bh=x1jrlqE2smOetyIl5l0di2vVnFPwi69/FhsyEo6/Xxg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BG61qShEqKNHIcZQ+S59Y9Hu4yrg5Vr0lLH1lOBBPGWk5K/UUcp5YTp+2YGH9OkKpZI7RozKVubCjNReTFEWspl9aDkJ7RHftc8DTh8YP2FvXIxAnP4/glxc5mrj19OVaG0ebw2Oaa6AESTNdlazSluN3kcrLvNmNbe9FfrJdZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UtmEWrUF; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24724C2BCB0;
	Tue, 12 May 2026 13:16:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778591799;
	bh=x1jrlqE2smOetyIl5l0di2vVnFPwi69/FhsyEo6/Xxg=;
	h=Subject:To:Cc:From:Date:From;
	b=UtmEWrUFx9Ubz9R7DWykBfLkW8OAhRFgqqmF52VU320D4obp64bq0MNdnDoRUMtTL
	 VrNap5rY2ZK3Yvy8/b1BB4uezpZCAzuSTK9Y9zkEEdRSbfNGsSUqTu0XEVLnIGQXk7
	 HG75mLuLqub9hEOjgV51ECxTGBr9wDlrxs2ocjJ8=
Subject: FAILED: patch "[PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in" failed to apply to 6.1-stable tree
To: tudor.ambarus@linaro.org,miquel.raynal@bootlin.com,mwalle@kernel.org,pratyush@kernel.org,takahiro.kuwano@infineon.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 12 May 2026 15:16:44 +0200
Message-ID: <2026051244-bonelike-likewise-bea8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 5938252171D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [2.34 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-245572-lists,stable=lfdr.de];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linuxfoundation.org:dkim,bootlin.com:email,gregkh:email,infineon.com:email,sashiko.dev:url]
X-Rspamd-Action: no action


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e47029b977e747cb3a9174308fd55762cce70147
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051244-bonelike-likewise-bea8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e47029b977e747cb3a9174308fd55762cce70147 Mon Sep 17 00:00:00 2001
From: Tudor Ambarus <tudor.ambarus@linaro.org>
Date: Fri, 17 Apr 2026 15:24:39 +0000
Subject: [PATCH] mtd: spi-nor: debugfs: fix out-of-bounds read in
 spi_nor_params_show()

Sashiko noticed an out-of-bounds read [1].

In spi_nor_params_show(), the snor_f_names array is passed to
spi_nor_print_flags() using sizeof(snor_f_names).

Since snor_f_names is an array of pointers, sizeof() returns the total
number of bytes occupied by the pointers
	(element_count * sizeof(void *))
rather than the element count itself. On 64-bit systems, this makes the
passed length 8x larger than intended.

Inside spi_nor_print_flags(), the 'names_len' argument is used to
bounds-check the 'names' array access. An out-of-bounds read occurs
if a flag bit is set that exceeds the array's actual element count
but is within the inflated byte-size count.

Correct this by using ARRAY_SIZE() to pass the actual number of
string pointers in the array.

Cc: stable@vger.kernel.org
Fixes: 0257be79fc4a ("mtd: spi-nor: expose internal parameters via debugfs")
Closes: https://sashiko.dev/#/patchset/20260417-die-erase-fix-v2-1-73bb7004ebad%40infineon.com [1]
Signed-off-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Reviewed-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Reviewed-by: Michael Walle <mwalle@kernel.org>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>

diff --git a/drivers/mtd/spi-nor/debugfs.c b/drivers/mtd/spi-nor/debugfs.c
index fa6956144d2e..14ba1680c315 100644
--- a/drivers/mtd/spi-nor/debugfs.c
+++ b/drivers/mtd/spi-nor/debugfs.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
+#include <linux/array_size.h>
 #include <linux/debugfs.h>
 #include <linux/mtd/spi-nor.h>
 #include <linux/spi/spi.h>
@@ -92,7 +93,8 @@ static int spi_nor_params_show(struct seq_file *s, void *data)
 	seq_printf(s, "address nbytes\t%u\n", nor->addr_nbytes);
 
 	seq_puts(s, "flags\t\t");
-	spi_nor_print_flags(s, nor->flags, snor_f_names, sizeof(snor_f_names));
+	spi_nor_print_flags(s, nor->flags, snor_f_names,
+			    ARRAY_SIZE(snor_f_names));
 	seq_puts(s, "\n");
 
 	seq_puts(s, "\nopcodes\n");


