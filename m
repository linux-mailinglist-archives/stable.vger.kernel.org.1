Return-Path: <stable+bounces-197945-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C6D1BC986D4
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:10:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C23E23A3F28
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:10:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD4A33468D;
	Mon,  1 Dec 2025 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="R0DDyz4w"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EAB42335092
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 17:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609031; cv=none; b=g9UjX9S4tQynZRxb02gBFTh6fc8nahtYeloSAEdyTjMLeCxA4PXx9MoUTE6hfzo9LRZkbMaf0hTh0MylkzN5/Royjsr5AVfMNdB5o8jdpAY3K0EaSNLcuK2uv2+jQVKVf+jE+8VfH6wRg1A2vPlodglt2Rt/BaIFT+tW0tWzd3w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609031; c=relaxed/simple;
	bh=lNufVc4bqEB/DKrw6YarwloPbETg2aPN7Fq1Qo+iXVw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=M3Zhw0tMh19NrcGGBHsahSDmTMVHarObzt7JCcuAN1i85laXinLUjOknD3wxQQd9dDsfP14bBvoCBRDDvw9P2SamJvPKYnI0O4uP0/awC2NDZzjof3i4Wr5VwyZF8X/4L5R4GdDDmAxDd2OLtiu1BdRkrgrVFcZiW8OLsl3kAfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=R0DDyz4w; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C846C4CEF1;
	Mon,  1 Dec 2025 17:10:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764609030;
	bh=lNufVc4bqEB/DKrw6YarwloPbETg2aPN7Fq1Qo+iXVw=;
	h=Subject:To:Cc:From:Date:From;
	b=R0DDyz4wwnxOiCs0ob5Bg8rxyJMa0XEtjKf3qMRQ7iy9lD7lhROEo86LaJAyiWQ8e
	 iJ4Go2ne61K+y2R5NAo/6IBh8X4tCJ40ObQLt5PmUmWtGNTTsHWF6WrqXw0DTpaTJA
	 nFsKgVJ4hBxBFsHO29d/47DSjFb1LZtDNGZ2NRTI=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: psy: Set max current to zero when" failed to apply to 6.6-stable tree
To: jthies@google.com,bleung@chromium.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,kenny@panix.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 18:10:16 +0100
Message-ID: <2025120116-sulfide-compacter-b9f2@gregkh>
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
git cherry-pick -x 23379a17334fc24c4a9cbd9967d33dcd9323cc7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120116-sulfide-compacter-b9f2@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 23379a17334fc24c4a9cbd9967d33dcd9323cc7c Mon Sep 17 00:00:00 2001
From: Jameson Thies <jthies@google.com>
Date: Thu, 6 Nov 2025 01:14:46 +0000
Subject: [PATCH] usb: typec: ucsi: psy: Set max current to zero when
 disconnected

The ucsi_psy_get_current_max function defaults to 0.1A when it is not
clear how much current the partner device can support. But this does
not check the port is connected, and will report 0.1A max current when
nothing is connected. Update ucsi_psy_get_current_max to report 0A when
there is no connection.

Fixes: af833e7f7db3 ("usb: typec: ucsi: psy: Set current max to 100mA for BC 1.2 and Default")
Cc: stable@vger.kernel.org
Signed-off-by: Jameson Thies <jthies@google.com>
Reviewed-by: Benson Leung <bleung@chromium.org>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Reviewed-by: Sebastian Reichel <sebastian.reichel@collabora.com>
Tested-by: Kenneth R. Crudup <kenny@panix.com>
Rule: add
Link: https://lore.kernel.org/stable/20251017000051.2094101-1-jthies%40google.com
Link: https://patch.msgid.link/20251106011446.2052583-1-jthies@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/ucsi/psy.c b/drivers/usb/typec/ucsi/psy.c
index 62a9d68bb66d..8ae900c8c132 100644
--- a/drivers/usb/typec/ucsi/psy.c
+++ b/drivers/usb/typec/ucsi/psy.c
@@ -145,6 +145,11 @@ static int ucsi_psy_get_current_max(struct ucsi_connector *con,
 {
 	u32 pdo;
 
+	if (!UCSI_CONSTAT(con, CONNECTED)) {
+		val->intval = 0;
+		return 0;
+	}
+
 	switch (UCSI_CONSTAT(con, PWR_OPMODE)) {
 	case UCSI_CONSTAT_PWR_OPMODE_PD:
 		if (con->num_pdos > 0) {


