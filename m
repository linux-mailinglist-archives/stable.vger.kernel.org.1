Return-Path: <stable+bounces-245932-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4EAwNkdnA2qj5gEAu9opvQ
	(envelope-from <stable+bounces-245932-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:45:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A85FE5260B9
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 19:45:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 44C4530034A4
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8765E3DC871;
	Tue, 12 May 2026 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Kt5u0u6n"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AE08385D69;
	Tue, 12 May 2026 17:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778607926; cv=none; b=dLj1sxoyJCceGQqnA3SUduDwrk5ygQ/m8u7JIE5DhhOec+FiLI+RPXdOvdrwruMaqw+bB05XG63I6uilF3mFH7fqNZquqWVpwdAI3h4A5gHnaJLsRaMBArWPaffuICdw797ZFr3BgeX2sBCdiS4U1JQeZMoqRLxDYYR5JByfzx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778607926; c=relaxed/simple;
	bh=gRr8PjKBuzIT4lfrze00QPUOYFtF4iXt0/BymI3kFc0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/MR26UpHDzvTwpCbwEi8FFIwE/065UPKNK7k6s4h630izMy39zAxkRUWA+wC5YInfWzEqhNmAM8VOiAHsMwLPjgbaSxJzrXlHQTE8AV2Lbrv9W52cb7uFNvtcwhdDqOa61GzLSd/ArQmPM4c8TNiBkPNNubIBVCpPg9fMPv0YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Kt5u0u6n; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7AB5C2BCF5;
	Tue, 12 May 2026 17:45:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778607926;
	bh=gRr8PjKBuzIT4lfrze00QPUOYFtF4iXt0/BymI3kFc0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Kt5u0u6nEDPa2XXqg9hF4/GeOYPyvOINLgKSgsU1ztNzrkI4+56kgRFu2RZ4qw3Ll
	 CK3Xbd8mSGRm0HShvsiTbfoig08dZErXkzpK2lG7rSewgAlzEaI5ItMSaZorGFV9CK
	 WTxs0mHc7LrmKnaWusI0XNfRDBEihGjZ6BiZ8cqo=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Myeonghun Pak <mhun512@gmail.com>,
	Wilken Gottwalt <wilken.gottwalt@posteo.net>,
	Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 6.12 088/206] hwmon: (corsair-psu) Close HID device on probe errors
Date: Tue, 12 May 2026 19:39:00 +0200
Message-ID: <20260512173934.719571579@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512173932.810559588@linuxfoundation.org>
References: <20260512173932.810559588@linuxfoundation.org>
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
X-Rspamd-Queue-Id: A85FE5260B9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-245932-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,posteo.net,roeck-us.net];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,roeck-us.net:email]
X-Rspamd-Action: no action

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Myeonghun Pak <mhun512@gmail.com>

commit 174606451fbb17db506ebaacdd5e203e57773d5f upstream.

corsairpsu_probe() opens the HID device before sending the device init
and firmware-info commands. If either command fails, the error path jumps
directly to fail_and_stop and skips hid_hw_close().

Use the existing fail_and_close label for those post-open failures so the
open count and low-level close callback are balanced before hid_hw_stop().

Fixes: d115b51e0e56 ("hwmon: add Corsair PSU HID controller driver")
Cc: stable@vger.kernel.org
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
Reviewed-by: Wilken Gottwalt <wilken.gottwalt@posteo.net>
Link: https://lore.kernel.org/r/20260424135107.13720-1-mhun512@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hwmon/corsair-psu.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/drivers/hwmon/corsair-psu.c
+++ b/drivers/hwmon/corsair-psu.c
@@ -805,13 +805,13 @@ static int corsairpsu_probe(struct hid_d
 	ret = corsairpsu_init(priv);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to initialize device (%d)\n", ret);
-		goto fail_and_stop;
+		goto fail_and_close;
 	}
 
 	ret = corsairpsu_fwinfo(priv);
 	if (ret < 0) {
 		dev_err(&hdev->dev, "unable to query firmware (%d)\n", ret);
-		goto fail_and_stop;
+		goto fail_and_close;
 	}
 
 	corsairpsu_get_criticals(priv);



