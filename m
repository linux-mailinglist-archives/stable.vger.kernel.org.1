Return-Path: <stable+bounces-187205-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CB6C4BEA6D2
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 18:03:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF3883B5FD4
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:38:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C2F6330B05;
	Fri, 17 Oct 2025 15:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="14/kVah6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC530330B03;
	Fri, 17 Oct 2025 15:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760715412; cv=none; b=gtxIld7F1gLBGuh/R8aNAzOuVqj2jKvphRw58CC3wzLA3bHgN84QgK28ID06gbWQH8Lrq17qU8XoUbGXWdHhqaDTcOmLBY/+577KkuTmka9waSSekwJDcHoE8vBTr2j6rcC0NLcN/3YdssaSQ4D/rNrDWRtISH6+IdctTQ68mG4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760715412; c=relaxed/simple;
	bh=pqTMl/WYknTCVMtumIDzQIaLRnfS+c+t65QRGOTruKI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QrWm6X8g7ecO1ZvJOkHikiYQFPsm+W1PJtr+lEEysSGU66+0jEX8Lz95JSAR43x45RpFxmLjYcJSvLlZ8ejL8LxzcFzEL71U9PQ9JqOjVKEuDzD/OlNG39c/+QO76YQbouFim8n7qCU5KyG6WfWPTFTkH7tpkKzOIWnRDUBgGK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=14/kVah6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 399EEC4CEE7;
	Fri, 17 Oct 2025 15:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760715412;
	bh=pqTMl/WYknTCVMtumIDzQIaLRnfS+c+t65QRGOTruKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=14/kVah6p37IENVztT9Pa0uMNV1gW7XbiPAAE49MUPEeVYN21u8SyZDHwhippKz7N
	 rtKosrvErsjJpbPU4bTYXZdIKwMoWLMADK3AbHwr1ElLuPtMmOf7epzRJfILfHNr0a
	 +ibyJ4H+JXkS8hEr/Cz0qC+pkWtWka8EqKEP0iwU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.17 208/371] crypto: atmel - Fix dma_unmap_sg() direction
Date: Fri, 17 Oct 2025 16:53:03 +0200
Message-ID: <20251017145209.615637884@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145201.780251198@linuxfoundation.org>
References: <20251017145201.780251198@linuxfoundation.org>
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

6.17-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

commit f5d643156ef62216955c119216d2f3815bd51cb1 upstream.

It seems like everywhere in this file, dd->in_sg is mapped with
DMA_TO_DEVICE and dd->out_sg is mapped with DMA_FROM_DEVICE.

Fixes: 13802005d8f2 ("crypto: atmel - add Atmel DES/TDES driver")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/atmel-tdes.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/atmel-tdes.c
+++ b/drivers/crypto/atmel-tdes.c
@@ -512,7 +512,7 @@ static int atmel_tdes_crypt_start(struct
 
 	if (err && (dd->flags & TDES_FLAGS_FAST)) {
 		dma_unmap_sg(dd->dev, dd->in_sg, 1, DMA_TO_DEVICE);
-		dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_TO_DEVICE);
+		dma_unmap_sg(dd->dev, dd->out_sg, 1, DMA_FROM_DEVICE);
 	}
 
 	return err;



