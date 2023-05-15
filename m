Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6328C703314
	for <lists+stable@lfdr.de>; Mon, 15 May 2023 18:33:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241954AbjEOQdA (ORCPT <rfc822;lists+stable@lfdr.de>);
        Mon, 15 May 2023 12:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242161AbjEOQc5 (ORCPT
        <rfc822;stable@vger.kernel.org>); Mon, 15 May 2023 12:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32A50B0
        for <stable@vger.kernel.org>; Mon, 15 May 2023 09:32:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 95A406279F
        for <stable@vger.kernel.org>; Mon, 15 May 2023 16:32:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A37F4C4339E;
        Mon, 15 May 2023 16:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684168370;
        bh=sm0lFB1Hn23gvq32Ugr83/HZ6PHLx2Be4MFFqTicPKI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=F8zDOgUO6u85CXKb0wZbVZSKH9TwnyR4jB+7BJkcsaNHUtog1dC6RPkc2fwYt9cEQ
         xaec87QPDGmUtXBDusK7T8vjGtrRAC0zHeHdQpJ0LLQGyqr7OA+c7DLFvi99yBZZO7
         so6A0O83I25PHbv76P+CyOrlal6Je2tjKs4pSF1Q=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [PATCH 4.14 007/116] perf sched: Cast PTHREAD_STACK_MIN to int as it may turn into sysconf(__SC_THREAD_STACK_MIN_VALUE)
Date:   Mon, 15 May 2023 18:25:04 +0200
Message-Id: <20230515161658.507043042@linuxfoundation.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230515161658.228491273@linuxfoundation.org>
References: <20230515161658.228491273@linuxfoundation.org>
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

commit d08c84e01afa7a7eee6badab25d5420fa847f783 upstream.

In fedora rawhide the PTHREAD_STACK_MIN define may end up expanded to a
sysconf() call, and that will return 'long int', breaking the build:

    45 fedora:rawhide                : FAIL gcc version 11.1.1 20210623 (Red Hat 11.1.1-6) (GCC)
      builtin-sched.c: In function 'create_tasks':
      /git/perf-5.14.0-rc1/tools/include/linux/kernel.h:43:24: error: comparison of distinct pointer types lacks a cast [-Werror]
         43 |         (void) (&_max1 == &_max2);              \
            |                        ^~
      builtin-sched.c:673:34: note: in expansion of macro 'max'
        673 |                         (size_t) max(16 * 1024, PTHREAD_STACK_MIN));
            |                                  ^~~
      cc1: all warnings being treated as errors

  $ grep __sysconf /usr/include/*/*.h
  /usr/include/bits/pthread_stack_min-dynamic.h:extern long int __sysconf (int __name) __THROW;
  /usr/include/bits/pthread_stack_min-dynamic.h:#   define PTHREAD_STACK_MIN __sysconf (__SC_THREAD_STACK_MIN_VALUE)
  /usr/include/bits/time.h:extern long int __sysconf (int);
  /usr/include/bits/time.h:# define CLK_TCK ((__clock_t) __sysconf (2))	/* 2 is _SC_CLK_TCK */
  $

So cast it to int to cope with that.

Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Guenter Roeck <linux@roeck-us.net>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/perf/builtin-sched.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -655,7 +655,7 @@ static void create_tasks(struct perf_sch
 	err = pthread_attr_init(&attr);
 	BUG_ON(err);
 	err = pthread_attr_setstacksize(&attr,
-			(size_t) max(16 * 1024, PTHREAD_STACK_MIN));
+			(size_t) max(16 * 1024, (int)PTHREAD_STACK_MIN));
 	BUG_ON(err);
 	err = pthread_mutex_lock(&sched->start_work_mutex);
 	BUG_ON(err);


