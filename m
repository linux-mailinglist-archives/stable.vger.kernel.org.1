Return-Path: <stable+bounces-189100-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DCC00CA8
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 13:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E73711A616DE
	for <lists+stable@lfdr.de>; Thu, 23 Oct 2025 11:38:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4FE830E0FB;
	Thu, 23 Oct 2025 11:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="elvqjNP7"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C65530BB81
	for <stable@vger.kernel.org>; Thu, 23 Oct 2025 11:37:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761219475; cv=none; b=LGADxMwWWx6MK/PWZ6G6k4k7ypNDdBOiYc4ZA1KOXqYAjEix/qiVOUE1wFfY3tqdXQ37sKtihJlRvGeKP3Gkjo/moiLf3pI2In4Ac0eEIk/OeRCuBSKUfOe92o7A4PFYKZs73hk2Ueic087jrt2JGuzsx7Xw8NA7JX/eR0s3W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761219475; c=relaxed/simple;
	bh=7oXf51m7mBPucNidESq9CXB9+ksqBJvy/yJfCr+VnSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=svghGmQXoWMp/aNlZVFo1YXyIYg4Exqnmtc7K2YM6r3oE2TIF1yjuEMjmeg85rng/deOyj9R7K58f8DiUWmCeN/4sDgEDfeTeC+o82kHUtECbZLLoDSr9MamjIpHXdCpjEV89CjwGcgDy+D2Df8/GQHXJOi6I4pYcV+jdXWbaOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=elvqjNP7; arc=none smtp.client-ip=209.85.218.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-ej1-f54.google.com with SMTP id a640c23a62f3a-b5b823b4f3dso133669166b.3
        for <stable@vger.kernel.org>; Thu, 23 Oct 2025 04:37:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1761219472; x=1761824272; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y8kmVxRSYUQArl5tDapoiE287uiuzt8v/x5S0PTvLP8=;
        b=elvqjNP7Ekc3lmFjrFFuw3OK9UKWaIB0Y+0RbrgmHv1kFufut4ZcCQcfahv2U2YhNm
         NEzXJKpo1wi1c5PqfeOWebAWRv7EGXAlOmulpGNzdYfSt4rZIDSI0Fq4DlKgtslzQ/gj
         Sh/IwLXZWXugDnFSB/nj98VseWxwQUJXOcba6bT3nPfLJOuCL9W4N05xd10DXlu9JvTp
         Kkw3GT6VZhrqUi4QYS2A699UoTFjig9is78ZZyObY6bZWKE4hfk4c0S/saHJWMLLkdJn
         vPNjitSxFMPFD3khc46Kly2UsMe2FgncfNxO+AYyf/2XUKnfyy0dRil8i+Qaqdywh+Rg
         sXIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761219472; x=1761824272;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y8kmVxRSYUQArl5tDapoiE287uiuzt8v/x5S0PTvLP8=;
        b=w3TvIhDW2VRVuoGjofWT8DhCV5OdmJqkPUI2SKGTriiSXkfoOMHxAo4fKrcbz1mgHL
         YJdcvMFnIFeulPKDxk5/ZZVyVhrdBbse8uGwm7TQeKhoITeFX8UM399u/Z0kazB+gTHS
         w90tHcS5QTxxCl7AZHvzBNp64xWosmmbAaT5Hcy7rXZQ7HF7vqb/+sUsr1a5vdXs/4Vo
         GQna+FerQ599zVmXkeqNFbqBE1kH2IP0IbM/Jqapy6EW1OVU/jvLK7zeLJnax0LHY5qW
         fds4ZN9eqXluYEXDCjmwfXk3TQ4KGA9xuJSjPJRcetGAHhyj56gygX+7+X9ZpGW/Le25
         s78w==
X-Forwarded-Encrypted: i=1; AJvYcCWOVdR+kI38PhkjU3PPUOJCRVjsi5SBiDN5ulVOX0yRA/jQiKytXn1wED35bNJMf7Pb04RnOvE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVoAZ/kZiktXXr5KyUorK2jMf8PoKoCdPxhIGOt7xkyO0+NE+Z
	BJ+lxAmGMl23shDTFiCG/RST6jbv3myQEXtmkSDJApFBB7NjwCK+9jqBG5vZ5/OBgzM=
X-Gm-Gg: ASbGncvj1gu+mkwYiYH7PTRGRt/cVqP0wESH1MZQY6K5h3rn6HvlpPm1tBoDeABk414
	5JpVxESKIcjZeJ4PoeAKJFHppBMi+yRluxn5yzLGe/f4Nq4PWmJE4Ynf1qSsb95QEgKCmmNEFNi
	0sQJRZAvNUN8q6bMhn/yhZKCOu/3ICaH8heTOfvCn0hEs2w4M1Q8EIN9UVXD1oNpwjpo9UgSItA
	eGjBVvsNTiRxiOom3inrIM9lzumoPfiTCkAYb8InHqYlj/Ym+dUypyn3DmnoZftmSD1Xv6GauFo
	Ep71D65xYuzr0jltOl5DxX6PtUkvIfzRCVnLj1lqdbxqd3DDz2Z9IGejITm17PWoTxCidiPxSXC
	tZLnd8r1bW4lybK6bv5PUAt01u9DXk28u4M2UX4u3yj6Ge0UWmVInXteJcT/KkL98Olo00Z/vBE
	lzkrakeByHFDseNKZRRtghuVpA+lWDDbdyx+7td/cFzR1T2A==
X-Google-Smtp-Source: AGHT+IEzcSqbV8G27b7RK+JXHjk+tt6rrpOdAaKPcwm6vc0BDCjPnkJCoc2TFrnWl+dB/W48T0b3nw==
X-Received: by 2002:a17:906:4fca:b0:b50:a067:2d85 with SMTP id a640c23a62f3a-b6473242850mr2602673666b.15.1761219471693;
        Thu, 23 Oct 2025 04:37:51 -0700 (PDT)
Received: from [192.168.178.36] (046124199085.public.t-mobile.at. [46.124.199.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b6d511f8634sm194429666b.29.2025.10.23.04.37.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Oct 2025 04:37:50 -0700 (PDT)
From: Luca Weiss <luca.weiss@fairphone.com>
Date: Thu, 23 Oct 2025 13:37:26 +0200
Subject: [PATCH v2 1/3] arm64: dts: qcom: sm6350: Fix wrong order of
 freq-table-hz for UFS
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251023-sm6350-ufs-things-v2-1-799d59178713@fairphone.com>
References: <20251023-sm6350-ufs-things-v2-0-799d59178713@fairphone.com>
In-Reply-To: <20251023-sm6350-ufs-things-v2-0-799d59178713@fairphone.com>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org, 
 Krzysztof Kozlowski <krzk@kernel.org>, linux-arm-msm@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luca Weiss <luca.weiss@fairphone.com>, stable@vger.kernel.org
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1761219468; l=978;
 i=luca.weiss@fairphone.com; s=20250611; h=from:subject:message-id;
 bh=7oXf51m7mBPucNidESq9CXB9+ksqBJvy/yJfCr+VnSk=;
 b=oXxHWyHCtwNqMCb25Ee7HIvzFWo/1Un9PghwgUi78155t7dSqhCLDn5o485ACX9xKDx66k5I5
 wHE14dkIjU3DFqmmpgw4UrtEb1U/qUWEiJ5KlLNG6Sm6iMSRNaPXsjd
X-Developer-Key: i=luca.weiss@fairphone.com; a=ed25519;
 pk=O1aw+AAust5lEmgrNJ1Bs7PTY0fEsJm+mdkjExA69q8=

During upstreaming the order of clocks was adjusted to match the
upstream sort order, but mistakently freq-table-hz wasn't re-ordered
with the new order.

Fix that by moving the entry for the ICE clk to the last place.

Fixes: 5a814af5fc22 ("arm64: dts: qcom: sm6350: Add UFS nodes")
Cc: <stable@vger.kernel.org>
Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
---
 arch/arm64/boot/dts/qcom/sm6350.dtsi | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/qcom/sm6350.dtsi b/arch/arm64/boot/dts/qcom/sm6350.dtsi
index 8459b27cacc7..19a7b9f9ea8b 100644
--- a/arch/arm64/boot/dts/qcom/sm6350.dtsi
+++ b/arch/arm64/boot/dts/qcom/sm6350.dtsi
@@ -1180,11 +1180,11 @@ ufs_mem_hc: ufshc@1d84000 {
 				<0 0>,
 				<0 0>,
 				<37500000 150000000>,
-				<75000000 300000000>,
 				<0 0>,
 				<0 0>,
 				<0 0>,
-				<0 0>;
+				<0 0>,
+				<75000000 300000000>;
 
 			status = "disabled";
 		};

-- 
2.51.1


