Return-Path: <stable+bounces-238522-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EGDzCtqx4mna9AAAu9opvQ
	(envelope-from <stable+bounces-238522-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:19:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B82441EDC6
	for <lists+stable@lfdr.de>; Sat, 18 Apr 2026 00:19:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 34B12300E268
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 22:19:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9BB60331A46;
	Fri, 17 Apr 2026 22:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H1GvEIgS";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="fx2p+Vhc"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0BB313298
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 22:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776464337; cv=none; b=aNW0Djriw2J4jjfZMUdqJ5XazeyIinVBGF+62PxKuRiGc+E8NzVdKmvEJTNrxe0GHP3p59M0L06DhjqEIvJBPG80bPkv8lKOIHv3lzEPU/Rcrv39XJSxj5ReM6oYl32KmA7be6uHxcBwZLlSxXBcBWg9JoJm3vYMO+Z3tOmOGHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776464337; c=relaxed/simple;
	bh=x2ltSZwWwG16qGDDXnqqZkOPdWpby5TntvRFz/1Hh3E=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=I43Kp8OIqUeHmPtFtrMLfx2KMG5N56w4nWPXNRDIDfcM2WM87sZjKIgLDUlQ0aqPPGLMmBBeW8gxaNPZhCTKCmZX2iDw9tiXB25fVCJwgOeCp7+lkpfieocZAWl+v4OoRKxdwmRP4ochYZRrr9rXUBUY09wqCDCrVqt8ZGh5W6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H1GvEIgS; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=fx2p+Vhc; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776464335;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TkwTWh53bAvy7ale2RIwDuDgsVj+kc+55FasuLmjA4=;
	b=H1GvEIgSYHddB6SKcEZaN8S0iWwiottSMbvXY3+xmEzoP1MC1Djp8NTFsTI9R5sRDMMjEQ
	+aXIeTvfieCqoFhTAFZN+2Tz2+8ILZKACl95nJNQiUq67sAa3W5ikoiaXyiXECblcszU78
	Oc6mOnh8qICHknoBTfyPmdSYC28hNGY=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590-dXUyKs39N1qXmlwWHn039A-1; Fri, 17 Apr 2026 18:18:52 -0400
X-MC-Unique: dXUyKs39N1qXmlwWHn039A-1
X-Mimecast-MFC-AGG-ID: dXUyKs39N1qXmlwWHn039A_1776464331
Received: by mail-yw1-f197.google.com with SMTP id 00721157ae682-799003e8a77so37432127b3.2
        for <stable@vger.kernel.org>; Fri, 17 Apr 2026 15:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776464331; x=1777069131; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2TkwTWh53bAvy7ale2RIwDuDgsVj+kc+55FasuLmjA4=;
        b=fx2p+VhcTXOxX9Qzvvhwzqyg/YI8VHDcuWYQT/FJ0Hk/JNq7QPoW91I2VXYsYJSgQ2
         HS0DbDW0MQd2t1WGmz44WljWS+D1LC1CepWV+VVqiS7K9pAw1lkTE2MGvEvS2+pEYbfW
         x/6fiGx862ePYcaIk8nCAI5Im3r/ng/Oe4n11EWny+j+BNfpJpUCTwy9wnBZ3neEC8Gm
         FixWxaUqaqdYQwHfEddWmSJi6j10ZTfpu6QVm3jdmb4zzXX7X42vVRU4yWgW1QGlXkUX
         gc4fnlYLVhHaorNMnPjGSxRmTJXNxG3TVYm4UY4ougXU2SVp5gc7rMj2XhSLONsNQBPi
         FD5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776464331; x=1777069131;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2TkwTWh53bAvy7ale2RIwDuDgsVj+kc+55FasuLmjA4=;
        b=aT0pSKidEs/8QtdJxLAwLczm0V1ij79UlZWhjhLIzZ5T8Y6u9+4CLde0pt6RlZXdwt
         GKAHF76curxtbvkgaZlUBAMCwUG9IQc5oV67tOuSGYfCLlE4DUtU7Y9bBlCd2UevSjjs
         mtfg9eJEr0kEwRBz9XhqpccZ3YvNqA/IwdxdDYdXgY8PKV3yddemg96kNH3dmkJSfAmH
         K+4t7A7gNbAcB9c6FWXdg5LBEXPhLwKuI+WTpPL0YGoQpNPE78lxiUnUQuVz/iUwje14
         9D0NRmSWhkjHBSiX/35uTyWWH7X9/tuTc4Mqkivah3PRmmCZDCZdCZb29fta1CgeUsiH
         URlw==
X-Forwarded-Encrypted: i=1; AFNElJ8SIqsCEeyW6pPAl2AZoSd+oK7yA2JM51KReHaoX6RoJN0fTIcWsoSd91vQFJEcBcwYWGDzQp4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxoYUsSnRVqskY0Sk+XotEmfL3+QjWrz9W6V4BHC+U3utMOmONs
	G6fzRdMYRgMvlVWeeg+xyB9dwMcECNQc+DMrgyq4uoouUDgiMAh/pxEtOaz95qx2kPs9zkycjU7
	ZRXn1hLmFIIccU0YZh8zW1GEvpuvcpMVpx3cY4WYuDRWEV+L0GVjvw19IWw==
X-Gm-Gg: AeBDievjyznH2nS/FSzswjzZ1ROG5+nQ+DT+xV/ATdKPj7WwhQczvHBlB1/tZhwY4SA
	tm0ON2lkzUjKBA3zhGHpjqWn5Yx1jYcOJtGvmNlEYdZYH6EHyVqoyb0zvrSwfAkQbWmQ06EtyAo
	N4VDxQ7/u89VdrDTQRdw6qqtaBywBgdB1n2aH23OGTLlLsvHeb0h7eqUQguHJmbQ0JJpsm3ZLam
	80XDhlmlCKINJULyX1rd5/diJn8OWNEUeW07+pkJN/heQzdUw0NBiNd3bjDiiLomlEcNTL1DAT1
	NONAYsEudeKuNff2/cs5KAkrBgVmXcfqpGDQBGOGBkV2vr9yRzOhVdfLted5g1ER7AdM0Kfg2++
	+vfA8sKBn4ZRTtWJJr1auBKAB12iRq5yEqrLQNdbaMOyNAAVlXoXxUOMf4JSTwxw=
X-Received: by 2002:a05:690c:60c3:b0:7a2:1f26:3d6a with SMTP id 00721157ae682-7b9ed00a78dmr50596067b3.45.1776464331521;
        Fri, 17 Apr 2026 15:18:51 -0700 (PDT)
X-Received: by 2002:a05:690c:60c3:b0:7a2:1f26:3d6a with SMTP id 00721157ae682-7b9ed00a78dmr50595847b3.45.1776464331001;
        Fri, 17 Apr 2026 15:18:51 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-7b9ee9b0463sm13106777b3.35.2026.04.17.15.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 15:18:50 -0700 (PDT)
Message-ID: <c3bf88025e3213b22d2bcc32213e52e2157e1616.camel@redhat.com>
Subject: Re: [PATCH] hfs: return error when bnode already hashed in
 hfs_bnode_create
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Andrew Morton
	 <akpm@linux-foundation.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com,
 stable@vger.kernel.org,  Tristan Madani <tristan@talencesecurity.com>,
 Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Date: Fri, 17 Apr 2026 15:18:49 -0700
In-Reply-To: <20260417185920.182595-1-tristan@talencesecurity.com>
References: <20260417185920.182595-1-tristan@talencesecurity.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,linux-foundation.org];
	TAGGED_FROM(0.00)[bounces-238522-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,a19ca73b21fe8bc69101];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email]
X-Rspamd-Queue-Id: 9B82441EDC6
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 2026-04-17 at 18:59 +0000, Tristan Madani wrote:
> hfs_bnode_create() checks if the requested node number is already
> present in the B-tree hash table.  If it is, the function emits a
> WARN_ON(1) and returns the existing node:
>=20
>     if (node) {
>         pr_crit("new node %u already hashed?\n", num);
>         WARN_ON(1);
>         return node;
>     }
>=20
> On crafted HFS images with inconsistent B-tree bitmap data, the
> allocator can repeatedly request creation of node 0 which is
> already hashed, triggering this WARNING reliably on every mkdir.
>=20
> Replace the WARN_ON with an error return.  The node being already
> hashed when creation is requested indicates filesystem corruption
> -- returning ERR_PTR(-EIO) allows the caller to handle this
> gracefully rather than generating a kernel stack trace.
>=20
> Reported-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
> Tested-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da19ca73b21fe8bc69101
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index e8cd1a31f247..69895ccf81ef 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -517,8 +517,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *=
tree, u32 num)
>  	spin_unlock(&tree->hash_lock);
>  	if (node) {
>  		pr_crit("new node %u already hashed?\n", num);
> -		WARN_ON(1);
> -		return node;
> +		return ERR_PTR(-EIO);

We return -EEXISTS in HFS+ because it is the case of node existence [1].

This issue takes place because of node 0 has been set in bitmap as not
available. However, every HFS/HFS+ b-tree must have this node. We already
implemented this check for HFS+. I would like to ask you to port this check=
 for
the case of HFS [2].

Thanks,
Slava.

>  	}
>  	node =3D __hfs_bnode_create(tree, num);
>  	if (!node)

[1]
https://lore.kernel.org/linux-fsdevel/08e7f7ef7da57448945a8d62160d2d7a67df2=
883.camel@ibm.com/
[2]
https://lore.kernel.org/linux-fsdevel/43be87e694ed6fe291990226624559e7f0182=
0d9.camel@dubeyko.com/


