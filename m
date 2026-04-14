Return-Path: <stable+bounces-237991-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +CiVAwPS3ml0IgAAu9opvQ
	(envelope-from <stable+bounces-237991-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:47:15 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A1533FF245
	for <lists+stable@lfdr.de>; Wed, 15 Apr 2026 01:47:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68A743030116
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 23:46:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF6DF3D8116;
	Tue, 14 Apr 2026 23:46:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ejhHwtrB"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37C4F3D47A3
	for <stable@vger.kernel.org>; Tue, 14 Apr 2026 23:46:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776210402; cv=none; b=RLmjpmMp58I9OsZgq1Zne8DlOOrrSgGeQIVJjYTMrulKpAjB/3J9E5m5SxiLCGFPqVhHtyWDFiY1VLrC4/b9l713jJ77xAoI2CJVkibXDF3uAHhuZn4bt66nUAtRZZ1VcyzMTwBVfqeWm+An7YRz1SZYWC32ag/D+OkDiXT+UeQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776210402; c=relaxed/simple;
	bh=/2hIp5BZLooUW37+BmEgbWSArMAppLPs2okM3gNV8jo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=iFci6kqqrLjjZttQtZCcCbQ8hMFAvo+G3p1GpR7LhCgnOOLUt82X25QZbDFu2tryPoM9idIVJqehmdsJFc8Bfl78ctc/v2h3JfhRs5dzhPN3PP5pitHVUCp0J/VNJSeCh22bZTjQ3+dcRTsicj3mBqT3oS+qHi/zy4NPxaEgiLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ejhHwtrB; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-82f22f6b0feso1683304b3a.0
        for <stable@vger.kernel.org>; Tue, 14 Apr 2026 16:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776210398; x=1776815198; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e+aagt8mewkTvyv3R6Dqrd15T0YDKTqKrH1kiymIT8g=;
        b=ejhHwtrB9EqxqKBxEBH2Cyon+JDPgc9th03SRehxMCuHi/tXl8bxG+sEz+WVEe+sL2
         auQiqktdFMjf5HApILzs9foRZJAeKxvJYXN9fW1dqUjKNDsfEMhckn1kbJYHn5UKaGDS
         QWNdc6h+OF2wWw+OzZmO5liCnFwCneVC06sRksBprsSQ+R0kdZoe2NaKvOgA/E6/woiV
         3vFuVZyzPZbFFfsU1Guuoavj6w+vwI8xoXn+gMj832bsywq7xJC9uXUYsEFeCEAZq1zU
         wilfqTa8EnYVzD9Av6Uz4zq0GL3uRlWOqC9GgV3MsV5TJykuJ/HH3Jo9B/hBAqexy84G
         gWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776210398; x=1776815198;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e+aagt8mewkTvyv3R6Dqrd15T0YDKTqKrH1kiymIT8g=;
        b=X20A3Onc322op7dj8xLpiYR60T5Mp2OEeyvTfw1VkYR/nJ1xyv1XM9/yEDWorHjKv5
         szbN46DkeO59SNXp09VzRZ6kOfINWtWNRBIaViPhldyme2Jm2KBInrZZ7s24ETOZB8sF
         wV+9HEWyMKvKLSbp3jd588Fz2zKF/AWwewtXN+cvAjevtFQNXUV70tkqAoq9IZiP5vVg
         26AHByDr5OtUKpJFAIr8FqXGnWGHEI9icJP19DWU816vBpQPWujxcCzcPHWrCt7LGpml
         YJAeBnehQnW4kupA1YrGHlp69A1pPUlWxsWDWBXJStOYOi5t7gLOPizjXFdht7TPXhxl
         0FYw==
X-Forwarded-Encrypted: i=1; AFNElJ/YXjKhZjz0CrZtGWV7sFbTffFWXeea1FuRI4hMzvPhlyewBNs01ip3f2a3QgNroqpYhYIJZ/c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlWzl0Yk7fke5uHnDuIA76nhPjMDYh0w6+kCkCPD+SX6oGaU+W
	Gyb1ZCQogHSvBX916c+y9yQQjPbl+Se6Bk3WDOV3xz69UEkCTWB/UWi2woK2UA==
X-Gm-Gg: AeBDievKnx/33iTbQcXlFE/0kxXRWiWztZ0H5ZMAg0IELo/Kw/7TZRRuFAzEQR9kSGO
	Q+i+x8nlKth7WfRQ3+0PyF7xXXjGsvSUnkdpxpSN2RM3K3q0ntP/ztz2epGl8/wbqTMNFTy96Tm
	sDbXBNGQ3BZV3nz5zCAhdsTqC1snZH1H/FUhaVQ2YzbQgTGsMHOydBHlnjXkUY+41GdRMmXf+8K
	UMpV+m5mVF2aBAWgWbWFXJj1Rk/9bxlr4Iq/+l5IlAt/y05anO6M4+xfUVdSWEWRKGsJqwCztc0
	LK5hUZJ7DObSUcJIwCVRQvZobXLn3peGaqPhjY4bx8ccC0HH+M/bIzEG/8KrB9VTx2XKlSvC913
	1of41/Fi8Uk3GVl2EnN+FeEsdjf5GqbwnWVkn3icgPWpvm6VxvyABV2hE9jgJXQXyPMSoTMl0zB
	PnSdUPvZfw+ckEA/rHKTCQs1bjAZWOk1RkfVW+AGg=
X-Received: by 2002:a05:6a00:886:b0:82f:592f:2ed7 with SMTP id d2e1a72fcca58-82f592f35f5mr3850866b3a.45.1776210398171;
        Tue, 14 Apr 2026 16:46:38 -0700 (PDT)
Received: from zenbook ([203.30.245.12])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f6702f900sm153027b3a.2.2026.04.14.16.46.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 16:46:37 -0700 (PDT)
From: Wilfred Mallawa <wilfred.opensource@gmail.com>
To: linux-xfs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Alistair Francis <alistair.francis@wdc.com>,
	Carlos Maiolino <cem@kernel.org>,
	Hans Holmberg <hans.holmberg@wdc.com>,
	"Darrick J . Wong" <djwong@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Wilfred Mallawa <wilfred.mallawa@wdc.com>,
	stable@vger.kernel.org,
	Carlos Maiolino <cmaiolino@redhat.com>
Subject: [PATCH v2] xfs: fix memory leak on error in xfs_alloc_zone_info()
Date: Wed, 15 Apr 2026 09:45:14 +1000
Message-ID: <20260414234513.1457961-2-wilfred.opensource@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237991-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wilfredopensource@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,wdc.com:email]
X-Rspamd-Queue-Id: 6A1533FF245
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Wilfred Mallawa <wilfred.mallawa@wdc.com>

Currently, the 0th index of the zi_used_bucket_bitmap array is not freed
on error due to the pre-decrement then evaluate semantic of the while
loop used in xfs_alloc_zone_info(). Fix it by allowing for the i == 0
case to be covered.

Fixes: 080d01c41d44 ("xfs: implement zoned garbage collection")
Cc: stable@vger.kernel.org
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Carlos Maiolino <cmaiolino@redhat.com>
Signed-off-by: Wilfred Mallawa <wilfred.mallawa@wdc.com>
---
 fs/xfs/xfs_zone_alloc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/xfs/xfs_zone_alloc.c b/fs/xfs/xfs_zone_alloc.c
index a851b98143c0..c64f9ab743a6 100644
--- a/fs/xfs/xfs_zone_alloc.c
+++ b/fs/xfs/xfs_zone_alloc.c
@@ -1217,7 +1217,7 @@ xfs_alloc_zone_info(
 	return zi;
 
 out_free_bitmaps:
-	while (--i > 0)
+	while (--i >= 0)
 		kvfree(zi->zi_used_bucket_bitmap[i]);
 	kfree(zi);
 	return NULL;
-- 
2.53.0


