Return-Path: <stable+bounces-217777-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sIoCJyFmnGmsFwQAu9opvQ
	(envelope-from <stable+bounces-217777-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 15:37:21 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0956217820D
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 15:37:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D1BC63033AA1
	for <lists+stable@lfdr.de>; Mon, 23 Feb 2026 14:36:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9DE527E049;
	Mon, 23 Feb 2026 14:36:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="irDxCvnq"
X-Original-To: stable@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5133C199FAB
	for <stable@vger.kernel.org>; Mon, 23 Feb 2026 14:36:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.179
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771857404; cv=pass; b=IRJVCuGZ4QQLQlhkIa4f74Cj0ZnKUNVRhfwOowiSGabXVCMM+fwBkRqXHCSlv11MGWxq8xP4TLzY7BmI0l3wHSDF7/qNc9vJoXO2MiST0RTT8AUcslDvlfPhCfcz4QBO694m3BVP6+9vPsTMFzsAtDl3rt7+v6as2m0clFUo7Vk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771857404; c=relaxed/simple;
	bh=j88nzqxGDcpi5krckH7OxT+BN89QRDXkSXwvN5oduIc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HL3yueLMeAywCfVap3N0IzXVe9aww0BSiP/K12Kwge7Wulu7dSHq3qBJSGgOYP4JsC+MpldLFOqj6JNdm7OKBcxpGfGnXWBt3JnS3rLsllkDvj47La+SZpccKqh+qqT2ps6+rFvt1VHdGc3UjlyEoiFpnydDSn/czpg5YH6vSic=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=irDxCvnq; arc=pass smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-3870778358aso36903031fa.1
        for <stable@vger.kernel.org>; Mon, 23 Feb 2026 06:36:43 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771857401; cv=none;
        d=google.com; s=arc-20240605;
        b=SVR6+0A1eceMrTVlP2qN4SiODktvlm+ENjNWa0XJXPw79Vx6kcBdJBV2Ld7DC2tvb3
         F/ilJkT8U9kr1yDOAJrGNhWaPUDtub7K4zOUXWQ+a8r+ITb8/jbJB46EzvgfKp7iMdWY
         VUgFz/I0fYNA1qz8SHVN/lnrKgpfenB+/q+VL4Klg2yFXsHmedy91pxp57CKWITlD4nX
         kPtbreG+oUwSODbwJqn/D7v5+hB8B+HiRgwyHWecCEJnWwE47JeAcGZSjuVtE2PCZA4c
         +Vb6OAym3Y9vhb0YPARxwukclnf7fs1tlyYr1GrTrly7d5gA2LPnntmhQGazVH48/rll
         Krtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=MM3aKteGZmW/7GayY7dRMfYL0Xw/N+1zNqCVx7UjMoM=;
        fh=beutSEitJL8r8+KeBxS56JO6xSi9YNDF2CbBHSCLaTU=;
        b=ibwQ/0KBDAj20Cd4XXEnFY4vpCOOvWv2i5FCIYJQyHJtuiQCB32nR41K4mn+CMEY3D
         0pwk/JeTngani6b1Y8s5mlQf6MhtLkEIj7L02nUffDzWrHQ5Ju5N/HbCTCt82OfxCzWA
         Z5xrieQK5exUMtyn6b4vZXMjaeoy0jNSz0dx8JGm7rpy2CnuHy5rZ+0iv6Ow3yc5Y2dj
         XGXbVfsj0jpeTaCl8LXzb4rsdgQNBqeGbhcBgTa2+4NbVPKdt8We6B9VMfFR6Sj8uKQs
         sa6I6UpIRhKcb5de7lifzH90p0ewke7sL+LNBnen5V1DgxRFr7TdlCftjKqZm32sQn6L
         euXQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1771857401; x=1772462201; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MM3aKteGZmW/7GayY7dRMfYL0Xw/N+1zNqCVx7UjMoM=;
        b=irDxCvnqteNRa0c/OsNPf326YWfXHqaIRd3qVPEV1c2K6ll8KaHw2UE680KEjE+VJr
         xsXenHQ97Zy8c44gGrHb+iOeUsY/q/QXIjLvdPjrY+oKwJ9miYyKCssGqdy44bmX2RUz
         JSNf4+gzFDlhR9ghVm12eomvNBjBSAljVgoW/GsNj47qvfz74Ne4cPrv0bjFvHU8Da9R
         9h365e53+BzRIBJbOytWbjX5efzSucz+ell57YV99LDzLXeJHGwoJcANwnWedVVGaYtW
         qk73WsREdAZN2DiPQm2vXwuae6qLnqmJKE4WG6avBsK7Y1oc5xTqb1cHej/EnDI6Od76
         nd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771857401; x=1772462201;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MM3aKteGZmW/7GayY7dRMfYL0Xw/N+1zNqCVx7UjMoM=;
        b=H12EKxaTjNsRvOlfEMeVOj5me+9ogp2hmByDYGJfiPIYPFiRfFcoB3Rq8RcKYtVBhO
         GYyF3I/uHMCOxllEirD2PpkUWBtslhRQklh3BjLYB67KszduhjCtGhddnvp/6ztmuWKI
         1vW6QRLeKGlRL9IcXLyJnNzatCCHR29KU1hDZ3bD8drQ+244eBPc91OUeJNPnD9pMHUQ
         B6ojBqtfT4f/vSyRRsXdGatnlpP4JzvK10GkFm49tfZ7VzodJXZgbVZ5bEjNJNHxFY5R
         50zw9tN8F7cBawgqKllOTn3hwsPKKpFLQ+lWacTWbFo/KoAAfTadU1JkNSwJk3e3Mb4f
         60jw==
X-Forwarded-Encrypted: i=1; AJvYcCVMPRbv23SrZhL+1U74Ul4r0EyasHX8dmAurSvyvvI7owazPcTuqmrd9F4MV3IWWOAY9olOFAg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyWgOUVJSNmX/kMaxBe0D+W3XyTHZkNk+DO6dH2hkEJQCtZz6Br
	Eww2YDQcpMvtK7ILbMOpSrrISclkpS5lt3saxJeviLhpw+hPmMwwLZeom9DQy7jgfALne1JjVAg
	cPXg+ChTL8z7BE4SrOUPkVqfS8nNsqR/44DdQSXHg
X-Gm-Gg: AZuq6aLBIkwDgbepP9H/pY6MwJU4eg5CAXgwWSYcFKOh2C6QjgRMRzqVhj+cyIZeBh2
	3DVLZwRE/P7jbMLjqQj7uM2WzXm0d01ldXr1UjAXED0cfnoUwQ0SBFdMIW6G6njeoUiDEkMKKUI
	dhbG6B8qw1ocTCF/f0FPDS6Pl09IwI4ahYbt7Asi9u3MxnfEJZ89O7JM+7+tPkutDfvq60aN8Rj
	wk3ug95xaIhi1iBNoyMP62X2lMtYxCAbPlkKyT2nFD06PNzhQT4JAMA2YUwr5YDzdK3EfW+vpAr
	x/zz5o6M+M1mHEHX4J+OszZ6t+VhRsgV5Apg/A==
X-Received: by 2002:a05:651c:31ce:b0:386:fd3e:bff0 with SMTP id
 38308e7fff4ca-389a5e94213mr23326701fa.39.1771857401229; Mon, 23 Feb 2026
 06:36:41 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260204092230.2540042-1-syzbot@kernel.org>
In-Reply-To: <20260204092230.2540042-1-syzbot@kernel.org>
From: Dmitry Vyukov <dvyukov@google.com>
Date: Mon, 23 Feb 2026 15:36:29 +0100
X-Gm-Features: AaiRm51tCsRBB7oayfu63tMMIZDAgJ7xHZQrvew4IJNGGTC0wVblcq8ltf71rm0
Message-ID: <CACT4Y+YVb8+XkEg2ucfYKjw-J7uy2Om19kzrGkXvkyxa9XTzvQ@mail.gmail.com>
Subject: Re: [PATCH] jfs: fix array-index-out-of-bounds in dbFindLeaf
To: syzbot <syzbot@kernel.org>
Cc: jfs-discussion@lists.sourceforge.net, shaggy@kernel.org, 
	ghandatmanas@gmail.com, syzbot+1afe7ef2d0062e19eeb3@syzkaller.appspotmail.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[lists.sourceforge.net,kernel.org,gmail.com,syzkaller.appspotmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-217777-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dvyukov@google.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[google.com:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable,1afe7ef2d0062e19eeb3];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,appspotmail.com:email]
X-Rspamd-Queue-Id: 0956217820D
X-Rspamd-Action: no action

On Wed, 4 Feb 2026 at 10:23, syzbot <syzbot@kernel.org> wrote:
>
> UBSAN reported an array-index-out-of-bounds issue in dbFindLeaf:
>
>   index 1365 is out of range for type 's8[1365]' (aka 'signed char[1365]')
>   CPU: 0 UID: 0 PID: 6287 Comm: syz-executor268 Not tainted ...
>   Call Trace:
>    ...
>    __ubsan_handle_out_of_bounds+0x115/0x140 lib/ubsan.c:455
>    dbFindLeaf+0x308/0x520 fs/jfs/jfs_dmap.c:2976
>    dbFindCtl+0x267/0x520 fs/jfs/jfs_dmap.c:1717
>    ...
>
> The issue is caused by an off-by-one error in the bounds check within
> dbFindLeaf. The function traverses the dmap tree to find free blocks.
> It uses a loop to iterate through the levels of the tree, calculating
> the index `x + n` to access the `tp->dmt_stree` array. The variable
> `max_size` represents the size of this array (CTLTREESIZE (1365) for
> dmapctl or TREESIZE (341) for dmaptree).
>
> The bounds check `if (x + n > max_size)` allows `x + n` to be equal to
> `max_size`. However, since the array size is `max_size`, the valid
> indices are `0` to `max_size - 1`. Accessing `tp->dmt_stree[max_size]`
> results in an array-index-out-of-bounds access.
>
> This can occur when the `dmt_height` field in the on-disk structure is
> corrupted or fuzzed to be larger than the fixed height supported by the
> `dmt_stree` array.
>
> Fix this by changing the condition to `>=` to correctly reject indices
> equal to or greater than the array size.
>
> Signed-off-by: syzbot@kernel.org
> Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
> Fixes: 22cad8bc1d36 ("jfs: fix array-index-out-of-bounds in dbFindLeaf")
> Reported-by: syzbot+1afe7ef2d0062e19eeb3@syzkaller.appspotmail.com
> To: <jfs-discussion@lists.sourceforge.net>
> To: "Dave Kleikamp" <shaggy@kernel.org>
> To: "Manas Ghandat" <ghandatmanas@gmail.com>
> Cc: <linux-kernel@vger.kernel.org>
> Cc: <stable@vger.kernel.org>
> ---
> This patch was generated by Google Gemini LLM model.
> It was pre-reviewed and Signed-off-by a human, but please review carefully.
>
> Gerrit code review with full side-by-side diffs:
> https://linux-review.git.corp.google.com/c/linux/kernel/git/torvalds/linux/+/26122
>
> Change-Id: I92f694e86518349eafa132b2ba314d8dfff6c86e
> ---
>
> diff --git a/fs/jfs/jfs_dmap.c b/fs/jfs/jfs_dmap.c
> index cdfa699..18a7dc5 100644
> --- a/fs/jfs/jfs_dmap.c
> +++ b/fs/jfs/jfs_dmap.c
> @@ -2971,7 +2971,7 @@ static int dbFindLeaf(dmtree_t *tp, int l2nb, int *leafidx, bool is_ctl)
>                         /* sufficient free space found.  move to the next
>                          * level (or quit if this is the last level).
>                          */
> -                       if (x + n > max_size)
> +                       if (x + n >= max_size)
>                                 return -ENOSPC;
>                         if (l2nb <= tp->dmt_stree[x + n])
>                                 break;
>
> base-commit: 63804fed149a6750ffd28610c5c1c98cce6bd377

Hello jfs maintainers,

Is this patch on anybody radaras? Please merge the fix.
Or should JFS patches now be sent to a generic FS tree for merging?

