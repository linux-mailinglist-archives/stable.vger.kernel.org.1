Return-Path: <stable+bounces-249374-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GAftL79jC2p5HAUAu9opvQ
	(envelope-from <stable+bounces-249374-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:08:47 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DD6FB572A71
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:08:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0DE883014B15
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:08:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE7C5391E4B;
	Mon, 18 May 2026 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qNThfi+9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f44.google.com (mail-yx1-f44.google.com [74.125.224.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17EE538BF72
	for <stable@vger.kernel.org>; Mon, 18 May 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131285; cv=none; b=IXIiy9PP/LNU7FdqKPjGvh2f6nBwNUuzw3nE04CWRfvC4sItxak3vw5bHUgfHyKWEXXSKaJHxYFivqWgX7hwKj6mdSa/1TG7y9AQIHLVajoobSRGmy8Z2PYqk/PFb4O0RuOTLVCrvtdU95Rpryny2mGDUDJpFKkf5/DFvpOfg6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131285; c=relaxed/simple;
	bh=cyubYiPMoczepqR7H+hZPOJL+jDn0Z9aHj+sP8Kujlc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMTpEf0S55aGtOxb2NNA79Of3bmFKCzin1R0jWEzzaFAjjuIJLT12dinEU1Rf/z+5aPqGnPU9SUSq3KJm5PyNBSHj5+AMgkuP2uOD8dOtHxVupHtibyHG4+5VJtqGaqxBOgoLZp37+QRe4D9nPDGVoc9lYeTyOqR/urw5+vlV8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qNThfi+9; arc=none smtp.client-ip=74.125.224.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f44.google.com with SMTP id 956f58d0204a3-65c5361142fso2745540d50.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 12:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131283; x=1779736083; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I7T0H8dfncXmprC9fFYzqugkaZEoxcqSE96XurOHhvI=;
        b=qNThfi+9lnMXXFDlJdZa+xEqovyClsnwI2Pl6/vrk6DIKNDz96EI1BzCieKv64ZW73
         VN+e5DkPFt3WK8ImevzuSoGpStLQTiclntCTtDiw1YVm4MD6DkBXho+GGjBI2XP5Swn8
         egn6OucTRwGX96aCCXfSkSO4K+AmWI2GP79l1IqNUL7nEPWSQNChOv3olKP8ZrDZFM8q
         XhA77bBpSga6LVmzL6ph9+ouVDLIrM5FQyhwtOeDdmvpOa1CJ4MVefeu87ss8YijD9Cq
         lzEI1owedC/dvxYdz1TEqiv9ZhQfea2VJOyziHUveqxwEMDo/RJOZgvwLDEGZYehLmhw
         4sCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131283; x=1779736083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=I7T0H8dfncXmprC9fFYzqugkaZEoxcqSE96XurOHhvI=;
        b=lBoOqwUpDM8k8ejkEebXYDE1jW9es9fW4bmA2LzIGGS+f4xFobAmdIyMYjHjJ/YjIz
         LxC0QSbFUOip9BSQz+FNc7iUhX7gYbZdlbMTP2E18Nj/rADIIF1SrJOvRsyE4vydMy/z
         T1bbCNte67tOs+mVlBwOYXIgt9Dn/EQ3B75ArW2Ir4IFy6ZCkuAyKI2PzV9OO52G8ynm
         hS9HAH9fMhVp2LlXFbmozLBsNHGorfAY+KgDqSyJLwFM3Aw0iLorY4Mq4ELG6xZlru0A
         yp85058eTsS7IqD3osFyquKlX8l3JB2HAMmWVmkF0qgJvBbi+eirVas4HMKPedzGUC73
         a84g==
X-Forwarded-Encrypted: i=1; AFNElJ8Ab34AZU0Wi347Jvb+rgaFxes5zszoH4a68hSel4FOPsQ0V/hg6bKVxTVH2Ja4jPIS9aa7Ywg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRsSpnjXQWXtbwmVhSqYyhsHYgkf+mVC8f62dbs/Ig1ji9iDzp
	3NXxPLf8ox6LwSd3L8iDb4NaA8S2ecX1dpCZcACMKSN6/Ldz5L/trRqmIJJJt1p9
X-Gm-Gg: Acq92OEBN8ONchNDbz9ULVKgjCnOrVyt5ckVOfcI9tKuGVnqKstdHMUfBtPVWeEpvZV
	r8Gn3rEB4vEfpitniC//aPQTQOqA6yiH129fZaSV157GlGCWMAK1+OoEjFzjsnlqt6Iua6CmltR
	b1LC8Jyp/gPEwkATu26l1r39f1expJkBvc5D21Bemi2LXb0DFzQoK/kGvRPSwnkqCOIkKReDi0U
	2+nDQDXtfiAQfXRV7xTA3BuytDphm8ottVOtDBhYuuBCRWLqclFGT76uEC2D/Jm8/gHaPjseqQq
	SK5Idy2PWHvCQNOsyEkBnE6CWm9Fq2d7sM1kltv/2nmh3jZLOUPSmhxtOEvOXIvfxIkisYRxuYx
	yGnJeMgiFXKYRzbqNmG4cS169zUC3tTbcHd0Q/RYD989oM8owkpkuMKayyUl6kbQsr160RO8rHy
	HTlmLG1WRW2dL45MiVnyw5RmRNIXKWxZudOPz7mQSSoARxMhzTfgUjS4rRudNcjyxP6HrghqnWe
	/lsFFHO5oSNnCIS
X-Received: by 2002:a05:690e:4409:10b0:650:18fc:f557 with SMTP id 956f58d0204a3-65e2285bec6mr14123598d50.56.1779131282796;
        Mon, 18 May 2026 12:08:02 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm6766160d50.11.2026.05.18.12.08.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:08:02 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v8 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Mon, 18 May 2026 13:07:41 -0600
Message-ID: <20260518190742.61426-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260518190742.61426-1-sebasjosue84@gmail.com>
References: <20260518190742.61426-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249374-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: DD6FB572A71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

afu_ioctl_dma_map() accepts a 64-bit length from userspace via
DFL_FPGA_PORT_DMA_MAP ioctl without an upper bound check. The value
is passed to afu_dma_pin_pages() where npages is derived as
length >> PAGE_SHIFT and passed to pin_user_pages_fast() which takes
int nr_pages, causing implicit truncation if length is very large.

Validate map.length at the ioctl entry point before calling
afu_dma_map_region(), rejecting values whose page count exceeds
INT_MAX.

Fixes: fa8dda1edef9 ("fpga: dfl: afu: add DFL_FPGA_PORT_DMA_MAP/UNMAP ioctls support")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v8:
  - Add Fixes: and Cc: stable tags.
    Reported by Greg Kroah-Hartman.
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v3:
  - Move validation to afu_ioctl_dma_map() at the ioctl entry point.
    Suggested by Greg Kroah-Hartman.
---
 drivers/fpga/dfl-afu-main.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/dfl-afu-main.c b/drivers/fpga/dfl-afu-main.c
index 3bf8e7338..097a97eee 100644
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


