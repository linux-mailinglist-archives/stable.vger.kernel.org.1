Return-Path: <stable+bounces-74161-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0EF49972DD2
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 11:36:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4160D1C248A4
	for <lists+stable@lfdr.de>; Tue, 10 Sep 2024 09:36:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAFF0189BBA;
	Tue, 10 Sep 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ej2oApHw"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81BE0188CDC;
	Tue, 10 Sep 2024 09:36:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725960992; cv=none; b=fB5e/LzmG3oFHUyh9AzV9GGfRFqcx1E7LpgKVV/Z93b3pv93iY2igTPgylxR1fJplDo7dyHUNLPkziEM+A01nuZfALE9XX846idan++4NRCAA73Ndw5vyfoaRFUiBceaFH2z5FPDTfBmJP2yBUbYlcYLg29qess8OS9pGTlr7DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725960992; c=relaxed/simple;
	bh=4FbHFZt06MYGnYBe21kyRV6Zl3gr7la7zTwk+mPXcok=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fxYoiMAPBeAdjIOsYLa2XuFTGbrsJTHruV7QIihjewIHvPNQPjRi+kos0ikKxyh+ogEaplDEMZH5qBEWOqJ04V8tLNVVbjGIr/fTTMOHwc1P3cfTj96otJwWjEb9Nr1HNA3r61iK90oqPZvidF9Yf6lDDs8RKVaO93/ZMdvC0xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ej2oApHw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5C13C4CEC3;
	Tue, 10 Sep 2024 09:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1725960992;
	bh=4FbHFZt06MYGnYBe21kyRV6Zl3gr7la7zTwk+mPXcok=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ej2oApHw+UGbaCcbJacQSHOTei0uqLutUhpNV5h3/q8ieJldmYutQlmilJ6WA73xE
	 L2ZYruxr9KzpTevX+BRBxKGasTdlB2mScUBd5cIWHInWIPXjr2yMHubte4qQ5btxPA
	 6Ur50ObvEVKSIstSt5R0BxzpYPLE/yCUaMDCvJCc=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	syzbot <syzbot+d59c4387bfb6eced94e2@syzkaller.appspotmail.com>,
	Andrey Konovalov <andreyknvl@google.com>,
	Hillf Danton <hdanton@sina.com>,
	Dan Carpenter <dan.carpenter@linaro.org>
Subject: [PATCH 4.19 17/96] ALSA: usb-audio: Fix gpf in snd_usb_pipe_sanity_check
Date: Tue, 10 Sep 2024 11:31:19 +0200
Message-ID: <20240910092542.171362807@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240910092541.383432924@linuxfoundation.org>
References: <20240910092541.383432924@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

4.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hillf Danton <hdanton@sina.com>

[ Upstream commit 5d78e1c2b7f4be00bbe62141603a631dc7812f35 ]

syzbot found the following crash on:

  general protection fault: 0000 [#1] SMP KASAN
  RIP: 0010:snd_usb_pipe_sanity_check+0x80/0x130 sound/usb/helper.c:75
  Call Trace:
    snd_usb_motu_microbookii_communicate.constprop.0+0xa0/0x2fb  sound/usb/quirks.c:1007
    snd_usb_motu_microbookii_boot_quirk sound/usb/quirks.c:1051 [inline]
    snd_usb_apply_boot_quirk.cold+0x163/0x370 sound/usb/quirks.c:1280
    usb_audio_probe+0x2ec/0x2010 sound/usb/card.c:576
    usb_probe_interface+0x305/0x7a0 drivers/usb/core/driver.c:361
    really_probe+0x281/0x650 drivers/base/dd.c:548
    ....

It was introduced in commit 801ebf1043ae for checking pipe and endpoint
types. It is fixed by adding a check of the ep pointer in question.

BugLink: https://syzkaller.appspot.com/bug?extid=d59c4387bfb6eced94e2
Reported-by: syzbot <syzbot+d59c4387bfb6eced94e2@syzkaller.appspotmail.com>
Fixes: 801ebf1043ae ("ALSA: usb-audio: Sanity checks for each pipe and EP types")
Cc: Andrey Konovalov <andreyknvl@google.com>
Signed-off-by: Hillf Danton <hdanton@sina.com>
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/usb/helper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/usb/helper.c
+++ b/sound/usb/helper.c
@@ -85,7 +85,7 @@ int snd_usb_pipe_sanity_check(struct usb
 	struct usb_host_endpoint *ep;
 
 	ep = usb_pipe_endpoint(dev, pipe);
-	if (usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
+	if (!ep || usb_pipetype(pipe) != pipetypes[usb_endpoint_type(&ep->desc)])
 		return -EINVAL;
 	return 0;
 }



