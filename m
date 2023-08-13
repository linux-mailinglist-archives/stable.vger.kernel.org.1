Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D253577AD3E
	for <lists+stable@lfdr.de>; Sun, 13 Aug 2023 23:48:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231601AbjHMVsQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 13 Aug 2023 17:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjHMVrg (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 13 Aug 2023 17:47:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10C182D54
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 14:47:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9713C61468
        for <stable@vger.kernel.org>; Sun, 13 Aug 2023 21:47:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2C2EC433C7;
        Sun, 13 Aug 2023 21:47:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1691963255;
        bh=TTW0c7Ngje9QeJ6xU8+/WC028QmCUWd/ql77WlYPyQc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Lp+HHc307zNJgKZO77FBhGjEm+VsAfE/LyO/WbL+WHRiISW4KC3IjPePGIXzbi347
         4MyLP0mjN0abxeU5B6zK32FWi3JVff+iaAtfsRp4kbyuMUjdTslCUUI4hozFvknhoJ
         fgxpnwNQoaluPVXZLHujdiVWs3Pusy+xUk3wTUKU=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Jen Linkova <furry@google.com>,
        Lorenzo Colitti <lorenzo@google.com>,
        David Ahern <dsahern@gmail.com>,
        =?UTF-8?q?YOSHIFUJI=20Hideaki=20/=20=E5=90=89=E8=97=A4=E8=8B=B1=E6=98=8E?= 
        <yoshfuji@linux-ipv6.org>,
        =?UTF-8?q?Maciej=20=C5=BBenczykowski?= <maze@google.com>,
        Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 5.4 02/39] ipv6: adjust ndisc_is_useropt() to also return true for PIO
Date:   Sun, 13 Aug 2023 23:19:53 +0200
Message-ID: <20230813211704.890894431@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230813211704.796906808@linuxfoundation.org>
References: <20230813211704.796906808@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

From: Maciej Żenczykowski <maze@google.com>

commit 048c796beb6eb4fa3a5a647ee1c81f5c6f0f6a2a upstream.

The upcoming (and nearly finalized):
  https://datatracker.ietf.org/doc/draft-collink-6man-pio-pflag/
will update the IPv6 RA to include a new flag in the PIO field,
which will serve as a hint to perform DHCPv6-PD.

As we don't want DHCPv6 related logic inside the kernel, this piece of
information needs to be exposed to userspace.  The simplest option is to
simply expose the entire PIO through the already existing mechanism.

Even without this new flag, the already existing PIO R (router address)
flag (from RFC6275) cannot AFAICT be handled entirely in kernel,
and provides useful information that should be exposed to userspace
(the router's global address, for use by Mobile IPv6).

Also cc'ing stable@ for inclusion in LTS, as while technically this is
not quite a bugfix, and instead more of a feature, it is absolutely
trivial and the alternative is manually cherrypicking into all Android
Common Kernel trees - and I know Greg will ask for it to be sent in via
LTS instead...

Cc: Jen Linkova <furry@google.com>
Cc: Lorenzo Colitti <lorenzo@google.com>
Cc: David Ahern <dsahern@gmail.com>
Cc: YOSHIFUJI Hideaki / 吉藤英明 <yoshfuji@linux-ipv6.org>
Cc: stable@vger.kernel.org
Signed-off-by: Maciej Żenczykowski <maze@google.com>
Link: https://lore.kernel.org/r/20230807102533.1147559-1-maze@google.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/ndisc.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

--- a/net/ipv6/ndisc.c
+++ b/net/ipv6/ndisc.c
@@ -196,7 +196,8 @@ static struct nd_opt_hdr *ndisc_next_opt
 static inline int ndisc_is_useropt(const struct net_device *dev,
 				   struct nd_opt_hdr *opt)
 {
-	return opt->nd_opt_type == ND_OPT_RDNSS ||
+	return opt->nd_opt_type == ND_OPT_PREFIX_INFO ||
+		opt->nd_opt_type == ND_OPT_RDNSS ||
 		opt->nd_opt_type == ND_OPT_DNSSL ||
 		opt->nd_opt_type == ND_OPT_CAPTIVE_PORTAL ||
 		ndisc_ops_is_useropt(dev, opt->nd_opt_type);


