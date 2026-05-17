Return-Path: <stable+bounces-249077-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QFuEEruxCWo4lgQAu9opvQ
	(envelope-from <stable+bounces-249077-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 14:16:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4FC23560E8D
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 14:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 716E030028C8
	for <lists+stable@lfdr.de>; Sun, 17 May 2026 12:16:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D21B35E1A6;
	Sun, 17 May 2026 12:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kNDIW61B"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f194.google.com (mail-pl1-f194.google.com [209.85.214.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A432D257844
	for <stable@vger.kernel.org>; Sun, 17 May 2026 12:16:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.194
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779020211; cv=none; b=kni2WfGobogerxu+50s9a/j/d5C8bvd76Hi+ef/CpgISoEov4PM45H/xVDgZI1MxHk8K1+DMa2dZpq5NZ3Eytfmq0zYsIALFEHbQLEAt74FpkGommYT5Pbc8pEfqhYYOHmzBRpjNK/FEuM4QLxrwzep6+JL0Myptoxfb1Qi+pyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779020211; c=relaxed/simple;
	bh=ZkRvU0jLzvplU5bZY41Zz/7ytph4SzqDCErIdtmXOM4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Zl9AgysNd8jiTURZfiMBz9PVtl/AapI2zdmiNRXcxfscqTrsTc/Gr6HB3uKNT5nls/lnFRbLmuKqq41/ee65nD6OhFjpq3hXNteUgCx/zHODuT1EZ5AjnV8i9PqFx/Hh8bXE2w0RQ5Tth5HshA5Jftg3sA4aMoNEwSrokobl1AA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kNDIW61B; arc=none smtp.client-ip=209.85.214.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f194.google.com with SMTP id d9443c01a7336-2bcd3ac3307so7451135ad.0
        for <stable@vger.kernel.org>; Sun, 17 May 2026 05:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779020209; x=1779625009; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yjlRY4tntfwtwjxbRp3yBR4txk5DfmJk/3uX12iiOEM=;
        b=kNDIW61BGQKGPKSmPsNxKtGZA+f72Td+DgmTSJw3IcinSNaE3vuN8KpmT+kpGVkkX8
         iCM7olURrfZh27g2PgGFn2WBX7pg+A7swZ0U7Vle+orHmpX4HTLRcNvTkYJE/JN1U2fg
         uFZkbQFi8h3bQYAJaSu43G4i7q25N1F4Hu5RsOkpx1vbsksEJP3UDMTOw6SUCBYUfMou
         MRl9MjNFEpZnJ+JL7ZQfO91fr840CErcLfvmt/+XWU52SkVm1eQOoMfZ+1gNbcxQLyJQ
         xPVMKtnEtTc+7kF8DoW/z0VMMP64bRhJcGwS+TofnYGbdlYn6QMItyEb8wbVUls9RKIn
         txXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779020209; x=1779625009;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yjlRY4tntfwtwjxbRp3yBR4txk5DfmJk/3uX12iiOEM=;
        b=Y+8DAWoLO+oqm5tYU4Ikd71Dng7IPO91B18mpWr1VdCFjnnAbYpOoSyue+CPRxWh3U
         Pij4QCmMFkveV5uwnxZDI+ejRaXXDXqWzVllK6WoLtXlyqDngzwaaG4/mQudU48ImPRG
         f2l9kAzk3RZ5s/BkqMac7FajeMZyThlAU1thwmLn+DbTYlFCLTMdmjaXKQXOn/9L09jB
         EfG09fR68CTptBoodavJJHemaBIP+RdQwFs9nJKelEnNjbLwkBvY3ciAoufBaKY5kEMf
         Zp9RCyJHCl8u3hF31rkNQG3NkXQKj6Mibj+CKvItDPUZGN9INIU4/fAF7efVYdg7ak7L
         Vhfw==
X-Forwarded-Encrypted: i=1; AFNElJ+auPqWTTpqMiXJRVonaEGJ2G6RftWmv75is8nAWaQ+XAciTzWyu5BDNHJnKW+LPO39u0wbBK0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyCw2zt0mMiE40qnlUc5OWtXv9Nv4zpZ5Dn+/9KUIfWyAyd5s/o
	oLLnK63zOWhli1+hRjLc7f7Z43FT4w47SG1HxvJo5BTowXBLuSt45JJJ
X-Gm-Gg: Acq92OGXTRDyUcST3NAzgv9mGgQKhynI1tFAs1BkrznGqZ815kU37oOTc62AuMZAZuE
	T95Hb7tVckR3pQ9NOMoCLK4aMWBakLXEA8EMsxvQGFQ0oC0SbLoKIM7bMtoj34tnYOXgJSY/1Sf
	dEF1EEaP4BCu+0O1EKY48xJMxmGoNnI8sezyc6BsuT5+4xssr4+a4GtyuFKsrp32lZn/L009dwP
	aAWBeb3JV5AQfVQSolkf1MyfOzpcisNa8K9ExCRJdqQ81cuWhSnXFvshGsDX9rNVUJFb1bdzIv1
	ol2jG7oTFkqaTYAMEvzROf49DyjlBAtMMI8E3yQAdkkQ7YA96vVNG1t6mzq2C9H8adDTxwQtzZF
	5PNJKpaIk3yko9a0IOy69nhyyAgr2VajIxKnf5pzugxNIcaNK79TmnLH2UcDay+mgEoqP5023oM
	W+dSGzyqA2xX2/A1urDJIOJ/v1Oi84G1A=
X-Received: by 2002:a17:902:b60a:b0:2bc:b366:4731 with SMTP id d9443c01a7336-2bd7e9b8086mr82854435ad.31.1779020208698;
        Sun, 17 May 2026 05:16:48 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2bd5c05ffbesm121124815ad.27.2026.05.17.05.16.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 May 2026 05:16:48 -0700 (PDT)
From: Zhang Cen <rollkingzzc@gmail.com>
To: Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	Jakub Sitnicki <jakub@cloudflare.com>
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	bpf@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	zerocling0077@gmail.com,
	2045gemini@gmail.com,
	Zhang Cen <rollkingzzc@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
Date: Sun, 17 May 2026 20:16:26 +0800
Message-Id: <20260517121626.406516-1-rollkingzzc@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 4FC23560E8D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249077-lists,stable=lfdr.de];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[kernel.org,iogearbox.net,linux.dev,gmail.com,fomichev.me,cloudflare.com];
	RCPT_COUNT_TWELVE(0.00)[19];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[davemloft.net,google.com,kernel.org,redhat.com,vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[gmail.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rollkingzzc@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Action: no action

SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
with this bit set are copied before data/data_end are exposed to SK_MSG
BPF programs for direct packet access.

bpf_msg_pull_data(), bpf_msg_push_data() and bpf_msg_pop_data() rewrite
the sk_msg scatterlist ring by collapsing, splitting and shifting
entries. These operations move msg->sg.data[] entries, but the parallel
copy bitmap can be left behind or stale in slots that no longer contain
the original entry. A copied entry can therefore later occupy a slot whose
copy bit is clear and be exposed as directly writable packet data.

Keep msg->sg.copy synchronized with scatterlist entry moves, preserve the
copy bit when an entry is split, clear it when a helper replaces an entry
with a private page, and clear every slot vacated by pull-data
compaction.

Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
Cc: stable@vger.kernel.org
Co-developed-by: Han Guidong <2045gemini@gmail.com>
Signed-off-by: Han Guidong <2045gemini@gmail.com>
Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
---
v2:
Sashiko-bot pointed out that bpf_msg_pull_data() could leave stale copy
bits on collapsed tail entries.

Clear msg->sg.copy for every entry consumed by bpf_msg_pull_data()
before compacting the scatterlist ring.

While researching recent page cache bugs, we discovered this bug.
We confirmed it allows overwriting the page cache of read-only files
via splice(). We haven't attempted to write an exploit, but the
corruption primitive is verified. PoC available upon request.
Recommend fixing ASAP.
---
 net/core/filter.c | 66 +++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 2 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 9590877b0714f..018c30a0d71fb 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2654,6 +2654,27 @@ static void sk_msg_reset_curr(struct sk_msg *msg)
 	}
 }
 
+static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
+{
+	return test_bit(i, msg->sg.copy);
+}
+
+static void sk_msg_set_elem_copy(struct sk_msg *msg, u32 i, bool copy)
+{
+	if (copy)
+		__set_bit(i, msg->sg.copy);
+	else
+		__clear_bit(i, msg->sg.copy);
+}
+
+static void sk_msg_clear_copy_range(struct sk_msg *msg, u32 start, u32 end)
+{
+	while (start != end) {
+		__clear_bit(start, msg->sg.copy);
+		sk_msg_iter_var_next(start);
+	}
+}
+
 static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
 	.func           = bpf_msg_cork_bytes,
 	.gpl_only       = false,
@@ -2738,6 +2759,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	} while (i != last_sge);
 
 	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
+	sk_msg_set_elem_copy(msg, first_sge, false);
 
 	/* To repair sg ring we need to shift entries. If we only
 	 * had a single entry though we can just replace it and
@@ -2747,13 +2769,20 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 	shift = last_sge > first_sge ?
 		last_sge - first_sge - 1 :
 		NR_MSG_FRAG_IDS - first_sge + last_sge - 1;
-	if (!shift)
+	if (!shift) {
+		sk_msg_set_elem_copy(msg, msg->sg.end, false);
 		goto out;
+	}
+
+	i = first_sge;
+	sk_msg_iter_var_next(i);
+	sk_msg_clear_copy_range(msg, i, last_sge);
 
 	i = first_sge;
 	sk_msg_iter_var_next(i);
 	do {
 		u32 move_from;
+		bool move_copy;
 
 		if (i + shift >= NR_MSG_FRAG_IDS)
 			move_from = i + shift - NR_MSG_FRAG_IDS;
@@ -2762,16 +2791,20 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
 		if (move_from == msg->sg.end)
 			break;
 
+		move_copy = sk_msg_elem_is_copy(msg, move_from);
 		msg->sg.data[i] = msg->sg.data[move_from];
+		sk_msg_set_elem_copy(msg, i, move_copy);
 		msg->sg.data[move_from].length = 0;
 		msg->sg.data[move_from].page_link = 0;
 		msg->sg.data[move_from].offset = 0;
+		sk_msg_set_elem_copy(msg, move_from, false);
 		sk_msg_iter_var_next(i);
 	} while (1);
 
 	msg->sg.end = msg->sg.end - shift > msg->sg.end ?
 		      msg->sg.end - shift + NR_MSG_FRAG_IDS :
 		      msg->sg.end - shift;
+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
 out:
 	sk_msg_reset_curr(msg);
 	msg->data = sg_virt(&msg->sg.data[first_sge]) + start - offset;
@@ -2794,6 +2827,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 {
 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
 	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
+	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
+	bool rsge_copy = false;
 	u8 *raw, *to, *from;
 	struct page *page;
 
@@ -2866,6 +2901,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 			sk_msg_iter_var_prev(i);
 		psge = sk_msg_elem(msg, i);
 		rsge = sk_msg_elem_cpy(msg, i);
+		rsge_copy = sk_msg_elem_is_copy(msg, i);
 
 		psge->length = start - offset;
 		rsge.length -= psge->length;
@@ -2891,23 +2927,31 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
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
+		sk_msg_set_elem_copy(msg, i, sge_copy);
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
 
@@ -2915,13 +2959,15 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
 	/* Place newly allocated data buffer */
 	sk_mem_charge(msg->sk, len);
 	msg->sg.size += len;
-	__clear_bit(new, msg->sg.copy);
+	sk_msg_set_elem_copy(msg, new, false);
 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
 	if (rsge.length) {
 		get_page(sg_page(&rsge));
 		sk_msg_iter_var_next(new);
 		msg->sg.data[new] = rsge;
+		sk_msg_set_elem_copy(msg, new, rsge_copy);
 	}
+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
 
 	sk_msg_reset_curr(msg);
 	sk_msg_compute_data_pointers(msg);
@@ -2945,29 +2991,41 @@ static void sk_msg_shift_left(struct sk_msg *msg, int i)
 
 	put_page(sg_page(sge));
 	do {
+		bool copy;
+
 		prev = i;
 		sk_msg_iter_var_next(i);
+		copy = sk_msg_elem_is_copy(msg, i);
 		msg->sg.data[prev] = msg->sg.data[i];
+		sk_msg_set_elem_copy(msg, prev, copy);
 	} while (i != msg->sg.end);
 
 	sk_msg_iter_prev(msg, end);
+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
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
+		sk_msg_set_elem_copy(msg, i, sge_copy);
 		sk_msg_iter_var_next(i);
 		sge = tmp;
+		sge_copy = tmp_copy;
 		tmp = sk_msg_elem_cpy(msg, i);
+		tmp_copy = sk_msg_elem_is_copy(msg, i);
 	}
+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
 }
 
 BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
@@ -3024,8 +3082,10 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 	 */
 	if (start != offset) {
 		struct scatterlist *nsge, *sge = sk_msg_elem(msg, i);
+		u32 sge_idx = i;
 		int a = start - offset;
 		int b = sge->length - pop - a;
+		bool sge_copy = sk_msg_elem_is_copy(msg, sge_idx);
 
 		sk_msg_iter_var_next(i);
 
@@ -3038,6 +3098,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				sg_set_page(nsge,
 					    sg_page(sge),
 					    b, sge->offset + pop + a);
+				sk_msg_set_elem_copy(msg, i, sge_copy);
 			} else {
 				struct page *page, *orig;
 				u8 *to, *from;
@@ -3054,6 +3115,7 @@ BPF_CALL_4(bpf_msg_pop_data, struct sk_msg *, msg, u32, start,
 				memcpy(to, from, a);
 				memcpy(to + a, from + a + pop, b);
 				sg_set_page(sge, page, a + b, 0);
+				sk_msg_set_elem_copy(msg, sge_idx, false);
 				put_page(orig);
 			}
 			pop = 0;
-- 
2.43.0

