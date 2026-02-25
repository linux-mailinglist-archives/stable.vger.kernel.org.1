Return-Path: <stable+bounces-219300-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SD2iHk+dnmkZWgQAu9opvQ
	(envelope-from <stable+bounces-219300-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:57:19 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CFD519297D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 07:57:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 95425301AE70
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 06:57:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D7AC2F25E4;
	Wed, 25 Feb 2026 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hnNrhzLi"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507112D8DCF;
	Wed, 25 Feb 2026 06:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772002625; cv=none; b=BFMNK9t9ZBXGSQQFJJn2GP9zQu9uv1XhLXI/FYANIqwDFKxYUwyeVhDgyfTUOlOkasfxt61yeAZez4a0vwFdaGaF865m//Jzl7CZ5pZP4Izy/tlOddCWTCKdMM9+MzMlFXPUrR2PtOtbb1f/LH93ul0+vLzAOXW96WsNdSlCXnE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772002625; c=relaxed/simple;
	bh=RBeiJDizYEVtGGhvQ1Kw32THGger99+TXmWIxOhkB00=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pg51/q37HmBWWQD9lmTV6UpUEco8H7VCN+v1EH94wVq0BwfYQe8xrv+3SfC4Gj2KStbGFYY4gh4HRzpUyJJkdUt/MX02P9DH8wqT307j543Qd3tAaiHOIGL3yAfs0WnokrFx5M58ePFv416p8PDNuw/jqVwpxhetgq9YnxZBdus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hnNrhzLi; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 27C6EC116D0;
	Wed, 25 Feb 2026 06:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1772002625;
	bh=RBeiJDizYEVtGGhvQ1Kw32THGger99+TXmWIxOhkB00=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hnNrhzLi0jbQ7fTHjrXm8HzeLbFzQIJptYgYG8ph/EPigPps4vFVMLASg2/zwT0BB
	 sKW1R5fkJNeeyM0gzZK0ovhtIfiKzsjwYELPsgwZK3biYqBzWMR+Nf6o90ZEpWORjc
	 0SWmQywjLobOZovE4uNqnS1kK96+A3mu9UB1uWnk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tudor Ambarus <tudor.ambarus@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 385/641] mtd: spinand: Fix kernel doc
Date: Tue, 24 Feb 2026 17:21:51 -0800
Message-ID: <20260225012357.916198460@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012348.915798704@linuxfoundation.org>
References: <20260225012348.915798704@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-219300-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,bootlin.com:email,linaro.org:email]
X-Rspamd-Queue-Id: 3CFD519297D
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit a57b1f07d2d35843a7ada30c8cf9a215c0931868 ]

The @data buffer is 5 bytes, not 4, it has been extended for the need of
devices with an extra ID bytes.

Fixes: 34a956739d29 ("mtd: spinand: Add support for 5-byte IDs")
Reviewed-by: Tudor Ambarus <tudor.ambarus@linaro.org>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/mtd/spinand.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 927c10d787695..1c741145e4971 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -287,7 +287,7 @@ struct spinand_device;
 
 /**
  * struct spinand_id - SPI NAND id structure
- * @data: buffer containing the id bytes. Currently 4 bytes large, but can
+ * @data: buffer containing the id bytes. Currently 5 bytes large, but can
  *	  be extended if required
  * @len: ID length
  */
-- 
2.51.0




