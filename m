Return-Path: <stable+bounces-16198-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CF7483F1A1
	for <lists+stable@lfdr.de>; Sun, 28 Jan 2024 00:12:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0A83E283C9E
	for <lists+stable@lfdr.de>; Sat, 27 Jan 2024 23:12:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71229200AD;
	Sat, 27 Jan 2024 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PrFWMzBI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EADC1B80B
	for <stable@vger.kernel.org>; Sat, 27 Jan 2024 23:12:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706397156; cv=none; b=uTMAa9Xy0l/TL5xTEldRlFw/UcNYjhpL0j+0cWyxVlKXctwoAuA0m8OyQXHJmwStBRcp8raxXa7759ywTwqt/sVoHoEXfd1uxBCh1Yq9eolP1mH78Q9F2QbdqUvB5SxtrspBkl2qPt5iiioAdv81ZE8dO7uJ7Qp+9Lo7ZUieImw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706397156; c=relaxed/simple;
	bh=vErdicvsJ5Mj5rt/01IWnliV0AVu0pJ5ODMTmt81kIg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Nk33YRZCyMGTvZva5RjmMRMQUXiF6mxIzx5ZWXwsbcgDdbMQD8tO+F6jZ8t8Ma4zW8Y6jyLCKiGQBKHoK4sYuyNRJjwBGbdAqwgRPOyJ1sENBxHfEJzRTipjZdMKop0PKfLaPfm0nsFJbVlSu3KCeqJZ4THBi0YoxGfRw7pfmaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PrFWMzBI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAEE0C43390;
	Sat, 27 Jan 2024 23:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1706397156;
	bh=vErdicvsJ5Mj5rt/01IWnliV0AVu0pJ5ODMTmt81kIg=;
	h=Subject:To:Cc:From:Date:From;
	b=PrFWMzBImpGBT/2dgwFZg4BN2uoXU5qF89h/iz9bEvsmmq4oam3AcX0tbGm0WhEs0
	 dwRR8QNa9QGDy3E++FR9FX7coUr02io4G5nUPSsQTBeVKh85BY0z6UJtZkZawuK3YD
	 e/9ux43vieuJddIqFqEQgmBUGJMZei+AEV0OgOms=
Subject: FAILED: patch "[PATCH] drm/amd/display: Include udelay when waiting for INBOX0 ACK" failed to apply to 6.6-stable tree
To: alvin.lee2@amd.com,alexander.deucher@amd.com,hamza.mahfooz@amd.com,samson.tam@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 27 Jan 2024 15:12:35 -0800
Message-ID: <2024012735-arming-childless-3574@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1c22d6ce53280763bcb4cb24d4f71111fff4a526
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024012735-arming-childless-3574@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:

1c22d6ce5328 ("drm/amd/display: Include udelay when waiting for INBOX0 ACK")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1c22d6ce53280763bcb4cb24d4f71111fff4a526 Mon Sep 17 00:00:00 2001
From: Alvin Lee <alvin.lee2@amd.com>
Date: Mon, 6 Nov 2023 11:20:15 -0500
Subject: [PATCH] drm/amd/display: Include udelay when waiting for INBOX0 ACK

When waiting for the ACK for INBOX0 message,
we have to ensure to include the udelay
for proper wait time

Cc: stable@vger.kernel.org # 6.1+
Reviewed-by: Samson Tam <samson.tam@amd.com>
Acked-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Signed-off-by: Alvin Lee <alvin.lee2@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>

diff --git a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
index 22fc4ba96def..38360adc53d9 100644
--- a/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
+++ b/drivers/gpu/drm/amd/display/dmub/src/dmub_srv.c
@@ -1077,6 +1077,7 @@ enum dmub_status dmub_srv_wait_for_inbox0_ack(struct dmub_srv *dmub, uint32_t ti
 		ack = dmub->hw_funcs.read_inbox0_ack_register(dmub);
 		if (ack)
 			return DMUB_STATUS_OK;
+		udelay(1);
 	}
 	return DMUB_STATUS_TIMEOUT;
 }


