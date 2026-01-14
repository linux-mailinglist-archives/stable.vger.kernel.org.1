Return-Path: <stable+bounces-208356-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40521D1ECC0
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 13:35:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7027D3008198
	for <lists+stable@lfdr.de>; Wed, 14 Jan 2026 12:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AE460399013;
	Wed, 14 Jan 2026 12:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nBYs7tW/"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com [209.85.128.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D77DB395DB6
	for <stable@vger.kernel.org>; Wed, 14 Jan 2026 12:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768394139; cv=none; b=eojs9SD527/LD+1S9PVALmP7oDaYMqqYUXbs2p8KAk45UVir/RS2da5hojJyJNJV5L8q48YKl3p23hCKTrTef14v4FKv0Cr03pPCHL1ljZjzoOrFjJa63evo09WFvOtcqJ6Ltdx5SlZvqEAN5v9XS7jz5d+MFy0THpQejj0b7ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768394139; c=relaxed/simple;
	bh=KmF+mxZXBd5usLx31jYbFUdpVv319xRsw1z4NwmBaGQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Bs+4LuLXsKOy2bh+rsXeKsgf9UHUrYUD8vluMJ1Ynv98zEgQzJHezyD9P/u2qzz+WliaMVHTJbQ6Mmj/WrUWkZy+6czGymdEKbE/kYko9lKv24LuL/GpFDzsbNN+eSOdDeJmSt6xLvZGc45IM3PkTZnALlfkk+azgQ92mF7KvBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nBYs7tW/; arc=none smtp.client-ip=209.85.128.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f41.google.com with SMTP id 5b1f17b1804b1-47ee47ff24aso732555e9.1
        for <stable@vger.kernel.org>; Wed, 14 Jan 2026 04:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768394133; x=1768998933; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q5TjDcxLgtKvSQq5PqYHcBcWFoLtkmVts7uy/aHfmR4=;
        b=nBYs7tW/3x7wwMyV/lFnZERQJItyCnKQ5to8w5AZmiRmO90Kcin8Y0brIt7szpX39I
         BI60JrLyXSuoVA5KooU9McRuS4qCKGutHAIe4hiccudblpMQFmIJQFDEXGdeqpVuiu9v
         dsbNbBj9pV6KuO2X2SAy9pzYEups4x+1Zgg6tWsDHN2jLRaj2HcyactOyah/piwFt3ma
         zi7meHwS0BOSOoxvyobOv7YIxHuk0qpvOT4Sql05l+umlbihuFaUqQ2sa7MimFbVygBo
         E7uROKwuw1nPWkbUL5+ir/zd3bBFhDXrMKR5dN7OPbAsrgdVsWYQDPoPJNVOKUpVSvmp
         zT9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768394133; x=1768998933;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q5TjDcxLgtKvSQq5PqYHcBcWFoLtkmVts7uy/aHfmR4=;
        b=MpmUa/F8uLJXcAIWLCrw8hJOmW5vAOfPq8XnLnzKSUUCusPnJhRiHJlS15s/OpUERM
         2ZpLttoFV/hvgqBfna6GnUxt5ej9mAmw5wmo5eyfovqnh/es+gAWUna6pXhH3kp3JOzY
         SLo7KA6ZXMT5LtqOc2UXlqVKZudl8eH5gyHW4i5z86UO5TtQrKIzrAjhQTB6TlRp9UaN
         4q/hTrb4FY0kHOcizCVs+T1iW+LJrpJLusJ7cuSlMpIaJLs0uJSnIdXljm/BvLlQfVKT
         v4RpaBB7owcuP+Jp3IefN+HCx9RmCLzC0mpJLwrtOR4ukbGMVjfEAYy7Mb1pCt0fM7Pl
         fSdw==
X-Forwarded-Encrypted: i=1; AJvYcCXAw9ORVi7jnTZR/VeZSCFrNrGQ0h1qi7yfZobkJrQjdr542r23nOI6O3vds8hv7afGckuNqjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzacfSr/lu9FalmlxQrvRQ0xZ2+TA6g+TYIHSG7d3ltrlfrZ9Ve
	QOdKlJ3d/C3NpDlNFlfEjxzjGl9dvCRsKHFXFWp3tQwxu5CX/UvkkCv/
X-Gm-Gg: AY/fxX7XUuX8T8FxqwyTNPYeGvGrNnivL+HMLvz3X2Bxe0vcYNsRARhDutcQJLQjt1J
	Rs0BUTV26Qgu7RfFd8D2eB2jycoCRxtSNDXfttoG128D9Q50kSKOxxiNdv33euz/dypnmy94shB
	WzKf/aIpK/SJwl2L7wtJEZtfRUt4Xowjq76l+y7nnoi7EbqcRB8KTJCJsNWYXMYtSHpOCY4Gxpt
	XCRparVGkJkQrx2bX25kJFuKz88s7fgsMQcuTp2v85pjq3AU7UsnNAnizoEE9TbBryatLmXfOZt
	ktKs6sEMLfUwkFZM6UkLAwqePHoYcxOarVHGAxEoJTunj1vnOmvFeNpTI4b/MuFbm7fIiRBqkOg
	3Vt0rQ2iXeOTMeaDuyjxCbYUgrs6E60RweayaMfXuMcyxa6BYmZyjMsjc3t95eYZ6NUHvn+jNaH
	oKiC+50/oKHsBaJueQPSvZ/c+pQmqiBbEhMJclIWUBD1GcthIIst1AnRz4M9G0I78WZxLWUO9kv
	asFgYENLFu2
X-Received: by 2002:a05:600c:8816:b0:477:5ca6:4d51 with SMTP id 5b1f17b1804b1-47ee33918a4mr10348685e9.3.1768394132893;
        Wed, 14 Jan 2026 04:35:32 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-eduroam-85-139.paris.inria.fr. [128.93.85.139])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd5ede7esm51037635f8f.32.2026.01.14.04.35.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Jan 2026 04:35:32 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Sunil Goutham <sgoutham@marvell.com>,
	Geetha sowjanya <gakula@marvell.com>,
	Subbaraya Sundeep <sbhatta@marvell.com>,
	hariprasad <hkelam@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] octeontx2: Fix otx2_dma_map_page() error return code
Date: Wed, 14 Jan 2026 13:31:06 +0100
Message-ID: <20260114123107.42387-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

0 is a valid DMA address [1] so using it as the error value can lead to
errors.  The error value of dma_map_XXX() functions is DMA_MAPPING_ERROR
which is ~0.  The callers of otx2_dma_map_page() use dma_mapping_error()
to test the return value of otx2_dma_map_page(). This means that they
would not detect an error in otx2_dma_map_page().

Make otx2_dma_map_page() return the raw value of dma_map_page_attrs().

[1] https://lore.kernel.org/all/f977f68b-cec5-4ab7-b4bd-2cf6aca46267@intel.com

Fixes: caa2da34fd25 ("octeontx2-pf: Initialize and config queues")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
index e616a727a3a9..8cdfc36d79d2 100644
--- a/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
+++ b/drivers/net/ethernet/marvell/octeontx2/nic/otx2_common.h
@@ -940,13 +940,8 @@ static inline dma_addr_t otx2_dma_map_page(struct otx2_nic *pfvf,
 					   size_t offset, size_t size,
 					   enum dma_data_direction dir)
 {
-	dma_addr_t iova;
-
-	iova = dma_map_page_attrs(pfvf->dev, page,
+	return dma_map_page_attrs(pfvf->dev, page,
 				  offset, size, dir, DMA_ATTR_SKIP_CPU_SYNC);
-	if (unlikely(dma_mapping_error(pfvf->dev, iova)))
-		return (dma_addr_t)NULL;
-	return iova;
 }
 
 static inline void otx2_dma_unmap_page(struct otx2_nic *pfvf,
-- 
2.43.0


