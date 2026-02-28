Return-Path: <stable+bounces-220310-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOIGMh43o2lh+gQAu9opvQ
	(envelope-from <stable+bounces-220310-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:38 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B111C628C
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8631D3082007
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:08:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CC9B38F630;
	Sat, 28 Feb 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GZGczUG8"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5042438F65B;
	Sat, 28 Feb 2026 17:36:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300213; cv=none; b=afbpbkya8qobZeZZgqMT22oK0mwzPSTxwSXR+N5UbONSShQ3lWL07fQsAthIb0lZ26Z5pQ1ZdqZSilo3MuBH0C7eWXk51mNMn0REe4Y3POJ2mZ3zJR9c1Z8bsA8S8MCiVbfZqrYEYWfmzgQ9Uas2DoL9YpX5VzfWGIYNBGfgX0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300213; c=relaxed/simple;
	bh=YXhinGD2EShjI+Ju96y5fdmzoeygDql3kCvvn3JTisw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PIeaF1PZzwOXwpiFsvS4P8bh8rzsGzIG9+5fWolZ4SS81lw2o1dxFKi9BaFacLw+zqzhpkNpxijIdQyha9O5g/SGeYF5M9M8DMHg1ZK7TYUb0ityGk0xvUeiK9oz8/lF7KQYtcg03gqPZ0iKZypD7pMlSlx7Q6AID4GseF66EhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GZGczUG8; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56356C116D0;
	Sat, 28 Feb 2026 17:36:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300212;
	bh=YXhinGD2EShjI+Ju96y5fdmzoeygDql3kCvvn3JTisw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GZGczUG8QAjwg395hLs6ICEvGHArEzbcUniKBpUuRivsdy7HJML5+ncBVtcCI5y8y
	 1v/c/DSCqKUs9f+ULJSbmoPsxGTx9GSQ5Y3xo+LAVsEeozoHhRDSZZAv4VO5UDJFeM
	 Dn6ExIZz0o/Swaii3Li3YjzMmPIEhqiDYIB+oDf9TEJdZzwb0O/35Kl6sBtEkRUq4H
	 8tm12TEvE3HrAnA5SY+vl1N5JdpxfWEWMeYi0V6TmwIrmm111+NChbQZB8D2/EdQBg
	 X8ZwNEi/JsKHOeIup39inq+nMPRp905oV10bJ2tJx5XlK3bAisqWSeTRa+lyOJP1mY
	 5Kn39wPhtLs4g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 232/844] hwmon: (f71882fg) Add F81968 support
Date: Sat, 28 Feb 2026 12:22:25 -0500
Message-ID: <20260228173244.1509663-233-sashal@kernel.org>
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
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220310-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: C0B111C628C
X-Rspamd-Action: no action

From: "Ji-Ze Hong (Peter Hong)" <peter_hong@fintek.com.tw>

[ Upstream commit e4a3d6f79c9933fece64368168c46d6cf5fc2e52 ]

Add hardware monitoring support for the Fintek F81968 Super I/O chip.
It is fully compatible with F81866.

Several products share compatibility with the F81866. To better distinguish
between them, ensure that the Product ID is displayed when the device is
probed.

Signed-off-by: Ji-Ze Hong (Peter Hong) <peter_hong@fintek.com.tw>
Link: https://lore.kernel.org/r/20251223051040.10227-1-peter_hong@fintek.com.tw
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/f71882fg.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/hwmon/f71882fg.c b/drivers/hwmon/f71882fg.c
index df83f9866fbcf..204059d2de6cd 100644
--- a/drivers/hwmon/f71882fg.c
+++ b/drivers/hwmon/f71882fg.c
@@ -51,6 +51,7 @@
 #define SIO_F81866_ID		0x1010	/* Chipset ID */
 #define SIO_F71858AD_ID		0x0903	/* Chipset ID */
 #define SIO_F81966_ID		0x1502	/* Chipset ID */
+#define SIO_F81968_ID		0x1806	/* Chipset ID */
 
 #define REGION_LENGTH		8
 #define ADDR_REG_OFFSET		5
@@ -2570,6 +2571,7 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
 		break;
 	case SIO_F81866_ID:
 	case SIO_F81966_ID:
+	case SIO_F81968_ID:
 		sio_data->type = f81866a;
 		break;
 	default:
@@ -2599,9 +2601,9 @@ static int __init f71882fg_find(int sioaddr, struct f71882fg_sio_data *sio_data)
 	address &= ~(REGION_LENGTH - 1);	/* Ignore 3 LSB */
 
 	err = address;
-	pr_info("Found %s chip at %#x, revision %d\n",
+	pr_info("Found %s chip at %#x, revision %d, devid: %04x\n",
 		f71882fg_names[sio_data->type],	(unsigned int)address,
-		(int)superio_inb(sioaddr, SIO_REG_DEVREV));
+		(int)superio_inb(sioaddr, SIO_REG_DEVREV), devid);
 exit:
 	superio_exit(sioaddr);
 	return err;
-- 
2.51.0


