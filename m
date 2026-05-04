Return-Path: <stable+bounces-243931-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6NRtKn4r+Wkq6QIAu9opvQ
	(envelope-from <stable+bounces-243931-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:27:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 52B7E4C4CE1
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:27:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id C46B930098B4
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 23:27:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13E7B3D4129;
	Mon,  4 May 2026 23:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dSAan5pq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ojji7bUe"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73EE23A7585
	for <stable@vger.kernel.org>; Mon,  4 May 2026 23:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937269; cv=none; b=SZ6463cSBxueawLLHcH8+Q8w7VaMvktHr6h8Yamxu1lDi00sX8HtggdehxL+E6HK97earHmbigrMwbzFaAiyXsTjdzRMlE6dWRx1kDPFwROId7lRDLvcrxiC+10fWMbbRcazOi63K3QK6q95Mpg9k3cYdXfAhny8P1948dGI5JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937269; c=relaxed/simple;
	bh=X/Ts6FB29sipVCHkAJKOzqHUgYArmLo5X/jhFL+PcWk=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=KiesTBM+oPx61mPVel+A0pZuKgQis6RFT64UV4bI+1+IPS6RgtSGJZksuk+6qSHw0GTQ4UO/1QLCZifk6ss0T6CIXUPXjtv8rUqkJr8gJl8GyInj0xZNTUp/UtuSQwkEEpyqunh4bIiKKE9dTDLxt+2WY9jRbP/X/vPLgBWBKRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dSAan5pq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ojji7bUe; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777937267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yeaz/dAuRpUt7GzZUrHflLMUXhh07epuZ/gDSiDt6lQ=;
	b=dSAan5pq9MznOUv34k3k0ElDqiHM35mDaL+c+NygKw93p6erDDgHmv4U5jhbQUajddQDrd
	rpqQqv+rFtQdVvBmgpxnMj+m+v52xoJDPbohFLvD0MjYKtljwWGm9ZlL5/nVC/t7YppW7l
	gh1dxPmiFqVohjIa4KGORz1w4gnaHSw=
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-527-OvDOjnDCP_Cv7IM-eY3LSw-1; Mon, 04 May 2026 19:27:44 -0400
X-MC-Unique: OvDOjnDCP_Cv7IM-eY3LSw-1
X-Mimecast-MFC-AGG-ID: OvDOjnDCP_Cv7IM-eY3LSw_1777937263
Received: by mail-yw1-f200.google.com with SMTP id 00721157ae682-7bd5c9e2e4aso88467447b3.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 16:27:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777937263; x=1778542063; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=yeaz/dAuRpUt7GzZUrHflLMUXhh07epuZ/gDSiDt6lQ=;
        b=Ojji7bUePPVSPBfvDnMUirWa6/C7s2ioCP9taSRHZ8avF93GgLTPKeBOMZEQqTaEeT
         DMFKUy2I0u0Fb8IRz8fMY6WWBJgpRGPLWxild76F6fAjwiaOCYZdByvq10sB3VsJzeON
         nKS5Uuc1kxVruG0OH/L+9Tm5tCcfaLxrxr1ITGYGIU5vEXE2U0NKrvwbPc3ZvB5sZWHm
         MP7+Fr7TuC9kP0nmAVN9Hvng/fuR9f0s6p3HkYch3GtlTpmg6aAMRGfm3G+YS0Aqxbo+
         nQxpcx2gU/eXXtu8gf7eymLn1HYI7WJJ75iX1qTlfu/cK6i5tXxrA0M3EozoCOos2V4n
         y7TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777937263; x=1778542063;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yeaz/dAuRpUt7GzZUrHflLMUXhh07epuZ/gDSiDt6lQ=;
        b=lbLw1o12clP6l0MQiSbjWfyU49ox63Umbzs0Ahbtun69FRU+T0pf/4g2Fm7LzXZbTs
         Fl9txK/p7BogZXdnYOfrro+sfRbl8am8PyOomJnrT2RTS5G9TyeVz9zHI36Bee51fidP
         0ZZSyHWffWrKmoWHmRO+zgnuCOOFYWIHKa6ZeBuZ3BMOunF3qoM3CaVw/ijIbuf7yMGq
         pBLs4FuIVNBiols+qUY1mlxpxE3y/0AkVkSWLTcx5Tzczg321xGwCe1ZdzzR8ESxfIU7
         Qx0A69NPPiAvzB0VdoJWPwPIZ97IHReJwJzZT3063yHQUw/pqq8e8CNXkwZN0brOu27K
         756w==
X-Forwarded-Encrypted: i=1; AFNElJ944TGcCwmW/YyUKNF+YNuYvwvpdGPJcJDFQ/h78bDgap/0juSLa0/6r8Ku5fhul8wan4he9MI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyfJskJpPdD4gbCSJJKF4OmMWZSxTad75SOFaC81bmBASN+YQlJ
	1oA7tz92cJ+CBRoFfz13rhLc17GdIgyn6++lAJTn6ufLva8cyQrps7rGegczNz+G/R8QExUvYp9
	SKcu00lBTxMZyPsKqgTmtfb+cmGzTLjkRKqOt2g/AWN4KP4Oga9u/Lx+F7A==
X-Gm-Gg: AeBDievz7XWGSbGHQUNJagsXAMSj+CBuwUpSz1RS/ftprtIedbJpLUMfllUx+C8IBXD
	IvdM5FzTsBT/aXp3Brc5r15dTXJdmKLbwPK3yxpLspEY9a0+sHPRo1CYQSNueVusc4YD6I8PUj3
	Ra5cruTC9FNAOBUeeRp3cIvg6SNt58GTIiR0UTiA3MO8hRi/I/L+bgCztmydOKyKNuFfR6W9/qX
	zCmi9qd4S+uASdjNN0LZuLfVk2TviMb8wUSykGnAtpcebSG4lJr4Kc7YqllYX3IWoNPJ8jEUQ34
	tziLeCuQFP/EylE1Ag6NvqVVGPmfBzroDptOn54YZaOBp45Q8sEKyKJGLjyXmdRqs/1MG6xt+9V
	rn5RcVXbNbk3y1oHnzrU5N8zmhTuZzSD3EZJif9qcCO1501O2jVEme73uz1R86O4=
X-Received: by 2002:a05:690c:dd5:b0:7bd:882a:43e0 with SMTP id 00721157ae682-7bdac599075mr9047147b3.27.1777937263380;
        Mon, 04 May 2026 16:27:43 -0700 (PDT)
X-Received: by 2002:a05:690c:dd5:b0:7bd:882a:43e0 with SMTP id 00721157ae682-7bdac599075mr9046887b3.27.1777937262923;
        Mon, 04 May 2026 16:27:42 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd6652dae3sm55907087b3.8.2026.05.04.16.27.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:27:42 -0700 (PDT)
Message-ID: <2a12f80d489dbf0a5a128294a95e9181e607a5db.camel@redhat.com>
Subject: Re: [PATCH 1/3] hfs/hfsplus: fix u32 overflow in
 check_and_correct_requested_length
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>, 
	syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com, 
	syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
Date: Mon, 04 May 2026 16:27:40 -0700
In-Reply-To: <20260501110218.29906-1-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 52B7E4C4CE1
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243931-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com,physik.fu-berlin.de,vivo.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	DKIM_TRACE(0.00)[redhat.com:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,6df204b70bf3261691c5,e76bf3d19b85350571ac];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,syzkaller.appspot.com:url,appspotmail.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Fri, 2026-05-01 at 11:02 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> check_and_correct_requested_length() compares (off + len) against
> node_size using u32 arithmetic.  When the caller passes a large len
> value (e.g. from an underflowed subtraction in hfs_brec_remove()),
> off + len can wrap past 2^32 and produce a small result, causing the
> bounds check to pass when it should fail.
>=20
> For example, with off=3D14 and len=3D0xFFFFFFF2 (underflowed from
> data_off - keyoffset - size in hfs_brec_remove), off + len wraps to 6,
> which is less than a typical node_size of 512, so the check passes and
> the subsequent memmove reads ~4GB past the node buffer.
>=20
> Fix this by comparing len against (node_size - off) instead.  Since
> is_bnode_offset_valid() already guarantees off < node_size before this
> point, the subtraction cannot underflow.
>=20
> Reported-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D6df204b70bf3261691c5
> Tested-by: syzbot+6df204b70bf3261691c5@syzkaller.appspotmail.com
> Reported-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3De76bf3d19b85350571ac
> Tested-by: syzbot+e76bf3d19b85350571ac@syzkaller.appspotmail.com
> Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c          | 2 +-
>  fs/hfsplus/hfsplus_fs.h | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 13d58c51fc46b..c00645a4a5733 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -41,7 +41,7 @@ u32 check_and_correct_requested_length(struct hfs_bnode=
 *node, u32 off, u32 len)
> =20
>  	node_size =3D node->tree->node_size;
> =20
> -	if ((off + len) > node_size) {
> +	if (len > node_size - off) {

I don't agree with likewise change. Probably, we need to have:

(u64)off + len

Thanks,
Slava.

>  		u32 new_len =3D node_size - off;
> =20
>  		pr_err("requested length has been corrected: "
> diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
> index 3545b8dbf11c5..10b2dda3f8044 100644
> --- a/fs/hfsplus/hfsplus_fs.h
> +++ b/fs/hfsplus/hfsplus_fs.h
> @@ -600,7 +600,7 @@ u32 check_and_correct_requested_length(struct hfs_bno=
de *node, u32 off, u32 len)
> =20
>  	node_size =3D node->tree->node_size;
> =20
> -	if ((off + len) > node_size) {
> +	if (len > node_size - off) {
>  		u32 new_len =3D node_size - off;
> =20
>  		pr_err("requested length has been corrected: "


