Return-Path: <stable+bounces-227967-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mPxyNMw5wWm7RQQAu9opvQ
	(envelope-from <stable+bounces-227967-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:02:04 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DF4D2F264E
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7B240307EBC8
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 12:53:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 644343A9D93;
	Mon, 23 Mar 2026 12:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="brW8xiCx"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2310D3A9D8F
	for <stable@vger.kernel.org>; Mon, 23 Mar 2026 12:53:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774270384; cv=none; b=PV3io5CtJQ187SlEwxhNtNIVTIHzWrlGNm9N7cwFfvhxzwoiLhuTY94j4l26C9OgS74N5fnTaWuJ1oO+GP6iX9DS6g0PDBdAwyQfIsl7YtJ7/nul3nN9H36W1cE2iMjWmtXgGQI/tAgLG+LCnSfDgUCiAHfNtf0WfU5rVnllYok=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774270384; c=relaxed/simple;
	bh=O2dHZFsOQ70hD1x0Z0vjR8SZREugcpDMh1YMqxxDscs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Z3YdEnu1V5H+9mpTYxOjRr2X2YG12PUIAk8nRbp4gjc8OkhwMJCS3PSTrqmCQtUsrjtiLQAD+sIjfn7bmIUuvZmbhLMAGdBoxk4n4dZ4PeX10I1CMTGKPASlUXGtZnCtw0XmFPWYo1tQG+Xed+YDgr1vTPso4HrmjLYELqvUNA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=brW8xiCx; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C9D1C4CEF7;
	Mon, 23 Mar 2026 12:53:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774270383;
	bh=O2dHZFsOQ70hD1x0Z0vjR8SZREugcpDMh1YMqxxDscs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=brW8xiCxk1MHYaeTIbcWz9jhqE7pZD+FTXn4ujnvK2xO2v+1qUpVncYDjYn6sB2Ay
	 Ry2nQ0mENa2Sd8PAY6MbAaF2K007WQSXwMuUll1FVJ3saFLtxowuRxRvUEldXxOC6l
	 FSZJ/y4PiJe99UOlzd5cQiBvZtCSJAA5mZBoxexAxWAvyn/rlwE/r8gUQ8YFL4TC+V
	 dDkq/dp5NUrMRHNSajx/WiftCM/Cm93QxVjuP4Pr4VJYC5nnpBgKLrG0S3IeqVC5JY
	 tUUHnWQ/O42YDLzB2BpjYP7JsDN4a6vbEtrWdHJMnHc9yaev+RRSgKTLzP/jPnBu7Z
	 JaUK2oB61t0cw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] i2c: cp2615: replace deprecated strncpy with strscpy
Date: Mon, 23 Mar 2026 08:53:00 -0400
Message-ID: <20260323125301.1649463-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <2026032347-celtic-fragility-e746@gregkh>
References: <2026032347-celtic-fragility-e746@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	SEM_URIBL_FRESH15_UNKNOWN_FAIL(0.00)[chromium.org:query timed out];
	TAGGED_FROM(0.00)[bounces-227967-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	SEM_URIBL_UNKNOWN_FAIL(0.00)[chromium.org:query timed out];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 6DF4D2F264E
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


