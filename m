Return-Path: <stable+bounces-226362-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gOsNO6CIuWmTJAIAu9opvQ
	(envelope-from <stable+bounces-226362-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:00:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EA9222AEC5F
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5E359309A723
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B2703EAC6F;
	Tue, 17 Mar 2026 16:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="y1StgJNg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F27503F54C4;
	Tue, 17 Mar 2026 16:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773766364; cv=none; b=nGj+Y5FLQiaAbYKRewWWprk3q6PKmQ8q273KsOSeJU6mPmTf0DMJh2MvuN/fsdGofy4EuYgbaci++eVcrVfVRy48hAfuaqfJc0Bc9WmTmlCpN63HAjUUKHlvHuqIbMahbYtWQlgbDGwawJJujsph4r6SpAQ9p3ISFM2CYCSSN8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773766364; c=relaxed/simple;
	bh=ipiHjgm1ApptEnq5hZdnSPnGQ18H39toWXG8farKUQg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PDaqHdjmoijSSh+VFF/Zs5Syr83KMhXQDlul1xh2hLz1S384IWOvPh6iwduB9gzoOVVaUUE09Mz/QW6iV0dFAE0sdPSwX8vMapLTabCI1taRzHb4iNOi1Rc+t8oUUOCdKBQIY4Od5bc+AlzOuz8y0QiJBZDLfy/1Vqpr86e1wUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=y1StgJNg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ABBDC4CEF7;
	Tue, 17 Mar 2026 16:52:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773766363;
	bh=ipiHjgm1ApptEnq5hZdnSPnGQ18H39toWXG8farKUQg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=y1StgJNgDTuxUrXoLKNKC1jdqn6dVsCIcW8URE4lQx74jJ7AYnY/Qnxn6k8CAWeQx
	 zlQqGOUBJMMaDmc9QYrRvSQfM+6AgVIptZQ+XQIjsCya3jntIsQrjPKz7jYbjQnNJ0
	 5kL2HcUJZkeFxB7gC9i+wPIiVevtkvc4toRKY1LI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Subject: [PATCH 6.19 228/378] gpiolib: normalize the return value of gc->get() on behalf of buggy drivers
Date: Tue, 17 Mar 2026 17:33:05 +0100
Message-ID: <20260317163015.397908006@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317163006.959177102@linuxfoundation.org>
References: <20260317163006.959177102@linuxfoundation.org>
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
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-226362-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,kernel.org,oss.qualcomm.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,qualcomm.com:email,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: EA9222AEC5F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

commit ec2cceadfae72304ca19650f9cac4b2a97b8a2fc upstream.

Commit 86ef402d805d ("gpiolib: sanitize the return value of
gpio_chip::get()") started checking the return value of the .get()
callback in struct gpio_chip. Now - almost a year later - it turns out
that there are quite a few drivers in tree that can break with this
change. Partially revert it: normalize the return value in GPIO core but
also emit a warning.

Cc: stable@vger.kernel.org
Fixes: 86ef402d805d ("gpiolib: sanitize the return value of gpio_chip::get()")
Reported-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Closes: https://lore.kernel.org/all/aZSkqGTqMp_57qC7@google.com/
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Link: https://patch.msgid.link/20260219-gpiolib-set-normalize-v2-1-f84630e45796@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpio/gpiolib.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

--- a/drivers/gpio/gpiolib.c
+++ b/drivers/gpio/gpiolib.c
@@ -3268,8 +3268,12 @@ static int gpiochip_get(struct gpio_chip
 
 	/* Make sure this is called after checking for gc->get(). */
 	ret = gc->get(gc, offset);
-	if (ret > 1)
-		ret = -EBADE;
+	if (ret > 1) {
+		gpiochip_warn(gc,
+			"invalid return value from gc->get(): %d, consider fixing the driver\n",
+			ret);
+		ret = !!ret;
+	}
 
 	return ret;
 }



