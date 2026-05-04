Return-Path: <stable+bounces-243934-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AHaTAOgr+Wkq6QIAu9opvQ
	(envelope-from <stable+bounces-243934-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:29:44 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 010D74C4D33
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id D19C130091FD
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 23:29:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C42E93D3486;
	Mon,  4 May 2026 23:29:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h92yLmBp";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="MxkhQDiK"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABDF3D1704
	for <stable@vger.kernel.org>; Mon,  4 May 2026 23:29:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937378; cv=none; b=uBnHbHuXG7Nvsd4Zpdt8VOlXtuwSMm7iB7qSruV390I4WAQHj1FMpp+nSnnAGwtv7WEhBTdjpviLuqm4gGOqVyiwgab7PTK4eXCVPtIeOFjFkyDGlcVpy5dH8gniNa9ArzJKfbni3mfdlhlcDQcsI7zSHi4+FKkJui2+jFkkdF8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937378; c=relaxed/simple;
	bh=VB/VZVOuWxM7Vs4MaYara4db9BUPG7xgRiAmNS6PBh4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=HFcCqXb+feugrQHzssl3rQC5MyIxAhF6Gs3nQbOo9zMDSvn/ixgLdBzazmV+0j8zTqIjIrcJ7qbt8qEbnVQa147B57uukvCS7xLAWAc3zAC2Jh+tgpMnZM2V9Q/F31pAYT0o6ViXsVx46FoG/zEglZ8Bq3qwgZ/ZfESw/bA5Cp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=h92yLmBp; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=MxkhQDiK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777937376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oMJ6qLGsbY/8TJJVB5qBWJI8imsazXiBmcRxjMiEVbc=;
	b=h92yLmBpTgXrgIJdmNPHbBbbuAyWFi89CxGtMVXZip3X3RWPINCGiALZVlobLNSOVIxEte
	Sl7GlskcLRRG65WTYMalAbmpO6JOwX3S2FixLK9O75TnyAMMPjtdUBfHM2yXQulvpvq5S5
	ImkR6tz5kxgpQj0Dk3wEOjzBVx14oBM=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-gn7rR0x8MKegPv41zRSIRQ-1; Mon, 04 May 2026 19:29:35 -0400
X-MC-Unique: gn7rR0x8MKegPv41zRSIRQ-1
X-Mimecast-MFC-AGG-ID: gn7rR0x8MKegPv41zRSIRQ_1777937375
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-79064868702so5967497b3.3
        for <stable@vger.kernel.org>; Mon, 04 May 2026 16:29:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777937374; x=1778542174; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=oMJ6qLGsbY/8TJJVB5qBWJI8imsazXiBmcRxjMiEVbc=;
        b=MxkhQDiKXqkTHkU03JhOUN8PGEBQCmoU77fFPhrTSthYkN5h7F+2JAXuZYxTnP5jy6
         nIAvDIsqe7fPiBW8Tv64y9b6a2X/10ru9ZwdT5VRSoKMAwFWDcHBTnBaMGsnVwP1kUWS
         Pt54rqy4Ciu26+7yFVOft5HVIKgbxoTER4Vh4/xdQaBQlpkQ8BvjcpUlEZrWH3NQ1CqR
         BhSOX++0fh/qbELUExn+jcDoy7gSddCNwb5BJLoVCfBw1ClCn0aiy+G7lI4MF010DEhr
         AMFaO4GIG2cqNKVxjC/+WFLy01lmi2KMuxh6yWFCcxAJPP1c5DZlI7HZf7BvLAL0EFSY
         KXsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777937374; x=1778542174;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oMJ6qLGsbY/8TJJVB5qBWJI8imsazXiBmcRxjMiEVbc=;
        b=ks9tdo4E7qc4yJecvPBwJP+TxnZshveLs+cJi5wNGnU193cYHJG2SHrt9uQxYeHxZ6
         4YkKZUBDfdCWkUR9o0QFWieYxJ0wFsNHhpRxaOpd3P8pySINWW60K4+cRQA7Obd9l/si
         UsHEJ1LILHigo0HnR+8v2qKqW8iDoMzZ5057y35ShZwn0woWn+jcaM48P0PM8hKUC1NT
         iZhdU331Toenkfj2rOvSwddHcUb8tr7NwY758Q8KbZQkdaet4quLKi4bcLcbggILDjwx
         3UmzIOyNUrOvIXZhuQX3YGvj8Tz8wLWxLqTvuQ3/DrE0yvk1wm/rcMcPtMlpE2Jh+++Y
         oN+w==
X-Forwarded-Encrypted: i=1; AFNElJ/g5xKMUdtpX/O8be5IQrmUvLRKd+8ABXoflgZFh0Kk4OIJ3pbTi4xe7IR0C5NmWZiG8wVYfLI=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoW/hAnPlcjjoylxIiCEObHKLf4ot9foxa4IpIIdCF4qi9tptK
	oKO9+cz+bFbRJ1UE/woPOvhH/UT/wvZ7dsJJEWnDaVGjAF6EskhGC6KUWDHRRnGCGFV83fDeWNw
	E8GF5u2P12sO02ERkxJo6R7hjzEDb5wKKQ0gHfhrYyFi/2ByaLT2RPm9FTiGinX3/tw==
X-Gm-Gg: AeBDieut+/L7/ZeR9itL2K/lVJcEY1wOlexFKgL+Oygt7CW96W5nHILcoEI+qMNLBvw
	z2ATAj29wjsPvMFJ45omO6uvLkP7TLV7GrSPwTm26IXo5e8C7JKFycAvHVJnwDDwWHdp4fwFvaZ
	5tLVd2k/xzCD0ZaPGmECk/iRS4h7NOnVnmkYKG3OFbihr261xSCXX2h1WOgiryJ8NITFwvHvB0J
	+ejRyX09IV2WBY8E4tWBGxra3NvCWiAeyBOq8KU9QBkbqDgg0ljcSIoDq2ltiTGFT7i1YlyUhdh
	9iQb3aaPcgOgRKc4Cyqdz/oi4sEme/NjrPafAMncHyWDTujxh3ly7FrG1dsEjcY1YYbBxM4fZ8g
	4Gh6e5JtwTqQOj+ZBxBFQGqoLF4KNIVAr9Ek6+iHpUKpe9tHK6X5+l9k4yAHsiXc=
X-Received: by 2002:a05:690c:c501:b0:7ba:fd82:9131 with SMTP id 00721157ae682-7bdac640431mr9347987b3.47.1777937374236;
        Mon, 04 May 2026 16:29:34 -0700 (PDT)
X-Received: by 2002:a05:690c:c501:b0:7ba:fd82:9131 with SMTP id 00721157ae682-7bdac640431mr9347667b3.47.1777937373502;
        Mon, 04 May 2026 16:29:33 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7bd7d849afesm37183217b3.49.2026.05.04.16.29.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:29:33 -0700 (PDT)
Message-ID: <af5d510b2204484b414474c5b92c8654908c4db3.camel@redhat.com>
Subject: Re: [PATCH 2/3] hfs/hfsplus: initialize data buffer in
 hfs_bnode_read_u16 and hfs_bnode_read_u8
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>, 
	syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
Date: Mon, 04 May 2026 16:29:31 -0700
In-Reply-To: <20260501110218.29906-2-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
	 <20260501110218.29906-2-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 010D74C4D33
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243934-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,217eb327242d08197efb];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talencesecurity.com:email,syzkaller.appspot.com:url,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,appspotmail.com:email]

On Fri, 2026-05-01 at 11:02 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> hfs_bnode_read_u16() and hfs_bnode_read_u8() declare local data buffers
> without initialization, then pass them to hfs_bnode_read().  If
> is_bnode_offset_valid() fails inside hfs_bnode_read(), the function
> returns early without writing to the buffer, leaving it uninitialized.
> The caller then returns the garbage value to its caller.
>=20
> This triggers KMSAN uninit-value reports when a corrupted HFS+ image
> has a node_size of 1, causing rec_off to underflow in hfs_bnode_find()
> and the subsequent hfs_bnode_read_u16() to operate on an invalid offset.
>=20
> Zero-initialize both buffers so that callers get a deterministic zero
> value when the underlying read fails.
>=20
> Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D217eb327242d08197efb
> Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Fixes: a431930c9bac ("hfs: fix slab-out-of-bounds in hfs_bnode_read()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c     | 4 ++--
>  fs/hfsplus/bnode.c | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index c00645a4a5733..08307faea7a68 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -97,7 +97,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, =
u32 off, u32 len)
> =20
>  u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
>  {
> -	__be16 data;
> +	__be16 data =3D 0;
>  	// optimize later...
>  	hfs_bnode_read(node, &data, off, 2);
>  	return be16_to_cpu(data);
> @@ -105,7 +105,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 of=
f)
> =20
>  u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
>  {
> -	u8 data;
> +	u8 data =3D 0;
>  	// optimize later...
>  	hfs_bnode_read(node, &data, off, 1);
>  	return data;
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index f8b5a8ae58ff5..35790085b5b2e 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -55,7 +55,7 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, =
u32 off, u32 len)
> =20
>  u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
>  {
> -	__be16 data;
> +	__be16 data =3D 0;
>  	/* TODO: optimize later... */
>  	hfs_bnode_read(node, &data, off, 2);
>  	return be16_to_cpu(data);
> @@ -63,7 +63,7 @@ u16 hfs_bnode_read_u16(struct hfs_bnode *node, u32 off)
> =20
>  u8 hfs_bnode_read_u8(struct hfs_bnode *node, u32 off)
>  {
> -	u8 data;
> +	u8 data =3D 0;
>  	/* TODO: optimize later... */
>  	hfs_bnode_read(node, &data, off, 1);
>  	return data;

If I remember correctly, I already shared that hfs_bnode_read() is called i=
n
multiple places. So, this patch is not enough for complete fix of the issue=
.

Thanks,
Slava.


