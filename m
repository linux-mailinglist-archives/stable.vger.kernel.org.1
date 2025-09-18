Return-Path: <stable+bounces-167434-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 515C5B2300F
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 19:47:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D270356527E
	for <lists+stable@lfdr.de>; Tue, 12 Aug 2025 17:46:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1D2E972E;
	Tue, 12 Aug 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="T3FgUi5u"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DA1C221FAC;
	Tue, 12 Aug 2025 17:46:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755020804; cv=none; b=kFDskXkzYgwy+pwkOe25u74LZ7tefMUrWA8t/tb1In/00QEhCYURVcC/Q3pa2x/GtPbuEBMTrJDGRD7zQOCcBoQoVq7qODIqkakmzvK4r+mgwd2rZ1em2G6wavexIRtCxDfBkvGj2uafnwO+JXP/x7WDpRYuXE0575EP8rQc47Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755020804; c=relaxed/simple;
	bh=mmBNK7eC/IYo03cN9/ASdDv1Qc3yUurW8P/QJi3SsMg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buL+Hn7J/Ls6cyHiu7J2Iizw/Ykc9wo9ywZeKGJFWyxX2AiYaHq2Z+uimpuq/bosfTmxtT0G/W7VV8hYXP+6kHUg9fEM0rTiZ4WUpsZT/s8dfz3MORgJiqoS+uLGjZp/bE/kF2TYr84epUX9CjM6Nt23H7JoR6W/5HheBSpsHB0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=T3FgUi5u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F3B1C4CEF0;
	Tue, 12 Aug 2025 17:46:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755020804;
	bh=mmBNK7eC/IYo03cN9/ASdDv1Qc3yUurW8P/QJi3SsMg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=T3FgUi5uHmAnRgWCsbbVfUQfZUTr5Q9q2i4fxAIWHomXZOS3u5vO0GU9sjWEGjFA+
	 hdV9MsCgqXVlT1rjTkAW6Wmf32rYA7Gis9/xknvOJshCkIOQfCvSBoet+4ERKJG5TJ
	 Mycn0w2PB+Lvu+bT+2t1hiM2zGdr1/OuHK/mSAJ4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Dan Carpenter <dan.carpenter@linaro.org>,
	Mike Marshall <hubcap@omnibond.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 171/253] fs/orangefs: Allow 2 more characters in do_c_string()
Date: Tue, 12 Aug 2025 19:29:19 +0200
Message-ID: <20250812172956.005701132@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250812172948.675299901@linuxfoundation.org>
References: <20250812172948.675299901@linuxfoundation.org>
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

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Dan Carpenter <dan.carpenter@linaro.org>

[ Upstream commit 2138e89cb066b40386b1d9ddd61253347d356474 ]

The do_k_string() and do_c_string() functions do essentially the same
thing which is they add a string and a comma onto the end of an existing
string.  At the end, the caller will overwrite the last comma with a
newline.  Later, in orangefs_kernel_debug_init(), we add a newline to
the string.

The change to do_k_string() is just cosmetic.  I moved the "- 1" to
the other side of the comparison and made it "+ 1".  This has no
effect on runtime, I just wanted the functions to match each other
and the rest of the file.

However in do_c_string(), I removed the "- 2" which allows us to print
two extra characters.  I noticed this issue while reviewing the code
and I doubt affects anything in real life.  My guess is that this was
double counting the comma and the newline.  The "+ 1" accounts for
the newline, and the caller will delete the final comma which ensures
there is enough space for the newline.

Removing the "- 2" lets us print 2 more characters, but mainly it makes
the code more consistent and understandable for reviewers.

Fixes: 44f4641073f1 ("orangefs: clean up debugfs globals")
Signed-off-by: Dan Carpenter <dan.carpenter@linaro.org>
Signed-off-by: Mike Marshall <hubcap@omnibond.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/orangefs/orangefs-debugfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/orangefs/orangefs-debugfs.c b/fs/orangefs/orangefs-debugfs.c
index fa41db088488..b57140ebfad0 100644
--- a/fs/orangefs/orangefs-debugfs.c
+++ b/fs/orangefs/orangefs-debugfs.c
@@ -728,8 +728,8 @@ static void do_k_string(void *k_mask, int index)
 
 	if (*mask & s_kmod_keyword_mask_map[index].mask_val) {
 		if ((strlen(kernel_debug_string) +
-		     strlen(s_kmod_keyword_mask_map[index].keyword))
-			< ORANGEFS_MAX_DEBUG_STRING_LEN - 1) {
+		     strlen(s_kmod_keyword_mask_map[index].keyword) + 1)
+			< ORANGEFS_MAX_DEBUG_STRING_LEN) {
 				strcat(kernel_debug_string,
 				       s_kmod_keyword_mask_map[index].keyword);
 				strcat(kernel_debug_string, ",");
@@ -756,7 +756,7 @@ static void do_c_string(void *c_mask, int index)
 	    (mask->mask2 & cdm_array[index].mask2)) {
 		if ((strlen(client_debug_string) +
 		     strlen(cdm_array[index].keyword) + 1)
-			< ORANGEFS_MAX_DEBUG_STRING_LEN - 2) {
+			< ORANGEFS_MAX_DEBUG_STRING_LEN) {
 				strcat(client_debug_string,
 				       cdm_array[index].keyword);
 				strcat(client_debug_string, ",");
-- 
2.39.5




