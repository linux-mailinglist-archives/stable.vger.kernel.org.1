Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4C7F735ED0
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 23:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbjFSVI0 (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 17:08:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbjFSVI0 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 17:08:26 -0400
Received: from mout-p-202.mailbox.org (mout-p-202.mailbox.org [80.241.56.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4A33E4D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 14:08:24 -0700 (PDT)
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mout-p-202.mailbox.org (Postfix) with ESMTPS id 4QlMn166cjz9sqP;
        Mon, 19 Jun 2023 23:08:21 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bernhard-seibold.de;
        s=MBO0001; t=1687208901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=H2K6Sd0FS771HZ19S80Oo7slx4lEtLwyxOlORyGb2Hc=;
        b=k4uciYvJLIUbHw9wj7qXG1nGBWq13liwer6dn7zCxSongelBvLaVJ4By2pbQ4DtN6hwe/i
        9x5TdKI8+hP5cfIjL4hQtJxWUeykxqpKdLN4RrJ5UibiCY5aQ+dawNU4j+rkYwYoPQoeQB
        8gdBE4oktL9l/yvGeOGocE0vwbUNYiKfidOdB0pjEhZc00G0Dq3M+1onjIk4R0sutmP4vj
        76PxOkAN7xpExoJ7Y9rjRQoI1MzhDTBeTHDlmJQ/5QlsnHik1X+tm8w/vliB44RBdvGT+5
        yxMvTro3DtpOMiafYVjItsNjUFuJp9/1jg6ZkJNh3yEUEtJ2oiYlG5okM6uQ7w==
From:   Bernhard Seibold <mail@bernhard-seibold.de>
To:     stable@vger.kernel.org
Cc:     Bernhard Seibold <mail@bernhard-seibold.de>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 4.19.y v2] serial: lantiq: add missing interrupt ack
Date:   Mon, 19 Jun 2023 23:08:09 +0200
Message-ID: <20230619210809.12140-1-mail@bernhard-seibold.de>
In-Reply-To: <2023061831-detention-overtime-783b@gregkh>
References: <2023061831-detention-overtime-783b@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

commit 306320034e8fbe7ee1cc4f5269c55658b4612048 upstream.

Currently, the error interrupt is never acknowledged, so once active it
will stay active indefinitely, causing the handler to be called in an
infinite loop.

Fixes: 2f0fc4159a6a ("SERIAL: Lantiq: Add driver for MIPS Lantiq SOCs.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Bernhard Seibold <mail@bernhard-seibold.de>
Reviewed-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Message-ID: <20230602133029.546-1-mail@bernhard-seibold.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/tty/serial/lantiq.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/serial/lantiq.c b/drivers/tty/serial/lantiq.c
index 044128277248..c6b4bd67d4d9 100644
--- a/drivers/tty/serial/lantiq.c
+++ b/drivers/tty/serial/lantiq.c
@@ -251,6 +251,7 @@ lqasc_err_int(int irq, void *_port)
 	unsigned long flags;
 	struct uart_port *port = (struct uart_port *)_port;
 	spin_lock_irqsave(&ltq_asc_lock, flags);
+	ltq_w32(ASC_IRNCR_EIR, port->membase + LTQ_ASC_IRNCR);
 	/* clear any pending interrupts */
 	ltq_w32_mask(0, ASCWHBSTATE_CLRPE | ASCWHBSTATE_CLRFE |
 		ASCWHBSTATE_CLRROE, port->membase + LTQ_ASC_WHBSTATE);
-- 
2.41.0

