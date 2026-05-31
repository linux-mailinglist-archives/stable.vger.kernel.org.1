Return-Path: <stable+bounces-259371-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yMYVKbaKHGrXPAkAu9opvQ
	(envelope-from <stable+bounces-259371-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 21:23:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B1C0617A33
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 21:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 174E33041786
	for <lists+stable@lfdr.de>; Sun, 31 May 2026 19:23:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73CB833D4F3;
	Sun, 31 May 2026 19:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ltmEov7K"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51B842DA765;
	Sun, 31 May 2026 19:23:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780255383; cv=none; b=dnJtqr4uq/sE+SK7c4G4ZikH4kRNt0YyRPGcuqjR0/Pl0ywTWjq5LSjjhM12GS9kkcz9PBc8hSnXriHA7NDXlxoc/toJOEJ3Wp6kCdHAMEnWZ0Sb2HxxOby8CXFH9MZkJHd1OVakw0cqyLwlgFfox7zR4T/E6om8FSyit8d7YXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780255383; c=relaxed/simple;
	bh=qvn/gXsoTTq4QWX5QXXeQZOdby6RxSxxTycPzPhsUf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=J/kesaOw8Xyrl31SK1LMim2LvwfRgbm0naSLpK2V3v1VuTRqhJCB3rbOv4IjgInogHJbl6gUgTVKoYqtORYdDwYOzqPRSb9Zz7T1yRxC03rwGMYN+jH3MNYubWA/gOjX398nGAm0OWBdIMW2IlLlnAdF7D1SnNsMGaMQVRDaAPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ltmEov7K; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBAD41F0089A;
	Sun, 31 May 2026 19:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780255382;
	bh=/mY3enrm8GFK36qU/nkkjB0lXkdJWeRdwxvRsf3AZR8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ltmEov7KkF/Do5u+UnehUfhpQB0vhC4ehOVE26KxpoRda66YHqhEZ/IFdLqcYvSYe
	 hYsIgbcO32GH0dYftrVPDh/cndTBRy+foG+1Tc9JyaYFUdF3c+hcE+hr+9rsn5fCg6
	 kWSv0HqoiMo+hLwJmvo9HenJkZJcqPbaOIVFZS/uz45ElS3PQxPJnR6Z7zGxeeE3su
	 gIR1X2ZEI6RceK6E3UDl+OYRy38hgo6cwnPEJNcwFiHnCTDUUKqAnwTmtLr9WHZkUp
	 r8R8eqm2KXURnTBGBfVOHT+yIhoYszGGGXK8AWpPxZlkNosieru1r0xdH0PGMyjtVk
	 OjvNgE08seixQ==
From: Eric Biggers <ebiggers@kernel.org>
To: linux-crypto@vger.kernel.org,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: linux-kernel@vger.kernel.org,
	Mounika Botcha <mounika.botcha@amd.com>,
	Harsh Jain <h.jain@amd.com>,
	Olivia Mackall <olivia@selenic.com>,
	Michal Simek <michal.simek@amd.com>,
	linux-arm-kernel@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH 2/4] crypto: xilinx-trng - Fix return value of xtrng_hwrng_trng_read()
Date: Sun, 31 May 2026 12:17:36 -0700
Message-ID: <20260531191738.55843-3-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260531191738.55843-1-ebiggers@kernel.org>
References: <20260531191738.55843-1-ebiggers@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-259371-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[ebiggers@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 2B1C0617A33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Implementations of hwrng::read are expected to return the number of
bytes generated.  Update xtrng_hwrng_trng_read() to match that.

Fixes: 8979744aca80 ("crypto: xilinx - Add TRNG driver for Versal")
Cc: stable@vger.kernel.org
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 drivers/crypto/xilinx/xilinx-trng.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/crypto/xilinx/xilinx-trng.c b/drivers/crypto/xilinx/xilinx-trng.c
index a35643baa489..a30b0b3b3685 100644
--- a/drivers/crypto/xilinx/xilinx-trng.c
+++ b/drivers/crypto/xilinx/xilinx-trng.c
@@ -237,22 +237,25 @@ static int xtrng_random_bytes_generate(struct xilinx_rng *rng, u8 *rand_buf_ptr,
 
 static int xtrng_hwrng_trng_read(struct hwrng *hwrng, void *data, size_t max, bool wait)
 {
 	u8 buf[TRNG_SEC_STRENGTH_BYTES];
 	struct xilinx_rng *rng;
-	int ret = -EINVAL, i = 0;
+	int ret = 0, i = 0;
 
 	rng = container_of(hwrng, struct xilinx_rng, trng);
 	while (i < max) {
 		ret = xtrng_random_bytes_generate(rng, buf, TRNG_SEC_STRENGTH_BYTES, wait);
-		if (ret < 0)
+		if (ret < 0) {
+			if (i == 0)
+				return ret;
 			break;
+		}
 
 		memcpy(data + i, buf, min_t(int, ret, (max - i)));
 		i += min_t(int, ret, (max - i));
 	}
-	return ret;
+	return i;
 }
 
 static int xtrng_hwrng_register(struct hwrng *trng)
 {
 	int ret;
-- 
2.54.0


