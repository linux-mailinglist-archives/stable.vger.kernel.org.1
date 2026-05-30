Return-Path: <stable+bounces-257305-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6EY3MGEaG2oq/QgAu9opvQ
	(envelope-from <stable+bounces-257305-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:12:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 20BA860F19F
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 19:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C79D1303EC24
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C00634BA42;
	Sat, 30 May 2026 17:02:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="peqPUeTa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF552690D5;
	Sat, 30 May 2026 17:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780160543; cv=none; b=dFsuS2pGDMPnyVE95v17LLPZ/NZWUWssQ0bIokmbTykFTNw4hBF0DlMgWFqOA4ztfU+uqMRBLrPQxF3xLnlnFOXhbDld0F7yt1fIFnimDMzkFZapuvCIt7NUtDYzAL6Xto5bm5rdUfJvAYdYSGU0fekTzzKtfBxHcsX+VyIopbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780160543; c=relaxed/simple;
	bh=c2Y6DAvNTAKgxpcThCZAOZQ6BTAlEYGuhU+qOvghogk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=j+GkKwGEk8hBAIx6Mq2yY6zT+rkNqVZFzDclauR9Y9cpGEhpc0wukpkAVEoq09pF+7CXmb3h66wK04vadx7d8y6B/qlxLUMVG/GoHbPYpWGNDhPywUlPbBBKVFi5xGrJntca41NvPvvt33i794cpTEx0xDrYFfVX7BGH/OmNBeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=peqPUeTa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C8E11F00893;
	Sat, 30 May 2026 17:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780160542;
	bh=xLMUeMBr9CMdMVYYMy2ZWVQCZfarZQVENbcvIIp4IEA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=peqPUeTaWZVuERcF/wcJ2L+JB4TeuMDHx5leXb21Hchi+OdR/O9ZHxUZ/0ZaVc9Xx
	 dfbsQhM4Kf46tAFtrEmzlnTCi/piqkbHLENA2GDPC6RzVO5YJeR3W9c/Ll+0C0ux4g
	 UMgWitu1rGlIii3f13UEckOCjkVxCvPbt+rQoDuQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	=?UTF-8?q?Andr=C3=A9=20Draszik?= <andre.draszik@linaro.org>,
	Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCH 6.1 366/969] power: supply: max17042: avoid overflow when determining health
Date: Sat, 30 May 2026 17:58:10 +0200
Message-ID: <20260530160310.433070600@linuxfoundation.org>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-257305-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 20BA860F19F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: André Draszik <andre.draszik@linaro.org>

commit 9a44949da669708f19d29141e65b3ac774d08f5a upstream.

If vmax has the default value of INT_MAX (e.g. because not specified in
DT), battery health is reported as over-voltage. This is because adding
any value to vmax (the vmax tolerance in this case) causes it to wrap
around, making it negative and smaller than the measured battery
voltage.

Avoid that by using size_add().

Fixes: edd4ab055931 ("power: max17042_battery: add HEALTH and TEMP_* properties support")
Cc: stable@vger.kernel.org
Signed-off-by: André Draszik <andre.draszik@linaro.org>
Link: https://patch.msgid.link/20260302-max77759-fg-v3-6-3c5f01dbda23@linaro.org
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/power/supply/max17042_battery.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/power/supply/max17042_battery.c
+++ b/drivers/power/supply/max17042_battery.c
@@ -199,7 +199,7 @@ static int max17042_get_battery_health(s
 		goto out;
 	}
 
-	if (vbatt > chip->pdata->vmax + MAX17042_VMAX_TOLERANCE) {
+	if (vbatt > size_add(chip->pdata->vmax, MAX17042_VMAX_TOLERANCE)) {
 		*health = POWER_SUPPLY_HEALTH_OVERVOLTAGE;
 		goto out;
 	}



