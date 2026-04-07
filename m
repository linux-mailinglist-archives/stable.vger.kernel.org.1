Return-Path: <stable+bounces-233701-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAR+KyU+1WlY3AcAu9opvQ
	(envelope-from <stable+bounces-233701-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:25:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 51F943B2574
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:25:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0508230D5776
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BCB533F38B;
	Tue,  7 Apr 2026 17:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j4RU+hlp"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f171.google.com (mail-vk1-f171.google.com [209.85.221.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05C9E33BBCF
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 17:22:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582574; cv=none; b=KNComDjpllXztamEG329cTTQsHt8ZsGKyXH5ionv05bN8qIcSbFrfJ/arhSj9UEcWx3ayDCTvk0XW+fH+s2ZIF+4NgA9K+3+pOH4pHJ3oDZhN4G6LbqxUocObcCNOSUQJ6DJlyEHZKcyXCAJ6jgJgcVxjHQdRF66a0S2kPATlS8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582574; c=relaxed/simple;
	bh=PENGNB8rrodSyMDYvWj45yPQ3gnAi8Ng4MHvP6kqE/I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARIzeUaDvWcV7imUnky/9b8vaFqePT5drgqDS8QrvYL7jbxLI2gQBc2Bnk/sDo+iuS3u+3fAJZoA8HCVqAZTAuV2nOXZYAd2qJ9v6beLvz62mJu2lzPB2P0ioa5Lx2vj35B/P9BfF5+IMSALx/mPkYSzfdrG0epAt0tbQ5x7goQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j4RU+hlp; arc=none smtp.client-ip=209.85.221.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f171.google.com with SMTP id 71dfb90a1353d-56b8804f37cso2260655e0c.3
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 10:22:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775582572; x=1776187372; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AFNdcYKOl2EgqlFAIeHqA6NsZRC/Ddu8gl6mqtB4eGQ=;
        b=j4RU+hlprmOQvcemICAkutmedMVLhzuZxEkr4YAiuEeKhoqiRUYDMArVQ0vtyObADJ
         yg/M/xRE6t+NTBaIXtXihcdkxneTEzpAMWKHLnp2YYzuLvPllSxFlsnrNqD93ZFDIuXg
         NVZ2davKtJaaC9kCNS6xgNJ/AF/liLBcbHYpTW7aPZs0iuAfWKIg5/DciZ/5EFO2J/NK
         WALMpyrs97eRjKFfO1S0LmrQTOALzV+IbPFs0Ckz9IARgR1YYkYH3XehJzcVA8k/hNbv
         gOjwHSn/HeFvkSIlsdUYfRLJ0vx9GIwrXGKdoXE2HxRNAa2ywCFyL3tx0KttbnbtGm6g
         NPmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775582572; x=1776187372;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AFNdcYKOl2EgqlFAIeHqA6NsZRC/Ddu8gl6mqtB4eGQ=;
        b=ERW0fIKbs7SYsIaANOeBGhl16Cq2qkjXnDQzEak8NIje3M+qvor7Fikn4Zx/vQcRwi
         xiVvRe3FqqOHMaDrhjPnmAPLFINKs2bPKWlt12l8BHZX8r5TUsU4NLh28RGhuYjjASPV
         TOeJHs0azz4LATKGZByrf7Nk6hqVUnOLgDVotDoWkY1A1IabSHn82ljhOASsSIxNZQQ+
         WbuvKa75TvPQWKkn11FBqQYUI9UEt5mBLLOoxTTbn8lFlXf2stZ3fE7ZRoKKfWSpCQd+
         v8gxZcmvE6Io+ArBjq6VzYaI2Fh2sN6zayMPUdHUw278WSSZdcUYhq7R9Xm1uD4cODhh
         3OOQ==
X-Forwarded-Encrypted: i=1; AJvYcCWU9oOuL36UP95/5kSR57+rhNVyQGez8evezqFb9ypPD6XA41QCpbhOXcSZpBIEqFR1LNS3pKI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIiUpzmW4R8YVTzRaGk+viiKDKwDQrTYyAGsnjmtwj0zEMQTfP
	cvieintb9DJE1jQq8x8dbfOQDVXypRhsCStB+40Gsn6xFuPmgVv7j/IG5zrZVpLB7vPt+A==
X-Gm-Gg: AeBDies9WkiMlc7WZ8CnbdKEEvuxz12eHYQ/UxVsavo2AjBfMBKEWDbGYs4UdKPnMOX
	vIolVJv1ua+qB2O5J4TZ0QMpwG1uOn8MVFqoohuGrqZvkP6pXm8UwxABiJZMLYxAEJOW9A1oJ3m
	pHvsb6McPcyPoDAHEtARcvbazrBn0r8p80x8VZG5QJfWLG7a0XiSmQnXDCSs7fFPfxL8XxK9Ftd
	MP2P2QzYgG0FJoNTwOiZyq9p9UGycGTEsQ0IgqgjoNVqHCV916xQQiHFQZuzZHzU1X0hD2kFLJ6
	mXMJnQxOHGzXPSLRssfUW5kid39IqUcpBjaFwK5DmSLFnjFsDAgdke60rSrYOmhH34u4lby9Oa8
	59UKR2ajCWZH3H984DyAxoKMEFI1p02dEaEnGp7PerxIr9Va4C7Kan24SWfwVrk125IqovHOC05
	zr3FpdTmwhAYaEvWM0tn1IR5R5
X-Received: by 2002:a05:6122:3701:b0:56b:9083:4331 with SMTP id 71dfb90a1353d-56dab9fb8ffmr6358028e0c.12.1775582571921;
        Tue, 07 Apr 2026 10:22:51 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d74:aa::11:155])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bae1117sm18878435e0c.7.2026.04.07.10.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:22:51 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v4 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue,  7 Apr 2026 11:22:16 -0600
Message-ID: <20260407172230.40775-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407172230.40775-1-sebasjosue84@gmail.com>
References: <20260407172230.40775-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233701-lists,stable=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 51F943B2574
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

Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
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


