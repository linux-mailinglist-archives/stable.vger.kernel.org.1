Return-Path: <stable+bounces-246324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4JpMGoJrA2rf5gEAu9opvQ
	(envelope-from <stable+bounces-246324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:03:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 27EAD526A2B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 20:03:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3C39B304BB02
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 18:02:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6400630BB80;
	Tue, 12 May 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tnpmE+W9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27B4E3EDE4B;
	Tue, 12 May 2026 18:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778608933; cv=none; b=LxlIJYTRW+tA6UEFPuIjh+gUKWA/w/RGQeCiQklFw87RVObiJ37LS24Vz0QcAxsTLtsEOg089bNtoDelapUMH2r8znkP5l1yxm3YmL6aJGDh9aO31SeOmbTO7wBEMNIzM60Jqqfk4URBSXo/rIkQSaykiBqa11yV7uXnq3X5NA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778608933; c=relaxed/simple;
	bh=CfklKcyJg06WOIDQLYgNQyJx8IKtqx58W38KPGlac7s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WDaKfQNsCPlWi8SVwa8jkTuFIsHjeOz9DSoTX8WfKohzK2mm3OL++WDBKcl+ztOcJ3jld8KPnmuCwq3DnElsDzOIAdj7wN83KIab0BdoazVkIegcVJxLjqkj9TRAKoAu8ubIkPjr2b43h4ckCGQ440b/zMXemd5YHICfltD2S3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tnpmE+W9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2BD2C2BCB0;
	Tue, 12 May 2026 18:02:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778608933;
	bh=CfklKcyJg06WOIDQLYgNQyJx8IKtqx58W38KPGlac7s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tnpmE+W9/PyJRVDsNYdqx4TOOblg7krXkLUOOibJgc3MWwzSaPUmBk0zuE+OUg7wA
	 83KsRQT35ML7Ahftcf30TsV7AjjEU6NA7ZlKex/z4qOECtpNFcuORJA1AUUuM0a1ti
	 c4H6N1tLyEbqyo5/KqOpKra2OdOiZIoaNIQ3wefU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 257/270] crypto: qat - fix indentation of macros in qat_hal.c
Date: Tue, 12 May 2026 19:40:58 +0200
Message-ID: <20260512173943.857315308@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173938.452574370@linuxfoundation.org>
References: <20260512173938.452574370@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 27EAD526A2B
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-246324-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,intel.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,apana.org.au:email]
X-Rspamd-Action: no action

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>

[ Upstream commit 4963b39e3a3feed07fbf4d5cc2b5df8498888285 ]

The macros in qat_hal.c were using a mixture of tabs and spaces.
Update all macro indentation to use tabs consistently, matching the
predominant style.

This does not introduce any functional change.

Signed-off-by: Suman Kumar Chakraborty <suman.kumar.chakraborty@intel.com>
Reviewed-by: Giovanni Cabiddu <giovanni.cabiddu@intel.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Stable-dep-of: e7dcb722bb75 ("crypto: qat - fix firmware loading failure for GEN6 devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/intel/qat/qat_common/qat_hal.c |   22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

--- a/drivers/crypto/intel/qat/qat_common/qat_hal.c
+++ b/drivers/crypto/intel/qat/qat_common/qat_hal.c
@@ -9,17 +9,17 @@
 #include "icp_qat_hal.h"
 #include "icp_qat_uclo.h"
 
-#define BAD_REGADDR	       0xffff
-#define MAX_RETRY_TIMES	   10000
-#define INIT_CTX_ARB_VALUE	0x0
-#define INIT_CTX_ENABLE_VALUE     0x0
-#define INIT_PC_VALUE	     0x0
-#define INIT_WAKEUP_EVENTS_VALUE  0x1
-#define INIT_SIG_EVENTS_VALUE     0x1
-#define INIT_CCENABLE_VALUE       0x2000
-#define RST_CSR_QAT_LSB	   20
-#define RST_CSR_AE_LSB		  0
-#define MC_TIMESTAMP_ENABLE       (0x1 << 7)
+#define BAD_REGADDR			0xffff
+#define MAX_RETRY_TIMES			10000
+#define INIT_CTX_ARB_VALUE		0x0
+#define INIT_CTX_ENABLE_VALUE		0x0
+#define INIT_PC_VALUE			0x0
+#define INIT_WAKEUP_EVENTS_VALUE	0x1
+#define INIT_SIG_EVENTS_VALUE		0x1
+#define INIT_CCENABLE_VALUE		0x2000
+#define RST_CSR_QAT_LSB			20
+#define RST_CSR_AE_LSB			0
+#define MC_TIMESTAMP_ENABLE		(0x1 << 7)
 
 #define IGNORE_W1C_MASK ((~(1 << CE_BREAKPOINT_BITPOS)) & \
 	(~(1 << CE_CNTL_STORE_PARITY_ERROR_BITPOS)) & \



