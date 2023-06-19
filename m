Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40FAF7352B8
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230431AbjFSKhj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231732AbjFSKh2 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E21A1AC
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7EC1060B0D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 93A5FC433C0;
        Mon, 19 Jun 2023 10:37:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171046;
        bh=C238M2BYjUpct3HZg/QcivshdYs/b3I14x62f1EVfdo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VSRWNswxn3GRuuEjlC4qj/nHlAcOXhNuCgyHwEYmrjfZvY6FX+bzJNcWWDatcdAxi
         G1PiDGWemL5XlyNrbRyiyrXfJydjVWp2leQLejInnN299JE76xOR81YlMAqj3UgIty
         upbtxwu5tFs8R7FZcS8Sbl2CpLUnmb3zU1Gge6Sw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Koba Ko <koba.ko@canonical.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>
Subject: [PATCH 6.3 092/187] thunderbolt: Increase DisplayPort Connection Manager handshake timeout
Date:   Mon, 19 Jun 2023 12:28:30 +0200
Message-ID: <20230619102202.049211731@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Mika Westerberg <mika.westerberg@linux.intel.com>

commit b6d572aeb58a5e0be86bd51ea514c4feba996cc4 upstream.

It turns out that when plugging in VGA cable through USB-C to VGA/DVI
dongle the Connection Manager handshake can take longer time, at least
on Intel Titan Ridge based docks such as Dell WD91TB. This leads to
following error in the dmesg:

  thunderbolt 0000:00:0d.3: 3:10: DP tunnel activation failed, aborting

and the display stays blank (because we failed to establish the tunnel).
For this reason increase the timeout to 3s.

Reported-by: Koba Ko <koba.ko@canonical.com>
Cc: stable@vger.kernel.org
Acked-By: Yehezkel Bernat <YehezkelShB@gmail.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/thunderbolt/tunnel.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/thunderbolt/tunnel.c
+++ b/drivers/thunderbolt/tunnel.c
@@ -526,7 +526,7 @@ static int tb_dp_xchg_caps(struct tb_tun
 	 * Perform connection manager handshake between IN and OUT ports
 	 * before capabilities exchange can take place.
 	 */
-	ret = tb_dp_cm_handshake(in, out, 1500);
+	ret = tb_dp_cm_handshake(in, out, 3000);
 	if (ret)
 		return ret;
 


