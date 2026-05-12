Return-Path: <stable+bounces-245569-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id I6SaLJQsA2pe1QEAu9opvQ
	(envelope-from <stable+bounces-245569-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:35:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 134D45214AB
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:35:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B7D9A328C121
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40D743C2BAA;
	Tue, 12 May 2026 13:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q4BrFZ6B"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A72363C1F46
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:07:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591254; cv=none; b=dhPbKzz/Z5P5ORkLcpWKwmn0CZNvjhTVRji/hQlA/wWBm1OAEHRLqWH4HtmXjUCS8WxAZdlrAXjehpj6+03kLDTQNDfp91HoGV6S6K8qRQ0M2XtZnCc936sLGQd6zxdk5hIN6dQ9RHnk3/pISqLVfLbapitLAaeWxiGKzXSMBMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591254; c=relaxed/simple;
	bh=4olwjdhUJV9yQf5ckjVh6vmaJyDU534e4WimvLGZEd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PC8Rg4OyIPbPgQK/mVFY6n5Eh2JOAMT6+iIGEz/JyLpc3uKzwjhbLOo81obRaiMknJ5ayRcerPq0z6TnoTAUXrbnqQEncUrZy1LYhukv8YqIOgsFS5wuH6ZaDTJBo3FXKp7/oXDo1RcwGGyYnoI4QcYThU7Sd5gaOgzOl8GUD4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q4BrFZ6B; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd8cb26219so30070937b3.0
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:07:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591252; x=1779196052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dF+t9homXAdxJUbJz+MKrPNemeLBnB/WpmMKz7l6PWU=;
        b=q4BrFZ6Bq/LCPbof2IuGhWOTrhZn9jEIKA6ZldUBuBNtEKnJGhD7UGDjvD6zxxgR2h
         pHP6NhroLwoWFAriD/RFwcvtRBPxIOPUUtVdMnrkyakWVcFY73bONDeO5b8MewusCOK9
         T3aKmuVOzqR6l2FuZw5w+EAzdWDFXKhvvyro0pL040igPaqS9svVY2Y6mHAGz7LOQpgR
         h4mOK/aZqpfxGyiRoxy9LDD5vjBXMO9SY8KQjlv7rfnfrbiIvIChmkKmWfQ90bPusb3g
         iduvcCTdAAGo8UHCCyZqsG5OlyDgj3N4Tf3ZYPe9zfRjqb0HxDiMaUF0fansE4w4BSLr
         QEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591252; x=1779196052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dF+t9homXAdxJUbJz+MKrPNemeLBnB/WpmMKz7l6PWU=;
        b=KAT0DxwyiQSpHj+bFTu4buCJk+hU/+Hzg5Yc3n1I/A+l5Z+zileF7shwfRHF7oo5in
         O0qdq4/ST3qMTO1XLl/pyt2pC2GVxd+Mxl1Quc2W7sCNLQaKwFGgAXGLIUu8uS04odSY
         cQ8goCROnOT72tltT1w2xNwxf/fYgsVvqKeIDcOJO9l8OOF63cylFkcsIO6Th8LEOgk+
         /hIvbQe8WhN3nGLrh8Yo8cv+UXQqcYdWJvguFjTiJ0Aiqd3I4Urg+67A3xbj0gxZkHqR
         GDnzbaK1ER5FLxZLONY45Aky8eWwNaJY9tjLuq+PDN60k4a4uB96lb5+isU83oIPe0/E
         cQOQ==
X-Forwarded-Encrypted: i=1; AFNElJ/EJvRzX9YGCHMaYmrfhD+AQtxoNqCVDeiqMWpq8z9dsquVXSnbcvDj2wsV3pVO6IH4yIbl1pw=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys3EcLrcFdULxS1dm4/ieo87ToedaO9xOYAEWouUY2DaXKUss8
	dffiiua+lAkTIXTlUEBmPXf9ts+JoNqZy5xAw8YKwS0NbOIIMksSQg5K
X-Gm-Gg: Acq92OEbmI3ET01+0lkuh4d7n0Rvj2ZkeSBXCp33bV1n3LNk93G+lALKwrNjlHfwvni
	x0yFenJJ4E6EFyN9Ur3s0PzrdufvdUeAuIvNWjNdD0/X3Y0fSouehnOAI0dNuRXQAr1DurhhVaA
	9v/N7eIuwfVxTeb/hSrrBMJvoZ66nYFVbPC5hlAjUxseCZt1xCg1OGepmrjdDESvJOlgMW6q3wE
	7JOkM8rwD/8capw0Ya2P4XCA+GbokzKy7xQ6xPutL3UYbofb+ixrBOdAEWG5912wCl3U2xb3S4Y
	loxANeAACfObbn97o1xoE0hULoAkr0GuMgakRPdZA0CYYoTDsHVJTEUf/e5o27kQdK6BAb5Gjjo
	8fwvAedJQBgZbnV+06cPAzaURksOSphIpCn1rjoRH16m/Usvk0CdzjKwe8idJfy5cKwTxXnGf2H
	azEfRzYPylHMs+sfG7UmBekkaKdaYGqlZmehZniTa/7Mo2p095DrBS4zLn
X-Received: by 2002:a05:690c:6612:b0:7bd:a4dc:c23b with SMTP id 00721157ae682-7c564141e00mr26031567b3.49.1778591251396;
        Tue, 12 May 2026 06:07:31 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm167459037b3.39.2026.05.12.06.07.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:07:30 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v6 2/3] fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
Date: Tue, 12 May 2026 07:07:09 -0600
Message-ID: <20260512130710.933089-3-sebasjosue84@gmail.com>
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
X-Rspamd-Queue-Id: 134D45214AB
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
	TAGGED_FROM(0.00)[bounces-245569-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


