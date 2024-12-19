Return-Path: <stable+bounces-105315-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 098A29F7F8C
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 17:24:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E1DC16274A
	for <lists+stable@lfdr.de>; Thu, 19 Dec 2024 16:24:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E39522A80A;
	Thu, 19 Dec 2024 16:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b="CpNR1OJT"
X-Original-To: stable@vger.kernel.org
Received: from forwardcorp1b.mail.yandex.net (forwardcorp1b.mail.yandex.net [178.154.239.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49D2288E5;
	Thu, 19 Dec 2024 16:22:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734625327; cv=none; b=O33U6f9YWBqRtDMacwSkWm8EMhSi0y9Q2X7t2pplCA/1HewTmbyd6kviUbZjvpVjyLq2b7SQh26LhkYoGESoVnRqTaiJdIlJhH79hgekfFiDsIIUxY25QOqzprhH53ODxz5IAeNukoykHNVWZOveUtmbsk3Kf0kIHvJRsB9/9gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734625327; c=relaxed/simple;
	bh=eoT3hYSWOt04Fah9DMV+xiBDwTAmeZ3TdRd1eAC5COQ=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=JcWGMcQaeHCi54afKE3LpChvX1iRyhZfKInpUhL29viPuiqlxKYq4A77mXmgtszoC702WkqJseX7qN0nG+oIe/xhm/vaguqlE/c04YiHwW1W1doP/sh/iXL8QQRDviFYFheuGiXyHplTazP3+RpM9fljkP+L7DVNvowanhLsS4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru; spf=pass smtp.mailfrom=yandex-team.ru; dkim=pass (1024-bit key) header.d=yandex-team.ru header.i=@yandex-team.ru header.b=CpNR1OJT; arc=none smtp.client-ip=178.154.239.136
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex-team.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex-team.ru
Received: from mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net [IPv6:2a02:6b8:c0c:a1f:0:640:ba2e:0])
	by forwardcorp1b.mail.yandex.net (Yandex) with ESMTPS id 1817E60E94;
	Thu, 19 Dec 2024 19:21:58 +0300 (MSK)
Received: from kniv-nix.yandex-team.ru (unknown [2a02:6b8:b081:8104::1:2c])
	by mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net (smtpcorp/Yandex) with ESMTPSA id jLV8H32IkKo0-spD1uvcw;
	Thu, 19 Dec 2024 19:21:57 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex-team.ru;
	s=default; t=1734625317;
	bh=86uF8z9q8RfEa7z7ymSGoeaNjFcJEcHXRQPm5ok7o+w=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=CpNR1OJT7377vXm4IW+ayYb70xlilV+FrV+o8ehvWulRTYfkupFhuEPWG4TbVJTQI
	 otXtMEK0unW3f37i0cGVXO9aypwDTqdHJhPaVbCB29ZS9emWWGFc/0ZtzzUZiHna2B
	 oNCmvfz635IeOWkarwUKX9l6jsRx/sWwmeVVsbho=
Authentication-Results: mail-nwsmtp-smtp-corp-main-66.iva.yp-c.yandex.net; dkim=pass header.i=@yandex-team.ru
From: Nikolay Kuratov <kniv@yandex-team.ru>
To: linux-kernel@vger.kernel.org
Cc: netdev@vger.kernel.org,
	linux-sctp@vger.kernel.org,
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>,
	Xin Long <lucien.xin@gmail.com>,
	Xi Wang <xi.wang@gmail.com>,
	Neil Horman <nhorman@tuxdriver.com>,
	Vlad Yasevich <vyasevich@gmail.com>,
	Nikolay Kuratov <kniv@yandex-team.ru>,
	stable@vger.kernel.org
Subject: [PATCH] net/sctp: Prevent autoclose integer overflow in sctp_association_init()
Date: Thu, 19 Dec 2024 19:21:14 +0300
Message-Id: <20241219162114.2863827-1-kniv@yandex-team.ru>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

While by default max_autoclose equals to INT_MAX / HZ, one may set
net.sctp.max_autoclose to UINT_MAX. There is code in
sctp_association_init() that can consequently trigger overflow.

Cc: stable@vger.kernel.org
Fixes: 9f70f46bd4c7 ("sctp: properly latch and use autoclose value from sock to association")
Signed-off-by: Nikolay Kuratov <kniv@yandex-team.ru>
---
 net/sctp/associola.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/sctp/associola.c b/net/sctp/associola.c
index c45c192b7878..0b0794f164cf 100644
--- a/net/sctp/associola.c
+++ b/net/sctp/associola.c
@@ -137,7 +137,8 @@ static struct sctp_association *sctp_association_init(
 		= 5 * asoc->rto_max;
 
 	asoc->timeouts[SCTP_EVENT_TIMEOUT_SACK] = asoc->sackdelay;
-	asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] = sp->autoclose * HZ;
+	asoc->timeouts[SCTP_EVENT_TIMEOUT_AUTOCLOSE] =
+		(unsigned long)sp->autoclose * HZ;
 
 	/* Initializes the timers */
 	for (i = SCTP_EVENT_TIMEOUT_NONE; i < SCTP_NUM_TIMEOUT_TYPES; ++i)
-- 
2.34.1


