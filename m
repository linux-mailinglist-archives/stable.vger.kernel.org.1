Return-Path: <stable+bounces-208117-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 525FCD12E7C
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 14:50:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3134F30B65CA
	for <lists+stable@lfdr.de>; Mon, 12 Jan 2026 13:46:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2AC35BDD7;
	Mon, 12 Jan 2026 13:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nJOwyigC"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451E135B150
	for <stable@vger.kernel.org>; Mon, 12 Jan 2026 13:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768225607; cv=none; b=R+MWOizkpozWS2SQAIIbZyFkmSDb1EcgXoY+Xu3fsR9eMbP0KSRuXerPLv+oK0ewfGpJS+vqwRWpIptsO1DDjgqUgtn4I+uknqD5joU1u27R+lqFjpkuVnPEf8PGsXkdUxjtSrulPVjcftQAQHG/s/H7I7ryYXRgQz3g6eJYxuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768225607; c=relaxed/simple;
	bh=Bv3qBy4+6Y3vuNcEVDB+hKAOGNXG4Ls7bTshKwoyfE4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=CimDLIbtQnd82Y81vhziKfFKXhxu4R85rwlxcW6BsUZi98x94UwfJdnQvqTkEgLbAD8TTv52qQgUJtBdsZ5PV3K9RCYq255JZbISiAUqnwA1qjoIr0/bUmu3tAyNdmoEVPxZiSfjfb+A9TWrQS8cLsgWMao3GiBFkMYAEmGdsc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nJOwyigC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-47798089d30so5802465e9.1
        for <stable@vger.kernel.org>; Mon, 12 Jan 2026 05:46:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768225601; x=1768830401; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=es+qBMxJPTkLDqGMs0DKU7nfnSOFsDewoZYlUkiYIcI=;
        b=nJOwyigC1wbWFfWbHKNbKQzVCHcII6oHKsKdVscm6Oy227Zg4nUVUWvutpV6xl3eSO
         P9sTVz/c628fhEjDG8VUtM26WQsAYSyv7Pn5jaTBIFxHjZUlvKbOwc/dUaPSjlV4QEPy
         Cm+wvmRCMDzATnC0aRQZQgWJ2ET+9RM9vmsIN8S59xi7uP8ZykudHR9nBBb9UQ7olgTb
         g1zmAMOh11STflau+l3d8ysquXZPXn+Q2BS44OwwaJljlRwucrb0tdNwo5ocNcVYuo0o
         3DMjWTmL7HYuN5fodDbeY+2cazkWrX157Q+aQ+fzB5uZphIZ23YPq42I7oC08Cg7RGYU
         B1gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768225601; x=1768830401;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=es+qBMxJPTkLDqGMs0DKU7nfnSOFsDewoZYlUkiYIcI=;
        b=blDgceqnOIDPRkgipY3G3A+PVHz59q3ljZuQWcQc+INaOEIfWxJ5RNuPVQDx7nWKdq
         WkOtLkMgsDZFmsDZ0uYck7+uRMynq/KjFwP0yKG3lLE26TbFEgx8p7elw69jLa1JJk48
         kiAhjbOuZTKFpWwCyAxSsC81MDsAcg5DEfa+MIrV5JfVAXdcHjkqDW2yBbwHK8WKOKgS
         kWoaXnCWXABp3RAhdqgDG3ai8Jpt4YqYA4Q6ST0FuXQjEeGBaUkWRL4kyRTe8CIlcj+g
         O0pu0cn3nDkOHdwwbCZdqllOe881SS2+vjNJU5rPZ0WwZyK5i2qn2B5+W39GdP5SgqTq
         Ecsw==
X-Forwarded-Encrypted: i=1; AJvYcCV//T99blsa+GX/gdN+XaNNHd1qZ+opW9AJq12+MSVZVrhg6p+Pq4iGnBO/sSD9MkNmVSOmBt4=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyp3opj+9c1XRqsFCdcmJQs1NEJ71ILfKmWKbhCLZpUaXHJ63/j
	k4tNkdvHkSuv4c/39srOe0si+bAxjGBMolU8ik/872Qpd4KcpVbhLp7B
X-Gm-Gg: AY/fxX648+7Wnrio5WY07rdqKMq97dDkNhsFNRPifbDYn+S5mCnsioTvRmLCK9Zn00K
	kVj1yhodIr9PFQTBEA2T4B0PCvz0ceI7mV0WJBnLMG6yYWhRgNY8CmrK0/hqe2S0rYFcAo1kVtP
	CEpaglSamXC3pZ4lnMIJZn2NYjRZX7JIgPoVuJx/ZLm9qFBT2J5SaMaE8c1Zz2Xze5AmnGeg9Sv
	sydD0sprCtgrqaY4icWGDtG6PI+ZhYqShpAOQuB6MOhQM3UFeqXmwWzj8dsM9XmqelcnQ6Gvvzm
	FXNGTUUlh7Ooww4tS6xqHqUaIBWbJUF1ri28SNUwZVa4OXw8mlbOieu4ZkjMAWsTqHmaoHILz7t
	jMSEirR9Xmeo4eeFTvF4kpBGIcPShKeMh4cEDzOaREVJ+8iOqMxoNvOEisRJOAG9UNi75SfHoxV
	GjZPMGn7UYU/lASH+2+bw83eH4IQnblwLR6J8zXt2e6KlaA4KueYbEGH1O0kzCnTGmr44ejo2Pp
	Lzoie4=
X-Google-Smtp-Source: AGHT+IF9z6VjQIMgTfD2brfQRa4uGZOlR6wwUJHpWLiS5CGfO5mfqE6ysQh84IO1RlX2FlItb65i2Q==
X-Received: by 2002:a05:600c:3e0d:b0:47b:d992:601e with SMTP id 5b1f17b1804b1-47d84b0a0c8mr134457105e9.2.1768225600494;
        Mon, 12 Jan 2026 05:46:40 -0800 (PST)
Received: from thomas-precision3591.paris.inria.fr (wifi-pro-83-215.paris.inria.fr. [128.93.83.215])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-432bd0dacd1sm38122724f8f.4.2026.01.12.05.46.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Jan 2026 05:46:39 -0800 (PST)
From: Thomas Fourier <fourier.thomas@gmail.com>
To: 
Cc: Thomas Fourier <fourier.thomas@gmail.com>,
	stable@vger.kernel.org,
	Nilesh Javali <njavali@marvell.com>,
	GR-QLogic-Storage-Upstream@marvell.com,
	"James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Duane Grigsby <duane.grigsby@marvell.com>,
	Hannes Reinecke <hare@suse.de>,
	Quinn Tran <qutran@marvell.com>,
	Larry Wisneski <Larry.Wisneski@marvell.com>,
	linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] scsi: qla2xxx: edif: Fix dma_free_coherent() size
Date: Mon, 12 Jan 2026 14:43:24 +0100
Message-ID: <20260112134326.55466-2-fourier.thomas@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Earlier in the function, the ha->flt buffer is allocated with size
sizeof(struct qla_flt_header) + FLT_REGIONS_SIZE but freed in the error
path with size SFP_DEV_SIZE.

Fixes: 84318a9f01ce ("scsi: qla2xxx: edif: Add send, receive, and accept for auth_els")
Cc: <stable@vger.kernel.org>
Signed-off-by: Thomas Fourier <fourier.thomas@gmail.com>
---
 drivers/scsi/qla2xxx/qla_os.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/scsi/qla2xxx/qla_os.c b/drivers/scsi/qla2xxx/qla_os.c
index 16a44c0917e1..e939bc88e151 100644
--- a/drivers/scsi/qla2xxx/qla_os.c
+++ b/drivers/scsi/qla2xxx/qla_os.c
@@ -4489,7 +4489,7 @@ qla2x00_mem_alloc(struct qla_hw_data *ha, uint16_t req_len, uint16_t rsp_len,
 fail_elsrej:
 	dma_pool_destroy(ha->purex_dma_pool);
 fail_flt:
-	dma_free_coherent(&ha->pdev->dev, SFP_DEV_SIZE,
+	dma_free_coherent(&ha->pdev->dev, sizeof(struct qla_flt_header) + FLT_REGIONS_SIZE,
 	    ha->flt, ha->flt_dma);
 
 fail_flt_buffer:
-- 
2.43.0


