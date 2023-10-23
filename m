Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3555C7D30F8
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233342AbjJWLEL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:04:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233339AbjJWLEA (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:04:00 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9650F10E7
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:03:55 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF7DBC433C8;
        Mon, 23 Oct 2023 11:03:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059035;
        bh=pAdG5+Gn4vIj5XyQYkxrnWO4cT+XsKsGHEu2iOtHiMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=xfGXBaiR+cfT+GPSowMDz+VNYwPPf/I7MgNzMzG4rwik09uTcUBZkho3+P20uZ+3G
         JiUtcQre3x6ZQbYWckvWCeqZ5R/Ag5bMIvbDBRkQFqJVxyq2sxjoHMj/lIFHd7oPy+
         6L55+/CH0OTuP5uUjvmdVxZRJart43hJpzBg0BKk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Harry Wentland <harry.wentland@amd.com>,
        Hamza Mahfooz <hamza.mahfooz@amd.com>
Subject: [PATCH 6.5 042/241] drm/edid: add 8 bpc quirk to the BenQ GW2765
Date:   Mon, 23 Oct 2023 12:53:48 +0200
Message-ID: <20231023104834.943643237@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Hamza Mahfooz <hamza.mahfooz@amd.com>

commit 88630e91f12677848c0c4a5790ec0d691f8859fa upstream.

The BenQ GW2765 reports that it supports higher (> 8) bpc modes, but
when trying to set them we end up with a black screen. So, limit it to 8
bpc modes.

Cc: stable@vger.kernel.org # 6.5+
Link: https://gitlab.freedesktop.org/drm/amd/-/issues/2610
Reviewed-by: Harry Wentland <harry.wentland@amd.com>
Signed-off-by: Hamza Mahfooz <hamza.mahfooz@amd.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20231012184927.133137-1-hamza.mahfooz@amd.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/drm_edid.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/gpu/drm/drm_edid.c b/drivers/gpu/drm/drm_edid.c
index 340da8257b51..4b71040ae5be 100644
--- a/drivers/gpu/drm/drm_edid.c
+++ b/drivers/gpu/drm/drm_edid.c
@@ -123,6 +123,9 @@ static const struct edid_quirk {
 	/* AEO model 0 reports 8 bpc, but is a 6 bpc panel */
 	EDID_QUIRK('A', 'E', 'O', 0, EDID_QUIRK_FORCE_6BPC),
 
+	/* BenQ GW2765 */
+	EDID_QUIRK('B', 'N', 'Q', 0x78d6, EDID_QUIRK_FORCE_8BPC),
+
 	/* BOE model on HP Pavilion 15-n233sl reports 8 bpc, but is a 6 bpc panel */
 	EDID_QUIRK('B', 'O', 'E', 0x78b, EDID_QUIRK_FORCE_6BPC),
 
-- 
2.42.0



