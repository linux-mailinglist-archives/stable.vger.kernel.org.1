Return-Path: <stable+bounces-52368-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BF48890A926
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 11:10:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 69ECE1F24C6D
	for <lists+stable@lfdr.de>; Mon, 17 Jun 2024 09:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E9251922CA;
	Mon, 17 Jun 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="1hnsAaQL"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF121922C4
	for <stable@vger.kernel.org>; Mon, 17 Jun 2024 09:09:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718615382; cv=none; b=jyzzwUVFy82VH8CeW17SVDPCIlBTzGlMDsNNd0+RKsoEKUZAwiAlfXQQI8d+5hI/ApwyPuiUUKqpiuHLPw/4WITABdvpShenErDJmvY9qKQd3Nx+JqK8LOGptU6gxPrW46ca2AVEHvB6Lzn2XZRARh29cFfukS2mbvitjO7X6v8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718615382; c=relaxed/simple;
	bh=Rs+1AB7x217w+s5zBM4wRYOyY54QkDmWfFFdM1/uscA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=BJKqab/rVOsFWY+V/TAXznVTbKP6p7ur5xqwEr5b8IkU7iUdPutCIs2xb5Tyvsin9GWzWDiNq6vwb1eCInU6DTcy9i1qVBq/L/9a1nGVGQVWrIJ1vxsu/j3PoJVi/A9QQ0bXLoFs5nEn80Cwkmxxp8/pcAN2oCoRIvhBeiR6JoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=1hnsAaQL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A509FC2BD10;
	Mon, 17 Jun 2024 09:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1718615382;
	bh=Rs+1AB7x217w+s5zBM4wRYOyY54QkDmWfFFdM1/uscA=;
	h=Subject:To:Cc:From:Date:From;
	b=1hnsAaQLNvkQQ+J3Vj7P5Ebl/uTbOjpRnWPF1o5cG8nYXKKBT5Dt6eT1HDcN+q07d
	 ePhnGbqckDpjf967KqT0208YepJj6tOdJzindq7wFQcAZj1D6Cr0fXCG8CEqrTycia
	 iOPyJz73PmebRPCqNDMC7ZrC5Ugu0OMbaUlocy3I=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: Ack also failed Get Error commands" failed to apply to 4.19-stable tree
To: heikki.krogerus@linux.intel.com,ammy.yi@intel.com,dmitry.baryshkov@linaro.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Jun 2024 11:09:24 +0200
Message-ID: <2024061724-straw-unwomanly-e822@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 4.19-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.19.y
git checkout FETCH_HEAD
git cherry-pick -x 8bdf8a42bca4f47646fd105a387ab6926948c7f1
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024061724-straw-unwomanly-e822@gregkh' --subject-prefix 'PATCH 4.19.y' HEAD^..

Possible dependencies:

8bdf8a42bca4 ("usb: typec: ucsi: Ack also failed Get Error commands")
bdc62f2bae8f ("usb: typec: ucsi: Simplified registration and I/O API")
ad74b8649bea ("usb: typec: ucsi: Preliminary support for alternate modes")
81534d5fa973 ("usb: typec: ucsi: Remove debug.h file")

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
 


