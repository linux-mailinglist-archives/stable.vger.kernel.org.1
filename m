Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F077775CEA
	for <lists+stable@lfdr.de>; Wed,  9 Aug 2023 13:32:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbjHILcL (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 9 Aug 2023 07:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234052AbjHILcI (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 9 Aug 2023 07:32:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6E7AED
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 04:32:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3BE84633DA
        for <stable@vger.kernel.org>; Wed,  9 Aug 2023 11:32:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 485E6C433D9;
        Wed,  9 Aug 2023 11:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691580726;
        bh=eCOL0ev9PPmurFXngy0fbigeeDoj1j8pEq349mQI2Gc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=MwM9jHF+ylucXkaU5l6uJDCzUHyZTkYm6T7FGmzWNym+d5lJxLQw4tFAwfqcjV+ot
         N8mZMHL/k1NKFhl/REmvLsViZFoVGF/ofGtpeoY0A1FpCRujv8oekOAdd+sDfJTbnO
         nqA18OKNMGDXJcahE0YnWib5BZSprPteFE6Yyis4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Eric Dumazet <edumazet@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Pietro Borrello <borrello@diag.uniroma1.it>,
        netdev@vger.kernel.org, Laszlo Ersek <lersek@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 128/154] net: tap_open(): set sk_uid from current_fsuid()
Date:   Wed,  9 Aug 2023 12:42:39 +0200
Message-ID: <20230809103641.133920784@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230809103636.887175326@linuxfoundation.org>
References: <20230809103636.887175326@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Laszlo Ersek <lersek@redhat.com>

commit 5c9241f3ceab3257abe2923a59950db0dc8bb737 upstream.

Commit 66b2c338adce initializes the "sk_uid" field in the protocol socket
(struct sock) from the "/dev/tapX" device node's owner UID. Per original
commit 86741ec25462 ("net: core: Add a UID field to struct sock.",
2016-11-04), that's wrong: the idea is to cache the UID of the userspace
process that creates the socket. Commit 86741ec25462 mentions socket() and
accept(); with "tap", the action that creates the socket is
open("/dev/tapX").

Therefore the device node's owner UID is irrelevant. In most cases,
"/dev/tapX" will be owned by root, so in practice, commit 66b2c338adce has
no observable effect:

- before, "sk_uid" would be zero, due to undefined behavior
  (CVE-2023-1076),

- after, "sk_uid" would be zero, due to "/dev/tapX" being owned by root.

What matters is the (fs)UID of the process performing the open(), so cache
that in "sk_uid".

Cc: Eric Dumazet <edumazet@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: Paolo Abeni <pabeni@redhat.com>
Cc: Pietro Borrello <borrello@diag.uniroma1.it>
Cc: netdev@vger.kernel.org
Cc: stable@vger.kernel.org
Fixes: 66b2c338adce ("tap: tap_open(): correctly initialize socket uid")
Bugzilla: https://bugzilla.redhat.com/show_bug.cgi?id=2173435
Signed-off-by: Laszlo Ersek <lersek@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/tap.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/tap.c
+++ b/drivers/net/tap.c
@@ -525,7 +525,7 @@ static int tap_open(struct inode *inode,
 	q->sock.state = SS_CONNECTED;
 	q->sock.file = file;
 	q->sock.ops = &tap_socket_ops;
-	sock_init_data_uid(&q->sock, &q->sk, inode->i_uid);
+	sock_init_data_uid(&q->sock, &q->sk, current_fsuid());
 	q->sk.sk_write_space = tap_sock_write_space;
 	q->sk.sk_destruct = tap_sock_destruct;
 	q->flags = IFF_VNET_HDR | IFF_NO_PI | IFF_TAP;


