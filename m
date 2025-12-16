Return-Path: <stable+bounces-202651-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FC46CC35A6
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 14:52:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E386B30A321E
	for <lists+stable@lfdr.de>; Tue, 16 Dec 2025 13:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6453B37C11E;
	Tue, 16 Dec 2025 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="iFGC5wz3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057CA37C11A;
	Tue, 16 Dec 2025 12:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765888597; cv=none; b=I8xD85srtLk1NCbyR8qY51umVdZFIfbzHeBIAOXkFIWsaXBH50LY4BtTTqmcSRHdjnWnMVvRmrXcQwIU/4jQrCgXdFOIi3RIgpcILYmBWAIMAFyMU4Gc/ngbChkoop6CUfZK8LmqL1pUokXJdHPZJaEZGU798IrxWSNgark1MRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765888597; c=relaxed/simple;
	bh=yLF8SPy09RRIb2fnFSatR3E+KytTqyC/gUZL51miT8E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LHgohLb1JLIEuf5l1jIjBI7ohLmS6BhrZ7vMioD4Gp8PdATlp8ZMACIZqlUsR4TVQZ+7E+ByPoXRiyOgoQQY7Gi2ruZplQ38lvJEt5soY3Cq5HtRvpnKeiOtrUfUqI2Y//4UtDk1uvWKof44J7njcOUPSix2NDZAEwWkLUnn+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=iFGC5wz3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 613FFC4CEF1;
	Tue, 16 Dec 2025 12:36:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1765888596;
	bh=yLF8SPy09RRIb2fnFSatR3E+KytTqyC/gUZL51miT8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iFGC5wz3TidWE9JEhXFtm6atvz+xt5a1OiHL+sJXWzuOCJfNg8IbykNXQqHTsUoDz
	 OpELbjnORhizqgM+d2pqfYmlMSWQmReTjq1kJlzpUBwS5GsgaK68RxIbf/A2ay7coJ
	 W3agfJpB3dJX9r1L0ykH9/QOTd1KnQHcUJNzImdc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18 581/614] rtc: max31335: Fix ignored return value in set_alarm
Date: Tue, 16 Dec 2025 12:15:48 +0100
Message-ID: <20251216111422.438305072@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251216111401.280873349@linuxfoundation.org>
References: <20251216111401.280873349@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nuno Sá <nuno.sa@analog.com>

[ Upstream commit f07640f9fb8df2158199da1da1f8282948385a84 ]

Return the result from regmap_update_bits() instead of ignoring it
and always returning 0.

Fixes: dedaf03b99d6 ("rtc: max31335: add driver support")
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Link: https://patch.msgid.link/20251128-max31335-handler-error-v1-1-6b6f7f78dbda@analog.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-max31335.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/rtc/rtc-max31335.c b/drivers/rtc/rtc-max31335.c
index dfb5bad3a3691..23b7bf16b4cd5 100644
--- a/drivers/rtc/rtc-max31335.c
+++ b/drivers/rtc/rtc-max31335.c
@@ -391,10 +391,8 @@ static int max31335_set_alarm(struct device *dev, struct rtc_wkalrm *alrm)
 	if (ret)
 		return ret;
 
-	ret = regmap_update_bits(max31335->regmap, max31335->chip->int_status_reg,
-				 MAX31335_STATUS1_A1F, 0);
-
-	return 0;
+	return regmap_update_bits(max31335->regmap, max31335->chip->int_status_reg,
+				  MAX31335_STATUS1_A1F, 0);
 }
 
 static int max31335_alarm_irq_enable(struct device *dev, unsigned int enabled)
-- 
2.51.0




