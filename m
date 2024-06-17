Return-Path: <stable+bounces-52366-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BCB690A922
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:09:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D26D41F24B00
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F70F190685;
	Mon, 17 Jun 2024 09:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BqG1Oxc/"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E1141836FC
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 09:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615376; cv=none; b=RdQQrH1TtvJ6NP1OW8zygggllqPvCy9n0IuXjlS71vGtpKuEQcEKF3KvjehoA9fwxeXscSm0gUKDdwhu+ZNsAT/bzj8MQnqTk2RAJD5cLASEUCyqwFIwcFcQNYRhtwciUTEwg0Ot9zy1TwcCVRg/nTFmbmk4mJmZDDRnUb7HPGc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615376; c=relaxed/simple;
	bh=UGrGPDGdIwNhG2Ujm2jK7NFpC8BNcaa8XFDv/RLPa6E=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RC4hURD34DFphX+wDTcQbJgi721N7Z2/YWsZxVpFSMBVk8mt83J9bQp1HRli7+Lp/F+/OltDUIFxyFSe5q9/7vdNwObF3njjLy3hT+GgfMkBNVLn/Bm7nvlSzAmP0xU6vPSjpMPN2lT5Sbx9tAU9hoV6bZBL/Vyih916945YuQk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BqG1Oxc/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B239C2BD10;
	Mon, 17 Jun 2024 09:09:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718615375;
	bh=UGrGPDGdIwNhG2Ujm2jK7NFpC8BNcaa8XFDv/RLPa6E=;
	h=Subject:To:Cc:From:Date:From;
	b=BqG1Oxc/c27xQP0lIfDLylIuhm2aOnoO2OW8JmZbOuFKjtjtZyCW5cQmEUIOSNXTG
	 0F6NzfeQOFl6kvkPgRRqmTyYl1B9yB9Uemw2MWjsOUks8rvV5fNGtPcojfzA7fnImX
	 ixTHI88O5heTCWwAFf4U5KtPZLONUJkGkFBh8y6A=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Ack also failed Get Error commands" failed to apply to 5.4-stable tree
To: heikki.krogerus@linux.intel.com,ammy.yi@intel.com,dmitry.baryshkov@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 11:09:23 +0200
Message-ID: <2024061723-sulfate-tuesday-7a6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.4-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.4.y
git checkout FETCH_HEAD
git cherry-pick -x 8bdf8a42bca4f47646fd105a387ab6926948c7f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061723-sulfate-tuesday-7a6e@gregkh' --subject-prefix 'PATCH 5.4.y' HEAD^..

Possible dependencies:

8bdf8a42bca4 ("usb: typec: ucsi: Ack also failed Get Error commands")
bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8bdf8a42bca4f47646fd105a387ab6926948c7f1 Mon Sep 17 00:00:00 2001
From: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Date: Fri, 31 May 2024 13:46:52 +0300
Subject: [PATCH] usb: typec: ucsi: Ack also failed Get Error commands

It is possible that also the GET_ERROR command fails. If
that happens, the command completion still needs to be
acknowledged. Otherwise the interface will be stuck until
it's reset.

Reported-by: Ammy Yi <ammy.yi@intel.com>
Fixes: bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Link: https://lore.kernel.org/r/20240531104653.1303519-1-heikki.krogerus@linux.intel.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/ucsi.c b/drivers/usb/typec/ucsi/ucsi.c
index cb52e7b0a2c5..2cc7aedd490f 100644
--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -153,8 +153,13 @@ static int ucsi_exec_command(struct ucsi *ucsi, u64 cmd)
 	}
 
 	if (cci & UCSI_CCI_ERROR) {
-		if (cmd == UCSI_GET_ERROR_STATUS)
+		if (cmd == UCSI_GET_ERROR_STATUS) {
+			ret = ucsi_acknowledge(ucsi, false);
+			if (ret)
+				return ret;
+
 			return -EIO;
+		}
 		return ucsi_read_error(ucsi);
 	}
 


