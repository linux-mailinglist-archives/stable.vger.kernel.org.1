Return-Path: <stable+bounces-245568-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gLmlKpsrA2oz1QEAu9opvQ
	(envelope-from <stable+bounces-245568-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:31:07 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 312E052137B
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:31:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1604031E144F
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:14:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F26C397AF5;
	Tue, 12 May 2026 13:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7DidAs3"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93040397AFF
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591253; cv=none; b=RSG96rj/6FIpy0AL3PxHZFwCdNCjrgm9lCrhmStQZLUbbFpKZO5tQsWUI7cH/0bK7B/rxjBG9FHWPodKpVwus4IKSvQMdIUzne178CM9BoSI0W1mG7meBd6XL7PnYUvi8Q3ZD81VdgLG8WOar/E2ICTQJiakq8fIIhSN6YRtbVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591253; c=relaxed/simple;
	bh=POp2n1MrrBwf4XyFtHBqsdLJqGpnHG4C59dkVpAvLgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cLj4kktRHPmZTLpoBJYKWned1B9LIXZGFkvtojRXkjp1ZCQmXpwW9ruFlDt9tI7892ukN9oKrATw44YeYtp+JSZ51+jAm7XTWYRbJaNr2yYwFMf2ofCtSXibEy4V+xP86ncgRm8EFvmTbcktwatJhpk5HzmwAAh/lVY8dbVtgHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7DidAs3; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-7c0dea734bcso29997447b3.2
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:07:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591250; x=1779196050; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iOG4qriMr29psJVDOI0klbLQYjbJN0xxiaQ5zdjbGPA=;
        b=S7DidAs3BIgOX7gYt7VHXkXH0BpJgSe8o00099C9kmDy5JGw5wtsDsnwThv+wU83Yw
         D+rJEWFlu1c5YslnT5sqSOORwJbkri74NCgnkfruHJVsN5oIVP+upmqyRNrRBwGrNBHk
         UjEhB+wMlzFbh5K6ndQUXk53loRADL5COzz4gUeh8TXi6iz/OyjdDT/B/5pFn+9SoCpy
         CMffMJ/Rv5wbARqtowGpqf1rkE0KFV2A9SaQm/fGE9gaitSavVXaYtAk060wJneFNZuC
         Eo3XTKPQPDrYz90m+f68dHauihpEVE44d1yzWVRRi4jhIQZe7c28RCOSRNavSVpLym7o
         Kcfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591250; x=1779196050;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=iOG4qriMr29psJVDOI0klbLQYjbJN0xxiaQ5zdjbGPA=;
        b=diafQ+spsTpR4MlyA7lhUGI1yJONJ0hYZoGIzJBH/eP9qnjN4++xQN8z9kDn2SN4eC
         /mHb/uXNpbWOiAMhaSDLjOIxvc0MiPi/cZBy1jKgA4UsrxFJ/HVJdV3N5vPCCl1va4io
         ksj5+MMaDKJPSZwG4VCBXc2s/seQdDnepzcjHLifrxnzwubtQHTnjQTTeze//nAedAy7
         UieB8h/kUcGbi8Q4vr+3ABOiGLyhxlpRip/F7zIf65ZkoK18rvBcmn09rpCUG83FkL3H
         TPXhm7FX3j8XX5pRf4yXqT3KQRgKy7v+XsxcUtU5diJWoQX5a7CQoIs5Bo7gTIf6dVct
         3DfA==
X-Forwarded-Encrypted: i=1; AFNElJ+zEstm84DXHwISB+l2PG3CTQnjlXVM03he5x2HxKG1qqSZq/wei5r7BT02ax1uDbr4xSwEqSw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzPWLBW3Qr2RvjRklRxUWLXw2GScrOW3FKZlmMnzNp3ueJAbeNw
	WAKchdIPS0SvJdTHD7GInsjoo6QlZq4ZnzbnGwTSWOJXIgFRbSHIq/kY
X-Gm-Gg: Acq92OHDf9zbJueEcmCnxYXvNv1MxL2cGd81WMlJX12gq/IKPIV5BDmW+hMW/wn/Cck
	YcZs+cQ05mjOUk6S1FLwalZyax7PILdthv8vHXd+hNbZaobVPwcpkfYxvxDhnSkG+UXrP07iNan
	6PejNgJ9mt0SXYPCiI2RbkPT8auILt8p/INLvTOF94VrbpyJ51yMcOPn1KIIhesdW4fU4CIhx3K
	GqaAPQY5A4m1LJMHi3pp+5nUA0OYABQg0HIL3CbdI+swwnU4+i4rNErwrOB4EsethAba87yp2ke
	z2v77HZwzpiJ6y05OmiYTG09pjAG+bmao8LRjmItVbuDE61NIZo5iI6CxkRkDO9X1Svoh1x4YQX
	pN7LfA+0GsHnpeTRmxKSMSG9t7v+KLMafQabgPtqfLNDv8jx49tGvnf/Yaw3wMzU1RaxknPy5iu
	w3Ul17IDvXpp8dACR5ff8sA4+FXsLkiHkSZ7S8fU3RmU6Spt7DbEl+KmZW
X-Received: by 2002:a05:690c:22c6:b0:7c0:82ec:fe75 with SMTP id 00721157ae682-7c10255d217mr127949657b3.10.1778591249713;
        Tue, 12 May 2026 06:07:29 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm167459037b3.39.2026.05.12.06.07.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:07:29 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v6 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Tue, 12 May 2026 07:07:08 -0600
Message-ID: <20260512130710.933089-2-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512130710.933089-1-sebasjosue84@gmail.com>
References: <20260512130710.933089-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 312E052137B
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245568-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

dfh_get_param_size() can return a parameter size larger than the feature
region because the loop bounds check is evaluated before incrementing
size. If the EOP (End of Parameters) bit is set in the same iteration,
the inflated size is returned without re-validation against max.

This can cause create_feature_instance() to call memcpy_fromio() with a
size exceeding the ioremap'd region when a malicious FPGA device provides
crafted DFHv1 parameter headers.

Add a bounds check after the size increment to ensure the accumulated
size never exceeds the feature boundary.

Fixes: a80a4b2b2e4f ("fpga: dfl: add support for DFHv1")
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Add blank line after the new bounds check.
    Suggested by Xu Yilun.
Changes in v2:
  - Use (size > max) instead of (size + DFHv1_PARAM_HDR > max).
    Suggested by Xu Yilun.
---
 drivers/fpga/dfl.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/fpga/dfl.c b/drivers/fpga/dfl.c
index 4087a36a0..4c63c7c85 100644
--- a/drivers/fpga/dfl.c
+++ b/drivers/fpga/dfl.c
@@ -1132,6 +1132,8 @@ static int dfh_get_param_size(void __iomem *dfh_base, resource_size_t max)
 			return -EINVAL;
 
 		size += next * sizeof(u64);
+		if (size > max)
+			return -EINVAL;
 
 		if (FIELD_GET(DFHv1_PARAM_HDR_NEXT_EOP, v))
 			return size;
-- 
2.43.0


