Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5AB5761762
	for <lists+stable@lfdr.de>; Tue, 25 Jul 2023 13:48:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229683AbjGYLse (ORCPT <rfc822;lists+stable@lfdr.de>);
        Tue, 25 Jul 2023 07:48:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232864AbjGYLrh (ORCPT
        <rfc822;stable@vger.kernel.org>); Tue, 25 Jul 2023 07:47:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D693C199C
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 04:47:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6C1896167D
        for <stable@vger.kernel.org>; Tue, 25 Jul 2023 11:47:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80D5AC433C8;
        Tue, 25 Jul 2023 11:47:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1690285653;
        bh=edg6UkgKYLS5pK85NQ0bKz3X7ep0m+uVIjaSywVztWg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fOZtu5jA8UsLcRVyA1tVgkeLSz7dAeuOx+oh0T7lHzK+p33strZVWnds6e7pqQ0we
         KIVPJeDKlyPrNt0mXHsDwbf+3MvlYr4Pm4XALYxuQIQ5jyqbmV4HHISI0T6A6mHQwp
         NkvIE1e3ASRTDbWkWtaGIzVTgv+jQqFhBD8MDvtI=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     stable@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@lists.linux.dev, Alexander Aring <aahringo@redhat.com>,
        David Teigland <teigland@redhat.com>
Subject: [PATCH 5.4 253/313] fs: dlm: return positive pid value for F_GETLK
Date:   Tue, 25 Jul 2023 12:46:46 +0200
Message-ID: <20230725104532.001128322@linuxfoundation.org>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20230725104521.167250627@linuxfoundation.org>
References: <20230725104521.167250627@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <stable.vger.kernel.org>
X-Mailing-List: stable@vger.kernel.org

From: Alexander Aring <aahringo@redhat.com>

commit 92655fbda5c05950a411eaabc19e025e86e2a291 upstream.

The GETLK pid values have all been negated since commit 9d5b86ac13c5
("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks").
Revert this for local pids, and leave in place negative pids for remote
owners.

Cc: stable@vger.kernel.org
Fixes: 9d5b86ac13c5 ("fs/locks: Remove fl_nspid and use fs-specific l_pid for remote locks")
Signed-off-by: Alexander Aring <aahringo@redhat.com>
Signed-off-by: David Teigland <teigland@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/dlm/plock.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

--- a/fs/dlm/plock.c
+++ b/fs/dlm/plock.c
@@ -363,7 +363,9 @@ int dlm_posix_get(dlm_lockspace_t *locks
 		locks_init_lock(fl);
 		fl->fl_type = (op->info.ex) ? F_WRLCK : F_RDLCK;
 		fl->fl_flags = FL_POSIX;
-		fl->fl_pid = -op->info.pid;
+		fl->fl_pid = op->info.pid;
+		if (op->info.nodeid != dlm_our_nodeid())
+			fl->fl_pid = -fl->fl_pid;
 		fl->fl_start = op->info.start;
 		fl->fl_end = op->info.end;
 		rv = 0;


