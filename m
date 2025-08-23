Return-Path: <stable+bounces-172645-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AD0DB329F0
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 17:56:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E29F13BE068
	for <lists+stable@lfdr.de>; Sat, 23 Aug 2025 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8EEA32080E8;
	Sat, 23 Aug 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="aZxs9azn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27F82193077
	for <stable@vger.kernel.org>; Sat, 23 Aug 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755964605; cv=none; b=D8+KVBLi2MJsAWaQDpYs7MWK45gsgc9paOC6nNuUfqTPB/mELMZ0GJl/L5eZB+45p9fp+uY6RyyPc3jNwdBP27B0n8n1Jfk2Dc8JTKwq3Q4S02q5d84Vl9WjQHn+1jDFcYozaw8pyc8XXRd+tMLMUgZeeYYsboWjJgz7ATjT/3U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755964605; c=relaxed/simple;
	bh=bXm/8u+Qdr+eKk0ilRnyBUxkkryjZltEA88JAL7pCAU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=qd1ai852h5IIeF0qE7gRy3g+vplFqYMGkfYxNT9a+Y1pFZnB747ha6LwVkGFC1Xvp505hLUo/zU40tQJZSCU81OD43B7rstfWOzB+l5J4EiDrMdvzDo862+/q4jaR+Qxv09gT10DJ/NthmKkH1gM7PZK8I/XDMQXbQslPOHkH7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=aZxs9azn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C113C4CEE7;
	Sat, 23 Aug 2025 15:56:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755964604;
	bh=bXm/8u+Qdr+eKk0ilRnyBUxkkryjZltEA88JAL7pCAU=;
	h=Subject:To:Cc:From:Date:From;
	b=aZxs9azn+3q4qK0uEW03AInt9XYfP7OOdEhPMadnnnnHVW6o60tE/WglPDAla3GTI
	 CQluttoZo7woxZDZVwSkfzyUi6Ua29VLhjl0S53WsBR2IiPMoliKqMW3o7vEapOMjn
	 hWvL21U2IYD9FLanzAhVEhSvlUue6eH5sDAr88dk=
Subject: FAILED: patch "[PATCH] usb: typec: maxim_contaminant: disable low power mode when" failed to apply to 6.6-stable tree
To: amitsd@google.com,badhri@google.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Sat, 23 Aug 2025 17:56:41 +0200
Message-ID: <2025082341-salami-darkroom-6913@gregkh>
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
git cherry-pick -x cabb6c5f4d9e7f49bdf8c0a13c74bd93ee35f45a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025082341-salami-darkroom-6913@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From cabb6c5f4d9e7f49bdf8c0a13c74bd93ee35f45a Mon Sep 17 00:00:00 2001
From: Amit Sunil Dhamne <amitsd@google.com>
Date: Fri, 15 Aug 2025 11:31:51 -0700
Subject: [PATCH] usb: typec: maxim_contaminant: disable low power mode when
 reading comparator values

Low power mode is enabled when reading CC resistance as part of
`max_contaminant_read_resistance_kohm()` and left in that state.
However, it's supposed to work with 1uA current source. To read CC
comparator values current source is changed to 80uA. This causes a storm
of CC interrupts as it (falsely) detects a potential contaminant. To
prevent this, disable low power mode current sourcing before reading
comparator values.

Fixes: 02b332a06397 ("usb: typec: maxim_contaminant: Implement check_contaminant callback")
Cc: stable <stable@kernel.org>
Signed-off-by: Amit Sunil Dhamne <amitsd@google.com>
Reviewed-by: Badhri Jagan Sridharan <badhri@google.com>
Rule: add
Link: https://lore.kernel.org/stable/20250814-fix-upstream-contaminant-v1-1-801ce8089031%40google.com
Link: https://lore.kernel.org/r/20250815-fix-upstream-contaminant-v2-1-6c8d6c3adafb@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/typec/tcpm/maxim_contaminant.c b/drivers/usb/typec/tcpm/maxim_contaminant.c
index 0cdda06592fd..818cfe226ac7 100644
--- a/drivers/usb/typec/tcpm/maxim_contaminant.c
+++ b/drivers/usb/typec/tcpm/maxim_contaminant.c
@@ -188,6 +188,11 @@ static int max_contaminant_read_comparators(struct max_tcpci_chip *chip, u8 *ven
 	if (ret < 0)
 		return ret;
 
+	/* Disable low power mode */
+	ret = regmap_update_bits(regmap, TCPC_VENDOR_CC_CTRL2, CCLPMODESEL,
+				 FIELD_PREP(CCLPMODESEL,
+					    LOW_POWER_MODE_DISABLE));
+
 	/* Sleep to allow comparators settle */
 	usleep_range(5000, 6000);
 	ret = regmap_update_bits(regmap, TCPC_TCPC_CTRL, TCPC_TCPC_CTRL_ORIENTATION, PLUG_ORNT_CC1);
diff --git a/drivers/usb/typec/tcpm/tcpci_maxim.h b/drivers/usb/typec/tcpm/tcpci_maxim.h
index 76270d5c2838..b33540a42a95 100644
--- a/drivers/usb/typec/tcpm/tcpci_maxim.h
+++ b/drivers/usb/typec/tcpm/tcpci_maxim.h
@@ -21,6 +21,7 @@
 #define CCOVPDIS                                BIT(6)
 #define SBURPCTRL                               BIT(5)
 #define CCLPMODESEL                             GENMASK(4, 3)
+#define LOW_POWER_MODE_DISABLE                  0
 #define ULTRA_LOW_POWER_MODE                    1
 #define CCRPCTRL                                GENMASK(2, 0)
 #define UA_1_SRC                                1


