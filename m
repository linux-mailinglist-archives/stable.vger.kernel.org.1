Return-Path: <stable+bounces-171465-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65739B2AA19
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 16:28:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05B0C688492
	for <lists+stable@lfdr.de>; Mon, 18 Aug 2025 14:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE3C3321F53;
	Mon, 18 Aug 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="kWDktlmR"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B2FB321455;
	Mon, 18 Aug 2025 14:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755526014; cv=none; b=KP1HFKAiLfIwNW+jSGTc3OwX9sn0POm0H222d4gXs4rui9hu0TBn8QYIrJ/DHpBXTFKaEwrkI03hcL1/esk1o0mhJsdcsqNWAVFALADNF7ScKtuMVhUs2ZpFkiBx0NtuytHUvMIfJyULTcMdlU6HXnzPWM3jOwFNnsQWx2CyU+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755526014; c=relaxed/simple;
	bh=6EvpMMXv8cT36/K3SLAWjxHIonK77fzKjCXyif04w7c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yc8HmQo9UDDxjkDCkCToN/p7CA/oFp/tr8uNdWnfJvYqH08nUNqFgswNbdp/9JoxMZbdZdVK274thbbU9w1b3wxq8S5XRchqC62MgDk9ItFr6Smn6JMu3yURzhTTZfrurpe/WM8GAoPF/449UVYkUyeGtzuuM7jCJWS3MKZTiXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=kWDktlmR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0D8EC4CEEB;
	Mon, 18 Aug 2025 14:06:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1755526014;
	bh=6EvpMMXv8cT36/K3SLAWjxHIonK77fzKjCXyif04w7c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=kWDktlmRl4P6q4x1kB1OBYQhj5a+5H5JlD9jRQXmFgERVzbQz4ql1BwVomV3vmfHO
	 CaMxC2PLtEVc59WHDlKbwX0OIcqvvfcR6BhlV8G6PUeXJFbW5U0+bu1DL5lAButGAI
	 T0xF3oR1b0pvkPASmeNT6oCeqZoQMRwnCBpPziy0=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	John Johansen <john.johansen@canonical.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.16 433/570] apparmor: fix x_table_lookup when stacking is not the first entry
Date: Mon, 18 Aug 2025 14:47:00 +0200
Message-ID: <20250818124522.510741078@linuxfoundation.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20250818124505.781598737@linuxfoundation.org>
References: <20250818124505.781598737@linuxfoundation.org>
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

6.16-stable review patch.  If anyone has any objections, please let me know.

------------------

From: John Johansen <john.johansen@canonical.com>

[ Upstream commit a9eb185be84e998aa9a99c7760534ccc06216705 ]

x_table_lookup currently does stacking during label_parse() if the
target specifies a stack but its only caller ensures that it will
never be used with stacking.

Refactor to slightly simplify the code in x_to_label(), this
also fixes a long standing problem where x_to_labels check on stacking
is only on the first element to the table option list, instead of
the element that is found and used.

Signed-off-by: John Johansen <john.johansen@canonical.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 security/apparmor/domain.c | 52 +++++++++++++++++++++-----------------
 1 file changed, 29 insertions(+), 23 deletions(-)

diff --git a/security/apparmor/domain.c b/security/apparmor/domain.c
index 5939bd9a9b9b..08ca9057f82b 100644
--- a/security/apparmor/domain.c
+++ b/security/apparmor/domain.c
@@ -508,6 +508,7 @@ static const char *next_name(int xtype, const char *name)
  * @name: returns: name tested to find label (NOT NULL)
  *
  * Returns: refcounted label, or NULL on failure (MAYBE NULL)
+ *          @name will always be set with the last name tried
  */
 struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex,
 				const char **name)
@@ -517,6 +518,7 @@ struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex,
 	struct aa_label *label = NULL;
 	u32 xtype = xindex & AA_X_TYPE_MASK;
 	int index = xindex & AA_X_INDEX_MASK;
+	const char *next;
 
 	AA_BUG(!name);
 
@@ -524,25 +526,27 @@ struct aa_label *x_table_lookup(struct aa_profile *profile, u32 xindex,
 	/* TODO: move lookup parsing to unpack time so this is a straight
 	 *       index into the resultant label
 	 */
-	for (*name = rules->file->trans.table[index]; !label && *name;
-	     *name = next_name(xtype, *name)) {
+	for (next = rules->file->trans.table[index]; next;
+	     next = next_name(xtype, next)) {
+		const char *lookup = (*next == '&') ? next + 1 : next;
+		*name = next;
 		if (xindex & AA_X_CHILD) {
-			struct aa_profile *new_profile;
-			/* release by caller */
-			new_profile = aa_find_child(profile, *name);
-			if (new_profile)
-				label = &new_profile->label;
+			/* TODO: switich to parse to get stack of child */
+			struct aa_profile *new = aa_find_child(profile, lookup);
+
+			if (new)
+				/* release by caller */
+				return &new->label;
 			continue;
 		}
-		label = aa_label_parse(&profile->label, *name, GFP_KERNEL,
+		label = aa_label_parse(&profile->label, lookup, GFP_KERNEL,
 				       true, false);
-		if (IS_ERR(label))
-			label = NULL;
+		if (!IS_ERR_OR_NULL(label))
+			/* release by caller */
+			return label;
 	}
 
-	/* released by caller */
-
-	return label;
+	return NULL;
 }
 
 /**
@@ -567,9 +571,9 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
 	struct aa_ruleset *rules = list_first_entry(&profile->rules,
 						    typeof(*rules), list);
 	struct aa_label *new = NULL;
+	struct aa_label *stack = NULL;
 	struct aa_ns *ns = profile->ns;
 	u32 xtype = xindex & AA_X_TYPE_MASK;
-	const char *stack = NULL;
 
 	switch (xtype) {
 	case AA_X_NONE:
@@ -578,13 +582,14 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
 		break;
 	case AA_X_TABLE:
 		/* TODO: fix when perm mapping done at unload */
-		stack = rules->file->trans.table[xindex & AA_X_INDEX_MASK];
-		if (*stack != '&') {
-			/* released by caller */
-			new = x_table_lookup(profile, xindex, lookupname);
-			stack = NULL;
+		/* released by caller
+		 * if null for both stack and direct want to try fallback
+		 */
+		new = x_table_lookup(profile, xindex, lookupname);
+		if (!new || **lookupname != '&')
 			break;
-		}
+		stack = new;
+		new = NULL;
 		fallthrough;	/* to X_NAME */
 	case AA_X_NAME:
 		if (xindex & AA_X_CHILD)
@@ -599,6 +604,7 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
 		break;
 	}
 
+	/* fallback transition check */
 	if (!new) {
 		if (xindex & AA_X_INHERIT) {
 			/* (p|c|n)ix - don't change profile but do
@@ -617,12 +623,12 @@ static struct aa_label *x_to_label(struct aa_profile *profile,
 		/* base the stack on post domain transition */
 		struct aa_label *base = new;
 
-		new = aa_label_parse(base, stack, GFP_KERNEL, true, false);
-		if (IS_ERR(new))
-			new = NULL;
+		new = aa_label_merge(base, stack, GFP_KERNEL);
+		/* null on error */
 		aa_put_label(base);
 	}
 
+	aa_put_label(stack);
 	/* released by caller */
 	return new;
 }
-- 
2.39.5




