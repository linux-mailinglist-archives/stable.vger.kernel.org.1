Return-Path: <stable+bounces-249343-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SF9+KtNEC2qsFAUAu9opvQ
	(envelope-from <stable+bounces-249343-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:56:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E1F55714A6
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 18:56:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B8149308E4E2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 16:53:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22E4C4949F9;
	Mon, 18 May 2026 16:53:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L3QAkuKr"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DF5C3F88A8
	for <stable@vger.kernel.org>; Mon, 18 May 2026 16:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779123213; cv=none; b=fc88DaXBHoiHjcgAUAi56572tABQ1BSURgSCr/N5pwgKPT1sBKmS6TrInvbrnSQakwRxrlq+Vfn5U7NHRd691G/+uQRY7Ei4VOXT9EzPxdr9WLajTNGZZbG5uj62Tbh1K/7R+Lu+V7QO4aeTUADj+pz9IU1hfU4At+QZISpIO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779123213; c=relaxed/simple;
	bh=O58YtyLftv/aSr8x9baMQzWxATwo2ioj8rHnKr5cmYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OWllpdmWUiQqzGWliO1t+2y6/Sc0n7CZjz/CdQG39j3+Oq4O7xz5f9I5B6k5lsDj8MW73+2rKsenCWJPtQNri0N0DSNvzgBcTF+cUUOQpa19l+ZYeTzN0IPIrTmd8WLLJYbG37vAYU47vgpx2Rm2Dkikd4PoFsQOggDG7qn8L+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L3QAkuKr; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-7cb345cb5bfso15031827b3.0
        for <stable@vger.kernel.org>; Mon, 18 May 2026 09:53:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779123211; x=1779728011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=L3QAkuKrkQ0UziMDwTYwuZW6ExFK9XePVRNR6f7NZFO4FvsWxgc0g40/eAE4YdYDu4
         FoOAe48oRZLErxQt5/6u8THA/MU5G2O7rRo+UpD/vy2lPKI8mkLiSa500bFn+UcYd/bm
         TG2O6JFipMb3MS0StKeIaV3UlAPY+uB5Px5ts00s1y1qRU+oFv9ycLvHX7oT7rKMIJOK
         IQIWP2yIr0oaRDhtQaT1UXT4q2JYWn7q5sSaV63VUtxc2+SId3fj2cRGaKuhsNXlTmpb
         0yuJbq7Eo/UglSlirFgpqz2TpHPL0GqeccFE3wcLFNJsXifVWYWCxkp9CIwJOtYb3rGb
         bSBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779123211; x=1779728011;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=s65D8viTf/78t9mRQudbZr/yQ++R5YW1b96LEQifdLAuiXWJr5lXxSY5HR4p7+XmN/
         lpZ+P8ZzmYd77UNZXv7FybTl9A1bZdo/21P+R9gzVMPeqAYXq6+F9ksYUxWfgyDlzMKR
         /M/6FzJ7n8mUoi2qkIh9mnqItRzUz+f7n4xU41trdv4ANfhmmiJTBtjif9ufPzzAcxCx
         JvqtU6n5sKcREYdXuDK0aPVz58UVOJULcZzxOwL/HreMVIQcWKEhGtka93bJh5Pups2P
         rE/bqqY41qvasFG0jgdsgB50bCrJZaWASY5lD8SmLDmh3Rdr+MIoE4HpbT9MutSf3Yuv
         0FuQ==
X-Forwarded-Encrypted: i=1; AFNElJ9N82zydsvpDdX3pL/YKG7oVvj4fPD0GkDQjrj01JXTzMgEYLSkA8gph/V+28LPtiRgklnAiPw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUo9dWyu28ZjDu+SftFfuxn2i82swgm3EIsb5+N2PosROl0fIX
	8nXGXfaiADbq9exsXL4GoHzejUrpIrlE7aSBlgA6tG3LPWiEdW1mSdl4
X-Gm-Gg: Acq92OG8UiophFRjQqA5SCMnA/MHCF+dMru/nsbzYIdF+Cionnp5NZcY2GScJx/PXFI
	iqZZ50YW+iDZ8jje6m9aNGuofQDAybCw+Vg+OePEKtLdhptwQX+u/K82pOTrQWhkUDHUGJ8eGnI
	2+7B3M4v6OCR0rpcEXbszMOzr8JbMZYlPu3ul52DgRmSwwzPD2f9FdYpQRdURTSCj9ERF787qoT
	wWaxsNFXuaBYINb29GRn45MylMXrvWCky+O0QXNfiUyHoN0YKovAy37UWjxeW1fYz/fz6/x5SMl
	+i05JxItzn3IBozRad+VluxtXFvdD6AyqbL/g+sdohJRDVVARL6YJAhQ879lnz+wAdUi6RoLC6p
	GoVpVmq1uBTV1sp2LAZocV+ek3yeaYGs01klcbumTqmBzyz4OxdsLWujD7aoWmVbtrnPm+DJvP9
	jZ5KAengqg+PcivEfLHfkeIOltRnEchNeNw61Dv82dn6w46rtaRnIbOU146mMOHvcWQc6c7yXbw
	sZQI5aGPfP/rmYC
X-Received: by 2002:a05:690c:19:b0:7bb:eaf:5101 with SMTP id 00721157ae682-7c9599a2f1emr185013507b3.16.1779123211650;
        Mon, 18 May 2026 09:53:31 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7cc965ab98dsm24232957b3.0.2026.05.18.09.53.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 09:53:30 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v7 0/3] fpga: bounds checks and input validation fixes
Date: Mon, 18 May 2026 10:52:15 -0600
Message-ID: <20260518165218.35388-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-249343-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4E1F55714A6
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


