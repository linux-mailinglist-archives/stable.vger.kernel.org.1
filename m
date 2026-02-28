Return-Path: <stable+bounces-220551-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIdlISA6o2mU+gQAu9opvQ
	(envelope-from <stable+bounces-220551-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:55:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CC331C6697
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:55:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E1C4E3424874
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:46:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81B543D567E;
	Sat, 28 Feb 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbBXauBz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375753D5674;
	Sat, 28 Feb 2026 17:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300433; cv=none; b=d4BElg65mF2oNaVEAaqGnM3LxXQ1DF7OxozlFDhHXtG0PLVj4ouTF8bf3Xep8/FHF1nWcls/Kj5MvGK9/YFDu0YPHi5xG6tgjw7i0Nwj8uSIAZ5h324DQXmFGVOYOdhnDRcimj0o9mIEDjTy9WTfVcl0VxMQ5sRDuIQOylyCzVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300433; c=relaxed/simple;
	bh=vFJOB/tj3DORoPczvwwyK/P3t1OiK9PdPbshDbq73c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HRLAC7gC2VU9zNrAmn09UbjWWH9hs2PGqDUwr4/O/q3KtUDfDj2Gq7DTzSVMpvT1Ai+QFc5fA5LDPsYWajKZazF21KcWSq6+S5qwTaU3zQbeCRrA2pyYrwe2uKKlUJ2SFnGU/2ItCj8MiFjJ3L6GR0DuPgNfwRlfqA1IkEfS5IA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbBXauBz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C49FC116D0;
	Sat, 28 Feb 2026 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300433;
	bh=vFJOB/tj3DORoPczvwwyK/P3t1OiK9PdPbshDbq73c8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbBXauBzbcBWQoFGwyvhEoJXeRYytMjhj7yXnLx3kBYmNtYNwKyB9GLRTuG7nXwdz
	 0tokNr8sch7kdWPYnmLG9JDBEpvf5rzJMj3u0OuiTK4yVWJTzEIhU1h+1Uut1OwtYs
	 bMgcwlyhyiqurKxA/8DjTC7AbqNNU/SgiDfNuNQgWZe2ZhhuvJNoyyVV+QLQXBVoSL
	 yupJiESYsUbcIbkCUaozcG7k8UJrW4/4yiSd5+G0mHXvLgWCfDcK0hK2PxoVzcVKX/
	 heHOkhZhwmvl02jPLAW/8UMp1wzJyZsEeX1iiXgnA3UVdrqymuuHtp7ZOfNf/zwl2B
	 3tBr06DI2OrhA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Jinwang Li <jinwang.li@oss.qualcomm.com>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 472/844] Bluetooth: hci_qca: Cleanup on all setup failures
Date: Sat, 28 Feb 2026 12:26:25 -0500
Message-ID: <20260228173244.1509663-473-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220551-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 0CC331C6697
X-Rspamd-Action: no action

From: Jinwang Li <jinwang.li@oss.qualcomm.com>

[ Upstream commit 5c4e9a8b18457ad28b57069ef0f14661e3192b2e ]

The setup process previously combined error handling and retry gating
under one condition. As a result, the final failed attempt exited
without performing cleanup.

Update the failure path to always perform power and port cleanup on
setup failure, and reopen the port only when retrying.

Fixes: 9e80587aba4c ("Bluetooth: hci_qca: Enhance retry logic in qca_setup")
Signed-off-by: Jinwang Li <jinwang.li@oss.qualcomm.com>
Reviewed-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/bluetooth/hci_qca.c | 24 ++++++++++++++----------
 1 file changed, 14 insertions(+), 10 deletions(-)

diff --git a/drivers/bluetooth/hci_qca.c b/drivers/bluetooth/hci_qca.c
index a3c217571c3c4..c0cc04995fc2f 100644
--- a/drivers/bluetooth/hci_qca.c
+++ b/drivers/bluetooth/hci_qca.c
@@ -2045,19 +2045,23 @@ static int qca_setup(struct hci_uart *hu)
 	}
 
 out:
-	if (ret && retries < MAX_INIT_RETRIES) {
-		bt_dev_warn(hdev, "Retry BT power ON:%d", retries);
+	if (ret) {
 		qca_power_shutdown(hu);
-		if (hu->serdev) {
-			serdev_device_close(hu->serdev);
-			ret = serdev_device_open(hu->serdev);
-			if (ret) {
-				bt_dev_err(hdev, "failed to open port");
-				return ret;
+
+		if (retries < MAX_INIT_RETRIES) {
+			bt_dev_warn(hdev, "Retry BT power ON:%d", retries);
+			if (hu->serdev) {
+				serdev_device_close(hu->serdev);
+				ret = serdev_device_open(hu->serdev);
+				if (ret) {
+					bt_dev_err(hdev, "failed to open port");
+					return ret;
+				}
 			}
+			retries++;
+			goto retry;
 		}
-		retries++;
-		goto retry;
+		return ret;
 	}
 
 	/* Setup bdaddr */
-- 
2.51.0


