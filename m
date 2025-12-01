Return-Path: <stable+bounces-197944-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8D1C986D1
	for <lists+stable@lfdr.de>; Mon, 01 Dec 2025 18:10:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 1BBE134492B
	for <lists+stable@lfdr.de>; Mon,  1 Dec 2025 17:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C7FC334C06;
	Mon,  1 Dec 2025 17:10:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qdlxxSqq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEC53191D3
	for <stable@vger.kernel.org>; Mon,  1 Dec 2025 17:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764609028; cv=none; b=k5NhbwtX4iMO29AQRckl6hEobZIWnbUnEVtRRWYlaR7UnMemwYcEn4lIE8U8HqS0z1orDdXM+e753jw0ee67G07IG5LEmL2da4z5be8uBE/uB52o+GqVEZjY0HUGVpUWxEVseoexOPX5H7gA8i5QRY5ofTOcKyt1P1H9eR7uwcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764609028; c=relaxed/simple;
	bh=ZdWAnp+dvIlAcziYNb5eK/wszK/0qAshzuSWkXPSp1k=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TLOQBcUNP5qjCwnNLySDVy11CztOvd0VFesCtqxNewEXY4abQu5R+qsuC1GWM8h6cnuBrFmzJpLvxcD4d2lYtDTygOg1Jk+fzXXANMkG/CDA6owFmlhRL8N58HkLJ/z/jd9EvskDu1w4Ym4HunRlpzJqZdoPvDF/GmQfaLHg+uI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qdlxxSqq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C01C116C6;
	Mon,  1 Dec 2025 17:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1764609027;
	bh=ZdWAnp+dvIlAcziYNb5eK/wszK/0qAshzuSWkXPSp1k=;
	h=Subject:To:Cc:From:Date:From;
	b=qdlxxSqqwYsf8xPWUCL+/KJn+RcNfAVvXXPVO2silNzH/RdSLaqSc6Ts3CZPR0EfK
	 uaz7qM4jla+xdJfs1+oME7wP7GKyjLUPD23f/T/agmRrMRbGghc4YQdesQbJpGNKGh
	 zda/+Xfo/AQWeyKPM0dHFF97TS2YTpU2Wdta5wGE=
Subject: FAILED: patch "[PATCH] usb: typec: ucsi: psy: Set max current to zero when" failed to apply to 6.1-stable tree
To: jthies@google.com,bleung@chromium.org,gregkh@linuxfoundation.org,heikki.krogerus@linux.intel.com,kenny@panix.com,sebastian.reichel@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 01 Dec 2025 18:10:16 +0100
Message-ID: <2025120116-bullwhip-geometry-eaa5@gregkh>
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
git cherry-pick -x 23379a17334fc24c4a9cbd9967d33dcd9323cc7c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025120116-bullwhip-geometry-eaa5@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

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


