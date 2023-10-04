Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290D07B890A
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244063AbjJDSWK (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:22:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243717AbjJDSWK (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:22:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3938EA6
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:22:07 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C39EC433C9;
        Wed,  4 Oct 2023 18:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443726;
        bh=bur4L3VdTlXtyb9APi0MojiP/bgPqN+RQqK2yWdFr5M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gd4UFbZkUeUJGRqJkRBbu2e92OfN5ZkLDR9XUH2lLlxj+Ep8L2C5XJlsO55XXTwNo
         F4CNMNhjTuCviyi2kMbtxC6fhAHzfGHmBqYgTkXVwzrDBZsUZ+6sM5fYaM3Gao9uWu
         wTMasfiyc6JxDOsZE7pmWCcZz8Q5ZA0TPeUTBxv4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, wildjim@kiwinet.org,
        Mario Limonciello <mario.limonciello@amd.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.1 259/259] ASoC: amd: yc: Fix a non-functional mic on Lenovo 82TL
Date:   Wed,  4 Oct 2023 19:57:12 +0200
Message-ID: <20231004175229.296545075@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175217.404851126@linuxfoundation.org>
References: <20231004175217.404851126@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mario Limonciello <mario.limonciello@amd.com>

commit cfff2a7794d23b03a3ddedd318bf1df1876c598f upstream.

Lenovo 82TL has DMIC connected like 82V2 does.  Also match
82TL.

Reported-by: wildjim@kiwinet.org
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217063
Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Link: https://lore.kernel.org/r/20230906182257.45736-1-mario.limonciello@amd.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/amd/yc/acp6x-mach.c |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/sound/soc/amd/yc/acp6x-mach.c
+++ b/sound/soc/amd/yc/acp6x-mach.c
@@ -217,6 +217,13 @@ static const struct dmi_system_id yc_acp
 		.driver_data = &acp6x_card,
 		.matches = {
 			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
+			DMI_MATCH(DMI_PRODUCT_NAME, "82TL"),
+		}
+	},
+	{
+		.driver_data = &acp6x_card,
+		.matches = {
+			DMI_MATCH(DMI_BOARD_VENDOR, "LENOVO"),
 			DMI_MATCH(DMI_PRODUCT_NAME, "82QF"),
 		}
 	},


