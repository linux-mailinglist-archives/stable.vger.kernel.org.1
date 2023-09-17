Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ADF17A3CA3
	for <lists+stable@lfdr.de>; Sun, 17 Sep 2023 22:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239688AbjIQUdh (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 17 Sep 2023 16:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241082AbjIQUdJ (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 17 Sep 2023 16:33:09 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ED0D137
        for <stable@vger.kernel.org>; Sun, 17 Sep 2023 13:33:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8762AC433CB;
        Sun, 17 Sep 2023 20:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694982783;
        bh=1BLdtesFIWPe6U+JNDXqNSdFBVUeCtY6c3k/tvkCjAo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GjITU0mOXU41dICD0nzFkWbMLqeAPN5Eu6WFrXhDpdNH/P/JhuAucx9747W0FcAbX
         IAJ56fUKm4zUeAL52DsVb4h2LE3Efp4mtBXyN8mm4GcGKvLbaMiI0OMfC084mxrgcm
         4jLktEakPWzbDEAlSJxTwy+/64vWF6dy9Vexbkko=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Siwar Zitouni <siwar.zitouni@6wind.com>,
        Guillaume Nault <gnault@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 352/511] net: handle ARPHRD_PPP in dev_is_mac_header_xmit()
Date:   Sun, 17 Sep 2023 21:12:59 +0200
Message-ID: <20230917191122.304978193@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230917191113.831992765@linuxfoundation.org>
References: <20230917191113.831992765@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
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

5.15-stable review patch.  If anyone has any objections, please let me know.

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


