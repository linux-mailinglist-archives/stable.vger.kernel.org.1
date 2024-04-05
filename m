Return-Path: <stable+bounces-36004-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 12F0D89953D
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 08:25:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 454FB1C218F1
	for <lists+stable@lfdr.de>; Fri,  5 Apr 2024 06:25:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1AAA72232B;
	Fri,  5 Apr 2024 06:25:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="r/qFa0tJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCB533D76
	for <stable@vger.kernel.org>; Fri,  5 Apr 2024 06:25:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712298306; cv=none; b=Q0E0XhbBzvKgTAx+7Io9vYVe/lhKLzguobnEyXRUKTQWkrKJdEZwz6y/HXDfcCarZeIobRPuFDd4SVx6++rvqeE2u0y/Suu8syhCHEKoigMG4ZgqjyyKqWGhNfHB+d/j9ocS8f18KeVrsO4rUJFMdU+Qt2S95dB3T0D5KBItkkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712298306; c=relaxed/simple;
	bh=j1mC3nXC4PzC8dL0cSI3lrXX2b5s7S4zJo/I9oq38Do=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mw1Fqp37UWKjdyfXvfCslIFQiq2rejR4VDhReRssYS9+06E2Rt8s5GrWrF3BZ1hwpE06GsTiSHtUntTChOrg/dbIHFjI6Q96/uu1gDUjcJpm+wBhXVDxNnFVWLJpSGBEy65x2cLn8PB4VTnVBotqFNnn4R1YKEUixFVv0UV6Vys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=r/qFa0tJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32A6BC433C7;
	Fri,  5 Apr 2024 06:25:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1712298306;
	bh=j1mC3nXC4PzC8dL0cSI3lrXX2b5s7S4zJo/I9oq38Do=;
	h=Subject:To:Cc:From:Date:From;
	b=r/qFa0tJq/CRxv6ng5rWZzMqPrJbf4cfFbdhQ+7zMb0Gk2nvTRwz0ebpAK5QAjgtc
	 8k1VP2vHiO6marq5jUxg5UFF9PO3/trXvr4HfqColBVSfDbkWfg0u2vAV+4T4FlhMw
	 Ueqj1nJgjk1iZyBhrkAv3j5QV3dhj0ENfoKvloo0=
Subject: FAILED: patch "[PATCH] Bluetooth: add quirk for broken address properties" failed to apply to 5.15-stable tree
To: johan+linaro@kernel.org,dianders@chromium.org,luiz.von.dentz@intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 05 Apr 2024 08:24:58 +0200
Message-ID: <2024040558-rigid-bristle-8569@gregkh>
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
git cherry-pick -x 39646f29b100566451d37abc4cc8cdd583756dfe
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2024040558-rigid-bristle-8569@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 39646f29b100566451d37abc4cc8cdd583756dfe Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan+linaro@kernel.org>
Date: Wed, 20 Mar 2024 08:55:53 +0100
Subject: [PATCH] Bluetooth: add quirk for broken address properties

Some Bluetooth controllers lack persistent storage for the device
address and instead one can be provided by the boot firmware using the
'local-bd-address' devicetree property.

The Bluetooth devicetree bindings clearly states that the address should
be specified in little-endian order, but due to a long-standing bug in
the Qualcomm driver which reversed the address some boot firmware has
been providing the address in big-endian order instead.

Add a new quirk that can be set on platforms with broken firmware and
use it to reverse the address when parsing the property so that the
underlying driver bug can be fixed.

Fixes: 5c0a1001c8be ("Bluetooth: hci_qca: Add helper to set device address")
Cc: stable@vger.kernel.org      # 5.1
Reviewed-by: Douglas Anderson <dianders@chromium.org>
Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
Signed-off-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>

diff --git a/include/net/bluetooth/hci.h b/include/net/bluetooth/hci.h
index 8701ca5f31ee..5c12761cbc0e 100644
--- a/include/net/bluetooth/hci.h
+++ b/include/net/bluetooth/hci.h
@@ -176,6 +176,15 @@ enum {
 	 */
 	HCI_QUIRK_USE_BDADDR_PROPERTY,
 
+	/* When this quirk is set, the Bluetooth Device Address provided by
+	 * the 'local-bd-address' fwnode property is incorrectly specified in
+	 * big-endian order.
+	 *
+	 * This quirk can be set before hci_register_dev is called or
+	 * during the hdev->setup vendor callback.
+	 */
+	HCI_QUIRK_BDADDR_PROPERTY_BROKEN,
+
 	/* When this quirk is set, the duplicate filtering during
 	 * scanning is based on Bluetooth devices addresses. To allow
 	 * RSSI based updates, restart scanning if needed.
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index f6b662369322..639090b9f4b8 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -3416,7 +3416,10 @@ static void hci_dev_get_bd_addr_from_property(struct hci_dev *hdev)
 	if (ret < 0 || !bacmp(&ba, BDADDR_ANY))
 		return;
 
-	bacpy(&hdev->public_addr, &ba);
+	if (test_bit(HCI_QUIRK_BDADDR_PROPERTY_BROKEN, &hdev->quirks))
+		baswap(&hdev->public_addr, &ba);
+	else
+		bacpy(&hdev->public_addr, &ba);
 }
 
 struct hci_init_stage {


