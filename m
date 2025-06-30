Return-Path: <stable+bounces-158977-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 56AACAEE489
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 18:29:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AC860188B544
	for <lists+stable@lfdr.de>; Mon, 30 Jun 2025 16:25:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5390228C873;
	Mon, 30 Jun 2025 16:25:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b="iyvRGBjS"
X-Original-To: stable@vger.kernel.org
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	(using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7410728C005
	for <stable@vger.kernel.org>; Mon, 30 Jun 2025 16:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=83.149.199.84
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751300721; cv=none; b=f2bsnbAl9WHW0y5RIvO75vFFf0SJZUC/hpwkaePUwiv5PQlecpaAtaZIsQ+PkRONQ2U0bEWxZXxYCckR1Pz/d0E0IQi1OZqBBZTbV+eOdjcysOW8QdlGC8rHyo0pmoN9CFlqqupBy3AgXs7cuP7tWzoci508AkYvSDaS9pGfLL4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751300721; c=relaxed/simple;
	bh=t4jy5cJhkCtVqjSQuSy8uvU9NcecJKspupr26C/plIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T/jujim6lWwj3EfHWsCFzPBoAU33L+WLhY5Y9xDkSCeacNKS99r0txcvMIaBZfkuwxOL0MGeSZ55Zs6FQulY4wt9VO/UrI2Z/fchxeegvC74/VsWfrA6SWxYWSowtj7tw3kngu1x+XFPCv45dtX9UPhF9k4ugWOwpLL/77MkpBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru; spf=pass smtp.mailfrom=ispras.ru; dkim=pass (1024-bit key) header.d=ispras.ru header.i=@ispras.ru header.b=iyvRGBjS; arc=none smtp.client-ip=83.149.199.84
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Received: from fedora.intra.ispras.ru (unknown [10.10.165.24])
	by mail.ispras.ru (Postfix) with ESMTPSA id B9B454076188;
	Mon, 30 Jun 2025 16:25:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru B9B454076188
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1751300709;
	bh=K0pIMP466n4G6pItwrF9EaycdxXCrSirFOCJ/yHtp+k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iyvRGBjSp26fUYTV3C8C/fTpo9+gtx7sxoHrKHV+XyvOqCeiblV3bAhdWJBK+fM2l
	 iLuY0U4qcKlrBH+mvGR/QWr+1EbdcLmnaQ2h9Hd1ljKbUH7BiwnRDKGQxrOfRYhGWB
	 h9C/tnx4oCCEq+8w0gVFM0FOum9pmvai1TlD2uQo=
From: Fedor Pchelkin <pchelkin@ispras.ru>
To: stable@vger.kernel.org
Cc: Fedor Pchelkin <pchelkin@ispras.ru>,
	Greg KH <gregkh@linuxfoundation.org>,
	Holger Dengler <dengler@linux.ibm.com>,
	David Airlie <airlied@redhat.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	lvc-project@linuxtesting.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 5.10 2/2] s390/pkey: Prevent overflow in size calculation for memdup_user()
Date: Mon, 30 Jun 2025 19:24:45 +0300
Message-ID: <20250630162446.1407811-2-pchelkin@ispras.ru>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250630162446.1407811-1-pchelkin@ispras.ru>
References: <20250630162446.1407811-1-pchelkin@ispras.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fedor Pchelkin <pchelkin@ispras.ru>

commit 7360ee47599af91a1d5f4e74d635d9408a54e489 upstream.

Number of apqn target list entries contained in 'nr_apqns' variable is
determined by userspace via an ioctl call so the result of the product in
calculation of size passed to memdup_user() may overflow.

In this case the actual size of the allocated area and the value
describing it won't be in sync leading to various types of unpredictable
behaviour later.

Use a proper memdup_array_user() helper which returns an error if an
overflow is detected. Note that it is different from when nr_apqns is
initially zero - that case is considered valid and should be handled in
subsequent pkey_handler implementations.

Found by Linux Verification Center (linuxtesting.org).

Fixes: f2bbc96e7cfa ("s390/pkey: add CCA AES cipher key support")
Cc: stable@vger.kernel.org
Signed-off-by: Fedor Pchelkin <pchelkin@ispras.ru>
Reviewed-by: Holger Dengler <dengler@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/r/20250611192011.206057-1-pchelkin@ispras.ru
Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
---

s390 and x86_64 allmodconfig build passed.

 drivers/s390/crypto/pkey_api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/crypto/pkey_api.c b/drivers/s390/crypto/pkey_api.c
index 362c97d9bd5b..293239076d40 100644
--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1119,7 +1119,7 @@ static void *_copy_apqns_from_user(void __user *uapqns, size_t nr_apqns)
 	if (!uapqns || nr_apqns == 0)
 		return NULL;
 
-	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
+	return memdup_array_user(uapqns, nr_apqns, sizeof(struct pkey_apqn));
 }
 
 static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,
-- 
2.50.0


