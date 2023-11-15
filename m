Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17ED17ECCF9
	for <lists+stable@lfdr.de>; Wed, 15 Nov 2023 20:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234250AbjKOTdj (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 15 Nov 2023 14:33:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234267AbjKOTdh (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 15 Nov 2023 14:33:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5094B1A8
        for <stable@vger.kernel.org>; Wed, 15 Nov 2023 11:33:34 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B059FC433CA;
        Wed, 15 Nov 2023 19:33:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1700076813;
        bh=R/SmjGdUljmuZxT9j07bD+CR7P/0fzAe5/sJ7PR+o5g=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=puKrpBf0/PJhTU/Vuo5KR8i52yh3F7/ObrIe+rJanhJJ8qs4Kt17ws1oVd4itM6dl
         az90ceCD3etwiI0M0k8//QNgUccbPhoSXsQZBfwg+I0VOl3RTQ9gdJFxEvbc3PJwe+
         nOCpdg58bOc6L2AgabaZU56okrZxb8ATQIcsCiPs=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, kernel test robot <lkp@intel.com>,
        Ian Rogers <irogers@google.com>, oe-kbuild-all@lists.linux.dev,
        Namhyung Kim <namhyung@kernel.org>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 431/550] perf tools: Do not ignore the default vmlinux.h
Date:   Wed, 15 Nov 2023 14:16:55 -0500
Message-ID: <20231115191630.645033532@linuxfoundation.org>
X-Mailer: git-send-email 2.42.1
In-Reply-To: <20231115191600.708733204@linuxfoundation.org>
References: <20231115191600.708733204@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Namhyung Kim <namhyung@kernel.org>

[ Upstream commit 1f36b190ad2dea68e3a7e84b7b2f24ce8c4063ea ]

The recent change made it possible to generate vmlinux.h from BTF and
to ignore the file.  But we also have a minimal vmlinux.h that will be
used by default.  It should not be ignored by GIT.

Fixes: b7a2d774c9c5 ("perf build: Add ability to build with a generated vmlinux.h")
Reported-by: kernel test robot <lkp@intel.com>
Reviewed-by: Ian Rogers <irogers@google.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202310110451.rvdUZJEY-lkp@intel.com/
Cc: oe-kbuild-all@lists.linux.dev
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/bpf_skel/vmlinux/.gitignore | 1 +
 1 file changed, 1 insertion(+)
 create mode 100644 tools/perf/util/bpf_skel/vmlinux/.gitignore

diff --git a/tools/perf/util/bpf_skel/vmlinux/.gitignore b/tools/perf/util/bpf_skel/vmlinux/.gitignore
new file mode 100644
index 0000000000000..49502c04183a2
--- /dev/null
+++ b/tools/perf/util/bpf_skel/vmlinux/.gitignore
@@ -0,0 +1 @@
+!vmlinux.h
-- 
2.42.0



