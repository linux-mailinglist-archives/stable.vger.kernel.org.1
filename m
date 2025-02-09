Return-Path: <stable+bounces-114426-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 49347A2DB79
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 08:18:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8C8E7188666E
	for <lists+stable@lfdr.de>; Sun,  9 Feb 2025 07:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D1E95A79B;
	Sun,  9 Feb 2025 07:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ht0eKW4Y"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6028A1DA3D;
	Sun,  9 Feb 2025 07:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739085483; cv=none; b=Pg2Vvj7wCZgCE5aCeqASughe5iig+N8LAKbitKiiA4L4e/3sbkn8TNrCgXHwa4WY9OKvTmp6kzb5PsKM1StfVGAtU1QMO7U2d6Gv84eYOhUrQpzLE1rYQZCBpmzrdK3btNzRxiM3y848L5KhzIBhzLy8076l5Cm0PK7cO80ezbk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739085483; c=relaxed/simple;
	bh=Jr9mtWVJicxKtein/61YFclfg/kl1N2nDZCgGpRccBg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=sXfEHGgaBcpRU+9F08qOZST2/T6jEleqaGErUhNQX2b+0Ipll4o0ysgMwAqkIpU16Mfzn/QhjdZHZ+3ftT5GmGrE3zVZF8O0PWVKdorhDtGRD+VuTVCAZSLnogSbiK9EKogzLXgxvs0LYbunYGjaL36wbeqoyqabk5N1pFkVzyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ht0eKW4Y; arc=none smtp.client-ip=209.85.216.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pj1-f54.google.com with SMTP id 98e67ed59e1d1-2f9ba87f5d4so4785070a91.3;
        Sat, 08 Feb 2025 23:18:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739085481; x=1739690281; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=hVglfIZTRkWBJx9VGhJ3jBOyVzR4Ecw20lpx1TSi70o=;
        b=Ht0eKW4YmgZDr64HXSnZx47m31rby2Nw9Sk6K99p91Ilg2k8ZlPLYFZWXpybxWfymv
         i/vFDCd3lKyq3j6fTNdJZjy0xMYDakelIaWAZaAIVtltT3wXS9M9cUj0zk4u4/TeA6DP
         ConEB32s70zlB+WvEUVO6ag8wxdfw46OyDZadLdeeP8mrZ7oYgFf20enDDUHUlshVEab
         mZeLdTcJKgh1TBGeuNvBLTwVFEtduNXggdY/UJpgbgVdLzQOl7oxhNnLJvM16cFzV4PW
         i2+pgxkrgPhAn+KTZkv6h8ovHCCmuNyMsQ0S1pq2eHmDrbOR+v7NcipomiYwIFGxevHE
         PNEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739085481; x=1739690281;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=hVglfIZTRkWBJx9VGhJ3jBOyVzR4Ecw20lpx1TSi70o=;
        b=saWs/9BMp9vMyyAsArdsK/N+5n/kCkrDWlNbTmi7DyIgvbFZqPuLmJiPRBeibhITE6
         zFPfenFv2i8qe4dp2kNmHJSyQukh880+ZR7QZDw78Q3HY+WEUjZRsei7yoyT2bt2blGm
         qfj2XPds83EvxPe0O9dnbC0G/0dNkumvEYFROeo2jurSjGKyUyBxJdnAo1Ils43W0El6
         Q+GI76QcXTiDQVagOegl2rGu7LN5NLnkl0IEHETaUbNM5UXHvyF/foRq8SY37g5g8lTr
         APux6bLl8oh9BLWigjhi33Y8y6HxGrqXdQ6l6gzD/rVpt0SGTcfvnLno0L6QtDwFlap9
         mRog==
X-Forwarded-Encrypted: i=1; AJvYcCUcKV2Tj8dEk5Fp8ADXiYZT3lH5HjZxMJ8knqi61AKNFLMoRu/610w4PcF2gu1+mOL77g0PIEjHOlZiNsM=@vger.kernel.org, AJvYcCW/2WegBEWIOsQ7TpV/1egk5A6Top8EdWgRbxjrP3pzef2+8q850b67JvD8xcDLtmcPJREWSP2G/4pH@vger.kernel.org, AJvYcCXCkE6BSqXU9YoeiFXP8em63cUBkzqfEnKdBz7GOfrZMlJFSdMvHvt2vra3dnR5P2NuIiNUXbU1@vger.kernel.org
X-Gm-Message-State: AOJu0YzkNkvb79jYlUtUO3WbcQHtHkQ9ZihCFgJk8Wo6qfPTKm2N5GYX
	+ObfKHrd/HFRgQa4T6R01oPt7bYG9ShrdO7dECCc2Q5mz7Ysacys
X-Gm-Gg: ASbGncsZlXUZEApP/TgC11CRRHqEX3XdcJqgHIu5mYvs5OAJfIjELkJzSK/p13hyhem
	MvCUzgxqNmK9sh8fxM698PX0kIjxTOgiMdx90vB5sgnEan1JeWhaTdmcg2kQkRamhjhKJ6qybt8
	pPV65DH42Tyws/CLjT7UBy/8GO7e18pLAjwuCnsx4eNmJtkbSQjCmB56hE/e/Q+1sfY5uaHn1Py
	kgVu9hCrSH1IZhJQ+Rzucw46kPip9OH/CLLQSt29rG7KJymWw2S7urjtKG9q41Il7ILQT6oif8q
	ZwVHg8secBilIMcH8nLnui0=
X-Google-Smtp-Source: AGHT+IGX2Ci+Pt5dpj3iKaGcELclAR8HA8fL7kkYH8EWEIdKJu9GhB5IjALez3lGS8pg/bP23Kkd1Q==
X-Received: by 2002:a17:90b:2252:b0:2fa:1a8a:cff8 with SMTP id 98e67ed59e1d1-2fa243ed2efmr13703278a91.29.1739085481482;
        Sat, 08 Feb 2025 23:18:01 -0800 (PST)
Received: from localhost ([36.45.119.30])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-21f368b4fcasm55717895ad.230.2025.02.08.23.17.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sat, 08 Feb 2025 23:18:01 -0800 (PST)
From: joswang <joswang1221@gmail.com>
To: heikki.krogerus@linux.intel.com,
	badhri@google.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/1] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap enters ERROR_RECOVERY
Date: Sun,  9 Feb 2025 15:17:52 +0800
Message-Id: <20250209071752.69530-1-joswang1221@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jos Wang <joswang@lenovo.com>

As PD2.0 spec ("6.5.6.2 PSSourceOffTimer")，the PSSourceOffTimer is
used by the Policy Engine in Dual-Role Power device that is currently
acting as a Sink to timeout on a PS_RDY Message during a Power Role
Swap sequence. This condition leads to a Hard Reset for USB Type-A and
Type-B Plugs and Error Recovery for Type-C plugs and return to USB
Default Operation.

Therefore, after PSSourceOffTimer timeout, the tcpm state machine should
switch from PR_SWAP_SNK_SRC_SINK_OFF to ERROR_RECOVERY. This can also solve
the test items in the USB power delivery compliance test:
TEST.PD.PROT.SNK.12 PR_Swap – PSSourceOffTimer Timeout

[1] https://usb.org/document-library/usb-power-delivery-compliance-test-specification-0/USB_PD3_CTS_Q4_2025_OR.zip

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org

Signed-off-by: Jos Wang <joswang@lenovo.com>
---
 drivers/usb/typec/tcpm/tcpm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/usb/typec/tcpm/tcpm.c b/drivers/usb/typec/tcpm/tcpm.c
index 47be450d2be3..6bf1a22c785a 100644
--- a/drivers/usb/typec/tcpm/tcpm.c
+++ b/drivers/usb/typec/tcpm/tcpm.c
@@ -5591,8 +5591,7 @@ static void run_state_machine(struct tcpm_port *port)
 		tcpm_set_auto_vbus_discharge_threshold(port, TYPEC_PWR_MODE_USB,
 						       port->pps_data.active, 0);
 		tcpm_set_charge(port, false);
-		tcpm_set_state(port, hard_reset_state(port),
-			       port->timings.ps_src_off_time);
+		tcpm_set_state(port, ERROR_RECOVERY, port->timings.ps_src_off_time);
 		break;
 	case PR_SWAP_SNK_SRC_SOURCE_ON:
 		tcpm_enable_auto_vbus_discharge(port, true);
-- 
2.17.1


