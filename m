Return-Path: <stable+bounces-218765-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4Dg/Ed1YnmkjUwQAu9opvQ
	(envelope-from <stable+bounces-218765-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:05:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A350119080D
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 03:05:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3985431FFCD1
	for <lists+stable@lfdr.de>; Wed, 25 Feb 2026 01:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97A772765D7;
	Wed, 25 Feb 2026 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nD7un8ob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BA6A26561A;
	Wed, 25 Feb 2026 01:40:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771983636; cv=none; b=NompVm3SFE8HydSFqWF1PwbiJKSgAodjzoin/Jk2mAeWcQKu3lRDyqT8XMEG1WX0TrhA4N9cT7ohrytdzxogLLzZWayzZxP64R0TwBDsnvqTo7LgR5cTCPgdbFwZl/VM/azHdS0PqmLRjUwQ/r9J08Q4YsPmaqB37cq6m6TFPhY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771983636; c=relaxed/simple;
	bh=FJuxeQCfd+7vFdDV6P2iDyHrSp881HHMjsdG4bUhcrU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nbKdM5d40ZME2EZzkAWx6pp7cochmgdW/FJlcgcusMC5fu+AuD0Og7XW42PtLsxQVcoAciyTVQD9kiEhJoJuAkRgUbtoGG41vrdWiyBuxl0O1kIpgJvu1HFfwFCgeDynIIHqB7jzN3vbF9yGQUx3F4y8vP2pW4JFs8PKILkgC88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nD7un8ob; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1BDF9C116D0;
	Wed, 25 Feb 2026 01:40:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1771983636;
	bh=FJuxeQCfd+7vFdDV6P2iDyHrSp881HHMjsdG4bUhcrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nD7un8obfwsrPL2QM5iuLTZnMdF8xiAqqh3B2+pqDCKWuln5fv0xUBW0SXiczI5En
	 xwbk/+Z0G/FVn4TpgjZ0QbK6xr0j89NM1S+sjb1Grf8u2f5MZCjc+mBHXGrW8PcFjl
	 Bxx4T5c9MEm6idS1m4DdoRRYGJJ033gdU/EL6YHw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Douglas Anderson <dianders@chromium.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 725/781] gpio: cdev: Avoid NULL dereference in linehandle_create()
Date: Tue, 24 Feb 2026 17:23:54 -0800
Message-ID: <20260225012417.517467655@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260225012359.695468795@linuxfoundation.org>
References: <20260225012359.695468795@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-218765-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[chromium.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim,msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email]
X-Rspamd-Queue-Id: A350119080D
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Douglas Anderson <dianders@chromium.org>

[ Upstream commit 6af6be278e3ba2ffb6af5b796c89dfb3f5d9063e ]

In linehandle_create(), there is a statement like this:
  retain_and_null_ptr(lh);

Soon after, there is a debug printout that dereferences "lh", which
will crash things.

Avoid the crash by using handlereq.lines, which is the same value.

Fixes: da7e394bf58f ("gpio: convert linehandle_create() to FD_PREPARE()")
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Link: https://patch.msgid.link/20260215120555.v2.1.I77c3eb563271c21870379eefd16ebbc4e09635bb@changeid
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index 2adc3c0709082..189127721e383 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -388,7 +388,7 @@ static int linehandle_create(struct gpio_device *gdev, void __user *ip)
 	fd_publish(fdf);
 
 	dev_dbg(&gdev->dev, "registered chardev handle for %d lines\n",
-		lh->num_descs);
+		handlereq.lines);
 
 	return 0;
 }
-- 
2.51.0




