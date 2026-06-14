Return-Path: <stable+bounces-263075-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id o2DxFx7ALmqw2QQAu9opvQ
	(envelope-from <stable+bounces-263075-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 16:52:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B465468152D
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 16:52:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=quora.org header.s=google header.b="Az/IenjI";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263075-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263075-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BF52330137AB
	for <lists+stable@lfdr.de>; Sun, 14 Jun 2026 14:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B4C4B3C819B;
	Sun, 14 Jun 2026 14:51:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 847BF3C769E
	for <stable@vger.kernel.org>; Sun, 14 Jun 2026 14:51:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781448705; cv=none; b=X+F+3bDyWpqBCp90nWjPWaTqxTfu32sfS4dczauTBaRavVmLuQwEc5hhNV6GJkx24K7t3gOkyM01BkmyVrmFQtJ+DzZ+kRm1byPc+ThWJsmpxpxn3UZvxGgJhXyMk8fYwzdSG+OXtci6taVRZJmPriNXgBkVx1oAzvPYi0bZ/Mc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781448705; c=relaxed/simple;
	bh=ogMc+SzI7BygL/QiVUbBYX/vH1UfhMtj0GEZ+Aa4xVg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ScA9hDS2fA3SoUfUVJriOks8BCUFU7m/0i/nELBDS5Cqt2dnTfuJ65E06y5B5PBF58MnMHUY8CZMOQMcvjWDhHNpzMjoPVpPrfc7MrUgCKKjCPwFxzNPGjCy96e57l/rDoUeXrDXJrRoyRRLLc08COLZmOoMl/SBX9GBbBEvqQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=quora.org; spf=pass smtp.mailfrom=quora.org; dkim=pass (1024-bit key) header.d=quora.org header.i=@quora.org header.b=Az/IenjI; arc=none smtp.client-ip=209.85.214.176
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2c0c2c7e0c5so15530195ad.1
        for <stable@vger.kernel.org>; Sun, 14 Jun 2026 07:51:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=quora.org; s=google; t=1781448700; x=1782053500; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+DoEJx5niGEYDDqKxpP9EhcqDdLdwV3n1HbmZ+qqPE=;
        b=Az/IenjI7lxchh6kvuIg+5I2rgXx3goXeaEMba0EHeARLPpFxko7XJmfgP4cu5cD1A
         DAwDuy4ZMdFLAV+xWhrYL9nNTlyluYgRfhvWEzJTpJpVMFtyJyp5XK7kjHELNuFEaEU8
         yBvIClA0LT1Q8vEFKLxrJ2LhffqqQOUA3OVW0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781448700; x=1782053500;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=c+DoEJx5niGEYDDqKxpP9EhcqDdLdwV3n1HbmZ+qqPE=;
        b=r/IE0xIZB9/CbcCvf8AwWRT70PgU9XbZkSedhpYkbsGZBCCtl58gS5+9nMaE90fX8S
         h43955FuC3LEfwmdS/rHktfqua3+VLVjbVLyJugt9ZBelGuC640A7aJ8Btp2TICZaEfA
         Sw2QQiy+OXf50ZpPn49zOle7odRGFJwaFbQzsD13pgJegU/Zc5iiHAl+XUeiM84QK/Qb
         M8afvobn1cdarAo1H3pCH4tsYudUrr+XzKj//F9pqKWrh/4JEC1zrxk3BJfbucsVNgVQ
         foYtDXbqfMfAKFUsaQcrNYheYzXGLPHmg7dwLHPI4YNFQn3jdBgsHcFatprgPCjuk8kF
         w6ow==
X-Forwarded-Encrypted: i=1; AFNElJ9z1LASDHxfH/mYRs2KJ0KrBZGLnMnkufw/A/BwJHEGu2w88r8c2c/trCsDs6lwAo6tCL2esX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVX/eA1MDF//9xdHX3ReeqLhvjYbL+EuxYlya9ID6OZFPwfBRc
	M6p2r21aR0fan8UfHdT1S2eRgoFAYOWDd+YGr5J/BT+m8uHMC3dQmcjMYTKkP887f2g=
X-Gm-Gg: Acq92OH2iF7qQrnGkNs7P7I6ZaWXzrhHH7rxABiFpI1tc6/+H0hwCLUD0infBcyv/mY
	YkGz3Dx4Jzl6TdfINisj7PgW5JXfwQrP6JL80D9+1ggdxGWSQ63BOGLkxud9cuJid8qeMbDCrt0
	Vhj9PgwblWcH8p+fD4Y6ZnwX3Rfng8wxFXKEAS/dbdzIhkjng1fm7RSl5IJ8HNd6fR5+jnkUgY2
	amDp4vYuWY0q84CWzUefhkhbqYBWUwZ0Gha4LB5OB4aFE9PN2r+TkyqqWfUB4hsoZ/zSOvJPfWo
	G1pm3z2pefJK8HD+gR7aBn/dOfQ6QTcVYm+PCbSLe/0T2yn1ifqD1loPOVrg6cP/ArwJNKoOSI8
	4jW7e49KUidO3GxqthTaasBINLil+8QW1E0dywLMadjUbzfYWtQdTGtgNoEKa+mat5i4mByhoY8
	6Z41ijumK2bLz5Zj0plH3I7mx8RQIY5M/waX+O7G9ZSfnC6J9cm9qEbN6WNRWj/rfbxgv+cr7ZJ
	GJVFFULONTwCz8rR22Q15qOt1omXD/PmpH6wapNqCPEBBd1lQ2/v/Nw3f7JunmZTutITQ0pLJKi
	JGXKViZTjRqd+pXpmQxvTrjPpHSo6rx7pT8JYGKNcfFaTOk4pZ4sfgJp1E5XIw==
X-Received: by 2002:a17:903:37c7:b0:2c0:f807:9bf3 with SMTP id d9443c01a7336-2c4108f197dmr120914925ad.10.1781448700638;
        Sun, 14 Jun 2026 07:51:40 -0700 (PDT)
Received: from aegis ([2001:fd8:4d03:c800:f499:6f6c:fbd4:8f])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c4327acca5sm66746385ad.51.2026.06.14.07.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Jun 2026 07:51:40 -0700 (PDT)
From: Daniel J Blueman <daniel@quora.org>
To: "Bryan O'Donoghue" <bod@kernel.org>,
	Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
	Abhinav Kumar <abhinav.kumar@linux.dev>,
	Bjorn Andersson <andersson@kernel.org>,
	Konrad Dybcio <konradybcio@kernel.org>
Cc: Daniel J Blueman <daniel@quora.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Stephan Gerhold <stephan.gerhold@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	linux-arm-msm@vger.kernel.org,
	linux-media@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] arm64: dts: qcom: hamoa: Reserve low IOVA range for Iris
Date: Sun, 14 Jun 2026 22:51:12 +0800
Message-ID: <20260614145113.84243-2-daniel@quora.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614145113.84243-1-daniel@quora.org>
References: <20260614145113.84243-1-daniel@quora.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [1.34 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[quora.org:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	TAGGED_FROM(0.00)[bounces-263075-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bod@kernel.org,m:vikash.garodia@oss.qualcomm.com,m:abhinav.kumar@linux.dev,m:andersson@kernel.org,m:konradybcio@kernel.org,m:daniel@quora.org,m:mchehab@kernel.org,m:stephan.gerhold@linaro.org,m:robh@kernel.org,m:krzk+dt@kernel.org,m:conor+dt@kernel.org,m:linux-arm-msm@vger.kernel.org,m:linux-media@vger.kernel.org,m:devicetree@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:krzk@kernel.org,m:conor@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[daniel@quora.org,stable@vger.kernel.org];
	DMARC_NA(0.00)[quora.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[daniel@quora.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[quora.org:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,dt];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp,quora.org:dkim,quora.org:email,quora.org:mid,quora.org:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B465468152D

On X1-family hamoa platforms, the Iris VPU reserves IOVA addresses
below 0x25800000 (600MB), primarily for non-pixel buffers accessed
via different Stream IDs. DMA into that range triggers unhandled SMMU
page faults that cause spontaneous device reboots. This is readily
reproduced with one or more browser tabs driving multiple concurrent
video decode streams.

Add a reserved-memory IOVA reservation node covering [0, 0x25800000)
and reference it from the Iris node so the IOMMU layer keeps DMA
allocations above that boundary.

This applies to all current hamoa.dtsi consumers (X1E80100/X1P42100/
X1P64100 boards); other Iris-bearing SoCs (sm8550/sm8650/sa8775p/
qcs8300) do not include hamoa.dtsi thus not affected.

Backports also require the preceding binding patch ("dt-bindings:
media: qcom,sm8550-iris: Allow IOVA reservation memory-region");
without it, dtbs_check rejects the second memory-region entry.

Link: https://github.com/qualcomm-linux/kernel-topics/issues/1157#issuecomment-4458933574
Fixes: 9065340ac04d ("arm64: dts: qcom: x1e80100: Add IRIS video codec")
Cc: stable@vger.kernel.org
Signed-off-by: Daniel J Blueman <daniel@quora.org>
---
v2:
- add Fixes tag
- clarify the reservation rationale
v1: https://lore.kernel.org/lkml/20260601041336.9497-2-daniel@quora.org/

 arch/arm64/boot/dts/qcom/hamoa.dtsi | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/qcom/hamoa.dtsi b/arch/arm64/boot/dts/qcom/hamoa.dtsi
index 051dee076416..ce96e7f8d8c1 100644
--- a/arch/arm64/boot/dts/qcom/hamoa.dtsi
+++ b/arch/arm64/boot/dts/qcom/hamoa.dtsi
@@ -716,6 +716,17 @@ smem_mem: smem@ffe00000 {
 			hwlocks = <&tcsr_mutex 3>;
 			no-map;
 		};
+
+		/*
+		 * The Iris VPU reserves IOVA below 0x25800000 (600MB),
+		 * primarily for non-pixel buffers using different Stream IDs.
+		 * DMA into that range triggers unhandled SMMU faults and
+		 * spontaneous reboots, so reserve it to keep IOMMU
+		 * allocations above this boundary.
+		 */
+		iris_iova: iris-iova {
+			iommu-addresses = <&iris 0x0 0x0 0x0 0x25800000>;
+		};
 	};
 
 	qup_opp_table_100mhz: opp-table-qup100mhz {
@@ -5479,7 +5490,7 @@ &config_noc SLAVE_VENUS_CFG QCOM_ICC_TAG_ACTIVE_ONLY>,
 			interconnect-names = "cpu-cfg",
 					     "video-mem";
 
-			memory-region = <&video_mem>;
+			memory-region = <&video_mem>, <&iris_iova>;
 
 			resets = <&gcc GCC_VIDEO_AXI0_CLK_ARES>;
 			reset-names = "bus";
-- 
2.53.0


