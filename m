Return-Path: <stable+bounces-263190-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id sANVFEDvL2o/JQUAu9opvQ
	(envelope-from <stable+bounces-263190-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:25:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D37D86862D2
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:25:35 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=GUm+VOIY;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263190-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263190-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8FB513033AFE
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 12:23:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1C253E8355;
	Mon, 15 Jun 2026 12:23:27 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f53.google.com (mail-lf1-f53.google.com [209.85.167.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E63C3E558F
	for <stable@vger.kernel.org>; Mon, 15 Jun 2026 12:23:26 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781526207; cv=none; b=qCWr0Ot+CUYRSYbKYanYqHoojBkOjHlr308x4sbGeMnlPVvHycmGLBcFnCwPMURN2UOzQkZ+/Sb2iTEy9cuIdoRmhbjiPpN1BsX2fIhvNBMA8C0j22f1Z+ieuLM6Vqo4DTdqZ1yY/Fps0EIAxIQ3cmhiSnFfHISvOrXxLaupzb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781526207; c=relaxed/simple;
	bh=9AhUzTPXW06iepjicTUk8KdUkKVvFXLZUIYC0xH75Ds=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I+g5ghNULQ3cF/xM8Ig2re1un3H6eaY5w7coZ4TCovDSBWuU4+EgMrFKj9DweqcvRTe0sefUNo9H2w9Alx9kURPIh6V+JaopP+DksRlx1zvl3kSiG56HZS5Bmi4xpzLUBB3pcQk/XoA0JF0GIrf75zadnMr52AymhdEkO+Yabjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GUm+VOIY; arc=none smtp.client-ip=209.85.167.53
Received: by mail-lf1-f53.google.com with SMTP id 2adb3069b0e04-5aa88b4f792so3785364e87.1
        for <stable@vger.kernel.org>; Mon, 15 Jun 2026 05:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781526204; x=1782131004; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=NxNwzg+e+NRp49UH9pl97KcoyF640OFUJSGThEXSWcQ=;
        b=GUm+VOIYllYVkvRxmQtrvp+Hls9NTGyRRj+H0Mj4NMXeAAkce0/r5OpY8x1SsZ8ug4
         ZS0uzs94krtYnTstbzv66kgQdCzyOzhk/zTN005yDqZhBHFOSQtrPWtm4ZshQDttqFEg
         aM4b47NDznyUclMJSLQFP0AuNOXgy58fOY59uFExHbyRWQDGyY573E5+14XAhbHFis9+
         WP73ekHR4U/q0kpgNrXf3Cuk0TYdrMDtw8yEqi9iNNIpUKUOUSy1pPiY/E73kDm5fGtU
         nuCPFvUDiSm9IOwB/yTYdjsY3Gxi9VVYnFphlokvZjFSKPGVyxnFv0I+2FSDFseM/fAK
         cfXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781526204; x=1782131004;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NxNwzg+e+NRp49UH9pl97KcoyF640OFUJSGThEXSWcQ=;
        b=JnvTrAnklWciq4t+EGOZbpcBzBWH99IYFM9222XA4NUGxclHuNDi7LMPO4UVkKCva6
         1iwHXsb/jh8LE8sL3B0FMU59TxCqXdeaaJYw5nFtm3vwYgEsunM5W/aTExns7j1jJ1LV
         Il/c9rTF3WTjqcNPKxyVjXsKo3XxHtdhvBOkdhEP1nzV9YFd2xrIyxq1JBXHIpTfQmsx
         LVsrSc37rCNXSoY4My5aB5Nn0MoY/zHfEH65EjyLxP578H6haU7YzMOE2Ng4a0436sFj
         x4h4DOyeWaIE51WdbUV7sE36n4ItN1pp7B/3vbnKiSva2ClIwEhrlFxFvMkPK2+tnF0U
         p7qQ==
X-Gm-Message-State: AOJu0YwpWGfcJHd9rTPCKy39FnyY5JvFvYxvf29kzFR0akquQd1tyLew
	HZctKLjH2laKLUYLvhnPF9Ch3ECsw/kAOoetxUWhQR4V+XfYLhRxhX1vS3624R1V
X-Gm-Gg: Acq92OHHsbJ1mF98emG2uWOTgC1vHVo86OX70s4gFkoW9lca01W/wJdVpKwmdauzyCe
	wKwSYfT5sVo2xAOxKhJer5Jx5KuFFf/1LqE17oWXHvt3s1yHKINmzCmJnBzMCTBh8IHqZdjbXjR
	56cCpfgsuLOthuAI93XnEKmPSw04kT0qvfdAhNwTPZT/YUsJxwqjBOIaRfpVCckYmxQtr3HL7NX
	1vDkRm8T0oENltrKT7GqfR4Vh0wtSzVJQnCPmb9ekLqa8diMn4tKmLZYSQ2dnEfjtPZpofRT6Os
	nGA+46jIrlDKF4Lpg7gbMlojnEHFUAKirPOMpJMNvHKNWmR+cgRqBBFkrXQUAx/IsvsiFOi1DL6
	kCtNsi9vsIEVle1eG3eqUkJwlRl8ddtt/5Z4ujUrVT0Y+FHpfhnDA1LzcI5E3YYKivsGhQ+AMCF
	3RI6oniU0iB0BG+7n7yVM2vpKqhpkh0eZXatZoprt1G5RVTzIjQwrqpqsCACw2+PEfAdyUawg=
X-Received: by 2002:ac2:51d4:0:b0:5aa:8827:73bd with SMTP id 2adb3069b0e04-5ad2e13f751mr3102317e87.23.1781526204433;
        Mon, 15 Jun 2026 05:23:24 -0700 (PDT)
Received: from cherrypc.astra-academy.ru (109-252-17-231.nat.spd-mgts.ru. [109.252.17.231])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5ad2e1a7092sm2656037e87.50.2026.06.15.05.23.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Jun 2026 05:23:23 -0700 (PDT)
From: Nazar Kalashnikov <sivartiwe@gmail.com>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Nazar Kalashnikov <sivartiwe@gmail.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Gregory Greenman <gregory.greenman@intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	netdev@vger.kernel.org,
	Luca Coelho <luciano.coelho@intel.com>,
	Kalle Valo <kvalo@codeaurora.org>,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.15/6.1/6.6/6.12] wifi: iwlwifi: fix 22000 series SMEM parsing
Date: Mon, 15 Jun 2026 15:20:58 +0300
Message-ID: <20260615122100.137560-1-sivartiwe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,intel.com,kernel.org,vger.kernel.org,davemloft.net,google.com,redhat.com,codeaurora.org,linuxtesting.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-263190-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sivartiwe@gmail.com,m:miriam.rachel.korenblit@intel.com,m:kvalo@kernel.org,m:johannes.berg@intel.com,m:linux-wireless@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:gregory.greenman@intel.com,m:davem@davemloft.net,m:edumazet@google.com,m:kuba@kernel.org,m:pabeni@redhat.com,m:netdev@vger.kernel.org,m:luciano.coelho@intel.com,m:kvalo@codeaurora.org,m:lvc-project@linuxtesting.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sivartiwe@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sivartiwe@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	ALIAS_RESOLVED(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp,intel.com:email]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D37D86862D2

From: Johannes Berg <johannes.berg@intel.com>

commit 58192b9ce09b0f0f86e2036683bd542130b91a98 upstream.

If the firmware were to report three LMACs (which doesn't
exist in hardware) then using "fwrt->smem_cfg.lmac[2]" is
an overrun of the array. Reject such and use IWL_FW_CHECK
instead of WARN_ON in this function.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Miri Korenblit <miriam.rachel.korenblit@intel.com>
Link: https://patch.msgid.link/20251110150012.16e8c2d70c26.Iadfcc1aedf43c5175b3f0757bea5aa232454f1ac@changeid
Signed-off-by: Nazar Kalashnikov <sivartiwe@gmail.com>
---
Backport fix for CVE-2026-43172
 drivers/net/wireless/intel/iwlwifi/fw/smem.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/fw/smem.c b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
index 3f1272014daf..e2fc2f5de442 100644
--- a/drivers/net/wireless/intel/iwlwifi/fw/smem.c
+++ b/drivers/net/wireless/intel/iwlwifi/fw/smem.c
@@ -6,6 +6,7 @@
  */
 #include "iwl-drv.h"
 #include "runtime.h"
+#include "dbg.h"
 #include "fw/api/commands.h"
 
 static void iwl_parse_shared_mem_22000(struct iwl_fw_runtime *fwrt,
@@ -17,7 +18,9 @@ static void iwl_parse_shared_mem_22000(struct iwl_fw_runtime *fwrt,
 	u8 api_ver = iwl_fw_lookup_notif_ver(fwrt->fw, SYSTEM_GROUP,
 					     SHARED_MEM_CFG_CMD, 0);
 
-	if (WARN_ON(lmac_num > ARRAY_SIZE(mem_cfg->lmac_smem)))
+	/* Note: notification has 3 entries, but we only expect 2 */
+	if (IWL_FW_CHECK(fwrt, lmac_num > ARRAY_SIZE(fwrt->smem_cfg.lmac),
+			 "FW advertises %d LMACs\n", lmac_num))
 		return;
 
 	fwrt->smem_cfg.num_lmacs = lmac_num;
@@ -26,7 +29,8 @@ static void iwl_parse_shared_mem_22000(struct iwl_fw_runtime *fwrt,
 	fwrt->smem_cfg.rxfifo2_size = le32_to_cpu(mem_cfg->rxfifo2_size);
 
 	if (api_ver >= 4 &&
-	    !WARN_ON_ONCE(iwl_rx_packet_payload_len(pkt) < sizeof(*mem_cfg))) {
+	    !IWL_FW_CHECK(fwrt, iwl_rx_packet_payload_len(pkt) < sizeof(*mem_cfg),
+			  "bad shared mem notification size\n")) {
 		fwrt->smem_cfg.rxfifo2_control_size =
 			le32_to_cpu(mem_cfg->rxfifo2_control_size);
 	}
-- 
2.47.3

