Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69E1C79ACE7
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 01:38:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377946AbjIKW3f (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:29:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239661AbjIKOZu (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 10:25:50 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F22DE
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 07:25:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A984C433C8;
        Mon, 11 Sep 2023 14:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694442345;
        bh=++vdt+m33Gxc3ZyS9rc60BgjJauZUdOSOlVkeUGYvyU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qs1juWDxpJZF2sz6kyslLAUCG6mZPyZHV0JHU2IeH3tpqo1a4nC3ObVrejO4V8lMj
         BC6ARCZ3/lS+4M8fYDqfDoGRPPhVfFVC7RyO8Qm0IYV6NqFXE/KN2CJY1HQVPiKMAD
         ED7dMgp4w3/kknQwauhgSYUieii/nJJ5Xw8QDg2c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Siwar Zitouni <siwar.zitouni@6wind.com>,
        Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.5 704/739] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Date:   Mon, 11 Sep 2023 15:48:23 +0200
Message-ID: <20230911134710.750195024@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Nicolas Dichtel <nicolas.dichtel@6wind.com>

commit a4f39c9f14a634e4cd35fcd338c239d11fcc73fc upstream.

The goal is to support a bpf_redirect() from an ethernet device (ingress)
to a ppp device (egress).
The l2 header is added automatically by the ppp driver, thus the ethernet
header should be removed.

CC: stable@vger.kernel.org
Fixes: 27b29f63058d ("bpf: add bpf_redirect() helper")
Signed-off-by: Nicolas Dichtel <nicolas.dichtel@6wind.com>
Tested-by: Siwar Zitouni <siwar.zitouni@6wind.com>
Reviewed-by: Guillaume Nault <gnault@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 include/linux/if_arp.h |    4 ++++
 1 file changed, 4 insertions(+)

--- a/include/linux/if_arp.h
+++ b/include/linux/if_arp.h
@@ -53,6 +53,10 @@ static inline bool dev_is_mac_header_xmi
 	case ARPHRD_NONE:
 	case ARPHRD_RAWIP:
 	case ARPHRD_PIMREG:
+	/* PPP adds its l2 header automatically in ppp_start_xmit().
+	 * This makes it look like an l3 device to __bpf_redirect() and tcf_mirred_init().
+	 */
+	case ARPHRD_PPP:
 		return false;
 	default:
 		return true;


