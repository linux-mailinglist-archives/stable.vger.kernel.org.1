Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C62C703883
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 19:32:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244377AbjEORcz (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 13:32:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244344AbjEORci (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 13:32:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E089D06C
        for <stable@vger.kernel.org>; Mon, 15 May 2023 10:29:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9F94862D1D
        for <stable@vger.kernel.org>; Mon, 15 May 2023 17:29:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96F8FC433D2;
        Mon, 15 May 2023 17:29:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684171797;
        bh=IXW+SxrrS9I3G4nKeObOhNkcrAc+UvDXcBFwOekBzes=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=GZR4XrP22p1OH1YauJv5mu4BGvbZ7hJAIz5+Ekl9/4yINsq9gbEZu596dUDYZD5+s
         v0pXTN/QdG5v8Ps/g2pfZyp5tpbdBFORc8I/1699ADHCr+ObVlrSA8jKYBKonpVmmU
         9MhexkvTpca2wVb2RTWxbh7dIbSEg+d7zjHMU27Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15 051/134] perf pmu: zfree() expects a pointer to a pointer to zero it after freeing its contents
Date:   Mon, 15 May 2023 18:28:48 +0200
Message-Id: <20230515161704.842936829@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161702.887638251@linuxfoundation.org>
References: <20230515161702.887638251@linuxfoundation.org>
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

From: Arnaldo Carvalho de Melo <acme@redhat.com>

[ Upstream commit 57f14b5ae1a97537f2abd2828ee7212cada7036e ]

An audit showed just this one problem with zfree(), fix it.

Fixes: 9fbc61f832ebf432 ("perf pmu: Add support for PMU capabilities")
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/perf/util/pmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 26c0b88cef4c8..eafd80be66076 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -1858,7 +1858,7 @@ static int perf_pmu__new_caps(struct list_head *list, char *name, char *value)
 	return 0;
 
 free_name:
-	zfree(caps->name);
+	zfree(&caps->name);
 free_caps:
 	free(caps);
 
-- 
2.39.2



