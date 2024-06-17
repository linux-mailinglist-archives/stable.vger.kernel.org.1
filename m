Return-Path: <stable+bounces-52367-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E65690A923
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:09:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8C528286CEB
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 09:09:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F1BF190691;
	Mon, 17 Jun 2024 09:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DM41doPj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D1341836FC
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 09:09:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615379; cv=none; b=UMRB5C1AqgzPj+nPwvJAamR7WjwDslvY/HbZFpyDBnjVjs2tzThT2BGnovMFs7scSvDYTYLosIG5MXeVL4jysycUjcpqFws7p2LBIZwgmhQgXGaSQrou8h+M8rgpqITwgP5PGlMla002vcJMUrW4EcltDBV9BgjY0LrFk491wq8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615379; c=relaxed/simple;
	bh=sbu1HOaMh/FzFeR0ObxY122nGAB/qwroL3CtGUkKWBY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cemTtVnbafmrrX2yY2e0ixQF5C0S7BkzjmS4jqdseTvBBhBTaa/YCjiDqFAG3+4wCy7e3KMjWvpgEviN+B6yxY+CdLlmFS9ef+O9qcJ5owmTNcyPqTkW9AcQji3pzJ/EF/V6ZDxfikmbyfK0VJOSEjle/h/rulOqVRmCkw7KShk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DM41doPj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C5D9C2BD10;
	Mon, 17 Jun 2024 09:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718615378;
	bh=sbu1HOaMh/FzFeR0ObxY122nGAB/qwroL3CtGUkKWBY=;
	h=Subject:To:Cc:From:Date:From;
	b=DM41doPjeCgvmjxt8MGFWtX/0A5300oTE9+SsvrAeZynLwwIK6RLp6TgeoCwCIMTw
	 iewRg1x8Lq7mbg0KULKcobCyZAnpEYjGi6UXwJ8ECh3DiqjRDgyi06DL+goNlStz4f
	 r5anO8uQhKHdWPL03qUN8D+q7uovdAvYXjrZo54c=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Ack also failed Get Error commands" failed to apply to 5.10-stable tree
To: heikki.krogerus@linux.intel.com,ammy.yi@intel.com,dmitry.baryshkov@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 11:09:23 +0200
Message-ID: <2024061723-earplugs-grumbling-2745@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 8bdf8a42bca4f47646fd105a387ab6926948c7f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061723-earplugs-grumbling-2745@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:

8bdf8a42bca4 ("usb: typec: ucsi: Ack also failed Get Error commands")

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
 


