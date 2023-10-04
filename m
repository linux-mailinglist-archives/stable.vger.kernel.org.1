Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F34D47B8956
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:24:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243773AbjJDSY7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:24:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244166AbjJDSY6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:24:58 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64F11D8
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:24:54 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A11DDC433C8;
        Wed,  4 Oct 2023 18:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696443894;
        bh=uWYJZSX36TS8fJX0w6uZGFKS7QfxWGr7PN4rehPriys=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GC/dGvIixTz6AUX5NQskdDW311P9DR/JWbKA3ue07dLbcXenTF7vIwxL3Mi9cO0HJ
         uk/VqUgCAdK8I0Uo+RQaSs+EBWpWgtqK5J4HjB2qdYtsqz7Gvb1zt2SqPo+IJ6rivV
         f+i8AphRRjqzm/NFqXYysHahqd8rbAXFn4up+YS4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Takashi Iwai <tiwai@suse.de>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 029/321] ALSA: docs: Fix a typo of midi2_ump_probe option for snd-usb-audio
Date:   Wed,  4 Oct 2023 19:52:54 +0200
Message-ID: <20231004175230.522520957@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175229.211487444@linuxfoundation.org>
References: <20231004175229.211487444@linuxfoundation.org>
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

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit 60edec9beffebd01a49c005221230f3a61fe6587 ]

A simple typo fix: midi2_probe => midi2_ump_probe.

Fixes: febdfa0e9c8a ("ALSA: docs: Update MIDI 2.0 documentation for UMP 1.1 enhancement")
Link: https://lore.kernel.org/r/20230912075944.14032-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 Documentation/sound/designs/midi-2.0.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/sound/designs/midi-2.0.rst b/Documentation/sound/designs/midi-2.0.rst
index 27d0d3dea1b0a..d91fdad524f1f 100644
--- a/Documentation/sound/designs/midi-2.0.rst
+++ b/Documentation/sound/designs/midi-2.0.rst
@@ -74,8 +74,8 @@ topology based on those information.  When the device is older and
 doesn't respond to the new UMP inquiries, the driver falls back and
 builds the topology based on Group Terminal Block (GTB) information
 from the USB descriptor.  Some device might be screwed up by the
-unexpected UMP command; in such a case, pass `midi2_probe=0` option to
-snd-usb-audio driver for skipping the UMP v1.1 inquiries.
+unexpected UMP command; in such a case, pass `midi2_ump_probe=0`
+option to snd-usb-audio driver for skipping the UMP v1.1 inquiries.
 
 When the MIDI 2.0 device is probed, the kernel creates a rawmidi
 device for each UMP Endpoint of the device.  Its device name is
-- 
2.40.1



