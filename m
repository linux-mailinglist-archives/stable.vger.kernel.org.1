Return-Path: <stable+bounces-254120-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uJDfJ+8iFGq3KAcAu9opvQ
	(envelope-from <stable+bounces-254120-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:22:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6585C9355
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 12:22:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EED733006F3A
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 10:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CFA2351C1E;
	Mon, 25 May 2026 10:22:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bF1MSqVq"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f181.google.com (mail-pf1-f181.google.com [209.85.210.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2849634CFD6
	for <stable@vger.kernel.org>; Mon, 25 May 2026 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779704554; cv=none; b=QSWS3INbPavDpccznC1OYG4JFrF/7k0FOvmM7EDjlApWc9+WxIZlW+s286ZJqrU917p/wP4fD3cNsUS0yJ0Lddh1xFRF4cWfZ08oyYTkSWzcRWrxq3LUCb2c69twu3RiiJPzej9ZW2L00i94jy22CDSGWikecW7qnFgwfcyX1QM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779704554; c=relaxed/simple;
	bh=CgvjRepLEJgFdo3A5HB6K2CcEmpnfY/BjLP7aUl1kfY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ZpELKF2cLTF8KFjxv/grb+NoVdaX0+QzlZqnaqjSrA3PWOHw5pv5sjDYUvyH4i03m5EBJVsmOsoteSStsnk2UwLUP49DPyUKH85CklgOYy9sjqDYbOiLi1eIN/f0RkHCXFmdEex57QTLDIZ3Tbx/U40iCo32B63W+bY0o61Lv2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bF1MSqVq; arc=none smtp.client-ip=209.85.210.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f181.google.com with SMTP id d2e1a72fcca58-841513664bbso2088876b3a.1
        for <stable@vger.kernel.org>; Mon, 25 May 2026 03:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779704552; x=1780309352; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WOdAlwMgVRhURs3aQ/KpZ+S0DgSBMZniTufqWqYUDhM=;
        b=bF1MSqVq/wvrrvFbt84PfPaofzlLkdi9lS4FjuO5MVSOzrSeT65i0+2YNUHD4ZcFOT
         bvFuxQ2RMo7ax6wyEsmquToSJfkr6gJjVBFmeEIHn5UAGndAheiqxxtwHsu6jYP8RkX2
         jZsksVtq7kxvSHwe6zqvNztUxWhtkSYKUN5FZabavUEOXxZ0Tn1TCemFRgnlvc35W4KK
         JDxXt6YCUyq7oBKuuf962LSv9b9VWdQ83ohovrGDKtn2NwHnUnvHEpvmmr5WhkzFSpjx
         ahpcIbNZLLXitqGDe2eK9EY7Bak2suS1BY5iztr0Krx2ZEzIMeqTIlLmCKJA10KovHbq
         B/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779704552; x=1780309352;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WOdAlwMgVRhURs3aQ/KpZ+S0DgSBMZniTufqWqYUDhM=;
        b=I12Ix0vyo3+qUmmXAdtb+wW8onF5/C0Pa0XFpuMqBgZj8ojYPCI+PdcP87rUaLfc4S
         WXhpmAJikWACoU7zUMRkNZQYXdcFkB4cr72ondL6q198oEVBOY/Jqg83t9MzYhINVTdz
         TTJ4c5l8EWINwEwsrZpZs2es9SBsvDtCXmRh62h5g5U3usny4aKSe65Izifxgtkb1jTz
         iJ/9d0O5kBBRtjntInT7dShJmGnD0aIXpQA+uw/SEcotVaLN8JcAOzrill6zLqDxB6RT
         v5/vTt/I9TpE2/UJHc4B8DiicsdRwyd72yy87wYgBYoWPCpnypvel0ylGlsdwD9WYIx/
         dbPQ==
X-Forwarded-Encrypted: i=1; AFNElJ8wtboden0Ezh5QypWlrpbmUYGTPzyM+Z/IefQAyu/G1xtkvXchWwgI6wBDdHtBFa7lIm4SX5A=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCg0QeKU5m/+y+ZCkORgbhyQoc7ENB6l+3yDCZBq/m2E2s+tQN
	qPjr6Q89th7zjAgqdjq4s7y+1RC1/4sp7qEJrCJIwJXSGKE7MXFUkvXM
X-Gm-Gg: Acq92OFAiy23z0Fvm+uwwuCfteO2wbsMueMHJVW4cjmnufCi5XMtreWkqsHE6l3Ibpq
	IVYplq9ddBWu18WQdugZ8Aqk3Eiai8kVYtkV0umxYachfSUJXi6uJJKoXZdo4Rur0H9Rdu9kMIp
	K3aM7Q49jDlNNzL2UnWIqBttbo+he3okMWIpsPl5ZSNsEIkHyT3IUlGDZETVZFEt+YmnTitFigv
	QxUu4rvhyw+UjFiL8Y+ks5atN8mOzFdD72ciDj9xZJj0gxFbVNokVLt5KELKj5JvquvF9TsnjpD
	sRyzAIThoX/Shx9S5ye5GogFluQwvwsq7ftIp4sMhVFQqoTjU/CIHdqpBBYItGf4yvOJMWqDGcj
	Cf8Y1x3gPnCE7fpDfHD3401cN+EQRoH71D2lKq9r9VsQReqVhyoAdaGcjFU8Boqtt8ylpPb4qlA
	M8AFZ8tPL0e9UYOK4ZZ7q3XfDDafqw1Wza387oaqvTKmwRzyiYlSEWDLfZ12dQI7zf7UCK2spP/
	nrDTiwcmJ5IdkkSGQge
X-Received: by 2002:a05:6a00:2d9c:b0:82a:146d:36a3 with SMTP id d2e1a72fcca58-84161197e43mr10255565b3a.21.1779704552426;
        Mon, 25 May 2026 03:22:32 -0700 (PDT)
Received: from archlinux ([2405:201:1b:225f:36f2:f474:be1d:cad7])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-84164fbb66bsm8970812b3a.45.2026.05.25.03.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 03:22:32 -0700 (PDT)
From: Krishna Chomal <krishna.chomal108@gmail.com>
To: ilpo.jarvinen@linux.intel.com,
	hansg@kernel.org
Cc: platform-driver-x86@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Krishna Chomal <krishna.chomal108@gmail.com>,
	=?UTF-8?q?Alberto=20Esca=C3=B1o?= <alberto_e_88@yahoo.es>,
	stable@vger.kernel.org
Subject: [PATCH] platform/x86: hp-wmi: Add support for Omen 16-ap0xxx (8D26)
Date: Mon, 25 May 2026 15:52:26 +0530
Message-ID: <20260525102226.56300-1-krishna.chomal108@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,yahoo.es];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-254120-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[krishnachomal108@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FREEMAIL_FROM(0.00)[gmail.com]
X-Rspamd-Queue-Id: 1B6585C9355
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

The HP Omen 16-ap0xxx (board ID: 8D26) has the same WMI interface as
other Victus S boards, but requires quirks for correctly switching
thermal profile.

Add the DMI board name to victus_s_thermal_profile_boards[] table and
map it to omen_v1_legacy_thermal_params.

Testing on board 8D26 confirmed that platform profile is registered
successfully and fan RPMs are readable and controllable.

Tested-by: Alberto Escaño <alberto_e_88@yahoo.es>
Reported-by: Alberto Escaño <alberto_e_88@yahoo.es>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=221514
Cc: <stable@vger.kernel.org> # v6.18+
Signed-off-by: Krishna Chomal <krishna.chomal108@gmail.com>
---
 drivers/platform/x86/hp/hp-wmi.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/platform/x86/hp/hp-wmi.c b/drivers/platform/x86/hp/hp-wmi.c
index d1cc6e7d176c..a2ec303f60b0 100644
--- a/drivers/platform/x86/hp/hp-wmi.c
+++ b/drivers/platform/x86/hp/hp-wmi.c
@@ -241,6 +241,10 @@ static const struct dmi_system_id victus_s_thermal_profile_boards[] __initconst
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8C9C") },
 		.driver_data = (void *)&victus_s_thermal_params,
 	},
+	{
+		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D26") },
+		.driver_data = (void *)&omen_v1_legacy_thermal_params,
+	},
 	{
 		.matches = { DMI_MATCH(DMI_BOARD_NAME, "8D41") },
 		.driver_data = (void *)&victus_s_thermal_params,
-- 
2.54.0


