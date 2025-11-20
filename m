Return-Path: <stable+bounces-195312-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 412BDC752AD
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 16:56:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by tor.lore.kernel.org (Postfix) with ESMTPS id 4C2EA2B9CE
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 15:56:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46A4F2E88B0;
	Thu, 20 Nov 2025 15:56:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Exvh0YZf"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05BD215855E
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 15:56:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763654205; cv=none; b=sxfYru5RM9dLrtINHio3+cOlTDECuu92ETYsJgeRPUzuossBF+39gjPoPv/N6mYjUwlwblluyy0Jc6ZJaIAXLGmsnr1LA/HYPKxtvXagDHbBdUYbUi25+GQI7y/sjhj+BMY6LOX2RyYfUG64XTHK2AsOfvJlJ0YmOkFXtCl00Ro=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763654205; c=relaxed/simple;
	bh=ri6QVeZGuO8PpBNcB2BXJ7Kt7GxzykjSxdbzCM4OloQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=QaCkj+cpG3KgGe2CjknRLd2Cp2fjA7145DcacwAoIzpKLGDvfrflaZZqBvx/iHhyS72xgY+IPe3H2VoybqWVo2MJp3Wph+vMA+G4zbZnv/4+uK5pw+nCb16hcHMERdj27nEuV24FJkQxJHh7yI7sE/po+ZBw2e48pU0NjfiP4iU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Exvh0YZf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80274C4CEF1;
	Thu, 20 Nov 2025 15:56:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1763654204;
	bh=ri6QVeZGuO8PpBNcB2BXJ7Kt7GxzykjSxdbzCM4OloQ=;
	h=Subject:To:Cc:From:Date:From;
	b=Exvh0YZfIpE01mtnZagr9m/aTughGU8iMbvnBhqwH+Fbth9BweLhwUu2SosFxARqk
	 58rO3yZqJVdtjZFc1Zk13wtuW6G0R9kfiPtfCrDOBXY07SFMJjfgBphmsF0C52x1DA
	 8S6C1LD6aMULabb5KQ+sI9FXRSRwWLM9H0JQ+FPE=
Subject: FAILED: patch "[PATCH] scripts/decode_stacktrace.sh: fix build ID and PC source" failed to apply to 6.17-stable tree
To: cmllamas@google.com,akpm@linux-foundation.org,broonie@kernel.org,catalin.marinas@arm.com,leitao@debian.org,luca.ceresoli@bootlin.com,mark.rutland@arm.com,matttbe@kernel.org,mbenes@suse.cz,puranjay@kernel.org,stable@vger.kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Nov 2025 16:56:31 +0100
Message-ID: <2025112031-catalyze-sleep-ba6e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.17-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.17.y
git checkout FETCH_HEAD
git cherry-pick -x 7d9f7d390f6af3a29614e81e802e2b9c238eb7b2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025112031-catalyze-sleep-ba6e@gregkh' --subject-prefix 'PATCH 6.17.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7d9f7d390f6af3a29614e81e802e2b9c238eb7b2 Mon Sep 17 00:00:00 2001
From: Carlos Llamas <cmllamas@google.com>
Date: Thu, 30 Oct 2025 01:03:33 +0000
Subject: [PATCH] scripts/decode_stacktrace.sh: fix build ID and PC source
 parsing

Support for parsing PC source info in stacktraces (e.g.  '(P)') was added
in commit 2bff77c665ed ("scripts/decode_stacktrace.sh: fix decoding of
lines with an additional info").  However, this logic was placed after the
build ID processing.  This incorrect order fails to parse lines containing
both elements, e.g.:

  drm_gem_mmap_obj+0x114/0x200 [drm 03d0564e0529947d67bb2008c3548be77279fd27] (P)

This patch fixes the problem by extracting the PC source info first and
then processing the module build ID.  With this change, the line above is
now properly parsed as such:

  drm_gem_mmap_obj (./include/linux/mmap_lock.h:212 ./include/linux/mm.h:811 drivers/gpu/drm/drm_gem.c:1177) drm (P)

While here, also add a brief explanation the build ID section.

Link: https://lkml.kernel.org/r/20251030010347.2731925-1-cmllamas@google.com
Fixes: 2bff77c665ed ("scripts/decode_stacktrace.sh: fix decoding of lines with an additional info")
Signed-off-by: Carlos Llamas <cmllamas@google.com>
Reviewed-by: Matthieu Baerts (NGI0) <matttbe@kernel.org>
Reviewed-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: Breno Leitao <leitao@debian.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marc Rutland <mark.rutland@arm.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Matthieu Baerts <matttbe@kernel.org>
Cc: Miroslav Benes <mbenes@suse.cz>
Cc: Puranjay Mohan <puranjay@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index c73cb802a0a3..8d01b741de62 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -277,12 +277,6 @@ handle_line() {
 		fi
 	done
 
-	if [[ ${words[$last]} =~ ^[0-9a-f]+\] ]]; then
-		words[$last-1]="${words[$last-1]} ${words[$last]}"
-		unset words[$last] spaces[$last]
-		last=$(( $last - 1 ))
-	fi
-
 	# Extract info after the symbol if present. E.g.:
 	# func_name+0x54/0x80 (P)
 	#                     ^^^
@@ -295,6 +289,14 @@ handle_line() {
 		last=$(( $last - 1 ))
 	fi
 
+	# Join module name with its build id if present, as these were
+	# split during tokenization (e.g. "[module" and "modbuildid]").
+	if [[ ${words[$last]} =~ ^[0-9a-f]+\] ]]; then
+		words[$last-1]="${words[$last-1]} ${words[$last]}"
+		unset words[$last] spaces[$last]
+		last=$(( $last - 1 ))
+	fi
+
 	if [[ ${words[$last]} =~ \[([^]]+)\] ]]; then
 		module=${words[$last]}
 		# some traces format is "(%pS)", which like "(foo+0x0/0x1 [bar])"


