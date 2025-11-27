Return-Path: <stable+bounces-197111-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B339C8EB30
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:08:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4BB4E3A7FCF
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 14:02:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A03F23717F;
	Thu, 27 Nov 2025 14:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ECHHtHMT"
X-Original-To: stable@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB6422D4F6
	for <stable@vger.kernel.org>; Thu, 27 Nov 2025 14:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764252155; cv=none; b=mkbe3bu/Vk0amxN0HGt99NZslAXzV/rNC+WJ9dDdYAnU2zN2m7ZWvrZvYzeK1sA5XChyB/lnEy+Q9LnMT4dg3TyhYRHBtJ/5LdPViHH+ZA/O49rltRCEYk+tcqFIqCGXU9tH1YAwQhXa2IYiuiLQFemC0I4nCQUpuVUHOQa8qe4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764252155; c=relaxed/simple;
	bh=5PX/iIDfuyyYqIcNb75539//OPviUA5Wl1Nt5gOSfbI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SiljAEwvFgceuw9+NvVP7tGTH4RfNfGhqkhcJMeTJ2fbXcuK++xgPXZThCkQQZ02pUd8FX31Ih6hHFlhYZ4TV1gDnGiE3ZRMj/a4xT/PvBlKO2Q9CB2BDfMm2IPSNRkrsWxhZX2TpdznIpmPQy3ID0BEBZcVa7H/2MaemEQOJKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ECHHtHMT; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1764252141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=t9sx4anvo4lGCsssDz1Ke/5DwhTNNf3DFzIUDPTugwc=;
	b=ECHHtHMTmmEI/ypGNIVfPDMrf26ZG8D1mUJsBi2cPzS4zFV3uvJna68XQjf7o/wiw+E2XM
	ZAs4Qp1KItICUFe2dNrDoD6OP2yDWmJMAV3SpaVv1WNeSzHEQst35NgI9V2dK5dlemuPtH
	VzLEXjs7rUvLYpzWaY8TWpQaU+t+Vjg=
From: Thorsten Blum <thorsten.blum@linux.dev>
To: Kristen Accardi <kristen.c.accardi@intel.com>,
	Vinicius Costa Gomes <vinicius.gomes@intel.com>,
	Kanchana P Sridhar <kanchana.p.sridhar@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Tom Zanussi <tom.zanussi@linux.intel.com>
Cc: Thorsten Blum <thorsten.blum@linux.dev>,
	stable@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: iaa - Fix out-of-bounds index in find_empty_iaa_compression_mode
Date: Thu, 27 Nov 2025 15:01:57 +0100
Message-ID: <20251127140158.173840-1-thorsten.blum@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

The local variable 'i' is initialized with -EINVAL, but the for loop
immediately overwrites it and -EINVAL is never returned.

If no empty compression mode can be found, the function would return the
out-of-bounds index IAA_COMP_MODES_MAX, which would cause an invalid
array access in add_iaa_compression_mode().

Fix both issues by returning either a valid index or -EINVAL.

Cc: stable@vger.kernel.org
Fixes: b190447e0fa3 ("crypto: iaa - Add compression mode management along with fixed mode")
Signed-off-by: Thorsten Blum <thorsten.blum@linux.dev>
---
 drivers/crypto/intel/iaa/iaa_crypto_main.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/drivers/crypto/intel/iaa/iaa_crypto_main.c b/drivers/crypto/intel/iaa/iaa_crypto_main.c
index 23f585219fb4..8ee2a55ec449 100644
--- a/drivers/crypto/intel/iaa/iaa_crypto_main.c
+++ b/drivers/crypto/intel/iaa/iaa_crypto_main.c
@@ -221,15 +221,13 @@ static struct iaa_compression_mode *iaa_compression_modes[IAA_COMP_MODES_MAX];
 
 static int find_empty_iaa_compression_mode(void)
 {
-	int i = -EINVAL;
+	int i;
 
-	for (i = 0; i < IAA_COMP_MODES_MAX; i++) {
-		if (iaa_compression_modes[i])
-			continue;
-		break;
-	}
+	for (i = 0; i < IAA_COMP_MODES_MAX; i++)
+		if (!iaa_compression_modes[i])
+			return i;
 
-	return i;
+	return -EINVAL;
 }
 
 static struct iaa_compression_mode *find_iaa_compression_mode(const char *name, int *idx)
-- 
Thorsten Blum <thorsten.blum@linux.dev>
GPG: 1D60 735E 8AEF 3BE4 73B6  9D84 7336 78FD 8DFE EAD4


