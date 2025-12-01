Return-Path: <stable+bounces-197943-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C7825C986E6
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:11:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id E152E4E2A57
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:10:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98920335BAF;
	Mon,  1 Dec 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="KxL1mlYg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 546133358DE
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 17:10:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609019; cv=none; b=MdUChpnydOeuoeuedqZNGEXD57Got8grtXgCWUK9eEMPgvgbNNugCVZ+hHrH6+cFZ9x3b3TrOk0T5EbyS4x1gWl/S9CV6TwiBkuYDo1DXrrayky7jL8xi/wPRLI2P88p8M6RoIjBvhi36MS88NEsyhUN0rVeTnTL3BQiJDZKh78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609019; c=relaxed/simple;
	bh=IYmHXcQ6W62OaZL/6avR6/qS/fqt8VJFrJdRJ2QT+lQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ECyfleZx/MnMsXj3AmNnwEtmvyQ1u3iZzK540dgax+EYA/8XZ7+tcJjzSf7XsqQfBEs63Dg9gcO3PORYKspYQEKsWguEyDKVTRVxbAuOG+k7GY+jpWraVkYrDGY6NJc+9T6HWG5267DKZ8zH7hJC6rpX8nNJkKdPxDQrvZTQNrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=KxL1mlYg; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68B94C16AAE;
	Mon,  1 Dec 2025 17:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764609018;
	bh=IYmHXcQ6W62OaZL/6avR6/qS/fqt8VJFrJdRJ2QT+lQ=;
	h=Subject:To:Cc:From:Date:From;
	b=KxL1mlYgWzKW5B/5O6EtaFQQ+j7tNzpFDeHE2gDwBtlyi0LHZDQX41iebKsxtBVu3
	 sj+msZ70fTO8wurNaUJEt+I/RFxnMxaOqfDp8Wmr2e/rysKHd6lfKJ6xIHk3/EXJ6x
	 FLD66LDYzjoF8+ft+JqbrwmQM/pbWc5WXBGqibOg=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: psy: Set max current to zero when" failed to apply to 6.12-stable tree
To: jthies@google.com,bleung@chromium.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,kenny@panix.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 18:10:15 +0100
Message-ID: <2025120115-ascension-acre-a1d0@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 23379a17334fc24c4a9cbd9967d33dcd9323cc7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120115-ascension-acre-a1d0@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

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


