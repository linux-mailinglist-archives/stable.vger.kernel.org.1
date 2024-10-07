Return-Path: <stable+bounces-81448-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9C1993503
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 19:29:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DDFFB1F23951
	for <lists+stable@lfdr.de>; Mon,  7 Oct 2024 17:29:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E7CF31DD553;
	Mon,  7 Oct 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XZwq86Ot"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 987071DCB06
	for <stable@vger.kernel.org>; Mon,  7 Oct 2024 17:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728322179; cv=none; b=J55CLjvIN+NHwSavLX1/KXSWFxJdLX6Q+z0upoaMg8oKOclAcJ31xnBtkzUrf0a3RE1AX6LzJarrUC8o+NAuPG6Z5cuJiTK4kGOkdygIRsYEVJYcvTF3rCGZ5xvesz24VzdcwwGO6J7Pmr56mpBi67HbNsTmHkgzyePDESP4WXc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728322179; c=relaxed/simple;
	bh=iD0t951VHh6kfdq6l20bSIPFPG65JBDgOKyaLRqMD5Q=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=W49f0ALvAA6ygnC5gifDa8Q7WptqgX1uPzkL/I0XgPB7iQTBUBbd0MRza63EoqoMBuKUZAJuVeg8GQnpK+utEE7bbChwNa043Xhivz+nl5mccCYtZb8c0T+/dNLbexrbTi5yXtXCRh9bAG8TJR7XFWSbREgIeB3zihkbAd0eIGI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XZwq86Ot; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A95CFC4CEC7;
	Mon,  7 Oct 2024 17:29:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728322179;
	bh=iD0t951VHh6kfdq6l20bSIPFPG65JBDgOKyaLRqMD5Q=;
	h=Subject:To:Cc:From:Date:From;
	b=XZwq86OtD1lyivEEtl8Gm47DHwt58pTpp1cq/LwB0zQKsj0/+b63ymAFIg5XM9Wk+
	 DAURsgcnPxxYKSjL1WK7YrLuzsvO2ZznYgRwFhibB++cQpxjU4RgqPTPpn16tg57QS
	 OS05YMiNLlOEB0QaqSt41MPp2TQ14Ro6IaXJ8Y2w=
Subject: FAILED: patch "[PATCH] Bluetooth: hci_event: Align BR/EDR JUST_WORKS paring with LE" failed to apply to 5.10-stable tree
To: luiz.von.dentz@intel.com,kiran.k@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 07 Oct 2024 19:29:27 +0200
Message-ID: <2024100727-emission-slot-94cc@gregkh>
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
git cherry-pick -x b25e11f978b63cb7857890edb3a698599cddb10e
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024100727-emission-slot-94cc@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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
6f6ff38a1e14 ("Bluetooth: hci_sync: Convert MGMT_OP_SET_LOCAL_NAME")
cf75ad8b41d2 ("Bluetooth: hci_sync: Convert MGMT_SET_POWERED")
ad383c2c65a5 ("Bluetooth: hci_sync: Enable advertising when LL privacy is enabled")
e8907f76544f ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 3")
cba6b758711c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 2")
161510ccf91c ("Bluetooth: hci_sync: Make use of hci_cmd_sync_queue set 1")
6a98e3836fa2 ("Bluetooth: Add helper for serialized HCI command execution")
4139ff008330 ("Bluetooth: Fix wrong opcode when LL privacy enabled")
01ce70b0a274 ("Bluetooth: eir: Move EIR/Adv Data functions to its own file")
5031ffcc79b8 ("Bluetooth: Keep MSFT ext info throughout a hci_dev's life cycle")

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


