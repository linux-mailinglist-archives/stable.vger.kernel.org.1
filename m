Return-Path: <stable+bounces-146228-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AA54AC2D39
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 05:31:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A7F844E47FB
	for <lists+stable@lfdr.de>; Sat, 24 May 2025 03:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36E7819D880;
	Sat, 24 May 2025 03:31:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jxVm1+C1"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F7194A1D;
	Sat, 24 May 2025 03:31:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748057507; cv=none; b=EP5mNvTBTIH7sX+reAgM++pyAKRM4y1zHYxWW3ESHjP9Upf4ghHm9q0GUmaw6AmnZbyaPeT5o397Nou6/6qHJkg++78NnlQ/2F7dFF4apa+hr+OosUENgih6cREkiEP2nqSsuBrm+o5W99b1A7qV07sdR5LdpJlcXitkCG9B4ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748057507; c=relaxed/simple;
	bh=skUyVSXbiipwpe/RGHesq9AxqtDJj2JGXYoLDvznrIA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ob6/A4T9ZR6PVDldtbmqzpt2XXgeALch4S2DTnJDbqYh6+Nto9i0xlOsYVN4ukqWQiDMP+4yY8ORSSqyxwavcWVy8JUrsIEqq5BDaasA//yJ1zt8DRqoyXXRVeyFxARniN+dvu6D1hMhrTj3+Voq2ugTx+zGAioyjtnhFirOzp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jxVm1+C1; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-310e1f4627aso536445a91.2;
        Fri, 23 May 2025 20:31:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748057505; x=1748662305; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=z0KfmMjgOEpWzo+0u3yfDTi/IRtsd5mxIqnOYASIlOI=;
        b=jxVm1+C1bFVoRu4Zq8eGb8Q7LJQNnNNXRU84V5TG0jfJq8kSFtTm6DGCCpWLzzbZF5
         PdYCi2KJpVaC8kIl2seQDKT3FJOpJBdZmD8yPMRMCQEe0So5dkC/wJR5oOnHtzzHwisq
         1h7vQ8EnBiNwcervgztIKAAkDGfZ2NhClRlRWYP4P0JHARK+RM+0c2/sNNUckjXBnNjY
         O5Vu7CrjmDU8v942FFdfIB3DVqCHX1EhJ7Iwc+OCGK1p4mdv3SuUaCdDxcO1ITF8uxWy
         sGGT00E2RnKOAGS/1PTEYZ50qHjO5X7KkJQltWN477irvbRohgvXMQFdDrc7kA0NhdQy
         +Lsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748057505; x=1748662305;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z0KfmMjgOEpWzo+0u3yfDTi/IRtsd5mxIqnOYASIlOI=;
        b=NRPOOqqyZtwMVfJWC1sB8amf0FWbEYgGXrRH/V58X61xu69Cv8/jNZohKp2PY2Dl4K
         YNXaV7VePiWBNOfMVbnuvVy6iRHZZWadoNEtop1MIxxM9Gf+mP0iOTzUqzNrY6iQjqg2
         wmzjwEuX4feNrMs9OmMlUTqPJMdu04oarxWCO5+e3ZCyy3K+CgBPKU9BgtWIXe955gwO
         0cdg7RAbLwD62sXL6bceYe6ECzPzJ54ejL6o2tVDOuUo4KfAD5DeT/9usiyClFUS113p
         JBtDW8z6kgJuSdOggU2OMW8ytUaP9m9CaZhV36q9aXuACHzSL6x8JUG5kIKtvBa3LeGt
         fo+w==
X-Forwarded-Encrypted: i=1; AJvYcCVngSH3X5vDwbgigmNw5Iainnau/WxSW4wXCOsfdBNRO5IsEQFDc79iVwQ0ACdtRwdiXKoaQ9/h@vger.kernel.org, AJvYcCVpIxUZ8+MnY6v1T1nKwhw6m2jlnMrjifgLrz8YaH6kz2dbGWZW788SB8nBcDy7EBmdBo8WDga+nFtDduA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZpdb+8sRBmm/psurxBv7qk0Ut15BaanxPBb/GWlPccC7LQR6R
	L2Fu/2QeCawhaoxrPqmQFRKvanc3WWzMY5LiYRqzSDdeaBZBqrU96I0C
X-Gm-Gg: ASbGncvMBdi6ryyixIX9JVqJjfPQjcFEksMW7tHyRiR4iOrzYF1anTeeF+ChOQUxwFe
	wPzz6EFNP+H1r5zE2NfS4l49voqRas26BQCrT/cqYPvtdLb9q6EmNC8O923NJ1yqjrhn2swe8sX
	a/bCtu5ceVCh8BJWkQiCC2iWrNfy27TWNgXZsvyQjlx01JNj/Y6wwxgRxqT7WZBQVaYOTono+oZ
	gQVHX3wKsuZNG8MmtK0mU6kTy3KMjqxkQlYhJ+5g9jw7Scrb+GVySnAHXC4cZFlcJXftfuP45xz
	LMEJo8bTm7wubdaEzCcWGj9enUkYRY4gZ/gCKs22O2faHwJWyPEDepkD/U8oz0I=
X-Google-Smtp-Source: AGHT+IFQTVRjmY+/uCNbktEe6LN80eKzA137UEpFZA8kJ1//cPP2NysUTgu3Y+saLRLKxZhfvfekMA==
X-Received: by 2002:a17:90b:280b:b0:2ff:6167:e92d with SMTP id 98e67ed59e1d1-31110d71ba8mr2169730a91.32.1748057504692;
        Fri, 23 May 2025 20:31:44 -0700 (PDT)
Received: from celestia.turtle.lan ([2601:1c2:c184:dc00:e71b:d5fb:fd1f:ff05])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-30f365f3487sm8074630a91.42.2025.05.23.20.31.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 May 2025 20:31:44 -0700 (PDT)
From: Sam Edwards <cfsworks@gmail.com>
X-Google-Original-From: Sam Edwards <CFSworks@gmail.com>
To: Heiko Stuebner <heiko@sntech.de>
Cc: linux-rockchip@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	=?UTF-8?q?Daniel=20Kukie=C5=82a?= <daniel@kukiela.pl>,
	Sven Rademakers <sven.rademakers@gmail.com>,
	Joshua Riek <jjriek@verizon.net>,
	Sam Edwards <CFSworks@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] arm64: dts: rockchip: Remove workaround that prevented Turing RK1 GPU power regulator control
Date: Fri, 23 May 2025 20:29:37 -0700
Message-ID: <20250524032937.7788-1-CFSworks@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The RK3588 GPU power domain cannot be activated unless the external
power regulator is already on. When GPU support was added to this DT,
we had no way to represent this requirement, so `regulator-always-on`
was added to the `vdd_gpu_s0` regulator in order to ensure stability.
A later patch series (see "Fixes:" commit) resolved this shortcoming,
but that commit left the workaround -- and rendered the comment above
it no longer correct.

Remove the workaround to allow the GPU power regulator to power off, now
that the DT includes the necessary information to power it back on
correctly.

Fixes: f94500eb7328b ("arm64: dts: rockchip: Add GPU power domain regulator dependency for RK3588")
Signed-off-by: Sam Edwards <CFSworks@gmail.com>
Cc: <stable@vger.kernel.org>
---
 arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi | 11 -----------
 1 file changed, 11 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
index 60ad272982ad..6daea8961fdd 100644
--- a/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3588-turing-rk1.dtsi
@@ -398,17 +398,6 @@ rk806_dvs3_null: dvs3-null-pins {
 
 		regulators {
 			vdd_gpu_s0: vdd_gpu_mem_s0: dcdc-reg1 {
-				/*
-				 * RK3588's GPU power domain cannot be enabled
-				 * without this regulator active, but it
-				 * doesn't have to be on when the GPU PD is
-				 * disabled.  Because the PD binding does not
-				 * currently allow us to express this
-				 * relationship, we have no choice but to do
-				 * this instead:
-				 */
-				regulator-always-on;
-
 				regulator-boot-on;
 				regulator-min-microvolt = <550000>;
 				regulator-max-microvolt = <950000>;
-- 
2.48.1


