Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7E8735281
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:35:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229694AbjFSKfm (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:35:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231646AbjFSKfP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:35:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C002FE62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:35:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F8B560B67
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:35:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38525C433C8;
        Mon, 19 Jun 2023 10:35:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170913;
        bh=4Ggte3LL8Y0t1ym8WwxE8dj0qFYZO6F1xMw0k6sg6Rk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LH0I3846ZyBWvx0rY0UvJTTzAAs7imp3/G+AWSc9D0PKjYzlq+VaIXqViv6Ms4UQy
         lbWfjhUJilO0l6h/wNv0xhPNBj/tzexzoV4KJT80Y7kZ4jPJkmte41JHp5NQC8sewD
         /UnCYUzRBE+62D7eAOmAPZozVvoprEbgWWp9iis4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Mario Limonciello <mario.limonciello@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Stylon Wang <stylon.wang@amd.com>,
        Peichen Huang <peichen.huang@amd.com>,
        Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>,
        Daniel Wheeler <daniel.wheeler@amd.com>
Subject: [PATCH 6.3 081/187] drm/amd/display: limit DPIA link rate to HBR3
Date:   Mon, 19 Jun 2023 12:28:19 +0200
Message-ID: <20230619102201.527489526@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Peichen Huang <peichen.huang@amd.com>

commit 7c5835bcb9176df94683396f1c0e5df6bf5094b3 upstream.

[Why]
DPIA doesn't support UHBR, driver should not enable UHBR
for dp tunneling

[How]
limit DPIA link rate to HBR3

Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Acked-by: Stylon Wang <stylon.wang@amd.com>
Signed-off-by: Peichen Huang <peichen.huang@amd.com>
Reviewed-by: Mustapha Ghaddar <Mustapha.Ghaddar@amd.com>
Tested-by: Daniel Wheeler <daniel.wheeler@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/gpu/drm/amd/display/dc/link/link_detection.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/drivers/gpu/drm/amd/display/dc/link/link_detection.c
+++ b/drivers/gpu/drm/amd/display/dc/link/link_detection.c
@@ -980,6 +980,11 @@ static bool detect_link_and_local_sink(s
 					(link->dpcd_caps.dongle_type !=
 							DISPLAY_DONGLE_DP_HDMI_CONVERTER))
 				converter_disable_audio = true;
+
+			/* limited link rate to HBR3 for DPIA until we implement USB4 V2 */
+			if (link->ep_type == DISPLAY_ENDPOINT_USB4_DPIA &&
+					link->reported_link_cap.link_rate > LINK_RATE_HIGH3)
+				link->reported_link_cap.link_rate = LINK_RATE_HIGH3;
 			break;
 		}
 


