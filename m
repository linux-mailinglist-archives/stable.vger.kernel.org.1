Return-Path: <stable+bounces-38961-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F15AE8A113B
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 12:42:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1E5491C23D6A
	for <lists+stable@lfdr.de>; Thu, 11 Apr 2024 10:42:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 506AE146D52;
	Thu, 11 Apr 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GGwWuVr1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFDB143C76;
	Thu, 11 Apr 2024 10:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712832107; cv=none; b=izRXI8A9Zez/VWRUr6b09vFnZfc7/baWpod13QGp++weldAFee5ioWIVZ6jsU2UAJbSTfOUZgxr/zVuxA3+/quy1mN8lB70u5/XBeRZP9ufTDJaBo3xcTah/2BGlQgZLRC0DLPVat099Jr5eZsRa22qNNFq1zkZH6jpv/JHOhLM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712832107; c=relaxed/simple;
	bh=8zKjSgCA93zFxwYX7nUARuwh4IMSs1fWhCvyXDsQMTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OuX8vVNB0lEjgQmNuv5tVA2NWMpbO4WQPe+D5TKZIvx+gZq5cUbWJUHbVkPZ1qcR0UmGP5kpGhA7Rxbosn74Z1WtxwuJVch7iaTyZNVmL8UuwxB/isMGVTwCpMi9sjLrNfZ7IpXpJUNwPmvZ+O4A1oLfOHB0NsMjAUI5+gj5ypU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GGwWuVr1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A570C433F1;
	Thu, 11 Apr 2024 10:41:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712832106;
	bh=8zKjSgCA93zFxwYX7nUARuwh4IMSs1fWhCvyXDsQMTY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GGwWuVr1rMSTGSyAk+cZtnnBD48MvOgHvqcm/jlFSP5G4TzPa5rKDGKeVjywZCE5G
	 FgY+rtB3GQwO65FJINTMgeYkmQ3xmDOBNGVlQ/OpDhVzzPQ42SoNbEaUykJhLZxLel
	 M8ycVqMSy5lwp/AeJcMh//nbVbixGfWjDPlBs/P0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Gui-Dong Han <2045gemini@gmail.com>,
	Bastien Nocera <hadess@hadess.net>,
	Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Subject: [PATCH 5.10 192/294] Bluetooth: Fix TOCTOU in HCI debugfs implementation
Date: Thu, 11 Apr 2024 11:55:55 +0200
Message-ID: <20240411095441.394776245@linuxfoundation.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240411095435.633465671@linuxfoundation.org>
References: <20240411095435.633465671@linuxfoundation.org>
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

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Bastien Nocera <hadess@hadess.net>

commit 7835fcfd132eb88b87e8eb901f88436f63ab60f7 upstream.

struct hci_dev members conn_info_max_age, conn_info_min_age,
le_conn_max_interval, le_conn_min_interval, le_adv_max_interval,
and le_adv_min_interval can be modified from the HCI core code, as well
through debugfs.

The debugfs implementation, that's only available to privileged users,
will check for boundaries, making sure that the minimum value being set
is strictly above the maximum value that already exists, and vice-versa.

However, as both minimum and maximum values can be changed concurrently
to us modifying them, we need to make sure that the value we check is
the value we end up using.

For example, with ->conn_info_max_age set to 10, conn_info_min_age_set()
gets called from vfs handlers to set conn_info_min_age to 8.

In conn_info_min_age_set(), this goes through:
	if (val == 0 || val > hdev->conn_info_max_age)
		return -EINVAL;

Concurrently, conn_info_max_age_set() gets called to set to set the
conn_info_max_age to 7:
	if (val == 0 || val > hdev->conn_info_max_age)
		return -EINVAL;
That check will also pass because we used the old value (10) for
conn_info_max_age.

After those checks that both passed, the struct hci_dev access
is mutex-locked, disabling concurrent access, but that does not matter
because the invalid value checks both passed, and we'll end up with
conn_info_min_age = 8 and conn_info_max_age = 7

To fix this problem, we need to lock the structure access before so the
check and assignment are not interrupted.

This fix was originally devised by the BassCheck[1] team, and
considered the problem to be an atomicity one. This isn't the case as
there aren't any concerns about the variable changing while we check it,
but rather after we check it parallel to another change.

This patch fixes CVE-2024-24858 and CVE-2024-24857.

[1] https://sites.google.com/view/basscheck/

Co-developed-by: Gui-Dong Han <2045gemini@gmail.com>
Signed-off-by: Gui-Dong Han <2045gemini@gmail.com>
Link: https://lore.kernel.org/linux-bluetooth/20231222161317.6255-1-2045gemini@gmail.com/
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-24858
Link: https://lore.kernel.org/linux-bluetooth/20231222162931.6553-1-2045gemini@gmail.com/
Link: https://lore.kernel.org/linux-bluetooth/20231222162310.6461-1-2045gemini@gmail.com/
Link: https://nvd.nist.gov/vuln/detail/CVE-2024-24857
Fixes: 31ad169148df ("Bluetooth: Add conn info lifetime parameters to debugfs")
Fixes: 729a1051da6f ("Bluetooth: Expose default LE advertising interval via debugfs")
Fixes: 71c3b60ec6d2 ("Bluetooth: Move BR/EDR debugfs file creation into hci_debugfs.c")
Signed-off-by: Bastien Nocera <hadess@hadess.net>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/bluetooth/hci_debugfs.c |   48 +++++++++++++++++++++++++++++---------------
 1 file changed, 32 insertions(+), 16 deletions(-)

--- a/net/bluetooth/hci_debugfs.c
+++ b/net/bluetooth/hci_debugfs.c
@@ -216,10 +216,12 @@ static int conn_info_min_age_set(void *d
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val > hdev->conn_info_max_age)
+	hci_dev_lock(hdev);
+	if (val == 0 || val > hdev->conn_info_max_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_min_age = val;
 	hci_dev_unlock(hdev);
 
@@ -244,10 +246,12 @@ static int conn_info_max_age_set(void *d
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val < hdev->conn_info_min_age)
+	hci_dev_lock(hdev);
+	if (val == 0 || val < hdev->conn_info_min_age) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->conn_info_max_age = val;
 	hci_dev_unlock(hdev);
 
@@ -526,10 +530,12 @@ static int sniff_min_interval_set(void *
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val > hdev->sniff_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -554,10 +560,12 @@ static int sniff_max_interval_set(void *
 {
 	struct hci_dev *hdev = data;
 
-	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
+	hci_dev_lock(hdev);
+	if (val == 0 || val % 2 || val < hdev->sniff_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->sniff_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -798,10 +806,12 @@ static int conn_min_interval_set(void *d
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val > hdev->le_conn_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -826,10 +836,12 @@ static int conn_max_interval_set(void *d
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0006 || val > 0x0c80 || val < hdev->le_conn_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_conn_max_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -938,10 +950,12 @@ static int adv_min_interval_set(void *da
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val > hdev->le_adv_max_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_min_interval = val;
 	hci_dev_unlock(hdev);
 
@@ -966,10 +980,12 @@ static int adv_max_interval_set(void *da
 {
 	struct hci_dev *hdev = data;
 
-	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval)
+	hci_dev_lock(hdev);
+	if (val < 0x0020 || val > 0x4000 || val < hdev->le_adv_min_interval) {
+		hci_dev_unlock(hdev);
 		return -EINVAL;
+	}
 
-	hci_dev_lock(hdev);
 	hdev->le_adv_max_interval = val;
 	hci_dev_unlock(hdev);
 



