Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2653D70C82A
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:36:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234917AbjEVTgT (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:36:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234943AbjEVTgN (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:36:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72904E5C
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:35:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D1E76298B
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:35:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54372C4339E;
        Mon, 22 May 2023 19:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684784125;
        bh=vo5dKigdXIC/4BfsSvsvAzbrRdYdx/q1TSj4PCTR8Lk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=x45ho6zvPm6TYVqnYgZKNst20xVzOmo4xCRYXG2E5kepw/En4oKS/aYWQRh0O5cM2
         d0Tt3IB/T0fn82HWiQ36wgC2T9y7mYlqJlz4b2UlEzSQoOiM8txUrQGaVVHI8giPTZ
         U7Ep34usCVkkCggLXERORFJqA2Q7tcV4deSeGNvg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Badhri Jagan Sridharan <badhri@google.com>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.1 233/292] usb: typec: altmodes/displayport: fix pin_assignment_show
Date:   Mon, 22 May 2023 20:09:50 +0100
Message-Id: <20230522190411.777554070@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190405.880733338@linuxfoundation.org>
References: <20230522190405.880733338@linuxfoundation.org>
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

From: Badhri Jagan Sridharan <badhri@google.com>

commit d8f28269dd4bf9b55c3fb376ae31512730a96fce upstream.

This patch fixes negative indexing of buf array in pin_assignment_show
when get_current_pin_assignments returns 0 i.e. no compatible pin
assignments are found.

BUG: KASAN: use-after-free in pin_assignment_show+0x26c/0x33c
...
Call trace:
dump_backtrace+0x110/0x204
dump_stack_lvl+0x84/0xbc
print_report+0x358/0x974
kasan_report+0x9c/0xfc
__do_kernel_fault+0xd4/0x2d4
do_bad_area+0x48/0x168
do_tag_check_fault+0x24/0x38
do_mem_abort+0x6c/0x14c
el1_abort+0x44/0x68
el1h_64_sync_handler+0x64/0xa4
el1h_64_sync+0x78/0x7c
pin_assignment_show+0x26c/0x33c
dev_attr_show+0x50/0xc0

Fixes: 0e3bb7d6894d ("usb: typec: Add driver for DisplayPort alternate mode")
Cc: stable@vger.kernel.org
Signed-off-by: Badhri Jagan Sridharan <badhri@google.com>
Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Link: https://lore.kernel.org/r/20230508214443.893436-1-badhri@google.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/altmodes/displayport.c |    4 ++++
 1 file changed, 4 insertions(+)

--- a/drivers/usb/typec/altmodes/displayport.c
+++ b/drivers/usb/typec/altmodes/displayport.c
@@ -513,6 +513,10 @@ static ssize_t pin_assignment_show(struc
 
 	mutex_unlock(&dp->lock);
 
+	/* get_current_pin_assignments can return 0 when no matching pin assignments are found */
+	if (len == 0)
+		len++;
+
 	buf[len - 1] = '\n';
 	return len;
 }


