Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3006FABFF
	for <lists+stable@lfdr.de>; Mon,  8 May 2023 13:19:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235548AbjEHLTk (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 8 May 2023 07:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235546AbjEHLTj (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 8 May 2023 07:19:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347CB37C5B
        for <stable@vger.kernel.org>; Mon,  8 May 2023 04:19:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C088A62C60
        for <stable@vger.kernel.org>; Mon,  8 May 2023 11:19:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0FC9C433EF;
        Mon,  8 May 2023 11:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1683544774;
        bh=HhS8ufqiPeZJLcjy3gTHXiqrCRYmeorO5lLoe/y8+oU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=n2cBJVfAMNUmUjkf0tTA+uPsf1DyKwVEfk+g44OFjmmb6ejTQFwR/pCf59QcpOzP8
         +Fr3L74F1nTWw/lV4Dl+nx2XgVrueRbWSiJX+PaVxiYv/GG+yN7aM+VEgYEWIw7Egs
         5NgCdLhWc98z3wWEgFjl0HejF2yM+dqxJfG/4XTk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Randy Dunlap <rdunlap@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.3 520/694] ia64: salinfo: placate defined-but-not-used warning
Date:   Mon,  8 May 2023 11:45:55 +0200
Message-Id: <20230508094451.114343207@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230508094432.603705160@linuxfoundation.org>
References: <20230508094432.603705160@linuxfoundation.org>
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

From: Randy Dunlap <rdunlap@infradead.org>

[ Upstream commit 0de155752b152d6bcd96b5b5bf20af336abd183a ]

When CONFIG_PROC_FS is not set, proc_salinfo_show() is not used.  Mark the
function as __maybe_unused to quieten the warning message.

../arch/ia64/kernel/salinfo.c:584:12: warning: 'proc_salinfo_show' defined but not used [-Wunused-function]
  584 | static int proc_salinfo_show(struct seq_file *m, void *v)
      |            ^~~~~~~~~~~~~~~~~

Link: https://lkml.kernel.org/r/20230223034309.13375-1-rdunlap@infradead.org
Fixes: 3f3942aca6da ("proc: introduce proc_create_single{,_data}")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/ia64/kernel/salinfo.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/ia64/kernel/salinfo.c b/arch/ia64/kernel/salinfo.c
index bd3ba276e69c3..03b632c568995 100644
--- a/arch/ia64/kernel/salinfo.c
+++ b/arch/ia64/kernel/salinfo.c
@@ -581,7 +581,7 @@ static int salinfo_cpu_pre_down(unsigned int cpu)
  * 'data' contains an integer that corresponds to the feature we're
  * testing
  */
-static int proc_salinfo_show(struct seq_file *m, void *v)
+static int __maybe_unused proc_salinfo_show(struct seq_file *m, void *v)
 {
 	unsigned long data = (unsigned long)v;
 	seq_puts(m, (sal_platform_features & data) ? "1\n" : "0\n");
-- 
2.39.2



