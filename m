Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC39178D169
	for <lists+stable@lfdr.de>; Wed, 30 Aug 2023 02:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233687AbjH3Auc (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 29 Aug 2023 20:50:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235975AbjH3AuB (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 29 Aug 2023 20:50:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CC61A6
        for <stable@vger.kernel.org>; Tue, 29 Aug 2023 17:49:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5683E637CA
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 00:49:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8B68C433C8
        for <stable@vger.kernel.org>; Wed, 30 Aug 2023 00:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1693356598;
        bh=4U3lECvh53wCJzGyoNSFaADWaMpwjOxHHp6WbDGzeJE=;
        h=Date:From:To:Subject:From;
        b=A/8QkiyoMImJCzpOKsTjaPHoMCpRueDNEqVku1l9tPMJnDIOCk2CfaGb90edriL+5
         5ZqTCHysPtZzgRteQD5iBeqW05Qoe/9oRy/O1hi6HJi+d5O+Mhj4sLXnw1WeOaons1
         g2wBFE9n4nuiGF0sQqMveKjbwGGN22Dr0+eeDNtrEuOKKkGu1I45oIT+yjECU6ccd9
         WpPnPKIc6FVSme/y320DuphJe3lUv6Rdf/0M3zC1RZ/mOnhZchfGCh7/U//03/QW8j
         zW/qpC8NFrZlhgpnJxs6q9EQrN35kh5ddz0ONrZE+7UUdlESMB7Zmg2NVLAHyvC2qa
         WTw64y1ud9VTg==
Date:   Tue, 29 Aug 2023 17:49:57 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     stable@vger.kernel.org
Subject: [6.5] please apply f5f80e32de12
Message-ID: <20230829174957.0ae84f41@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Hi!

Is the queue for 6.5 open already? :)

Please apply commit f5f80e32de12 ("ipv6: remove hard coded limitation
on ipv6_pinfo") to 6.5, it mistakenly went via -next. It's in Linus's 
tree now.

Discussions:

https://lore.kernel.org/all/CABq1_viq9yMo9wZ2XkLg_45FaOcwL93qVhqFUZ9wTygKagnszg@mail.gmail.com/
https://lore.kernel.org/netdev/CANn89iLTn6vv9=PvAUccpRNNw6CKcXktixusDpqxqvo+UeLviQ@mail.gmail.com/T/#mb8dca9fc9491cc78fca691e64e601301ec036ce7

Fixes: fe79bd65c819 ("net/tcp: refactor tcp_inet6_sk()")
