Return-Path: <stable+bounces-177005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8AC99B3FF32
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 14:08:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A64512C6638
	for <lists+stable@lfdr.de>; Tue,  2 Sep 2025 12:04:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5E33019A8;
	Tue,  2 Sep 2025 11:57:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b="JXUx18fV"
X-Original-To: stable@vger.kernel.org
Received: from out203-205-221-239.mail.qq.com (out203-205-221-239.mail.qq.com [203.205.221.239])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D94892FC875
	for <stable@vger.kernel.org>; Tue,  2 Sep 2025 11:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.239
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756814274; cv=none; b=WFWQsOtXfbvmeB7qfqsjMYvxnOqoe3PXADqF+iFtNw2PT3KuQt86r4tSNHldOQgKT8nPN0+upAtRQdAzg/WYVeD1XA3J5RyPmfsmsCceIfRdKao6mRx+Q5vRlAIQEItsrNcvDQAwRU7yO3MnPzy4wB3YgypUoBTFJ0QDCVg4IiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756814274; c=relaxed/simple;
	bh=a370aIgZUMDEjs0JMFwIkhfA8Qi2NC59bUJdc3INbMU=;
	h=Message-ID:From:To:Cc:Subject:Date:MIME-Version; b=GBpMFMliRxwjqz1f2HfH/olz0jA2k2exxvRbmDxA+To0MZHQkCQAOcg9jf+4t4XS8oUtqlObORee1x0AIToDcw3kaCLnwIbqd6aAZ0gu/efzZEgp7JFNuho4sfMiPZ7qxpZMJbFSbOA1DTgVk7Sbjevo8ObNinr4u2ZPOmV0Pik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com; spf=pass smtp.mailfrom=foxmail.com; dkim=pass (1024-bit key) header.d=foxmail.com header.i=@foxmail.com header.b=JXUx18fV; arc=none smtp.client-ip=203.205.221.239
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foxmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foxmail.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
	s=s201512; t=1756814267;
	bh=GYaFXqXLEKWGz4dgArel64ydmlxR3gXxQe7uLF/j44g=;
	h=From:To:Cc:Subject:Date;
	b=JXUx18fVyUoyEyUIPeNrs2wuYG2OjwOy/0l19dB6CMdxSKM1BDnfGJNaMRxd/vNU7
	 Wiwj1PbekeoYcHZtipWWNqwm/eCORh+gdHwUVeh//83f+x/+7PoWQEqEc3thhOXqw/
	 mD+nyrWovTITP1JQbbwkhZtD+/dIClFb4WTU5eW8=
Received: from SSOC3-SH.company.local ([58.33.109.195])
	by newxmesmtplogicsvrszc43-0.qq.com (NewEsmtp) with SMTP
	id E64A7012; Tue, 02 Sep 2025 19:57:36 +0800
X-QQ-mid: xmsmtpt1756814256trwkeg0l7
Message-ID: <tencent_668C22B3310F1F372696487B211B9AB21807@qq.com>
X-QQ-XMAILINFO: MZu/+/yIvVI0gnNxObwApfH5WlBfI+PBk8RiSUgvDgb2XL7KXhupw+XIbF/uOn
	 qpg40QU1tA96lUPQAHuKd0NBJ24djMKUJ5hLyrfMqR/rpBBQD7CZbUuQKuuaEjuoVtCFhbq68Mgi
	 2mXe0xcSSFOqhlUVsak27UJ3FiZb0GXEBQOmEw49ahM2wVAnJEdsMqbREwtIkesCq/DPoSZZ0eOP
	 k2GcWT7ui/kC79sQi6rYaMV3IWQaxhN9y/C7KebQU2Ie2bnYleepFOfuKaTFnhbKHozo/7Zf2N2z
	 mAOFuWcDec+Ca9flWapYNR5rVYfQPv0OhkeW9HaKeD6Ish70eYEDJouH415kaJm9kzMJL5MTfKaP
	 VG3V4Sqjd8ZhjxsfrbGqF6VW7TpxnS7+CzqVRbvCuGvZ2W/R0Y/cLFMdBCBqht/y2fKtL6FQ6Ky/
	 h/LUQoWRl6+on3GT0rMl+K25MRjunkIPcwwc0bOALloLGpM+p5ORaIR5SlOyzjLaM4tTApTj96Tl
	 RMB3v0hzRTBgAGfm6kWKL8aFClsnGbvY/+G/lKaRBihKoCJhmRVwmY0OdJiiQgC6xGNg1eyieFK5
	 HD8ZioVUJmqhYFWJkgP2uEroTVkIGUSMDc1jB0Y1E9vkb1RdGjWRtFRsk3x+7jgtnLFPgLPWlVSY
	 M3OPpYTNhIixk2ZpMFwBN9+wCCxDypZa7zLF5Tn2u/VIgdQkVslzCV/SNKp13InFqT5JlyaEvSf+
	 EncUDaUoVlvQD4T9Pv3Mu3Fsb7aMz7eIcxoO/1T+4DxRivMpF9OgR7W2uhIjSabK/Mw93f+PkJrR
	 bhAJHuEjCKYTNN9xDzuM5eT4TvFALd1l2d5DRkFVydxLC7HqRWPfsHcJH1v+GUI9CUs6/sh24XeM
	 gBOwN7h9oqhXLYgtDlwIWnqA1PALQ4Q5PIZqAhi4Y+3k2M0deJ+x2GrBq2/olUG0ZZbrF0+aKt5h
	 kS008KhXFHllgykJHmTdsQQR9Qk0AHeNHd8ci0A7J+KwrG5VGQkxRlKI7GYq578oTx9KVS9gYoFm
	 HsH0wxYVPzNBzywHySjWbhmaZEjn6z9MCnwb2ZaySJzyPpQEViajhrMTiXo98=
X-QQ-XMRINFO: MSVp+SPm3vtS1Vd6Y4Mggwc=
From: gj.han@foxmail.com
To: hanguangjiang@lixiang.com
Cc: liangjie@lixiang.com,
	stable@vger.kernel.org
Subject: [PATCH] blk-throttle: check policy bit in blk_throtl_activated()
Date: Tue,  2 Sep 2025 19:57:34 +0800
X-OQ-MSGID: <20250902115734.3624896-1-gj.han@foxmail.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Han Guangjiang <hanguangjiang@lixiang.com>

On repeated cold boots we occasionally hit a NULL pointer crash in
blk_should_throtl() when throttling is consulted before the throttle
policy is fully enabled for the queue. Checking only q->td != NULL is
insufficient during early initialization, so blkg_to_pd() for the
throttle policy can still return NULL and blkg_to_tg() becomes NULL,
which later gets dereferenced.

Tighten blk_throtl_activated() to also require that the throttle policy
bit is set on the queue:

  return q->td != NULL &&
         test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);

This prevents blk_should_throtl() from accessing throttle group state
until policy data has been attached to blkgs.

Fixes: a3166c51702b ("blk-throttle: delay initialization until configuration")
Cc: stable@vger.kernel.org

Co-developed-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Liang Jie <liangjie@lixiang.com>
Signed-off-by: Han Guangjiang <hanguangjiang@lixiang.com>
---
 block/blk-throttle.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-throttle.h b/block/blk-throttle.h
index 3b27755bfbff..9ca43dc56eda 100644
--- a/block/blk-throttle.h
+++ b/block/blk-throttle.h
@@ -156,7 +156,7 @@ void blk_throtl_cancel_bios(struct gendisk *disk);
 
 static inline bool blk_throtl_activated(struct request_queue *q)
 {
-	return q->td != NULL;
+	return q->td != NULL && test_bit(blkcg_policy_throtl.plid, q->blkcg_pols);
 }
 
 static inline bool blk_should_throtl(struct bio *bio)
-- 
2.25.1


