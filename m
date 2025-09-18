Return-Path: <stable+bounces-168005-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 58A86B232F2
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 20:23:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4581B188B027
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 18:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17CEE3F9D2;
	Tue, 12 Aug 2025 18:18:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Nrv8A7VU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C98BC2E7BD4;
	Tue, 12 Aug 2025 18:18:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755022722; cv=none; b=Oo8N7mIUG+eLNUcB2VX2RKw3I5ppLoiUKtumV2rvcD71nNuB8vDS282E6m93r32eteDyOLIXK4LSHVCBNCa2kw4Kq0s/Nzirbe7QfKOd7nS1e+B/1rqf1fKJW2gRTyS90EuROdLhowv6sJii2Nf6Y0nZs2NZWn+32Rld8xLmFpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755022722; c=relaxed/simple;
	bh=GRTAQF3nq/WMnV4q3Bgzy7D6C0wjd2KlMsbLruDjMNM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ksv5A3a/XL+5vkXXoLbIW0Ga5MtLr/YcJjeimQJ2G9bhrU3PlXf0AVtxt1xJFbDoMgo5J0q2NHrLXp8h4HvAwtAR2zLwEWdITYMNQfbYS9ihzKs293XT048E+MdTwXdj9GrCBy8cqEHHstQi4wk8AI+Hes1TMNU4lGuS3atvK9E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Nrv8A7VU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35AE6C4CEF1;
	Tue, 12 Aug 2025 18:18:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755022722;
	bh=GRTAQF3nq/WMnV4q3Bgzy7D6C0wjd2KlMsbLruDjMNM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Nrv8A7VUTHKHRF156oiK4z1dIsMZ/Mbbogh1v0q8SAI/m9yUf0wHdMh1MhPcFSj/K
	 qf1747KxAUGemBbOH8zHjHbpb+VUsZCF/UYDor+pHmosRNlfdTSLTVXjXY4nA8NaTP
	 oIXW9LBxjBmAiz/hZIr1RIL6CUDGVFMXZZFCijPQ=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Ryan Lee <ryan.lee@canonical.com>,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12 239/369] apparmor: fix loop detection used in conflicting attachment resolution
Date: Tue, 12 Aug 2025 19:28:56 +0200
Message-ID: <20250812173023.767791112@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812173014.736537091@linuxfoundation.org>
References: <20250812173014.736537091@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Ryan Lee <ryan.lee@canonical.com>

[ Upstream commit a88db916b8c77552f49f7d9f8744095ea01a268f ]

Conflicting attachment resolution is based on the number of states
traversed to reach an accepting state in the attachment DFA, accounting
for DFA loops traversed during the matching process. However, the loop
counting logic had multiple bugs:

 - The inc_wb_pos macro increments both position and length, but length
   is supposed to saturate upon hitting buffer capacity, instead of
   wrapping around.
 - If no revisited state is found when traversing the history, is_loop
   would still return true, as if there was a loop found the length of
   the history buffer, instead of returning false and signalling that
   no loop was found. As a result, the adjustment step of
   aa_dfa_leftmatch would sometimes produce negative counts with loop-
   free DFAs that traversed enough states.
 - The iteration in the is_loop for loop is supposed to stop before
   i = wb->len, so the conditional should be < instead of <=.

This patch fixes the above bugs as well as the following nits:
 - The count and size fields in struct match_workbuf were not used,
   so they can be removed.
 - The history buffer in match_workbuf semantically stores aa_state_t
   and not unsigned ints, even if aa_state_t is currently unsigned int.
 - The local variables in is_loop are counters, and thus should be
   unsigned ints instead of aa_state_t's.

Fixes: 21f606610502 ("apparmor: improve overlapping domain attachment resolution")

Signed-off-by: Ryan Lee <ryan.lee@canonical.com>
Co-developed-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/include/match.h |  5 +----
 security/apparmor/match.c         | 22 +++++++++++-----------
 2 files changed, 12 insertions(+), 15 deletions(-)

diff --git a/security/apparmor/include/match.h b/security/apparmor/include/match.h
index 0539abda328d..ae31a8a631fc 100644
--- a/security/apparmor/include/match.h
+++ b/security/apparmor/include/match.h
@@ -138,15 +138,12 @@ void aa_dfa_free_kref(struct kref *kref);
 /* This needs to be a power of 2 */
 #define WB_HISTORY_SIZE 32
 struct match_workbuf {
-	unsigned int count;
 	unsigned int pos;
 	unsigned int len;
-	unsigned int size;	/* power of 2, same as history size */
-	unsigned int history[WB_HISTORY_SIZE];
+	aa_state_t history[WB_HISTORY_SIZE];
 };
 #define DEFINE_MATCH_WB(N)		\
 struct match_workbuf N = {		\
-	.count = 0,			\
 	.pos = 0,			\
 	.len = 0,			\
 }
diff --git a/security/apparmor/match.c b/security/apparmor/match.c
index 0f791a58d933..12e036f8ce0f 100644
--- a/security/apparmor/match.c
+++ b/security/apparmor/match.c
@@ -624,35 +624,35 @@ aa_state_t aa_dfa_matchn_until(struct aa_dfa *dfa, aa_state_t start,
 	return state;
 }
 
-#define inc_wb_pos(wb)						\
-do {								\
+#define inc_wb_pos(wb)							\
+do {									\
 	BUILD_BUG_ON_NOT_POWER_OF_2(WB_HISTORY_SIZE);			\
 	wb->pos = (wb->pos + 1) & (WB_HISTORY_SIZE - 1);		\
-	wb->len = (wb->len + 1) & (WB_HISTORY_SIZE - 1);		\
+	wb->len = (wb->len + 1) > WB_HISTORY_SIZE ? WB_HISTORY_SIZE :	\
+				wb->len + 1;				\
 } while (0)
 
 /* For DFAs that don't support extended tagging of states */
+/* adjust is only set if is_loop returns true */
 static bool is_loop(struct match_workbuf *wb, aa_state_t state,
 		    unsigned int *adjust)
 {
-	aa_state_t pos = wb->pos;
-	aa_state_t i;
+	int pos = wb->pos;
+	int i;
 
 	if (wb->history[pos] < state)
 		return false;
 
-	for (i = 0; i <= wb->len; i++) {
+	for (i = 0; i < wb->len; i++) {
 		if (wb->history[pos] == state) {
 			*adjust = i;
 			return true;
 		}
-		if (pos == 0)
-			pos = WB_HISTORY_SIZE;
-		pos--;
+		/* -1 wraps to WB_HISTORY_SIZE - 1 */
+		pos = (pos - 1) & (WB_HISTORY_SIZE - 1);
 	}
 
-	*adjust = i;
-	return true;
+	return false;
 }
 
 static aa_state_t leftmatch_fb(struct aa_dfa *dfa, aa_state_t start,
-- 
2.39.5




