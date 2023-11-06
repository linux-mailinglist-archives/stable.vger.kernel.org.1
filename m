Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F9687E23D1
	for <lists+stable@lfdr.de>; Mon,  6 Nov 2023 14:14:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbjKFNO6 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 6 Nov 2023 08:14:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232223AbjKFNO5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 6 Nov 2023 08:14:57 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EAE194
        for <stable@vger.kernel.org>; Mon,  6 Nov 2023 05:14:55 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57B8CC433C7;
        Mon,  6 Nov 2023 13:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1699276494;
        bh=JUskU+19kz06Vq7xcxKvRgwwmzRLtvBAYQQHw8it+V0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=uIyZZEzBuqNdk3wgEOHoV+Z6eXIKaeRzsfXG30KiQgbSbby4jaG014SuXJNqz4PRx
         e8SbtBk7NCfhljVW/pLrgn2LFuNln6jBzOpKkIepVgxp1swuLX3Hd3nEtJWAXim2rB
         98J/SSq6rBTTUTFT16goUWCtr0JDBdFay8QDicy0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Mark Hasemeyer <markhas@chromium.org>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.1 61/62] ALSA: hda: intel-dsp-config: Fix JSL Chromebook quirk detection
Date:   Mon,  6 Nov 2023 14:04:07 +0100
Message-ID: <20231106130303.936248858@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231106130301.807965064@linuxfoundation.org>
References: <20231106130301.807965064@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

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


