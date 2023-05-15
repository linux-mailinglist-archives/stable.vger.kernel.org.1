Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97A417038F5
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:37:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242702AbjEORhC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:37:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244462AbjEORgh (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:36:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4AC8F9
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:34:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B572E62DB1
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:34:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AACD7C433D2;
        Mon, 15 May 2023 17:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172052;
        bh=FCO+mQ7M3QwYjQeEpbF4qYkU0s0b3eMBg1HLdPwqYy4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PVgMz7fRNU03IZ7wK1R/xyOtvqN3oFxBGZMdSV/NymXjd6f6+T4aV7yaYvHeNSeVr
         fP5H5NpY2jg0wRrjcdCvzL2dffohzBB5fHPX+ImPaSLpNGPcIRDJZRrwk9cM7W++bT
         tg/5E/ylT5rhP5AP+zdMQCggPemerMkErpF8TuYA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, stable <stable@kernel.org>,
        =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Subject: [PATCH 5.10 028/381] staging: iio: resolver: ads1210: fix config mode
Date:   Mon, 15 May 2023 18:24:39 +0200
Message-Id: <20230515161738.056386182@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161736.775969473@linuxfoundation.org>
References: <20230515161736.775969473@linuxfoundation.org>
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

From: Nuno Sá <nuno.sa@analog.com>

commit 16313403d873ff17a587818b61f84c8cb4971cef upstream.

As stated in the device datasheet [1], bits a0 and a1 have to be set to
1 for the configuration mode.

[1]: https://www.analog.com/media/en/technical-documentation/data-sheets/ad2s1210.pdf

Fixes: b19e9ad5e2cb9 ("staging:iio:resolver:ad2s1210 general driver cleanup")
Cc: stable <stable@kernel.org>
Signed-off-by: Nuno Sá <nuno.sa@analog.com>
Link: https://lore.kernel.org/r/20230327145414.1505537-1-nuno.sa@analog.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/staging/iio/resolver/ad2s1210.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/staging/iio/resolver/ad2s1210.c
+++ b/drivers/staging/iio/resolver/ad2s1210.c
@@ -101,7 +101,7 @@ struct ad2s1210_state {
 static const int ad2s1210_mode_vals[4][2] = {
 	[MOD_POS] = { 0, 0 },
 	[MOD_VEL] = { 0, 1 },
-	[MOD_CONFIG] = { 1, 0 },
+	[MOD_CONFIG] = { 1, 1 },
 };
 
 static inline void ad2s1210_set_mode(enum ad2s1210_mode mode,


