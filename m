Return-Path: <stable+bounces-165055-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6843B14CB7
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 13:06:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F9443A643A
	for <lists+stable@lfdr.de>; Tue, 29 Jul 2025 11:05:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1553C28C00D;
	Tue, 29 Jul 2025 11:06:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dIxSjL31"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5442728C013
	for <stable@vger.kernel.org>; Tue, 29 Jul 2025 11:05:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753787159; cv=none; b=YhNjjL0YZuxhXH4alXZFS5LL3JjuorG4JkJD+3ihyPPXbUw+v5FP1976cBv2Jl5oEyiMPKfgLT4mVc6GikbV8U508Iti3gSKOS3YF7T6vKfgefsTLy135AqIWB9hTX6w3G9+4D/0LVRsV0IaxvkMwult0YRjiSdOH5zntbThsJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753787159; c=relaxed/simple;
	bh=I9kLV2anI0MpCPn1nA9ysq56rcSc9+llBUXrV8n82oQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6u/rxoe9RFaFUF35R/TGKI3Zwjf2tJeVkTmydoMF0U3EkQQ/Rq8VnuW9RTaVPettMmw34LFxDfT+dblPC28bN7Y4qsbm3zUbNqKHcJqVZGNkQfdaq9wm2gJdW6QIrD/IosJtbentEdvOEO1qI6XqG6pIFQqEuKUtCUc26KqS1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dIxSjL31; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2406fe901fcso5531335ad.3
        for <stable@vger.kernel.org>; Tue, 29 Jul 2025 04:05:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753787157; x=1754391957; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WLHeYkFqqgcgLLa5E70HO7JnbGS55Dax9Okm1rFtTZg=;
        b=dIxSjL31+/q+BSOxb+jOHygH0YZcg4/xO5+CqH2QA+ZLNRGdLXiW0/jHffKlHorbn7
         2EicQmBxADf+UmiykcpzUXCQQqhZ7Zfs4cUFg8kCP8X1GvQb/qAUWcNy2qhJTd3goN3C
         l/1Xmz339Im7VFD4lYdFEFRfqnYi1NVziu94yUJ0WDYisFGCPCWpiJPnmUeUa1jI9xnH
         Vzw9/eT4z/1elS9G1bbiA86CxCVXzRGGZcldKF4cu4J3OYXEKCj8bxvzbDlv2lysWz9J
         DRepy4/CbmDYidnYpnJU+H5w9UsX1eMwjQ/EOUA1aE774dVgWq1Gb3efF54dI/CgFzTF
         HZSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753787157; x=1754391957;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WLHeYkFqqgcgLLa5E70HO7JnbGS55Dax9Okm1rFtTZg=;
        b=HU0kK3TlaK/sCn/vx3f8dm/x1LMn8OpAKEycp0XXVX+7RvFI7zHM8+5806iRLquYDE
         ntBB7QpC+rG2PPesqUrtXiCMdDxKmgsct4gOyIAFooucCTRFJFgt/1kX5QJFiC99E9n7
         a5UXEz1csh2NtbeABqXV7753Oxy59rda3cbw7U/hN1Rpwl3RGQ2PUHvZAAZ0sbui5Dqi
         1+os+SbXNNphAI50+ah24XD/pUemjmAV99m/qEMjJCQ3xnTPmF2i1y9QVCEdfJzUAwh8
         5BVtaB3Udc7yeHmcZHmzuk+QY2dKe6KmGHXKuMBNHLfdr5jtebfNt9FIGgiy2eOLGtlE
         aWqQ==
X-Forwarded-Encrypted: i=1; AJvYcCWVUzCaFykZ0LR3SVCxu+344Hi8SskeXqpKSWFJGOIFG7v+cATLgVIhpY33HIG+aARX54UOSaI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+lHwL2SqXOeZhskqSHP/Z8koJzCmN18UsxtcfYreJTwIWJHvI
	7rVupvGfPjudGsw4l34+aDM6pmQoEMlzcHIF2Xt43MrnzLXAGNbFr9I=
X-Gm-Gg: ASbGncvPBPLGmEJQC7tH5SAsn8Ia+hdkkmSklz8Y6XexsNFhJEek1313jIu+bIdV/bW
	w4PYgjY8jkJRnaHwvmG+fEgTG7ByqcWbSOAJjKKEUUMNRJ91TDxyoydBgVmCsvyCj7EhorR6YWi
	QzTQi9yhODcKviJUJkF9TZO8E6ZGwv2DULA7tq0ta3+9JXPt+w7XnTD8kJ3pKF4qaVpa02mpWjQ
	av2z5RSVL2nMMFx2iMlw4lUBr0tnzwoaTgi/964jzSOm0vvWDgAMCuIfKZWLyCtAIlUtQynUGN7
	suKcX0qDOIKD0b9z8bbKUz8Z2rQTqr/qtPORvXPQjrF8q23cfscZLesNFBsfOW1uxmgr70f7z1D
	yIeWtl+Fz0JyY0h5VUNVN13WEcLbbdO6R6XC7D/E=
X-Google-Smtp-Source: AGHT+IEaUlgjTCWhrh0w4mjTtnBsKLmW8QBUdOBpwR84OQmFTVKiyCPzd0imDRIAZjTJTlRy2xCB8Q==
X-Received: by 2002:a17:903:94e:b0:240:7725:18de with SMTP id d9443c01a7336-24077252f3amr19060465ad.37.1753787157361;
        Tue, 29 Jul 2025 04:05:57 -0700 (PDT)
Received: from git-send-email.moeko.lan ([139.227.17.83])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-23fbe30bc1fsm75929025ad.5.2025.07.29.04.05.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Jul 2025 04:05:56 -0700 (PDT)
From: Tomita Moeko <tomitamoeko@gmail.com>
To: Lucas De Marchi <lucas.demarchi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: intel-xe@lists.freedesktop.org,
	stable@vger.kernel.org,
	Tomita Moeko <tomitamoeko@gmail.com>,
	Michal Wajdeczko <michal.wajdeczko@intel.com>,
	Badal Nilawar <badal.nilawar@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Subject: [PATCH 6.12 4/4] Revert "drm/xe/forcewake: Add a helper xe_force_wake_ref_has_domain()"
Date: Tue, 29 Jul 2025 19:05:25 +0800
Message-ID: <20250729110525.49838-5-tomitamoeko@gmail.com>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250729110525.49838-1-tomitamoeko@gmail.com>
References: <20250729110525.49838-1-tomitamoeko@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This reverts commit deb05f8431f31e08fd6ab99a56069fc98014dbec.

The helper function introduced in the reverted commit is for handling
the "refcounted domain mask" introduced in commit a7ddcea1f5ac
("drm/xe: Error handling in xe_force_wake_get()"). Since that API change
only exists in 6.13 and later, this helper is unnecessary in 6.12 stable
kernel.

Cc: Michal Wajdeczko <michal.wajdeczko@intel.com>
Cc: Badal Nilawar <badal.nilawar@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Signed-off-by: Tomita Moeko <tomitamoeko@gmail.com>
---
 drivers/gpu/drm/xe/xe_force_wake.h | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_force_wake.h b/drivers/gpu/drm/xe/xe_force_wake.h
index 1608a55edc84..a2577672f4e3 100644
--- a/drivers/gpu/drm/xe/xe_force_wake.h
+++ b/drivers/gpu/drm/xe/xe_force_wake.h
@@ -46,20 +46,4 @@ xe_force_wake_assert_held(struct xe_force_wake *fw,
 	xe_gt_assert(fw->gt, fw->awake_domains & domain);
 }
 
-/**
- * xe_force_wake_ref_has_domain - verifies if the domains are in fw_ref
- * @fw_ref : the force_wake reference
- * @domain : forcewake domain to verify
- *
- * This function confirms whether the @fw_ref includes a reference to the
- * specified @domain.
- *
- * Return: true if domain is refcounted.
- */
-static inline bool
-xe_force_wake_ref_has_domain(unsigned int fw_ref, enum xe_force_wake_domains domain)
-{
-	return fw_ref & domain;
-}
-
 #endif
-- 
2.47.2


