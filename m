Return-Path: <stable+bounces-198025-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4C0C99AF3
	for <lists+stable@lfdr.de>; Tue, 02 Dec 2025 01:58:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DB2E34E1835
	for <lists+stable@lfdr.de>; Tue,  2 Dec 2025 00:58:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52F5379CF;
	Tue,  2 Dec 2025 00:58:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="swMU+1OS"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F287156678
	for <stable@vger.kernel.org>; Tue,  2 Dec 2025 00:58:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764637125; cv=none; b=k97QewA0p22Oc1dAhzWGP0vBMMZpcQwYehKUZBAtXwO8pE2zrh8rtL5wlP1vBOmJaRfBX83yK5KAClTQeb8fhoF/H5fElIAOVxYUhW7LWT6ivsODnLzFAMp+3iNTNku1nP+0Wo9TzGN05wEldO+w+VEsBvoiqgChroTeOM3VUd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764637125; c=relaxed/simple;
	bh=U3DidM1m4sS4IC9opNfm3Mh4/3TWIfwC72PIq9YXBpg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oeP1feFJvGIiggqjIT0iI1UnbEKd8Q/bEojqUhaOpVHamAa+dCvxF+zzeiYUOIqxcIfnhFRcR0PdOZyLBdtDmHNXxsnfI6lFi9VVowvjoiEj5ECXf/1TlYg/AfaRwWamHS9AMvXkGmvcYtJntMfldArAkNftcai9eeOP86XNDMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=swMU+1OS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC77C4CEF1;
	Tue,  2 Dec 2025 00:58:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1764637124;
	bh=U3DidM1m4sS4IC9opNfm3Mh4/3TWIfwC72PIq9YXBpg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=swMU+1OSJH0DkEakFRQTL0MQPanp/VSh/CwD0eo6+yu6putNVvKv6AlNLKjSQJh1l
	 uYBhpq5O9hamqPY+aavLhebhJUrpWX0Vt/uKC1OwtIYAqzN3qjXUqcQMvzhhNzAjQr
	 0DSHspQrp+eijfGowPL7Y3GgXBtuIXCssu6ojCWDLnDd+2VzadQldKtc3yhFwYmWH4
	 AKJsqDRYXTUB5u6dBfDpxzp1UOFaWxnK+dooeHbiVsxsx8r+1B5Pq5qBTBf8QtaBVz
	 FQszJe8DB8WjIXHxagvgqa/4YaH2JBig+2/IKh0W2+T+M0qAjHXFLPC0hBOAsB6933
	 MVq5JO5rhosxg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jameson Thies <jthies@google.com>,
	Benson Leung <bleung@chromium.org>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	"Kenneth R. Crudup" <kenny@panix.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] usb: typec: ucsi: psy: Set max current to zero when disconnected
Date: Mon,  1 Dec 2025 19:58:41 -0500
Message-ID: <20251202005841.1542822-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2025120117-clasp-fringe-f0f5@gregkh>
References: <2025120117-clasp-fringe-f0f5@gregkh>
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
index b7d16ad38c44c..5a8b62b69497f 100644
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


