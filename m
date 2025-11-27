Return-Path: <stable+bounces-197461-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 71B23C8F274
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 16:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 8E5C14EA4FF
	for <lists+stable@lfdr.de>; Thu, 27 Nov 2025 15:04:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D7C6024E4A8;
	Thu, 27 Nov 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="dTl0ORpK"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913F628CF42;
	Thu, 27 Nov 2025 15:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764255886; cv=none; b=tjPmBbcn2PJNVsLdmDaxS3H7vVVpqivquxqSUY4N8SYMN7zNyZuyIhoAd32tyYNWdUfsx0p8bpq6uA39TxFqi7VnJCAW6Pb/Ov/fIOUlsp7fn4ZYqOBDpLVRlP8TMX5IblQqS2YBmFbsGcxQqXPTP5ygolxzPBdhL6y+gGyqZ0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764255886; c=relaxed/simple;
	bh=6UTWROIxF9Qhr8zoGI69sQ4KGEXMDTrcNrqTCxvzH38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XbKAEZcftszZ3RhTRW/lvMkvPytmCx97ie0p0gLB1I81GegSJOTbOfNwgWfltw90Yy3i6tO4Cii21gzCcIBrdr50TI32YOiaG8lS+vSTKZcRpJgP0Fv/mFs7FiWfCNKFRlrxFOTLcC3WcN6M4xeyfTyBV7r/6ztyiaqdJEYK7z4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=dTl0ORpK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13EC3C4CEF8;
	Thu, 27 Nov 2025 15:04:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764255886;
	bh=6UTWROIxF9Qhr8zoGI69sQ4KGEXMDTrcNrqTCxvzH38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dTl0ORpKtrN1Ex1d2NbCt9GvchjJ8NCw8tzWDSdXRfcQrHuN0VvNIjRBft3pnbPKl
	 PzZ4emHM+gPeue2QzQBShCMrQFMu8K6NKKNdMM2aZtXosdOH+BlHFWI7fKq9qUld7N
	 ZeRFQY/BPFHX+7eYpn8PRx8vHfQGk9LnThLtMZn0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Eric Biggers <ebiggers@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Carlos Llamas <cmllamas@google.com>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.17 149/175] blk-crypto: use BLK_STS_INVAL for alignment errors
Date: Thu, 27 Nov 2025 15:46:42 +0100
Message-ID: <20251127144048.396118156@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251127144042.945669935@linuxfoundation.org>
References: <20251127144042.945669935@linuxfoundation.org>
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

From: Carlos Llamas <cmllamas@google.com>

[ Upstream commit 0b39ca457241aeca07a613002512573e8804f93a ]

Make __blk_crypto_bio_prep() propagate BLK_STS_INVAL when IO segments
fail the data unit alignment check.

This was flagged by an LTP test that expects EINVAL when performing an
O_DIRECT read with a misaligned buffer [1].

Cc: Eric Biggers <ebiggers@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Link: https://lore.kernel.org/all/aP-c5gPjrpsn0vJA@google.com/ [1]
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Eric Biggers <ebiggers@kernel.org>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/blk-crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-crypto.c b/block/blk-crypto.c
index 4b1ad84d1b5ab..3e7bf1974cbd8 100644
--- a/block/blk-crypto.c
+++ b/block/blk-crypto.c
@@ -292,7 +292,7 @@ bool __blk_crypto_bio_prep(struct bio **bio_ptr)
 	}
 
 	if (!bio_crypt_check_alignment(bio)) {
-		bio->bi_status = BLK_STS_IOERR;
+		bio->bi_status = BLK_STS_INVAL;
 		goto fail;
 	}
 
-- 
2.51.0




