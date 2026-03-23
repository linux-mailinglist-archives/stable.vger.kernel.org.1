Return-Path: <stable+bounces-227985-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Kw+B4c/wWlnRwQAu9opvQ
	(envelope-from <stable+bounces-227985-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:26:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7CDBB2F2E02
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:26:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 613CB306CDC7
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 13:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0413837F01B;
	Mon, 23 Mar 2026 13:19:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dqCMTCxs"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCDC32DE6F1
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 13:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774271952; cv=none; b=sGhj+Omu4gkI1YciUmTKb4hC2iEwYm8eJIf4VSDmwDfHhAqBeamfgxfD3RdYqOOIYWPqqNwL1K0TO8KNOz8M6oVKLUNYb+LMm+hpQRu2KZMcvugYsI7qh/QxqumA+9/S7YP9X04VpLcNQBMaHs3Qdb2Im9cuxkmLhl1KPSd9jHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774271952; c=relaxed/simple;
	bh=O2dHZFsOQ70hD1x0Z0vjR8SZREugcpDMh1YMqxxDscs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MOoq6oIA7wqZdd/9Ji9/jFWq+ypXiWDcGQmON7O9DVIcomIpyuqvr/wnghzqHj13lKlN0ZCSl2g+prw4V0quTgcJy7lxWm3UqYa+u9dVDZWNB2PyzOi9vO62UeSeDV39onKc780IZ6Qk41CMsuqiI3APRKd935hAFoxyEYNjVnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dqCMTCxs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA179C4CEF7;
	Mon, 23 Mar 2026 13:19:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774271952;
	bh=O2dHZFsOQ70hD1x0Z0vjR8SZREugcpDMh1YMqxxDscs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dqCMTCxswicc9Yza5YM4D0l654ciXMwEgNYxDyMI0yC2uaOnKrZUve1U5UwRhQVIb
	 LfH/t9/4m7kv9o7GHtEJzjJhZdCpWR0OgOJexCEU+OVMYpes5S1uMbfENkHNBhud3+
	 x2y7d4Y8+GQXFLTNtH4vo+4pGenGhOmkapUFYiGr7+xoFPAtqtwrbBb1IIwlPl2Xux
	 aXjs+vsAKPNFcA8+bvzvlwduwwTCq0467nQZEu+OLI+od+do3O+V16pelnoVRN1JX+
	 dvDo99PmNIkRJJg/fX49pypgPj04L8kaRmhUmGbEIU7wacukaZqtX7P457cXWtcRMM
	 8cpy+JyBa4nYA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] i2c: cp2615: replace deprecated strncpy with strscpy
Date: Mon, 23 Mar 2026 09:19:09 -0400
Message-ID: <20260323131910.1715046-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032348-savor-throbbing-4586@gregkh>
References: <2026032348-savor-throbbing-4586@gregkh>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-227985-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,chromium.org:email]
X-Rspamd-Queue-Id: 7CDBB2F2E02
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Justin Stitt <justinstitt@google.com>

[ Upstream commit e2def33f9ee1b1a8cda4ec5cde69840b5708f068 ]

`strncpy` is deprecated for use on NUL-terminated destination strings [1].

We should prefer more robust and less ambiguous string interfaces.

We expect name to be NUL-terminated based on its numerous uses with
functions that expect NUL-terminated strings.

For example in i2c-core-base.c +1533:
| dev_dbg(&adap->dev, "adapter [%s] registered\n", adap->name);

NUL-padding is not required as `adap` is already zero-alloacted with:
| adap = devm_kzalloc(&usbif->dev, sizeof(struct i2c_adapter), GFP_KERNEL);

With the above in mind, a suitable replacement is `strscpy` [2] due to
the fact that it guarantees NUL-termination on the destination buffer
without unnecessarily NUL-padding.

Link: https://www.kernel.org/doc/html/latest/process/deprecated.html#strncpy-on-nul-terminated-strings [1]
Link: https://manpages.debian.org/testing/linux-manual-4.8/strscpy.9.en.html [2]
Link: https://github.com/KSPP/linux/issues/90
Signed-off-by: Justin Stitt <justinstitt@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Wolfram Sang <wsa@kernel.org>
Stable-dep-of: aa79f996eb41 ("i2c: cp2615: fix serial string NULL-deref at probe")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/i2c/busses/i2c-cp2615.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/i2c/busses/i2c-cp2615.c b/drivers/i2c/busses/i2c-cp2615.c
index 3ded28632e4c1..20f8f7c9a8cd4 100644
--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -298,7 +298,7 @@ cp2615_i2c_probe(struct usb_interface *usbif, const struct usb_device_id *id)
 	if (!adap)
 		return -ENOMEM;
 
-	strncpy(adap->name, usbdev->serial, sizeof(adap->name) - 1);
+	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = &usbif->dev;
 	adap->dev.of_node = usbif->dev.of_node;
-- 
2.51.0


