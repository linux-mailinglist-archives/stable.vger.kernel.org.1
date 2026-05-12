Return-Path: <stable+bounces-245567-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GLTgGy4qA2qw1AEAu9opvQ
	(envelope-from <stable+bounces-245567-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:25:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 08DF85211A8
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 15:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6546F30E808C
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 13:14:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99ECB397B05;
	Tue, 12 May 2026 13:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NwuFgspb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F007397AF9
	for <stable@vger.kernel.org>; Tue, 12 May 2026 13:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778591250; cv=none; b=GGrOyrkWg5tXqMMqhLMBYS4EmcNKOJaAX6pQHsekFS0y7PVBP7FBefE5ZEc6QREEmV+IiVDx4IIWU+de6Tc3pHePKBEgoJoei5kP9/waSX176qRUOv5N+jlXE/P+dpq+xsKdyXRkeFNd5Em7MlRI3sCGBpwjK3QFe8TanhzEc2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778591250; c=relaxed/simple;
	bh=O58YtyLftv/aSr8x9baMQzWxATwo2ioj8rHnKr5cmYk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=cnJFlxkzBpesr//SGlxRIZtYaTouqDRUpf64c5usfXo1za7/GPqC4akd/1nyrDxi268OSyeMXOPflFWuwr/HedF3pd9O1HNvWViSRjsuk2hbMsQsCIEB6QADru+CqaE5CAuRF7OJgtJFQ5Zq8H8e3nSQFYATRuW8/PtAzbr7bZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NwuFgspb; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-7bf1eaba464so48022987b3.1
        for <stable@vger.kernel.org>; Tue, 12 May 2026 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778591248; x=1779196048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=NwuFgspbYjjUKTWzbFiLyatbSUVTs/IOpFn5NBzG/cUwQBk/0H1pWciYNYM/AbzK2l
         UhcMXqkPYWj0Mtk2M6//aD8DqVQNh0cpPt4yzBio8IW96GVk8Wr08QsywXmCFDLF/zGN
         hLx6bPIfhQ7QveXF2Rf0IUqzysyHSLwq9jS8DHZSZ5S5i2+U1L5vcyfeZAroRUO9RGBn
         QqLsLP+5sHt8toYMXej3tJdDRXJmTuuzfgBljLfI3wcQr0ustLzftHI3pQRD8jd5z6o0
         kgteVPzYFPWWjX3LlPdPPbMSrc28L+la6K8/X2W8yTFDpYe3lPrLE2uFPbHgJFC48JYz
         DClA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778591248; x=1779196048;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q6OJAQsGwoFPD7r4LZcpMPocelNw4jhWQiyjjqAx5Pk=;
        b=iljDnzglx3/eqvdB47LY3Zv7Pde9O20uACbHlraoe0j3s3x0NFhwLCkViDMJV5F7zc
         3fzQ6WZMhB7YvQD90o1C0kgPgxPIW9tXeX/XOerYSis0qPwTkkm1uzWaFN5FQcQyLXB3
         fuzXMrAO5ZK4ftqM8YqOd9ZA59P6nlv0OwDRkJPD1RQRE2CdmZuWDJZb6C1oNLUDjp0j
         Qu/NKUaUcj3VfUfAiG5M/Z+/M5qy9OShF9tN0r1YCYTYBWIGBC5/2J9P7a8FC/fJPbKw
         U1ioc28qgoop9Fl3Kz2IW5+s0qbZ6o8IfkshzpNSy8hZN190mT+CBVRbFaDTvLUfY9tE
         z5zA==
X-Forwarded-Encrypted: i=1; AFNElJ8HutctZR3x8bUcR7irBEx+GlT+HVKitzpS0Lh6kxrpV70/OlnhW9YR2pxB8i2fyzOF59/exwk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy+TUsaRpcXbhpChImQqpRUkVXhWLoLNycRYlerCvfw2cC1dqIf
	VRuyqFHzt2m7O4aUPJVjtCHRayiKWNZW9ujkGoDyeKbk32dAoism8wF8
X-Gm-Gg: Acq92OHykXmNfdbkqlFx/Np83Ve43vGLZqW1+TZL67tYgpOddwDwekft/aaVcI+GQpv
	SpHfbDm4ofjjJLS7lkeMjOoc8bj58JOs/WvCmsrso1GOThozY7wrn9M6GS4/Z6LPtqNvD43+zcs
	bF6vxqEL7Dx/vu/7lRFBYVorRTwilCMrauba3SXX7z7zY0g0e5+5a5aDIEjCaDnrJ8rqcrD1fVO
	h3kzvZTxN/gGtapoVGi4xRUkTI1Fa3JX47+8KbCR1xNkSFwYsi8IyfgzSQ2P1GwxL0BKnAZzIGt
	vm8eN31cmtH5XTyB8sykeC6kr6opSOze9JImFGwgMltakrExlzOdqp8SGf0+QFzlQh0wFJFcGCz
	mdAz66sIralhyY2Uid51JTDvw4w97Tj3qxRc/fMHipS2U3FJm1VXScULQZZs5xcg8I20RL11BjF
	t0qbR5o2gCIxDOVe49cLi+ciB2UiIB11tZB0uudVi7mt7IzgpurvgekipP
X-Received: by 2002:a05:690c:885:b0:79a:3e8d:9bd8 with SMTP id 00721157ae682-7c1025640dbmr134369777b3.2.1778591247954;
        Tue, 12 May 2026 06:07:27 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6686ead7sm167459037b3.39.2026.05.12.06.07.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 May 2026 06:07:27 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v6 0/3] fpga: bounds checks and input validation fixes
Date: Tue, 12 May 2026 07:07:07 -0600
Message-ID: <20260512130710.933089-1-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 08DF85211A8
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-245567-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

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


