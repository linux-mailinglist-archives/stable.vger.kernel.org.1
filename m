Return-Path: <stable+bounces-220307-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6L6aMeY0o2kI+gQAu9opvQ
	(envelope-from <stable+bounces-220307-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E9801C5F1F
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:33:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EDD0833D311D
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C249338D915;
	Sat, 28 Feb 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hFnrKUxT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8560E38D90C;
	Sat, 28 Feb 2026 17:36:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300210; cv=none; b=MWV/wQNiFrcfPQ1fsUQMSPAHm1ecn56nEP25wj4/xonCAUVubFnSDctWccnD34AZO1EQ2JgeSQE66vxoFOx4cbNtfBHQIR5AgQSZovsSX/lT1q5O4LNme7kAIycm8gBP8weFrYJE4ecX9aF+O6QgSz3nTvI0H7n/029Sin0GLpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300210; c=relaxed/simple;
	bh=pT+LdLV3yEuY57fuDBK1byh/uEypzVof9WiEIGMjNPk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T4EPceZpQdvYd+GxoskhgOap60w4hm0rAenFk6ixYy5raHKw5t/eemtjs77QpAbZLJbUsJV3XQg7d9BmOihntBF0Nz/i/gtnayyUCIvn3qzclky/GU6zy9PMlZaQJCYbRot5ZUNwrzRixdJq5184j5a9q1CZiaGV8QMZtCHZf1Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hFnrKUxT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B3A61C19425;
	Sat, 28 Feb 2026 17:36:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300210;
	bh=pT+LdLV3yEuY57fuDBK1byh/uEypzVof9WiEIGMjNPk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=hFnrKUxTLq0s7ZfHg6aFKD6rYXu/0VAzMm+RPvyHkMXBrj1TTbHHPajMrhiOQngY/
	 0NxVSJXkrK//loGEgV5VbUra6kdsX5UrQJRk5FtQQxkgMjfBnvIhnZ4B1i4Eaifumm
	 AjtABQwXpGjbJtWk3sfOHXAJRUHfFbWM1yNSOR8q7p0W4g+BHz44PPlZGfX6p+LUzw
	 JOadpiZxxWoYghToxQINYGiYr7a2bhQ9h0grYsWkpspSdE4CotrV2/0OvQ264hWqpH
	 HR9a66q2I5nfZp9vp5mC8qEGhJ0EjdnBi/EXfYBJYbeSQX1H3PsDDGR2IzMvunf37Q
	 53i6dwyaYsK0A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Denis Pauk <pauk.denis@gmail.com>,
	Marcus <shoes2ga@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 229/844] hwmon: (nct6775) Add ASUS Pro WS WRX90E-SAGE SE
Date: Sat, 28 Feb 2026 12:22:22 -0500
Message-ID: <20260228173244.1509663-230-sashal@kernel.org>
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
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-220307-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,roeck-us.net,kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 1E9801C5F1F
X-Rspamd-Action: no action

From: Denis Pauk <pauk.denis@gmail.com>

[ Upstream commit 246167b17c14e8a5142368ac6457e81622055e0a ]

Boards Pro WS WRX90E-SAGE SE has got a nct6775 chip, but by default there's
no use of it because of resource conflict with WMI method.

Add the board to the WMI monitoring list.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=204807
Signed-off-by: Denis Pauk <pauk.denis@gmail.com>
Tested-by: Marcus <shoes2ga@gmail.com>
Link: https://lore.kernel.org/r/20251231155316.2048-1-pauk.denis@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/nct6775-platform.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/nct6775-platform.c b/drivers/hwmon/nct6775-platform.c
index c3a719aef1ace..555029dfe713f 100644
--- a/drivers/hwmon/nct6775-platform.c
+++ b/drivers/hwmon/nct6775-platform.c
@@ -1357,6 +1357,7 @@ static const char * const asus_msi_boards[] = {
 	"Pro WS W680-ACE IPMI",
 	"Pro WS W790-ACE",
 	"Pro WS W790E-SAGE SE",
+	"Pro WS WRX90E-SAGE SE",
 	"ProArt B650-CREATOR",
 	"ProArt B660-CREATOR D4",
 	"ProArt B760-CREATOR D4",
-- 
2.51.0


