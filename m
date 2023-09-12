Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26C079BEDF
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjIKVaa (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:30:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242162AbjIKPX5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:23:57 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4733ED8
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:23:53 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83F7BC433C8;
        Mon, 11 Sep 2023 15:23:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694445832;
        bh=qYbKvh7XiLBB0p0MDxIUihMJPsrrG8HE3cRzplQUoKs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VdsBN3I3hcKiQ1rJZMUS/b+wTbzpw43HPkpCeY3Jd2zInSvc3SJCIG9Cm7VMiBEmq
         edZMRruOdpDIdaEKIknklTU422GQlp/lHV6SrvHFdXq380SZnUjgNNGD8A2KJ5YGeJ
         dJJclnLi7fJFkHz/JwPnVcH6KquKgCESIYasg/RU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nils Fuhler <nils@nilsfuhler.de>,
        Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 461/600] HID: input: Support devices sending Eraser without Invert
Date:   Mon, 11 Sep 2023 15:48:14 +0200
Message-ID: <20230911134647.260780286@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>

[ Upstream commit 276e14e6c3993317257e1787e93b7166fbc30905 ]

Some digitizers (notably XP-Pen Artist 24) do not report the Invert
usage when erasing.  This causes the device to be permanently stuck with
the BTN_TOOL_RUBBER tool after sending Eraser, as Invert is the only
usage that can release the tool.  In this state, Touch and Inrange are
no longer reported to userspace, rendering the pen unusable.

Prior to commit 87562fcd1342 ("HID: input: remove the need for
HID_QUIRK_INVERT"), BTN_TOOL_RUBBER was never set and Eraser events were
simply translated into BTN_TOUCH without causing an inconsistent state.

Introduce HID_QUIRK_NOINVERT for such digitizers and detect them during
hidinput_configure_usage().  This quirk causes the tool to be released
as soon as Eraser is reported as not set.  Set BTN_TOOL_RUBBER in
input->keybit when mapping Eraser.

Fixes: 87562fcd1342 ("HID: input: remove the need for HID_QUIRK_INVERT")
Co-developed-by: Nils Fuhler <nils@nilsfuhler.de>
Signed-off-by: Nils Fuhler <nils@nilsfuhler.de>
Signed-off-by: Illia Ostapyshyn <ostapyshyn@sra.uni-hannover.de>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-input.c | 18 ++++++++++++++++--
 include/linux/hid.h     |  1 +
 2 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index 3acaaca888acd..77ee5e01e6111 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -961,6 +961,7 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 			return;
 
 		case 0x3c: /* Invert */
+			device->quirks &= ~HID_QUIRK_NOINVERT;
 			map_key_clear(BTN_TOOL_RUBBER);
 			break;
 
@@ -986,9 +987,13 @@ static void hidinput_configure_usage(struct hid_input *hidinput, struct hid_fiel
 		case 0x45: /* ERASER */
 			/*
 			 * This event is reported when eraser tip touches the surface.
-			 * Actual eraser (BTN_TOOL_RUBBER) is set by Invert usage when
-			 * tool gets in proximity.
+			 * Actual eraser (BTN_TOOL_RUBBER) is set and released either
+			 * by Invert if tool reports proximity or by Eraser directly.
 			 */
+			if (!test_bit(BTN_TOOL_RUBBER, input->keybit)) {
+				device->quirks |= HID_QUIRK_NOINVERT;
+				set_bit(BTN_TOOL_RUBBER, input->keybit);
+			}
 			map_key_clear(BTN_TOUCH);
 			break;
 
@@ -1532,6 +1537,15 @@ void hidinput_hid_event(struct hid_device *hid, struct hid_field *field, struct
 		else if (report->tool != BTN_TOOL_RUBBER)
 			/* value is off, tool is not rubber, ignore */
 			return;
+		else if (*quirks & HID_QUIRK_NOINVERT &&
+			 !test_bit(BTN_TOUCH, input->key)) {
+			/*
+			 * There is no invert to release the tool, let hid_input
+			 * send BTN_TOUCH with scancode and release the tool after.
+			 */
+			hid_report_release_tool(report, input, BTN_TOOL_RUBBER);
+			return;
+		}
 
 		/* let hid-input set BTN_TOUCH */
 		break;
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 0a1ccc68e798a..784dd6b6046eb 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -357,6 +357,7 @@ struct hid_item {
 #define HID_QUIRK_NO_OUTPUT_REPORTS_ON_INTR_EP	BIT(18)
 #define HID_QUIRK_HAVE_SPECIAL_DRIVER		BIT(19)
 #define HID_QUIRK_INCREMENT_USAGE_ON_DUPLICATE	BIT(20)
+#define HID_QUIRK_NOINVERT			BIT(21)
 #define HID_QUIRK_FULLSPEED_INTERVAL		BIT(28)
 #define HID_QUIRK_NO_INIT_REPORTS		BIT(29)
 #define HID_QUIRK_NO_IGNORE			BIT(30)
-- 
2.40.1



