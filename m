Return-Path: <stable+bounces-213001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AE6xCq2Ef2mxsgIAu9opvQ
	(envelope-from <stable+bounces-213001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 17:51:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id E03E7C6902
	for <lists+stable@lfdr.de>; Sun, 01 Feb 2026 17:51:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 4540B3001030
	for <lists+stable@lfdr.de>; Sun,  1 Feb 2026 16:51:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D3E423536B;
	Sun,  1 Feb 2026 16:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VIXvAdNg"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFEE31B532F
	for <stable@vger.kernel.org>; Sun,  1 Feb 2026 16:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769964714; cv=none; b=tW4crLiiFpwPZaIu29JgSrgme0VayTk+mA2esD1bZHQQ7pwafqC05bkfjGlFTIqdyjf93cuPWmLPfhSaunul/YSpvjxJzDVO5MwCQKR/axY06hc4uui+zc9j4PNtLssuVx2CMyDMpBmnt1w/puJlMDUsEHwDi55ClQl1j9FEP8w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769964714; c=relaxed/simple;
	bh=ddelZs4saclLRF6sch2rRSjldIrJ72w7jZXXb06+vSU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fd6JPVhINxAKOC+kMRiOJfIfXuZKnxUK7+Gio6WFKACeeTsAjdf6FKo0ibvVkYPfIJjA4p+PHtF5/g+TYwE8yoa3yXqnwI0/+Woeu41snFQViQ12Kmpe5lwq+3360xJ5ne9Yft0spxX+w7RZzplOnnTUX7scQeYbl0FEYfYn1sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VIXvAdNg; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-81dbc0a99d2so1853425b3a.1
        for <stable@vger.kernel.org>; Sun, 01 Feb 2026 08:51:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769964713; x=1770569513; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IKlyXwPFG6GKEH0YaZ7/fSJxwTIFwYdtxia1Wrm6PzE=;
        b=VIXvAdNgKuQjvHZStQN0aLRUAVe70XcNGTe87Bya5OoOeGFu65GRbXkog1HuCd/J/G
         Pm/Rh4TV1rDgaRTbNNfgCJXFIdttVjbLzg9S8sIXpPxX4m9OzTP4aVTtkjXMqPiO551g
         L2YPw+aG0RyUgNU80F+syC2jhFRukKdvctL4lQF4XssMYY4HexX3Sb7a1NNRnM6lmn3l
         fq2h/1X8ic3V4ir7U6Nq1OgULS9gFRcIAeOI2I66XnChuoQaynAkttDPGdd3QWCBcccl
         bzYlpy/Z4tPKP+N5bvrUZqNhNe0gbuuxmpHs2xuPD9Bnx9RFmTxe+ywYM2ENep9bErF6
         OMiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769964713; x=1770569513;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IKlyXwPFG6GKEH0YaZ7/fSJxwTIFwYdtxia1Wrm6PzE=;
        b=GQJgVvNvEOrKMq5cD119mSHuPn39IFpKgSCaaQwzD2l8UMDPGvIDmERADIK7kIfMDn
         4qz0GwVG5X5zTWW4GxyHQWxEKuL1jwEyl7JAjMaxPk5ZKbeGg2bMcRBmzAca47xpLox+
         Avz08e6BwP4LK0cUZmuww3H9Jd1U9Ev6qx2KTpcRT73eMwJj26IZVESiV+zUZUjCvjIj
         jfq/jUnsix6F00nnQtWzdrYIxpmUosocEbDX8rGVjKAOfiUxOD6h50vGspDYs7k27mx6
         Inrfj/lPBwwXEjZbb1MVGpfWlb64eGwnOM3s164WbTrdIouyf0oAF1+FVMhwY6U2B2yF
         yefA==
X-Gm-Message-State: AOJu0YwoEbuQlLbuUirvDN8CuoNUVwZokRECMivsmUQ4G1ppKx3xqKCv
	Trl7oKDAvRfv7cPKn1nDjQxNR9KxdxxzZflenlBmAuVKNpM6WOJkrKqA
X-Gm-Gg: AZuq6aKFIz0b8615vyXwADxuhCdu+JOg9fdLvFN2o2Yap/Fg8p+uKkEHjahOPSqyAg9
	r/ACXOLrD0D1Qo+zeac5pLmaKKECT1mCbBgXld3XFiOIK38w0hhKtTRFbS+3rn16mdSRHL+QO0U
	fnRdQEzUQrJiWslpyb1/5S7dC1UwkgXB/vOtY1pTQnlLvigETWcGiyF+mHngM0nRj01Y/EsmPAQ
	2ksYng7uOiK2DRIZdb47nr3OnjpATpfBhtj/g06piI/CVNQ08nSrzhQX60KHh4indR9DGpCZpUi
	mZSL7kVncfGeUP5KnYWU6Q1XML5zzaMT2JBDAMI50ajre0iKjUqLwi8BP9jST5RlWqze5WGfsLQ
	Vv1ZAN6e1dA+HXbQsiFMvo3MpWfMQrif610E+L4eq7/2v5ZOFhQqKqHzZ31W7ldF1necwMnrO9M
	jdMaDm5sUbZhGN1n6J7G0y+EDM
X-Received: by 2002:a05:6a00:1c90:b0:81f:4c37:7658 with SMTP id d2e1a72fcca58-823ab71e1b4mr9267349b3a.36.1769964712956;
        Sun, 01 Feb 2026 08:51:52 -0800 (PST)
Received: from 4aee0dccb4bc ([115.245.213.202])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379bfd797sm13309326b3a.43.2026.02.01.08.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Feb 2026 08:51:52 -0800 (PST)
From: Sanjaikumar V S <sanjaikumarvs@gmail.com>
X-Google-Original-From: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
To: sanjaikumar.vs@dicortech.com
Cc: stable@vger.kernel.org
Subject: [PATCH 2/2] mtd: spi-nor: core: Fix AAI mode when dirmap is not available
Date: Sun,  1 Feb 2026 16:51:06 +0000
Message-ID: <20260201165106.30-3-sanjaikumar.vs@dicortech.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260201165106.30-1-sanjaikumar.vs@dicortech.com>
References: <20260201165106.30-1-sanjaikumar.vs@dicortech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_TO(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-213001-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCPT_COUNT_TWO(0.00)[2];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sanjaikumarvs@gmail.com,stable@vger.kernel.org];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dicortech.com:mid,dicortech.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E03E7C6902
X-Rspamd-Action: no action

When the SPI controller does not support direct mapping (nodirmap=true),
spi_nor_spimem_write_data() calls spi_mem_dirmap_write() which falls
back to spi_mem_no_dirmap_write(). This fallback uses the operation
template created at probe time with the standard page program opcode.

For SST flashes using AAI mode, this fails because the template cannot
handle the dynamic opcode and address byte changes required by AAI.

Fix by checking nodirmap and using spi_nor_spimem_exec_op() directly,
which uses the runtime-built operation with correct AAI configuration.

Cc: stable@vger.kernel.org
Signed-off-by: Sanjaikumar V S <sanjaikumar.vs@dicortech.com>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index d3f8a78efd3b..7caeb508d628 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -281,7 +281,7 @@ static ssize_t spi_nor_spimem_write_data(struct spi_nor *nor, loff_t to,
 	if (spi_nor_spimem_bounce(nor, &op))
 		memcpy(nor->bouncebuf, buf, op.data.nbytes);
 
-	if (nor->dirmap.wdesc) {
+	if (nor->dirmap.wdesc && !nor->dirmap.wdesc->nodirmap) {
 		nbytes = spi_mem_dirmap_write(nor->dirmap.wdesc, op.addr.val,
 					      op.data.nbytes, op.data.buf.out);
 	} else {
-- 
2.43.0


