Return-Path: <stable+bounces-159876-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FEEFAF7B3F
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 17:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C82B188F2D2
	for <lists+stable@lfdr.de>; Thu,  3 Jul 2025 15:17:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DF222F19BD;
	Thu,  3 Jul 2025 15:13:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="0TmQ7frU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1ACF42EFDAF;
	Thu,  3 Jul 2025 15:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751555636; cv=none; b=IJIUWBKPi/GASeYLkMVUETRyeVMSsdPEEyzI4wLc9ZpJjXF6gtZVL4f9iShzb5DRyVNT6+Tay7yNnvQlOOR06keZPZVesLhYyr2auF2IlZjmAn7WFUCtiNN252xydbavLE7dHhsGAAgG/Iot0pXBuoAS533uuUl0Cqck3nsKRNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751555636; c=relaxed/simple;
	bh=61XsKMoUe6kWyHMq3C2IJw1YHvYzESZ25PRJAk99owk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cr5HNibEmyaWFL/6MtmQJD3X1LxLRyOCXEamto9NwZlHyjaYlanN/sLRz9PxF+68m3GgF+8s7VOZFtjZCE8TR0payAc/ZyzHxoHb4mZdU1L6rbRjZfec7J4fx5c0uvLdRbBKM6BanO3+0lplbHAFTdpBRq8COKD7kq/6LeLJfDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=0TmQ7frU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAB48C4CEE3;
	Thu,  3 Jul 2025 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751555635;
	bh=61XsKMoUe6kWyHMq3C2IJw1YHvYzESZ25PRJAk99owk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=0TmQ7frU1/sbl7U7Ctd8Ya/b7fHW4SjNr2CffipwjcNmI8uhPgLeRChxoYyPyNP6E
	 yYVIfJOumIuPE/p+v3D8V+JYLmnToH5s/wAm6HVGlZh+pHOY6jirF5eVnqWuvBbsOe
	 WaIXSUPAkMM0BZIFlz6NDVhWvmikfQnEkYOug9vI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Fedor Pchelkin <pchelkin@ispras.ru>,
	Holger Dengler <dengler@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>
Subject: [PATCH 6.6 075/139] s390/pkey: Prevent overflow in size calculation for memdup_user()
Date: Thu,  3 Jul 2025 16:42:18 +0200
Message-ID: <20250703143944.102459115@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250703143941.182414597@linuxfoundation.org>
References: <20250703143941.182414597@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/s390/crypto/pkey_api.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/crypto/pkey_api.c
+++ b/drivers/s390/crypto/pkey_api.c
@@ -1333,7 +1333,7 @@ static void *_copy_apqns_from_user(void
 	if (!uapqns || nr_apqns == 0)
 		return NULL;
 
-	return memdup_user(uapqns, nr_apqns * sizeof(struct pkey_apqn));
+	return memdup_array_user(uapqns, nr_apqns, sizeof(struct pkey_apqn));
 }
 
 static long pkey_unlocked_ioctl(struct file *filp, unsigned int cmd,



