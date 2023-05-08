Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 020606FAC04
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:20:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235550AbjEHLT7 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:19:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235579AbjEHLTx (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:19:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E03FF387F6
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:19:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 76BDC62C64
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A3C9C433D2;
        Mon,  8 May 2023 11:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544787;
        bh=WsR8fgP0yl+3Z6wf2pmqPsUwLcGJv9euAvjGdsRm/No=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h1JNktAvXFR9P5O705CEwFpSWWoNUVgdceJdR4gyulXaNhZRvnFP3TV+i7fv11sIb
         Q1jEubHsz26HTqxC9a+b0aXYpAJ129M7c6QCOWJlmvXbrk8OjjBDK5B9pGeBOq77E0
         ZPYepBKTO1bhAz8c+IFBlqJgWEBlX44zb5fTU/eA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Basavaraj Natikar <Basavaraj.Natikar@amd.com>,
        Jiri Kosina <jkosina@suse.cz>, Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 524/694] HID: amd_sfh: Correct the structure fields
Date:   Mon,  8 May 2023 11:45:59 +0200
Message-Id: <20230508094451.291944863@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Basavaraj Natikar <Basavaraj.Natikar@amd.com>

[ Upstream commit 7e7fdab79899f62de39c9280fb78f3d3b02ac207 ]

Misinterpreted sfh_cmd_base structure member fields. Therefore, adjust
the structure member fields accordingly to reflect functionality.

Fixes: 93ce5e0231d7 ("HID: amd_sfh: Implement SFH1.1 functionality")
Signed-off-by: Basavaraj Natikar <Basavaraj.Natikar@amd.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
index ae47a369dc05a..a3e0ec289e3f9 100644
--- a/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
+++ b/drivers/hid/amd-sfh-hid/sfh1_1/amd_sfh_interface.h
@@ -33,9 +33,9 @@ struct sfh_cmd_base {
 		struct {
 			u32 sensor_id		: 4;
 			u32 cmd_id		: 4;
-			u32 sub_cmd_id		: 6;
-			u32 length		: 12;
-			u32 rsvd		: 5;
+			u32 sub_cmd_id		: 8;
+			u32 sub_cmd_value	: 12;
+			u32 rsvd		: 3;
 			u32 intr_disable	: 1;
 		} cmd;
 	};
-- 
2.39.2



