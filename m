Return-Path: <stable+bounces-98401-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A9AD9E40FA
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 18:15:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 646321619BD
	for <lists+stable@lfdr.de>; Wed,  4 Dec 2024 17:15:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7D9D32139BC;
	Wed,  4 Dec 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y7hd4iZT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABA8213255;
	Wed,  4 Dec 2024 17:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733331660; cv=none; b=mx30MXS0maJMwgjCKNoU5InvK7NFKZJ5CyAl5YVnm0hLEY8eGPiCc5JhMa0bqESLzJtaYZzvI4FOewIQegGyPkfxmD+I2+CGpduYqKtuCpctorUBqLuuTxTu6AalIKcr/hLxOhRcE21IBiQ3abScWCP/2RV433ICDMlf6A4pVqQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733331660; c=relaxed/simple;
	bh=oDKrhmkhEDIgHaXI1MH3VxbvBxyG9qAbuFJiKqPcUpY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ty4T2FPTnO0UwqjeOIgOzXE27OjP/iPYKn0WNF69uwkm5Ugo5MXDKSrifkUNVevrBvGlW6ox7Z3J8BHqzhJecfKMH5rmEvR0zdS8TJ6Z1XkNdnRseKlrh7uCOlMg0Ttu0zhsVZ8MSXXLCvs33IwIo16+v2yXw1zH1Nn4rQCpxJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y7hd4iZT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07354C4CECD;
	Wed,  4 Dec 2024 17:00:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733331659;
	bh=oDKrhmkhEDIgHaXI1MH3VxbvBxyG9qAbuFJiKqPcUpY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Y7hd4iZToD8xVrXQCuq7JNQ0t+9KFudOAeiQwFpqQ2GV2gXZnz1qTmVU5uJqu02HC
	 AAVQrtfThK6jD93K5FI17l982VB+I3tFH9Z/aJzDHm/Wv73iChwLnmvwEfPu56r4vA
	 OVc4Qv4LnE15LHImN7yRxut01huGCPmfrY9jiTj72GpIGNBu9gR802NyO123gQU88z
	 y1mfavn1BWpGPsSkH0hjmM3aoCl9C7g9mus+8y/k4DxHB4rfCB/gB2sY2JOOzPfsPF
	 0r9PEd2HjiEAB100nTxoWaVNMmKwz7Xmn45+345MntTezNUbalchtbV/R7H6eDEiZ/
	 +pjofn9CyYPLA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Gabriele Monaco <gmonaco@redhat.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-trace-kernel@vger.kernel.org
Subject: [PATCH AUTOSEL 6.11 32/33] verification/dot2: Improve dot parser robustness
Date: Wed,  4 Dec 2024 10:47:45 -0500
Message-ID: <20241204154817.2212455-32-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241204154817.2212455-1-sashal@kernel.org>
References: <20241204154817.2212455-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.10
Content-Transfer-Encoding: 8bit

From: Gabriele Monaco <gmonaco@redhat.com>

[ Upstream commit 571f8b3f866a6d990a50fe5c89fe0ea78784d70b ]

This patch makes the dot parser used by dot2c and dot2k slightly more
robust, namely:
* allows parsing files with the gv extension (GraphViz)
* correctly parses edges with any indentation
    * used to work only with a single character (e.g. '\t')
Additionally it fixes a couple of warnings reported by pylint such as
wrong indentation and comparison to False instead of `not ...`

Link: https://lore.kernel.org/20241017064238.41394-2-gmonaco@redhat.com
Signed-off-by: Gabriele Monaco <gmonaco@redhat.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 tools/verification/dot2/automata.py | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/tools/verification/dot2/automata.py b/tools/verification/dot2/automata.py
index baffeb960ff0b..bdeb98baa8b06 100644
--- a/tools/verification/dot2/automata.py
+++ b/tools/verification/dot2/automata.py
@@ -29,11 +29,11 @@ class Automata:
 
     def __get_model_name(self):
         basename = ntpath.basename(self.__dot_path)
-        if basename.endswith(".dot") == False:
+        if not basename.endswith(".dot") and not basename.endswith(".gv"):
             print("not a dot file")
             raise Exception("not a dot file: %s" % self.__dot_path)
 
-        model_name = basename[0:-4]
+        model_name = ntpath.splitext(basename)[0]
         if model_name.__len__() == 0:
             raise Exception("not a dot file: %s" % self.__dot_path)
 
@@ -68,9 +68,9 @@ class Automata:
     def __get_cursor_begin_events(self):
         cursor = 0
         while self.__dot_lines[cursor].split()[0] != "{node":
-           cursor += 1
+            cursor += 1
         while self.__dot_lines[cursor].split()[0] == "{node":
-           cursor += 1
+            cursor += 1
         # skip initial state transition
         cursor += 1
         return cursor
@@ -94,11 +94,11 @@ class Automata:
                 initial_state = state[7:]
             else:
                 states.append(state)
-                if self.__dot_lines[cursor].__contains__("doublecircle") == True:
+                if "doublecircle" in self.__dot_lines[cursor]:
                     final_states.append(state)
                     has_final_states = True
 
-                if self.__dot_lines[cursor].__contains__("ellipse") == True:
+                if "ellipse" in self.__dot_lines[cursor]:
                     final_states.append(state)
                     has_final_states = True
 
@@ -110,7 +110,7 @@ class Automata:
         # Insert the initial state at the bein og the states
         states.insert(0, initial_state)
 
-        if has_final_states == False:
+        if not has_final_states:
             final_states.append(initial_state)
 
         return states, initial_state, final_states
@@ -120,7 +120,7 @@ class Automata:
         cursor = self.__get_cursor_begin_events()
 
         events = []
-        while self.__dot_lines[cursor][1] == '"':
+        while self.__dot_lines[cursor].lstrip()[0] == '"':
             # transitions have the format:
             # "all_fired" -> "both_fired" [ label = "disable_irq" ];
             #  ------------ event is here ------------^^^^^
@@ -161,7 +161,7 @@ class Automata:
         # and we are back! Let's fill the matrix
         cursor = self.__get_cursor_begin_events()
 
-        while self.__dot_lines[cursor][1] == '"':
+        while self.__dot_lines[cursor].lstrip()[0] == '"':
             if self.__dot_lines[cursor].split()[1] == "->":
                 line = self.__dot_lines[cursor].split()
                 origin_state = line[0].replace('"','').replace(',','_')
-- 
2.43.0


