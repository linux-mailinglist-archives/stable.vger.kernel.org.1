Return-Path: <stable+bounces-104164-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59A609F1B8E
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 01:54:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C76B1623ED
	for <lists+stable@lfdr.de>; Sat, 14 Dec 2024 00:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 716E43FB31;
	Sat, 14 Dec 2024 00:53:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oYcM4koi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f172.google.com (mail-pg1-f172.google.com [209.85.215.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E7E2940B
	for <stable@vger.kernel.org>; Sat, 14 Dec 2024 00:53:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734137596; cv=none; b=Y/7bT88x27LVpPNglWYYRATSaziHYY41Bwe0AvdIMyvg0rjo0/WZo+A3sAtIseeiExFjCA+BzwUpCQYnZrT6w69fQPEYi+zp1xfBL62gw4wkjj5Q178ROQxIS48I4zr1e0fkYeh+78G/N/hWsIpXtrxaBzF7YrTLVyhGfJbzIxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734137596; c=relaxed/simple;
	bh=V7gKntkQ8bwv+lZaockCmjTF5uEC8vW5YtYKvCaU2Ck=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qTb+hBWE8W6mEu6mCppQAUZxXPaHWXe75Bim6EUHPL7wcS66HbV3Fe/RM3HFbGCUI2GLC6H0gWzaUFfilHN0CiXudp4zRbWOizc7kwtLYqsfq1giltPM3CdrlMibOTFnDJ3fktjJVOa+NA8ai3lTf0WLLrCXEX5sGB7VEQETIlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=oYcM4koi; arc=none smtp.client-ip=209.85.215.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f172.google.com with SMTP id 41be03b00d2f7-7f4325168c8so1208979a12.1
        for <stable@vger.kernel.org>; Fri, 13 Dec 2024 16:53:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734137593; x=1734742393; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aUvE2f6iOzNwCrYNdrQY+FL/vDHn4ndwLWchPd2QhtQ=;
        b=oYcM4koiQzAZLEfY3lLfB8Eg/+jZLKhC+RDOkk0iMvD1IZ4szKZz7VsKMcxvQFEoMi
         8SjDmFAT7VHHLV14kp9igz74bRjd2zw3H4vr0pZAtavzuSmwLFR7M0DgODsqdji9NfhN
         Bq8wYqP4cKeQFMpZ1sz0iVdaLhQs2PenGONpI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734137593; x=1734742393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aUvE2f6iOzNwCrYNdrQY+FL/vDHn4ndwLWchPd2QhtQ=;
        b=slrpabbBvSU5gaNm6qSS9P6dSQyzJlvrOqENoXUYo3ZbGsFsik2Ngg49h7GS9lsqQL
         UWQ9zbOq4OwifePyYrCzK3udOm+lAub6wwJSrKmpO7U0eoMX6HDjxvtmbQ07l49KVbus
         6tT0EQwVRgFVyj7EAtx0pk/I/ldJ0EPe+YcG/hIDyXeUzhl7iF3DUFtqbg2awc1yklVj
         IuHVDnn8dwPbKL34+itmWpTgXDLGjDBBLF8IQOOzBXTvEEMmHuVDLUiSjvMqCVkFAyo3
         BRpYppNb6tYNPQ+c2JW08rW7Wr8AYWXHqwQUHSggsitixZN/ptDpoxUV1rifyxpOU21Y
         RDsw==
X-Forwarded-Encrypted: i=1; AJvYcCVrnnWAIVyOY/CkNnwkoSLwf6eZZ+aVUACsHhP7ivvavZdUC99wvIsLaT04WM1Z97/QtSPjpq0=@vger.kernel.org
X-Gm-Message-State: AOJu0YwlZ8WBXViwptWDambtju0/isl+iWtxKlux2BV52I0nelWpNAWl
	/rSisYMJ3dCbYKa+w0m3i+HlZ6JWXPH4HlP3y2QhYuqNEoc5KZMr3keS1JkkNA==
X-Gm-Gg: ASbGncvSDaPVz7Bp5trZO2VEhppLKG58LwwZJt3nGRNE4bxW9X5hgmd0vC/w5X4hBF2
	rojT56iFKaBpLbuG7XcR96gRoSxt9jalWfwrbF3e5pAXOW3VPbOKEQbM2wlrBq0/604dnyy0/yS
	I3f2U5zxZkFdLF48dnC9JNaGkHJp4CNlp+ldaNmM2IPm4kn5fBYtvG0FaFxlOX9yO9S3nDUvZeh
	aeUmSb47Ohm5jWWEPo5nsKwT2i19sl2cZeFBIblFTE+tOm0GbaR1LZ4qml0zU/cxRqJz9I9vdyT
X-Google-Smtp-Source: AGHT+IGU2S6Z3GVHm0+57veKVF9GWyDASh7uUNfkbmZbC9Zjun4Gf1t3LPe02j8X69XemOFEZkD8aQ==
X-Received: by 2002:a17:90b:3c02:b0:2ee:c9d8:d01a with SMTP id 98e67ed59e1d1-2f28fb63bf1mr6635097a91.11.1734137593296;
        Fri, 13 Dec 2024 16:53:13 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:ae86:44a5:253c:f9bf])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f142f9e186sm3788270a91.41.2024.12.13.16.53.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Dec 2024 16:53:12 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: linux-arm-msm@vger.kernel.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Julius Werner <jwerner@chromium.org>,
	linux-arm-kernel@lists.infradead.org,
	Roxana Bradescu <roxabee@google.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	bjorn.andersson@oss.qualcomm.com,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	James Morse <james.morse@arm.com>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 3/6] arm64: errata: Add QCOM_KRYO_4XX_GOLD to the spectre_bhb_k24_list
Date: Fri, 13 Dec 2024 16:52:04 -0800
Message-ID: <20241213165201.v2.3.Ie4ef54abe02e7eb0eee50f830575719bf23bda48@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241214005248.198803-1-dianders@chromium.org>
References: <20241214005248.198803-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Qualcomm Kryo 400-series Gold cores appear to have a derivative of an
ARM Cortex A76 in them. Since A76 needs Spectre mitigation via looping
then the Kyro 400-series Gold cores also should need Spectre
mitigation via looping.

Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---
The "k" value here really should come from analysis by Qualcomm, but
until we can get that analysis let's choose the same value as A76: 24.

Ideally someone from Qualcomm can confirm that this mitigation is
needed and confirm / provide the proper "k" value.

...or do people think that this should go in the k32 list to be
safe. At least adding it to the list of CPUs we don't warn about seems
like a good idea since it seems very unlikely that it needs a FW
mitigation when the A76 it's based on doesn't.

...or should we just drop this until Qualcomm tells us the right "k"
value here?

Changes in v2:
- Slight change to wording and notes of KRYO_4XX_GOLD patch

 arch/arm64/kernel/proton-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 012485b75019..04c3f0567999 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -887,6 +887,7 @@ u8 spectre_bhb_loop_affected(int scope)
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A76),
 			MIDR_ALL_VERSIONS(MIDR_CORTEX_A77),
 			MIDR_ALL_VERSIONS(MIDR_NEOVERSE_N1),
+			MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_GOLD),
 			{},
 		};
 		static const struct midr_range spectre_bhb_k11_list[] = {
-- 
2.47.1.613.gc27f4b7a9f-goog


