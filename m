Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3410173527C
	for <lists+stable@lfdr.de>; Mon, 19 Jun 2023 12:35:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231664AbjFSKfg (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 19 Jun 2023 06:35:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232120AbjFSKfH (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 19 Jun 2023 06:35:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E3EECD
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 03:35:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2463960B6D
        for <stable@vger.kernel.org>; Mon, 19 Jun 2023 10:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 397DEC433C8;
        Mon, 19 Jun 2023 10:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687170902;
        bh=1rA60v34VpalHgNbi1f2EV+1rMNTKszrS8EJULrYUgA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lEzqZQM8JFxn3pPj2+SLYdG3WJr1GmtHhucgTXlKnBBEPI1t9/ZslzlsaLG5c6mAa
         WM6Yh3knvJZuO5A8d9xMyBsQt7lCVwNTT5rNbhfLTdngeE43tYcJ7nzUl7MDaNN8BO
         TcyZQTku5xV28ha9HfE5noL+ZMq2RnBovtORuv9c=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Haibo Li <haibo.li@mediatek.com>,
        David Hildenbrand <david@redhat.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 6.3 077/187] mm/gup_test: fix ioctl fail for compat task
Date:   Mon, 19 Jun 2023 12:28:15 +0200
Message-ID: <20230619102201.353391346@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230619102157.579823843@linuxfoundation.org>
References: <20230619102157.579823843@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Haibo Li <haibo.li@mediatek.com>

commit 4f572f0074b8be8a70bd150d96a749aa94c8d85f upstream.

When tools/testing/selftests/mm/gup_test.c is compiled as 32bit, then run
on arm64 kernel, it reports "ioctl: Inappropriate ioctl for device".

Fix it by filling compat_ioctl in gup_test_fops

Link: https://lkml.kernel.org/r/20230526022125.175728-1-haibo.li@mediatek.com
Signed-off-by: Haibo Li <haibo.li@mediatek.com>
Acked-by: David Hildenbrand <david@redhat.com>
Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Cc: Matthias Brugger <matthias.bgg@gmail.com>
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 mm/gup_test.c |    1 +
 1 file changed, 1 insertion(+)

--- a/mm/gup_test.c
+++ b/mm/gup_test.c
@@ -381,6 +381,7 @@ static int gup_test_release(struct inode
 static const struct file_operations gup_test_fops = {
 	.open = nonseekable_open,
 	.unlocked_ioctl = gup_test_ioctl,
+	.compat_ioctl = compat_ptr_ioctl,
 	.release = gup_test_release,
 };
 


