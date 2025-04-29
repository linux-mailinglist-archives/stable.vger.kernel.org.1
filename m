Return-Path: <stable+bounces-137724-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EDB24AA14E5
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 19:21:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56499984DB1
	for <lists+stable@lfdr.de>; Tue, 29 Apr 2025 17:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E77B62512D7;
	Tue, 29 Apr 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FHl1JFhG"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A47AE25228D;
	Tue, 29 Apr 2025 17:15:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745946936; cv=none; b=HvI8RfAXOsxee6/A/OolNVpoXhn1+IUtOTp2r382/uHS5TJQqGDQc6PjgqYdZ5JNaHSn8m0daELP+tsNQSWcl36FPTVlcPQ9t6BcWZIfiovlbPev1ESWQLQdj4DvbpMq19wFIK5VpwmZHpIERwUf+MThRk3YU29Dv+naXtRS8eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745946936; c=relaxed/simple;
	bh=ApYR7iKvJq/7behGoaG/ZfGA1x+R+wr1S29MmBxoKSY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gjUKTkLDFj46UsCCPIc7OrcDSkmDeYfH1i5vY/+UUCgvIVxgUn/FjwxmsHEMJohxbAxGwfD2Hcxzo6WpCf9CULjtaxb6U+vKPKNS91Tc9MJZuTZgk84NlP6Ms8Q4FLUYcCTZ20oQyP45MvStiGF8UJTt1HQqcu7pjdIye7vrufA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FHl1JFhG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC24C4CEE3;
	Tue, 29 Apr 2025 17:15:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1745946936;
	bh=ApYR7iKvJq/7behGoaG/ZfGA1x+R+wr1S29MmBxoKSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FHl1JFhGIBZoMFA04jjc+a0MDnVboj2Df06zEKG52AR/k6qT6nc3BmEuc+6sByiBB
	 QgVkOkQLkYwfvvAA2KoMaLVxtzVu6DtvtJt2pcGVoZsWOSVpcmUZz5lCYt7oqSALnz
	 dFzHnAICLvFo8JAfiFir4QmhooUrwHq0XOjf9DOo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Jonas Gorski <jonas.gorski@gmail.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 117/286] net: b53: enable BPDU reception for management port
Date: Tue, 29 Apr 2025 18:40:21 +0200
Message-ID: <20250429161112.669200669@linuxfoundation.org>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250429161107.848008295@linuxfoundation.org>
References: <20250429161107.848008295@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jonas Gorski <jonas.gorski@gmail.com>

[ Upstream commit 36355ddfe8955f226a88a543ed354b9f6b84cd70 ]

For STP to work, receiving BPDUs is essential, but the appropriate bit
was never set. Without GC_RX_BPDU_EN, the switch chip will filter all
BPDUs, even if an appropriate PVID VLAN was setup.

Fixes: ff39c2d68679 ("net: dsa: b53: Add bridge support")
Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
Link: https://patch.msgid.link/20250414200434.194422-1-jonas.gorski@gmail.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/dsa/b53/b53_common.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/net/dsa/b53/b53_common.c b/drivers/net/dsa/b53/b53_common.c
index 2fc33019e814a..d3428e62bef24 100644
--- a/drivers/net/dsa/b53/b53_common.c
+++ b/drivers/net/dsa/b53/b53_common.c
@@ -686,6 +686,15 @@ static void b53_enable_mib(struct b53_device *dev)
 	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
 }
 
+static void b53_enable_stp(struct b53_device *dev)
+{
+	u8 gc;
+
+	b53_read8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, &gc);
+	gc |= GC_RX_BPDU_EN;
+	b53_write8(dev, B53_MGMT_PAGE, B53_GLOBAL_CONFIG, gc);
+}
+
 static u16 b53_default_pvid(struct b53_device *dev)
 {
 	if (is5325(dev) || is5365(dev))
@@ -807,6 +816,7 @@ static int b53_switch_reset(struct b53_device *dev)
 	}
 
 	b53_enable_mib(dev);
+	b53_enable_stp(dev);
 
 	return b53_flush_arl(dev, FAST_AGE_STATIC);
 }
-- 
2.39.5




