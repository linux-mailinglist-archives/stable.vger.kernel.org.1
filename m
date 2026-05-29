Return-Path: <stable+bounces-256743-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mZVYLPnpGWqYzwgAu9opvQ
	(envelope-from <stable+bounces-256743-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:33:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA7E607E8D
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 21:33:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E10493023C22
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 19:33:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C07F373C1A;
	Fri, 29 May 2026 19:33:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LqnVvgu0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC68B3264C4
	for <stable@vger.kernel.org>; Fri, 29 May 2026 19:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780083186; cv=none; b=PxlKa7vhA+MeU2GXK8yAHh2ogEyI0NvTvLXTSXx8LXwvfChQIQ8zt+nvwHl5ENbXOTvj6djAnuDvVeGcsDtm2q0k5/GwNApxOWYVVF5yThl9PlYKzY8bNccVJsyBo+qxfulpKiG2jiIgBmzxNbDdD3SFvPBvNpQBQsHEcGPbJJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780083186; c=relaxed/simple;
	bh=FZa/BrF6kTSqaZxMpke+LoV28HQ4kYoTNqHHIoUlHMo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eHJS0qdFIbEx5fKFaaFP648X5snH9uvE5oXz+i4+TgrD7M61PIxnuSpd7mcDiRshUVaRH5cTv2+0eWKgZDGkINwsSAAQlhSgypw1RWa8kBz0J5et3/ORen9esWQdhOJjJM7k0e5I5HI9kKfTKc9tSVibfkNyuVDmddprlRnQgFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LqnVvgu0; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E824E1F00893;
	Fri, 29 May 2026 19:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780083185;
	bh=xk4FJi4aJAnBAq4K76d712WOB6pmYj6YgYj2pDo/1MA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LqnVvgu0zIYNd1h5fbRHY/Jgf7JsWxhpYBEfB3Q/DIiDTe430nnCt/aJX2RWJJDLC
	 y8IHvIr9r8bxeu11XyTZ8mWzfLofnz32CSJxzuWbS3+b/jIcBg8tXJJgkSZBkVsK7u
	 yqNzpIdrKDtlEgvKl1CVUgvqYJ9vEiTaI1Wgfib2cIlLP9BZtD4fQWrDgJtMer+Ima
	 Xc7J0LO+2lccYhw87RnTd+nOFuhfr9ZfUY8cW4+VRkxnA6pB18K7SSGplYUuTbQqbo
	 SApNM5J9Cb4rpCfXB7xxa8WVlZD9q7fIt70XQ02NegU9m2k8pqnZfCgfzLyB1Xq25h
	 uixLh1m6g78yg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Ricardo B. Marliere" <ricardo@marliere.net>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] serdev: make serdev_bus_type const
Date: Fri, 29 May 2026 15:33:00 -0400
Message-ID: <20260529193303.1704693-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052800-unloving-guileless-afb9@gregkh>
References: <2026052800-unloving-guileless-afb9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-256743-lists,stable=lfdr.de];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,linuxfoundation.org:email]
X-Rspamd-Queue-Id: AAA7E607E8D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: "Ricardo B. Marliere" <ricardo@marliere.net>

[ Upstream commit 88cddfb7bf23b06876da6c3e9f296e666d0f6332 ]

Now that the driver core can properly handle constant struct bus_type,
move the serdev_bus_type variable to be a constant structure as well,
placing it into read-only memory which can not be modified at runtime.

Suggested-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: "Ricardo B. Marliere" <ricardo@marliere.net>
Link: https://lore.kernel.org/r/20240203-bus_cleanup-tty-v1-1-86b698c82efe@marliere.net
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 375ba7484132 ("Bluetooth: hci_qca: Convert timeout from jiffies to ms")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serdev/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serdev/core.c b/drivers/tty/serdev/core.c
index e7d663901c075..75c42fa1b5de7 100644
--- a/drivers/tty/serdev/core.c
+++ b/drivers/tty/serdev/core.c
@@ -441,7 +441,7 @@ static void serdev_drv_remove(struct device *dev)
 	dev_pm_domain_detach(dev, true);
 }
 
-static struct bus_type serdev_bus_type = {
+static const struct bus_type serdev_bus_type = {
 	.name		= "serial",
 	.match		= serdev_device_match,
 	.probe		= serdev_drv_probe,
-- 
2.53.0


