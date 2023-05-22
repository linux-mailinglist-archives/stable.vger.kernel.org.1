Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B75870C69A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:20:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234329AbjEVTUD (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:20:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234320AbjEVTUC (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:20:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4D793
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:20:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EC44F62810
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2482C433EF;
        Mon, 22 May 2023 19:19:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783200;
        bh=YDw6gjSCboNq0DEomF62LgY68MbI2o3WAuRBGpHrH2A=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQb14W7tHWp1gRPHcWuXistblMKpDa6iwpobpX982Lw5IdbsHh1F69NUZiuzz9V0m
         /Bip/clljrD/Pipq2bjL5HucPdfe76uPl2WxXymqejkJLpaZ6ohwbEy2oDj+sJbh8f
         J82XEqtHQaZRSXWGRw/v7QGaz6g0Vu7dQICXNPZI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Nikhil Mahale <nmahale@nvidia.com>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 171/203] ALSA: hda: Add NVIDIA codec IDs a3 through a7 to patch table
Date:   Mon, 22 May 2023 20:09:55 +0100
Message-Id: <20230522190359.720442768@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
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
@@ -4385,6 +4385,11 @@ HDA_CODEC_ENTRY(0x10de009d, "GPU 9d HDMI
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


