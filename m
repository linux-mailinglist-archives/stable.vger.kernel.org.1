Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF536FAEC6
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:47:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234051AbjEHLrj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236117AbjEHLrY (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:47:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 332003C3EE
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:47:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCD286398B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:47:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3B19C433EF;
        Mon,  8 May 2023 11:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683546442;
        bh=A+P+KM1zo+z19jmJFTTeLZqNzjxdkwdQIW24kogJ0kM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=p1s2g7MNnCH6fSgyUgK49mnZDRKLTH9ZP+1TPVXmw1062QCOdoaVIjECIA8WS98Ld
         8Xi7fR4TzDvIDsvek3TyY7Hh1YJpgg0kGBFgB5Y0rQhebZ6550RLThIQ93sOytDuBy
         MXTNjiBUxZEasev/1GSa0feidxGs8eBlfX/RbhcM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Miles Chen <miles.chen@mediatek.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Takashi Iwai <tiwai@suse.de>
Subject: [PATCH 5.15 370/371] sound/oss/dmasound: fix dmasound_setup defined but not used
Date:   Mon,  8 May 2023 11:49:31 +0200
Message-Id: <20230508094826.725971595@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094811.912279944@linuxfoundation.org>
References: <20230508094811.912279944@linuxfoundation.org>
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

From: Miles Chen <miles.chen@mediatek.com>

commit 357ad4d898286b94aaae0cb7e3f573459e5b98b9 upstream.

We observed: 'dmasound_setup' defined but not used error with
COMPILER=gcc ARCH=m68k DEFCONFIG=allmodconfig build.

Fix it by adding __maybe_unused to dmasound_setup.

Error(s):
sound/oss/dmasound/dmasound_core.c:1431:12: error: 'dmasound_setup' defined but not used [-Werror=unused-function]

Fixes: 9dd7c46346ca ("sound/oss/dmasound: fix build when drivers are mixed =y/=m")
Signed-off-by: Miles Chen <miles.chen@mediatek.com>
Acked-by: Randy Dunlap <rdunlap@infradead.org>
Link: https://lore.kernel.org/r/20220414091940.2216-1-miles.chen@mediatek.com
Signed-off-by: Takashi Iwai <tiwai@suse.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 sound/oss/dmasound/dmasound_core.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/sound/oss/dmasound/dmasound_core.c
+++ b/sound/oss/dmasound/dmasound_core.c
@@ -1428,7 +1428,7 @@ void dmasound_deinit(void)
 		unregister_sound_dsp(sq_unit);
 }
 
-static int dmasound_setup(char *str)
+static int __maybe_unused dmasound_setup(char *str)
 {
 	int ints[6], size;
 


