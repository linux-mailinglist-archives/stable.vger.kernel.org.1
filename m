Return-Path: <stable+bounces-243009-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OBEuLoqN+GkVwgIAu9opvQ
	(envelope-from <stable+bounces-243009-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:14:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3094BCC9D
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 14:14:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 473C3301C12F
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 12:13:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A3C43CF049;
	Mon,  4 May 2026 12:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZZ8N5eNT"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B36F23CEBBA
	for <stable@vger.kernel.org>; Mon,  4 May 2026 12:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777896822; cv=none; b=RhKH0mY2EL2kZ5IvWPCB8Msl71+15wV9rwADvrtNFIdWQQI9J12B12xC4asIVmS+6oE/ZydwyJmnckQiqdZjExKnLH4t6DMK+SvmEoHGeLV7Mzq6Y+E3M4c9pG37ukSzBcWJylG+XYfBy3GDlV0lKmTZlZfcS0YMtkc1uR5a8e8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777896822; c=relaxed/simple;
	bh=Egdo5vrSXhRUuwvCP13xWBmy+e12kq8TwbonylRp/1I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Obu3sCI0mKcGo5EdHZmLuqrQGh7UKCPIIIy+Oy6qnqlwXo/UMi6M3obF+tl6bc+rY7cs+BSE5pCLUMS7L7w4mI3MtvwbsyKpO3ouVIpC7qzNssVMKKtOD1yRLclk88cd6ZqznxV3NUs7tErfaGCuHwc9s4cbPSUu9bjWiVvHdw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZZ8N5eNT; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-651bc8f864fso2615417d50.1
        for <stable@vger.kernel.org>; Mon, 04 May 2026 05:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777896820; x=1778501620; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/70r6IqZMUzMPLl+F4JoQGxVMmdN9u1Qh2Ykml3WfQY=;
        b=ZZ8N5eNTxmG2M6cMkJCHmZjJxcbyazwHJ2F9x7BD4h6bBXjSwvzVOCbpdG8Kv35uhF
         U4Ci5jjKTwgozMmkZEPA+mBmaTvCXzqrMjIRi4fTjsSSizkcM8ys9D3afpkV1t0L+WbV
         a9yJXmbkHAMJScUtamenb6tH3rW7UzKrTno6zB7Ya50zTEtF/HTpUoZ2nXlOzt6NKzFG
         45wpnJH5mVgGyT0+G+94bpjXk6YRudke0RnnZKNheiE1+nTP+tVDPqI+0ni/+gGA3KfM
         sL7GKxArHVVfsuPWKEnOJrt1wdT5xgIyIFrdOEjK+rbDO51DTY9t1tC/3YNx9Ipv7ewq
         z16Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777896820; x=1778501620;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/70r6IqZMUzMPLl+F4JoQGxVMmdN9u1Qh2Ykml3WfQY=;
        b=K4/WuPy4kUYUOGiquiMzT2ecNQNiWV0ru1MCl4INJH8tt7S9S/0MDEghu7/cfv/HTc
         qfHBfJfBnpvriuG+0kLRQz1jHBQvJAW2O/WtXXwrP5aOJmiA9UI5X3aGY//Ebcx4uNyd
         +64A4aZCKx+6cfYYFAdF3iyaFN8JPUjpb5KhlN/+9yQe6fsNwGxoVgwtaW0vibz0QBs2
         dP/Ahi6XuG7svLnkWCgMmBSTIAA6evHBsHep4xN306+KjRpeEctOLOVcfkDw+bF8Y0b0
         2PmtO0nGhZQ8v0p0rqfAVu2gef9XI3xIoU88YmV5UGWdV7krfwVfDIZv+Dhdg7KrKDkf
         71PQ==
X-Forwarded-Encrypted: i=1; AFNElJ9Fed0D3BDGLHOAhboQ3aSlcuXejs7/HYRBEawO6+kBTT8xi4dM31p85OzTinmj0aktHLWnEYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8QkuLeEF4F9BT9yZl2ysYLWTx1B17lsEkSpYWYLlOg4N5TH0U
	fQBkVon96642DeMeGxcerTZdg2Uvqv1BR+CvA5mLeWglWWA5mBCkYlxI
X-Gm-Gg: AeBDiese0sM4HTVE6Nk0e6rn7ugeDkZcV7rdYihU/UjgJdIr+h+Iv0M36/wWVXnbmVE
	SGz6liF7G9lLJoJFFCUgilO1hrx3KAHVrZORXkrCbzLoMi9bApY4KJVlGU5Ft8pjaqMM540Wyyl
	ueQW7MsOAZMHlbSyyOMc3SwE1o+KSV8Igo/NzHdfPknB6DenpUlDrLMyVZIF8VMo2LfcA9oI/g1
	LfxONJSZeXiX8/uWhtQqXZBz0OMiZBK2HI4YM6FqbhdK4j10djOOqzkm9hyj4u+PB4BTEBS6rpv
	BfrE1zR/1+mmmpiEn6YJXoFkoVpH5cMiHHYnkQvJRQDvi9tRl2pPamy53M+K600hjfujQY3H4Ke
	CtPtky1Iywu7p7WyvkOjPAWjUeE2TZLphrl3c2V/Aatr7ltONBaJFJzTJIJkk8gpLJ2enuWKWhL
	4solqS7cEvcwF2Cfk+YvAP8ZCOA9kc2XzlpGTFmwDO0TLoK8NUL/ztRmKIND65gHirCQ==
X-Received: by 2002:a05:690c:e3c5:b0:7ba:154:87d1 with SMTP id 00721157ae682-7bd770dbe69mr97087697b3.33.1777896819793;
        Mon, 04 May 2026 05:13:39 -0700 (PDT)
Received: from ubuntu-linux-2404.ts.net ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd665464ccsm48417937b3.11.2026.05.04.05.13.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 05:13:39 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v5 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Mon,  4 May 2026 06:13:31 -0600
Message-ID: <20260504121332.1053563-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260504121332.1053563-1-sebasjosue84@gmail.com>
References: <20260504121332.1053563-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 7C3094BCC9D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-243009-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.998];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

afu_ioctl_dma_map() accepts a 64-bit length from userspace via
DFL_FPGA_PORT_DMA_MAP ioctl without an upper bound check. The value
is passed to afu_dma_pin_pages() where npages is derived as
length >> PAGE_SHIFT and passed to pin_user_pages_fast() which takes
int nr_pages, causing implicit truncation if length is very large.

Validate map.length at the ioctl entry point before calling
afu_dma_map_region(), rejecting values whose page count exceeds
INT_MAX.

Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v5:
  - Resubmit as full series with v5 corrections to patches 1/3 and 3/3.
    No changes to this patch.
Changes in v4:
  - Resubmit as full series per maintainer request.
Changes in v3:
  - Move validation to afu_ioctl_dma_map() at the ioctl entry point,
    before crossing the userspace/kernel boundary, instead of deep in
    afu_dma_pin_pages(). Suggested by Greg Kroah-Hartman.
Changes in v2:
  - Added cap at INT_MAX in afu_dma_pin_pages() (superseded by v3).
---
 drivers/fpga/dfl-afu-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e73..097a97e 100644
--- a/drivers/fpga/dfl-afu-main.c
+++ b/drivers/fpga/dfl-afu-main.c
@@ -723,6 +723,9 @@ afu_ioctl_dma_map(struct dfl_feature_dev_data *fdata, void __user *arg)
 	if (map.argsz < minsz || map.flags)
 		return -EINVAL;
 
+	if (map.length >> PAGE_SHIFT > (u64)INT_MAX)
+		return -EINVAL;
+
 	ret = afu_dma_map_region(fdata, map.user_addr, map.length, &map.iova);
 	if (ret)
 		return ret;
-- 
2.43.0


