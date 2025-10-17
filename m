Return-Path: <stable+bounces-186847-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A787BE9C4B
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 17:25:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 039FD189B2D2
	for <lists+stable@lfdr.de>; Fri, 17 Oct 2025 15:22:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB33632C958;
	Fri, 17 Oct 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="K5XnmSIu"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE7F36CDEC;
	Fri, 17 Oct 2025 15:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760714395; cv=none; b=EPsbuhX+88QGHWFzNr4eMK/7sxuaMcDRC2qhrQpkEyoiwmn3X5LF1cmI5edgYREzKYUV6djTtMfJpbF1j0bBerWbgbLxCt2RN3Z9rzmU4MxGWffamPaFQGLlGpyzKW0MfMWA1wo14RTWxLtwS0VHC44wSYbkGztuROHGTtlB7r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760714395; c=relaxed/simple;
	bh=xFWPzTwwf9VW9ZTqoSxSm0UlmC/0m8FLvqqdL3nxtEM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MWoWCDrHF1ge+pKhskSzh9UA0cTW0uZQcSMU9sLhd9X7m2avYpfta64EEmSZNYND4OtHG/d+I+zvQKhq47PuGQwpgUDoS761mzSUoJYpm7ymbPxuI8tZoQcCdfWTyS8cXu77fMRz8cdhr6JNTeuImmAodFyIoCB5NBty/IFBRxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=K5XnmSIu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C4DFC4CEFE;
	Fri, 17 Oct 2025 15:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1760714395;
	bh=xFWPzTwwf9VW9ZTqoSxSm0UlmC/0m8FLvqqdL3nxtEM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=K5XnmSIuiVC32azxFppeZhBf83G58OVo4uN0gNF71N+qi06Xv6n6LLN54J2QNjCuJ
	 Q0YFYYymbhPKF+aECUaQe3R4naCvwy+4ZBX2g/gQYeQDjl3dJzpF+VnLth3kzPXF6Z
	 zr0V/1XU2epKBh3zxukUrUwdq1vsNSO7fi3ptfNM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thomas Fourier <fourier.thomas@gmail.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Subject: [PATCH 6.12 129/277] crypto: rockchip - Fix dma_unmap_sg() nents value
Date: Fri, 17 Oct 2025 16:52:16 +0200
Message-ID: <20251017145151.837000412@linuxfoundation.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251017145147.138822285@linuxfoundation.org>
References: <20251017145147.138822285@linuxfoundation.org>
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

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Fourier <fourier.thomas@gmail.com>

commit 21140e5caf019e4a24e1ceabcaaa16bd693b393f upstream.

The dma_unmap_sg() functions should be called with the same nents as the
dma_map_sg(), not the value the map function returned.

Fixes: 57d67c6e8219 ("crypto: rockchip - rework by using crypto_engine")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
Signed-off-by: Herbert Xu <herbert@gondor.apana.org.au>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/crypto/rockchip/rk3288_crypto_ahash.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/crypto/rockchip/rk3288_crypto_ahash.c
+++ b/drivers/crypto/rockchip/rk3288_crypto_ahash.c
@@ -252,7 +252,7 @@ static void rk_hash_unprepare(struct cry
 	struct rk_ahash_rctx *rctx = ahash_request_ctx(areq);
 	struct rk_crypto_info *rkc = rctx->dev;
 
-	dma_unmap_sg(rkc->dev, areq->src, rctx->nrsg, DMA_TO_DEVICE);
+	dma_unmap_sg(rkc->dev, areq->src, sg_nents(areq->src), DMA_TO_DEVICE);
 }
 
 static int rk_hash_run(struct crypto_engine *engine, void *breq)



