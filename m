Return-Path: <stable+bounces-160467-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49693AFC644
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 10:55:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EFC53177FB3
	for <lists+stable@lfdr.de>; Tue,  8 Jul 2025 08:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCF152C08A6;
	Tue,  8 Jul 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YTIU0+/7"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8932C033E
	for <stable@vger.kernel.org>; Tue,  8 Jul 2025 08:54:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751964870; cv=none; b=OVH3Jb9s1xyRpanoFZ1kjWJ9EYLxViYQgHO7h1JbAV8jNlxJoDWc339wqn9HZhj6lmNeTxXA3KyS7o4vPPpq/lhQT9Hx5fghv+f7WR5zU8GhM+LPmToNLwT8faNPPcrD6ciFj5lzXlG3vroPsvhkJWiwQdcQ6wiMAJ0mLJIUias=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751964870; c=relaxed/simple;
	bh=1B/hIS6XTPb2IjK9e+D8xUh5a2S1RDKWTuxka/NS0xc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=bNmoRzjNUgbjy6hyI33wI5ItBCCSHyX3d91n/M5672cmq2xTlSYhMiht7/jyQmB9wzIvZ9a1Wf6TGrCG5YnB2JxH6sDO0hDy9gTG1d1XV13w7pWETeWnbwhKIsCkP64wzdCVCUO05nEWtpPqMnQEoJLv9wSTvJkw4AiCKpw6+FM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YTIU0+/7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA171C4CEF0;
	Tue,  8 Jul 2025 08:54:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1751964870;
	bh=1B/hIS6XTPb2IjK9e+D8xUh5a2S1RDKWTuxka/NS0xc=;
	h=Subject:To:Cc:From:Date:From;
	b=YTIU0+/72pa+bP/FfbrPZMxWtOi31e03P8TbdPgUKmRFufrrnZaPaFVzCtLOHM/p3
	 XDAgzwZbLhVg8iBZM4grNcxBnoy0Flzvvx25w9C3lQ7q+S99UvFwoY0aboAUuJfipU
	 2yDC8mNdf03GObT0tQcFPcFe2clj59MAnUBC5sw4=
Subject: FAILED: patch "[PATCH] usb: cdnsp: Fix issue with CV Bad Descriptor test" failed to apply to 5.15-stable tree
To: pawell@cadence.com,gregkh@linuxfoundation.org,peter.chen@kernel.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 08 Jul 2025 10:54:17 +0200
Message-ID: <2025070817-spongy-unlinked-9fe7@gregkh>
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
git cherry-pick -x 2831a81077f5162f104ba5a97a7d886eb371c21c
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025070817-spongy-unlinked-9fe7@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 2831a81077f5162f104ba5a97a7d886eb371c21c Mon Sep 17 00:00:00 2001
From: Pawel Laszczak <pawell@cadence.com>
Date: Fri, 20 Jun 2025 08:23:12 +0000
Subject: [PATCH] usb: cdnsp: Fix issue with CV Bad Descriptor test

The SSP2 controller has extra endpoint state preserve bit (ESP) which
setting causes that endpoint state will be preserved during
Halt Endpoint command. It is used only for EP0.
Without this bit the Command Verifier "TD 9.10 Bad Descriptor Test"
failed.
Setting this bit doesn't have any impact for SSP controller.

Fixes: 3d82904559f4 ("usb: cdnsp: cdns3 Add main part of Cadence USBSSP DRD Driver")
Cc: stable <stable@kernel.org>
Signed-off-by: Pawel Laszczak <pawell@cadence.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/PH7PR07MB95382CCD50549DABAEFD6156DD7CA@PH7PR07MB9538.namprd07.prod.outlook.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/cdns3/cdnsp-debug.h b/drivers/usb/cdns3/cdnsp-debug.h
index cd138acdcce1..86860686d836 100644
--- a/drivers/usb/cdns3/cdnsp-debug.h
+++ b/drivers/usb/cdns3/cdnsp-debug.h
@@ -327,12 +327,13 @@ static inline const char *cdnsp_decode_trb(char *str, size_t size, u32 field0,
 	case TRB_RESET_EP:
 	case TRB_HALT_ENDPOINT:
 		ret = scnprintf(str, size,
-				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c",
+				"%s: ep%d%s(%d) ctx %08x%08x slot %ld flags %c %c",
 				cdnsp_trb_type_string(type),
 				ep_num, ep_id % 2 ? "out" : "in",
 				TRB_TO_EP_INDEX(field3), field1, field0,
 				TRB_TO_SLOT_ID(field3),
-				field3 & TRB_CYCLE ? 'C' : 'c');
+				field3 & TRB_CYCLE ? 'C' : 'c',
+				field3 & TRB_ESP ? 'P' : 'p');
 		break;
 	case TRB_STOP_RING:
 		ret = scnprintf(str, size,
diff --git a/drivers/usb/cdns3/cdnsp-ep0.c b/drivers/usb/cdns3/cdnsp-ep0.c
index f317d3c84781..5cd9b898ce97 100644
--- a/drivers/usb/cdns3/cdnsp-ep0.c
+++ b/drivers/usb/cdns3/cdnsp-ep0.c
@@ -414,6 +414,7 @@ static int cdnsp_ep0_std_request(struct cdnsp_device *pdev,
 void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 {
 	struct usb_ctrlrequest *ctrl = &pdev->setup;
+	struct cdnsp_ep *pep;
 	int ret = -EINVAL;
 	u16 len;
 
@@ -427,10 +428,21 @@ void cdnsp_setup_analyze(struct cdnsp_device *pdev)
 		goto out;
 	}
 
+	pep = &pdev->eps[0];
+
 	/* Restore the ep0 to Stopped/Running state. */
-	if (pdev->eps[0].ep_state & EP_HALTED) {
-		trace_cdnsp_ep0_halted("Restore to normal state");
-		cdnsp_halt_endpoint(pdev, &pdev->eps[0], 0);
+	if (pep->ep_state & EP_HALTED) {
+		if (GET_EP_CTX_STATE(pep->out_ctx) == EP_STATE_HALTED)
+			cdnsp_halt_endpoint(pdev, pep, 0);
+
+		/*
+		 * Halt Endpoint Command for SSP2 for ep0 preserve current
+		 * endpoint state and driver has to synchronize the
+		 * software endpoint state with endpoint output context
+		 * state.
+		 */
+		pep->ep_state &= ~EP_HALTED;
+		pep->ep_state |= EP_STOPPED;
 	}
 
 	/*
diff --git a/drivers/usb/cdns3/cdnsp-gadget.h b/drivers/usb/cdns3/cdnsp-gadget.h
index 2afa3e558f85..a91cca509db0 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.h
+++ b/drivers/usb/cdns3/cdnsp-gadget.h
@@ -987,6 +987,12 @@ enum cdnsp_setup_dev {
 #define STREAM_ID_FOR_TRB(p)		((((p)) << 16) & GENMASK(31, 16))
 #define SCT_FOR_TRB(p)			(((p) << 1) & 0x7)
 
+/*
+ * Halt Endpoint Command TRB field.
+ * The ESP bit only exists in the SSP2 controller.
+ */
+#define TRB_ESP				BIT(9)
+
 /* Link TRB specific fields. */
 #define TRB_TC				BIT(1)
 
diff --git a/drivers/usb/cdns3/cdnsp-ring.c b/drivers/usb/cdns3/cdnsp-ring.c
index 757fdd918286..0758f171f73e 100644
--- a/drivers/usb/cdns3/cdnsp-ring.c
+++ b/drivers/usb/cdns3/cdnsp-ring.c
@@ -2485,7 +2485,8 @@ void cdnsp_queue_halt_endpoint(struct cdnsp_device *pdev, unsigned int ep_index)
 {
 	cdnsp_queue_command(pdev, 0, 0, 0, TRB_TYPE(TRB_HALT_ENDPOINT) |
 			    SLOT_ID_FOR_TRB(pdev->slot_id) |
-			    EP_ID_FOR_TRB(ep_index));
+			    EP_ID_FOR_TRB(ep_index) |
+			    (!ep_index ? TRB_ESP : 0));
 }
 
 void cdnsp_force_header_wakeup(struct cdnsp_device *pdev, int intf_num)


