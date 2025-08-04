Return-Path: <stable+bounces-166463-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA822B19F92
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 12:17:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4F9EA3BCE70
	for <lists+stable@lfdr.de>; Mon,  4 Aug 2025 10:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA8FD24A058;
	Mon,  4 Aug 2025 10:17:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MwKf7TkK"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49859248F7D
	for <stable@vger.kernel.org>; Mon,  4 Aug 2025 10:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754302644; cv=none; b=lPgLZ30JfayEAhmYCo32Y7V204o5eIJ7yzQ7B8yirFoJ2mONdnrZ9igsaYb43KG8+WKRqMnx6nUDEu7nMRQ24Au0JtChkRrcQVqiZLnj1XF5RC0XnyzV+4s5scPcJb6HNHTREm8Q+qahyS2GPG6NFBtEr3ntFmeTV7nsljOC81U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754302644; c=relaxed/simple;
	bh=xgQg2piCgtcVJR28CucH+ZQVx1F5pV25ef4v6SAaxrs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R7PgeeNGSrhuZ++oNa1eCcfoNL8Rgy3AXApA+pBrLLdnwVCPZ7S1eki4rgNYcSH1952kEcrgDbFgsIqA+HToAqRROJIKwABfhyHUZC8CJJmdlk537cvUj3/tz2rxHFyBS77Mc7xfYOCCPkLlBTUOIr3Rtm+AL44p6LRGxMOHCqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=MwKf7TkK; arc=none smtp.client-ip=209.85.215.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-b3bcb168fd5so2210225a12.3
        for <stable@vger.kernel.org>; Mon, 04 Aug 2025 03:17:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1754302642; x=1754907442; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RF3WI8AhKcmAvKZyknl/8fs18EA9ITjgb8vqbZ01TbE=;
        b=MwKf7TkKmlVuoINPwEX8CgLbDcOcIWlBd6sGx7kN2Vz3TTUJMfyv448u/NmuBhByQO
         8/+ILnMBPVi1w55pchJWzHKEzz+UQwgKmsxEwRwXLhk8rfhwGHcH7K17iCxE4SMqr5Le
         wSkT7M9exq8zlx8pLHFNCUz7dcFMZ48pKcsFk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754302642; x=1754907442;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RF3WI8AhKcmAvKZyknl/8fs18EA9ITjgb8vqbZ01TbE=;
        b=LdKRUsyBNYjqPkKEQr8Bnwp464KrKf4CPHfazAlNE2IiQ2ZJtcChP4lXGQovunIP+J
         99rljXnt+nH4o7tQqCv72nB6ohhzRKAGskXzSBc9aSCPHl+6xxE0ARXOPtcwLQiooVi2
         K0A33Hj3kA/85nZe3jvQGsTU9TPJ7Voca2e1qYCuvJiCVah1jRIRVDC936sxBEpxr2O2
         6U8GiQXJ86OPIfGsa4xoQcXp7oELjpU2tAZJswpGCwSkWAby33wYfCn9DTVwqTaQwCd9
         URk84f6nWz+QgEqx8b+z7/IE+hdqVnwz8rLUkQf+Vx6wRCNGMo4EHiXxzFgiNUItxv7e
         Fw7g==
X-Gm-Message-State: AOJu0YwYN/ec7K5cRnJB3wCDD5MnGKfmFCUOPSlMosGY9gvNe+yneCTe
	N9J0cVi4Vghl+79gYUlGeeCdzyzJTPAuARIG66YtLv1xWHxGvtMN80LWFkUIAgh4KtrA+ZAkkpD
	qb2w=
X-Gm-Gg: ASbGncvh/Iae0QQvECywLssTZlbouxHzBVrlDlqA9zz6+ER2ciBx5NgsM+S0q/IcF6j
	oE2w11pFONpyEL5Aeo/QYrLwVxJMNG9Lx/g+OzfhDY6S8T2OH1CpJRmpsT3aa1s8i/etxzk/aG0
	4tktg/WMIhIEv7oZTCVrLufBivMLdyZPrY3EJe1JO0X6Tk15xXgIiTZLTBWQwhSC9klwQPPOuoX
	zPpaT71mXDFvXqE5MpkqHyJX3WNloJNpwLwAF3EQ0TNBO7ux59BfLuWHlk9zlmbswyNBrweClj9
	kmwoWb0zrnP+zootw0nVN6Zw2yRuMIdynrVmzhkqNB6shl6x+HbXnUssZONQgtFYoabLDiCOy2e
	3XVboZoPg/RnstOC5fjfrf7uJ1AN5Gmq+s6mfNGrAyPR005uLS9Puw1zz7Fc=
X-Google-Smtp-Source: AGHT+IH4ghSlw8CVyxpNBXyHgN2l0yODTFg6OZWi+jsnAj/jZcCvLxIwkGjGU43lbRYzXkIigSUKEQ==
X-Received: by 2002:a17:90a:dfcc:b0:312:f650:c795 with SMTP id 98e67ed59e1d1-321162bb980mr11703980a91.21.1754302642564;
        Mon, 04 Aug 2025 03:17:22 -0700 (PDT)
Received: from tigerii.tok.corp.google.com ([2401:fa00:8f:203:3668:3855:6e9a:a21e])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-31f63dc1bb7sm14085261a91.10.2025.08.04.03.17.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Aug 2025 03:17:22 -0700 (PDT)
From: Sergey Senozhatsky <senozhatsky@chromium.org>
To: stable@vger.kernel.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Ville Syrjala <ville.syrjala@linux.intel.com>,
	Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH 6.12 4/6] drm/i915/ddi: gracefully handle errors from intel_ddi_init_hdmi_connector()
Date: Mon,  4 Aug 2025 19:16:42 +0900
Message-ID: <d064859cde86c25f3be1b9b09d274b0082ca337a.1754302552.git.senozhatsky@chromium.org>
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

[ Upstream commit 8ea07e294ea2d046e16fa98e37007edcd4b9525d ]

Errors from intel_ddi_init_hdmi_connector() can just mean "there's no
HDMI" while we'll still want to continue with DP only. Handle the errors
gracefully, but don't propagate. Clear the hdmi_reg which is used as a
proxy to indicate the HDMI is initialized.

v2: Gracefully handle but do not propagate

Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Ville Syrjala <ville.syrjala@linux.intel.com>
Reported-and-tested-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Closes: https://lore.kernel.org/r/20241031105145.2140590-1-senozhatsky@chromium.org
Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org> # v1
Reviewed-by: Suraj Kandpal <suraj.kandpal@intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/d72cb54ac7cc5ca29b3b9d70e4d368ea41643b08.1735568047.git.jani.nikula@intel.com
Signed-off-by: Jani Nikula <jani.nikula@intel.com>
---
 drivers/gpu/drm/i915/display/intel_ddi.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_ddi.c b/drivers/gpu/drm/i915/display/intel_ddi.c
index b567efc5b93c..9e42f0836989 100644
--- a/drivers/gpu/drm/i915/display/intel_ddi.c
+++ b/drivers/gpu/drm/i915/display/intel_ddi.c
@@ -4632,7 +4632,16 @@ static int intel_ddi_init_hdmi_connector(struct intel_digital_port *dig_port)
 		return -ENOMEM;
 
 	dig_port->hdmi.hdmi_reg = DDI_BUF_CTL(port);
-	intel_hdmi_init_connector(dig_port, connector);
+
+	if (!intel_hdmi_init_connector(dig_port, connector)) {
+		/*
+		 * HDMI connector init failures may just mean conflicting DDC
+		 * pins or not having enough lanes. Handle them gracefully, but
+		 * don't fail the entire DDI init.
+		 */
+		dig_port->hdmi.hdmi_reg = INVALID_MMIO_REG;
+		kfree(connector);
+	}
 
 	return 0;
 }
-- 
2.50.1.565.gc32cd1483b-goog


