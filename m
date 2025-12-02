Return-Path: <stable+bounces-198019-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2725C99A4D
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 01:23:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 676B43A3A8E
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 00:23:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588A182899;
	Tue,  2 Dec 2025 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="H9MMrVZ7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1810636D518
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 00:23:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764634998; cv=none; b=G/NCSVPix6gWdrCYYkv3QJ2C2EtezciB2A6xOZ9dippM+oWBZxezqbKwwvSvyFfR8//Fwwh4Y4rKUZce2hNmWbmyurDk5mogb1N9qGnLBRbRWCTMz1Uzbk0BHiv+3enVz3MFIFYTInQjkkdHQHdbERw+KOCkx/zfPKRHUL16Mh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764634998; c=relaxed/simple;
	bh=L730SmW/I1sWqXQgoxUmSEjDTaTBRI/5hIw5XqcngjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=naOCy6OB622YOK1RRPrLY4P8XbpIUW4+lwbJwqbXftaf2yrtQ0CkJlo/5to6OC8vSSqKBCfHrmZg4kBZKNhAr8iP+Um8Lg9j1ik/haUqKm/Jq8gTRzhSBpBEd20O0gb7pzJYPUSFVbvXZm037Mgl7wfSsV5zShU/ISlRHzRAJJA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=H9MMrVZ7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8BA8BC4CEF1;
	Tue,  2 Dec 2025 00:23:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764634997;
	bh=L730SmW/I1sWqXQgoxUmSEjDTaTBRI/5hIw5XqcngjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H9MMrVZ7XIHdFAkxFpO9srYel7+0yVAiVdfCIxH/SH1W7h2M0JJoDwTp8rvYg8rG0
	 bH0S4GBILfCYly5Hk3CpqgX8LFocCzjvzTJZRBKvxjoHUxGaM3fr70GWWT38WUqfb7
	 8BQd/aRABxC4n8ffj3l7xN0welU8TqDD3J6E6Bzn2xmqAuDNnhIqVIsMhvPsJPpty8
	 r1QGecXrgwmtb32iwYOjRRXyjR6OVlU6PuGyANHAm0nCpGvluMbagR/nh+BpCcDOaD
	 s70TkmamHpu7fWY9k7WEwQr5YlWCevmEyFJws01GVFjoSNA6kwDzYY6HoW29/IHist
	 Yt9zfe6uiPBeQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	"Kenneth R. Crudup" <kenny@panix.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] usb: typec: ucsi: psy: Set max current to zero when disconnected
Date: Mon,  1 Dec 2025 19:23:08 -0500
Message-ID: <20251202002308.1498190-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120115-ascension-acre-a1d0@gregkh>
References: <2025120115-ascension-acre-a1d0@gregkh>
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
index 9447a50716ec1..7f176382b1a0f 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -145,6 +145,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
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


