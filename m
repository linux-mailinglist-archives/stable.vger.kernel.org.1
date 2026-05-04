Return-Path: <stable+bounces-242999-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAz6JCiE+Gn0wAIAu9opvQ
	(envelope-from <stable+bounces-242999-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:34:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E3AB94BC68E
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 13:33:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 689EA3011103
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 11:33:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F09D03BD646;
	Mon,  4 May 2026 11:33:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PjceFGdu";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="QMQEroo/"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F4D3B8D7E
	for <stable@vger.kernel.org>; Mon,  4 May 2026 11:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777894423; cv=pass; b=iaHbI46HtoVPcS+fRybEsB751L1wIt5erxVBdstywvq/ozrzb1q34Z8quKMs1EnMtKE4GFgGbRgTyRiRriHiz85hQ31rkeVCQYwyHt59VNs4jBn3K5bZ2r/EE1ZaCxnEh07ngShZuoMtbywtZBVGlyJPUIyhJBfgKhcyYw9fSJk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777894423; c=relaxed/simple;
	bh=8SDLmHevIlwB/u7ZlGuFSlD6zurYax3/7No2hDObsOs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hbb5gFcfDwwyDm+d7YLYdlIsYhGo9JdTc4liT3LbssonPr5OAtZH6SXiGxzCfy2fNFwXEHoPMRiTjiWG+ytTM5PJ5A4gaJQXMIYEn+uv66unlpE10vvxpgd9L0ZzlDgpmtRuebjMyzy5aZLC9NLP0BiUCUGlwYIPtkOtJoGJag8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PjceFGdu; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=QMQEroo/; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777894421;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cqnd2v1SDhrP0TeXptQ4w+p6QPtBOu2LtlAfgl/gb2A=;
	b=PjceFGduW4Z2BFdosDdZX526+/SOJG9gTqNlH2UHPlsbG3U2VuIt4EnwE9kE9A1ej4VmB7
	6RuQ/dx6yDWi3teq32AXecgNB/ki9yfd7DzyjvQqVNDIJVr8+dcnQogv/KoCQC7zQFixhB
	/kxnqDpl0ZhAJE7QaOA21zWLkfsM3ZU=
Received: from mail-yw1-f198.google.com (mail-yw1-f198.google.com
 [209.85.128.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-21-49Iy-P6BMbSp-0AQRA5Z9Q-1; Mon, 04 May 2026 07:33:40 -0400
X-MC-Unique: 49Iy-P6BMbSp-0AQRA5Z9Q-1
X-Mimecast-MFC-AGG-ID: 49Iy-P6BMbSp-0AQRA5Z9Q_1777894419
Received: by mail-yw1-f198.google.com with SMTP id 00721157ae682-7bd9c8d6de1so3521207b3.2
        for <stable@vger.kernel.org>; Mon, 04 May 2026 04:33:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777894419; cv=none;
        d=google.com; s=arc-20240605;
        b=EFxtZ3r9LY08SfQ9nubR12autXJfQS4izW4CnBEFpL7auVgJ0skmdHhSbnFLTBcAE4
         cCsSjSyDThxxK/59Wdt/zc4eO25V8hAaoi9A7t4MxzEPmeu4wqRx0gNbS7N2ilqoO3jf
         UwVmZ0x5hPBWK6/liLVH0QyCI011gbLrwbn2JaiQ9moGx8P5PMLsGVSV67+F+dX3WNv8
         RUkYrlEa6/UmOZo61ZcyRo8WlY2a7hrml/4GpXi6ovEWYGOJW8kpARgGPwDCCEpfUIiD
         NBYa7lE8q/v9DTvaMUp0i1ToJ42c4vH+Yga//nWu/bEDunMto/SPRO0uJDId3v1vTRcd
         QWIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=cqnd2v1SDhrP0TeXptQ4w+p6QPtBOu2LtlAfgl/gb2A=;
        fh=tSE2QfRzm8xzMMfrzRlKT9ILUoK9Wq82KtwrwHm/sN8=;
        b=etqKIutDfZ4rtUIq826HOQdkLDHxtnSSFxbulLCKIRu9mI6nRlC7Cpte0rzx6oYjsq
         LGlp9GwB+0eOXZSiht7ajwWZoKlRF2HBankyjM1pHEt5m+5ECj8aN/UwT/Q+KLdef5lT
         SeIxHS8eYO7MFh80DYCc8y5FRmuL3GEe/X65+APAjvtCRqu7IOMzAXpOpLo8vAzAiTUJ
         J27FNMoYRAYWi7cV5PIWWEQUmPeWvlHSa8Mso+F0dNnIq6Nzqa5f0rT0SgQ4jSSsplBX
         m9Mklva9yFVhtF3aRP/XbEZ4AW0M8jSg/vxWW59Kxzcy/ce+BAfZLmitc/A78MPibXXP
         Ecgg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777894419; x=1778499219; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cqnd2v1SDhrP0TeXptQ4w+p6QPtBOu2LtlAfgl/gb2A=;
        b=QMQEroo/8mTRLEevVh63gmXU5Hg6D458HhALzvm9ARPMwfYKufwh9eJiBOr86VybzV
         x7IJi+Iu/vP1r6mnMWJw9Gke77mVkjvZLsRZ0dHP7s35NCSQnFPFaKxnFi4M66CGhHDi
         BZpa3B5tfpx0yJzeNN2jmYOebjPL8cRfFi9HxdcuvePPbYcbR4VvUTKNgsTUaHfQUFYf
         kLRwqgTVlTx35AkG/aBKmcyPphpwvPFYbYlfVQeFZeAzRlPG+am9vi0FOKUnsEIK9ivx
         whqbF5VjsCrpPyolyO6QWuPhwd9wKVXg/682l+jwykZD3ynPMq5GKzGO38XX6bQ0e5WZ
         iI1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777894419; x=1778499219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=cqnd2v1SDhrP0TeXptQ4w+p6QPtBOu2LtlAfgl/gb2A=;
        b=VifBxrUiircVwb9N4D7AvX28I+e+796ysOEVOA9Hgpd46yanFxBqsDOF2q9EX7Vl4M
         zEaWl1ldYTi6qWIa32e+PhNsMJagle32MmEJGkAUuhL1+jHt4sDXyLZbTBoZ0Y6U/X6n
         4a06lXY0dMeOkNh9jneyDD4A6zW/HClGOCzxAhHco/c36IBTqQGxUqsJM82mmr2th70O
         6F/ZYA4mXpjEkeQiPD531KbEzsIsBSbrb0aywBarhNLcT3UrfYxgHmUL7w12gM6QanAf
         IB9m/9//xxNFgivrupR2+jqHMVHiMXfZwfyJ0zu6Esr+7td4BBtSZUYYWuJJJpNDEKLm
         S5DQ==
X-Forwarded-Encrypted: i=1; AFNElJ/LiL0xTv8Jp3wtpk/yl823qpeFu5P6Me0C3HB7ppKcKTxhVAU26oSA9kZUgPJ9GQ1iifz0HJM=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0pPRl16F9XnMTu9yE04VnX1PKEqwYMy1MkwkD3p410cX/qMhi
	14N/fDh1pVHj+shPnjTTjLl5J2I4m+35F4FyCHQmfMFT+reBiNoefEZ1alyiijTNH7XeDptgDXm
	TvjlxVhwAQwAhEYCIzcktSGzUTZXO4qioK8/hl8TvZlihk3vjf2C2itX+Ti/BHSyhh2AyrYedeY
	uU/44gDNx1Fs7RHAihCyJlQZIhQzXKYbtR
X-Gm-Gg: AeBDieuSQZH9ZD2bjCaujL2DiF0K/MNFXe5pFaLRBgkmOGjXi1pxYxLO3Vabtzpwh6X
	ycwUsqJk2FjFpincSxnpZSLSEQVRCSWNwYMkYlwp1vH0jVwH1vW4AJJ0DozpQJ0iQ6ilQoWY+JH
	uuuUdH6Dez1B5DokRuXvAhXQnlpBsOeGOWaAnECjPsFCDA+MxUn+TRLkeiew+jcuTomnY5unLOU
	oMLcN8lCDNy+Otk1wD1MT1UYN4YQpkKh0CH6aCzyS3ix7UgPK77oWGSRoCKVaGu9uTpkbQB6dL3
X-Received: by 2002:a05:690c:93:b0:7bd:73f3:7a67 with SMTP id 00721157ae682-7bd770b299bmr97676487b3.28.1777894419470;
        Mon, 04 May 2026 04:33:39 -0700 (PDT)
X-Received: by 2002:a05:690c:93:b0:7bd:73f3:7a67 with SMTP id
 00721157ae682-7bd770b299bmr97676187b3.28.1777894418970; Mon, 04 May 2026
 04:33:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501110203.18771-1-tristmd@gmail.com>
In-Reply-To: <20260501110203.18771-1-tristmd@gmail.com>
From: Andreas Gruenbacher <agruenba@redhat.com>
Date: Mon, 4 May 2026 13:33:28 +0200
X-Gm-Features: AVHnY4L9bmQa5IUNT3tNlIxYBRuA1RsJ3l5yFYV1uqU02xQgIy4-3k0W5T6qgdg
Message-ID: <CAHc6FU6drG2y+dD-gkuq52uKUXzdGzBA6dNiwPe79-SF9J2hvg@mail.gmail.com>
Subject: Re: [PATCH] gfs2: fix use-after-free in gfs2_qd_dealloc
To: Tristan Madani <tristmd@gmail.com>
Cc: gfs2@lists.linux.dev, linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
	Tristan Madani <tristan@talencesecurity.com>, 
	syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: E3AB94BC68E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242999-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[agruenba@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,42a37bf8045847d8f9d2];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,syzkaller.appspot.com:url,mail.gmail.com:mid,talencesecurity.com:email,appspotmail.com:email]

On Fri, May 1, 2026 at 1:02=E2=80=AFPM Tristan Madani <tristmd@gmail.com> w=
rote:
> From: Tristan Madani <tristan@talencesecurity.com>
>
> gfs2_qd_dealloc(), called as an RCU callback from gfs2_qd_dispose(),
> accesses the superblock object sdp through qd->qd_sbd after freeing qd.
> It does so to decrement sd_quota_count and wake up sd_kill_wait.
>
> However, by the time the RCU callback runs, gfs2_put_super() may have
> already freed sdp via free_sbd().  This can happen when
> gfs2_quota_cleanup() is called during unmount: it disposes of quota
> objects via call_rcu() and then waits on sd_kill_wait with a 60-second
> timeout.  If the timeout expires, or if gfs2_gl_hash_clear() triggers
> additional qd_put() calls that schedule more RCU callbacks after the
> wait completes, gfs2_put_super() will proceed to free the superblock
> while RCU callbacks referencing it are still pending.
>
> Add an rcu_barrier() before free_sbd() in gfs2_put_super() to ensure
> all pending RCU callbacks (including gfs2_qd_dealloc) have completed
> before the superblock is freed.
>
> Fixes: a475c5dd16e5 ("gfs2: Free quota data objects synchronously")
> Reported-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
> Closes: https://syzkaller.appspot.com/bug?extid=3D42a37bf8045847d8f9d2
> Tested-by: syzbot+42a37bf8045847d8f9d2@syzkaller.appspotmail.com
> Cc: stable@vger.kernel.org
> Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
> ---
>  fs/gfs2/super.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/gfs2/super.c b/fs/gfs2/super.c
> index a2ea121331f18..4d854556b5299 100644
> --- a/fs/gfs2/super.c
> +++ b/fs/gfs2/super.c
> @@ -643,6 +643,7 @@ static void gfs2_put_super(struct super_block *sb)
>         gfs2_delete_debugfs_file(sdp);
>
>         gfs2_sys_fs_del(sdp);
> +       rcu_barrier();
>         free_sbd(sdp);
>  }
>
> --
> 2.47.3
>

Applied, thanks.

Andreas


