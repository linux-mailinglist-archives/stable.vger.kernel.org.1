Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4B7C75E9B6
	for <lists+stable@lfdr.de>; Mon, 24 Jul 2023 04:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbjGXC3c (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sun, 23 Jul 2023 22:29:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229974AbjGXC3b (ORCPT
        <rfc822;stable@vger.kernel.org>); Sun, 23 Jul 2023 22:29:31 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BA01FD
        for <stable@vger.kernel.org>; Sun, 23 Jul 2023 19:29:19 -0700 (PDT)
Received: from dggpeml500012.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4R8PGg5r4Jz1K9s8;
        Mon, 24 Jul 2023 10:28:27 +0800 (CST)
Received: from localhost.localdomain (10.67.175.61) by
 dggpeml500012.china.huawei.com (7.185.36.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Mon, 24 Jul 2023 10:29:17 +0800
From:   Zheng Yejian <zhengyejian1@huawei.com>
To:     <gregkh@linuxfoundation.org>
CC:     <rostedt@goodmis.org>, <stable@vger.kernel.org>,
        <zhengyejian1@huawei.com>
Subject: [PATCH 5.10 0/2] re: FAILED: patch "[PATCH] ftrace: Fix possible
Date:   Mon, 24 Jul 2023 10:29:22 +0800
Message-ID: <20230724022924.3478612-1-zhengyejian1@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <2023072114-giblet-unzip-f1db@gregkh>
References: <2023072114-giblet-unzip-f1db@gregkh>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.67.175.61]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500012.china.huawei.com (7.185.36.15)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

Resolve backport failed due to lack of dependency commit
db42523b4f3e ("ftrace: Store the order of pages allocated in ftrace_page")

Linus Torvalds (1):
  ftrace: Store the order of pages allocated in ftrace_page

Zheng Yejian (1):
  ftrace: Fix possible warning on checking all pages used in
    ftrace_process_locs()

 kernel/trace/ftrace.c | 72 ++++++++++++++++++++++++++-----------------
 1 file changed, 44 insertions(+), 28 deletions(-)

-- 
2.25.1

