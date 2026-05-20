Return-Path: <stable+bounces-252509-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kKBKNEX7DWrO5AUAu9opvQ
	(envelope-from <stable+bounces-252509-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F018595D30
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:19:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 595EA30E735C
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFE883F8707;
	Wed, 20 May 2026 18:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="SM2mcQ0r"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B659D3DC4DA;
	Wed, 20 May 2026 18:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779300859; cv=none; b=a1056qD0EVos4jFxFx5BzRgoP4yxb66t3WxgEeTfG3N0o84HOhXQsWja5jGbFHZwJpuxkMRDK31f2hAlit7NBE2mQjMHC+eFOBCTEv/xLc4yRHwa7x6Je181rBaAPzVUYZrKEIlN2tjJblWGV9h0/J5BiEViieszImF28DGjcN0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779300859; c=relaxed/simple;
	bh=Kiqx7jOQm2E3JsfnuDTVqS6PjsgebepTZkavPcC0vB0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u64mWItrDE1Y9waKbcFOXErneQosXCRCwXOGU3pNvEbx+OuKN0/NZIaKD+p+LOh+jdcYIx1OjWxDc79qe2TqRk4I4QFqytUdwbDVihcN+v4mqF4rEk4a30WMTy5pb4BJJco5QxNs2FLkij8vUi5zYhU5eK0I6PmB47f3+hm+idM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=SM2mcQ0r; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 276CB1F000E9;
	Wed, 20 May 2026 18:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779300858;
	bh=FWXibHDyYeY9ug83KNHDhkYeIiXqUNNg2USIfLi04rk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SM2mcQ0rkvQ4Ce5hB3NEbQwLFNRJyfsGr5OGBOaEEVjsX9yU9dwRQAdaALbpucugN
	 WZ8mq2lnRUDFnPqbJP1VSGHF2HlKo1gA3XMKj6s6WcwIvJGUBvkfgUdKvmeX+FDOzD
	 +0cgiS997ycLJqi79sqJfv5I632sbxpPdKTztu9M=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Haibo Chen <haibo.chen@nxp.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 334/666] mtd: spi-nor: core: correct the op.dummy.nbytes when check read operations
Date: Wed, 20 May 2026 18:19:05 +0200
Message-ID: <20260520162118.471527027@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-252509-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:mid,linuxfoundation.org:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,nxp.com:email]
X-Rspamd-Queue-Id: 6F018595D30
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Haibo Chen <haibo.chen@nxp.com>

[ Upstream commit 756564a536ecd8c9d33edd89f0647a91a0b03587 ]

When check read operation, need to setting the op.dummy.nbytes based
on current read operation rather than the nor->read_proto.

Fixes: 0e30f47232ab ("mtd: spi-nor: add support for DTR protocol")
Signed-off-by: Haibo Chen <haibo.chen@nxp.com>
Reviewed-by: Pratyush Yadav <pratyush@kernel.org>
Signed-off-by: Pratyush Yadav (Google) <pratyush@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mtd/spi-nor/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index a3e6a8c28dfbe..d666e044b0c4d 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -2416,7 +2416,7 @@ static int spi_nor_spimem_check_readop(struct spi_nor *nor,
 	/* convert the dummy cycles to the number of bytes */
 	op.dummy.nbytes = (read->num_mode_clocks + read->num_wait_states) *
 			  op.dummy.buswidth / 8;
-	if (spi_nor_protocol_is_dtr(nor->read_proto))
+	if (spi_nor_protocol_is_dtr(read->proto))
 		op.dummy.nbytes *= 2;
 
 	return spi_nor_spimem_check_op(nor, &op);
-- 
2.53.0




