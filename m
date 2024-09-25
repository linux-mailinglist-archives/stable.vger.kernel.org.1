Return-Path: <stable+bounces-77620-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7125F985F32
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 15:52:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A25EF1C25E37
	for <lists+stable@lfdr.de>; Wed, 25 Sep 2024 13:52:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CEAF2207F1;
	Wed, 25 Sep 2024 12:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="vA0IIIfV"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB50B2207E5;
	Wed, 25 Sep 2024 12:14:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727266498; cv=none; b=TazMlpOMFK6zwZh29JsKqrryO7Kc4KXo3ouY0Cx6rszqA2aNWSme73FY0aQc1JPyagA1hBCP/NInLvH1qDveh2hPQE0Mu8nzCrrj+/pGphrhnX89AB7F/BD6pLqMLAy4CN/j8oCx0qu6aBQld06PCEMFcyRmMHywT6OvzVFR5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727266498; c=relaxed/simple;
	bh=84Rhq/UE1HwUGX63uMq0z2ShlifERp66qxV0V3E24gM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ddi8ifj+oWQbl9QI5dLTZo/cGalgbjZVAZ//ySaYrzHFVf4A2W69zZ3Qo2djtgsV/Nhlu4C5RLYXleBS/uEmakHj4eb/VsDHBQUJUo7KCySLPlrPOudMd+iDDGKILt3UZQkXe2sMfMENSMLt8Krbsin0LpMhzt0MGOV1YKREfFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=vA0IIIfV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64D6DC4CEC7;
	Wed, 25 Sep 2024 12:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727266497;
	bh=84Rhq/UE1HwUGX63uMq0z2ShlifERp66qxV0V3E24gM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vA0IIIfVLNxkuHBrI3PcJg8207RYJl6vCi58pzpyrvk35g+ukoshBOcZjMtnFPYuZ
	 T397me+otCGC7z69wUqLcc00Gh9H3A1mTwpK4ai1dYbHO+q1OCKwSQfsfqVHGGgFya
	 7vU3pWnVnSFkZ2RjUSLGwzXlPsneN2X2Hf3016yUI2kf8tfRri0jayv3iWZMl8+xET
	 W2vGSDXqmoJddHT63p8rx3qDZD6iL8cb2r763sIx3g+PTGDkUFuNIO5QT87+pQhuJV
	 cq3dHzgOgER0WS4dczETve6Ql8MWyf3S72aoEED9AGUL68q5anVzp1GA65k0zMUb3M
	 TRu79aVtK1EwQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Denis Pauk <pauk.denis@gmail.com>,
	Attila <attila@fulop.one>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>,
	jdelvare@suse.com,
	linux-hwmon@vger.kernel.org
Subject: [PATCH AUTOSEL 6.6 073/139] hwmon: (nct6775) add G15CF to ASUS WMI monitoring list
Date: Wed, 25 Sep 2024 08:08:13 -0400
Message-ID: <20240925121137.1307574-73-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240925121137.1307574-1-sashal@kernel.org>
References: <20240925121137.1307574-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.52
Content-Transfer-Encoding: 8bit

From: Denis Pauk <pauk.denis@gmail.com>

[ Upstream commit 1f432e4cf1dd3ecfec5ed80051b4611632a0fd51 ]

Boards G15CF has got a nct6775 chip, but by default there's no use of it
because of resource conflict with WMI method.

Add the board to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Attila <attila@fulop.one>
Message-ID: <20240812152652.1303-1-pauk.denis@gmail.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index 81bf03dad6bbc..706a662dd077d 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1269,6 +1269,7 @@ static const char * const asus_msi_boards[] = {
 	"EX-B760M-V5 D4",
 	"EX-H510M-V3",
 	"EX-H610M-V3 D4",
+	"G15CF",
 	"PRIME A620M-A",
 	"PRIME B560-PLUS",
 	"PRIME B560-PLUS AC-HES",
-- 
2.43.0


