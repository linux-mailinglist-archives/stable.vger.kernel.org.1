Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0863713FE9
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:50:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231419AbjE1TuZ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:50:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjE1TuY (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:50:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 036479C
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:50:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95BE062056
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:50:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1DD9C433D2;
        Sun, 28 May 2023 19:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685303423;
        bh=zq1Os+D/7yy/NJzFj2J8bClDSlPMi/oDDTlDd37Pa0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Rv7h5bs79XvnlZ4Or0+ZXLu+ALTpLqlZ7LdlU+rt0GCpU/vudP/UoZOII3YlhilrR
         pIKX2/eqOZn3LCeCMVTQ/K6NKuQBobbN/2vJ7DuLQGusotN50I4iJwu8UfmTJk6ZuT
         tAqRmPeGP7xNeyFq+vzqZ2ee+Q2dG1pzqcaPMJJg=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.15 40/69] ipv6: Fix out-of-bounds access in ipv6_find_tlv()
Date:   Sun, 28 May 2023 20:12:00 +0100
Message-Id: <20230528190829.855546239@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190828.358612414@linuxfoundation.org>
References: <20230528190828.358612414@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>

commit 878ecb0897f4737a4c9401f3523fd49589025671 upstream.

optlen is fetched without checking whether there is more than one byte to parse.
It can lead to out-of-bounds access.

Found by InfoTeCS on behalf of Linux Verification Center
(linuxtesting.org) with SVACE.

Fixes: c61a40432509 ("[IPV6]: Find option offset by type.")
Signed-off-by: Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>
Reviewed-by: Jiri Pirko <jiri@nvidia.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 net/ipv6/exthdrs_core.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/net/ipv6/exthdrs_core.c
+++ b/net/ipv6/exthdrs_core.c
@@ -143,6 +143,8 @@ int ipv6_find_tlv(const struct sk_buff *
 			optlen = 1;
 			break;
 		default:
+			if (len < 2)
+				goto bad;
 			optlen = nh[offset + 1] + 2;
 			if (optlen > len)
 				goto bad;


