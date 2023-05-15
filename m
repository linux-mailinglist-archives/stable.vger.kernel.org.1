Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDFB703892
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:33:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243181AbjEORdN (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:33:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244252AbjEORcp (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B951120AC
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:30:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3D8E62D2D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:30:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F60C433D2;
        Mon, 15 May 2023 17:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171834;
        bh=B4NmIIfCyZvHfNU7wknHF7dbItUFAbYJvEYS6Jdg7Nw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OH1SDHRaenhX6uI7pEN616x5eaknXrTYM9/Rua05X5hZmH/XHBuXqzZQZXbsVZG72
         fPNOCWNziwdNHzKEFNMgNN1xLGTqjtEjPE4rhXIUwjjA+QGsvJfvDMdv9fIPBw8Vf5
         y7v9B52kBruOn120eIirl1iFTqk7fDhBAqTjerlI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ping Cheng <ping.cheng@wacom.com>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [PATCH 5.15 094/134] HID: wacom: Set a default resolution for older tablets
Date:   Mon, 15 May 2023 18:29:31 +0200
Message-Id: <20230515161706.288201535@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Ping Cheng <pinglinux@gmail.com>

commit 08a46b4190d345544d04ce4fe2e1844b772b8535 upstream.

Some older tablets may not report physical maximum for X/Y
coordinates. Set a default to prevent undefined resolution.

Signed-off-by: Ping Cheng <ping.cheng@wacom.com>
Link: https://lore.kernel.org/r/20230409164229.29777-1-ping.cheng@wacom.com
Signed-off-by: Benjamin Tissoires <benjamin.tissoires@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/hid/wacom_wac.c |   12 ++++++++++--
 1 file changed, 10 insertions(+), 2 deletions(-)

--- a/drivers/hid/wacom_wac.c
+++ b/drivers/hid/wacom_wac.c
@@ -1857,6 +1857,7 @@ static void wacom_map_usage(struct input
 	int fmax = field->logical_maximum;
 	unsigned int equivalent_usage = wacom_equivalent_usage(usage->hid);
 	int resolution_code = code;
+	int resolution = hidinput_calc_abs_res(field, resolution_code);
 
 	if (equivalent_usage == HID_DG_TWIST) {
 		resolution_code = ABS_RZ;
@@ -1877,8 +1878,15 @@ static void wacom_map_usage(struct input
 	switch (type) {
 	case EV_ABS:
 		input_set_abs_params(input, code, fmin, fmax, fuzz, 0);
-		input_abs_set_res(input, code,
-				  hidinput_calc_abs_res(field, resolution_code));
+
+		/* older tablet may miss physical usage */
+		if ((code == ABS_X || code == ABS_Y) && !resolution) {
+			resolution = WACOM_INTUOS_RES;
+			hid_warn(input,
+				 "Wacom usage (%d) missing resolution \n",
+				 code);
+		}
+		input_abs_set_res(input, code, resolution);
 		break;
 	case EV_KEY:
 	case EV_MSC:


