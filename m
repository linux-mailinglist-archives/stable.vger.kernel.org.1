Return-Path: <stable+bounces-81447-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05577993502
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:29:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 364F31C22648
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:29:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EE581DD54F;
	Mon,  7 Oct 2024 17:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hSEFkGQC"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E7381DA2E5
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322171; cv=none; b=g8P43YDXwY1j5h92YLOdXLAV5Tx61aSDpHY4Eka9GhDulppX4rrjBsbtM3t+nR/b7sduKuGDxuya+y3+NeDOCe3hYWnTHdOESNtL8bLS7QaK34dUwISJwfQWKhDZoUXRwTUSdMrSJFdItDa2yj4R0qSBIS7gpNi+VrjegEVD4G8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322171; c=relaxed/simple;
	bh=zUZX5oMxhlJZyl5VoOAbtJcXr53oyd47aSCVb7yA/uE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ShV+dMckTb3OSxW4hjkQ+pt0YPp0a9WIvi4voYkTgm0vupiwDd6ekPuvergoDZ4XIur53p2z+yeBBEGAdh7aCu0vAvSu4RIKGrnO7Af0ZsenJwqS+I8fkQwA+fw3pdIvOGBrgGRNzqkBB+ejlfMtfPfMsOwLutQXxy/sXNttiFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hSEFkGQC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0136CC4CEC6;
	Mon,  7 Oct 2024 17:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728322170;
	bh=zUZX5oMxhlJZyl5VoOAbtJcXr53oyd47aSCVb7yA/uE=;
	h=Subject:To:Cc:From:Date:From;
	b=hSEFkGQCseuIDPE4Tgf4F87S0SpFpUoTKJGPAKBBlTRi3kyfOAkJG4+0FjRFgZY2t
	 2vomytFNGp6TGKWNea68j6A96Y2QTuazUOzcEQb0Fpw5krYRUksFGz4uE5BRiU1Hxb
	 agjXIgtXMQsPI7oWVsvx7wYJqljzWOhfwIIFoi7U=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE" failed to apply to 5.15-stable tree
To: luiz.von.dentz@intel.com,kiran.k@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:29:27 +0200
Message-ID: <2024100727-switch-reaffirm-2dec@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x b25e11f978b63cb7857890edb3a698599cddb10e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100727-switch-reaffirm-2dec@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:

b25e11f978b6 ("Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE")
3e54c5890c87 ("Bluetooth: hci_event: Use of a function table to handle HCI events")
12cfe4176ad6 ("Bluetooth: HCI: Use skb_pull_data to parse LE Metaevents")
70a6b8de6af5 ("Bluetooth: HCI: Use skb_pull_data to parse Extended Inquiry Result event")
8d08d324fdcb ("Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result with RSSI event")
27d9eb4bcac1 ("Bluetooth: HCI: Use skb_pull_data to parse Inquiry Result event")
aadc3d2f42a5 ("Bluetooth: HCI: Use skb_pull_data to parse Number of Complete Packets event")
e3f3a1aea871 ("Bluetooth: HCI: Use skb_pull_data to parse Command Complete event")
ae61a10d9d46 ("Bluetooth: HCI: Use skb_pull_data to parse BR/EDR events")
3244845c6307 ("Bluetooth: hci_sync: Convert MGMT_OP_SSP")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b25e11f978b63cb7857890edb3a698599cddb10e Mon Sep 17 00:00:00 2001
From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Date: Thu, 12 Sep 2024 12:17:00 -0400
Subject: [PATCH] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE

This aligned BR/EDR JUST_WORKS method with LE which since 92516cd97fd4
("Bluetooth: Always request for user confirmation for Just Works")
always request user confirmation with confirm_hint set since the
likes of bluetoothd have dedicated policy around JUST_WORKS method
(e.g. main.conf:JustWorksRepairing).

CVE: CVE-2024-8805
Cc: stable@vger.kernel.org
Fixes: ba15a58b179e ("Bluetooth: Fix SSP acceptor just-works confirmation without MITM")
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
Tested-by: Kiran K <kiran.k@intel.com>

diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index b87c0f1dab9e..561c8cb87473 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -5324,19 +5324,16 @@ static void hci_user_confirm_request_evt(struct hci_dev *hdev, void *data,
 		goto unlock;
 	}
 
-	/* If no side requires MITM protection; auto-accept */
+	/* If no side requires MITM protection; use JUST_CFM method */
 	if ((!loc_mitm || conn->remote_cap == HCI_IO_NO_INPUT_OUTPUT) &&
 	    (!rem_mitm || conn->io_capability == HCI_IO_NO_INPUT_OUTPUT)) {
 
-		/* If we're not the initiators request authorization to
-		 * proceed from user space (mgmt_user_confirm with
-		 * confirm_hint set to 1). The exception is if neither
-		 * side had MITM or if the local IO capability is
-		 * NoInputNoOutput, in which case we do auto-accept
+		/* If we're not the initiator of request authorization and the
+		 * local IO capability is not NoInputNoOutput, use JUST_WORKS
+		 * method (mgmt_user_confirm with confirm_hint set to 1).
 		 */
 		if (!test_bit(HCI_CONN_AUTH_PEND, &conn->flags) &&
-		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT &&
-		    (loc_mitm || rem_mitm)) {
+		    conn->io_capability != HCI_IO_NO_INPUT_OUTPUT) {
 			bt_dev_dbg(hdev, "Confirming auto-accept as acceptor");
 			confirm_hint = 1;
 			goto confirm;


