Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BEF97D311E
	for <lists+stable@lfdr.de>; Mon, 23 Oct 2023 13:05:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233280AbjJWLFr (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 23 Oct 2023 07:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233303AbjJWLFq (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 23 Oct 2023 07:05:46 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BE70D7B
        for <stable@vger.kernel.org>; Mon, 23 Oct 2023 04:05:45 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80965C433C9;
        Mon, 23 Oct 2023 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1698059144;
        bh=iUs9Nu26qnTF5TyFyh0AW67Zg8jppUS5jQkoKkxEKBE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nwZFlvFnPiFGPpnaxPgNjwT4ZIMqRVGEBBlVJZiqKXFg77TwWfvR882yXQMN+MT1o
         M3Qf967krt0FCWEVElubPANAX0Ul+tJe+9BaqE1dVOXl2GtXCgWZZnEfG/OCIXgOcT
         SW3lkYxIdv88ZOFtYxZ4PWxGw2vvYMAZMIezDIIE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Aaron Conole <aconole@redhat.com>,
        "David S. Miller" <davem@davemloft.net>
Subject: [PATCH 6.5 078/241] selftests: openvswitch: Catch cases where the tests are killed
Date:   Mon, 23 Oct 2023 12:54:24 +0200
Message-ID: <20231023104835.789829165@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231023104833.832874523@linuxfoundation.org>
References: <20231023104833.832874523@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Aaron Conole <aconole@redhat.com>

commit af846afad5ca1c1a24d320adf9e48255e97db84e upstream.

In case of fatal signal, or early abort at least cleanup the current
test case.

Fixes: 25f16c873fb1 ("selftests: add openvswitch selftest suite")
Signed-off-by: Aaron Conole <aconole@redhat.com>
Signed-off-by: David S. Miller <davem@davemloft.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/net/openvswitch/openvswitch.sh |    2 ++
 1 file changed, 2 insertions(+)

--- a/tools/testing/selftests/net/openvswitch/openvswitch.sh
+++ b/tools/testing/selftests/net/openvswitch/openvswitch.sh
@@ -3,6 +3,8 @@
 #
 # OVS kernel module self tests
 
+trap ovs_exit_sig EXIT TERM INT ERR
+
 # Kselftest framework requirement - SKIP code is 4.
 ksft_skip=4
 


