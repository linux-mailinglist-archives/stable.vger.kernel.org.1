Return-Path: <stable+bounces-233518-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OCe7CDbB1GmWwwcAu9opvQ
	(envelope-from <stable+bounces-233518-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:32:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 775E23AB646
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:32:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5D2ED300E729
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824CD20C029;
	Tue,  7 Apr 2026 08:32:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtpbgau2.qq.com (smtpbgau2.qq.com [54.206.34.216])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A32B397E6E
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 08:32:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.206.34.216
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775550760; cv=none; b=sOtChwE12sl0ID5MOXNYtdCu9CjerX8DeGRkUOYUgS4AXNQ7DrtupSWE8kyL89ZPa4mRY2TUSPv6Mon1Skwn/uDopZwS/qjGHitqJk6CqKjI98i/Rv4UIFaeqfgTeMQ5S8kz0f1h2HyEG/DMUKe/06OzsKQ0SmSzYlNQrloVvhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775550760; c=relaxed/simple;
	bh=btgOKgbuheDcUPT8oEZacQRTKrs4Vl9Yek45oxBmL2I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=cobbf8aquYvXCMlq5SVvUcwoJIu1BWw+WRtluq++BwM1tz7zlm2MPDlPnWC4wHiKY74pcPzzPNS5mN9cSFXjFMRIXBwNroGd2pu/dLlXdiISCnhWBeuF0PmY/dcIb598d/iRRHu0NwJ+pCmZwwiXrk1s+oQ3Py1EhaDZN6MfcyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com; spf=pass smtp.mailfrom=radxa.com; arc=none smtp.client-ip=54.206.34.216
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=radxa.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=radxa.com
X-QQ-mid: esmtpgz11t1775550741t4bae4b67
X-QQ-Originating-IP: km4qO8TB8e0CX3fAEWqRNQfz23UNoL5SmAgx2StGANo=
Received: from [192.168.30.32] ( [116.234.14.100])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 07 Apr 2026 16:32:19 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5058057940856507686
EX-QQ-RecipientCnt: 12
From: Xilin Wu <sophon@radxa.com>
Date: Tue, 07 Apr 2026 16:32:05 +0800
Subject: [PATCH 6.18.y] ASoC: qcom: sc7280: make use of common helpers
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260407-qcom-sdw-6-18-v1-1-2e1b884c14cf@radxa.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMzQ6CMBAGX4V8Z5d0G1KIr2I8QLvomgja9TeEd
 7fqcSaZWWCSVQzbakGWh5rOUwHeVIjHfjoIaSoM73xwjWvpGuczWXpSIO7Ip36QJrBwO6I0lyy
 jvn6/HULNXf3G/u/tPpwk3r4zrOsH7uS5nnkAAAA=
X-Change-ID: 20260407-qcom-sdw-6-18-2dabe461e17f
To: Srinivas Kandagatla <srini@kernel.org>, 
 Liam Girdwood <lgirdwood@gmail.com>, Mark Brown <broonie@kernel.org>, 
 Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>, 
 linux-sound@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Steev Klimaszewski <threeway@gmail.com>, Xilin Wu <sophon@radxa.com>
X-Mailer: b4 0.15.1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2001; i=sophon@radxa.com;
 h=from:subject:message-id; bh=w+gy2MD3FrtevswuLj1MAXnzeWGi3gtTK0a6/TYrKU4=;
 b=owGbwMvMwCVmdFg0fe08Iz/G02pJDJlXDorcZUj5/a4ywbHVetb/93uWm4X43ZS68TlO8OlPS
 0kpq/OtHaUsDGJcDLJiiiwK8Qxz2Stzrz0VK9WDmcPKBDKEgYtTACYyr4KR4T6vTU7CpqPnGhak
 OGa48q/Z+eXw6ZjsPfyHKy/8PRuZtZHhn103F4/ez7lSGyI//Py8Olbfe2GWh+TFGyy3BIzW/mb
 w5QMA
X-Developer-Key: i=sophon@radxa.com; a=openpgp;
 fpr=205F009D07796DD6E516752E32C31567AD9E324E
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpgz:radxa.com:qybglogicsvrsz:qybglogicsvrsz3b-0
X-QQ-XMAILINFO: Of2cEohDBRJBI0ZtEXBAogVdx98uiZtBFdj0MNITXm3zAh0Uj45SGlLf
	sLt7lX6XRGLY6yY01KJ/UB5qUIYB0UmH9M7kU0Ttt3iPrjVtvtfMn/S9V3E9kpI5SgsJzwu
	11cgwfZ1ugxCfCxH6KgU8nYKgxZ3rHCm+d7eiWiajwuINo98v9RsMIFrVwvjk/zGJ/Yx3EL
	IpAM2aw+bJ8YDWcglNC7rIBoQnlPG9B3XV7xG/9T8sZybvFxjT0/ChJI9fyjOwUwJX8fJGp
	VwHWL7wSswAxF467sEZjR0+C6Blz4VDOKVGg0BsMF36w0LPLcWfuW1nznYpj6leb9EtN6ud
	1MkSda92LrsqFjbKGJfarZempgEhDztJhM5uvsXV6LIsu6Fwx+rJ2tEr6Fy0ZXZgRHmA11V
	+lX9Dpgm/1Y+g3+BQEA2tVyhjaCA2G98vKf9oCF5Lreti1kq1z+yzxd64ehSd+9bQDjYZ04
	LANz0GgxPI2k3VWMkfxAOLuiuYpOqWzVvHYNqcD5LyHAhPElc5tPF/NOZYtDvNEGmDeLR3s
	rf1WitYlEAKLdHRZ3wsjsfot/cxXem7UQWuMyBRJ1kiDKy1jqwI4tmpfq7FPzVx2NYnnvcf
	dQjohUjYsXKMtpSj9l5QUYTYQlJXeeGy7PvsQqfUTYLPZj0qbCcPLhZeGu6oouadsT+bGZv
	wwsvnfR6ejERj0EDpTxoM07Kx/1g6r4zVQOiAe/BDB8AUm87E62bn5m8Jmv0xbapATtIgTD
	Vo2g2X8cz3KCwBAQVT6efLe1HOOe+YpwEyB+5bGQMCROSgnWKb0tbcRJSHe6VWWlqLxoVmO
	el7K/brQV/DP/2odQMMEckOO3CkCLnCA9giIR7VdaCur+TlCXbJpukBIUvscU+hMkxjTvOI
	Re5HYa/xRKXmmJ5bfKyJdsHokZtksSSWKW3MenZsJzPzu8MmAKeTRu954PrflDfQyek46/0
	/ofa9ONushwA8pae9OEuC+abVRfwBj6vpZK3IlFM+8+i/U9jPJwfRiMDcfMexMn7RktYNOu
	xZLvUnU0cWTKO5uG3exUb/IvjvhxM=
X-QQ-XMRINFO: Mp0Kj//9VHAxzExpfF+O8yhSrljjwrznVg==
X-QQ-RECHKSPAM: 0
X-Spamd-Result: default: False [-1.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	DMARC_POLICY_SOFTFAIL(0.10)[radxa.com : SPF not aligned (relaxed), No valid DKIM,none];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[kernel.org,gmail.com,perex.cz,suse.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233518-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,vger.kernel.org,gmail.com,radxa.com];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sophon@radxa.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.982];
	MID_RHS_MATCH_FROM(0.00)[];
	R_DKIM_NA(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: 775E23AB646
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>

commit 8fdb030fe283c84fd8d378c97ad0f32d6cdec6ce upstream.

sc7280 machine driver can make use of common sdw functions to do most of
the soundwire related operations. Remove such redundant code from sc7280
driver.

[This is a partial backport containing only the sound/soc/qcom/sdw.c
changes which add LPASS CDC DMA DAI IDs to qcom_snd_is_sdw_dai().
The sc7280.c refactoring changes are omitted as they depend on
intermediate patches not present in 6.18.y. The sdw.c change fixes a
NULL pointer dereference for lpass-cpu based SoundWire links.]

Fixes: bcba17279327 ("ASoC: qcom: sdw: fix memory leak for sdw_stream_runtime")
Cc: stable@vger.kernel.org
Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@oss.qualcomm.com>
Tested-by: Steev Klimaszewski <threeway@gmail.com> # Thinkpad X13s
Link: https://patch.msgid.link/20251022143349.1081513-5-srinivas.kandagatla@oss.qualcomm.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Xilin Wu <sophon@radxa.com>
---
 sound/soc/qcom/sdw.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/sound/soc/qcom/sdw.c b/sound/soc/qcom/sdw.c
index 7b2cae92c812..5f880c74c8dc 100644
--- a/sound/soc/qcom/sdw.c
+++ b/sound/soc/qcom/sdw.c
@@ -2,6 +2,7 @@
 // Copyright (c) 2018-2023, Linaro Limited.
 // Copyright (c) 2018, The Linux Foundation. All rights reserved.
 
+#include <dt-bindings/sound/qcom,lpass.h>
 #include <dt-bindings/sound/qcom,q6afe.h>
 #include <linux/module.h>
 #include <sound/soc.h>
@@ -35,6 +36,16 @@ static bool qcom_snd_is_sdw_dai(int id)
 		break;
 	}
 
+	/* DSP Bypass usecase, cpu dai index overlaps with DSP dai ids,
+	 * DO NOT MERGE into top switch case */
+	switch (id) {
+	case LPASS_CDC_DMA_TX3:
+	case LPASS_CDC_DMA_RX0:
+		return true;
+	default:
+		break;
+	}
+
 	return false;
 }
 

---
base-commit: dd26ea937ef593a9c47aa4c85296e6b57a5344a1
change-id: 20260407-qcom-sdw-6-18-2dabe461e17f

Best regards,
--  
Xilin Wu <sophon@radxa.com>


