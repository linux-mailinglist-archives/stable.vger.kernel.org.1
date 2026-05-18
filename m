Return-Path: <stable+bounces-249373-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6H7JJKhjC2p5HAUAu9opvQ
	(envelope-from <stable+bounces-249373-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:08:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id B19895729A2
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:08:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 6DAFA3014B3A
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 19:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA7F53909B9;
	Mon, 18 May 2026 19:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZQLMv2vJ"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f50.google.com (mail-yx1-f50.google.com [74.125.224.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47B0838F255
	for <stable@vger.kernel.org>; Mon, 18 May 2026 19:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779131283; cv=none; b=SvwsSX2GGxULug66BlY3yk4N9XjLqPNZgqdNmLbn2me2NIRRHLZNUwN22u4Jt3oAQRP77Agf1cpwSsVCxGqUQj0jp8Vz1gr5zjtnqwzvqe1di6+RgBHO1WJIGHh426tZm2RzCOphD/MgM7zhuFwyWhdD7S+/oRIF03V6aBcXC6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779131283; c=relaxed/simple;
	bh=lr/Il1RBfm+qfe8Cae/ztCEpMom3cE9zLIvaGjdLVQc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PpSSEZUAnkHmj0Tvl47CGF6F1pGvJjWD3vcPx4U2XLGv/rJjfGHzZSyrw7T8MKCnQW/1k79/LSIzxp9kgrkFvwIsKIyYnUGnrzeO0jzwQrsUJRHbjjNExDp0Md9KmXEv19wkwy9MhZ7fCDMuvuBh+EnHH2p7v/r8O4/mhjKsX+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZQLMv2vJ; arc=none smtp.client-ip=74.125.224.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f50.google.com with SMTP id 956f58d0204a3-651c5d525f6so2747694d50.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 12:08:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779131281; x=1779736081; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EBDXdrLaiJs5mJCkZrMnLOovecApXs5qp8DhmlH8DV4=;
        b=ZQLMv2vJV6e7TEn0C29mqs3kXyWUO0kZyvS5woroyiWejXY7rUwIRpMUE4mf2tG0lC
         NUcPY/TkBxe9B5qfOUKCwniQBnPlXuOu0fuM8GeDf1gIPF9RsHe62uR42OiU1RCC3EfM
         ZpafBQC+AARdBj+gIJmP9dOJ7j+1ESfoa/khA99ZD3w6boT+jZxaxrIiM4Zhqw88wcLL
         4RkmWqMDCYKP3cdEfoRnaxDcuM8pC1GMZHSROtk2ipSLYfEWLp9Fw6tWvZf2r0YcpYwr
         TjwdkQoyPFCtZANxiQ30pIBaYhtneedlJvYfqNf1ia2+oDL7FwWnQrBSueJzbH70Wlnx
         Sgsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779131281; x=1779736081;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EBDXdrLaiJs5mJCkZrMnLOovecApXs5qp8DhmlH8DV4=;
        b=syxaGoDinh2JykAlo/7QSBbBBtAHplRJnUIG+BB65xz5XEAmM4NcD0UFSGOUoxTeeK
         LOcwMj1j0bQrBGbM+1GprW1qR6cvAbb9xlAkQmXIi5jTRlMSYfy7AW02v9nF6BgNwS3n
         vozrTXUxRz18N4J3IMjASRFZgPIkuoxEHCCvEf5MTtdrqOtt6KL6blqol6uvLW1JWSwu
         i6sYhZLM2gu8P+uo9LriP9XDxAGRMRNjIBiRM3e9nEUx+xseKF9QZUcHtEjSEyPTntmy
         7N6mn2vzznFA1xcfa40rY1arub429maWv91oz2+O4gPyd1oPeNtZ601AQ6qMo4aUS1gU
         E2Vw==
X-Forwarded-Encrypted: i=1; AFNElJ/N8R6RYbEou4UgV8kbOf4EgvZfeG3nIMCs8SR9jnM3lY+rhd70yzdbM1rjbw5ZIvuad8zNQBU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzyofrV0s7+tsn8zQYEwIG1/gxFaypgrZTeXA24+RF/7dFNbCct
	gh03/nZjunDvtO5R1M14qCv6dS7BA2MjiBsk/hZJ0el0KhQX3FxdsPt0
X-Gm-Gg: Acq92OH1W0QMB6vvPzU3UJiyBKRPp/Y/ECBbsYoLh+7xKV2CzdqwC83Z01KDDFrXqLL
	pw78WnzkDvN3bt1g/vQtnxwUjQmZl3itNlvMF4WvA/PMmu7A2kAdCQhFp+IpYU9P05p/qULC2wB
	64YbJsitAb50yGNoYZxO5DGi0x0dTnWumzZYi6PcGZjCIcE6f0HDInsXa0c2QmBCWA/OASxcNa4
	wfh3YjVg6ay7kQFlBtLH731TwKEZyNUo4z7i7zbB/og3cMHJZLzjZDkyWTSXptwKR8rWRixPaJV
	rM5dmD0c9+wGIDhBlKMkHAcIm7fWZDTib70LWkHS8khp8F/3YP+570QDMf/4MqpyCI50BiY4RyA
	I55GFX0psvE2ZdfUxb7hPwDPu8z7DP6BW23kveC7HIXoATHu2kpfk4I6zkQrxkH91pQTT5Y9eqM
	czhr0MKLLfirVli/TanPr2sKroxQsenRF5BHH9CZlFrXljda5LpUvrCoY6nL3DhFivKWx53P3E2
	fpJayfBKGkAlETAm8JF6ZTp650=
X-Received: by 2002:a53:d045:0:10b0:651:c734:ed4b with SMTP id 956f58d0204a3-65e22686be3mr13638970d50.2.1779131281317;
        Mon, 18 May 2026 12:08:01 -0700 (PDT)
Received: from localhost.localdomain ([186.151.100.108])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65e0db0b11esm6766160d50.11.2026.05.18.12.07.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 12:08:00 -0700 (PDT)
From: Sebastian Alba Vives <sebasjosue84@gmail.com>
To: yilun.xu@linux.intel.com,
	gregkh@linuxfoundation.org
Cc: linux-fpga@vger.kernel.org,
	conor.dooley@microchip.com,
	mdf@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Sebastian Alba Vives <sebasjosue84@gmail.com>
Subject: [PATCH v8 1/3] fpga: dfl: add bounds check in dfh_get_param_size()
Date: Mon, 18 May 2026 13:07:40 -0600
Message-ID: <20260518190742.61426-2-sebasjosue84@gmail.com>
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
	TAGGED_FROM(0.00)[bounces-249373-lists,stable=lfdr.de];
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
X-Rspamd-Queue-Id: B19895729A2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

dfh_get_param_size() can return a parameter size larger than the feature
region because the loop bounds check is evaluated before incrementing
size. If the EOP (End of Parameters) bit is set in the same iteration,
the inflated size is returned without re-validation against max.

This can cause create_feature_instance() to call memcpy_fromio() with a
size exceeding the ioremap'd region when a malicious FPGA device provides
crafted DFHv1 parameter headers.

Add a bounds check after the size increment to ensure the accumulated
size never exceeds the feature boundary.

Fixes: 4747ab89b4a6 ("fpga: dfl: add basic support for DFHv1")
Cc: stable@vger.kernel.org
Signed-off-by: Sebastian Alba Vives <sebasjosue84@gmail.com>
---
Changes in v8:
  - Add Cc: stable tag.
    Reported by Greg Kroah-Hartman.
Changes in v7:
  - Correct the Fixes: tag commit hash (checkpatch).
    Reported by Xu Yilun.
Changes in v6:
  - Rebase onto linux-next. Add cover letter.
    Suggested by Xu Yilun.
Changes in v5:
  - Add blank line after the new bounds check.
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


