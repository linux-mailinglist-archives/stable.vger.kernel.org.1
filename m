Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA59375CF25
	for <lists+stable@lfdr.de>; Fri, 21 Jul 2023 18:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjGUQ1s (ORCPT <rfc822;lists+stable@lfdr.de>);
        Fri, 21 Jul 2023 12:27:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232967AbjGUQ1b (ORCPT
        <rfc822;stable@vger.kernel.org>); Fri, 21 Jul 2023 12:27:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FFBB44B6
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 09:24:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18A9D61D57
        for <stable@vger.kernel.org>; Fri, 21 Jul 2023 16:24:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28189C433C9;
        Fri, 21 Jul 2023 16:24:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1689956646;
        bh=EmwsSZd/Jo2MV6L8wgoHDi46G9Ti7gHt520/dumZvG8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OMWmWgOLGYdsjQ9yhQqJf/fOdGAz8DVibk7LMbEmVBwh81/N5eX2s2kyNF9tYfaDw
         +kOGROU/DLM57U2GZAKykYiP6iNByPfddZhGLIs8PicqFckY7Upv7v+Ewi7bMuUhes
         XJ4gV8NsJuHGpV9v/tu2HDQP7bjNvyfaCb2teCH8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Xiubo Li <xiubli@redhat.com>,
        Milind Changire <mchangir@redhat.com>,
        Patrick Donnelly <pdonnell@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 6.4 223/292] ceph: dont let check_caps skip sending responses for revoke msgs
Date:   Fri, 21 Jul 2023 18:05:32 +0200
Message-ID: <20230721160538.447892496@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230721160528.800311148@linuxfoundation.org>
References: <20230721160528.800311148@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

commit 257e6172ab36ebbe295a6c9ee9a9dd0fe54c1dc2 upstream.

If a client sends out a cap update dropping caps with the prior 'seq'
just before an incoming cap revoke request, then the client may drop
the revoke because it believes it's already released the requested
capabilities.

This causes the MDS to wait indefinitely for the client to respond
to the revoke. It's therefore always a good idea to ack the cap
revoke request with the bumped up 'seq'.

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/61782
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Milind Changire <mchangir@redhat.com>
Reviewed-by: Patrick Donnelly <pdonnell@redhat.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/caps.c |    9 +++++++++
 1 file changed, 9 insertions(+)

--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3560,6 +3560,15 @@ static void handle_cap_grant(struct inod
 	}
 	BUG_ON(cap->issued & ~cap->implemented);
 
+	/* don't let check_caps skip sending a response to MDS for revoke msgs */
+	if (le32_to_cpu(grant->op) == CEPH_CAP_OP_REVOKE) {
+		cap->mds_wanted = 0;
+		if (cap == ci->i_auth_cap)
+			check_caps = 1; /* check auth cap only */
+		else
+			check_caps = 2; /* check all caps */
+	}
+
 	if (extra_info->inline_version > 0 &&
 	    extra_info->inline_version >= ci->i_inline_version) {
 		ci->i_inline_version = extra_info->inline_version;


