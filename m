Return-Path: <stable+bounces-195419-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2161CC76255
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 21:12:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sea.lore.kernel.org (Postfix) with ESMTPS id D79312957C
	for <lists+stable@lfdr.de>; Thu, 20 Nov 2025 20:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DBD72FD66E;
	Thu, 20 Nov 2025 20:12:13 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from akranes.kaiser.cx (akranes.kaiser.cx [152.53.16.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B912D7D41
	for <stable@vger.kernel.org>; Thu, 20 Nov 2025 20:12:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=152.53.16.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763669533; cv=none; b=Tc+YWhctQtEKXd4cddchYvbZ/4LE+t6NovRJt+KGkVRwRBdzHHLkKLOKT6LUrD0t6gDVI++EeAtrAK8TKEuY8chO91xWGfo5vX/u4VBJea7Dac7Xpr2DupyJtrqNmP6krvSPttFo0CgVcCxYLP6xCnEbUG3RuMPI+32an6PpcTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763669533; c=relaxed/simple;
	bh=Yr7/uk0J+MxB8yNaRi1iV8zkiiEEyosouhIXM8srSS0=;
	h=Date:From:To:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=axvSaCzHh0TjV1K2XV4GdnHGjaCpJzxGi5GXEVq9A7j3plv+JdDQLcx8ZGJ2OLMAd+Eu+KePDrVK3Okt8GS4+W4C3lZNXwovm1kToAVpoV8EWX9DKgaxUTSqx8lyPGKbaeUfABvH5ideB9AbNxdaLZ1SG/zdyh1civRyWWx6juY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx; spf=pass smtp.mailfrom=kaiser.cx; arc=none smtp.client-ip=152.53.16.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kaiser.cx
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kaiser.cx
Received: from [37.224.174.116] (helo=ehlo.thunderbird.net)
	by akranes.kaiser.cx with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <martin@kaiser.cx>)
	id 1vMAE3-008k3J-2h;
	Thu, 20 Nov 2025 20:21:52 +0100
Date: Thu, 20 Nov 2025 22:22:17 +0300
From: Martin Kaiser <martin@kaiser.cx>
To: gregkh@linuxfoundation.org, Liam.Howlett@oracle.com,
 akpm@linux-foundation.org, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_FAILED=3A_patch_=22=5BPATCH=5D?=
 =?US-ASCII?Q?_maple=5Ftree=3A_fix_tracepoin?=
 =?US-ASCII?Q?t_string_pointers=22_failed_to_apply_to_6=2E1-stable_tree?=
User-Agent: K-9 Mail for Android
In-Reply-To: <2025112054-thieving-setback-0708@gregkh>
References: <2025112054-thieving-setback-0708@gregkh>
Message-ID: <2DF90F18-7FD2-4E2D-888A-0D883A18248B@kaiser.cx>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable

I'm travelling at the moment, will have a look next week when I'm back=2E
Thanks, Martin

On 20 November 2025 18:55:54 GMT+03:00, gregkh@linuxfoundation=2Eorg wrote=
:
>
>The patch below does not apply to the 6=2E1-stable tree=2E
>If someone wants it applied there, or to any other stable or longterm
>tree, then please email the backport, including the original git commit
>id to <stable@vger=2Ekernel=2Eorg>=2E
>
>To reproduce the conflict and resubmit, you may use the following command=
s:
>
>git fetch https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/stable/linu=
x=2Egit/ linux-6=2E1=2Ey
>git checkout FETCH_HEAD
>git cherry-pick -x 91a54090026f84ceffaa12ac53c99b9f162946f6
># <resolve conflicts, build, test, etc=2E>
>git commit -s
>git send-email --to '<stable@vger=2Ekernel=2Eorg>' --in-reply-to '2025112=
054-thieving-setback-0708@gregkh' --subject-prefix 'PATCH 6=2E1=2Ey' HEAD^=
=2E=2E
>
>Possible dependencies:
>
>
>
>thanks,
>
>greg k-h
>
>------------------ original commit in Linus's tree ------------------
>
>>From 91a54090026f84ceffaa12ac53c99b9f162946f6 Mon Sep 17 00:00:00 2001
>From: Martin Kaiser <martin@kaiser=2Ecx>
>Date: Thu, 30 Oct 2025 16:55:05 +0100
>Subject: [PATCH] maple_tree: fix tracepoint string pointers
>
>maple_tree tracepoints contain pointers to function names=2E Such a point=
er
>is saved when a tracepoint logs an event=2E There's no guarantee that it'=
s
>still valid when the event is parsed later and the pointer is dereference=
d=2E
>
>The kernel warns about these unsafe pointers=2E
>
>	event 'ma_read' has unsafe pointer field 'fn'
>	WARNING: kernel/trace/trace=2Ec:3779 at ignore_event+0x1da/0x1e4
>
>Mark the function names as tracepoint_string() to fix the events=2E
>
>One case that doesn't work without my patch would be trace-cmd record
>to save the binary ringbuffer and trace-cmd report to parse it in
>userspace=2E  The address of __func__ can't be dereferenced from
>userspace but tracepoint_string will add an entry to
>/sys/kernel/tracing/printk_formats
>
>Link: https://lkml=2Ekernel=2Eorg/r/20251030155537=2E87972-1-martin@kaise=
r=2Ecx
>Fixes: 54a611b60590 ("Maple Tree: add new data structure")
>Signed-off-by: Martin Kaiser <martin@kaiser=2Ecx>
>Acked-by: Liam R=2E Howlett <Liam=2EHowlett@oracle=2Ecom>
>Cc: <stable@vger=2Ekernel=2Eorg>
>Signed-off-by: Andrew Morton <akpm@linux-foundation=2Eorg>
>
>diff --git a/lib/maple_tree=2Ec b/lib/maple_tree=2Ec
>index 39bb779cb311=2E=2E5aa4c9500018 100644
>--- a/lib/maple_tree=2Ec
>+++ b/lib/maple_tree=2Ec
>@@ -64,6 +64,8 @@
> #define CREATE_TRACE_POINTS
> #include <trace/events/maple_tree=2Eh>
>=20
>+#define TP_FCT tracepoint_string(__func__)
>+
> /*
>  * Kernel pointer hashing renders much of the maple tree dump useless as=
 tagged
>  * pointers get hashed to arbitrary values=2E
>@@ -2756,7 +2758,7 @@ static inline void mas_rebalance(struct ma_state *m=
as,
> 	MA_STATE(l_mas, mas->tree, mas->index, mas->last);
> 	MA_STATE(r_mas, mas->tree, mas->index, mas->last);
>=20
>-	trace_ma_op(__func__, mas);
>+	trace_ma_op(TP_FCT, mas);
>=20
> 	/*
> 	 * Rebalancing occurs if a node is insufficient=2E  Data is rebalanced
>@@ -2997,7 +2999,7 @@ static void mas_split(struct ma_state *mas, struct =
maple_big_node *b_node)
> 	MA_STATE(prev_l_mas, mas->tree, mas->index, mas->last);
> 	MA_STATE(prev_r_mas, mas->tree, mas->index, mas->last);
>=20
>-	trace_ma_op(__func__, mas);
>+	trace_ma_op(TP_FCT, mas);
>=20
> 	mast=2El =3D &l_mas;
> 	mast=2Er =3D &r_mas;
>@@ -3172,7 +3174,7 @@ static bool mas_is_span_wr(struct ma_wr_state *wr_m=
as)
> 			return false;
> 	}
>=20
>-	trace_ma_write(__func__, wr_mas->mas, wr_mas->r_max, entry);
>+	trace_ma_write(TP_FCT, wr_mas->mas, wr_mas->r_max, entry);
> 	return true;
> }
>=20
>@@ -3416,7 +3418,7 @@ static noinline void mas_wr_spanning_store(struct m=
a_wr_state *wr_mas)
> 	 * of data may happen=2E
> 	 */
> 	mas =3D wr_mas->mas;
>-	trace_ma_op(__func__, mas);
>+	trace_ma_op(TP_FCT, mas);
>=20
> 	if (unlikely(!mas->index && mas->last =3D=3D ULONG_MAX))
> 		return mas_new_root(mas, wr_mas->entry);
>@@ -3552,7 +3554,7 @@ static inline void mas_wr_node_store(struct ma_wr_s=
tate *wr_mas,
> 	} else {
> 		memcpy(wr_mas->node, newnode, sizeof(struct maple_node));
> 	}
>-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
>+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
> 	mas_update_gap(mas);
> 	mas->end =3D new_end;
> 	return;
>@@ -3596,7 +3598,7 @@ static inline void mas_wr_slot_store(struct ma_wr_s=
tate *wr_mas)
> 		mas->offset++; /* Keep mas accurate=2E */
> 	}
>=20
>-	trace_ma_write(__func__, mas, 0, wr_mas->entry);
>+	trace_ma_write(TP_FCT, mas, 0, wr_mas->entry);
> 	/*
> 	 * Only update gap when the new entry is empty or there is an empty
> 	 * entry in the original two ranges=2E
>@@ -3717,7 +3719,7 @@ static inline void mas_wr_append(struct ma_wr_state=
 *wr_mas,
> 		mas_update_gap(mas);
>=20
> 	mas->end =3D new_end;
>-	trace_ma_write(__func__, mas, new_end, wr_mas->entry);
>+	trace_ma_write(TP_FCT, mas, new_end, wr_mas->entry);
> 	return;
> }
>=20
>@@ -3731,7 +3733,7 @@ static void mas_wr_bnode(struct ma_wr_state *wr_mas=
)
> {
> 	struct maple_big_node b_node;
>=20
>-	trace_ma_write(__func__, wr_mas->mas, 0, wr_mas->entry);
>+	trace_ma_write(TP_FCT, wr_mas->mas, 0, wr_mas->entry);
> 	memset(&b_node, 0, sizeof(struct maple_big_node));
> 	mas_store_b_node(wr_mas, &b_node, wr_mas->offset_end);
> 	mas_commit_b_node(wr_mas, &b_node);
>@@ -5062,7 +5064,7 @@ void *mas_store(struct ma_state *mas, void *entry)
> {
> 	MA_WR_STATE(wr_mas, mas, entry);
>=20
>-	trace_ma_write(__func__, mas, 0, entry);
>+	trace_ma_write(TP_FCT, mas, 0, entry);
> #ifdef CONFIG_DEBUG_MAPLE_TREE
> 	if (MAS_WARN_ON(mas, mas->index > mas->last))
> 		pr_err("Error %lX > %lX " PTR_FMT "\n", mas->index, mas->last,
>@@ -5163,7 +5165,7 @@ void mas_store_prealloc(struct ma_state *mas, void =
*entry)
> 	}
>=20
> store:
>-	trace_ma_write(__func__, mas, 0, entry);
>+	trace_ma_write(TP_FCT, mas, 0, entry);
> 	mas_wr_store_entry(&wr_mas);
> 	MAS_WR_BUG_ON(&wr_mas, mas_is_err(mas));
> 	mas_destroy(mas);
>@@ -5882,7 +5884,7 @@ void *mtree_load(struct maple_tree *mt, unsigned lo=
ng index)
> 	MA_STATE(mas, mt, index, index);
> 	void *entry;
>=20
>-	trace_ma_read(__func__, &mas);
>+	trace_ma_read(TP_FCT, &mas);
> 	rcu_read_lock();
> retry:
> 	entry =3D mas_start(&mas);
>@@ -5925,7 +5927,7 @@ int mtree_store_range(struct maple_tree *mt, unsign=
ed long index,
> 	MA_STATE(mas, mt, index, last);
> 	int ret =3D 0;
>=20
>-	trace_ma_write(__func__, &mas, 0, entry);
>+	trace_ma_write(TP_FCT, &mas, 0, entry);
> 	if (WARN_ON_ONCE(xa_is_advanced(entry)))
> 		return -EINVAL;
>=20
>@@ -6148,7 +6150,7 @@ void *mtree_erase(struct maple_tree *mt, unsigned l=
ong index)
> 	void *entry =3D NULL;
>=20
> 	MA_STATE(mas, mt, index, index);
>-	trace_ma_op(__func__, &mas);
>+	trace_ma_op(TP_FCT, &mas);
>=20
> 	mtree_lock(mt);
> 	entry =3D mas_erase(&mas);
>@@ -6485,7 +6487,7 @@ void *mt_find(struct maple_tree *mt, unsigned long =
*index, unsigned long max)
> 	unsigned long copy =3D *index;
> #endif
>=20
>-	trace_ma_read(__func__, &mas);
>+	trace_ma_read(TP_FCT, &mas);
>=20
> 	if ((*index) > max)
> 		return NULL;
>

