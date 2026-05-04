Return-Path: <stable+bounces-243780-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id CEgvMHWw+GkdzAIAu9opvQ
	(envelope-from <stable+bounces-243780-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:43:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 5817E4BFED0
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 16:43:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2649B309CE10
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 14:28:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5BD83DFC94;
	Mon,  4 May 2026 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KNffd9xl"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A973C3DFC7E;
	Mon,  4 May 2026 14:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777904759; cv=none; b=nIscUoiY41yXlw1JsIaf4pfvEUQlJs7C1lcSrpDxZBI+pl85MBGwO19m9Bj0wdJE0XbFNWbB9NGXOKEMl9r3KqHZa92Hg2EtXDvSk945WFwGwtnPmdaMGMbddRgQj1Qd9Zain8hwCp+3UZRPnbdeTTRsyZuciTiyU3PKlM0NQGs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777904759; c=relaxed/simple;
	bh=KVXNmHsNzCyy9eQ0Ip888e1zq4ViPr/SONEHyT1Qxio=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IdIYAX4A1+5yG3EZZGQownHARm/Zgtb1oAmsInmvWBRURF2u6NZA1X2/4fBC4ERjX9E5U0MNSKpVqAcwDOa6LqS5cp5iq/HgzH8qHE04flwWbPwHcEAk7ueyOIW1bO7/I6fpPTRsftdhiesg2DzlZWX2EVrwmzL4H3E1yO2PQJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KNffd9xl; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40A62C2BCB8;
	Mon,  4 May 2026 14:25:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1777904759;
	bh=KVXNmHsNzCyy9eQ0Ip888e1zq4ViPr/SONEHyT1Qxio=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=KNffd9xl+OsFcTC8tgm9OfgCJkPZy0jNcBwCO4IWZwptKRvrlJaQMI49qpSjekdr/
	 XZYD7vgjZk3pbwN/OMH0OMJpXvtzUNeCe2cRfOqGT2KSAIVDu6UC73xVAg0vWQuaLz
	 iimM04T2dru3C/EUt/Tl/I9+8g3rEyHHEZWRApoI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.12 163/215] crypto: nx - Fix packed layout in struct nx842_crypto_header
Date: Mon,  4 May 2026 15:53:02 +0200
Message-ID: <20260504135136.131390767@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260504135130.169210693@linuxfoundation.org>
References: <20260504135130.169210693@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 5817E4BFED0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-243780-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,apana.org.au:email,linux.dev:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Gustavo A. R. Silva <gustavoars@kernel.org>

commit b0bfa49c03e3c65737eafa73d8a698eaf55379a6 upstream.

struct nx842_crypto_header is declared with the __packed attribute,
however	the fields grouped with struct_group_tagged() were not packed.
This caused the grouped header portion of the structure to lose the
packed layout guarantees of the containing structure.

Fix this by replacing struct_group_tagged() with __struct_group(...,
..., __packed, ...) so the grouped fields are packed, and the original
layout is preserved, restoring the intended packed layout of the
structure.

Before changes:
struct nx842_crypto_header {
	union {
		struct {
			__be16     magic;                /*     0     2 */
			__be16     ignore;               /*     2     2 */
			u8         groups;               /*     4     1 */
		};                                       /*     0     6 */
		struct nx842_crypto_header_hdr hdr;      /*     0     6 */
	};                                               /*     0     6 */
	struct nx842_crypto_header_group group[];        /*     6     0 */

	/* size: 6, cachelines: 1, members: 2 */
	/* last cacheline: 6 bytes */
} __attribute__((__packed__));

After changes:
struct nx842_crypto_header {
	union {
		struct {
			__be16     magic;                /*     0     2 */
			__be16     ignore;               /*     2     2 */
			u8         groups;               /*     4     1 */
		} __attribute__((__packed__));           /*     0     5 */
		struct nx842_crypto_header_hdr hdr;      /*     0     5 */
	};                                               /*     0     5 */
	struct nx842_crypto_header_group group[];        /*     5     0 */

	/* size: 5, cachelines: 1, members: 2 */
	/* last cacheline: 5 bytes */
} __attribute__((__packed__));

Fixes: 1e6b251ce175 ("crypto: nx - Avoid -Wflex-array-member-not-at-end warning")
Cc: stable@vger.kernel.org
Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Reviewed-by: Thorsten Blum <thorsten.blum@linux.dev>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/nx/nx-842.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/crypto/nx/nx-842.h
+++ b/drivers/crypto/nx/nx-842.h
@@ -158,7 +158,7 @@ struct nx842_crypto_header_group {
 
 struct nx842_crypto_header {
 	/* New members MUST be added within the struct_group() macro below. */
-	struct_group_tagged(nx842_crypto_header_hdr, hdr,
+	__struct_group(nx842_crypto_header_hdr, hdr, __packed,
 		__be16 magic;		/* NX842_CRYPTO_MAGIC */
 		__be16 ignore;		/* decompressed end bytes to ignore */
 		u8 groups;		/* total groups in this header */
@@ -166,7 +166,7 @@ struct nx842_crypto_header {
 	struct nx842_crypto_header_group group[];
 } __packed;
 static_assert(offsetof(struct nx842_crypto_header, group) == sizeof(struct nx842_crypto_header_hdr),
-	      "struct member likely outside of struct_group_tagged()");
+	      "struct member likely outside of __struct_group()");
 
 #define NX842_CRYPTO_GROUP_MAX	(0x20)
 



