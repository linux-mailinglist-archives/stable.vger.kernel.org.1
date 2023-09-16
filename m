Return-Path: <stable-owner@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9271C7A301B
	for <lists+stable@lfdr.de>; Sat, 16 Sep 2023 14:29:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239171AbjIPM2i (ORCPT <rfc822;lists+stable@lfdr.de>);
        Sat, 16 Sep 2023 08:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239057AbjIPM2T (ORCPT
        <rfc822;stable@vger.kernel.org>); Sat, 16 Sep 2023 08:28:19 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EDFC194
        for <stable@vger.kernel.org>; Sat, 16 Sep 2023 05:28:14 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C8E5C433C7;
        Sat, 16 Sep 2023 12:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1694867293;
        bh=fF9xXznG4fM8P8nb6aQdSkyf3P065OMIFugcfO1lRQA=;
        h=Subject:To:Cc:From:Date:From;
        b=KDS0pXVRi8H+nbMH/QAA1+uwO86h72HOiWi0yMeYDGDKMRYmDv42RynK97EhHoBTo
         GS8PIbnKPMeRSNSax80cPtoP/pcv9yRUNPJDnjDKfwWhuL8FIltN/ZBwSjUPtcPJ6a
         mpsH//YUQdKDWnPshyYD3gEzVTa4MzAnyNcesp3Y=
Subject: FAILED: patch "[PATCH] perf hists browser: Fix the number of entries for 'e' key" failed to apply to 4.14-stable tree
To:     namhyung@kernel.org, acme@redhat.com, adrian.hunter@intel.com,
        irogers@google.com, jolsa@kernel.org, mingo@kernel.org,
        peterz@infradead.org
Cc:     <stable@vger.kernel.org>
From:   <gregkh@linuxfoundation.org>
Date:   Sat, 16 Sep 2023 14:28:06 +0200
Message-ID: <2023091606-lisp-unwrapped-1868@gregkh>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
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


The patch below does not apply to the 4.14-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-4.14.y
git checkout FETCH_HEAD
git cherry-pick -x f6b8436bede3e80226e8b2100279c4450c73806a
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2023091606-lisp-unwrapped-1868@gregkh' --subject-prefix 'PATCH 4.14.y' HEAD^..

Possible dependencies:

f6b8436bede3 ("perf hists browser: Fix the number of entries for 'e' key")
e6d6abfc447a ("perf report/top: Make 'e' visible in the help and make it toggle showing callchains")
d10ec006dcd7 ("perf hists browser: Allow passing an initial hotkey")
bdc633fec50b ("perf report/top: Improve toggle callchain menu option")
d5a599d9890f ("perf report/top: Add menu entry for toggling callchain expansion")
9218a9132f83 ("perf report/top: Make ENTER consistently bring up menu")
5cb456af99f5 ("perf util: Move block TUI function to ui browsers")
7fa46cbf20d3 ("perf report: Sort by sampled cycles percent per block for tui")
6f7164fa231a ("perf report: Sort by sampled cycles percent per block for stdio")
b65a7d372b1a ("perf hist: Support block formats with compare/sort/display")
7841f40aed93 ("perf hist: Count the total cycles of all samples")
6041441870ab ("perf block: Cleanup and refactor block info functions")
cebf7d51a6c3 ("perf diff: Report noisy for cycles diff")
6ef81c55a2b6 ("perf session: Return error code for perf_session__new() function on failure")
fb71c86cc804 ("perf tools: Remove util.h from where it is not needed")
4a903c2e1514 ("perf tools: Remove debug.h from places where it is not needed")
b22bb139dcb3 ("perf debug: No need to include ui/util.h")
d3300a3c4e76 ("perf symbols: Move mem_info and branch_info out of symbol.h")
f2a39fe84901 ("perf auxtrace: Uninline functions that touch perf_session")
fa0d98462fae ("perf tools: Remove needless evlist.h include directives")

thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f6b8436bede3e80226e8b2100279c4450c73806a Mon Sep 17 00:00:00 2001
From: Namhyung Kim <namhyung@kernel.org>
Date: Mon, 31 Jul 2023 02:49:33 -0700
Subject: [PATCH] perf hists browser: Fix the number of entries for 'e' key

The 'e' key is to toggle expand/collapse the selected entry only.  But
the current code has a bug that it only increases the number of entries
by 1 in the hierarchy mode so users cannot move under the current entry
after the key stroke.  This is due to a wrong assumption in the
hist_entry__set_folding().

The commit b33f922651011eff ("perf hists browser: Put hist_entry folding
logic into single function") factored out the code, but actually it
should be handled separately.  The hist_browser__set_folding() is to
update fold state for each entry so it needs to traverse all (child)
entries regardless of the current fold state.  So it increases the
number of entries by 1.

But the hist_entry__set_folding() only cares the currently selected
entry and its all children.  So it should count all unfolded child
entries.  This code is implemented in hist_browser__toggle_fold()
already so we can just call it.

Fixes: b33f922651011eff ("perf hists browser: Put hist_entry folding logic into single function")
Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Ian Rogers <irogers@google.com>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: stable@vger.kernel.org
Link: https://lore.kernel.org/r/20230731094934.1616495-2-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index d8b88f10a48d..70db5a717905 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -407,11 +407,6 @@ static bool hist_browser__selection_has_children(struct hist_browser *browser)
 	return container_of(ms, struct callchain_list, ms)->has_children;
 }
 
-static bool hist_browser__he_selection_unfolded(struct hist_browser *browser)
-{
-	return browser->he_selection ? browser->he_selection->unfolded : false;
-}
-
 static bool hist_browser__selection_unfolded(struct hist_browser *browser)
 {
 	struct hist_entry *he = browser->he_selection;
@@ -584,8 +579,8 @@ static int hierarchy_set_folding(struct hist_browser *hb, struct hist_entry *he,
 	return n;
 }
 
-static void __hist_entry__set_folding(struct hist_entry *he,
-				      struct hist_browser *hb, bool unfold)
+static void hist_entry__set_folding(struct hist_entry *he,
+				    struct hist_browser *hb, bool unfold)
 {
 	hist_entry__init_have_children(he);
 	he->unfolded = unfold ? he->has_children : false;
@@ -603,34 +598,12 @@ static void __hist_entry__set_folding(struct hist_entry *he,
 		he->nr_rows = 0;
 }
 
-static void hist_entry__set_folding(struct hist_entry *he,
-				    struct hist_browser *browser, bool unfold)
-{
-	double percent;
-
-	percent = hist_entry__get_percent_limit(he);
-	if (he->filtered || percent < browser->min_pcnt)
-		return;
-
-	__hist_entry__set_folding(he, browser, unfold);
-
-	if (!he->depth || unfold)
-		browser->nr_hierarchy_entries++;
-	if (he->leaf)
-		browser->nr_callchain_rows += he->nr_rows;
-	else if (unfold && !hist_entry__has_hierarchy_children(he, browser->min_pcnt)) {
-		browser->nr_hierarchy_entries++;
-		he->has_no_entry = true;
-		he->nr_rows = 1;
-	} else
-		he->has_no_entry = false;
-}
-
 static void
 __hist_browser__set_folding(struct hist_browser *browser, bool unfold)
 {
 	struct rb_node *nd;
 	struct hist_entry *he;
+	double percent;
 
 	nd = rb_first_cached(&browser->hists->entries);
 	while (nd) {
@@ -640,6 +613,21 @@ __hist_browser__set_folding(struct hist_browser *browser, bool unfold)
 		nd = __rb_hierarchy_next(nd, HMD_FORCE_CHILD);
 
 		hist_entry__set_folding(he, browser, unfold);
+
+		percent = hist_entry__get_percent_limit(he);
+		if (he->filtered || percent < browser->min_pcnt)
+			continue;
+
+		if (!he->depth || unfold)
+			browser->nr_hierarchy_entries++;
+		if (he->leaf)
+			browser->nr_callchain_rows += he->nr_rows;
+		else if (unfold && !hist_entry__has_hierarchy_children(he, browser->min_pcnt)) {
+			browser->nr_hierarchy_entries++;
+			he->has_no_entry = true;
+			he->nr_rows = 1;
+		} else
+			he->has_no_entry = false;
 	}
 }
 
@@ -659,8 +647,10 @@ static void hist_browser__set_folding_selected(struct hist_browser *browser, boo
 	if (!browser->he_selection)
 		return;
 
-	hist_entry__set_folding(browser->he_selection, browser, unfold);
-	browser->b.nr_entries = hist_browser__nr_entries(browser);
+	if (unfold == browser->he_selection->unfolded)
+		return;
+
+	hist_browser__toggle_fold(browser);
 }
 
 static void ui_browser__warn_lost_events(struct ui_browser *browser)
@@ -732,8 +722,8 @@ static int hist_browser__handle_hotkey(struct hist_browser *browser, bool warn_l
 		hist_browser__set_folding(browser, true);
 		break;
 	case 'e':
-		/* Expand the selected entry. */
-		hist_browser__set_folding_selected(browser, !hist_browser__he_selection_unfolded(browser));
+		/* Toggle expand/collapse the selected entry. */
+		hist_browser__toggle_fold(browser);
 		break;
 	case 'H':
 		browser->show_headers = !browser->show_headers;

