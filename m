Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6815879BE35
	for <lists+stable@lfdr.de>; Tue, 12 Sep 2023 02:17:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376347AbjIKWTQ (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 11 Sep 2023 18:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241281AbjIKPFk (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 11 Sep 2023 11:05:40 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59B131B9
        for <stable@vger.kernel.org>; Mon, 11 Sep 2023 08:05:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0226C433C8;
        Mon, 11 Sep 2023 15:05:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694444736;
        bh=6cGUWQ6yHz716sgMSCvUwiJxTzioz8hU9RzPxCoKU60=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=cxqLP9QFSgDZYV1yVhoS/r8+j+TWX+t9fVH735pyMwn64MnhSmhOn4wsPzcv/iTgk
         40GdbMYbMHUUqo6Mcijk3LD1QQ6H5lXYChA3Aq0T90AWt5leEq2N0FC9nnhEJb2PHt
         1yt4P9dtB9huXffNbss+isGaxz/vDKVh/DTkbJlM=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Ian Rogers <irogers@google.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jiri Olsa <jolsa@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 6.1 098/600] tools/resolve_btfids: Tidy HOST_OVERRIDES
Date:   Mon, 11 Sep 2023 15:42:11 +0200
Message-ID: <20230911134636.497588643@linuxfoundation.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20230911134633.619970489@linuxfoundation.org>
References: <20230911134633.619970489@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ian Rogers <irogers@google.com>

commit e0975ab92f2406fd3e12834f62dc57cb10404f85 upstream.

Don't set EXTRA_CFLAGS to HOSTCFLAGS, ensure CROSS_COMPILE isn't
passed through.

Signed-off-by: Ian Rogers <irogers@google.com>
Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Link: https://lore.kernel.org/bpf/20230202224253.40283-1-irogers@google.com
Cc: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/bpf/resolve_btfids/Makefile |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/tools/bpf/resolve_btfids/Makefile
+++ b/tools/bpf/resolve_btfids/Makefile
@@ -17,9 +17,9 @@ else
   MAKEFLAGS=--no-print-directory
 endif
 
-# always use the host compiler
+# Overrides for the prepare step libraries.
 HOST_OVERRIDES := AR="$(HOSTAR)" CC="$(HOSTCC)" LD="$(HOSTLD)" ARCH="$(HOSTARCH)" \
-		  EXTRA_CFLAGS="$(HOSTCFLAGS) $(KBUILD_HOSTCFLAGS)"
+		  CROSS_COMPILE=""
 
 RM      ?= rm
 HOSTCC  ?= gcc


