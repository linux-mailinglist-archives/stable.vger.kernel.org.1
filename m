Return-Path: <stable+bounces-249372-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eCgXOa1jC2rwGwUAu9opvQ
	(envelope-from <stable+bounces-249372-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:08:29 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CCD25729D2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:08:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 0CB2930300D5
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:08:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 559F239023B;
	Mon, 18 May 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cH1paVhG"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com [209.85.128.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0FB038F25C
	for <stable@vger.kernel.org>; Mon, 18 May 2026 19:08:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131283; cv=none; b=GfmR/Z7ZdmxHM5bho0VESHdzybYR6gBKbmZMhwWeR/AXPD0maTMSYAZZDgIBG8WRJtrranI31oWg8bvgrGd15iybTj3ZRL9NiTjF/9cY4nIXela4YTKiGNsI+jImY1EbNWy1yraEA9SuUZjMZQeagqaYNx/qGvgwYFCX6DlTjRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131283; c=relaxed/simple;
	bh=O58YtyLftv/aSr8x9baMQzWxATwo2ioj8rHnKr5cmYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=rqFVfrp2KcsgwEOxBsrstDt+U1BGeTq5x8zhh3YTHvYdv/+WKy3u74/ru0AX1womcy4G84tE7w3eq97cmjAtNKB5CqYV2aFDVUWqQrhBmQNUK8Addv/jiXG9P3Bo/lgI5jWBq3U43TQZZ1lYxZvkirjNLM8s4CDwCN0sTeR7wdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cH1paVhG; arc=none smtp.client-ip=209.85.128.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-7bd5c773ef3so20723907b3.1
        for <stable@vger.kernel.org>; Mon, 18 May 2026 12:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131280; x=1779736080; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=cH1paVhGmz0GxWCAmIOMsuxpBG0wRPkxxuY84eDhul0lgXgrj7nVGH7W/cT2+Rob+w
         vaswy6lDAye+1ZpzRjwCR1k0/U4MHFhAy3IKQPHXBK0C7+5PxDnsrfhQ+9D+6SqZeIA5
         dEMkQZFg1HSdNrUkHTCtgMQPQUAjRL0wEIyVsMj/lnOggXDuuCh8UFcFPeJgRc0fJsU/
         7v8UpjY3RGJ6ldYGLC0BWMqhyw5A0v5xfVj1BdjSu9jMiplie+cfJ3mOBWsrnAedVbYY
         WE679QfLk0xqGXmEsfPoEeVkEX+G4UimkeI+Py+5x9FvHgr64aljsjILYFKKOOs4PVlF
         BCnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131280; x=1779736080;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=FTrZDMpxC6OZ9NGcyDU1KEXmgGNkKyF5oritMuMLJtebbhkb0wDBi+PKgd/1JnGmKj
         PtxlQ9sUpS6pm9v/YVVfPo2Tz3E3VYunll1sFKtGrMdr6iapdWy4isDhKnk/1/X7MW4R
         vllRNKNbULuYFwUyBg7YSQESddDUR8xl9hLdgNYlzlOYP+5xde0XtZ5IAOyA7VxRTeSL
         HU+uG4AN5x4mVHbmjCeZ0B7mMCnIpRSwwhg42F0NR2MBfnxPJG9R/CxtvfLLimiKsDwu
         ykicHPPa9y6MA/whgV9V1yBvdLk+vgnMST5qRNt0ECP/0ytG+fPU+Jt8SeWBuwx4BSap
         TD0g==
X-Forwarded-Encrypted: i=1; AFNElJ97ZDkfRkucPmikFXx0Vq8n+bZVo1KE68d9HzgEdtekCib3hVv76T+mBy92qXhJ5nbXOxQhv8o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8WJHblZoy3o7832jdxtTWIhIgmDH7onioEJpcnzB7pLiPdRmf
	z0C5GXPX3NvIQpCTS6SEGpG0PiGapfOvCmJzWd0hxH/U7JCFTRNd2ILA
X-Gm-Gg: Acq92OFOu42IkNr2SBDIBjzr9GoDq3F6y++tDk30EoTJV3WdbP7Ai8rhQ1nQMYqNAz/
	1fncmqPvc/PLY1MmQ89LIlecq3iveFa4YCMGujZVweFD3Gx6SJNUiG84zVt0+UZkYJcD48huT0F
	c5mxQa3Gs99O8UET7ohCJVEhn/oszoiI8uM0XNwM2Ey/NUL2HeggWBuYYX7OH3jHv23Q+hUi5P8
	kMpQCkEuLCIO3O2jXXG907qK+vGwvoqGHZdocdkpPEEyKu6ISJcaV8IYgcvvgeSJrSo05JAWLiL
	NwA7mnsAxiuJHTu1z3PPinftnLVtcIDoXwlIEtlaVPd7tjrnFZCjdBWx8nVeBXOsLZlQLrdhkEr
	DB+4C3N+MVvcnIGPKYPmgNPeaHdyu9Ue/hm9wZ27mzeheINHaZhJIY0MU3xhG0n3I/Pf6JNqupX
	XiQtTYkndt6yDjfs+YZqVo8SU6juzBcLmzRImVkX9adFrGfRgk0h8tGwVi42Tt41bpPUrPAGKML
	ko2GuEl9AyVAF7BDXTxWwLoYCQ=
X-Received: by 2002:a05:690e:4086:b0:65e:5955:2e44 with SMTP id 956f58d0204a3-65e59554694mr5535194d50.47.1779131279841;
        Mon, 18 May 2026 12:07:59 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm6766160d50.11.2026.05.18.12.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:07:59 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v8 0/3] fpga: bounds checks and input validation fixes
Date: Mon, 18 May 2026 13:07:39 -0600
Message-ID: <20260518190742.61426-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249372-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
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
X-Rspamd-Queue-Id: 9CCD25729D2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This series adds three defensive fixes to FPGA drivers:

Patch 1/3 fixes dfh_get_param_size() in the DFL driver where the loop
bounds check is evaluated before incrementing size, potentially returning
an inflated size that exceeds the feature region boundary.

Patch 2/3 validates the DMA mapping length in afu_ioctl_dma_map() at the
ioctl entry point before passing it down the call chain, preventing
implicit integer truncation in pin_user_pages_fast().

Patch 3/3 fixes mpf_ops_parse_header() in the Microchip SPI FPGA manager
where a zero header_size from the bitstream causes a one-byte read before
the buffer start.

Sebastian Alba Vives (3):
  fpga: dfl: add bounds check in dfh_get_param_size()
  fpga: dfl-afu: validate DMA mapping length in afu_dma_map_region()
  fpga: microchip-spi: fix zero header_size OOB read in
    mpf_ops_parse_header()

 drivers/fpga/dfl-afu-main.c  | 3 +++
 drivers/fpga/dfl.c           | 2 ++
 drivers/fpga/microchip-spi.c | 3 +++
 3 files changed, 8 insertions(+)

-- 
2.43.0


