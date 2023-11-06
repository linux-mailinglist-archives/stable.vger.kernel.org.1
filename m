Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37EBE7E2434
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:19:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232371AbjKFNT2 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:19:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbjKFNTW (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:19:22 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 562D7BF
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:19:20 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9AA23C433C9;
        Mon,  6 Nov 2023 13:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276760;
        bh=FBnzIl7+ciMGdOZd6TkQVlhKw75gOo1HCfgsQzekWR0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F7iMF1+8VlREV7Ku4AhmkhD4Ty4IunbutVpW2lc5Y+7smMtqcUyKc/9E0O38Hzb5W
         ec+tPgECBzE9IPjFt83++k0PPjUqEJZ/kSFPjvK+jeNp19v5OPyATSlw223s/j1f7S
         mkuxwZQh2A5EKJq5jnaUTP9bWOeKpmEBEcYgYcYU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Hasemeyer <markhas@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.5 87/88] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection
Date:   Mon,  6 Nov 2023 14:04:21 +0100
Message-ID: <20231106130309.029384279@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130305.772449722@linuxfoundation.org>
References: <20231106130305.772449722@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Mark Hasemeyer <markhas@chromium.org>

commit 7c05b44e1a50d9cbfc4f731dddc436a24ddc129a upstream.

Some Jasperlake Chromebooks overwrite the system vendor DMI value to the
name of the OEM that manufactured the device. This breaks Chromebook
quirk detection as it expects the system vendor to be "Google".

Add another quirk detection entry that looks for "Google" in the BIOS
version.

Cc: stable@vger.kernel.org
Signed-off-by: Mark Hasemeyer <markhas@chromium.org>
Reviewed-by: Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Link: https://lore.kernel.org/r/20231018235944.1860717-1-markhas@chromium.org
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/hda/intel-dsp-config.c |    6 ++++++
 1 file changed, 6 insertions(+)

--- a/sound/hda/intel-dsp-config.c
+++ b/sound/hda/intel-dsp-config.c
@@ -343,6 +343,12 @@ static const struct config_entry config_
 					DMI_MATCH(DMI_SYS_VENDOR, "Google"),
 				}
 			},
+			{
+				.ident = "Google firmware",
+				.matches = {
+					DMI_MATCH(DMI_BIOS_VERSION, "Google"),
+				}
+			},
 			{}
 		}
 	},


