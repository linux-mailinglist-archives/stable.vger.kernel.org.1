Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F5FD713F4F
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:44:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjE1ToF (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231234AbjE1ToE (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:44:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22AE79C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:44:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A846861F1C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:44:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6883C433EF;
        Sun, 28 May 2023 19:44:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303043;
        bh=MxhScrPLpmv3M7UwSvKpbaq2a/vULNmjQI/SCoOvJkI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gqsBhEnRH4MvhND1tFBtRz7TcKfnsowurjaTYJ02U8jbpXdVuPV9yg2ACCnqlsyc8
         /LjjA8e8YlXVb1YfAnbFhKg13/OKntg7gcCUTWrl0kIAv+KwVfg1qBVcE5sUhSY/4+
         3rj0cwV4Y8rqAhXRq2u6c7Uhv4QBeg9rfrWsGpyA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nikhil Mahale <nmahale@nvidia.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.10 131/211] ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table
Date:   Sun, 28 May 2023 20:10:52 +0100
Message-Id: <20230528190846.792067713@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190843.514829708@linuxfoundation.org>
References: <20230528190843.514829708@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Nikhil Mahale <nmahale@nvidia.com>

commit dc4f2ccaedddb489a83e7b12ebbdc347272aacc9 upstream.

These IDs are for AD102, AD103, AD104, AD106, and AD107 gpus with
audio functions that are largely similar to the existing ones.

Tested audio using gnome-settings, over HDMI, DP-SST and DP-MST
connections on AD106 gpu.

Signed-off-by: Nikhil Mahale <nmahale@nvidia.com>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/20230517090736.15088-1-nmahale@nvidia.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/patch_hdmi.c |    5 +++++
 1 file changed, 5 insertions(+)

--- a/sound/pci/hda/patch_hdmi.c
+++ b/sound/pci/hda/patch_hdmi.c
@@ -4374,6 +4374,11 @@ HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI
 HDA_CODEC_ENTRY(0x10de009e, "GPU 9e HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de009f, "GPU 9f HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de00a0, "GPU a0 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a3, "GPU a3 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a4, "GPU a4 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a5, "GPU a5 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a6, "GPU a6 HDMI/DP",	patch_nvhdmi),
+HDA_CODEC_ENTRY(0x10de00a7, "GPU a7 HDMI/DP",	patch_nvhdmi),
 HDA_CODEC_ENTRY(0x10de8001, "MCP73 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x10de8067, "MCP67/68 HDMI",	patch_nvhdmi_2ch),
 HDA_CODEC_ENTRY(0x11069f80, "VX900 HDMI/DP",	patch_via_hdmi),


