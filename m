Return-Path: <stable+bounces-233702-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oKqnDU8+1WlY3AcAu9opvQ
	(envelope-from <stable+bounces-233702-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:26:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9233F3B2583
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:26:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B925430E64E8
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3E5233262F;
	Tue,  7 Apr 2026 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jkc4OcsA"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74C1333F370
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775582577; cv=none; b=FkqpOMaFq4yLeqBSVBX77Noea+Tutmj3AxRWekKMJQkH5RluHZJaZUuycEkEEDF0kP7yyaUUxmzz5D/dRQbGwsd4OtUTAJwrMF58VTbqyKhozbOufv2CveCFiFG3se07QJFzNXAC1TgSyydYQ8Jj2VyQL9f2D2/+cwFFSiW4PtM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775582577; c=relaxed/simple;
	bh=ZcAd8r2E89ehSGioFtn3ZR2V7bW32AhFgtz22gBkxCQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pWmGayHYV8InlwcEG39mXcbZOh+USgaKWnHyqxGszMio/7a4g38666/ajjyEmyaYOmsH9ctyZie18j335A6XbsAYNqclbknzFml/3ofGHiK5eFa/t/7Vey70DxAZDMHevWkQk13pvUGBP+h8a0OECQ6Awy9SHtuFgLj/Bmkpe0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jkc4OcsA; arc=none smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-56d924c7183so108203e0c.0
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 10:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775582575; x=1776187375; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6wfYwtoFl6sdyFNiCt9In4dW+DHVo0dRtpd7r2ydApw=;
        b=Jkc4OcsA3ixCr3iDkli+MCmI9lmQWGXZEU58ZAYDUTbKTn6Xl1z4w/qWBAdfzbUGmQ
         npu86gi8f80hOMM8MuHf/XEgJgtch0XhnRJITWXvs/F5QEdLuPxqpFCvhiHNJbfW9+Uw
         zv5HXimRu4GlasVkDe8CncSbOiPziVK5UIPb/cteN3ZmAAIHh0yrt0J0DF+nB+1rCnlE
         RUGX+z0AFOVlZe5ptsXbW0nvBoMIHlnbOhaWXlfVIC7VXrJD9xGf2uswCX5wo97TqDku
         3/TU3c7I4ZUR5JVyJjhE7+thXdZnpcfXklumjZnPRbs+xF/npioig4W+1ZuPQFm7iHp4
         0lvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775582575; x=1776187375;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6wfYwtoFl6sdyFNiCt9In4dW+DHVo0dRtpd7r2ydApw=;
        b=X44zcwQOIFDLWKAXo+nJeyv81mFAF5iNdi7FcUzA5GzTJQ4ueJqk0l7JTYRoLuJmve
         8HkhKRV5fo8eVRkt4GOmo9s2pkmksfurbFuRAhQvlAYquD9g6C1iNnDa1TMcliOlIy7d
         +LT/hf6YLjOED5kVNKPkuegRH/W5Aqy2/d2h2GBz+AC9MhbY4DnGUwCyPB4GpfYAKk0w
         Ku1xgxUKsRC1QMNCZO8FEqf3CLMYcV6KUt8LaCkrSvGtAAa9eXdk2dLBiAzpSxaW9YBl
         t0qbxFfrpId3N7Sal5326DoEU/ZQqyrBRtdGjQTu/ZF+15M+vgvST1x6Zd/f6YVsDSR+
         ZTnA==
X-Forwarded-Encrypted: i=1; AJvYcCUVSAI2KpObYoIMcnSjCFjZXtGDzaaLkLcnSwWOHlB4Umx5MBLdVwAYK6Uq23+1VQWkEDMbz78=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlJvFRP9OOhqg0cV04W/AphQSzZ57c/tI/pv/La0aZYw5Vo8ux
	dcL/iMjq+GNGwKjWas8f9Rxr4v3GzYXYECeGjd+Bfuxd70RuZ3nH1hX9
X-Gm-Gg: AeBDieu/qiWQ0xt7EvZogg/YppefPJl3iyAb6/SvgOWkgOMuTxTKhoxsPlCSfGv3gzK
	N6Np5psePovtT7LsX5Z13v+X8WUZfrfiOLkaiD0a3eBtTCEh1446ffxggzhkkZQLt+k9S/ApC7U
	UAh35rRoV9eD/LBaJCPoppxAU5Uj5sy8RDbqqG9TwX52teq7KMAR57nCKD6oRrfa5H/QALTb5ot
	N+cbiaxy5QQJIQMmjA6ETnelSc7JUQTxYHVW3X/IhUIaoAI5w5fGb20GLEkLf49SNZ68pG2+RWD
	dvfBpn/jb5REQVPNW1vrgE3Nu5waAYQ8ckHN8yc10vMosyVF9rSzL6SdoH9FyjgnlBoRSbhBE3R
	fHB+QhZVr6d3eJAS3dmffMKOOnXhvlspkVVGkw51Wo0UFs12SoIPcbD+gLF8uQKAUeOspeBxYTR
	CuHkZXPvsWxTgPSVLnhVkkGbj6
X-Received: by 2002:a05:6122:81d3:b0:56b:a569:948d with SMTP id 71dfb90a1353d-56d9f1976fcmr4282062e0c.5.1775582575428;
        Tue, 07 Apr 2026 10:22:55 -0700 (PDT)
Received: from localhost.localdomain ([2a09:bac5:6d74:aa::11:155])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-56d9bae1117sm18878435e0c.7.2026.04.07.10.22.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2026 10:22:53 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v4 3/3] fpga: microchip-spi: fix OOB read in mpf_ops_parse_header()
Date: Tue,  7 Apr 2026 11:22:17 -0600
Message-ID: <20260407172230.40775-3-sebasjosue84@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260407172230.40775-1-sebasjosue84@gmail.com>
References: <20260407172230.40775-1-sebasjosue84@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,microchip.com,kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-233702-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sebasjosue84@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9233F3B2583
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

mpf_ops_parse_header() reads header_size at MPF_HEADER_SIZE_OFFSET (24)
without first checking that count is large enough, leading to an
out-of-bounds read if the buffer is smaller than 25 bytes.

Additionally, when header_size is zero, the expression
*(buf + header_size - 1) reads one byte before the buffer start.
Since a zero header_size cannot be resolved by providing a larger
buffer, return -EINVAL instead of falling through.

Fixes: 5f8d4a9008307 ("fpga: microchip-spi: add Microchip MPF FPGA manager")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v4:
  - Reduce to two minimal fixes only: minimum count check before
    reading header_size, and -EINVAL for zero header_size.
    Drop redundant block loop checks — the pre-loop bounds extension
    already ensures all block offsets are within count.
    Suggested by Xu Yilun.
Changes in v3:
  - Add overflow check for 32-bit in component size loop.
Changes in v2:
  - Return -EINVAL for header_size == 0, -EAGAIN in block loop,
    add count check before MPF_HEADER_SIZE_OFFSET read.
---
 drivers/fpga/microchip-spi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/fpga/microchip-spi.c b/drivers/fpga/microchip-spi.c
index 6134cea..dca1a5d 100644
--- a/drivers/fpga/microchip-spi.c
+++ b/drivers/fpga/microchip-spi.c
@@ -115,7 +115,13 @@ static int mpf_ops_parse_header(struct fpga_manager *mgr,
 		return -EINVAL;
 	}
 
+	if (count < MPF_HEADER_SIZE_OFFSET + 1)
+		return -EINVAL;
+
 	header_size = *(buf + MPF_HEADER_SIZE_OFFSET);
+	if (!header_size)
+		return -EINVAL;
+
 	if (header_size > count) {
 		info->header_size = header_size;
 		return -EAGAIN;
-- 
2.43.0


