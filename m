Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078F878AA54
	for <lists+stable@lfdr.de>; Mon, 28 Aug 2023 12:21:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229477AbjH1KVJ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 28 Aug 2023 06:21:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjH1KUg (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 28 Aug 2023 06:20:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9FD91B1
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 03:20:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D3976384F
        for <stable@vger.kernel.org>; Mon, 28 Aug 2023 10:19:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DF58C433C7;
        Mon, 28 Aug 2023 10:19:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1693217980;
        bh=hH6Jb6id3LRvf9sPRJmuYE+PryWqDQw+Pf+ozK6wvaE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=f4YDwXPG7SU30r0TYrk5a5TGdjwjDTSai39UB8zvdOSNiXOiQm2mzKXGWr0RodyTn
         YpX8zh+i1FTuW4DRwv7kHOHlVqBP9dhRFcTjChdUbyx++uUKe9b7qbGwVHo9kG9h1p
         inP2KU227tZBQ77rAeXDI4b1+ulAwtQGsxnirzSU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Mark Brown <broonie@kernel.org>
Subject: [PATCH 6.4 052/129] ASoC: cs35l41: Correct amp_gain_tlv values
Date:   Mon, 28 Aug 2023 12:12:11 +0200
Message-ID: <20230828101159.106228825@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230828101157.383363777@linuxfoundation.org>
References: <20230828101157.383363777@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Charles Keepax <ckeepax@opensource.cirrus.com>

commit 1613781d7e8a93618ff3a6b37f81f06769b53717 upstream.

The current analog gain TLV seems to have completely incorrect values in
it. The gain starts at 0.5dB, proceeds in 1dB steps, and has no mute
value, correct the control to match.

Signed-off-by: Charles Keepax <ckeepax@opensource.cirrus.com>
Link: https://lore.kernel.org/r/20230823085308.753572-1-ckeepax@opensource.cirrus.com
Signed-off-by: Mark Brown <broonie@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/soc/codecs/cs35l41.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/soc/codecs/cs35l41.c
+++ b/sound/soc/codecs/cs35l41.c
@@ -168,7 +168,7 @@ static int cs35l41_get_fs_mon_config_ind
 static const DECLARE_TLV_DB_RANGE(dig_vol_tlv,
 		0, 0, TLV_DB_SCALE_ITEM(TLV_DB_GAIN_MUTE, 0, 1),
 		1, 913, TLV_DB_MINMAX_ITEM(-10200, 1200));
-static DECLARE_TLV_DB_SCALE(amp_gain_tlv, 0, 1, 1);
+static DECLARE_TLV_DB_SCALE(amp_gain_tlv, 50, 100, 0);
 
 static const struct snd_kcontrol_new dre_ctrl =
 	SOC_DAPM_SINGLE("Switch", CS35L41_PWR_CTRL3, 20, 1, 0);


