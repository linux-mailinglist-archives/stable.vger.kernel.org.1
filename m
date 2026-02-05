Return-Path: <stable+bounces-214459-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8IveGMGchGmI3wMAu9opvQ
	(envelope-from <stable+bounces-214459-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:36:01 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id CA25BF3590
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 14:36:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 51A97301F791
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 13:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A17D22541B;
	Thu,  5 Feb 2026 13:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZFnZOSiR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C09B321CC51;
	Thu,  5 Feb 2026 13:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770298540; cv=none; b=l9niNWQDwfs4BQ2ezzPe9QruZE4nRqEruf+KDic153plp9NF0/m858MNX+oSn51LkSVe9KsLnODCZY07mQfByeOcvxHvHpCYwz6oM51EK3p0ncHQsBzED9UL0CtKvOPKFdSuIP/zkRfk7xUYdGw0BNYnI/N7gi6WiuBGN8GXwH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770298540; c=relaxed/simple;
	bh=7H8x7+Vs9ncPRmSVekn0q1igZHbJe/1+HCqa5nbEupo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=eR1/yBJLSk4PenvmM7ZSCQ6Z8phvNJal40cnr/ouiVWRnvQxOU3hVx50eu/+g3r7eqr1SEPBKrvLHJWOEZcKVr12wpWs6m6PB01HyQLb+r4lXhrSm4SWCu+gb4h9HZu/ZkmHNNGD66pDTR43DBFYI+w6OKFPeZ2GMQmtHtqcAiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZFnZOSiR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 5AC29C4CEF7;
	Thu,  5 Feb 2026 13:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770298540;
	bh=7H8x7+Vs9ncPRmSVekn0q1igZHbJe/1+HCqa5nbEupo=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ZFnZOSiR3ZnJEVu6D8EYzb5FQEtPzb3qldZ7e1JZ9wp4eMAvlYdJRsCPjq2jrA93T
	 4zKupqDpaQynkbKkczCeRI9e4uJohWDxWFMcNnYFwcSBqWJCOVH/IGVrHN/aglKmXX
	 3grHD8gLoe/bIUzQ/ryvwtJ99azQ4Fj3g86DOcb11r+ftSWWmC8+M52Xovxzn1KFgG
	 bsT+ydIFFOTetXRKZpYs3A2sJl4MHuYpBXR/P/sA79o59brr5k35icomxVUF6s3MJW
	 jYdZo6V5AGRj1KRyg8Vj2vebTzKI+71C0hlzWA/ODUp7QuntDO0dgTNrp2XVRunyOW
	 bJADUSZVeb1hA==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 435BCEC1E9B;
	Thu,  5 Feb 2026 13:35:40 +0000 (UTC)
From: Jean-Baptiste Maneyrol via B4 Relay <devnull+jean-baptiste.maneyrol.tdk.com@kernel.org>
Date: Thu, 05 Feb 2026 14:35:33 +0100
Subject: [PATCH] iio: imu: inv_icm45600: fix regulator put warning when
 probe fails
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260205-inv-icm45600-fix-regulator-put-warning-v1-1-314ec12512cb@tdk.com>
X-B4-Tracking: v=1; b=H4sIAKSchGkC/x2N0QrCMAwAf2Xk2UCs7UR/RfZQYqwBzUa6TWHs3
 y0+Hhx3G1RxlQrXbgOXVauO1uB46ICf2Yqg3htDoNBToIRqKyq/Y+qJ8KFfdCnLK8+j47TM+Ml
 uagXPHFOOF46cTtBik0uT/6PbsO8/W6CSXHgAAAA=
X-Change-ID: 20260205-inv-icm45600-fix-regulator-put-warning-7c45a49c4c53
To: Remi Buisson <remi.buisson@tdk.com>, 
 Jonathan Cameron <jic23@kernel.org>, David Lechner <dlechner@baylibre.com>, 
 =?utf-8?q?Nuno_S=C3=A1?= <nuno.sa@analog.com>, 
 Andy Shevchenko <andy@kernel.org>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1770298539; l=2036;
 i=jean-baptiste.maneyrol@tdk.com; s=20240923; h=from:subject:message-id;
 bh=T/j7PYMV8Dkhv8t5z9e34UhoY7jumpJGzpjuK+CVlpM=;
 b=Z5aK5s1uCMhnxpxXvOFQx4RngBLnWPPbFd7r47gUprMEXOtUFxjOOHubekNAcYIa2JQcOUEw5
 5h+2Ys5JxwUAWnWBVNp6+zM9/Maj+KvQUgvX4qFwGI0vEPTRXAzPsjB
X-Developer-Key: i=jean-baptiste.maneyrol@tdk.com; a=ed25519;
 pk=bRqF1WYk0hR3qrnAithOLXSD0LvSu8DUd+quKLxCicI=
X-Endpoint-Received: by B4 Relay for
 jean-baptiste.maneyrol@tdk.com/20240923 with auth_id=218
X-Original-From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Reply-To: jean-baptiste.maneyrol@tdk.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_RHS_MATCH_TO(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-214459-lists,stable=lfdr.de,jean-baptiste.maneyrol.tdk.com];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_HAS_DN(0.00)[];
	HAS_REPLYTO(0.00)[jean-baptiste.maneyrol@tdk.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[devnull@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CA25BF3590
X-Rspamd-Action: no action

From: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>

When the driver probe fails we encounter a regulator put warning
because vddio regulator is not stopped before release. The issue
comes from pm_runtime not already setup when core probe fails and
the vddio regulator disable callback is called.

Fix the issue by deleting pm_runtime check in the vddio regulator
disable callback and handing over the vddio disable management to
pm_runtime by deleting the disable remove action before setting up
pm_runtime.

Fixes: 7ff021a3faca ("iio: imu: inv_icm45600: add new inv_icm45600 driver")
Signed-off-by: Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>
Cc: stable@vger.kernel.org
---
 drivers/iio/imu/inv_icm45600/inv_icm45600_core.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
index ab1cb7b9dba435a3280e50ab77cd16e903c7816c..18d613a025cb4f9cbb8d73f27a46fc1207f5820d 100644
--- a/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
+++ b/drivers/iio/imu/inv_icm45600/inv_icm45600_core.c
@@ -676,10 +676,6 @@ static int inv_icm45600_enable_regulator_vddio(struct inv_icm45600_state *st)
 static void inv_icm45600_disable_vddio_reg(void *_data)
 {
 	struct inv_icm45600_state *st = _data;
-	struct device *dev = regmap_get_device(st->map);
-
-	if (pm_runtime_status_suspended(dev))
-		return;
 
 	regulator_disable(st->vddio_supply);
 }
@@ -780,6 +776,8 @@ int inv_icm45600_core_probe(struct regmap *regmap, const struct inv_icm45600_chi
 	if (ret)
 		return ret;
 
+	/* hand over vddio management to pm_runtime */
+	devm_remove_action(dev, inv_icm45600_disable_vddio_reg, st);
 	pm_runtime_get_noresume(dev);
 	pm_runtime_set_autosuspend_delay(dev, 2 * USEC_PER_MSEC);
 	pm_runtime_use_autosuspend(dev);

---
base-commit: d820183f371d9aa8517a1cd21fe6edacf0f94b7f
change-id: 20260205-inv-icm45600-fix-regulator-put-warning-7c45a49c4c53

Best regards,
-- 
Jean-Baptiste Maneyrol <jean-baptiste.maneyrol@tdk.com>



