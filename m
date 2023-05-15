Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DB24703880
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:32:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244321AbjEORcx (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:32:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244327AbjEORch (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A961DDBF
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:29:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 968C962083
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:29:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C135C433D2;
        Mon, 15 May 2023 17:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171791;
        bh=w1jTZOrqbsu/LNImxaqRXBXXWvrVtgOAWa9jG7JIQUM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=zULjug6KzkIywK/4Gif3Sg/elLPmrFKgmw6V6oAWrvtFEaFzCc38upuHkK8gCaKpR
         BKBGRTZqD/Fe5sg6I9w2pYLkOuRR0gotnls+IbTKRZ0y3P5CoBkQu8ZoEhEMRSYGoQ
         +pnpgGMxJdYK9obt5iY5Jh1+3kXcGSBhXZV1xwpI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Roman Lozko <lozko.roma@gmail.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 049/134] perf scripts intel-pt-events.py: Fix IPC output for Python 2
Date:   Mon, 15 May 2023 18:28:46 +0200
Message-Id: <20230515161704.781668679@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Roman Lozko <lozko.roma@gmail.com>

[ Upstream commit 1f64cfdebfe0494264271e8d7a3a47faf5f58ec7 ]

Integers are not converted to floats during division in Python 2 which
results in incorrect IPC values. Fix by switching to new division
behavior.

Fixes: a483e64c0b62e93a ("perf scripting python: intel-pt-events.py: Add --insn-trace and --src-trace")
Signed-off-by: Roman Lozko <lozko.roma@gmail.com>
Acked-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Link: https://lore.kernel.org/r/20230310150445.2925841-1-lozko.roma@gmail.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/scripts/python/intel-pt-events.py | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/scripts/python/intel-pt-events.py b/tools/perf/scripts/python/intel-pt-events.py
index 66452a8ec3586..ed6f614f2724d 100644
--- a/tools/perf/scripts/python/intel-pt-events.py
+++ b/tools/perf/scripts/python/intel-pt-events.py
@@ -11,7 +11,7 @@
 # FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
 # more details.
 
-from __future__ import print_function
+from __future__ import division, print_function
 
 import os
 import sys
-- 
2.39.2



