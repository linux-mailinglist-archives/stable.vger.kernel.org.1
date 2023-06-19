Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09D4E7352B6
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:37:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229865AbjFSKhb (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231391AbjFSKhX (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:37:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C6310C3
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:37:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 153EB60B62
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:37:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F7D6C433C0;
        Mon, 19 Jun 2023 10:37:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687171041;
        bh=E2lpTGPZ7rvR7MuQPEYvXmAOO1DAY8csw6d3kblZGKA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pp+va6vAkdzqDpIEtr5Wi82S1e7GS2ucj9YESCc4KGX0VyYbT9BDw0jJNDchnmfDn
         Zx1/LmiKqQ9TX7b+/4FQcp74ezFflJZFKFENtf1jKpERKheEQyWDcJaahqrY3lUG88
         +SR0xmMwFsMvVc4ilRPDBDLT5yKj+s/bZ2AIkI1Y=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Stephan Bolten <stephan.bolten@gmx.net>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>
Subject: [PATCH 6.3 100/187] usb: typec: ucsi: Fix command cancellation
Date:   Mon, 19 Jun 2023 12:28:38 +0200
Message-ID: <20230619102202.431304441@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
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

From: Heikki Krogerus <heikki.krogerus@linux.intel.com>

commit c4a8bfabefed706bb9150867db528ceefd5cb5fe upstream.

The Cancel command was passed to the write callback as the
offset instead of as the actual command which caused NULL
pointer dereference.

Reported-by: Stephan Bolten <stephan.bolten@gmx.net>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217517
Fixes: 094902bc6a3c ("usb: typec: ucsi: Always cancel the command if PPM reports BUSY condition")
Cc: stable@vger.kernel.org
Signed-off-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
Message-ID: <20230606115802.79339-1-heikki.krogerus@linux.intel.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/usb/typec/ucsi/ucsi.c |   11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

--- a/drivers/usb/typec/ucsi/ucsi.c
+++ b/drivers/usb/typec/ucsi/ucsi.c
@@ -132,10 +132,8 @@ static int ucsi_exec_command(struct ucsi
 	if (ret)
 		return ret;
 
-	if (cci & UCSI_CCI_BUSY) {
-		ucsi->ops->async_write(ucsi, UCSI_CANCEL, NULL, 0);
-		return -EBUSY;
-	}
+	if (cmd != UCSI_CANCEL && cci & UCSI_CCI_BUSY)
+		return ucsi_exec_command(ucsi, UCSI_CANCEL);
 
 	if (!(cci & UCSI_CCI_COMMAND_COMPLETE))
 		return -EIO;
@@ -149,6 +147,11 @@ static int ucsi_exec_command(struct ucsi
 		return ucsi_read_error(ucsi);
 	}
 
+	if (cmd == UCSI_CANCEL && cci & UCSI_CCI_CANCEL_COMPLETE) {
+		ret = ucsi_acknowledge_command(ucsi);
+		return ret ? ret : -EBUSY;
+	}
+
 	return UCSI_CCI_LENGTH(cci);
 }
 


