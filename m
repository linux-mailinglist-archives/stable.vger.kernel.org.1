Return-Path: <stable+bounces-105366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18B4A9F8663
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 21:55:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11A0B1894CEA
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 20:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 399C81D07BA;
	Thu, 19 Dec 2024 20:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Zf1uV8FH"
X-Original-To: stable@vger.kernel.org
Received: from mail-pg1-f176.google.com (mail-pg1-f176.google.com [209.85.215.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BBF11C07EC
	for <stable@vger.kernel.org>; Thu, 19 Dec 2024 20:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734641692; cv=none; b=HvI3j/t0CWrxadM0zMbE+MgCc5WfD+ySwgm0sDYqvdT+38fMoRlycl1vn60fEPRAJ7tiI8Od5cE8+pI6prPbk6wruRpssRMhgxKeLcIrRBGI++ILXa0aswWk5Uvcu8rxf9ObTnG/vJIBDcTaaI7GGP2fvyXbTkwy1UfH0QZDtK0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734641692; c=relaxed/simple;
	bh=dk6yOhy+In+//VLQ9Xjx9LYbW1IaqEuO8wfTODHuApA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oO5UvuwDXYZ121fKeLj8bR3WiaHQmFBG7T6U0xYWwyZsqJFCwmqRydZpSAEVVp/aaiN1/IcXrL/bJV8FV8VvlJJp7u4CMLEOEBbaIriAUB/T4qzjvWvH4HySUCrZvvPIU+TJ0VzO1mw40Z6z8QNm4r6RKB/+69ejYOtde5LWJp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=Zf1uV8FH; arc=none smtp.client-ip=209.85.215.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-pg1-f176.google.com with SMTP id 41be03b00d2f7-852fff91550so171842a12.1
        for <stable@vger.kernel.org>; Thu, 19 Dec 2024 12:54:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1734641690; x=1735246490; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8nYPl8ByRqy7GQGlWB5bDU6INvfmgU7gSd26B40zOKE=;
        b=Zf1uV8FHilNfsoC/3WAZlS+n4Mh4a6PpZuEMCNHH7UnuxkZNwgxBcSkJQvJz5oa7jf
         +p1Q8A+dQ2X8cL3lL8VETH+KWSwwJue5DC9baab4eLm6lnOfdgtS4OUQRjTcOh3NwpcE
         NE1ItHHx3bW0buOZr3TOE/bT6spb8II/XSezw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734641690; x=1735246490;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8nYPl8ByRqy7GQGlWB5bDU6INvfmgU7gSd26B40zOKE=;
        b=tr36W8TZFJYrfivGVlhzLT6Jqk0qtOPWw3iSOR99UYAgCsTj6CXSTHel0lVnR8O4YY
         9T6AUNQY4HMqE+n6F3teOhJ5LoNC81xEU4lk+ujGG4N/MvVn+9me1emHV3P14uUTN3V/
         96AVEwmuJfnIE9k7l6iea9nn7KhUu0mitI7csGqcaqe+pKd+hXzebn9/BzA1uNxYZGLo
         0pDjQaLw13AbqBbt/+ZDyt9wOolHlUU7yihxEi0mZJentQCHtC3WvjYPRPT4spIrfM3Y
         6Nrm0vWOAKcJISBDqR459vJgPauoJyBwRRaSYhCvVXFGxY3j3Oi/xrdPAhwB71+YdXWj
         Gzcg==
X-Forwarded-Encrypted: i=1; AJvYcCWFDu2T6nZXOEU89ba908jmAuZcNXl6w5f6AJcY6P4QcHY+qXrp9nNoxgouQBmI1nS9yGD5Wl8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/nvOpCsWTX/2w/MMYcIoSkp74jmYu+GdZATmVs++VxO4l74EB
	s1y8vTVXDu9N+eMc6raSHwaBlur4OB2t/st2MuEgRoq+FPplQc/FLsLuQcNxAg==
X-Gm-Gg: ASbGncvlSE4rb2mMXzVyG+i40pnLrP4OJE5z6+WOVGb/ASrK7t54wdVEzPwxXhWd8RQ
	ct1gycUBfJRN/8uC0M3losjCwYY5I26QyWSOM3tee6ktjeR5qHDULv1XO+W/ta90ixWWJ1J+S3v
	67jdatkcuqeIbHOJkhNwCoRvuAcN0OFjV2rsHurFIhoriw72Me+4gXqJIw9hpjZ4WZjcmtBvMtd
	gYCdX7QlnYWVfJDOgVn2M1lXH0L/EGPlCSHD7XYFp/UIRE0jKOTHfBL7mnY8xIYv+MEyAPq0QWI
X-Google-Smtp-Source: AGHT+IHwccOicX14rSFcDOJXBtww/CDCMLgDGO2mkaPlpWN8gXB9LCHU0FnM7zfKAT8dE4Ug4VhHdQ==
X-Received: by 2002:a17:90b:5487:b0:2ee:f653:9f8e with SMTP id 98e67ed59e1d1-2f452eeda4dmr637078a91.35.1734641689761;
        Thu, 19 Dec 2024 12:54:49 -0800 (PST)
Received: from dianders.sjc.corp.google.com ([2620:15c:9d:2:a8a3:6409:6518:340d])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f2ed644d87sm4126905a91.27.2024.12.19.12.54.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Dec 2024 12:54:49 -0800 (PST)
From: Douglas Anderson <dianders@chromium.org>
To: Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Mark Rutland <mark.rutland@arm.com>
Cc: Roxana Bradescu <roxabee@google.com>,
	Julius Werner <jwerner@chromium.org>,
	bjorn.andersson@oss.qualcomm.com,
	linux-arm-kernel@lists.infradead.org,
	linux-arm-msm@vger.kernel.org,
	Jeffrey Hugo <quic_jhugo@quicinc.com>,
	Trilok Soni <quic_tsoni@quicinc.com>,
	Douglas Anderson <dianders@chromium.org>,
	stable@vger.kernel.org,
	Anshuman Khandual <anshuman.khandual@arm.com>,
	Besar Wicaksono <bwicaksono@nvidia.com>,
	D Scott Phillips <scott@os.amperecomputing.com>,
	Easwar Hariharan <eahariha@linux.microsoft.com>,
	Oliver Upton <oliver.upton@linux.dev>,
	linux-kernel@vger.kernel.org
Subject: [PATCH v3 2/3] arm64: cputype: Add MIDR_CORTEX_A76AE
Date: Thu, 19 Dec 2024 12:53:22 -0800
Message-ID: <20241219125317.v3.2.I151f3b7ee323bcc3082179b8c60c3cd03308aa94@changeid>
X-Mailer: git-send-email 2.47.1.613.gc27f4b7a9f-goog
In-Reply-To: <20241219205426.2275508-1-dianders@chromium.org>
References: <20241219205426.2275508-1-dianders@chromium.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From the TRM, MIDR_CORTEX_A76AE has a partnum of 0xDOE and an
implementor of 0x41 (ARM). Add the values.


Cc: stable@vger.kernel.org
Signed-off-by: Douglas Anderson <dianders@chromium.org>
---

Changes in v3:
- New

 arch/arm64/include/asm/cputype.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/include/asm/cputype.h b/arch/arm64/include/asm/cputype.h
index 488f8e751349..a345628fce51 100644
--- a/arch/arm64/include/asm/cputype.h
+++ b/arch/arm64/include/asm/cputype.h
@@ -75,6 +75,7 @@
 #define ARM_CPU_PART_CORTEX_A76		0xD0B
 #define ARM_CPU_PART_NEOVERSE_N1	0xD0C
 #define ARM_CPU_PART_CORTEX_A77		0xD0D
+#define ARM_CPU_PART_CORTEX_A76AE	0xD0E
 #define ARM_CPU_PART_NEOVERSE_V1	0xD40
 #define ARM_CPU_PART_CORTEX_A78		0xD41
 #define ARM_CPU_PART_CORTEX_A78AE	0xD42
@@ -158,6 +159,7 @@
 #define MIDR_CORTEX_A76	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76)
 #define MIDR_NEOVERSE_N1 MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_N1)
 #define MIDR_CORTEX_A77	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A77)
+#define MIDR_CORTEX_A76AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A76AE)
 #define MIDR_NEOVERSE_V1	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_NEOVERSE_V1)
 #define MIDR_CORTEX_A78	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78)
 #define MIDR_CORTEX_A78AE	MIDR_CPU_MODEL(ARM_CPU_IMP_ARM, ARM_CPU_PART_CORTEX_A78AE)
-- 
2.47.1.613.gc27f4b7a9f-goog


