Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6FEB761511
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230377AbjGYLZT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:25:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234578AbjGYLZS (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:25:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F0C297
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:25:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ADEFB61691
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:25:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEF6DC433C7;
        Tue, 25 Jul 2023 11:25:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690284316;
        bh=ncm47kN3BwJFRAHE6jPJSDPvZdoJEvavTY6EptC6jg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwnOQlUKZ7WuCLNeF7hgRqEV4bO/dHvTCgj0hhp15MS5OJk1I4qRmIf+nocgfO4MF
         g+fPRDRzwUrm89pT0lZCIzv9oVdbdUE2AvcgJ3/2kPgqP6IudrEBiooC5bSOyp1UIW
         UTGJdeCZ9nhQjHUIkIWsW/CP+HNCre77gjuml8VA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Robert Marko <robimarko@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Subject: [PATCH 5.10 284/509] mmc: core: disable TRIM on Micron MTFC4GACAJCN-1M
Date:   Tue, 25 Jul 2023 12:43:43 +0200
Message-ID: <20230725104606.739386473@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104553.588743331@linuxfoundation.org>
References: <20230725104553.588743331@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Robert Marko <robimarko@gmail.com>

commit dbfbddcddcebc9ce8a08757708d4e4a99d238e44 upstream.

It seems that Micron MTFC4GACAJCN-1M despite advertising TRIM support does
not work when the core is trying to use REQ_OP_WRITE_ZEROES.

We are seeing the following errors in OpenWrt under 6.1 on Qnap Qhora 301W
that we did not previously have and tracked it down to REQ_OP_WRITE_ZEROES:
[   18.085950] I/O error, dev loop0, sector 596 op 0x9:(WRITE_ZEROES) flags 0x800 phys_seg 0 prio class 2

Disabling TRIM makes the error go away, so lets add a quirk for this eMMC
to disable TRIM.

Signed-off-by: Robert Marko <robimarko@gmail.com>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230530213259.1776512-1-robimarko@gmail.com
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/mmc/core/quirks.h |    7 +++++++
 1 file changed, 7 insertions(+)

--- a/drivers/mmc/core/quirks.h
+++ b/drivers/mmc/core/quirks.h
@@ -107,6 +107,13 @@ static const struct mmc_fixup __maybe_un
 		  MMC_QUIRK_TRIM_BROKEN),
 
 	/*
+	 * Micron MTFC4GACAJCN-1M advertises TRIM but it does not seems to
+	 * support being used to offload WRITE_ZEROES.
+	 */
+	MMC_FIXUP("Q2J54A", CID_MANFID_MICRON, 0x014e, add_quirk_mmc,
+		  MMC_QUIRK_TRIM_BROKEN),
+
+	/*
 	 * Some SD cards reports discard support while they don't
 	 */
 	MMC_FIXUP(CID_NAME_ANY, CID_MANFID_SANDISK_SD, 0x5344, add_quirk_sd,


