Return-Path: <stable+bounces-82017-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A96F2994AA1
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 14:34:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5FAA91F21BCF
	for <lists+stable@lfdr.de>; Tue,  8 Oct 2024 12:34:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0599C1C2443;
	Tue,  8 Oct 2024 12:34:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="otAVR7em"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6B0D1779B1;
	Tue,  8 Oct 2024 12:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728390896; cv=none; b=QXPjIY6KL/vgIqZ+5ryz2qjf3CrfR7bz05dOqOfvQEU2e2EDktI/1ZqpZDgkmBpBPC3u4lGmerZwJK2M0sBTUSiIE/P37iVvgCNHmuS2k0MzwhF+uK9koD7QX35EMt4tV9gQLUnuLBWWrLTPS0OEZtPCYFvOxWx9L6/F9oI78Q4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728390896; c=relaxed/simple;
	bh=hpg6Q16Fwji2LwphJN026BSOQdAxN8PziLGx0tTIra4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bXWu8b3rqKQVp+VGw0ahhT1FmWE7SRhL21KTs094Bt+uWaQqSnJmMkHNkW6xrJ6lLBoQ8d2QZlkC4BJ0PFw3LMuX+4IKiesBTulmB+vAX1KfJfq/0rcsNmkH4ZCgVgK+c3yzX3sEN+3+zTafGXeBOxKhzJDIr8UfVjmql6FfAog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=otAVR7em; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21311C4CEC7;
	Tue,  8 Oct 2024 12:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728390896;
	bh=hpg6Q16Fwji2LwphJN026BSOQdAxN8PziLGx0tTIra4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=otAVR7emin+KE/XfWcyDFUlkFeQEJKTqWAZhVnNAjlWww2UtMKm5SbPNsJDxgOHbT
	 CIL90Kqn8s183kvRJMw89agWVufW99GLu2zvT2thXeiHEYE02TyRz9JXtxh6b+AfWs
	 EO+VqG4TKNPb1BSkJk3X8K/bB8VpTXruA/VpFDZU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jiawei Ye <jiawei.ye@foxmail.com>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Przemek Kitszel <przemyslaw.kitszel@intel.com>,
	Stefan Schmidt <stefan@datenfreihafen.org>
Subject: [PATCH 6.10 425/482] mac802154: Fix potential RCU dereference issue in mac802154_scan_worker
Date: Tue,  8 Oct 2024 14:08:08 +0200
Message-ID: <20241008115705.127457191@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241008115648.280954295@linuxfoundation.org>
References: <20241008115648.280954295@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jiawei Ye <jiawei.ye@foxmail.com>

commit bff1709b3980bd7f80be6786f64cc9a9ee9e56da upstream.

In the `mac802154_scan_worker` function, the `scan_req->type` field was
accessed after the RCU read-side critical section was unlocked. According
to RCU usage rules, this is illegal and can lead to unpredictable
behavior, such as accessing memory that has been updated or causing
use-after-free issues.

This possible bug was identified using a static analysis tool developed
by myself, specifically designed to detect RCU-related issues.

To address this, the `scan_req->type` value is now stored in a local
variable `scan_req_type` while still within the RCU read-side critical
section. The `scan_req_type` is then used after the RCU lock is released,
ensuring that the type value is safely accessed without violating RCU
rules.

Fixes: e2c3e6f53a7a ("mac802154: Handle active scanning")
Cc: stable@vger.kernel.org
Signed-off-by: Jiawei Ye <jiawei.ye@foxmail.com>
Acked-by: Miquel Raynal <miquel.raynal@bootlin.com>
Reviewed-by: Przemek Kitszel <przemyslaw.kitszel@intel.com>
Link: https://lore.kernel.org/tencent_3B2F4F2B4DA30FAE2F51A9634A16B3AD4908@qq.com
Signed-off-by: Stefan Schmidt <stefan@datenfreihafen.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/mac802154/scan.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/net/mac802154/scan.c
+++ b/net/mac802154/scan.c
@@ -176,6 +176,7 @@ void mac802154_scan_worker(struct work_s
 	struct ieee802154_local *local =
 		container_of(work, struct ieee802154_local, scan_work.work);
 	struct cfg802154_scan_request *scan_req;
+	enum nl802154_scan_types scan_req_type;
 	struct ieee802154_sub_if_data *sdata;
 	unsigned int scan_duration = 0;
 	struct wpan_phy *wpan_phy;
@@ -209,6 +210,7 @@ void mac802154_scan_worker(struct work_s
 	}
 
 	wpan_phy = scan_req->wpan_phy;
+	scan_req_type = scan_req->type;
 	scan_req_duration = scan_req->duration;
 
 	/* Look for the next valid chan */
@@ -246,7 +248,7 @@ void mac802154_scan_worker(struct work_s
 		goto end_scan;
 	}
 
-	if (scan_req->type == NL802154_SCAN_ACTIVE) {
+	if (scan_req_type == NL802154_SCAN_ACTIVE) {
 		ret = mac802154_transmit_beacon_req(local, sdata);
 		if (ret)
 			dev_err(&sdata->dev->dev,



