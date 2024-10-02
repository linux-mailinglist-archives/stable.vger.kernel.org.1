Return-Path: <stable+bounces-80471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EE8F598DDAC
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 16:51:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86B2DB21369
	for <lists+stable@lfdr.de>; Wed,  2 Oct 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54F541D1726;
	Wed,  2 Oct 2024 14:47:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NU+bTcYb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C1FD1EB21;
	Wed,  2 Oct 2024 14:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727880469; cv=none; b=roKaYwYfv8SBoQkeHsPUO9ARb5HFkX7cLd9106wbwQrljJvwLcybJFLKXRIGNbBY2f09HsnVdAKRxURB34dBHz8TUW/+RPJWVnZumu1aZ2I88R5BUY2p3IIfTNGSKiIceFItXTikZIc3sm9ouby2YYaEXYt+0K9XyG7FJ+uD2NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727880469; c=relaxed/simple;
	bh=E5d/wVgP1Gqg1/SZ7rBf+uTDs/dobFN/0WQe9sFajro=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GVMctxWka0IgCyo2vsOyZ5vO7AaofEbHq62y59BFmecZtaL2DHfpklGBt5KVip0FQ1COubpHZ0j7jQVgZzxTl0MzHFfY6zKGA1OMy6nBCwAVo1kaLpdN9iNzCcW8cYr3WsVg7LNIXx/a16yX9rMG9o50RGXl1dV2nsfOZVahJks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NU+bTcYb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D08BC4CEC2;
	Wed,  2 Oct 2024 14:47:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1727880468;
	bh=E5d/wVgP1Gqg1/SZ7rBf+uTDs/dobFN/0WQe9sFajro=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NU+bTcYbutuSmpGYbwURysFTWttaqzIAQ4uWQ+Rw4TUmz87bLHyHbxIXHuqzkN+Dl
	 GR26HHExTxd4zPHxM4A5JGQy8CEKpfIo1xeklteq1DC/6SYDg4vzqU1tmUR2su5iXl
	 deNQ7I6vNGeSdQeoQwB6PnC2Ap3dop5JyhXgcJD4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pawel Laszczak <pawell@cadence.com>,
	Peter Chen <peter.chen@kernel.org>
Subject: [PATCH 6.6 437/538] usb: cdnsp: Fix incorrect usb_request status
Date: Wed,  2 Oct 2024 15:01:16 +0200
Message-ID: <20241002125809.689051208@linuxfoundation.org>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241002125751.964700919@linuxfoundation.org>
References: <20241002125751.964700919@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pawel Laszczak <pawell@cadence.com>

commit 1702bec4477cc7d31adb4a760d14d33fac928b7a upstream.

Fix changes incorrect usb_request->status returned during disabling
endpoints. Before fix the status returned during dequeuing requests
while disabling endpoint was ECONNRESET.
Patch change it to ESHUTDOWN.

Patch fixes issue detected during testing UVC gadget.
During stopping streaming the class starts dequeuing usb requests and
controller driver returns the -ECONNRESET status. After completion
requests the class or application "uvc-gadget" try to queue this
request again. Changing this status to ESHUTDOWN cause that UVC assumes
that endpoint is disabled, or device is disconnected and stops
re-queuing usb requests.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
cc: stable@vger.kernel.org
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Reviewed-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/PH7PR07MB9538E8CA7A2096AAF6A3718FDD9E2@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/cdns3/cdnsp-ring.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -718,7 +718,8 @@ int cdnsp_remove_request(struct cdnsp_de
 	seg = cdnsp_trb_in_td(pdev, cur_td->start_seg, cur_td->first_trb,
 			      cur_td->last_trb, hw_deq);
 
-	if (seg && (pep->ep_state & EP_ENABLED))
+	if (seg && (pep->ep_state & EP_ENABLED) &&
+	    !(pep->ep_state & EP_DIS_IN_RROGRESS))
 		cdnsp_find_new_dequeue_state(pdev, pep, preq->request.stream_id,
 					     cur_td, &deq_state);
 	else
@@ -736,7 +737,8 @@ int cdnsp_remove_request(struct cdnsp_de
 	 * During disconnecting all endpoint will be disabled so we don't
 	 * have to worry about updating dequeue pointer.
 	 */
-	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING) {
+	if (pdev->cdnsp_state & CDNSP_STATE_DISCONNECT_PENDING ||
+	    pep->ep_state & EP_DIS_IN_RROGRESS) {
 		status = -ESHUTDOWN;
 		ret = cdnsp_cmd_set_deq(pdev, pep, &deq_state);
 	}



