Return-Path: <stable+bounces-211836-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OMacKPvMeGmNtQEAu9opvQ
	(envelope-from <stable+bounces-211836-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:34:35 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 40FF495CCC
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:34:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E461D300B9E8
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:34:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4C335CB89;
	Tue, 27 Jan 2026 14:34:22 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from metis.whiteo.stw.pengutronix.de (metis.whiteo.stw.pengutronix.de [185.203.201.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF78C35C1BD
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 14:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.203.201.7
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524462; cv=none; b=FYb6A60YhtyAxOhl1hk8Xd2B5/8kmM2WsjJ3EOCQj7iKX/Vz9tNsSlri6lO26thIM/EAKzTLELj4EEHmZ+T4DXiwYHxwt3lw9NgbxJwSfd95dZLW48cxBRsJ91l60KyYcQJRkoF4c7uQCT2XMGXiH2vdptuVVugC55GkelxU8ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524462; c=relaxed/simple;
	bh=uRuNyBAGyovwKDw/oME16eV5He7u/K6vXrm/jcAAzOE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWTN6+bBiJUUdu4IR0xKlIHjKPOz8b7doKpQAXTHJS0CjZGTXW+bpXwsb8EqI3roZqbobUEnb3boC7vVYhTL66mn7V1DMaguGniVbsB4NeTFKAQMbJXnEeyhLAf2dN3hFIOUbSbOFnOVYSUrmEvMsZZnngmWjBtmzSsCiAI1s1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; arc=none smtp.client-ip=185.203.201.7
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
	by metis.whiteo.stw.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
	(Exim 4.92)
	(envelope-from <mkl@pengutronix.de>)
	id 1vkk8t-0006za-A5; Tue, 27 Jan 2026 15:34:07 +0100
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1vkk8s-002lNk-18;
	Tue, 27 Jan 2026 15:34:05 +0100
Received: from blackshift.org (p54b15bf8.dip0.t-ipconnect.de [84.177.91.248])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 666B94D9633;
	Tue, 27 Jan 2026 14:34:05 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Brett A C Sheffield <bacs@librecast.net>,
	Slade Watkins <sr@sladewatkins.com>,
	Francesco Dolcini <francesco.dolcini@toradex.com>,
	Florian Fainelli <florian.fainelli@broadcom.com>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Ron Economos <re@w6rz.net>,
	Jon Hunter <jonathanh@nvidia.com>,
	Peter Schneider <pschneider1968@googlemail.com>,
	Mark Brown <broonie@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>
Subject: [PATCH 6.6.y] Linux 6.6.121
Date: Tue, 27 Jan 2026 15:34:02 +0100
Message-ID: <20260127143403.1428916-1-mkl@pengutronix.de>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026012715-dividers-displace-ed3c@gregkh>
References: <2026012715-dividers-displace-ed3c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.whiteo.stw.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: stable@vger.kernel.org
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	FREEMAIL_CC(0.00)[linuxfoundation.org,librecast.net,sladewatkins.com,toradex.com,broadcom.com,w6rz.net,nvidia.com,googlemail.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-211836-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[pengutronix.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mkl@pengutronix.de,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-0.932];
	TAGGED_RCPT(0.00)[stable];
	R_DKIM_NA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[pengutronix.de:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,nvidia.com:email,librecast.net:email,w6rz.net:email,broadcom.com:email]
X-Rspamd-Queue-Id: 40FF495CCC
X-Rspamd-Action: no action

From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Link: https://lore.kernel.org/r/20260115164146.312481509@linuxfoundation.org
Tested-by: Brett A C Sheffield <bacs@librecast.net>
Tested-by: Slade Watkins <sr@sladewatkins.com>
Tested-by: Francesco Dolcini <francesco.dolcini@toradex.com>
Tested-by: Florian Fainelli <florian.fainelli@broadcom.com>
Tested-by: Shuah Khan <skhan@linuxfoundation.org>
Tested-by: Ron Economos <re@w6rz.net>
Tested-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Peter Schneider <pschneider1968@googlemail.com>
Tested-by: Mark Brown <broonie@kernel.org>
Tested-by: Miguel Ojeda <ojeda@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Makefile b/Makefile
index 7f8d8816b8a9..79fa45c965fb 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 120
+SUBLEVEL = 121
 EXTRAVERSION =
 NAME = Pinguïn Aangedreven
 
-- 
2.51.0


