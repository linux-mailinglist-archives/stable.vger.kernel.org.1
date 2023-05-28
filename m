Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 495FD713DAE
	for <lists+stable@lfdr.de>; Sun, 28 May 2023 21:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjE1T1w (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 28 May 2023 15:27:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230120AbjE1T1v (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 28 May 2023 15:27:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D603DB1
        for <stable@vger.kernel.org>; Sun, 28 May 2023 12:27:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 739B861CC5
        for <stable@vger.kernel.org>; Sun, 28 May 2023 19:27:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9292AC433D2;
        Sun, 28 May 2023 19:27:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685302069;
        bh=zq1Os+D/7yy/NJzFj2J8bClDSlPMi/oDDTlDd37Pa0U=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Pk8t3UdGd1ULnPdzCih87LL4SiJD91E/xyh3CycKdVQkDa3D3o1WaIesd+o/4j+xy
         LHImw08pMxsEPMLeY7BTvovxqkxtVSBHiCaIJTfMRkPMe60Yr+Qesjl5bkCGYURZBQ
         T6qhpJdVkjQVXVnx/0bN+bAL0DTZWZ+1ggp3Moso=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Gavrilov Ilia <Ilia.Gavrilov@infotecs.ru>,
        Jiri Pirko <jiri@nvidia.com>, David Ahern <dsahern@kernel.org>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 5.4 148/161] ipv6: Fix out-of-bounds access in ipv6_find_tlv()
Date:   Sun, 28 May 2023 20:11:12 +0100
Message-Id: <20230528190841.599664847@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230528190837.051205996@linuxfoundation.org>
References: <20230528190837.051205996@linuxfoundation.org>
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


