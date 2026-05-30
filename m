Return-Path: <stable+bounces-257669-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yyfAOR0eG2q4/QgAu9opvQ
	(envelope-from <stable+bounces-257669-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:27:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 464E860FB71
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6271C3020E83
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:22:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7421332EA7;
	Sat, 30 May 2026 17:22:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MK05k2Dk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9154263F44;
	Sat, 30 May 2026 17:22:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780161777; cv=none; b=N+5qIdlqVutuuB7k+DCmOTdNw6prj/qr5dCPe6G9bfUYsy/Ta5TUQOFwes/kQe1TUGl/UsqL4V3Rnm2zClOcC3HfA0h1TfpxobiyBajB6/r+bVuzMw2Wp+crPVM0f1KPe2OIEXb/7eH/bK+7fjRC/ufWIOW4y2+N1JAJT/BD1wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780161777; c=relaxed/simple;
	bh=LpG6BxQR6pd8YpC8Mry0LeOkKLqOW8X1tZLdZj+nrI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ihtc2HHfKsHkw2aOSuZlwDuI4ff/IzScChy6ZIVrvh+DSsFhwdHA6GkP/MfhG5yNkYtr3r7AcpWFUT0RRs23WBtBDtml/OGEXx1pshqv14YkpViY+v8ce/UxFIwZp+eLuLlUVsn2mo+M2je+XYBa52NglPO2ziKIgv1zBW4JH6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MK05k2Dk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A4B9D1F00893;
	Sat, 30 May 2026 17:22:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780161776;
	bh=RD3gt9CTTbalF9eD5PtWI3q//tLOMV4gA+I8JAPYwts=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MK05k2DkKymig/x/MYJmEaevKSF+srcsokynFpaUvkmjHkgXs7jLmOIL5wnkcAHqm
	 YnLKxWBCjyMs2vo6Bizs0ihW0VawzhwA6qIrwH/qikVVnUgfHyrsgQeV1+ofL+m2yc
	 D/vwJFE2Zp/bcT872mqeoe+ClfK47KGKZoKuVfT4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Anthony Pighin <anthony.pighin@nokia.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 723/969] rtc: abx80x: Disable alarm feature if no interrupt attached
Date: Sat, 30 May 2026 18:04:07 +0200
Message-ID: <20260530160320.503252034@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260530160300.485627683@linuxfoundation.org>
References: <20260530160300.485627683@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-257669-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bootlin.com:email,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,nokia.com:email]
X-Rspamd-Queue-Id: 464E860FB71
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Anthony Pighin (Nokia) <anthony.pighin@nokia.com>

[ Upstream commit 0fedce7244e4b85c049ce579c87e298a1b0b811d ]

Commit 795cda8338ea ("rtc: interface: Fix long-standing race when setting
alarm") exposed an issue where the rtc-abx80x driver does not clear the
alarm feature bit, but instead relies on the set_alarm operation to return
invalid.

For example, when a RTC_UIE_ON ioctl is handled, it should abort at the
feature validation. Instead, it proceeds to the rtc_timer_enqueue(),
which used to return an error from the set_alarm call. However,
following the race condition handling, which likely should not be
discarding predecing errors, a success condition is returned to the
ioctl() caller. This results in (for example):
    hwclock: select() to /dev/rtc0 to wait for clock tick timed out

Notwithstanding the validity of the race condition handling, if an interrupt
wasn't specified, or could not be attached, the driver should clear the
alarm feature bit.

Fixes: 718a820a303c ("rtc: abx80x: add alarm support")
Signed-off-by: Anthony Pighin <anthony.pighin@nokia.com>
Link: https://patch.msgid.link/BN0PR08MB69510928028C933749F4139383D1A@BN0PR08MB6951.namprd08.prod.outlook.com
Signed-off-by: Alexandre Belloni <alexandre.belloni@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/rtc/rtc-abx80x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/rtc/rtc-abx80x.c b/drivers/rtc/rtc-abx80x.c
index 2ea6fdd2ae984..651270e5f1e66 100644
--- a/drivers/rtc/rtc-abx80x.c
+++ b/drivers/rtc/rtc-abx80x.c
@@ -836,6 +836,8 @@ static int abx80x_probe(struct i2c_client *client,
 			client->irq = 0;
 		}
 	}
+	if (client->irq <= 0)
+		clear_bit(RTC_FEATURE_ALARM, priv->rtc->features);
 
 	err = rtc_add_group(priv->rtc, &rtc_calib_attr_group);
 	if (err) {
-- 
2.53.0




