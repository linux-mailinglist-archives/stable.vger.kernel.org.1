Return-Path: <stable+bounces-252717-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kERCKqH9DWo95QUAu9opvQ
	(envelope-from <stable+bounces-252717-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:29:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 39ED05965AC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 20:29:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E31253151B8F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 18:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40CE83FE652;
	Wed, 20 May 2026 18:23:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1C0I+10q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 980E53FE35F;
	Wed, 20 May 2026 18:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779301406; cv=none; b=YV1CGEXx3o0uaU0NDrPPkiTbtVSbVm6x2HvjZglnCAoWnFmOTVk4E/A74Hz7GRErixn9t7jZpemK0AmEs8+Vji3V7w67d+KO4WdyGis7bqYZofEfe0EPioQQlnd89qSiq7riXEegcTR8lPDoTnx9ltBED6/E/0twvX089aTirbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779301406; c=relaxed/simple;
	bh=thgKPePakzIY5l7K8QF0UJQ7qB8IBs+Qm11LTN6vbbk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PfareasSoad50xcQfxm2DSlxshIlel/DiYBHpr4GKkpvK3AiTbXajihuuDFzgMk+GrNcFfSuVmfL/D7O2wU+kp19SJbCwt+c/MxiOLtXletnIccV+cYFu/dQlYJm/ql5G06pYAibPZaLKFL2O2MPFsejH2qJbby2osWL4BKpdDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1C0I+10q; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC6811F00894;
	Wed, 20 May 2026 18:23:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1779301404;
	bh=lMm4jqabV16UWf4wYCpjWNfL2fzqRxL5tUiEDYcRNgI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=1C0I+10qPF3ozNU0kfRH995d5ArNa7XcQ1jAJ/OO6RoV3Z4c12MKyGQmc+ku1vdwN
	 d4NuNVVa0lw9m5HFNDoantbB2qk+VViL7PkKFhftO6xYuxIetffYKaSe2H++59dH1e
	 bBdBaSOmGJlQnJNBt6AXspH7YGY4wSFbjvVRBEvg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Paul Geurts <paul.geurts@prodrive-technologies.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>,
	Mark Greer <mgreer@animalcreek.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 542/666] NFC: trf7970a: Ignore antenna noise when checking for RF field
Date: Wed, 20 May 2026 18:22:33 +0200
Message-ID: <20260520162123.018904855@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520162111.222830634@linuxfoundation.org>
References: <20260520162111.222830634@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-252717-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[qualcomm.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,msgid.link:url,linuxfoundation.org:mid,linuxfoundation.org:dkim,prodrive-technologies.com:email]
X-Rspamd-Queue-Id: 39ED05965AC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Geurts <paul.geurts@prodrive-technologies.com>

[ Upstream commit a9bc28aa4e64320668131349436a650bf42591a5 ]

The main channel Received Signal Strength Indicator (RSSI) measurement
is used to determine whether an RF field is present or not. RSSI != 0
is interpreted as an RF Field is present. This does not take RF noise
and measurement inaccuracy into account, and results in false positives
in the field.

Define a noise level and make sure the RF field is only interpreted as
present when the RSSI is above the noise level.

Fixes: 851ee3cbf850 ("NFC: trf7970a: Don't turn on RF if there is already an RF field")
Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>
Reviewed-by: Mark Greer <mgreer@animalcreek.com>
Link: https://patch.msgid.link/20260422100930.581237-1-paul.geurts@prodrive-technologies.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nfc/trf7970a.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
index 9e1a34e23af26..6b8311f526a5e 100644
--- a/drivers/nfc/trf7970a.c
+++ b/drivers/nfc/trf7970a.c
@@ -311,6 +311,7 @@
 #define TRF7970A_RSSI_OSC_STATUS_RSSI_MASK	(BIT(2) | BIT(1) | BIT(0))
 #define TRF7970A_RSSI_OSC_STATUS_RSSI_X_MASK	(BIT(5) | BIT(4) | BIT(3))
 #define TRF7970A_RSSI_OSC_STATUS_RSSI_OSC_OK	BIT(6)
+#define TRF7970A_RSSI_OSC_STATUS_RSSI_NOISE_LEVEL	1
 
 #define TRF7970A_SPECIAL_FCN_REG1_COL_7_6		BIT(0)
 #define TRF7970A_SPECIAL_FCN_REG1_14_ANTICOLL		BIT(1)
@@ -1253,7 +1254,7 @@ static int trf7970a_is_rf_field(struct trf7970a *trf, bool *is_rf_field)
 	if (ret)
 		return ret;
 
-	if (rssi & TRF7970A_RSSI_OSC_STATUS_RSSI_MASK)
+	if ((rssi & TRF7970A_RSSI_OSC_STATUS_RSSI_MASK) > TRF7970A_RSSI_OSC_STATUS_RSSI_NOISE_LEVEL)
 		*is_rf_field = true;
 	else
 		*is_rf_field = false;
-- 
2.53.0




