Return-Path: <stable+bounces-240380-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BdGIgUc6Wm7UQIAu9opvQ
	(envelope-from <stable+bounces-240380-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:05:41 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0AD244A03F
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 21:05:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B5E4F300AB18
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 19:05:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CE213603F7;
	Wed, 22 Apr 2026 19:05:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H4P8N4vs";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="IOSd9Eig"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA85A346E54
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 19:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776884730; cv=none; b=NfYZXbFBBuASzE6fNQ99nnebMWw+KuoQS1StW1b2K+DydNP6ifB48KbGuVkKO6T+0TK2ISxEQvTHi5Kl6RxR1m3XYr3Qq3HhWIb/lnchwGsXyVWG9ZSYoyyWva04/yz6MG0W3DRZFUwyzBeCze6JNqILy7doc5nYzdSyq8C2Uos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776884730; c=relaxed/simple;
	bh=Tz3hhX5x+6vq9gkHGTZMedq2MVdkGKiJWeelP5fat0c=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=hH2F3GuGRTwxP760rN0UrZNMF8uu+QGijzVZuw8bOiHFYPv2VR1QJ8WFtasKutZKI2Av1XEEbQp+q/tQQFUh1c4XB5sy8jgsBXJ07vLYTXVtQmxPrMWkTV+QiX/Fu60YQV6T0ZdWNqJ936ckcGSJm5gJ5l+BPUB5Ui8T9VmitOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H4P8N4vs; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=IOSd9Eig; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776884715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qdmwawli/VQb0uXVhY3lVbW18VGZ4FsWwRRf0cqAFUQ=;
	b=H4P8N4vsSxEL1yGbdwe/UTWyyrfI7OYqI+sLIcUqm2hZ32+mn1AJbxJVXJC440r2SgiHJX
	PsymYtBkaru8I5RSLG5Xp/3XhKYx2t52IyIaswGZ07LkUebCqa2zyml9B0yJV7Dt2tR82c
	ERxGKPuilhd/ln1cicq2+m7gTD9VreY=
Received: from mail-oi1-f198.google.com (mail-oi1-f198.google.com
 [209.85.167.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-u2Ty1jZyMrS4dMWQBxAvoA-1; Wed, 22 Apr 2026 15:05:13 -0400
X-MC-Unique: u2Ty1jZyMrS4dMWQBxAvoA-1
X-Mimecast-MFC-AGG-ID: u2Ty1jZyMrS4dMWQBxAvoA_1776884712
Received: by mail-oi1-f198.google.com with SMTP id 5614622812f47-46fec31defdso9601845b6e.0
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776884712; x=1777489512; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qdmwawli/VQb0uXVhY3lVbW18VGZ4FsWwRRf0cqAFUQ=;
        b=IOSd9EigKPcZ1clLdaXJHrlMLwWAOVmHCz55mDHh8kioJAYYB5OumqGF4K8hkttG+D
         DDu+H7gO0krhwYhWPVdrlAngyqrNAx9A77O4pCv1WIAACD1cjYFwKsqBwUMBoGGUKEkd
         DVGtTgUdy1jTb8pFxwO7Ou3mvn4InAIorDTMBKYmk7RSXqhoX/y1he8Kl6AItIF6COlM
         DswE1iQ7TS70cOsHmMF1SIySR/9v333W/dY62eGmFZQmFe1p2bxDF+G2Zrjr05n5Ervl
         n8bQNZvIMXK8dXgiybtNQWQBRlT5aBiZftjgl915NeeQxlRf/+WkZ2miNDjvC6uKBP+m
         XfYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776884712; x=1777489512;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qdmwawli/VQb0uXVhY3lVbW18VGZ4FsWwRRf0cqAFUQ=;
        b=o3sFCNR6HB39QBxAdFFMVjMSv1XOtTe22gWlqeBNToQ+5cgSFgwKKawkK7o8YGAasU
         mxmGOvA5GGt0PJDGkFKt5/KXnZYywLAnH9AoQz8KJFX9VrtsqVCLyIHRoInjqTAa1I9N
         CS6icP0RW6fbFYLRaiO4omvOVwMIL3VuBVPUuHmgWGGMgl56wyEMjD5aRRUXMaKveLYf
         WuW2Fys+V7DKQaaTGPJWCtpS9812ALUUQhtGHNnUE/AO4fVovktSz3feBJnlu4xn32IT
         Xs00pFyM91ah8La7DCPFfThFP4WmWdNHEPbja0oIIvuFCsTXYS0gDu755qwON5ke9Hpk
         UT0w==
X-Forwarded-Encrypted: i=1; AFNElJ8kQRC8N0OM1wg47L6OGyO1jBlPFNTa/jNKwYTSJt+tKtpwXdfjeCZa8QYE/0vfb+l3wJe4vAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyESFPvtpiOBSpvsivKvP+1m8WsOCNdz/G11GAwyogqiqCqIw/X
	/bpiCY4Q9wlD5VeZdqpAybVt3R3tcKCO3pouBSvY5AcbI/YA/ZEle4rMgkGFM3ehxWayvBaPVp1
	IAlBY77JQFxIaLx6bXYJWaxMf1kBbIMPGY9bYcRBmMNqeyk3g/qBkfJZ5vabZ8HdMNg==
X-Gm-Gg: AeBDieujzD1KUROCVvb0p1SzVKYAGtCgXsYGmZuENr4p01M4LzvGKTeOf/4xkuOpby/
	k5aa//ffuTaqgf66BZAuipzM7MMLaL2N+lzMCiWli/TvMEnmgEn9iT5j8VbqAcmOcBs6VwYxUya
	fNELfOIQDIFTEXSoOetT3N23vxAHtDSnOr9fLSJOorJSAkBESbelvQZ0QPycWfhazFP6hKluLJU
	ygJRqMYd/jTfAB8QpW3CqkbFuwGOYrZSij6Le4wYqsxlzgPZ5vBs411XbEw9xhCNMrcLTWpn0QL
	OVlrXCL/l72oC5DP1+iPsT8H8fhCFnFYNgGPyWv1QBcpw9z+ltPfiRrCw06mBGE4Tfgh1RNAiuB
	YlHU25UZMNDyoj+uRJNd+D25Va7aycvMIfweKoEFmnlXBx09sfhcCm2ZU9kHdplM=
X-Received: by 2002:a05:6808:158f:b0:479:ec96:f4de with SMTP id 5614622812f47-479ec97413amr4506888b6e.2.1776884712031;
        Wed, 22 Apr 2026 12:05:12 -0700 (PDT)
X-Received: by 2002:a05:6808:158f:b0:479:ec96:f4de with SMTP id 5614622812f47-479ec97413amr4506875b6e.2.1776884711604;
        Wed, 22 Apr 2026 12:05:11 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-42c05ca16e2sm7973157fac.15.2026.04.22.12.05.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 12:05:11 -0700 (PDT)
Message-ID: <44cc78470b0b550d24bba9d159ebe1e07e2ef9c5.camel@redhat.com>
Subject: Re: [PATCH] hfsplus: zero-initialize buffer in hfs_bnode_read
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org,
 syzbot+217eb327242d08197efb@syzkaller.appspotmail.com,  Tristan Madani
 <tristan@talencesecurity.com>
Date: Wed, 22 Apr 2026 12:05:10 -0700
In-Reply-To: <20260418134003.1719393-1-tristan@talencesecurity.com>
References: <20260418134003.1719393-1-tristan@talencesecurity.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43app2) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com,physik.fu-berlin.de,vivo.com];
	TAGGED_FROM(0.00)[bounces-240380-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,217eb327242d08197efb];
	DBL_BLOCKED_OPENRESOLVER(0.00)[appspotmail.com:email,syzkaller.appspot.com:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E0AD244A03F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-04-18 at 13:40 +0000, Tristan Madani wrote:
> hfs_bnode_read() can return early without initializing the output
> buffer when the offset is invalid or the requested length is
> corrected to zero by check_and_correct_requested_length().  Callers
> such as hfs_bnode_read_u16() pass stack-allocated buffers and use the
> result unconditionally, leading to KMSAN uninit-value reports.
>=20
> Rather than initializing at each individual call site, zero the buffer
> at the start of hfs_bnode_read() before any validation checks.  This
> ensures the buffer is always in a known state regardless of which
> early-return path is taken.
>=20
> Reported-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Tested-by: syzbot+217eb327242d08197efb@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D217eb327242d08197efb
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfsplus/bnode.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/fs/hfsplus/bnode.c b/fs/hfsplus/bnode.c
> index f8b5a8ae58ff5..14d1af2c7ba93 100644
> --- a/fs/hfsplus/bnode.c
> +++ b/fs/hfsplus/bnode.c
> @@ -25,6 +25,8 @@ void hfs_bnode_read(struct hfs_bnode *node, void *buf, =
u32 off, u32 len)
>  	struct page **pagep;
>  	u32 l;
> =20
> +	memset(buf, 0, len);
> +

The patch looks good. However, I have this point in my mind. Let's imagine =
that
we receive a valid buf pointer but len is 0. It sounds to me that memset()
simply will do nothing. But if buffer has not zero length, then it means th=
at we
have no initialization again. What do you think?

>  	if (!is_bnode_offset_valid(node, off))
>  		return;
> =20

I assume that this is a second version of the patch. You can use this comma=
nd to
add version to the patch: 'git format-patch -v2 -1 HEAD', for example. Fran=
kly
speaking, the patch without version looks slightly confusing for my taste. =
:)

Thanks,
Slava.


