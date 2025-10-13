Return-Path: <stable+bounces-184128-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A963DBD171C
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 07:26:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5F3033BA80A
	for <lists+stable@lfdr.de>; Mon, 13 Oct 2025 05:26:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFB92D1303;
	Mon, 13 Oct 2025 05:26:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="koPUogAc"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com [209.85.221.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B58D2C11E5
	for <stable@vger.kernel.org>; Mon, 13 Oct 2025 05:26:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760333205; cv=none; b=HL+UIOOu1oiJUe9hQwyHIeT53of6xAgXGwUbOPl39i7okvgjZ6OqvvvQmD1dyAkm3fI9wwfjPsrVV0mDioQ5Astbk+/IiFKLZbqvMpWoG8j+bz34e67zGJFOLxSoIPHohmDnOY3mahZlrfMzELnj6gBbAqu46GhYS7n3rMmWrls=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760333205; c=relaxed/simple;
	bh=bte+/wVXcSwCx7MOPocExUhSsc8jEuDiXCklRhPJ27Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=OB1T0o+Qt1O20X3HstOTdCQvwBXLA5IR3pnI+rMoQqyBom7fEU2FcKSt3oCJ2V5ZO1uoZ1jJ7q4bNE9CirDDG6i7KcUMM4mjASsX4SmfDtijnWzgO7N49klGWBiwccmIUx2Sb2ODfd5GigjeGMLprzXaNNCMpGHFRVZVH9F+L8I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=koPUogAc; arc=none smtp.client-ip=209.85.221.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f176.google.com with SMTP id 71dfb90a1353d-54bbaca0ee5so1171911e0c.3
        for <stable@vger.kernel.org>; Sun, 12 Oct 2025 22:26:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760333203; x=1760938003; darn=vger.kernel.org;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Vf/bbB2S5/yiMGyiJS9WX49wXVFc70s9KvXRbsVke5k=;
        b=koPUogAcFjaXU0mvqo1vdCrhXDgRQoj/+6lZZUDDcGugQ7pgKKYKqje597SY4/n0Qq
         1+0s9JckCGE+gJ4/V4lPquso5oWb17zVF/tJkJB/NIR0U7/pgMtXV31427CHTeWPpYqQ
         vl2M/CcInNEif7Iu3UMOl++44yrsmrS6+E4GeHcIvZCyuLCbZsrcr0eQtcnJONdtH5Lg
         GoJ/0BogwAWJHoUO9ZpiFrZEvdE4nwhI1VDHhT4iN7GvelSIaSaTYfSYZMCygYnpuZPX
         Frc0Fz98m6jR+Cve3rJaQnqyy9gNBdTvNhCRVAGY1kqNAlIcDdzp4UGPhGdcAUuG4duP
         DalA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760333203; x=1760938003;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vf/bbB2S5/yiMGyiJS9WX49wXVFc70s9KvXRbsVke5k=;
        b=MYISdDUJEq23oqpKXKrnjWI4D4+i+LUZ+5I3XpBag3natlekGNk6GFFcaH2j0kmWEJ
         aMYyoqXGV6pe4iQNjpZuXg0fzMgywRC2h0e0X7XLkLEeeS7pl/AnPgMInryudyOTg8CB
         vrOpvaTQpbKrc2y+P+PFE8nm+w6bQTmniiHRY1OKaFwBUF2pPAHaEj4Yx4DP8VBEBLlb
         cTz4xgPmJSuxlhjYloulYlJPaFuahO3cM7VO1OBVNywCQedhz/Ovy1C62KHdv/DuOs9U
         G2vVVp+n7a16j32SipF7ue/uLr9EaqjBN1KeCi9b7JRRgKQl41xoyIW0oKPo8AzmBBcU
         eaRw==
X-Forwarded-Encrypted: i=1; AJvYcCWp8Pb8DF5ta4QxLZHTCNNHJ7t0Z4tPwB/C22BSO5A973qtu3+ijVbCDGGoakKaNpANj8FCxWU=@vger.kernel.org
X-Gm-Message-State: AOJu0YyAUNhC+JY+PTUynrD3/zjwbQMkA3vzDv3jxKolyS4NZtt3OKXS
	ns7omCCQKTe8iBqQZ4eo4oBXX2n2TABUjSJ3Oxv7V/EHCXJ1WQgQMki6
X-Gm-Gg: ASbGnctPTAMMH3kPmg09pGZ1tBaKXiK2Gvw9COWz6MZLvpgWb7M/beEBmmzFJvQMUtr
	GA2FsY0uJXYInLHQ3PI+hLJNhYY9s9pDOWql+LM4cDjfR+rrjmx01h8mrageHhOCWw1bYJyxSfR
	zUIE+pLkJNn0nDTRwQpfDdQPk1+hkxQ6GUOQz194h56BWuJgNj9tEQDWjdUbItZMmmWz43XSega
	5gdOk8AyK+988z9grodhSkw9MhLROu20A60KbmVjqz9vFJ+bC9nxqzZg6UxKBCOoOvZP2P4p38U
	2jrRK3bSyHaFezovuZsR83JJfV8WygO2UtYHQoPw6iXE5PPFyR7u78KMmiRDRpd/WbJ661Ig5u6
	rjorlJTBgUZUaN68p2h/tXiPxIrp9tfRfr96FDNfAJPs=
X-Google-Smtp-Source: AGHT+IHxXC+pCZQx+aXV0IlhjLPkLiyhSlWgyNUpi8Iml6vF4L9jhh0Rvj5DdpwJ8PedQvRsqfXzrg==
X-Received: by 2002:a05:6122:2a0d:b0:554:afe3:1fb1 with SMTP id 71dfb90a1353d-554b8cf023dmr7141600e0c.14.1760333203045;
        Sun, 12 Oct 2025 22:26:43 -0700 (PDT)
Received: from [192.168.100.70] ([2800:bf0:82:3d2:875c:6c76:e06b:3095])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-554d80a456csm2823171e0c.14.2025.10.12.22.26.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Oct 2025 22:26:42 -0700 (PDT)
From: Kurt Borja <kuurtb@gmail.com>
Date: Mon, 13 Oct 2025 00:26:26 -0500
Subject: [PATCH v2] platform/x86: alienware-wmi-wmax: Fix null pointer
 derefence in sleep handlers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251013-sleep-fix-v2-1-1ad8bdb79585@gmail.com>
X-B4-Tracking: v=1; b=H4sIAIGN7GgC/03MQQrDIBCF4auEWdfiGAzYVe9RsjA6TQaSGDRIS
 /DutYFCl//j8R2QKDIluDUHRMqcOKw11KUBN9l1JMG+NiipNEpUIs1Em3jyS2gvtem8N8q2UP9
 bpDqf1qOvPXHaQ3yfdMbv+lPaPyWjQGHU4BCHjpyl+7hYnq8uLNCXUj56xq9logAAAA==
X-Change-ID: 20251012-sleep-fix-5d0596dd92a3
To: Hans de Goede <hansg@kernel.org>, 
 =?utf-8?q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
 Armin Wolf <W_Armin@gmx.de>
Cc: platform-driver-x86@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Gal Hammer <galhammer@gmail.com>, Kurt Borja <kuurtb@gmail.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2073; i=kuurtb@gmail.com;
 h=from:subject:message-id; bh=bte+/wVXcSwCx7MOPocExUhSsc8jEuDiXCklRhPJ27Q=;
 b=owGbwMvMwCUmluBs8WX+lTTG02pJDBlveifKcc/+nSOSsjfYylpj8yOhFKW5b119Os6ohc79N
 l93wV/mjlIWBjEuBlkxRZb2hEXfHkXlvfU7EHofZg4rE8gQBi5OAZjI52uMDCs2x3aqxHp/169R
 v/Bx8tVU/YU7ArkdNa/7VL67tj/Z0prhf4ik59GDG3/LRu/9KNXfdWJOwlGbyK9/vnYX1z5WUnd
 NYwcA
X-Developer-Key: i=kuurtb@gmail.com; a=openpgp;
 fpr=54D3BE170AEF777983C3C63B57E3B6585920A69A

Initialize `awcc` with empty quirks to avoid a null pointer dereference
in sleep handlers for devices without the AWCC interface.

This also allows some code simplification in alienware_wmax_wmi_init().

Cc: stable@vger.kernel.org
Reported-by: Gal Hammer <galhammer@gmail.com>
Tested-by: Gal Hammer <galhammer@gmail.com>
Fixes: 07ac275981b1 ("platform/x86: alienware-wmi-wmax: Add support for manual fan control")
Signed-off-by: Kurt Borja <kuurtb@gmail.com>
---
Changes in v2:
- Little logic mistake in the `force_gmode` path... (oops)
- Link to v1: https://lore.kernel.org/r/20251013-sleep-fix-v1-1-92bc11b6ecae@gmail.com
---
 drivers/platform/x86/dell/alienware-wmi-wmax.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/platform/x86/dell/alienware-wmi-wmax.c b/drivers/platform/x86/dell/alienware-wmi-wmax.c
index 31f9643a6a3b5c2eb74b089dc071964bd6df8b43..cefeef84d85d111e9cc15ebed35fb83f03c41c7c 100644
--- a/drivers/platform/x86/dell/alienware-wmi-wmax.c
+++ b/drivers/platform/x86/dell/alienware-wmi-wmax.c
@@ -393,7 +393,7 @@ static const enum platform_profile_option awcc_mode_to_platform_profile[AWCC_PRO
 	[AWCC_PROFILE_LEGACY_PERFORMANCE]		= PLATFORM_PROFILE_PERFORMANCE,
 };
 
-static struct awcc_quirks *awcc;
+static struct awcc_quirks *awcc = &empty_quirks;
 
 /*
  *	The HDMI mux sysfs node indicates the status of the HDMI input mux.
@@ -1680,22 +1680,14 @@ int __init alienware_wmax_wmi_init(void)
 	if (id)
 		awcc = id->driver_data;
 
-	if (force_hwmon) {
-		if (!awcc)
-			awcc = &empty_quirks;
-
+	if (force_hwmon)
 		awcc->hwmon = true;
-	}
-
-	if (force_platform_profile) {
-		if (!awcc)
-			awcc = &empty_quirks;
 
+	if (force_platform_profile)
 		awcc->pprof = true;
-	}
 
 	if (force_gmode) {
-		if (awcc)
+		if (awcc->pprof)
 			awcc->gmode = true;
 		else
 			pr_warn("force_gmode requires platform profile support\n");

---
base-commit: 3ed17349f18774c24505b0c21dfbd3cc4f126518
change-id: 20251012-sleep-fix-5d0596dd92a3
-- 
 ~ Kurt


