Return-Path: <stable+bounces-243935-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aJP6HW0s+Wkq6QIAu9opvQ
	(envelope-from <stable+bounces-243935-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:31:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1094C4D54
	for <lists+stable@lfdr.de>; Tue, 05 May 2026 01:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 88661300614A
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 23:31:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 496163DD51D;
	Mon,  4 May 2026 23:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fhpLAU23";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="Te1uBzM0"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D3432E692
	for <stable@vger.kernel.org>; Mon,  4 May 2026 23:31:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777937513; cv=none; b=M+SP+88S/VGsTwwzuLU+QFg5kWbDepKB8W1nEd90uStGCowHba0j2vi4ul8QnT1I+NTiwbVx/hWRReeMobQMentapkvoemGdhoY7kPcQcsa/uaj8386ejNcJ8WLvK3gTc8DuakFh6+t52Hkq/HsjIO1XBZOgxiW8xJTSxKTMUZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777937513; c=relaxed/simple;
	bh=mLVFdp5TspvCCdHUC34Lqoaa6WJY8K3YQB6d/Orv8/8=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=ZQUXDOm+lPC5BuLH8SE3WpjFFQFNySWOtVXlCI6sPFJ5Q5WrYR/5zQoQXKDsHBZ46u+0ut+VPPWZOn3CY0+GW8KCydxJ18CiNxsNdHu9eeFxNFvXJFDESwk/JcP4uh7O1szlZCi9QpZUbzPazeNiSC8EM2Wjzc1qbyVLliDbpfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fhpLAU23; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=Te1uBzM0; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777937510;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WIdi3Vf7s14TiGM2SJEWnXo9lX3vBp55691Ki3YV0NY=;
	b=fhpLAU23xX1yNpDq8+GheSmCJuFuDUFbVpkm3eDMA3WoztVBUaObkwmisXRlCqvkv8TA0Z
	/Wz2HDGjq5judIdye31bUc084c5sdeWGNDu/Na3nkkX38xwsZgszQn+xfsWCb0SKESrKjK
	iqVojBXKl9kkCPlk8JNVC6mVKxjF4s8=
Received: from mail-yx1-f70.google.com (mail-yx1-f70.google.com
 [74.125.224.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-TC5ii3_PMJaG3pIOPKGU1Q-1; Mon, 04 May 2026 19:31:49 -0400
X-MC-Unique: TC5ii3_PMJaG3pIOPKGU1Q-1
X-Mimecast-MFC-AGG-ID: TC5ii3_PMJaG3pIOPKGU1Q_1777937509
Received: by mail-yx1-f70.google.com with SMTP id 956f58d0204a3-65c694b54d7so897437d50.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 16:31:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777937509; x=1778542309; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=WIdi3Vf7s14TiGM2SJEWnXo9lX3vBp55691Ki3YV0NY=;
        b=Te1uBzM0W2x754eDmKozP8TKE9c5VIjH7naS59PDvhFmC7USJ9p6obQynvZUV/FpnI
         xtFU6284//rgij/XuApyBxiQoMI4sB1keRd0PFYPEE9CGF1d+Nywh0E7r9/uU9JGkipT
         HD9ViAwOwTCjnZJpLBfGKJaNIbhLi5mjKdPwxbaDsblVzpznToRnW/bbhileWK1Ctw6H
         ezp54Lgi1rrrtCfpH6wArAsHC8Ik61+5PM/TYQqO9V8GpTEowZxiE8vDqgAxyGJmL8ck
         FrgcPHwainy3R2rmvVfoRNHqZwLNihs9dDnIRMoRt+K1WFeI0qumVCrzYwRrLTo5195P
         68PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777937509; x=1778542309;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WIdi3Vf7s14TiGM2SJEWnXo9lX3vBp55691Ki3YV0NY=;
        b=PrY6aiQq8ObYv/ZBL3sdF7O+9AFPAbIFl2Xxk+0sFQCCshZM/PZYSpxFnAgXPUFV/X
         InGPiudSVq3eF5t3cF8+HQacFtk2jLMoZD98Z1l6cQgmahkxF1Jt5T1MQDXACnW3BjY7
         Lf/Up2rxkifIVPFbhTEWuH/yZxAeJwS9lAUFbA5j5/J/Y4NNH4IiI1f72ApsNh0HtLFW
         fAhhwLPAHIi0es8g+7FbDY7jp1XS/xDy/+uzT0zWf2sNl0R1nCK7TApv+AyOvODRgDZb
         bGZjo+0BVTJaAXz6PqhoMoPbW/fDl4CjqeGCHDLXCuRbB6knB6KjNNADN1winCjLmaBu
         Q2AA==
X-Forwarded-Encrypted: i=1; AFNElJ8W6Z18C8B3EVeP07GTnPVHjeUp2XA35w/QrqhWLCRqLOzgo/yhbxyUMrCq+kmFTd5wpeuOwks=@vger.kernel.org
X-Gm-Message-State: AOJu0Yya67c2mNHKqiGUe1t1ZQcztlb/0r+XwjnCmwOGxorNxCk5efOY
	nJojCztwo1ob7nFZL1DThAzNwshz88nd1il8fn2o0sNegZVYPDb6VBFDdsqdeRwkkArPnc0ym57
	bmUx3XYvqcwbd6zjAIMbI5AJH5KBIVao69Vkt1Zv9qULqDnXpsOwCJkoe9Q==
X-Gm-Gg: AeBDieuU59m1CSeSvgLO50eJz362J1BfolcKsIH2jHIasuUkrjrXgjzUwesm14fdD71
	tZi7umz55rrn+fmReWra+lJDkGUNFMiNhupdXMu7c0ZDE8AfT3mxle4TJSwmjExmZVNLNNbqpsr
	g0v5DWdVPFsRehWlY6Tw6qxI3jpbXq1HU/XD0TMqsn/hU9p4sYqEsHI0VKPJJxOq8N0TqFLDpVa
	60pE2oXXhGouQmw298SzkRJiHb0b4ELDKu/oJDS8mXv7cKTmR6NxK/esUyCNy2YY81x7gYRAjur
	Xjdaex5hHke2/HczKR4rRpmX/4Tc4cazYQIBSYuRjYGiZSmarC/pw546BH1V1Ql/d413mOSe8lx
	jQ2o9T4gUr9L2Jg81o4ke303mqHSayGCRC7PA5boxyjPR9fYfo2SMxKdt/FA4vCs=
X-Received: by 2002:a05:690e:480c:b0:65c:2066:a9c1 with SMTP id 956f58d0204a3-65c69ecfc79mr685827d50.42.1777937509200;
        Mon, 04 May 2026 16:31:49 -0700 (PDT)
X-Received: by 2002:a05:690e:480c:b0:65c:2066:a9c1 with SMTP id 956f58d0204a3-65c69ecfc79mr685812d50.42.1777937508761;
        Mon, 04 May 2026 16:31:48 -0700 (PDT)
Received: from li-4c4c4544-0032-4210-804c-c3c04f423534.ibm.com ([2600:1700:6476:1430::29])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-65c2df83478sm6167827d50.2.2026.05.04.16.31.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 May 2026 16:31:47 -0700 (PDT)
Message-ID: <af3e5c699e80c0462351cd900458901ada932bd0.camel@redhat.com>
Subject: Re: [PATCH 3/3] hfsplus: fix null pointer dereference in
 hfsplus_create_attributes_file
From: Viacheslav Dubeyko <vdubeyko@redhat.com>
To: Tristan Madani <tristmd@gmail.com>, Viacheslav Dubeyko
 <slava@dubeyko.com>,  John Paul Adrian Glaubitz
 <glaubitz@physik.fu-berlin.de>, Yangtao Li <frank.li@vivo.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Tristan Madani <tristan@talencesecurity.com>, 
	syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
Date: Mon, 04 May 2026 16:31:46 -0700
In-Reply-To: <20260501110218.29906-3-tristmd@gmail.com>
References: <20260501110218.29906-1-tristmd@gmail.com>
	 <20260501110218.29906-3-tristmd@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.60.0 (3.60.0-1.fc44app2) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 1B1094C4D54
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-243935-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,bc70a12e438dadba4fb4];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,syzkaller.appspot.com:url,appspotmail.com:email,talencesecurity.com:email]

On Fri, 2026-05-01 at 11:02 +0000, Tristan Madani wrote:
> From: Tristan Madani <tristan@talencesecurity.com>
>=20
> hfsplus_create_attributes_file() calls hfsplus_mark_inode_dirty() with
> HFSPLUS_ATTR_TREE_I(sb) before sbi->attr_tree has been set by
> hfs_btree_open().  HFSPLUS_ATTR_TREE_I dereferences sbi->attr_tree to
> reach ->inode, causing a null pointer dereference when attr_tree is
> still NULL.
>=20
> Move the mark_dirty call to after hfs_btree_open() and guard it with a
> NULL check on sbi->attr_tree.
>=20
> Reported-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3Dbc70a12e438dadba4fb4
> Tested-by: syzbot+bc70a12e438dadba4fb4@syzkaller.appspotmail.com
> Fixes: ee8422d00b7c ("hfsplus: fix potential Allocation File corruption a=
fter fsync")
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/hfsplus/xattr.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/fs/hfsplus/xattr.c b/fs/hfsplus/xattr.c
> index 452a1f9becb2d..1ea9f313368c5 100644
> --- a/fs/hfsplus/xattr.c
> +++ b/fs/hfsplus/xattr.c
> @@ -317,12 +317,13 @@ static int hfsplus_create_attributes_file(struct su=
per_block *sb)
>  		next_node++;
>  	}
> =20
> -	hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY)=
;
>  	hfsplus_mark_inode_dirty(attr_file, HFSPLUS_I_ATTR_DIRTY);
> =20
>  	sbi->attr_tree =3D hfs_btree_open(sb, HFSPLUS_ATTR_CNID);
>  	if (!sbi->attr_tree)
>  		pr_err("failed to load attributes file\n");
> +	else
> +		hfsplus_mark_inode_dirty(HFSPLUS_ATTR_TREE_I(sb), HFSPLUS_I_ATTR_DIRTY=
);
> =20
>  failed_header_node_init:
>  	kfree(buf);


This patch already fixes the issue:

https://lore.kernel.org/linux-fsdevel/6601b6ec0de087674f60566db950449c4e821=
bfc.camel@redhat.com/

Thanks,
Slava.


