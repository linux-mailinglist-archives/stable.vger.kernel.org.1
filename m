Return-Path: <stable+bounces-106287-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B96909FE6FC
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 15:21:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0B1913A1B31
	for <lists+stable@lfdr.de>; Mon, 30 Dec 2024 14:21:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02F121ACEDA;
	Mon, 30 Dec 2024 14:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="o17KKDy4"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E059B1AC42B
	for <stable@vger.kernel.org>; Mon, 30 Dec 2024 14:20:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735568454; cv=none; b=I4+C6kGclsTZ/QRm+i5V14JmDbnHOta+mm5xbPmW430D9afyQXHmFDJJ2n8xX60fVZHq+gQX325fOum41Aky6RHBTKMhQ/Lwu4gBVwZH2jKLr/bVqTuV0UTymneDpHbHKjvZWFZ5MhgAnfYkAPs/IIY/Ds9OLvbuAq2VZmGMxzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735568454; c=relaxed/simple;
	bh=WQzH2nzOt0XELOhPECgQdlAzFp5KYY4CijVbF4W8c/A=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bRyJUudV9ZMF5qz79e+wW+QoKvONObhpAPW5goBZ8DPjfcsOVLwjHbWI6WGtIWi/BvdK2E+bBNWKwjdYsVpp6/aJFd0z05OlZ5o+7XlR/R5rtWGxRqCralAcfs+HHXP36FLRyGKMOk4hfU7paCo0Ll87b7fwUHOVghna1X/2TCM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=o17KKDy4; arc=none smtp.client-ip=209.85.221.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-385de9f789cso6969731f8f.2
        for <stable@vger.kernel.org>; Mon, 30 Dec 2024 06:20:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1735568451; x=1736173251; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vXqrhvbs9T7x3lm4JhTEiWk0/q2Riu6DpR6jegYoWQM=;
        b=o17KKDy4FrIjW+etAh00s5swa3iTVk4oGCunkD9pzX162JlpaZM0BhRxkZI7bdZn63
         AnJtQN3kfvp5Rso99Ds45YZTb+lYnNcebbhUVGYcliIVYhQGsZHMLxIo4GCnoMsLDo+L
         IQpXqNiBjfIUANwjZAI4gaF9cKJOfZ/dpJvP576dbdyHIqJPyRD8aCKH7zPsxSPIKw3q
         opFMk6jnvcA1Y5on4AKIr3poIiS4jwhoeJqo6O8UYLkBaCdQseH0ABSb8t4mIG3Ghrxr
         BrYq7WctO0tR1C0+z+RPqQ0D3yPlkkNTLGf9WZG+vlx2mdnvU+vkkdoZxj+1CdS9bc2f
         OEHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735568451; x=1736173251;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vXqrhvbs9T7x3lm4JhTEiWk0/q2Riu6DpR6jegYoWQM=;
        b=xSb9RZSrxMqR3nHb5fkkLvpuT02KQFZXj/zo+2puXmOYRkPPmyVDXeth0u5LFC05D5
         KOT2bQ33B+KAMU6Cv875Xzjxn6Qcr8EhyDyKcZFXOkS9XtNeE5QXcY4XGEBgsci5io8X
         Zhgwk3/jjGD1HtKOVpYgRfE/YueJkbA/c141dPVP5fru+osFGYah7OOhOXl8cxM1um2A
         m4et9Nt6ejGTXgr5gwhsmSbMGm5HOx+pcA9P1hh85pIsthqQYoUIN6oNyDEa1sTnCPJL
         KDUAsmFUblZsezyrIMl4s4muWiMSUvgWKgh8uZB1B83+tsCi0+G7IebkWOyfBRjdBllH
         tcPg==
X-Forwarded-Encrypted: i=1; AJvYcCXAbf6OdJ3ePi/8pstSrmMMyzpB1e4FOFH4LNvylteFBoWY5+VEYlNqJ4XhC6ZeTQ/xh/qXPTg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIVy7vYgN6/o8CXLSxxcNr/BVivai5lee+OEynjyvCvk7Fq5RJ
	WbNWxEKEOWw3siESNm8ad2pUmxsna66EmJW0MkERL/27i0ztpJtkD64IVVLMNkPc8Doc7Jmt8XT
	q
X-Gm-Gg: ASbGncuQMLQi4RNRbsSZDn+b0JXjLYzZRpqcpOtH+7BjD8XWzQSemx0iEi190UBWcSd
	xjawxhidjFE8Z8xY/6f9V5fwnbCOHCyz9XDwYPOfoHLREHRRHnW2Tk2Zqu9uQs7Tsa/xG5cR+Ds
	HR43oIWhs7vrkCdGWh1zNc9bTOykOJGNsaK0Zbc+7kT+7w5qc6iF+JIh6vve2x+UNG+tl5J/RM6
	MUV53PP2ocqVjD285vWTsSWYE2/cFiNpIOuqcQrsx7lDU1jYw4AOC64uuckTs9TaQKhQcJdzvlb
	pAbuvQ==
X-Google-Smtp-Source: AGHT+IE1ta3+RLtcAbVtIgE6ruGPjb189G00giWmI+CbNz4RIJtuy0OVeou90Wz5humN5tA4Mqb1GQ==
X-Received: by 2002:a05:6000:1787:b0:386:3c21:b1ff with SMTP id ffacd0b85a97d-38a2240ffc3mr26385979f8f.58.1735568451212;
        Mon, 30 Dec 2024 06:20:51 -0800 (PST)
Received: from localhost.localdomain ([5.133.47.210])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8471dcsm30377536f8f.48.2024.12.30.06.20.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Dec 2024 06:20:50 -0800 (PST)
From: srinivas.kandagatla@linaro.org
To: gregkh@linuxfoundation.org
Cc: linux-kernel@vger.kernel.org,
	Jennifer Berringer <jberring@redhat.com>,
	stable@vger.kernel.org,
	Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Subject: [PATCH 6/6] nvmem: core: improve range check for nvmem_cell_write()
Date: Mon, 30 Dec 2024 14:19:01 +0000
Message-Id: <20241230141901.263976-7-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241230141901.263976-1-srinivas.kandagatla@linaro.org>
References: <20241230141901.263976-1-srinivas.kandagatla@linaro.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1704; i=srinivas.kandagatla@linaro.org; h=from:subject; bh=K2O6zbN8+hoRK8sza9Q/dLbXq5Bn1/iGmBCW0k5cYBk=; b=owEBbQGS/pANAwAKAXqh/VnHNFU3AcsmYgBncqvVUc2AB3biCwM3Pad6gShL44OZKsNQ0xxoL U+bH22uvu6JATMEAAEKAB0WIQQi509axvzi9vce3Y16of1ZxzRVNwUCZ3Kr1QAKCRB6of1ZxzRV N7lnB/48Nl+2yQ6noOKRF6d779cJTtCQE426PiL8layF0FgNVRE7RZfuiaMr6RKuo6Y6Mw4bCIX hb5GlO5WyAJklbCqIo2x/xqDAor5R53KEpXJ47SCv+gUpun4pWYrdvLqXdNkNy5lP0ul5UoLO1r XBHm9eFqmAMpcZ85Vt9zqMo3O3FhV/WstqWGtHQMNvRFOkkPFmHdNH6+FnqnV071KYOzDDsLccp 2C05PqsjbgZ2sHSOxf7lv+ImIKMyNaNCWB93aeILMZwDimGhOuTF7gpIGwuZBwwj3ZCoK6glTAK B0gEq+nOAU9mU6GKuf7Uf6/lDao4PeZGPhImw/NLm5Z0PLd8
X-Developer-Key: i=srinivas.kandagatla@linaro.org; a=openpgp; fpr=ED6472765AB36EC43B3EF97AD77E3FC0562560D6
Content-Transfer-Encoding: 8bit

From: Jennifer Berringer <jberring@redhat.com>

When __nvmem_cell_entry_write() is called for an nvmem cell that does
not need bit shifting, it requires that the len parameter exactly
matches the nvmem cell size. However, when the nvmem cell has a nonzero
bit_offset, it was skipping this check.

Accepting values of len larger than the cell size results in
nvmem_cell_prepare_write_buffer() trying to write past the end of a heap
buffer that it allocates. Add a check to avoid that problem and instead
return -EINVAL when len doesn't match the number of bits expected by the
nvmem cell when bit_offset is nonzero.

This check uses cell->nbits in order to allow providing the smaller size
to cells that are shifted into another byte by bit_offset. For example,
a cell with nbits=8 and nonzero bit_offset would have bytes=2 but should
accept a 1-byte write here, although no current callers depend on this.

Fixes: 69aba7948cbe ("nvmem: Add a simple NVMEM framework for consumers")
Cc: stable@vger.kernel.org
Signed-off-by: Jennifer Berringer <jberring@redhat.com>
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/nvmem/core.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index d6494dfc20a7..845540b57e68 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1790,6 +1790,8 @@ static int __nvmem_cell_entry_write(struct nvmem_cell_entry *cell, void *buf, si
 		return -EINVAL;
 
 	if (cell->bit_offset || cell->nbits) {
+		if (len != BITS_TO_BYTES(cell->nbits) && len != cell->bytes)
+			return -EINVAL;
 		buf = nvmem_cell_prepare_write_buffer(cell, buf, len);
 		if (IS_ERR(buf))
 			return PTR_ERR(buf);
-- 
2.25.1


