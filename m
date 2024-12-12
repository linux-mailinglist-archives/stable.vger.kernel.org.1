Return-Path: <stable+bounces-102080-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BB4CE9EF0D8
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 17:32:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E76F1165DBE
	for <lists+stable@lfdr.de>; Thu, 12 Dec 2024 16:21:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31FC7239BAC;
	Thu, 12 Dec 2024 16:11:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o/fA4KhL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3660239BA3;
	Thu, 12 Dec 2024 16:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734019893; cv=none; b=soUx6jnjqBEjpmFOaepHmJFmvwlIqt6vjOlWefRh5zNqURCgT+IEbXSXwA9kuAWe2JD596LGsHZtVkojKqeL/tDkoCVVucgLAkaYwvesVa9KSwVnXRaUX2STktG9GzRIzDXJqpK7KZFjfSOW13xQxsJ4Y3btWlhldEtravwK3Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734019893; c=relaxed/simple;
	bh=jS970s8lrTKaCZJjbmeYIqGsg+eXa8KjpPS2dZrUW0o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kmX/okOSlEbghru4ELy4byUs+7biHK2Tg5dDdjBwG7NOcIZxvS5p5MKw+flSsA+MU3RjdRkYmO/QP3m1V65viYipvvvCjTaoQPXDfdYuJLfW2bmSHR8vwhMCTcj3sax+qXdrnKpGIN4OEU1RrJVT93HkVv/EHB91LIRnv0Grovs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o/fA4KhL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52331C4CECE;
	Thu, 12 Dec 2024 16:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1734019892;
	bh=jS970s8lrTKaCZJjbmeYIqGsg+eXa8KjpPS2dZrUW0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=o/fA4KhL91TydEUc0SIb1f84XEmG2bykvOIPy578h4CQdRCFOzsTC0bZkRXEYm2zu
	 L6efYnqFt6nUmTN/ukC1/PJ1PwShZJ8rIfNyP27SxR2uNTl3cRuaEaCrPAvXvFS/sw
	 HvoksOAlcLwkcakIoMjAwSMsYdlX5OYFNkZ/ZdJo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Murad Masimov <m.masimov@maxima.ru>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 295/772] hwmon: (tps23861) Fix reporting of negative temperatures
Date: Thu, 12 Dec 2024 15:54:00 +0100
Message-ID: <20241212144402.089876836@linuxfoundation.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241212144349.797589255@linuxfoundation.org>
References: <20241212144349.797589255@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Murad Masimov <m.masimov@maxima.ru>

[ Upstream commit de2bf507fabba9c0c678cf5ed54beb546f5ca29a ]

Negative temperatures are reported as large positive temperatures
due to missing sign extension from unsigned int to long. Cast unsigned
raw register values to signed before performing the calculations
to fix the problem.

Found by Linux Verification Center (linuxtesting.org) with SVACE.

Fixes: fff7b8ab2255 ("hwmon: add Texas Instruments TPS23861 driver")
Signed-off-by: Murad Masimov <m.masimov@maxima.ru>
Message-ID: <20241121173604.2021-1-m.masimov@maxima.ru>
[groeck: Updated subject and description]
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/tps23861.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hwmon/tps23861.c b/drivers/hwmon/tps23861.c
index 68c77c4932700..152e3c1c5c5fa 100644
--- a/drivers/hwmon/tps23861.c
+++ b/drivers/hwmon/tps23861.c
@@ -132,7 +132,7 @@ static int tps23861_read_temp(struct tps23861_data *data, long *val)
 	if (err < 0)
 		return err;
 
-	*val = (regval * TEMPERATURE_LSB) - 20000;
+	*val = ((long)regval * TEMPERATURE_LSB) - 20000;
 
 	return 0;
 }
-- 
2.43.0




