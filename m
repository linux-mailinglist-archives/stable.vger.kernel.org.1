Return-Path: <stable+bounces-249400-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ALuzGN+FC2paIwUAu9opvQ
	(envelope-from <stable+bounces-249400-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 23:34:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id BFBA5573EB4
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 23:34:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F377B3046999
	for <lists+stable@lfdr.de>; Mon, 18 May 2026 21:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED68839A040;
	Mon, 18 May 2026 21:32:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK+OiKIi"
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f172.google.com (mail-pf1-f172.google.com [209.85.210.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 598642EA48F
	for <stable@vger.kernel.org>; Mon, 18 May 2026 21:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779139964; cv=none; b=TqOpiD+bDG6p/uJskYtV4ds17XbNA6r7ZTCKBZdCCkB1+rfDfrny6gTBlVx5Mq9omzGZ0GlNBetoGvm6DLd7/LRMcdkUUg0BWj9d+D8FLL2dWGLZz+b1Jui4U1PD6AnMKv67TXfrimlzJ+rKxz4BctEPwXou+y9CGEoryHdaoCs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779139964; c=relaxed/simple;
	bh=3aO2yCIwUg/uOsD4q75e/EVR3uTZHduiRHimOrSA678=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r5ASvp0I3wqmZo/MAIfPup9m3hegKD9n7mqgcCKogcf/A0YNvF2QM7t9X/VrDXKFIHl6vrkd9IuquSpsZyzwV01DjGFM1DdtkqfYN0x76hU21K7rQ518cocuSx+j/fnMrVNdjw5BXE4+uonMtw8KzFR4UY60nBOQ0nPmEPbpvZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DK+OiKIi; arc=none smtp.client-ip=209.85.210.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f172.google.com with SMTP id d2e1a72fcca58-838d0b7c950so1949317b3a.3
        for <stable@vger.kernel.org>; Mon, 18 May 2026 14:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779139962; x=1779744762; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=8XdCdfE4QefmdTL9pvsdi/RQj4TXB83Ld+/w0tbLorI=;
        b=DK+OiKIiw/EFRHmb2Ir5NLJKuVR+okJ4hzupkR6nU2olcJ67E4ZMc1ygTvmKO4vKoD
         ljWG57V8XD8681qPYnMuzMcT6wb4HWvqzmVeju3zWQrOfF9VWKNbCQdDqRK6AL6ugJ5s
         o5tivJjl72zX6v5BejnexT86HagBJuqjkmhEsYoJmxpBABVe5h/YjIdvGy9WiLej8PaI
         Ca7pP5DDY+3HjllKbql56c2x4HkaabT0K0damBIhks3Jbzr1ux+uY0+OyI5VtQCDzMbF
         B6Y3cHGD6ngrEgYbOt5KEkbPrW3OPOl0UkqD2SSFYxrNXiRoDhSrtXem6OmN9Wzzkhm5
         Fhbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779139962; x=1779744762;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8XdCdfE4QefmdTL9pvsdi/RQj4TXB83Ld+/w0tbLorI=;
        b=dyuewjJ9A90P9oP6msup9394Nh9zdX/2DBSJNt4dOCa+1lUcHZKqnQ+hkQk2D8IDgS
         EzMH57E2OAA333T8qQ6xXu75vm4BYY/02MEPNO1eZ8NQo2MyEEQpUyX6dDTwwxYkun75
         L3DDFRkPG9ZN6NMD21jj5ZucYTEUHxvaXf9Haq56TP7Egey46dkM7jJqsSrdTGaqwejW
         K8dTxs+BMBQMm4UTZVnUpFSxnlQk/z5sQ4dbc1CYbYbpGq2i6mYVKxuKdZaNfN5MFY52
         MFwr0pYlLD2tVXQc6e3XCIgijV6hSacrXCgpIJKsBj7131lcvchN11RLELTXquaVND2z
         nMlQ==
X-Forwarded-Encrypted: i=1; AFNElJ/C3jd51N3wJvWYoYKi/kGcsOb4TVi1JKXrsR6Y9pJyeuD1R1HzqRbDccIkSzbPxOFfnTvhaYA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLmGUZrNNPgGCDDNWBZ4e+pMItPRZfPqjFR8ha0q3S1s/uBlzR
	C/ivdHpPrZzJo4KIHYy3+07DUOb1tWnUPsxpB5aQyOhuYi8x8fUDlxCg
X-Gm-Gg: Acq92OHqn/za1iAUjsbqrZIaA4fVOb2jzmMP1Bm/lOhBnDw5/MHJqpBkRrB3Ss79duA
	q3f3koaKyYyc7Q2LaoLodP0BbzKnzg8foLoZDZ18HedzzRRvb6ykdk3FSy1qFn27x17c80t/+So
	n0W8142HZo3NmBujojEkFwAGMV+elDeatHJdJCtQVvqvMDD/9MjQQDZK6Wg36IjWBhn4Wq2CYyh
	g2jdAnd/dXKoXgKDVKAHYf+5Q/94iDexL1FCXfzXtNV4G7Zc05t3o0fCSzNvO6MKelugprpt6Cr
	VFbUM6cHIGMh/ZTxqiIlt4rLKJkQULySZVAXQFOqZjcsYGR8xruVNoUANvPO1YT5BAfHa7cvLTF
	oyMjESg3pmDE7R4YqqKrsfunG8eisiKbA/HA+Jez0Qa087gdq0yFAOjVkcJDbZItEYWg2Qt52K5
	NOs3KZCKD9MENdOfgGt4/z27Q23HpJRmA=
X-Received: by 2002:a05:6a00:2e9f:b0:83d:446c:2aa4 with SMTP id d2e1a72fcca58-83f33dd346emr17824630b3a.33.1779139961622;
        Mon, 18 May 2026 14:32:41 -0700 (PDT)
Received: from john-p8 ([98.97.42.187])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-83f75c0d232sm4274129b3a.17.2026.05.18.14.32.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2026 14:32:40 -0700 (PDT)
Date: Mon, 18 May 2026 14:32:38 -0700
From: John Fastabend <john.fastabend@gmail.com>
To: Zhang Cen <rollkingzzc@gmail.com>
Cc: Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Andrii Nakryiko <andrii@kernel.org>, 
	Martin KaFai Lau <martin.lau@linux.dev>, Stanislav Fomichev <sdf@fomichev.me>, 
	Jakub Sitnicki <jakub@cloudflare.com>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, bpf@vger.kernel.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, zerocling0077@gmail.com, 
	2045gemini@gmail.com, stable@vger.kernel.org
Subject: Re: [PATCH v2] bpf, sockmap: keep sk_msg copy state in sync
Message-ID: <rclmtymkiaor247n7gwi6ggmpwi2hyu5hicggroopeohspfnyv@7ryrgezzs63q>
References: <20260517121626.406516-1-rollkingzzc@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20260517121626.406516-1-rollkingzzc@gmail.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249400-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,linux.dev,fomichev.me,cloudflare.com,davemloft.net,google.com,redhat.com,vger.kernel.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[johnfastabend@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: BFBA5573EB4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, May 17, 2026 at 08:16:26PM +0800, Zhang Cen wrote:
>SK_MSG uses msg->sg.copy as per-scatterlist-entry provenance. Entries
>with this bit set are copied before data/data_end are exposed to SK_MSG
>BPF programs for direct packet access.
>
>bpf_msg_pull_data(), bpf_msg_push_data() and bpf_msg_pop_data() rewrite
>the sk_msg scatterlist ring by collapsing, splitting and shifting
>entries. These operations move msg->sg.data[] entries, but the parallel
>copy bitmap can be left behind or stale in slots that no longer contain
>the original entry. A copied entry can therefore later occupy a slot whose
>copy bit is clear and be exposed as directly writable packet data.
>
>Keep msg->sg.copy synchronized with scatterlist entry moves, preserve the
>copy bit when an entry is split, clear it when a helper replaces an entry
>with a private page, and clear every slot vacated by pull-data
>compaction.
>
>Fixes: 015632bb30da ("bpf: sk_msg program helper bpf_sk_msg_pull_data")
>Fixes: 6fff607e2f14 ("bpf: sk_msg program helper bpf_msg_push_data")
>Fixes: 7246d8ed4dcc ("bpf: helper to pop data from messages")
>Cc: stable@vger.kernel.org
>Co-developed-by: Han Guidong <2045gemini@gmail.com>
>Signed-off-by: Han Guidong <2045gemini@gmail.com>
>Signed-off-by: Zhang Cen <rollkingzzc@gmail.com>
>---
>v2:
>Sashiko-bot pointed out that bpf_msg_pull_data() could leave stale copy
>bits on collapsed tail entries.
>
>Clear msg->sg.copy for every entry consumed by bpf_msg_pull_data()
>before compacting the scatterlist ring.
>
>While researching recent page cache bugs, we discovered this bug.
>We confirmed it allows overwriting the page cache of read-only files
>via splice(). We haven't attempted to write an exploit, but the
>corruption primitive is verified. PoC available upon request.
>Recommend fixing ASAP.

Sorry I missed your v2 so reviewing again.

Important note here on where this actually happens. It will only
effect users of BPF programs that are making the push/pop/..
calls. So most/all users should not be impacted. Agree though lets
fix this.

>---
> net/core/filter.c | 66 +++++++++++++++++++++++++++++++++++++++++++++--
> 1 file changed, 64 insertions(+), 2 deletions(-)
>
>diff --git a/net/core/filter.c b/net/core/filter.c
>index 9590877b0714f..018c30a0d71fb 100644
>--- a/net/core/filter.c
>+++ b/net/core/filter.c
>@@ -2654,6 +2654,27 @@ static void sk_msg_reset_curr(struct sk_msg *msg)
> 	}
> }
>
>+static bool sk_msg_elem_is_copy(const struct sk_msg *msg, u32 i)
>+{
>+	return test_bit(i, msg->sg.copy);
>+}
>+
>+static void sk_msg_set_elem_copy(struct sk_msg *msg, u32 i, bool copy)
>+{
>+	if (copy)
>+		__set_bit(i, msg->sg.copy);
>+	else
>+		__clear_bit(i, msg->sg.copy);
>+}

To make this easier to read I think having a,

static void sk_msg_clear_elem_copy(struct sk_msg *msg, u32 i, bool copy)
{
	__clear_bit(i, msg->sg.copy);
}

is nice to have. Otherwise we get lots of

    sk_msg_clear_elem_copy(..., false) 

Or just direclty call __clear_bit() is also cleaner.

>+
>+static void sk_msg_clear_copy_range(struct sk_msg *msg, u32 start, u32 end)
>+{
>+	while (start != end) {
>+		__clear_bit(start, msg->sg.copy);
>+		sk_msg_iter_var_next(start);
>+	}
>+}
>+
> static const struct bpf_func_proto bpf_msg_cork_bytes_proto = {
> 	.func           = bpf_msg_cork_bytes,
> 	.gpl_only       = false,
>@@ -2738,6 +2759,7 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
> 	} while (i != last_sge);
>
> 	sg_set_page(&msg->sg.data[first_sge], page, copy, 0);
>+	sk_msg_set_elem_copy(msg, first_sge, false);
>
> 	/* To repair sg ring we need to shift entries. If we only
> 	 * had a single entry though we can just replace it and
>@@ -2747,13 +2769,20 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
> 	shift = last_sge > first_sge ?
> 		last_sge - first_sge - 1 :
> 		NR_MSG_FRAG_IDS - first_sge + last_sge - 1;
>-	if (!shift)
>+	if (!shift) {
>+		sk_msg_set_elem_copy(msg, msg->sg.end, false);
> 		goto out;
>+	}
>+
>+	i = first_sge;
>+	sk_msg_iter_var_next(i);
>+	sk_msg_clear_copy_range(msg, i, last_sge);
>
> 	i = first_sge;
> 	sk_msg_iter_var_next(i);
> 	do {
> 		u32 move_from;
>+		bool move_copy;
>
> 		if (i + shift >= NR_MSG_FRAG_IDS)
> 			move_from = i + shift - NR_MSG_FRAG_IDS;
>@@ -2762,16 +2791,20 @@ BPF_CALL_4(bpf_msg_pull_data, struct sk_msg *, msg, u32, start,
> 		if (move_from == msg->sg.end)
> 			break;
>
>+		move_copy = sk_msg_elem_is_copy(msg, move_from);
> 		msg->sg.data[i] = msg->sg.data[move_from];
>+		sk_msg_set_elem_copy(msg, i, move_copy);

This is sk_msg_sg_move()?

> 		msg->sg.data[move_from].length = 0;
> 		msg->sg.data[move_from].page_link = 0;
> 		msg->sg.data[move_from].offset = 0;
>+		sk_msg_set_elem_copy(msg, move_from, false);
> 		sk_msg_iter_var_next(i);
> 	} while (1);
>
> 	msg->sg.end = msg->sg.end - shift > msg->sg.end ?
> 		      msg->sg.end - shift + NR_MSG_FRAG_IDS :
> 		      msg->sg.end - shift;
>+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
> out:
> 	sk_msg_reset_curr(msg);
> 	msg->data = sg_virt(&msg->sg.data[first_sge]) + start - offset;
>@@ -2794,6 +2827,8 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> {
> 	struct scatterlist sge, nsge, nnsge, rsge = {0}, *psge;
> 	u32 new, i = 0, l = 0, space, copy = 0, offset = 0;
>+	bool sge_copy = false, nsge_copy = false, nnsge_copy = false;
>+	bool rsge_copy = false;
> 	u8 *raw, *to, *from;
> 	struct page *page;
>
>@@ -2866,6 +2901,7 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> 			sk_msg_iter_var_prev(i);
> 		psge = sk_msg_elem(msg, i);
> 		rsge = sk_msg_elem_cpy(msg, i);
>+		rsge_copy = sk_msg_elem_is_copy(msg, i);
>
> 		psge->length = start - offset;
> 		rsge.length -= psge->length;

I think we need another fix here,

	       rsge.offset += start - offset;

Probably carry in another patch. I can do it if you want?

>@@ -2891,23 +2927,31 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> 	/* Shift one or two slots as needed */
> 	sge = sk_msg_elem_cpy(msg, new);
> 	sg_unmark_end(&sge);
>+	sge_copy = sk_msg_elem_is_copy(msg, new);
>
> 	nsge = sk_msg_elem_cpy(msg, i);
>+	nsge_copy = sk_msg_elem_is_copy(msg, i);
> 	if (rsge.length) {
> 		sk_msg_iter_var_next(i);
> 		nnsge = sk_msg_elem_cpy(msg, i);
>+		nnsge_copy = sk_msg_elem_is_copy(msg, i);
> 		sk_msg_iter_next(msg, end);
> 	}
>
> 	while (i != msg->sg.end) {
> 		msg->sg.data[i] = sge;
>+		sk_msg_set_elem_copy(msg, i, sge_copy);
> 		sge = nsge;
>+		sge_copy = nsge_copy;
> 		sk_msg_iter_var_next(i);
> 		if (rsge.length) {
> 			nsge = nnsge;
>+			nsge_copy = nnsge_copy;
> 			nnsge = sk_msg_elem_cpy(msg, i);
>+			nnsge_copy = sk_msg_elem_is_copy(msg, i);
> 		} else {
> 			nsge = sk_msg_elem_cpy(msg, i);
>+			nsge_copy = sk_msg_elem_is_copy(msg, i);
> 		}
> 	}
>
>@@ -2915,13 +2959,15 @@ BPF_CALL_4(bpf_msg_push_data, struct sk_msg *, msg, u32, start,
> 	/* Place newly allocated data buffer */
> 	sk_mem_charge(msg->sk, len);
> 	msg->sg.size += len;
>-	__clear_bit(new, msg->sg.copy);
>+	sk_msg_set_elem_copy(msg, new, false);
> 	sg_set_page(&msg->sg.data[new], page, len + copy, 0);
> 	if (rsge.length) {
> 		get_page(sg_page(&rsge));
> 		sk_msg_iter_var_next(new);
> 		msg->sg.data[new] = rsge;
>+		sk_msg_set_elem_copy(msg, new, rsge_copy);
> 	}
>+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
>
> 	sk_msg_reset_curr(msg);
> 	sk_msg_compute_data_pointers(msg);
>@@ -2945,29 +2991,41 @@ static void sk_msg_shift_left(struct sk_msg *msg, int i)
>
> 	put_page(sg_page(sge));
> 	do {
>+		bool copy;
>+
> 		prev = i;
> 		sk_msg_iter_var_next(i);
>+		copy = sk_msg_elem_is_copy(msg, i);
> 		msg->sg.data[prev] = msg->sg.data[i];
>+		sk_msg_set_elem_copy(msg, prev, copy);

sk_msg_sg_move()?

> 	} while (i != msg->sg.end);
>
> 	sk_msg_iter_prev(msg, end);
>+	sk_msg_set_elem_copy(msg, msg->sg.end, false);
> }


I think this is good with small cleanup. The bot report (need to check 
again), but I think it was calling out another issue with a different
fix/patch needed.

Do you want to follow up with the other couple addons or should I?

Also please add a test for this so we capture it in selftests.

Thanks!
John

