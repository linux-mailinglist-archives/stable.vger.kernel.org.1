Return-Path: <stable+bounces-166465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 87AB4B19F94
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:17:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40C3E189A4F4
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6E6422259D;
	Mon,  4 Aug 2025 10:17:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="HJHJUzNq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015EC2417D1
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 10:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302651; cv=none; b=moJZF8gC+V8HedHg/mJC8jOmbKSi7ZIBGzIz1UVzB7BmA5/qePEmcbokOn477NhPU9R+3wJlKYCclir4Ejndhlhd2tSnbJlsXKX49mPQE7Upd8EVp82adY9XM6EZVFGXH8DxIEPrnhxs3AshXODFmpI61Z7j6+qzXLyK2/mqLU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302651; c=relaxed/simple;
	bh=GxvB9kZlljAyCtaStYtXCyb0d/Fpu0HoUgG5dlIsVdY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dwgvTJh8T8mjL6oeZa0LpySGX6+z7TzKefCi7pcytbbDSrkhu1QyefUvuPh9zTIFYnxhpuqTr/BKZhnx9I6xsXuyq4t5hN5Fg/PBiWP5ToMItzfKMCaA2IOQX1vsbgEenRLn1pEYqvNzPO874yxTdnBx4Yf17E03qXfIB/uzqgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=HJHJUzNq; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b421b70f986so3255605a12.1
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 03:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754302646; x=1754907446; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2wzIxW+E5bIxOX7QdsVgfjxRZdWss8FghhfLm9ZACD8=;
        b=HJHJUzNqO+xDgv8Ls1HKCvd85mqjChYI/8sXkV+sh+4vr+QQSCYFKtf9LySiCgDlMg
         1ALLkl9KuU0CW/8pjWfZbxqt6xuejEyfvk1O8gXNVHO5IrXFYnORX148TAgkt/FMP/aX
         28jErFRLo8CKQvmNT83SsQIHFzbyK+OVcK5Ao=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302646; x=1754907446;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2wzIxW+E5bIxOX7QdsVgfjxRZdWss8FghhfLm9ZACD8=;
        b=JzBJgv5sbGM/VA+EA+UNHmFQW46YUjKGqCrMTdajZJLDEzOleb8UXccHwvQkQ4OGhJ
         /L3YkxLMb1qo4rtI2yl2ky6YKgwlp/r0o1GSx9iqV4KKl85ZgVOrYSChb2u0b59OFpbQ
         a0h8LPwmC0B9bm8UkphT2D24Zmrpl6m27V0J0WYoeagx9zSRDZZrzc6QJiH5XYfhKYHi
         Q9DdZTKyAAYxs2TMObPZlaZdUGjjCtiwSpKY57q5lrEhkwRY0UDm3eIfElLM1iqO1suR
         q7NcoTdaqkcAZcX8yz1jafNoIBVQARyLABfwbM23s1N7rVnUfrHTDwhGiRgjgimkNipT
         ki3Q==
X-Gm-Message-State: AOJu0YzoNs5ci30JpvuVJyslbGuJTGJSnEhhWrGsFzBH7DlSzav1dYzs
	ir0z2cosB/0q3DNhkvpW7rELP7nXlZP+gB57gclF9Qap9mpmaxNHFy+GYIAZH9x2EXoqlDfkat+
	bkHQ=
X-Gm-Gg: ASbGncvR7/BIULCsAWeo8rZFrOIn93yEHrN61Jj9G4Zvxz84Jt9SZOD/vak+/4T4QPC
	r81dIz5iUiEu3giMe//euBKEc5TbJgQ4hQ5gJFfSdOE2Bi6sXzf9Xcx1sJ0DjVHqhf16oijhh0B
	A+REVHf7fOXCo7JCGkl8ouHQl6wGL3m1YOgFMcxbCDe7LyJYjb02AhwIC3sHu6BAfx6ZuBMz3dq
	vxjMemFQIXaEO05F7hpfa1gglFZCgxgquYYvjE1qh7XvTTRLDC2NssFGAKdKvuHcrd7l4zhpmHa
	cwKazBhjUM3J3fbGn+vPLAodK1SJQsJupWlEkFP2IFUnLuRTo1UYQmjJnOkUYhhcVlpNuPFNXHR
	aFMLMAKoNXvFp0uBmEdXW1ZGXs2xLDbkjPhN3lCJJWh4k84aM6LXCsm8Spyg=
X-Google-Smtp-Source: AGHT+IG9al9MEq3hdCDNW4lnTknT3dhuQqMgxnX6nogIBuN2uBuxCYMNENn7CaSOYuyEyASpMFmV0Q==
X-Received: by 2002:a17:90b:38c1:b0:31e:d9f0:9b92 with SMTP id 98e67ed59e1d1-3211620ad4dmr13154667a91.14.1754302646155;
        Mon, 04 Aug 2025 03:17:26 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3668:3855:6e9a:a21e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm14085261a91.10.2025.08.04.03.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:17:25 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH 6.12 6/6] drm/i915/ddi: only call shutdown hooks for valid encoders
Date: Mon,  4 Aug 2025 19:16:44 +0900
Message-ID: <ff10c20ae7a05ef436366e71b609374709f1c517.1754302552.git.senozhatsky@chromium.org>
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

[ Upstream commit 60a43ecbd59decb77b31c09a73f09e1d4f4d1c4c ]

DDI might be HDMI or DP only, leaving the other encoder
uninitialized. Calling the shutdown hook on an uninitialized encoder may
lead to a NULL pointer dereference. Check the encoder types (and thus
validity via the DP output_reg or HDMI hdmi_reg checks) before calling
the hooks.

Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Closes: https://lore.kernel.org/r/20241031105145.2140590-1-senozhatsky@chromium.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/8b197c50e7f3be2bbc07e3935b21e919815015d5.1735568047.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index 9e42f0836989..5b24460c0134 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4798,8 +4798,10 @@ static void intel_ddi_tc_encoder_suspend_complete(struct intel_encoder *encoder)
 
 static void intel_ddi_encoder_shutdown(struct intel_encoder *encoder)
 {
-	intel_dp_encoder_shutdown(encoder);
-	intel_hdmi_encoder_shutdown(encoder);
+	if (intel_encoder_is_dp(encoder))
+		intel_dp_encoder_shutdown(encoder);
+	if (intel_encoder_is_hdmi(encoder))
+		intel_hdmi_encoder_shutdown(encoder);
 }
 
 static void intel_ddi_tc_encoder_shutdown_complete(struct intel_encoder *encoder)
-- 
2.50.1.565.gc32cd1483b-goog


