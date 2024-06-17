Return-Path: <stable+bounces-52363-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDE990A91F
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:09:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 400E728549A
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 09:09:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73491190698;
	Mon, 17 Jun 2024 09:09:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="BCN61JQn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30DD2190691
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615367; cv=none; b=RFqjm2o2xLLZDFRJZbzT4bNRkxOSRK1Cmczorgro2EBy+H4Xqfk1wb+XpGprkGXaLsCWjJoaUbM6Ab25aTAcvIhkyUYUg6tUtiJAiBboxESM8CJY7SMtACESaU0UOUHTGKqBNnVxAOw+qZU7IOG3zQTklGn0/IQyK/YGDN7uwyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615367; c=relaxed/simple;
	bh=u9wdEST3Rvy9RJWv3nWV3cgcm2SegaX1Z3BSvLVAr5o=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qprkhk/6g+Jb2RRfg6TrWDp/OnVIEESmbjGzcMsWGDytCzl/KCvQwnmGMUAmGPv468wS/POfQ0hxatlT77ao/KdbpeK34RprmbQcCyDHFcefH9J5IB9jcXUN/jjpuMFA6gre5oowrmyQ3QjqKOGJducON9SHjhTRi/1oeYW4P64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=BCN61JQn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A84AC2BD10;
	Mon, 17 Jun 2024 09:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718615366;
	bh=u9wdEST3Rvy9RJWv3nWV3cgcm2SegaX1Z3BSvLVAr5o=;
	h=Subject:To:Cc:From:Date:From;
	b=BCN61JQnADkr5bFdKiE4esFQ5x5UMUL/hLwtQGdCTX5HKX27W4ty2cFlH4CoLVmlM
	 KEm6DwROBocux6vtEHEGeqU/Q8TpEklD3OF2nBW4OAKgCUIued2IrT3rc1KupWboQY
	 PSsmNoxfpuxBLpwSHTPFd6UwszjzFtfT8oqYcZN0=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Ack also failed Get Error commands" failed to apply to 6.1-stable tree
To: heikki.krogerus@linux.intel.com,ammy.yi@intel.com,dmitry.baryshkov@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 11:09:21 +0200
Message-ID: <2024061721-tacking-freckled-03d5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 8bdf8a42bca4f47646fd105a387ab6926948c7f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061721-tacking-freckled-03d5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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
 


