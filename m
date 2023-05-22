Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EA4370C6B1
	for <lists+stable@lfdr.de>; Mon, 22 May 2023 21:21:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234368AbjEVTVR (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 22 May 2023 15:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234373AbjEVTVP (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 22 May 2023 15:21:15 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6429893
        for <stable@vger.kernel.org>; Mon, 22 May 2023 12:21:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 018DE6282E
        for <stable@vger.kernel.org>; Mon, 22 May 2023 19:21:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1F3C4339B;
        Mon, 22 May 2023 19:21:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684783273;
        bh=mvaH/ft45hKSwlqj6qSsLzH/xsI4osguc62vsp3jqwQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vRatyjSjNkh0dylQgl6fHhrMdGz/e62XhnNL49TxiXkVMli0crcAAM+M6E49aiYvQ
         VWfLRUF8syVzXCGPnDAn18zvf/tM74nyKYbKRJZ/VWqaBzOqsHuhTraZmpRImCG2Fz
         lL9jldrB+lkL/k/oa7S3fTfwQjAPrNfnFlteyktw=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Frank Schilder <frans@dtu.dk>,
        Xiubo Li <xiubli@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 5.15 195/203] ceph: force updating the msg pointer in non-split case
Date:   Mon, 22 May 2023 20:10:19 +0100
Message-Id: <20230522190400.428217882@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230522190354.935300867@linuxfoundation.org>
References: <20230522190354.935300867@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Xiubo Li <xiubli@redhat.com>

commit 4cafd0400bcb6187c0d4ab4d4b0229a89ac4f8c2 upstream.

When the MClientSnap reqeust's op is not CEPH_SNAP_OP_SPLIT the
request may still contain a list of 'split_realms', and we need
to skip it anyway. Or it will be parsed as a corrupt snaptrace.

Cc: stable@vger.kernel.org
Link: https://tracker.ceph.com/issues/61200
Reported-by: Frank Schilder <frans@dtu.dk>
Signed-off-by: Xiubo Li <xiubli@redhat.com>
Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/ceph/snap.c |   13 +++++++++++++
 1 file changed, 13 insertions(+)

--- a/fs/ceph/snap.c
+++ b/fs/ceph/snap.c
@@ -1028,6 +1028,19 @@ skip_inode:
 				continue;
 			adjust_snap_realm_parent(mdsc, child, realm->ino);
 		}
+	} else {
+		/*
+		 * In the non-split case both 'num_split_inos' and
+		 * 'num_split_realms' should be 0, making this a no-op.
+		 * However the MDS happens to populate 'split_realms' list
+		 * in one of the UPDATE op cases by mistake.
+		 *
+		 * Skip both lists just in case to ensure that 'p' is
+		 * positioned at the start of realm info, as expected by
+		 * ceph_update_snap_trace().
+		 */
+		p += sizeof(u64) * num_split_inos;
+		p += sizeof(u64) * num_split_realms;
 	}
 
 	/*


