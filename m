Return-Path: <stable+bounces-229950-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UA/PIYFuwWnmTAQAu9opvQ
	(envelope-from <stable+bounces-229950-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:46:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 77CBB2F8CA5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 17:46:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E21E3302FBD5
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 16:30:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D9233B3C1C;
	Mon, 23 Mar 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tfa7kReP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1129F3ACA5C;
	Mon, 23 Mar 2026 16:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774283345; cv=none; b=Ux9OX7e5mwqH9l4ix4+fGJteHHX91a9D9jMV31/b5GnRH7oW0gA4rrPH4NGvinThZchTn0aJbVQaDpy3AAqFYZWqlprSMz9CHbFTIV2HaQHm6c47o2tiLHf1o94vnMxpDrwXpdRE4k0aShOhI+gQkRhPUu9DV1ywJNyHhTjc8Do=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774283345; c=relaxed/simple;
	bh=zrmInzEsjllQNYJ953dwR6Whq45qPIMP4UJssRWly4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jfk4YHbT+v/BNirzgUu8rO0jA8ueYUcKoQijz4Zv8RDyvaj8ptS+RoOquM587/J6n/F5FUDI6RAs/cPtZnq0tSVoRsxtnaIQDpEvWlNI4mhqMPnN9O8yUnbpUHU9klceJDXnBdlalWdEchst/XX98nh+x8rXbIvz6q1d1y/wMHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tfa7kReP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE62C4CEF7;
	Mon, 23 Mar 2026 16:29:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774283345;
	bh=zrmInzEsjllQNYJ953dwR6Whq45qPIMP4UJssRWly4Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=tfa7kRePAVzsJIGr4KSEJhsuL8BJjN5o35dcg7+LQ2pbxkt0ST9UHjUbORz7LtLEA
	 jMRc5wYxJYg7+AoOvFGru7ydhouRhp7B+YjPY+Zb2+nvk6hiYq775OwjA9lSCJDYuG
	 BmZGRQUlIGskOgXxOpOGCZ/kSvZJCkxCxeo6Gyuc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Justin Stitt <justinstitt@google.com>,
	Kees Cook <keescook@chromium.org>,
	Wolfram Sang <wsa@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 477/481] i2c: cp2615: replace deprecated strncpy with strscpy
Date: Mon, 23 Mar 2026 14:47:39 +0100
Message-ID: <20260323134536.844459076@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134525.256603107@linuxfoundation.org>
References: <20260323134525.256603107@linuxfoundation.org>
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
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-229950-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	PRECEDENCE_BULK(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 77CBB2F8CA5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/i2c/busses/i2c-cp2615.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/i2c/busses/i2c-cp2615.c
+++ b/drivers/i2c/busses/i2c-cp2615.c
@@ -298,7 +298,7 @@ cp2615_i2c_probe(struct usb_interface *u
 	if (!adap)
 		return -ENOMEM;
 
-	strncpy(adap->name, usbdev->serial, sizeof(adap->name) - 1);
+	strscpy(adap->name, usbdev->serial, sizeof(adap->name));
 	adap->owner = THIS_MODULE;
 	adap->dev.parent = &usbif->dev;
 	adap->dev.of_node = usbif->dev.of_node;



