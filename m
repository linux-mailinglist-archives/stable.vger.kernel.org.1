Return-Path: <stable+bounces-166464-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B572CB19F93
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:17:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E4E11179D3F
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:17:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E98B81F30BB;
	Mon,  4 Aug 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="ltAOrfRt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4855A248F7D
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 10:17:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302646; cv=none; b=QUmR7VvsAt0XDuvESf6vd14ivFqpVAzb2BHWLV0KnTLqbIwDBoVJA5KNxtdz4g6/jD5V1T+lVvztN/RmYfdfNyIQYmZaS8Nji2loFMgZqmOIxqPobGgljx09SNwTY/SCPKGaEoSFuBunmLVZbffnbFXgrdL6aD337NrcYtUjqgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302646; c=relaxed/simple;
	bh=FLcKGNzbMLD60o5Kflw7C6M80pHTx0rAAGhF3TNjwHo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DDYVCIsv07hgQXSFKEf9/I+LQcR3ISwHDIRVKSBnIVKATHuIpMd/oENqFjtX4kddh8sTKwiuZ8pAj7vEU2pZARxhV5HXmji/Ap5aQWEvg1cmYDXLMSP8APta65dcKLt1GbZHhqTV8bgs/A2NTUnfM8wQGJggxDZNF02Mfa4YpjI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=ltAOrfRt; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-b4239091facso1865531a12.0
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 03:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754302644; x=1754907444; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vHidkXX9FJtxaLG7qr0gbrzwfg/zu8OQtZyjpx/2Eho=;
        b=ltAOrfRtyU4gwW28Q6OgdCGIbJMhciRrsduKnDwvCQ9NbyGLu9ty4RhBfXr1ZSheIB
         O6Tdmgk3UFIS3xylri+zuYAO620rRs8VJqJnjUzRdk4dcukw4taTKTDPA3tt2p6x8loC
         CxD3VwJgdq0mYl8XeAPrdBoirG7TIv3d7IglM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302644; x=1754907444;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vHidkXX9FJtxaLG7qr0gbrzwfg/zu8OQtZyjpx/2Eho=;
        b=Tqh0go+xjj6UgH3lXcDQpDOcHW5M+VN12ZzeeZra3n2skaVjUAGcus4JKVxUiHzgV+
         ou7PQ15jNrTqSanLN7B/RG54PdUXN3AdQAF7qy5/hhuizA+XsYG/LkiWZK1fOyj/J0sV
         KLKmw3c86Rw+rOEEfTbOt6BYQ7SgNxswMuK7A07UNnE3KXh7f71w4Q3Me+X1QwvhGQ97
         59LyduENRFPTEwuFcLqdrvO2b7+3NlHNp7iEDAHzNn7fwzqeejeIxrhDJ2jyS04DZLKc
         w08tehMu+AElbZEOdNrLPm7HZT081XmghlIkdWjQvAO6XJh1k0uGOoeZ1WEhQ99Ak6+T
         pkcA==
X-Gm-Message-State: AOJu0YzPQhU/WLRk/kZnspybx7rlG71Oxx++Hcz0eAg6xEDsaaHISMxR
	I8MmutDIBEJYXA99eBuG+nldom8SR9HTm3g65jN3XYTooaqQuKR4jUDfJykrnuk0WzEDnzOA6Sk
	IZws=
X-Gm-Gg: ASbGncsMRXpiUWboX8CLN8IJ/Oiq+ZUD+WVdkRm/EDJSjFC/owVdVNBw2xJwdnScl5v
	ZxyQKx/yZCGV57eUqap1zjyEE/J1v3wD4pCAZABDe/O3uU9Eif5Kg+80YJB3arf9wg60dFltJyM
	TDXYbe15wmmp2MkeiGgMuzKShMkfPR/QmlCH1RpFa7GdFc3rBr7f3GN7eNS9EPLiynvdlMdoUZo
	eYM/PW6FXBv15YuHAkzyzq/1aqbf2Y3pDZmBZRqiU500dvpUuizwrL5XnFqtADcyFHQBTYm48x8
	okrq8lYIz/IBFD/KziPt+i0s81bW8Krqtb1SFRxKuNUQ0Wa6zYPPz5jXyoCP09AWxnRoDMMUzAP
	DzerclzXl1s886LhFDzMrzeW/3nJGOliLtaRCbwlpE3LwFywm0scBPC8GzjQ=
X-Google-Smtp-Source: AGHT+IHDwsfOO7hKsTAFMBGk8T7MGA0768XuYk9WZ2h9NYZxoNUnokzcBntB9ixn9lJAyRP/VmXitw==
X-Received: by 2002:a17:90b:4b86:b0:321:2407:3cef with SMTP id 98e67ed59e1d1-32124073d8dmr7889296a91.32.1754302644373;
        Mon, 04 Aug 2025 03:17:24 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3668:3855:6e9a:a21e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm14085261a91.10.2025.08.04.03.17.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:17:24 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH 6.12 5/6] drm/i915/display: add intel_encoder_is_hdmi()
Date: Mon,  4 Aug 2025 19:16:43 +0900
Message-ID: <9da54648dbd77a7eee8a66a1e3a8255bb6cfad32.1754302552.git.senozhatsky@chromium.org>
X-Mailer: git-send-email 2.50.1.565.gc32cd1483b-goog
In-Reply-To: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
References: <e53d47b06b3ba07b4add2c6930ddafba91a49b41.1754302552.git.senozhatsky@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jani Nikula <jani.nikula@intel.com>

[ Upstream commit efa43b751637c0e16a92e1787f1d8baaf56dafba ]

Similar to intel_encoder_is_dp() and friends.

Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Link: https://patchwork.freedesktop.org/patch/msgid/e6bf9e01deb5d0d8b566af128a762d1313638847.1735568047.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_types.h | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 3e24d2e90d3c..9812191e7ef2 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -2075,6 +2075,19 @@ static inline bool intel_encoder_is_dp(struct intel_encoder *encoder)
 	}
 }
 
+static inline bool intel_encoder_is_hdmi(struct intel_encoder *encoder)
+{
+	switch (encoder->type) {
+	case INTEL_OUTPUT_HDMI:
+		return true;
+	case INTEL_OUTPUT_DDI:
+		/* See if the HDMI encoder is valid. */
+		return i915_mmio_reg_valid(enc_to_intel_hdmi(encoder)->hdmi_reg);
+	default:
+		return false;
+	}
+}
+
 static inline struct intel_lspcon *
 enc_to_intel_lspcon(struct intel_encoder *encoder)
 {
-- 
2.50.1.565.gc32cd1483b-goog


