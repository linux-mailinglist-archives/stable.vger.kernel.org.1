Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44A6C70C9C6
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:52:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235417AbjEVTwI (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:52:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235377AbjEVTv6 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:51:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 010C1E59
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:51:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A32A62B04
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:51:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71240C4339B;
        Mon, 22 May 2023 19:51:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684785081;
        bh=BtcZZjwoFE+Kpx3IvX0oQB/oHDEWqpJ3AWTZySHw8Jg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mLCBabSAKtM0Z/ot4TGGYr014XTBcXgH6ltK6dS6gIlq7+U3wVyqYhx+jHBktMROs
         Tp5Z3Ejt8DmmReJoeF+H/jJObysN6ESeZ3B33iTP/SMZN8nfr0FS7alSLTPrXP2I+i
         BkZ5BkNq7RFxKBP54ARpdgZl+TYnQSh2Epg2Wnd0=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Olliver Schinagl <oliver@schinagl.nl>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 6.3 301/364] ALSA: hda: Fix Oops by 9.1 surround channel names
Date:   Mon, 22 May 2023 20:10:06 +0100
Message-Id: <20230522190420.297814485@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190412.801391872@linuxfoundation.org>
References: <20230522190412.801391872@linuxfoundation.org>
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

From: Takashi Iwai <tiwai@suse.de>

commit 3b44ec8c5c44790a82f07e90db45643c762878c6 upstream.

get_line_out_pfx() may trigger an Oops by overflowing the static array
with more than 8 channels.  This was reported for MacBookPro 12,1 with
Cirrus codec.

As a workaround, extend for the 9.1 channels and also fix the
potential Oops by unifying the code paths accessing the same array
with the proper size check.

Reported-by: Olliver Schinagl <oliver@schinagl.nl>
Cc: <stable@vger.kernel.org>
Link: https://lore.kernel.org/r/64d95eb0-dbdb-cff8-a8b1-988dc22b24cd@schinagl.nl
Link: https://lore.kernel.org/r/20230516184412.24078-1-tiwai@suse.de
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/pci/hda/hda_generic.c |    7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

--- a/sound/pci/hda/hda_generic.c
+++ b/sound/pci/hda/hda_generic.c
@@ -1155,8 +1155,8 @@ static bool path_has_mixer(struct hda_co
 	return path && path->ctls[ctl_type];
 }
 
-static const char * const channel_name[4] = {
-	"Front", "Surround", "CLFE", "Side"
+static const char * const channel_name[] = {
+	"Front", "Surround", "CLFE", "Side", "Back",
 };
 
 /* give some appropriate ctl name prefix for the given line out channel */
@@ -1182,7 +1182,7 @@ static const char *get_line_out_pfx(stru
 
 	/* multi-io channels */
 	if (ch >= cfg->line_outs)
-		return channel_name[ch];
+		goto fixed_name;
 
 	switch (cfg->line_out_type) {
 	case AUTO_PIN_SPEAKER_OUT:
@@ -1234,6 +1234,7 @@ static const char *get_line_out_pfx(stru
 	if (cfg->line_outs == 1 && !spec->multi_ios)
 		return "Line Out";
 
+ fixed_name:
 	if (ch >= ARRAY_SIZE(channel_name)) {
 		snd_BUG();
 		return "PCM";


