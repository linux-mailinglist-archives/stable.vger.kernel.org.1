Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADD1F7B87AD
	for <lists+stable@lfdr.de>; Wed,  4 Oct 2023 20:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243845AbjJDSIH (ORCPT <rfc822;lists+stable@lfdr.de>);
        Wed, 4 Oct 2023 14:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243848AbjJDSIG (ORCPT
        <rfc822;stable@vger.kernel.org>); Wed, 4 Oct 2023 14:08:06 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E5A2BF
        for <stable@vger.kernel.org>; Wed,  4 Oct 2023 11:08:03 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A5FC433C7;
        Wed,  4 Oct 2023 18:08:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1696442882;
        bh=bGU+5ASGzg2sKsRXB6/i7VsYUSslbaQ6oAvTyd93BFQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=U4FY9Oxmg3f/dO5Dw/au08+1LxXMltJ1QRTk1kdtpFbXtRx1tkUct+CXGwHQzZ5DZ
         EgwL+hv1C8yw8gach+nH9eJoBjW+OzuHBaFFV6/dyW80cpnOmvR/fKl0AbQ+HeJcT/
         KDkqcR6H0XuJYRU1hlCHmw8Pky0C9Qli3DZpKVTE=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Adrian Hunter <adrian.hunter@intel.com>,
        Ian Rogers <irogers@google.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 142/183] perf build: Define YYNOMEM as YYNOABORT for bison < 3.81
Date:   Wed,  4 Oct 2023 19:56:13 +0200
Message-ID: <20231004175209.938770222@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231004175203.943277832@linuxfoundation.org>
References: <20231004175203.943277832@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 88cc47e24597971b05b6e94c28a2fc81d2a8d61a ]

YYNOMEM was introduced in bison 3.81, so define it as YYABORT for older
versions, which should provide the previous perf behaviour.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/Build | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index f2914d5bed6e8..7d085927da413 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -263,6 +263,12 @@ ifeq ($(BISON_GE_35),1)
 else
   bison_flags += -w
 endif
+
+BISON_LT_381 := $(shell expr $(shell $(BISON) --version | grep bison | sed -e 's/.\+ \([0-9]\+\).\([0-9]\+\).\([0-9]\+\)/\1\2\3/g') \< 381)
+ifeq ($(BISON_LT_381),1)
+  bison_flags += -DYYNOMEM=YYABORT
+endif
+
 CFLAGS_parse-events-bison.o += $(bison_flags)
 CFLAGS_pmu-bison.o          += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
 CFLAGS_expr-bison.o         += -DYYLTYPE_IS_TRIVIAL=0 $(bison_flags)
-- 
2.40.1



