Return-Path: <stable+bounces-204327-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E4BFCEB779
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 08:47:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D548C30053D8
	for <lists+stable@lfdr.de>; Wed, 31 Dec 2025 07:46:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D08F32FCC0E;
	Wed, 31 Dec 2025 07:46:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b="RhQSeVNl"
X-Original-To: stable@vger.kernel.org
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 114B52AE70
	for <stable@vger.kernel.org>; Wed, 31 Dec 2025 07:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767167206; cv=none; b=GzcEPCj+iyF4GAlyWn4Ez5tOlYKlWVFROs/KP1KCcj5U+L1rQuzluXjidbE2XyPEvJFr4G/2IqOaudY8jVmGvcy/FZJmZOvvT30SsF4ne06gZoDjA5+Uf2gApIOyPHh0/ucnay3e8V/KDBbxjUZApu4Sw9LbwoTpgTAezOMsUoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767167206; c=relaxed/simple;
	bh=S+QErFLPAsEmZdXL2ZR61ZlxoWFp4vGhaMp4rKO0qdw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XxNPm1XEMcKbM+UA7m2C/69laZbtvsGbPnMpNKsnZ8MzeJTcs8TA1BKKogBEzAGAhjg08i92goO1p9PZC8aRGfHiwHBCoTD0mGhNSIK5rUue5bZnmyh+uv4RvTNIlbKWnOcbNptnKoirmBeU+ta9quMPnQHL4p6cHRRpxhDQGvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com; spf=pass smtp.mailfrom=cloudlinux.com; dkim=pass (2048-bit key) header.d=cloudlinux.com header.i=@cloudlinux.com header.b=RhQSeVNl; arc=none smtp.client-ip=209.85.221.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Received: by mail-wr1-f44.google.com with SMTP id ffacd0b85a97d-42fb0fc5aa4so8223230f8f.1
        for <stable@vger.kernel.org>; Tue, 30 Dec 2025 23:46:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1767167202; x=1767772002; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=rcK5OWb8lQWwyYY1U8hmUdtzkD50MwR2w8DVGyTAGVA=;
        b=RhQSeVNlJSug8r8qSJVYFzGN9ytpFGmyyN147pxUPNV3fm/S+QxmzQvF194YqIEXep
         janSo3sZB+/4Qh09Vd8rO6CBrcO3yh8aSr8On7NdH750U+EChQPmhYO29/0D9sPHxHDu
         cq0dtVwaokMaRL+krmoT3hykBaB0bOTOFLfy789nKkquTtVqLgbaiXk1zTeCBVKjmKX4
         E8oJ4eFQK0SF8C7T7+ewChaYNLRjPc/n3JPML15IGLUq4ERy/EzAB+LvuNPeGXXtokBu
         oweQlPlfb0/yKaBNvJ4F5wUCOqIcHemAShOSLtY79nbvJtFz6WC8UvNDd5x0s5zWSuwz
         F5zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767167202; x=1767772002;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rcK5OWb8lQWwyYY1U8hmUdtzkD50MwR2w8DVGyTAGVA=;
        b=fPcWD7JevQyYVwNecXvIyvkhX0VNjmKVxx8fhA4pn2+N1ZolNi1exQoHacvp80IPgm
         divLMDqn+lkfGlA/o+nVP5g2O+D1gatQdPIRyhir2Ve0zrzE+IRO7XH8J589ZZTUDbby
         M+PKeJHfuScaz/amKA6tJQw+n5PVqngdVY5pXX6J3T69ZtvjFd0sUJTf0VYeKHJp7eDY
         M0ELvDHmoAhAlmmGRHUmBWG52a2FRrCCDIDtVpDLVHtvz1HMSKjJepz9+wDOQDCXi890
         1jAgRGvSEF8j9bXtV2zB5myEurIcRO3+KAoDqwj/xWgjaAuqX4vfyl1R7C36P7luWbh9
         KVzw==
X-Forwarded-Encrypted: i=1; AJvYcCXLorlAqK8DzC6aTahkCl+hYdZXSWj7JC61YNhthNKYfhOT3J+q4V5ThnpdZb9g+G3VsAXK4o4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzS2RZZNub1oKW1fxwFg8m/RhqZJa55HWaXlhH3YIrVW/GIPGHW
	CKOqU1fwSb+4JXhvXWIvwaOCqRFX8vaaswBZjFrmOshrf4zgIUU9J4oQ8Rg7zQVqyVrCLuRVhNH
	nTzRYDcg=
X-Gm-Gg: AY/fxX57BN1xfCpdsB3ig8zwxuOdu1I/b2sCYn0f5kZIEfY2opfPlTzfboJXS6HiXSu
	HmJIV7crQab8efZ20PTBYHW5zycHfwAl3YWPXW+GUDKCf86miYAQdzJH+CqEeP1a4u2iOeUsb/3
	bKBwcGW+DXcbw2Lp2Ajv+P/V8o397X7HX/maH1+S2Z1R+X5u5xxDaKQQ5OS74GjzqPtrpNiZ/yY
	J3/FKXjDhVnVmwFmX2qJesaAhOytDPI0fVR3V10akO2zh6Ss3T2tGnUkGbyMBh94ghFh8TUZ/au
	peqAOZ/jVDE8wh5TNaPequZiCbWUg6UNIIiUF7Mm64gkAwPll1R1pig1SKfSHVUAFGAwcJNRStI
	cKJTDCrZV3W3o1k0X30iMC8Iru3rfJP2zlUS3n6RBhSxa5m/vcibjX+RV+BEpMWU4nNk13ZfCyy
	5C4uW+aVCs83pDXXZS23CbWBCNjOBqXEs=
X-Google-Smtp-Source: AGHT+IHgPCTbrZ8SuyzVrzffH6KxGgE30rE6DKiN8ff7CAf5R8oHwTDdgYTozgvOKrd776lNlz+n6g==
X-Received: by 2002:a05:6000:2c06:b0:431:864:d48f with SMTP id ffacd0b85a97d-4324e4d5029mr46915304f8f.27.1767167202241;
        Tue, 30 Dec 2025 23:46:42 -0800 (PST)
Received: from fedora.cloudlinux.com ([94.204.137.252])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea1b36fsm72315953f8f.5.2025.12.30.23.46.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Dec 2025 23:46:41 -0800 (PST)
From: Pavel Butsykin <pbutsykin@cloudlinux.com>
To: hannes@cmpxchg.org,
	yosry.ahmed@linux.dev,
	nphamcs@gmail.com
Cc: chengming.zhou@linux.dev,
	akpm@linux-foundation.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] mm/zswap: fix error pointer free in zswap_cpu_comp_prepare()
Date: Wed, 31 Dec 2025 11:46:38 +0400
Message-ID: <20251231074638.2564302-1-pbutsykin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

crypto_alloc_acomp_node() may return ERR_PTR(), but the fail path checks
only for NULL and can pass an error pointer to crypto_free_acomp().
Use IS_ERR_OR_NULL() to only free valid acomp instances.

Fixes: 779b9955f643 ("mm: zswap: move allocations during CPU init outside the lock")
Cc: stable@vger.kernel.org
Signed-off-by: Pavel Butsykin <pbutsykin@cloudlinux.com>
---
 mm/zswap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/zswap.c b/mm/zswap.c
index 5d0f8b13a958..ac9b7a60736b 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -787,7 +787,7 @@ static int zswap_cpu_comp_prepare(unsigned int cpu, struct hlist_node *node)
 	return 0;
 
 fail:
-	if (acomp)
+	if (!IS_ERR_OR_NULL(acomp))
 		crypto_free_acomp(acomp);
 	kfree(buffer);
 	return ret;
-- 
2.52.0


