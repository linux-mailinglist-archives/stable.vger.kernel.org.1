Return-Path: <stable+bounces-190017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D55AC0EE33
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 16:18:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88FB1426CB4
	for <lists+stable@lfdr.de>; Mon, 27 Oct 2025 15:08:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C947309EF8;
	Mon, 27 Oct 2025 15:07:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tbz1cVqZ"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B20613090C1
	for <stable@vger.kernel.org>; Mon, 27 Oct 2025 15:07:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761577656; cv=none; b=ZoAiVx7T6d+hg8L/pyOdpHvdJmRluat4RHi1fTa6LNiUXkgI0u65nMOTuVfYqRLrbEtbsZeBbYequoUAkD+j6kM19AKYwV02B7OzzHczydgjsCb052+gn2Q4BljhI2a3RFm5AUa1+fWNgLEjgh1aO0TKC1zbeUiB3vbRBg4s5fw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761577656; c=relaxed/simple;
	bh=4KYywOgTHGEIz3ZCocUr/rj1P+mUN7k7cfPlJwv4luk=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=s5DFyZ2dYwFB/dv3+/WHuhesZwn7qcqAmvW6Bx+Nx/CoLFxAt6TQ2IIXIATW/wPvCYhO8VGw3t7TcQLfkOBsNQZWZtBTd+/eQDE7lykipOdHtH8s8ij/tI4LivgFpPsjIR5r/bu+fQScOg8GsHWfVnr7wvIYO4Cx1wHVh6JA4TI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tbz1cVqZ; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-290c2b6a6c2so49946095ad.1
        for <stable@vger.kernel.org>; Mon, 27 Oct 2025 08:07:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761577654; x=1762182454; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Qz3ecQyWxC7VNS5GAYBhcfKzMJ8mPoJ6wolDlF8Nh4U=;
        b=Tbz1cVqZGseSwkIvYl/wlayY15FjFoE2rDnTwV0OruwzSlj4x4LuWngEEAf3cMNaK4
         M/SCCf0W0Awo57RdGfDSyBh4L7DeUPJPkEB4KgV/okxGDwIp8imcBeNDmnw0JtDGLL4i
         Otj6XBGoOk1Tp0QNr2hkAyDRh3Aaw7DTBPlLj5DXcXnlVYyhUUTGJt2lpnoPB1QPf+Qp
         /bdKfs2N6qrJ5QCWNmpgQaNeYT+GrLLSz151I4TUNdxReaMpzsGt7Df0Mmu1rvYKlTA0
         V3YeB5qM5SaOvhOOkJ3xYgRH6sv1ffXOncYMPE8tKKY2lElCwfi+YTQRIx7nifmZ8Fc/
         NjeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761577654; x=1762182454;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Qz3ecQyWxC7VNS5GAYBhcfKzMJ8mPoJ6wolDlF8Nh4U=;
        b=xIgpgka7Q+XmjA9s1J4MryK/5OQThCEOgpDqDPFWzg+j/mm1lfDK0n+0aOnRyveGvv
         PDbqKdt/tcT3VAf3vcnIGiAX1UCWCMxZXMpszR2ayoLEkiHhIyQyaN060sE/5SVhkAGg
         y4xkYmgOcQf03uYqbAWlrqv12/ZXB5XF6Zr5xk/zUm/UTT/ppyK3S7DSUS7GrBOBlYUa
         vB9jsRk9uFzThzmHVmLprw6HLwP5JiSSO/q1CamE6Vw4GEwBA0gRosFFynTIe8QHrMtn
         Kd8uzNo6+sAKr5hMo4bQ/P4G34oMi+1Jz/ZDz3nk/yhIxvcNMH9n4+Dd9lUC+6IzYoyR
         UtuA==
X-Forwarded-Encrypted: i=1; AJvYcCXSdfWdwaSLshXpyh165YwcEhCAmIqRRyMXXXzgTZrW1ugIN3qQPUz39KXf6Hm0XulvKzMiu4w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo2zatkngAH/0P6LfOEw+5Hf1ysyOJaftCrbjwkFwc3ICesMcW
	Gx78fgQufoPcdj7+gW/2RhipTO5hw3GH94EoiguJES2zJrmVqWXtRTX+
X-Gm-Gg: ASbGncv/kqGznDj6kQD39dgjqtIUKDCuggdLYzyseresmyX6MJlb7LQ9HCWOS/fVJDH
	XZ4dhfxlIC8lw0ih6MxRNJ4LTIDrZ9Y27FzWw4CV37MFn9AIo5YwYBGaHn8VgBlRd29aliqzUph
	3HH/OWVnSHpI29DR3PWHInR7q5ER6fr+MndgLykkAxmXYNp8UkQCEDJApMwerdf3rokFKvjI9BM
	kXQWXSprZmLH3FPyn+0jz/sS1c5ac62wqrUTtwcmAmqJc+pnKg1Gftg5N3bzGktDgb1VVpmW/hr
	/cL0Fat5mnCCFSbJNwSPcl1htt5viVPFzAirbSlprHpLaumFkYt4TYmkPacPUusbxqHStfoTCaO
	MNVoyhxWLBwc7f1Q1VcdjDxRxh6v+k38X/ss5gm03lPJ2gtImD00Ai84yevo0oS2vLqtnJuL9OR
	dNq3AshqUjLGMgXyaHWlgLI2i/iiOJiswx
X-Google-Smtp-Source: AGHT+IHFy+IMljdrhVQ66DQvOfteh6iHx3cumDuMAgc7JMxc9hldJM3AHM32ikGVgmmr//G+ptdz1g==
X-Received: by 2002:a17:902:e805:b0:24c:cc32:788b with SMTP id d9443c01a7336-294cb3693b5mr2991405ad.3.1761577653775;
        Mon, 27 Oct 2025 08:07:33 -0700 (PDT)
Received: from localhost.localdomain ([124.77.218.104])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-29498d44db4sm86422035ad.86.2025.10.27.08.07.26
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Oct 2025 08:07:30 -0700 (PDT)
From: Miaoqian Lin <linmq006@gmail.com>
To: Lars-Peter Clausen <lars@metafoo.de>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Angelo Dureghello <adureghello@baylibre.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: linmq006@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH] iio: dac: ad3552r-hs: fix out-of-bound write in ad3552r_hs_write_data_source
Date: Mon, 27 Oct 2025 23:07:13 +0800
Message-Id: <20251027150713.59067-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When simple_write_to_buffer() succeeds, it returns the number of bytes
actually copied to the buffer, which may be less than the requested
'count' if the buffer size is insufficient. However, the current code
incorrectly uses 'count' as the index for null termination instead of
the actual bytes copied, leading to out-of-bound write.

Add a check for the count and use the return value as the index.

Found via static analysis. This is similar to the
commit da9374819eb3 ("iio: backend: fix out-of-bound write")

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Cc: stable@vger.kernel.org
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 drivers/iio/dac/ad3552r-hs.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 41b96b48ba98..a9578afa7015 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -549,12 +549,15 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
 
 	guard(mutex)(&st->lock);
 
+	if (count >= sizeof(buf))
+		return -ENOSPC;
+
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
 				     count);
 	if (ret < 0)
 		return ret;
 
-	buf[count] = '\0';
+	buf[ret] = '\0';
 
 	ret = match_string(dbgfs_attr_source, ARRAY_SIZE(dbgfs_attr_source),
 			   buf);
-- 
2.39.5 (Apple Git-154)


