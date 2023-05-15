Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FFB3703A1A
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244776AbjEORtC (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244639AbjEORs3 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:48:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 274F71B0AD
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:46:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 865D962EFF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:46:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C11EC433D2;
        Mon, 15 May 2023 17:46:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684172812;
        bh=KS9dps38y2zSNgTXjJEODh6zdcIo8HUfnMDC+87zd/8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hT+hyvQPqVtjttQlfSG03Xn5YoFxoCTLzB8SAKZCqdxEPLNb+AUQFeO30GJaSy0mP
         EBRvass0z+wiw5sx7qbS2h/DMQ5sDhZkLZfJNwR63PN034nfq2ifpWjE4B9lX+spZH
         J/Wf/TyY6qfXGtMDodN7GWfNaR8Td1s070vCkgcc=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        Andrew Lunn <andrew@lunn.ch>, Lee Jones <lee.jones@linaro.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10 274/381] mfd: tqmx86: Remove incorrect TQMx90UC board ID
Date:   Mon, 15 May 2023 18:28:45 +0200
Message-Id: <20230515161749.160893809@linuxfoundation.org>
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

From: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>

[ Upstream commit 16b2ad150f74db0eb91f445061f16140b5aaa650 ]

No TQMx90UC exists at the moment, and it is undecided whether ID 10 will
be used eventually (and if it is, how that SoM will be named).

Signed-off-by: Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Signed-off-by: Lee Jones <lee.jones@linaro.org>
Stable-dep-of: 051c69ff4f60 ("mfd: tqmx86: Specify IO port register range more precisely")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/mfd/tqmx86.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/drivers/mfd/tqmx86.c b/drivers/mfd/tqmx86.c
index 99a59341e4492..c5c5846dcf995 100644
--- a/drivers/mfd/tqmx86.c
+++ b/drivers/mfd/tqmx86.c
@@ -35,7 +35,6 @@
 #define TQMX86_REG_BOARD_ID_E39x	7
 #define TQMX86_REG_BOARD_ID_70EB	8
 #define TQMX86_REG_BOARD_ID_80UC	9
-#define TQMX86_REG_BOARD_ID_90UC	10
 #define TQMX86_REG_BOARD_REV	0x21
 #define TQMX86_REG_IO_EXT_INT	0x26
 #define TQMX86_REG_IO_EXT_INT_NONE		0
@@ -127,8 +126,6 @@ static const char *tqmx86_board_id_to_name(u8 board_id)
 		return "TQMx70EB";
 	case TQMX86_REG_BOARD_ID_80UC:
 		return "TQMx80UC";
-	case TQMX86_REG_BOARD_ID_90UC:
-		return "TQMx90UC";
 	default:
 		return "Unknown";
 	}
@@ -141,7 +138,6 @@ static int tqmx86_board_id_to_clk_rate(u8 board_id)
 	case TQMX86_REG_BOARD_ID_60EB:
 	case TQMX86_REG_BOARD_ID_70EB:
 	case TQMX86_REG_BOARD_ID_80UC:
-	case TQMX86_REG_BOARD_ID_90UC:
 		return 24000;
 	case TQMX86_REG_BOARD_ID_E39M:
 	case TQMX86_REG_BOARD_ID_E39C:
-- 
2.39.2



