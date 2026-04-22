Return-Path: <stable+bounces-240396-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id JTuBBjBU6Wk7XwIAu9opvQ
	(envelope-from <stable+bounces-240396-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 01:05:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9750D44B641
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 01:05:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7169C300E5B9
	for <lists+stable@lfdr.de>; Wed, 22 Apr 2026 23:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C768347BD7;
	Wed, 22 Apr 2026 23:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YmDyoeAq";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="noEnxwnV"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 999C92BFC60
	for <stable@vger.kernel.org>; Wed, 22 Apr 2026 23:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776899115; cv=none; b=TgrYhXSEIg98dW3BmPxRtXk4pr4vHgS1p5X4Yy1/yBi6qUwtla/iHUm93FaXSEV2CIMeHTsphEl8JRX3FYYVsiBNClmJ35fjXPi5GTwQuhIo0kPcE9r/THe+fhsXzE9hylT0+VKW4JBw7AQlfOrCnL4XU7y8EkbHlX8N4WD2src=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776899115; c=relaxed/simple;
	bh=thLiyIcNke4TCPMCu3CUKpsUc5eDoR3oMMoAXIyJAkE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Y8B/QLPJ65JyH7FCFsPJQzsIfr5LjzAqDE+4+YGQTsk2L6/tgELMb38VymxnQcYfF3SbPxHdTY/iDgwSFu3QXGa6VTkjfj7XIs0OxMqwyZDE1Pb+SSmWHIuyHAVSUOrQmNifNMabAvLLO5Nz4VJDZM3VmsJ52qVfybKvr19XivQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YmDyoeAq; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=noEnxwnV; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776899112;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=z/Yb5z7akaYaPjtq31YYTPejINDkMWFksvY9tqU2bIs=;
	b=YmDyoeAqf1YFktXbXsWDhk43FJld1XVB+Qp9YG37GnuRARyCiSflzhfqoj0vPKOQhpx2jj
	RHRsjOf9X23S45oFUwh9P7b1qe+56brTaS4SGNwe1knQZnFiR8Wb5WZL0OLuwVkRBgrJvl
	m/jFHXZ3dVNL64dRCjOcx6zAQx7HUCA=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-BRCSVJF2OuSLn6ZVCM-WRg-1; Wed, 22 Apr 2026 19:05:11 -0400
X-MC-Unique: BRCSVJF2OuSLn6ZVCM-WRg-1
X-Mimecast-MFC-AGG-ID: BRCSVJF2OuSLn6ZVCM-WRg_1776899111
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-4793e70895cso8694984b6e.2
        for <stable@vger.kernel.org>; Wed, 22 Apr 2026 16:05:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1776899111; x=1777503911; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=z/Yb5z7akaYaPjtq31YYTPejINDkMWFksvY9tqU2bIs=;
        b=noEnxwnV4X74ST3vxxlsDPrn1LbcqNqVqBuhlXXrcuke9BGjVsCZmaBH5zivy8jUWp
         rWUnWn9Ywa0MjOHgZCdV4fBPz852NWRv1YbD01tnXhbNCI2F7aaSzuAmH+XqHO4F5jJw
         lmr5hvhwVfo+zhZboDlY7xt6+vmgzsAuZDS2CDLSf/zicJSq17eUGASXJH74hiTbSB6I
         d3QX/0sJRARM/dyMIktW3cp3O02Xw59wdD1tDrIcqS9vD3dnnIAsKxWPz7KoTeGMHgvG
         W7Ra7duZZVw+y8rzTcuePMDZ9sRln/KPfWeYPSS9mVxvVRdS6XblJhVgYxPuZ35AGTYQ
         GUBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776899111; x=1777503911;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=z/Yb5z7akaYaPjtq31YYTPejINDkMWFksvY9tqU2bIs=;
        b=iTDTFhsiiSg5yGniv3KuJk3PeFMsBLH3Hm7LvF94m3ivhEoVEzX6bVcM83LD2dFWcE
         Cds2YIBFF/5TAquvXAArhG3KXEP9USMOIEuZbQJdOMogZBExXCtVXmXQHQewsrkdGT3J
         u/kJv0CSgv+GowHbKG+AaqiX1i4RpktwWNwZ4Z9JWlf9p4SIh3+QtX2S8OYg8MUbQ+Gx
         vdH91tFm9+BTg6glNARpDowWKOIQNoT3bQAehPoRhgYIiW+EunhMCYrZq3cPZ5riQgol
         qaUIiaIfwWWk2RBM/ttbklID+0O8d65wXSktWpOeFTmQ5OA4cNZ7brIzQGvuah7cj+ga
         fJrA==
X-Forwarded-Encrypted: i=1; AFNElJ/wNDTcRuQPuVhz+UnU8V96HgLiiYgSMPifiyXraDF5qpPsPSKR10UM2I/1AvelKve4mEujF50=@vger.kernel.org
X-Gm-Message-State: AOJu0YxIypgbxVU0KFw4qyVLkoxsVaMtTkXr/RzsN2A8liUm0k6xsjzh
	nK/F+euHZgE/BRDXNYxZxjC//z9OX3RtHFcU6RXLZovKE6c5bco6rKeEO2am/eFS1y0sGYrtGiL
	l6V/Kgu6btcSw8p73FPikMryAKpK2cQB/1aE2eDMhXFgZKaf6e/2MZGgFsw==
X-Gm-Gg: AeBDietKFCwJisTAfCS4R3XRcECLRReILCT2WDv3Oi5h48+X5wSiPeelvBNbPfen9xP
	8cdCFRumVS3SEz7Pe1/HFkgb/SujATzGiLLncCXg8j2HSJFhK34TKdHr8NzSVl6mVH1w2Kc9J2P
	Ug/LbtNHb+s0+AhckCzqFIrP2dowZSlaHK7VuGL5eJQlAdfHzmDj25Dfjoj/7mv3aipFPf+g/Ua
	rzHPRS9ZczZul0eKKdjbxO9ETyxMDKNR9kk4NCfyvrbglFCGBLgA5Nqm0Ac2jC1VlL0MxEoxRDJ
	bEcRVDSCmlA8IkYNMOI2i1xT5LrHQYhjz6/3WXW54aqhLqlHih4CfzRg5nt2h0njxDYWUmPaMIs
	0kE+t7xcmcYrXuRrQqGkBJy6fThRGijsnBDVuM3QZ6jTLpNBLiPlBn+D09tzIiHo=
X-Received: by 2002:a05:6808:8888:b0:479:d57b:839e with SMTP id 5614622812f47-479d57b8c70mr5326081b6e.24.1776899110575;
        Wed, 22 Apr 2026 16:05:10 -0700 (PDT)
X-Received: by 2002:a05:6808:8888:b0:479:d57b:839e with SMTP id 5614622812f47-479d57b8c70mr5326071b6e.24.1776899110107;
        Wed, 22 Apr 2026 16:05:10 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-4799ff36814sm12431712b6e.7.2026.04.22.16.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2026 16:05:09 -0700 (PDT)
Message-ID: <a274aafb30abfee53d81525028ae64ebe9316620.camel@redhat.com>
Subject: Re: [PATCH] hfs: validate bitmap record offset in hfs_bmap_alloc
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, slava@dubeyko.com, 
	glaubitz@physik.fu-berlin.de, frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org, 
	stable@vger.kernel.org,
 syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com,  Tristan Madani
 <tristan@talencesecurity.com>
Date: Wed, 22 Apr 2026 16:05:08 -0700
In-Reply-To: <20260418133949.1713416-1-tristan@talencesecurity.com>
References: <20260418133949.1713416-1-tristan@talencesecurity.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,dubeyko.com,physik.fu-berlin.de,vivo.com];
	TAGGED_FROM(0.00)[bounces-240396-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[vdubeyko@redhat.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,a19ca73b21fe8bc69101];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,talencesecurity.com:email]
X-Rspamd-Queue-Id: 9750D44B641
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sat, 2026-04-18 at 13:39 +0000, Tristan Madani wrote:
> hfs_bmap_alloc() retrieves the bitmap record from the header node
> using hfs_brec_lenoff() but does not validate the returned offset
> and length before using them to compute page pointers.  On a crafted
> HFS image with corrupted B-tree data, the offset can exceed the node
> size, causing an out-of-bounds page access.
>=20
> Additionally, when the bitmap has node 0 bit incorrectly unset,
> hfs_bmap_alloc() calls hfs_bnode_create(tree, 0) for the already-
> hashed header node, triggering a WARN_ON and returning the existing
> node without incrementing its reference count.
>=20
> Port the fixes already applied to HFS+ (commits d8a73cc46c84 and
> 738d5a51864e) to the HFS side:
>=20
> 1. Move is_bnode_offset_valid() and check_and_correct_requested_length()
>    from bnode.c to btree.h so they can be used by btree.c.
>=20
> 2. Validate the record offset and length in hfs_bmap_alloc() before
>    computing page pointers, preventing out-of-bounds access.
>=20
> 3. Return ERR_PTR(-EEXIST) from hfs_bnode_create() when the node is
>    already hashed, properly signaling filesystem corruption to callers.

I assume that we have the second version of the patch again. Am I correct?

> Reported-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
> Tested-by: syzbot+a19ca73b21fe8bc69101@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Da19ca73b21fe8bc69101
> Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfs/bnode.c | 44 +-------------------------------------------
>  fs/hfs/btree.c |  6 ++++++
>  fs/hfs/btree.h | 42 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 49 insertions(+), 43 deletions(-)
>=20
> diff --git a/fs/hfs/bnode.c b/fs/hfs/bnode.c
> index 13d58c51fc46b..26c2e65ab5935 100644
> --- a/fs/hfs/bnode.c
> +++ b/fs/hfs/bnode.c
> @@ -15,48 +15,6 @@
> =20
>  #include "btree.h"
> =20
> -static inline
> -bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
> -{
> -	bool is_valid =3D off < node->tree->node_size;
> -
> -	if (!is_valid) {
> -		pr_err("requested invalid offset: "
> -		       "NODE: id %u, type %#x, height %u, "
> -		       "node_size %u, offset %u\n",
> -		       node->this, node->type, node->height,
> -		       node->tree->node_size, off);
> -	}
> -
> -	return is_valid;
> -}
> -
> -static inline
> -u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, =
u32 len)
> -{
> -	unsigned int node_size;
> -
> -	if (!is_bnode_offset_valid(node, off))
> -		return 0;
> -
> -	node_size =3D node->tree->node_size;
> -
> -	if ((off + len) > node_size) {
> -		u32 new_len =3D node_size - off;
> -
> -		pr_err("requested length has been corrected: "
> -		       "NODE: id %u, type %#x, height %u, "
> -		       "node_size %u, offset %u, "
> -		       "requested_len %u, corrected_len %u\n",
> -		       node->this, node->type, node->height,
> -		       node->tree->node_size, off, len, new_len);
> -
> -		return new_len;
> -	}
> -
> -	return len;
> -}
> -
>  void hfs_bnode_read(struct hfs_bnode *node, void *buf, u32 off, u32 len)
>  {
>  	struct page *page;
> @@ -518,7 +476,7 @@ struct hfs_bnode *hfs_bnode_create(struct hfs_btree *=
tree, u32 num)
>  	if (node) {
>  		pr_crit("new node %u already hashed?\n", num);
>  		WARN_ON(1);
> -		return node;
> +		return ERR_PTR(-EEXIST);
>  	}
>  	node =3D __hfs_bnode_create(tree, num);
>  	if (!node)
> diff --git a/fs/hfs/btree.c b/fs/hfs/btree.c
> index 2eb37a2f64e86..e8bc24c8baf1a 100644
> --- a/fs/hfs/btree.c
> +++ b/fs/hfs/btree.c
> @@ -304,6 +304,12 @@ struct hfs_bnode *hfs_bmap_alloc(struct hfs_btree *t=
ree)
>  	len =3D hfs_brec_lenoff(node, 2, &off16);
>  	off =3D off16;
> =20
> +	if (!is_bnode_offset_valid(node, off)) {
> +		hfs_bnode_put(node);
> +		return ERR_PTR(-EIO);
> +	}
> +	len =3D check_and_correct_requested_length(node, off, len);
> +
>  	off +=3D node->page_offset;
>  	pagep =3D node->page + (off >> PAGE_SHIFT);
>  	data =3D kmap_local_page(*pagep);
> diff --git a/fs/hfs/btree.h b/fs/hfs/btree.h
> index 99be858b24465..6032b14b1639d 100644
> --- a/fs/hfs/btree.h
> +++ b/fs/hfs/btree.h
> @@ -85,6 +85,48 @@ struct hfs_find_data {
>  };
> =20
> =20
> +static inline
> +bool is_bnode_offset_valid(struct hfs_bnode *node, u32 off)
> +{
> +	bool is_valid =3D off < node->tree->node_size;
> +
> +	if (!is_valid) {
> +		pr_err("requested invalid offset: "
> +		       "NODE: id %u, type %#x, height %u, "
> +		       "node_size %u, offset %u\n",
> +		       node->this, node->type, node->height,
> +		       node->tree->node_size, off);
> +	}
> +
> +	return is_valid;
> +}
> +
> +static inline
> +u32 check_and_correct_requested_length(struct hfs_bnode *node, u32 off, =
u32 len)
> +{
> +	unsigned int node_size;
> +
> +	if (!is_bnode_offset_valid(node, off))
> +		return 0;
> +
> +	node_size =3D node->tree->node_size;
> +
> +	if ((off + len) > node_size) {
> +		u32 new_len =3D node_size - off;
> +
> +		pr_err("requested length has been corrected: "
> +		       "NODE: id %u, type %#x, height %u, "
> +		       "node_size %u, offset %u, "
> +		       "requested_len %u, corrected_len %u\n",
> +		       node->this, node->type, node->height,
> +		       node->tree->node_size, off, len, new_len);
> +
> +		return new_len;
> +	}
> +
> +	return len;
> +}
> +
>  /* btree.c */
>  extern struct hfs_btree *hfs_btree_open(struct super_block *sb, u32 id,
>  					btree_keycmp keycmp);

This modification makes sense but I mean the porting of slightly different
functionality. Are you working on it? Or have you missed my point?

Thanks,
Slava.


