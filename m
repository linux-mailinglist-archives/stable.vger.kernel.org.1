Return-Path: <stable+bounces-249375-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sHc/DM9jC2p5HAUAu9opvQ
	(envelope-from <stable+bounces-249375-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:09:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 32A6B572A80
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:09:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EE471301AF24
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:08:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E56E5392814;
	Mon, 18 May 2026 19:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZuMABIv"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C3D0391828
	for <stable@vger.kernel.org>; Mon, 18 May 2026 19:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131286; cv=none; b=GjxHWJmyV963pdz5ONRkGb8VBtfoa4VIoQlBJ9UAtasK8MrsMyzF1EL9TW2DZJ0Pv3ZZPAbUjBWDlSs0mtKfHfAaueFytQ9YD8VapYDnWn+IDurxZfbAaHbxPq1XRVgViFOzx+qUAO/UKsGzZOT2nGHqCJXDZ+XlfUO2EPkDp+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131286; c=relaxed/simple;
	bh=OrL3+x1tcgdp6L7F08VxJfvF3uGmnc+Qbsj9WOcFBI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R+9PDNv+uGfEWQ4CQg9ZM81/RB9Cpz0bU0GRg7EDF8b/rRP+0jxZm5VEy0nUFIfb99ubmGL01XLv2Gb5Vg+cTNXZBQPjTaRHq1mMCsr75xGd5W7gLhnPu0FxYf+VnnFMzY7zMtEgb68BfqCfsFKkjiBbW/VDRUPqVacXsP+NmYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZuMABIv; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-65890a6ca20so3034974d50.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 12:08:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131284; x=1779736084; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ygoe/8YI/F9vvMO0U7oDJ387wljZe6nsikPiQPuzlSg=;
        b=VZuMABIvBw4LZZmsjLk22c86RyG3EE1ru0uc+d8CAMnhMyF/3R2SaRNge/ttHytNlZ
         mDYg+hZgRM0LXco2MwdD/vk+aRCHaDi3jF5Wqb8ur9CP30ElYaJUFfZUIfLcPC2e4I/P
         GM74eM6V5h5tm6NOlwlekOC0iUw8suGyaA9TkNOvm6WVmulfEJ2QyBpRqSzDRgmqq8H3
         toNTt4/eUC9GKX+5jZoGunodmAebkGuabc2X5qpoX/ZNJKUuOBpJMNpCV2w6JlySJsv4
         A9+f4WrCfjPx2pOvwuQ610SijPSifCmy7rPi6h1po2O5dX0O9bjYOQdHirGfsz84MMwT
         y2KA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131284; x=1779736084;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ygoe/8YI/F9vvMO0U7oDJ387wljZe6nsikPiQPuzlSg=;
        b=Y2JgkqHeYj/9ir/lHRBFDzyqk3Ze2WL+t6pAKhxOi3D4MScq8sopBkQgxPTTOwW2nw
         G9Jwd09eOyxrNu+ZXR70TTF2TWI7L1QodSDLgSucPaBlR9BobLsVLKCZ4t91E2j/WB/Y
         Sc009psifWqZC3loglRL+kKruX+UBKi4gXCQ4TkLAY9kXZ6gxhnxhbQ8kM1aqvMGtLIG
         6dF2wJ4+SJJgHrSuXFDtMHBOrkkyrPX7BMPi9u2Vjg8W86cfDOpTEiNhc11Uket+/mt9
         OkpH9s+zJE1+8ME5NReJSQ3pF+pQSRqLiJdmJoS+8sBY3aQCrAXqCiJHtzkBYE05ExJT
         OxIw==
X-Forwarded-Encrypted: i=1; AFNElJ/aFYmGjbt94mRWHOF6FleQ0o1lSxZU4F6Slh5h2TLmnuKjqju2LERa8GznwmI1JWXTvxEeUsY=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLzKZ3NYZis7dgky8X3cNWYG4uwJizWVrrB5aTEdYjd1SZQw2L
	5PupgHGblyu695al5D/LlvG1pXbheWmW/9b7efN863lA2qursYntTON9
X-Gm-Gg: Acq92OHMGb+GMVyEEXw/O9oVa/9jgvoOZ91UT0rJOlNplR0HlprebsBgFlCI6Wwk3PX
	VdiyKeD4LfotlmkGna0V7oZ9vY2Ybq+4LGdTpwWaV7gQvJ5xQTcFu7vGkwYUgzR2B6UBTNkc5C6
	GALOQSpuCd9zBa1TBym+YEzD8eb9RQv2iidjc4csnsD6tISF1w2MN6jjNWvqBIbviXfHpomFceC
	4te3tW0Hz3NmsFmzenR+WkSQoBYe1mdwwRvcEUZJRHIot8cxBK41nHNCulvb6/2QGZ74ZB6UohQ
	4AdJ/NUEAX3LfYOiXwi78y7sqlB8a71swRcAYMTdx4Rzuze5s5zwt370OI2cL5cvhtLEcw4AJoo
	Il8K1WrTP8sKwD7QWBFsPJNc3g37TuMZdRNGPJzEwz16Q/YtCLxtIPz4YzolCUItu1r7RBFxxYy
	38r67XDUxaGMaEOE1WOXrl1TvhdftLgiawduTmYfRMC0mqOd370VV4QX7/BzjHobyn8kT08Aeaq
	D24Sazpr34Ff+Lj
X-Received: by 2002:a05:690e:c47:b0:65e:43a2:82ae with SMTP id 956f58d0204a3-65e43a28920mr9545838d50.57.1779131284347;
        Mon, 18 May 2026 12:08:04 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm6766160d50.11.2026.05.18.12.08.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:08:03 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v8 3/3] fpga: microchip-spi: fix zero header_size OOB read in mpf_ops_parse_header()
Date: Mon, 18 May 2026 13:07:42 -0600
Message-ID: <20260518190742.61426-4-sebasjosue84@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-249375-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
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
X-Rspamd-Queue-Id: 32A6B572A80
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mpf_ops_parse_header() reads header_size from the bitstream at
MPF_HEADER_SIZE_OFFSET (24). When header_size is zero, the expression
*(buf + header_size - 1) reads one byte before the buffer start.

Since initial_header_size is set to 71 in mpf_ops, the fpga-mgr core
guarantees the buffer is large enough to reach MPF_HEADER_SIZE_OFFSET.
The only real gap is the zero header_size case, which cannot be
resolved by providing a larger buffer, so return -EINVAL.

Fixes: 5f8d4a900830 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v8:
  - No changes.
Changes in v7:
  - Correct the Fixes: tag commit hash and wrap commit message
    at 75 columns (checkpatch).
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Drop redundant count check since initial_header_size = 71 already
    guarantees the buffer covers MPF_HEADER_SIZE_OFFSET.
    Suggested by Xu Yilun.
---
 drivers/fpga/microchip-spi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea86..cc8f6d7bb 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -116,6 +116,9 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 	}
 
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
+	if (!header_size)
+		return -EINVAL;
+
 	if (header_size > count) {
 		info->header_size = header_size;
 		return -EAGAIN;
-- 
2.43.0


