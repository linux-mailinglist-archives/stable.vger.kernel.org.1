Return-Path: <stable+bounces-136829-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37E39A9EB45
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 10:57:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4E8A43BB9A1
	for <lists+stable@lfdr.de>; Mon, 28 Apr 2025 08:57:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 266601FFC45;
	Mon, 28 Apr 2025 08:57:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FY2xfH9p"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DABAB18CC15
	for <stable@vger.kernel.org>; Mon, 28 Apr 2025 08:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745830670; cv=none; b=hlTtFHG4+TXpta+jgbqAIFzcdb2UPTi7hABuRmSQ4OXvs8Oc5uIX5FlCVio/dJ71NoVu0snAtJIN7cHdzGZLbhK6dKbJVpZjp6NsBiD3oVhH54thlrW2++nZ1LhVK9UetaE4uP8Jkwpz2c0XgSiqwiqUyzysNAEDAPKqnve861s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745830670; c=relaxed/simple;
	bh=Jmgqqhj0/jOYgrfSrf8YuheevSt/cs0mE+NhGV5CLQ0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=d3Bfxx1XAzUZO3gtbRI6ZA486iQX4gHxZggOG4KR1rFMyynOc9KGdsTX4aScR0HTW3H1z5bjD3nvaAMACTROvAMlR/U6awSJ9vIeK6suTlXC0szvlwBkz8HydoeR41rxNoUGDbvIIeCumqUSUS3CZwpfUD7SJaokPcHexDJhhpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FY2xfH9p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97BD9C4CEE4;
	Mon, 28 Apr 2025 08:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745830670;
	bh=Jmgqqhj0/jOYgrfSrf8YuheevSt/cs0mE+NhGV5CLQ0=;
	h=From:To:Cc:Subject:Date:From;
	b=FY2xfH9peHK5o3LPPHx22/CVAHY5gxjhlS/fHd6uUzTzUumHTFaxawc1mzrx2j/RV
	 7xeKTBy/pBSCL5TbubLDoAVTufxGI5Ji89X232RTw8T88SPDDXxG+HBemv+JHTD631
	 q9YzgM1Y46BhUUuJndYA/WEeHu1rDqQwOrl0GZYSGiyXfD+zr84GtDkni6IYFUuU1g
	 ktB4PMAD39NFUgjNBKSt6fhQfekQVgLb1iOZ7T1KQgUWCmVmC/ndhWglovRmXzay/G
	 +MeWbAmt9C3Sbmt3ENbwXByt8PA0ZuoGtBTdKa2LK0H0hDVpcRnABAqBabZNcQkRYt
	 SpeHTSKgHf+4w==
From: =?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>
To: stable@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>
Cc: Andrew Lunn <andrew@lunn.ch>,
	Vladimir Oltean <olteanv@gmail.com>,
	Eric Dumazet <edumazet@google.com>,
	=?UTF-8?q?Marek=20Beh=C3=BAn?= <kabel@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.10.y 1/3] net: dsa: mv88e6xxx: fix atu_move_port_mask for 6341 family
Date: Mon, 28 Apr 2025 10:57:42 +0200
Message-ID: <20250428085744.19762-1-kabel@kernel.org>
X-Mailer: git-send-email 2.49.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

commit 4ae01ec007716986e1a20f1285eb013cbf188830 upstream.

The atu_move_port_mask for 6341 family (Topaz) is 0xf, not 0x1f. The
PortVec field is 8 bits wide, not 11 as in 6390 family. Fix this.

Fixes: e606ca36bbf2 ("net: dsa: mv88e6xxx: rework ATU Remove")
Signed-off-by: Marek Behún <kabel@kernel.org>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Link: https://patch.msgid.link/20250317173250.28780-3-kabel@kernel.org
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
---
 drivers/net/dsa/mv88e6xxx/chip.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/net/dsa/mv88e6xxx/chip.c b/drivers/net/dsa/mv88e6xxx/chip.c
index ebc858087394..d583052af26c 100644
--- a/drivers/net/dsa/mv88e6xxx/chip.c
+++ b/drivers/net/dsa/mv88e6xxx/chip.c
@@ -4679,7 +4679,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
@@ -5085,7 +5085,7 @@ static const struct mv88e6xxx_info mv88e6xxx_table[] = {
 		.global1_addr = 0x1b,
 		.global2_addr = 0x1c,
 		.age_time_coeff = 3750,
-		.atu_move_port_mask = 0x1f,
+		.atu_move_port_mask = 0xf,
 		.g1_irqs = 9,
 		.g2_irqs = 10,
 		.pvt = true,
-- 
2.49.0


