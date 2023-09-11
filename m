Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1253379BAD0
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:12:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348738AbjIKVae (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 17:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238476AbjIKN5V (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 09:57:21 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5FEACD7
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 06:57:16 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C3F2C433C8;
        Mon, 11 Sep 2023 13:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694440636;
        bh=s7UhqM2SnS08/mny9mDQEA1AFgjWlIz4jW1KnQv2fp4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=C1ZBS1rIFPmqSQAGgM9eflfxYho7auPkFDZllXE90RXsplgjmNGbis6oSvu0h2+ye
         ZtWdtqPQTvP7Gv4R8Rvs0wWDIzXIgn8fR3/y0llA7IpRypACkRhLqT/FNwmJEqjBe/
         MIkT0el2kpIhWTIZoZrlCyAIBar/iFzE7yBLcon8=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Marco Vedovati <marco.vedovati@crowdstrike.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.5 131/739] libbpf: Set close-on-exec flag on gzopen
Date:   Mon, 11 Sep 2023 15:38:50 +0200
Message-ID: <20230911134654.746219531@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134650.921299741@linuxfoundation.org>
References: <20230911134650.921299741@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

6.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Marco Vedovati <marco.vedovati@crowdstrike.com>

[ Upstream commit 8e50750f122e59ea4cab4b4f696ef22b391bedc9 ]

Enable the close-on-exec flag when using gzopen. This is especially important
for multithreaded programs making use of libbpf, where a fork + exec could
race with libbpf library calls, potentially resulting in a file descriptor
leaked to the new process. This got missed in 59842c5451fe ("libbpf: Ensure
libbpf always opens files with O_CLOEXEC").

Fixes: 59842c5451fe ("libbpf: Ensure libbpf always opens files with O_CLOEXEC")
Signed-off-by: Marco Vedovati <marco.vedovati@crowdstrike.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Link: https://lore.kernel.org/bpf/20230810214350.106301-1-martin.kelly@crowdstrike.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/lib/bpf/libbpf.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/lib/bpf/libbpf.c b/tools/lib/bpf/libbpf.c
index 7cc79bf764550..e07dff7eba600 100644
--- a/tools/lib/bpf/libbpf.c
+++ b/tools/lib/bpf/libbpf.c
@@ -1975,9 +1975,9 @@ static int bpf_object__read_kconfig_file(struct bpf_object *obj, void *data)
 		return -ENAMETOOLONG;
 
 	/* gzopen also accepts uncompressed files. */
-	file = gzopen(buf, "r");
+	file = gzopen(buf, "re");
 	if (!file)
-		file = gzopen("/proc/config.gz", "r");
+		file = gzopen("/proc/config.gz", "re");
 
 	if (!file) {
 		pr_warn("failed to open system Kconfig\n");
-- 
2.40.1



