Return-Path: <stable+bounces-228030-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SORUFQpHwWnpRwQAu9opvQ
	(envelope-from <stable+bounces-228030-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:58:34 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 82FE22F389F
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:58:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04694307339A
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B2613A961B;
	Mon, 23 Mar 2026 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qnR3tlaR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E809340298;
	Mon, 23 Mar 2026 13:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774273915; cv=none; b=t4F3N5qfLeAL18uMtajSKwdiajxfApfIDO3IM3qTt8IKO4plg6sDXyPR/eDO7o7YDy0V5Ql7iIW4Qn3EblK+04/ExvchHtRJ8u2WTsEGS6PQcbsnMSLowB7l41s0E6mf4iBMtA/chEntBrOP5bteKjvDx3y0T20VqeleKl6ZoDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774273915; c=relaxed/simple;
	bh=CLYtgUJ4aaAnfa3phsISxPxovvL3yyhj+u8x9pDQ9SQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C9HLJgSTVY2vW8zDoeWHox9u3jLkKecCdSwsZPRZnqHrSv7gICPNO33roDgpPZdnnia3sjG0KT3yZZ6cQVohXBhe7gQys5+EjNkOc2EPqYYvu/6Gu2SOkfMMmwflh+dq9GvCsbuvBMxuXP/4qpDq1/qMu/nHB5cRDCePVeMBn5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qnR3tlaR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C884FC4CEF7;
	Mon, 23 Mar 2026 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774273915;
	bh=CLYtgUJ4aaAnfa3phsISxPxovvL3yyhj+u8x9pDQ9SQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qnR3tlaRD9zjtrpJP5tIi5/zxI8g8JsHFfuVUeUc2SxQtvkiR3AcFyFecK076WQpT
	 Dkaz0Brteh5Y7Tu7YgWilp+zvzHSDx3bUKi2/Vukn05AJf5Yp7xJeo2zIi1h1bKItu
	 yNShS1ruOoCNWdHvXgLVaLmY/MlIwvr0bSJKyQSY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Takahiro Kuwano <takahiro.kuwano@infineon.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 6.19 049/220] mtd: spi-nor: Fix RDCR controller capability core check
Date: Mon, 23 Mar 2026 14:43:46 +0100
Message-ID: <20260323134506.138186567@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134504.575022936@linuxfoundation.org>
References: <20260323134504.575022936@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-228030-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linaro.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,bootlin.com:email]
X-Rspamd-Queue-Id: 82FE22F389F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

commit ac512cd351f7e4ab4569f6a52c116f4ab3a239cc upstream.

Commit 5008c3ec3f89 ("mtd: spi-nor: core: Check read CR support") adds a
controller check to make sure the core will not use CR reads on
controllers not supporting them. The approach is valid but the fix is
incorrect. Unfortunately, the author could not catch it, because the
expected behavior was met. The patch indeed drops the RDCR capability,
but it does it for all controllers!

The issue comes from the use of spi_nor_spimem_check_op() which is an
internal helper dedicated to check read/write operations only, despite
its generic name.

This helper looks for the biggest number of address bytes that can be
used for a page operation and tries 4 then 3. It then calls the usual
spi-mem helpers to do the checks. These will always fail because there
is now an inconsistency: the address cycles are forced to 4 (then 3)
bytes, but the bus width during the address cycles rightfully remains
0. There is a non-zero address length but a zero address bus width,
which is an invalid combination.

The correct check in this case is to directly call spi_mem_supports_op()
which doesn't messes up with the operation content.

Fixes: 5008c3ec3f89 ("mtd: spi-nor: core: Check read CR support")
Cc: stable@vger.kernel.org
Acked-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Acked-by: Takahiro Kuwano <takahiro.kuwano@infineon.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 8ffeb41c3e08..13201908a69f 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2466,7 +2466,7 @@ spi_nor_spimem_adjust_hwcaps(struct spi_nor *nor, u32 *hwcaps)
 
 		spi_nor_spimem_setup_op(nor, &op, nor->reg_proto);
 
-		if (spi_nor_spimem_check_op(nor, &op))
+		if (!spi_mem_supports_op(nor->spimem, &op))
 			nor->flags |= SNOR_F_NO_READ_CR;
 	}
 }
-- 
2.53.0




