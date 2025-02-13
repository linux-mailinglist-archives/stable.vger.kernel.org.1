Return-Path: <stable+bounces-115141-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55F4FA340BE
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 14:49:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 13BFF16742D
	for <lists+stable@lfdr.de>; Thu, 13 Feb 2025 13:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C89D24BC19;
	Thu, 13 Feb 2025 13:49:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XdvA4m0A"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C88BEE;
	Thu, 13 Feb 2025 13:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739454569; cv=none; b=hJA63GgZJhlUhQsLbGEJMCZtAQtovpo4zkk9uXoz/z4x/3V6cvUR3GEIPwe7EbLbew901NDFLdrAiShk/RhcNgKMi6VWJOuNCSyPfwKLJ8krmULHN/TegmK1FCDS8LD9Lx7rgVLCPsAUfZDxTtc+FfSWtkkDlB8epUjdeakLdHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739454569; c=relaxed/simple;
	bh=ncEkifSPLY7l3Ao/uK7in6+8nu/N+/uAN5zBIopDcJo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=terbWNlhquPEW6Tt0TulfZYob/m3GbM2RBS8q2vPK6Uv9VDiiEr9k85y++oLrRYIfaldAIwmxTaxhkJMByrIHTGEs/5pY4tQHaMrluGYFwKW8IkwjucEyOcHSsmWze54WruLUxIg2xEvbWwvG0R87+6PmHwkUZObVljuoa5nFf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XdvA4m0A; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-21f78b1fb7dso13925615ad.3;
        Thu, 13 Feb 2025 05:49:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739454567; x=1740059367; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=D/sWqWutzOG0l2Gm73iX0YH9oY7U8vkhAI1AslN3GKU=;
        b=XdvA4m0AqrtsO1Y3kbJc2ylhFtBGYxVWPHxoIypnZEp4S9r6mk/YQVvTyr4CJ4y+Dz
         wYMa4WoUT+StdPFyNAtzvj1wC2qY1XIJwY7B94+pgyJCS+HY9xAUFXxrQWiI3183++bi
         glefDpvtI700tCr19sVWyuqR6JR81rwOCaz+p4NCEDqlsyb8jagVIL+Uu5XpA+9y8IO/
         Kgtw9TGU6oSitNNGy204slaQOA0rtyozWqQ9ZJjIWFUMfJF+f7juKQOD5S2FfmGOnxf/
         cMF8B3Kj9Df/WYqTFQvQ5DfRAGhMpRBCdSdXSpoHC40DP3kVJUe6vaIqJIQsqZHClP9t
         QZww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739454567; x=1740059367;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=D/sWqWutzOG0l2Gm73iX0YH9oY7U8vkhAI1AslN3GKU=;
        b=N0F0eVueCAH6R6hMR5Z0Oi1u9caVadOXJSvmM/1CLzqvOO8r9glaKfi1X06nDP58ju
         DS2pFnEWpHyVzIljMdbno2K4KUiacOEl8nh1jFf9lcRtbFmS/KWyY224Mj7d9788/7q8
         w0CdTUM0m0l97gSdUnblYVXKYDCEfzu3+U6VT1Nj22XJygmbvqzE7vGbaHS9mwCXRM+r
         Gtx0cU3UNlMoOVxiDxKoUko0QBV5ZhidLmmUZtcpswYSazr7t++MmzZPtKB0LcX/Cs9H
         yS/Fx4Bu1KZQupWNloTqToRe7FvngDWVxJAHAJ+/24tW+xM0ysvJ5Vb6C3kuD7RrUW28
         95xQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7juUa8Ri5qZQO7FFq1VM+ZKj+q/8jwsxkowudFol2kkZ/q8m/Xt8ptgw5EP2E2DHQPLgGPzYK@vger.kernel.org, AJvYcCV/6JG/x4SltNVp9myNZVham+uN0eKEfEpbvGsZidG/Rc+e9JDntCX3O6nx0kG1eN7QLeJysqnTaD5b3y4=@vger.kernel.org, AJvYcCXlCBYRHBFz2P7DLHT1Rak2tSFBImD2cv0eswAluL1W5lE0qDUsJY1AZ8rAzaCaDGGSls/rop73Kis/@vger.kernel.org
X-Gm-Message-State: AOJu0YxFFGKez1W+srP6Xzthkq+hN+M5VFW1a82drb4gj740q+2FqwVH
	IOAd/LLiXzd5qMK9rm2vO+qLZCmnl1Ld/KUWkmt7IxEUfeyn8PrR
X-Gm-Gg: ASbGncs/19QhpHDVaGODwqMoK4xoZ45URu/nds+PhTSy+9YrEchps1xOYlWFviho4ey
	IKenq1BAqiwvuncc95b8KiTqgg4fHbSpb8WnYW7OfDUu8pOqcVM4kLFj6nxsQOWppfYo7oWH3SK
	FduVzvmjaGk/JCoD1goANssbSPYyLrdm5SrvPKVXnsEqa2n0nkrPGjUJz5txc+LAVYXb8eTPUWv
	JPyWV1e6U9wWlaWCekg4JNlGTcRpL4wbr1bawYfxdSwLLMRO3V5vxSv0C5Qv6zpDX3FmWLBiztU
	2Hw5xo8gozuBvU3ZLlpHs5s=
X-Google-Smtp-Source: AGHT+IHwNQLmhMOfqP0DfY2lFDVCTFxcw/p+wO0NVzYKFBlQ1PD2DdvopBtbC7UrvzIvyG5tFkSIAg==
X-Received: by 2002:a05:6a00:348d:b0:732:288b:c049 with SMTP id d2e1a72fcca58-7322c378646mr9851232b3a.1.1739454566750;
        Thu, 13 Feb 2025 05:49:26 -0800 (PST)
Received: from localhost ([36.43.23.151])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7324273e4d5sm1283577b3a.86.2025.02.13.05.49.25
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 13 Feb 2025 05:49:26 -0800 (PST)
From: joswang <joswang1221@gmail.com>
To: heikki.krogerus@linux.intel.com,
	badhri@google.com
Cc: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Jos Wang <joswang@lenovo.com>,
	stable@vger.kernel.org
Subject: [PATCH v2, 1/1] usb: typec: tcpm: PSSourceOffTimer timeout in PR_Swap enters ERROR_RECOVERY
Date: Thu, 13 Feb 2025 21:49:21 +0800
Message-Id: <20250213134921.3798-1-joswang1221@gmail.com>
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
switch from PR_SWAP_SNK_SRC_SINK_OFF to ERROR_RECOVERY. This can also
solve the test items in the USB power delivery compliance test:
TEST.PD.PROT.SNK.12 PR_Swap – PSSourceOffTimer Timeout

[1] https://usb.org/document-library/usb-power-delivery-compliance-test-specification-0/USB_PD3_CTS_Q4_2025_OR.zip

Fixes: f0690a25a140 ("staging: typec: USB Type-C Port Manager (tcpm)")
Cc: stable@vger.kernel.org
Signed-off-by: Jos Wang <joswang@lenovo.com>
---
v2: Modify the commit message, remove unnecessary blank lines.
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


