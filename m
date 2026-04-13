Return-Path: <stable+bounces-235922-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gKZdOn6R3Gl9TAkAu9opvQ
	(envelope-from <stable+bounces-235922-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 90C633E7E4A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 08:47:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D19EF3004626
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:47:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A8E366057;
	Mon, 13 Apr 2026 06:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="Ca8qZa/c"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C1CE35C181
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.125.188.122
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776062842; cv=none; b=PRgpbtp2kK7p0v7XnUpVt1vFW+Wpgo1S5Gr7wWktW7ISCjxuxJC8qtgkBKrsU372M59Py0uaECVJwM+/LO9xovttH0iaMYjZ3H464ocC9sigDihEOsxAcS9dfePdM3iQw72QnyZ3nGhOQfvRuXWINBqDR12JpcI8Uqu/kCCUFU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776062842; c=relaxed/simple;
	bh=Pcav1mFxDFzpwc0XJWWIBk5egKEjAIjcNNlVSbFC4AA=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jXQRB8nvfml6IntDxW00rjHBhQOtk9W20edWTWgd6+pHyykj1WwjPhq8JxASKAnzvnKipVDddzUGP6s2JD5fUN4Mt2qZStJV52jq0Pf4q6FDkV/9MkKT3wVl7IKhjA62Ouns2pfMZr7nt5n2/QBwbSYgH/do0wxQdEUs4eaiav0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=Ca8qZa/c; arc=none smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com [209.85.214.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id CF87B3F20E
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 06:47:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1776062839;
	bh=syyz47cWSbBXCmYhP3gzJ7UIBEmw7cokxBzOFe/xgaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version;
	b=Ca8qZa/ccJXShapvgSzXYFJwFow4WTk2NJIaYnG/U+4pQP1bjrnJzy7EDEY2FGqCe
	 Pxo8xIEjKAnokxMmHIVEqNzGtF6zYu6DWPYobgnI7l72lQwvUkNPtXI6xwYZtTBKMU
	 +UeWSiZmGXXa38uqxU3U0J+Xxk8Dnctx1x/0qDGTqPF19GTgINUGf8xp18//fq0f//
	 GflfzLQMozaREqCmX7LgHJfv7WTsNiSgrWydcHlUeGgszLOCTRK3pjdv9J1jihXNO9
	 ql0XdLyW//Dyu0oKuiGszY/AxUL/jR/yWvVE+R9BouUmkKus71mEVERa+EThdIcPx7
	 nRgGLJ9wtt+uor7uZEstY9evLGEle0zWqkHGmSj/hh1b0pLXGG0inlB9jtho6r4EoD
	 hKNJ0AujEJZFcAlocZUT6A07GXLIANM5LbTKRjGLmMSTIoiyuezGVoIsdt9QXHUu9R
	 kA9x4utyYxwKQUvdxTk49ghU9R5QveXpVNJSyQBHZLWzwkczRTI6vQSnDowrciaARF
	 sgjS06muSQoFbuz4MnBrfRGEKD0h3SdSYoBwRzWvp8xq4jkcsTeAE5QV2we7hM9uhB
	 jQ6Dfk8oXBw40pgVHjFESCDYAfr99kiGFib1xj6lvAQlDqW6Kt7oi3FLYen4lNFMHT
	 LebXEvpmmgFTe9VfGiD4aT6M=
Received: by mail-pl1-f199.google.com with SMTP id d9443c01a7336-2b2ec17dc21so11013475ad.2
        for <stable@vger.kernel.org>; Sun, 12 Apr 2026 23:47:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776062838; x=1776667638;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=syyz47cWSbBXCmYhP3gzJ7UIBEmw7cokxBzOFe/xgaM=;
        b=AKsrh1rPxqsj/90GbtT77L1KUPmh2wrql1oxkoqR+O6OtdMpW9mvIU75hIbtcyER5t
         ow8EIDlbb02+LLwhCtC68Zj63U5Z4iYCwcAk5ThO6JBKmqqW6IVrCAVNY0p/jEmCCRQy
         pB1LjXpEquCmu6ulADhKMECWQS25AhsqlUqI0jiCJtSPIr/JdbRI0vd03TG1wUYTE5NR
         4lGCsBFEbVY8jrBZB52VcvGor/uKNvFpSg9jBis9lmIwJ4Baam5joEzWArjmYayi1vg8
         68xg0R/u78mz8jzGaOXik516LZlD7hSHs6hdB0pxy+3GLrYuya5PObUPoMYktunL1/Di
         VPHg==
X-Gm-Message-State: AOJu0Yx5o87X0Ehru/gpXr5xc73KSON5GglAcpzbHXTInKJieYefg6NF
	yv3B7VFuvxHm4nWIjpCuLre9CEWsDILAjhWGpn1Te3hSCzrF9smqXAN/i2bZ5wbGfpofwMNtC9+
	QTXvlFRar3kHZCdIrYHAGLgX0JDawaJdgK4kVhqcCxVt9NJ4AfKeY6TuqUzA3PPxfxBl0W7hjms
	BbHGpPzQ==
X-Gm-Gg: AeBDietdP3aDdxQI/eeJLmVftgWVOdjLIIKZ+VJQvyGbLO92+220LfAqD17ebVLF7K+
	94DycvY6gYzu+4uxIEctMBBuiIhU9n05vb7Wd97mXWkE6JI2YHly5YqPsqA82+yp3ltCr9YeJRd
	hfbOP82/T7Xw81MY/wL/1JnRrwUYucmKMrNBUitOUC0Nk5uTIQWu67TDgy30Btw6SX+TkFxeBmK
	tsI7wLTiczACG7zq9rd7a74PD+ddjPABPIuYxBuw60jmx+Jxq+iPX2gd8cbXE+uNRU7ElcXnyfI
	s90ynC4xt/lJz4sl0FXDsTNNdv3+PpStlYZcSoA8ulYk/XYr4SdgdehXjBFJ0pQT800jTuQawda
	tkAHWRGrnOYLo1vyyWGEJClZcZtk=
X-Received: by 2002:a17:903:4505:b0:2b4:5f19:1d46 with SMTP id d9443c01a7336-2b45f192a23mr16340765ad.19.1776062838276;
        Sun, 12 Apr 2026 23:47:18 -0700 (PDT)
X-Received: by 2002:a17:903:4505:b0:2b4:5f19:1d46 with SMTP id d9443c01a7336-2b45f192a23mr16340595ad.19.1776062837844;
        Sun, 12 Apr 2026 23:47:17 -0700 (PDT)
Received: from localhost ([50.47.147.90])
        by smtp.googlemail.com with UTF8SMTPSA id d9443c01a7336-2b2d4e04e20sm101983815ad.32.2026.04.12.23.47.17
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 12 Apr 2026 23:47:17 -0700 (PDT)
From: John Johansen <john.johansen@canonical.com>
To: stable@vger.kernel.org
Subject: [PATCH 01/11] apparmor: validate DFA start states are in bounds in unpack_pdb
Date: Sun, 12 Apr 2026 23:46:26 -0700
Message-ID: <20260413064712.1581137-2-john.johansen@canonical.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260413064712.1581137-1-john.johansen@canonical.com>
References: <20260413064712.1581137-1-john.johansen@canonical.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235922-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	RCPT_COUNT_ONE(0.00)[1];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[john.johansen@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_NONE(0.00)[];
	DKIM_TRACE(0.00)[canonical.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[canonical.com:dkim,canonical.com:email,canonical.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 90C633E7E4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>

commit 9063d7e2615f4a7ab321de6b520e23d370e58816 upstream.

Backport for conflicts caused by
  ad596ea74e74 ("apparmor: group dfa policydb unpacking")
  - rearrange and consolidated the unpack.

  b11e51dd7094 ("apparmor: test: make static symbols visible during kunit testing")
  - rename function and make it visible to kunit tests

Start states are read from untrusted data and used as indexes into the
DFA state tables. The aa_dfa_next() function call in unpack_pdb() will
access dfa->tables[YYTD_ID_BASE][start], and if the start state exceeds
the number of states in the DFA, this results in an out-of-bound read.

==================================================================
 BUG: KASAN: slab-out-of-bounds in aa_dfa_next+0x2a1/0x360
 Read of size 4 at addr ffff88811956fb90 by task su/1097
 ...

Reject policies with out-of-bounds start states during unpacking
to prevent the issue.

Fixes: ad5ff3db53c6 ("AppArmor: Add ability to load extended policy")
Reported-by: Qualys Security Advisory <qsa@qualys.com>
Tested-by: Salvatore Bonaccorso <carnil@debian.org>
Reviewed-by: Georgia Garcia <georgia.garcia@canonical.com>
Reviewed-by: Cengiz Can <cengiz.can@canonical.com>
Signed-off-by: Massimiliano Pellizzer <massimiliano.pellizzer@canonical.com>
Signed-off-by: John Johansen <john.johansen@canonical.com>
---
 security/apparmor/policy_unpack.c | 21 +++++++++++++++++++--
 1 file changed, 19 insertions(+), 2 deletions(-)

diff --git a/security/apparmor/policy_unpack.c b/security/apparmor/policy_unpack.c
index 851fd6212831..737f23bc7d61 100644
--- a/security/apparmor/policy_unpack.c
+++ b/security/apparmor/policy_unpack.c
@@ -841,9 +841,18 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 			error = -EPROTO;
 			goto fail;
 		}
-		if (!unpack_u32(e, &profile->policy.start[0], "start"))
+		if (!unpack_u32(e, &profile->policy.start[0], "start")) {
 			/* default start state */
 			profile->policy.start[0] = DFA_START;
+		} else {
+			size_t state_count = profile->policy.dfa->tables[YYTD_ID_BASE]->td_lolen;
+
+			if (profile->policy.start[0] >= state_count) {
+				info = "invalid dfa start state";
+				goto fail;
+			}
+		}
+
 		/* setup class index */
 		for (i = AA_CLASS_FILE; i <= AA_CLASS_LAST; i++) {
 			profile->policy.start[i] =
@@ -864,9 +873,17 @@ static struct aa_profile *unpack_profile(struct aa_ext *e, char **ns_name)
 		info = "failed to unpack profile file rules";
 		goto fail;
 	} else if (profile->file.dfa) {
-		if (!unpack_u32(e, &profile->file.start, "dfa_start"))
+		if (!unpack_u32(e, &profile->file.start, "dfa_start")) {
 			/* default start state */
 			profile->file.start = DFA_START;
+		} else {
+			size_t state_count = profile->file.dfa->tables[YYTD_ID_BASE]->td_lolen;
+
+			if (profile->file.start >= state_count) {
+				info = "invalid dfa start state";
+				goto fail;
+			}
+		}
 	} else if (profile->policy.dfa &&
 		   profile->policy.start[AA_CLASS_FILE]) {
 		profile->file.dfa = aa_get_dfa(profile->policy.dfa);
-- 
2.51.0


