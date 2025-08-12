Return-Path: <stable+bounces-167617-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BD4BCB230E4
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:57:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFA941892008
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:57:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1DFE2FA0DB;
	Tue, 12 Aug 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R0rIMQRk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E604268C73;
	Tue, 12 Aug 2025 17:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755021419; cv=none; b=Sqiz2w1DBDBV2LfrVBtOQfqpdnfCkNtwErpGLdYskqTu+xKOgL9pvdtHpINFSVPhvLFPOXz+uI3zkRfO4ssPvBq+3tvrCeVorVx74bHN4TvLID7lSemXq4rJfosFUMQkKvYiFt4Y3lRs3bYHoNGsss6GUYn7nv27oVHjzsFB4i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755021419; c=relaxed/simple;
	bh=g6L+DA5fOu7lZwevuJ1V9HPbpTIw11DuBkBcH02zN1Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=snoru4KUOA8X7i6bAqyLuGMRXNEZFozmsV3tLG7nR6x12IkRGwEaUDMkExeEwz5c4b//FXG33v+XXzGMZrdSGNJi8aURQ8swPOk2eYQuZvXgqZpyNs/Grgd9CCUfiy5CEHG8bCXmfDMyhq/gea1XUif4kDxC654d8tlh/4lKpS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R0rIMQRk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0C7EC4CEF0;
	Tue, 12 Aug 2025 17:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755021419;
	bh=g6L+DA5fOu7lZwevuJ1V9HPbpTIw11DuBkBcH02zN1Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=R0rIMQRktirpijaY6geLFAAJxb9J1HtFz3Ivu4LE9Mx6G/gqAwEtSk0AdGqKT5UZS
	 6IDcU2XtBeSFLXVjpwzX5gQVuAml+DkN877/JwQK8PeBwZcFnT/01beYTwbQNT0EBJ
	 WMChq7Di4wKtfZzsSgmkS4bcebH1BR9MEXQSXfyw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Charles Han <hanchunchao@inspur.com>,
	Sebastian Reichel <sebastian.reichel@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6 115/262] power: supply: cpcap-charger: Fix null check for power_supply_get_by_name
Date: Tue, 12 Aug 2025 19:28:23 +0200
Message-ID: <20250812172957.999143201@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172952.959106058@linuxfoundation.org>
References: <20250812172952.959106058@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Han <hanchunchao@inspur.com>

[ Upstream commit d9fa3aae08f99493e67fb79413c0e95d30fca5e9 ]

In the cpcap_usb_detect() function, the power_supply_get_by_name()
function may return `NULL` instead of an error pointer.
To prevent potential null pointer dereferences, Added a null check.

Fixes: eab4e6d953c1 ("power: supply: cpcap-charger: get the battery inserted infomation from cpcap-battery")
Signed-off-by: Charles Han <hanchunchao@inspur.com>
Link: https://lore.kernel.org/r/20250519024741.5846-1-hanchunchao@inspur.com
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/power/supply/cpcap-charger.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/power/supply/cpcap-charger.c b/drivers/power/supply/cpcap-charger.c
index be9764541d52..05a3f4b208a4 100644
--- a/drivers/power/supply/cpcap-charger.c
+++ b/drivers/power/supply/cpcap-charger.c
@@ -689,9 +689,8 @@ static void cpcap_usb_detect(struct work_struct *work)
 		struct power_supply *battery;
 
 		battery = power_supply_get_by_name("battery");
-		if (IS_ERR_OR_NULL(battery)) {
-			dev_err(ddata->dev, "battery power_supply not available %li\n",
-					PTR_ERR(battery));
+		if (!battery) {
+			dev_err(ddata->dev, "battery power_supply not available\n");
 			return;
 		}
 
-- 
2.39.5




