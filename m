Return-Path: <stable+bounces-198026-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 85419C99B36
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 02:06:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 4118A4E18D7
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 01:06:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC764157A5A;
	Tue,  2 Dec 2025 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WDovQbx4"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C950136672
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 01:06:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637584; cv=none; b=sbT9q9SothMxxwEfyc+eGb0zYpP7FiaD42y5GUlb1Fe0XrV9B5F0Fiw3VGw0K6PF38Q1eDtft31eOKiaSsu6Tp0mTFap5L7Q0XIrjiqzDukdrjj/xWttbkU+myYfioTXLmS3qpk97mFsHvqXfy4RzPjVM5CyVsdSTG6IYmBYJKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637584; c=relaxed/simple;
	bh=/VW44yS7a6ncHZFZQk+1TgtqDv/8IAznZEPKJKvoSHc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bTPvdyrI3xcsKYvpLDcEChrxGiYTjPFtt6gkbPURbevVYkXscOfNR2UQTCucFDu9cULZg59jL0oj4zibCGTTjvRbal777dwYKhmddajGbuzQRPWqArYGiG8C0HFPn+XAboB98R4iifNEbvlLMbm7sqcwc7Qw/jKk+XGmBhiU4BI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WDovQbx4; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 46447C4CEF1;
	Tue,  2 Dec 2025 01:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764637584;
	bh=/VW44yS7a6ncHZFZQk+1TgtqDv/8IAznZEPKJKvoSHc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WDovQbx44ruFt9PqVM+PffsmtfD+Tan+b747yHVxdFGfw6g6KopWZk5i9ZHjs3kNk
	 HQ8615T8NFfvRm5H/N1fH0Y2OMvFtM2F8SYTq8R86d6WKpL4ED0bn3+KjJ1ZFDBaW/
	 28bFxecP3D2APhPd13/JoBI74/Z1jjte0Nq6uaFT3ondeK3bDbtXJ8MTCg4w8MUxwx
	 W0H89VRDbj8i7d4LzWqZTNEzGX1gUqmuzJpuFvv4xdIEsySspn3getXVRKOHR/XoT8
	 AZ8xP4iFh+pwgtQ3bFuwrVkl3lUGwrvmFN/N8tKJ0ZOtlYTo9NS+a2oOELEeXBT8ZA
	 +l2ojJ/jiSYug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	"Kenneth R. Crudup" <kenny@panix.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] usb: typec: ucsi: psy: Set max current to zero when disconnected
Date: Mon,  1 Dec 2025 20:06:19 -0500
Message-ID: <20251202010619.1551492-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120117-landing-used-752b@gregkh>
References: <2025120117-landing-used-752b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jameson Thies <jthies@google.com>

[ Upstream commit 23379a17334fc24c4a9cbd9967d33dcd9323cc7c ]

The ucsi_psy_get_current_max function defaults to 0.1A when it is not
clear how much current the partner device can support. But this does
not check the port is connected, and will report 0.1A max current when
nothing is connected. Update ucsi_psy_get_current_max to report 0A when
there is no connection.

Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
Cc: stable@vger.kernel.org
Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
Rule: add
Link: https://lore.kernel.org/stable/20251017000051.2094101-1-jthies%40google.com
Link: https://patch.msgid.link/20251106011446.2052583-1-jthies@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ adapted UCSI_CONSTAT() macro to direct flag access ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/typec/ucsi/psy.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index ba5f797156dcb..f7305db950127 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -123,6 +123,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 {
 	u32 pdo;
 
+	if (!(con->status.flags & UCSI_CONSTAT_CONNECTED)) {
+		val->intval = 0;
+		return 0;
+	}
+
 	switch (UCSI_CONSTAT_PWR_OPMODE(con->status.flags)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
 		if (con->num_pdos > 0) {
-- 
2.51.0


