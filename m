Return-Path: <stable+bounces-249802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qOx0D82NDWoIzQUAu9opvQ
	(envelope-from <stable+bounces-249802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:32:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B08358BCD1
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 12:32:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7A08830A08BC
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 10:27:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48DE13D6688;
	Wed, 20 May 2026 10:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q7R528Xt"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f193.google.com (mail-pl1-f193.google.com [209.85.214.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A544936BCCC
	for <stable@vger.kernel.org>; Wed, 20 May 2026 10:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779272871; cv=none; b=slnXVudoAYAh/daGGcV3vFBH0KDhwUX+NxHbRdenZAhab9+mMzD7gBZ6+oL5ARtYOZFCMFHkUI5uuYKFvE5yfL63HqvQ2qb8lf1fD7T9jD3GIIrWKdZO3ycMA4TnFMGUYiGBmqX+DEu0FGraE+Sd/25wYbsOD0iFmC/y/y0U+H4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779272871; c=relaxed/simple;
	bh=v4LRPgssKtacnsgHYPSxXQMqRCVWbDp3MTS0anM1IUg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=CD84k0tEwHZjo9Ey9wOPhZkHttaltUnbukQMD4BM+yByduMi8btxOBJnO0O+xdzT7+1ykBFqhpXl/uDLZ9I6dofxepcjek37iLjEJUxQTpZWDVhsrmmwj7wRgJuz8rTs+PP96XirofpQqvkN1J0JDUm6CQeV1qRIJ2izas9dJdg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q7R528Xt; arc=none smtp.client-ip=209.85.214.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f193.google.com with SMTP id d9443c01a7336-2bd2c147abaso27438935ad.3
        for <stable@vger.kernel.org>; Wed, 20 May 2026 03:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779272856; x=1779877656; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=4Jr69J7LRul37iv7/iruhVOBfe8scp7vK2+y5cCRCh0=;
        b=Q7R528XtvYRNu4A9tbubq+K4K3WXLTLbKHVdG8xejzBc6p6efl42jngrf7LNljbkMN
         glSKM59I3ZTf6h817uMi4ya8hs87vazlw24ci+Iy3xNae2NJEYBiDC5H/O9zKrmkV7Hm
         teuBQ6e5Xk273BIwFirkBUK8FZGUwK/E9Jbj5wYobkoPJllzkuCVpCUZJJVWslye7evk
         nwHMESTP5KFLPtEg93z45taVFVwpWdMHzwJNp7B0fp2eSCjG1VR7d+rAqfKaYfSsusuH
         3qG2Aq38PJ3OuNdh4n5H4EANgAEKI6poZT+eLuI8RkowEbmbgdBnos0e9z2mmyjTPqf0
         oITA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779272856; x=1779877656;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Jr69J7LRul37iv7/iruhVOBfe8scp7vK2+y5cCRCh0=;
        b=abCvraDtnnnm1wn4kCr4HDUPkJCbTYliqBJCnrWyCP8At/yi5Laaru2maZxDq+8e63
         S4EX4EW0bbCOO1bL6nBqV4l+z+B5B0nRsknA8Dqt435BoI6jyJJOBdUdx+mH70bgov2m
         T6crfNzI3gNp38FdvRBxeMHYsOXlObVMJKUNPEN/Rfr4ozscX4QmCNqlFsvMYKSOBtZa
         LXNRn95v+8173TEAjUUOhGUWPz2W2MmkdBRqlsevq+PG/rHYJ74zmwrjKPfZJQE46jMB
         pErPhYtiWwcxVFncjsxfUQcXNvTXthdksgLrmetaC0diUsVMHN5XV2JcIh6ufJi1hqj7
         g9ow==
X-Forwarded-Encrypted: i=1; AFNElJ/DsbfR7XPlSPNyh5jVmky2NxytjxBLvvqnlEvcYcec42sgqYM4f0GahpOvgauYQpR4Fj01rHQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwbrqzOYGkflGUe95iLSZ9wLtXfsj1ruI/JP5lCvefT7etlzJVc
	WNpR81ZkeSQ5TKwzHgXZECE2k3QSPkt5Vqy2GXTMYM33z2rTmt3vW76w
X-Gm-Gg: Acq92OGQ8SbQsiNviwR9s6/i2Lkr40vpyWWAuSdHDRKviC9Tx5CSQxMLsHmGNJ8Hff7
	s+kYxRRbsT3LDiDCK1IMtHQnHt4qUkghXAl/sPg+pb4Bh2MNvTeWOeyP9lOma5zs/cjuGlu0GEE
	sLjQW7/S/725x7HM5mrVc2O1RZedS2lMWUi6X+Ijw66kIEm7aPSKMM+HX9PvexVGROCWIFEg99V
	ZIrjQ9j/EJ0tbRgQCK8QUvfhhzDz06dF6jV8bfCsMM9ysvar/oqv4HRGOenPP8y2HEG3HfvQ26a
	ogxwz2yFkl9VVXnE8OWASh30CUY+LykgIG6PWTw8bI4pUl/ortQf1WIOouRgXkk1kJze9fuDNza
	PyiCrKKmccC0289PawONbIaMjxTV2wPmPMVxW6M1SaHXKJLrmAmS81zeHhBc6v7qvVin58h7mwi
	Cql1ZyAwqkrA+7C5gLxjcvWKaOvbV1bVSI2yujbbvf2Q==
X-Received: by 2002:a17:903:2a87:b0:2ba:4eee:6c1e with SMTP id d9443c01a7336-2bd7e8214d5mr251314915ad.15.1779272855877;
        Wed, 20 May 2026 03:27:35 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5d116287sm216373685ad.68.2026.05.20.03.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2026 03:27:35 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Sitnicki <jakub@cloudflare.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>
Cc: bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v3] bpf, sockmap: keep sk_msg copy state in sync
Date: Wed, 20 May 2026 18:27:15 +0800
Message-Id: <20260520102715.3033936-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249802-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 8B08358BCD1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
with this bit set are copied before data/data_end are exposed to SK_MSG
BPF programs for direct packet access.

bpf_msg_pull_data(), bpf_msg_push_data(), and bpf_msg_pop_data()
rewrite the sk_msg scatterlist ring by collapsing, splitting, and
shifting entries. These operations move msg->sg.data[] entries, but the
parallel copy bitmap can be left behind on the old slot. A copied entry
can then return to msg->sg.start with its copy bit clear and be exposed
as directly writable packet data.

This corruption path requires an attached SK_MSG BPF program that calls
the mutating helpers; ordinary sockmap/TLS traffic that never runs
push/pop/pull helper sequences is not affected.

Keep msg->sg.copy synchronized with scatterlist entry moves, preserve
the copy bit when an entry is split, clear it when a helper replaces an
entry with a private page, and clear slots vacated by pull-data
compaction.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Cc: stable@vger.kernel.org
Co-developed-by: Han Guidong <2045gemini@gmail.com>
Signed-off-by: Han Guidong <2045gemini@gmail.com>
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
v3:
- Refactor copy-bit helpers per John Fastabend's review: encapsulate scatterlist element moves alongside their copy state into a unified helper, and streamline bit-clearing operations.
- Clarify in commit log that only programs using push/pop/pull are affected.
- Note: The additional edge cases reported by the Sashiko-bot bot and the addition of BPF selftests will be addressed in a separate follow-up patch series to expedite this core fix.

v2:
Address Sashiko-bot's feedback by clearing msg->sg.copy for every entry consumed by bpf_msg_pull_data() before compacting the scatterlist ring, preventing stale copy bits on collapsed tail entries.

v1:
While researching recent page cache bugs, we discovered this bug.
We confirmed it allows overwriting the page cache of read-only files
via splice(). We haven't attempted to write an exploit, but the
corruption primitive is verified. PoC available upon request.
Recommend fixing ASAP.
---

 net/core/filter.c | 88 ++++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 83 insertions(+), 5 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 78b548158fb05..1be8fc750a1a1 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2650,6 +2650,38 @@ static void sk_msg_reset_curr(struct sk_msg *msg)
 	}
 }
 
+static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
+{
+	return test_bit(i, msg->sg.copy);
+}
+
+static void sk_msg_clear_elem_copy(struct sk_msg *msg, u32 i)
+{
+	__clear_bit(i, msg->sg.copy);
+}
+
+static void sk_msg_set_elem_copy(struct sk_msg *msg, u32 i)
+{
+	__set_bit(i, msg->sg.copy);
+}
+
+static void sk_msg_clear_copy_range(struct sk_msg *msg, u32 start, u32 end)
+{
+	while (start != end) {
+		sk_msg_clear_elem_copy(msg, start);
+		sk_msg_iter_var_next(start);
+	}
+}
+
+static void sk_msg_sg_move(struct sk_msg *msg, u32 dst, u32 src)
+{
+	msg->sg.data[dst] = msg->sg.data[src];
+	if (sk_msg_elem_is_copy(msg, src))
+		sk_msg_set_elem_copy(msg, dst);
+	else
+		sk_msg_clear_elem_copy(msg, dst);
+}
+
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
 	.func           = bpf_msg_cork_bytes,
 	.gpl_only       = false,
@@ -2688,7 +2720,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	 * account for the headroom.
 	 */
 	bytes_sg_total = start - offset + bytes;
-	if (!test_bit(i, msg->sg.copy) && bytes_sg_total <= len)
+	if (!sk_msg_elem_is_copy(msg, i) && bytes_sg_total <= len)
 		goto out;
 
 	/* At this point we need to linearize multiple scatterlist
@@ -2734,6 +2766,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	} while (i != last_sge);
 
 	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
+	sk_msg_clear_elem_copy(msg, first_sge);
 
 	/* To repair sg ring we need to shift entries. If we only
 	 * had a single entry though we can just replace it and
@@ -2743,8 +2776,14 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	shift = last_sge > first_sge ?
 		last_sge - first_sge - 1 :
 		NR_MSG_FRAG_IDS - first_sge + last_sge - 1;
-	if (!shift)
+	if (!shift) {
+		sk_msg_clear_elem_copy(msg, msg->sg.end);
 		goto out;
+	}
+
+	i = first_sge;
+	sk_msg_iter_var_next(i);
+	sk_msg_clear_copy_range(msg, i, last_sge);
 
 	i = first_sge;
 	sk_msg_iter_var_next(i);
@@ -2758,16 +2797,18 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		if (move_from == msg->sg.end)
 			break;
 
-		msg->sg.data[i] = msg->sg.data[move_from];
+		sk_msg_sg_move(msg, i, move_from);
 		msg->sg.data[move_from].length = 0;
 		msg->sg.data[move_from].page_link = 0;
 		msg->sg.data[move_from].offset = 0;
+		sk_msg_clear_elem_copy(msg, move_from);
 		sk_msg_iter_var_next(i);
 	} while (1);
 
 	msg->sg.end = msg->sg.end - shift > msg->sg.end ?
 		      msg->sg.end - shift + NR_MSG_FRAG_IDS :
 		      msg->sg.end - shift;
+	sk_msg_clear_elem_copy(msg, msg->sg.end);
 out:
 	sk_msg_reset_curr(msg);
 	msg->data = sg_virt(&msg->sg.data[first_sge]) + start - offset;
@@ -2790,6 +2831,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 {
 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
 	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
+	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
+	bool rsge_copy = false;
 	u8 *raw, *to, *from;
 	struct page *page;
 
@@ -2862,6 +2905,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
+		rsge_copy = sk_msg_elem_is_copy(msg, i);
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
@@ -2887,23 +2931,34 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	/* Shift one or two slots as needed */
 	sge = sk_msg_elem_cpy(msg, new);
 	sg_unmark_end(&sge);
+	sge_copy = sk_msg_elem_is_copy(msg, new);
 
 	nsge = sk_msg_elem_cpy(msg, i);
+	nsge_copy = sk_msg_elem_is_copy(msg, i);
 	if (rsge.length) {
 		sk_msg_iter_var_next(i);
 		nnsge = sk_msg_elem_cpy(msg, i);
+		nnsge_copy = sk_msg_elem_is_copy(msg, i);
 		sk_msg_iter_next(msg, end);
 	}
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		if (sge_copy)
+			sk_msg_set_elem_copy(msg, i);
+		else
+			sk_msg_clear_elem_copy(msg, i);
 		sge = nsge;
+		sge_copy = nsge_copy;
 		sk_msg_iter_var_next(i);
 		if (rsge.length) {
 			nsge = nnsge;
+			nsge_copy = nnsge_copy;
 			nnsge = sk_msg_elem_cpy(msg, i);
+			nnsge_copy = sk_msg_elem_is_copy(msg, i);
 		} else {
 			nsge = sk_msg_elem_cpy(msg, i);
+			nsge_copy = sk_msg_elem_is_copy(msg, i);
 		}
 	}
 
@@ -2911,13 +2966,18 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	/* Place newly allocated data buffer */
 	sk_mem_charge(msg->sk, len);
 	msg->sg.size += len;
-	__clear_bit(new, msg->sg.copy);
+	sk_msg_clear_elem_copy(msg, new);
 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
 	if (rsge.length) {
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
 		msg->sg.data[new] = rsge;
+		if (rsge_copy)
+			sk_msg_set_elem_copy(msg, new);
+		else
+			sk_msg_clear_elem_copy(msg, new);
 	}
+	sk_msg_clear_elem_copy(msg, msg->sg.end);
 
 	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
@@ -2943,27 +3003,38 @@ static void sk_msg_shift_left(struct sk_msg *msg, int i)
 	do {
 		prev = i;
 		sk_msg_iter_var_next(i);
-		msg->sg.data[prev] = msg->sg.data[i];
+		sk_msg_sg_move(msg, prev, i);
 	} while (i != msg->sg.end);
 
 	sk_msg_iter_prev(msg, end);
+	sk_msg_clear_elem_copy(msg, msg->sg.end);
 }
 
 static void sk_msg_shift_right(struct sk_msg *msg, int i)
 {
 	struct scatterlist tmp, sge;
+	bool tmp_copy, sge_copy;
 
 	sk_msg_iter_next(msg, end);
 	sge = sk_msg_elem_cpy(msg, i);
+	sge_copy = sk_msg_elem_is_copy(msg, i);
 	sk_msg_iter_var_next(i);
 	tmp = sk_msg_elem_cpy(msg, i);
+	tmp_copy = sk_msg_elem_is_copy(msg, i);
 
 	while (i != msg->sg.end) {
 		msg->sg.data[i] = sge;
+		if (sge_copy)
+			sk_msg_set_elem_copy(msg, i);
+		else
+			sk_msg_clear_elem_copy(msg, i);
 		sk_msg_iter_var_next(i);
 		sge = tmp;
+		sge_copy = tmp_copy;
 		tmp = sk_msg_elem_cpy(msg, i);
+		tmp_copy = sk_msg_elem_is_copy(msg, i);
 	}
+	sk_msg_clear_elem_copy(msg, msg->sg.end);
 }
 
 BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
@@ -3020,8 +3091,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	 */
 	if (start != offset) {
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
+		u32 sge_idx = i;
 		int a = start - offset;
 		int b = sge->length - pop - a;
+		bool sge_copy = sk_msg_elem_is_copy(msg, sge_idx);
 
 		sk_msg_iter_var_next(i);
 
@@ -3034,6 +3107,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				if (sge_copy)
+					sk_msg_set_elem_copy(msg, i);
+				else
+					sk_msg_clear_elem_copy(msg, i);
 			} else {
 				struct page *page, *orig;
 				u8 *to, *from;
@@ -3050,6 +3127,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				memcpy(to, from, a);
 				memcpy(to + a, from + a + pop, b);
 				sg_set_page(sge, page, a + b, 0);
+				sk_msg_clear_elem_copy(msg, sge_idx);
 				put_page(orig);
 			}
 			pop = 0;
-- 
2.43.0

