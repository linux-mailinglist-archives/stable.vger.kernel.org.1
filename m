Return-Path: <stable+bounces-54811-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753769124FE
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 14:18:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E044EB23E39
	for <lists+stable@lfdr.de>; Fri, 21 Jun 2024 12:18:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 82B461534FC;
	Fri, 21 Jun 2024 12:17:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AFA314F9EE
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 12:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718972271; cv=none; b=FSL1UpxZy68+jjsMAocKorItR3qusHatI0YuB0LQ6j1EZHVJBk5WcxDWEYRrXf0XKmsUTtmWiUxS0pBScqEPPhfRf10mtpUkXg9HsLZRgZGfzHINPSFc9P/vX1kIRkMufBAzscn9N3/42nT1MKrIEf+OSIYPMCqRFji+E6hv9tk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718972271; c=relaxed/simple;
	bh=4TNEajhmxtz6qltSapQzxekRO3DR6xrS6qCR8FNRgec=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R3jiqKxn0E5N84zJxLDP2JR2i2kCGF6dmOQLpKNmTXLUxzrwyYlPhb0NUooDm3jftUUy9DGqmU3AqnUTUL5W0XCxWCHHOydhk4ABz4W/oFYY/twQ9YJ5UWPA5w/oALtaHxTXCqPZZQOD7e4QRpctv0ZwZLsMGXwhYCIVVZHoW1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKdD8-0002QD-Pw
	for stable@vger.kernel.org; Fri, 21 Jun 2024 14:17:46 +0200
Received: from [2a0a:edc0:0:b01:1d::7b] (helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <mkl@pengutronix.de>)
	id 1sKdD7-003wFh-Ji
	for stable@vger.kernel.org; Fri, 21 Jun 2024 14:17:45 +0200
Received: from dspam.blackshift.org (localhost [127.0.0.1])
	by bjornoya.blackshift.org (Postfix) with SMTP id 47F622EE838
	for <stable@vger.kernel.org>; Fri, 21 Jun 2024 12:17:45 +0000 (UTC)
Received: from hardanger.blackshift.org (unknown [172.20.34.65])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	by bjornoya.blackshift.org (Postfix) with ESMTPS id F15FE2EE80C;
	Fri, 21 Jun 2024 12:17:42 +0000 (UTC)
Received: from blackshift.org (localhost [::1])
	by hardanger.blackshift.org (OpenSMTPD) with ESMTP id e45de929;
	Fri, 21 Jun 2024 12:17:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Oleksij Rempel <o.rempel@pengutronix.de>,
	stable@vger.kernel.org,
	=?UTF-8?q?Alexander=20H=C3=B6lzl?= <alexander.hoelzl@gmx.net>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 3/5] net: can: j1939: recover socket queue on CAN bus error during BAM transmission
Date: Fri, 21 Jun 2024 13:23:38 +0200
Message-ID: <20240621121739.434355-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240621121739.434355-1-mkl@pengutronix.de>
References: <20240621121739.434355-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org

From: Oleksij Rempel <o.rempel@pengutronix.de>

Addresses an issue where a CAN bus error during a BAM transmission
could stall the socket queue, preventing further transmissions even
after the bus error is resolved. The fix activates the next queued
session after the error recovery, allowing communication to continue.

Fixes: 9d71dd0c70099 ("can: add support of SAE J1939 protocol")
Cc: stable@vger.kernel.org
Reported-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
Tested-by: Alexander Hölzl <alexander.hoelzl@gmx.net>
Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
Link: https://lore.kernel.org/all/20240528070648.1947203-1-o.rempel@pengutronix.de
Cc: stable@vger.kernel.org
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 net/can/j1939/transport.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/can/j1939/transport.c b/net/can/j1939/transport.c
index c6569f98d251..4be73de5033c 100644
--- a/net/can/j1939/transport.c
+++ b/net/can/j1939/transport.c
@@ -1696,6 +1696,8 @@ static int j1939_xtp_rx_rts_session_active(struct j1939_session *session,
 
 		j1939_session_timers_cancel(session);
 		j1939_session_cancel(session, J1939_XTP_ABORT_BUSY);
+		if (session->transmission)
+			j1939_session_deactivate_activate_next(session);
 
 		return -EBUSY;
 	}
-- 
2.43.0



