Return-Path: <stable+bounces-83341-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id BAB2B99847F
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 13:07:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56A62B2751A
	for <lists+stable@lfdr.de>; Thu, 10 Oct 2024 11:07:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 578301C4609;
	Thu, 10 Oct 2024 11:06:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cwhdiNQ2"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 139371C245B;
	Thu, 10 Oct 2024 11:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728558409; cv=none; b=OsB7pK3KZdQtNNKNCcbI88yHQE7NCOThE/JT1SFyVMD0sXaYHwEm5Zu1VQH0cPjundMujuaIiYAvIGKGr4WoNJEuJw+0V2ojvxgkXmcXEXHkudTJ4fjbaCLR3xeByRXnC/6t6p+6MytKt5Z514HJk5KU4A/z/kSxrfmhMTiZMPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728558409; c=relaxed/simple;
	bh=dJV9aCYcY7E9gcS+re6KKVn4+hyOlb7m4eaxnZwGmk8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Li+kaoyOAA+oXA+S4cd5ol6wnptqtJbkt6jpMcLYatnWwMVoUHhkzfh/VCv3vffRx+vBioiDieRG4lqbofCuFuvZV2SVqdczT3Uzrkq0FXZ5+xRUQ3RwJmMY9NHksur7RNzSETk2rR4GHXKmddY4RUDdHId3Ekdi4LxGKoye5NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cwhdiNQ2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 755CFC4CEC5;
	Thu, 10 Oct 2024 11:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1728558408;
	bh=dJV9aCYcY7E9gcS+re6KKVn4+hyOlb7m4eaxnZwGmk8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cwhdiNQ2qtaWzxgQ0OtwXaXKOirRFIcxNMcABdMSOt17yXosRShjAEUZllQfU7/Au
	 NxGBQA/6f3wHFyhWx6HtWwOMTBRUlAYic4FqE4VqZ5mTLGFAPc30wfL1wmG6X2t8JD
	 yC6KqHThIlqkBlabk9L7TmiZpktCa89F4Apj4s6U=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 6.6.56
Date: Thu, 10 Oct 2024 13:06:37 +0200
Message-ID: <2024101038-undated-bullpen-8b09@gregkh>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <2024101038-overhung-discard-e873@gregkh>
References: <2024101038-overhung-discard-e873@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 6e297758842d..301c5694995c 100644
--- a/Makefile
+++ b/Makefile
@@ -1,9 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 6
 PATCHLEVEL = 6
-SUBLEVEL = 55
+SUBLEVEL = 56
 EXTRAVERSION =
-NAME = Hurr durr I'ma ninja sloth
+NAME = Pinguïn Aangedreven
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 24dead4e3065..7c6874804660 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2536,12 +2536,8 @@ static void save_lbr_cursor_node(struct thread *thread,
 		cursor->curr = cursor->first;
 	else
 		cursor->curr = cursor->curr->next;
-
-	map_symbol__exit(&lbr_stitch->prev_lbr_cursor[idx].ms);
 	memcpy(&lbr_stitch->prev_lbr_cursor[idx], cursor->curr,
 	       sizeof(struct callchain_cursor_node));
-	lbr_stitch->prev_lbr_cursor[idx].ms.maps = maps__get(cursor->curr->ms.maps);
-	lbr_stitch->prev_lbr_cursor[idx].ms.map = map__get(cursor->curr->ms.map);
 
 	lbr_stitch->prev_lbr_cursor[idx].valid = true;
 	cursor->pos++;
@@ -2752,9 +2748,6 @@ static bool has_stitched_lbr(struct thread *thread,
 		memcpy(&stitch_node->cursor, &lbr_stitch->prev_lbr_cursor[i],
 		       sizeof(struct callchain_cursor_node));
 
-		stitch_node->cursor.ms.maps = maps__get(lbr_stitch->prev_lbr_cursor[i].ms.maps);
-		stitch_node->cursor.ms.map = map__get(lbr_stitch->prev_lbr_cursor[i].ms.map);
-
 		if (callee)
 			list_add(&stitch_node->node, &lbr_stitch->lists);
 		else
@@ -2778,8 +2771,6 @@ static bool alloc_lbr_stitch(struct thread *thread, unsigned int max_lbr)
 	if (!thread__lbr_stitch(thread)->prev_lbr_cursor)
 		goto free_lbr_stitch;
 
-	thread__lbr_stitch(thread)->prev_lbr_cursor_size = max_lbr + 1;
-
 	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->lists);
 	INIT_LIST_HEAD(&thread__lbr_stitch(thread)->free_lists);
 
@@ -2835,12 +2826,8 @@ static int resolve_lbr_callchain_sample(struct thread *thread,
 						max_lbr, callee);
 
 		if (!stitched_lbr && !list_empty(&lbr_stitch->lists)) {
-			struct stitch_list *stitch_node;
-
-			list_for_each_entry(stitch_node, &lbr_stitch->lists, node)
-				map_symbol__exit(&stitch_node->cursor.ms);
-
-			list_splice_init(&lbr_stitch->lists, &lbr_stitch->free_lists);
+			list_replace_init(&lbr_stitch->lists,
+					  &lbr_stitch->free_lists);
 		}
 		memcpy(&lbr_stitch->prev_sample, sample, sizeof(*sample));
 	}
diff --git a/tools/perf/util/thread.c b/tools/perf/util/thread.c
index 6817b99e550b..61e9f449c725 100644
--- a/tools/perf/util/thread.c
+++ b/tools/perf/util/thread.c
@@ -478,7 +478,6 @@ void thread__free_stitch_list(struct thread *thread)
 		return;
 
 	list_for_each_entry_safe(pos, tmp, &lbr_stitch->lists, node) {
-		map_symbol__exit(&pos->cursor.ms);
 		list_del_init(&pos->node);
 		free(pos);
 	}
@@ -488,9 +487,6 @@ void thread__free_stitch_list(struct thread *thread)
 		free(pos);
 	}
 
-	for (unsigned int i = 0 ; i < lbr_stitch->prev_lbr_cursor_size; i++)
-		map_symbol__exit(&lbr_stitch->prev_lbr_cursor[i].ms);
-
 	zfree(&lbr_stitch->prev_lbr_cursor);
 	free(thread__lbr_stitch(thread));
 	thread__set_lbr_stitch(thread, NULL);
diff --git a/tools/perf/util/thread.h b/tools/perf/util/thread.h
index a5423f834dc9..0df775b5c110 100644
--- a/tools/perf/util/thread.h
+++ b/tools/perf/util/thread.h
@@ -28,7 +28,6 @@ struct lbr_stitch {
 	struct list_head		free_lists;
 	struct perf_sample		prev_sample;
 	struct callchain_cursor_node	*prev_lbr_cursor;
-	unsigned int prev_lbr_cursor_size;
 };
 
 struct thread_rb_node {

