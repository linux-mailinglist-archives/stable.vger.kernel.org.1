Return-Path: <stable+bounces-250801-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKGhOWzvDWpu4wUAu9opvQ
	(envelope-from <stable+bounces-250801-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:29:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 92981593CE5
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 19:29:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 21A313155356
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 17:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DAB613D7D66;
	Wed, 20 May 2026 16:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bsvx1mDL";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="UfeIFZKU"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 311A63EFD14
	for <stable@vger.kernel.org>; Wed, 20 May 2026 16:59:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779296344; cv=pass; b=c9d65lbDKZloEWFz2moe/1KsD4dmxs6Ud3aouaCbrom600JwZj817Sx7U2A0IcgQimNdfpayIMajuMRdwGK476d1E1PF03L2BQoHJ4B2hVxxYU+OZT6cubOna1S+0QXfMs1mKRhefQYQRJFmi3KppSroKd9dCXO7jC4dFragnBg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779296344; c=relaxed/simple;
	bh=/N3cAkuhC0sFY5XN2iqTKl/9FqFNKW3EYh10C+xNj38=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gzRqMwVZNdmxuFxbQW9/Zjhg7Ss2sh3ZTyj9zwlu4OOOK2zcnyHf8L42pIFxZp5xkv/2/zp26nbAL6DZNqLD136N4gTUW6IyFik4Ho00treWTHYCEv1xvvHDw7bQmdr8sw8/LiMx2CdWzXJC9nCZWIK5i5+PZnP8IBvnopSpWh0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bsvx1mDL; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=UfeIFZKU; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779296342;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vh5MuTZX0xtaFylPc5morN8QD2kp7GolTmmF27Hc4YM=;
	b=Bsvx1mDLom6thLk+2m/Db1yxJ1+ipUphaFgfUtS3Q0L5ZCZGM9npLqldc1VGbrb4+2HV/a
	GF5NtOkNYtm/Y6IBs2Y95IIgM2BrE8BeukGBKywPqE4JiXo2HoZvUaEidEylyCzi2DvYHn
	73albmMY+JXrmEVHn/7hP0RGMGpSFao=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-306-QGy_FEE_PcGhcMqXUD8vUw-1; Wed, 20 May 2026 12:58:58 -0400
X-MC-Unique: QGy_FEE_PcGhcMqXUD8vUw-1
X-Mimecast-MFC-AGG-ID: QGy_FEE_PcGhcMqXUD8vUw_1779296338
Received: by mail-ej1-f70.google.com with SMTP id a640c23a62f3a-bd31fa4b1b8so487387566b.2
        for <stable@vger.kernel.org>; Wed, 20 May 2026 09:58:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779296337; cv=none;
        d=google.com; s=arc-20240605;
        b=erBMoD7lmDV/P+r6BuOrzCOSWi65IdVmb7PlHCcUxqilEjNlZacHKrpTxG7uUbIDy3
         CyGvp3xfmCdjmVSzNFP/G6biB5OJlsFBx4Egwo+D2qrCL52RJHBcV36plH+aHlx68jnZ
         LoNXYcV5UxnHrumLYxyDOtwyqbO14oZqBFC14OgOMJxWcz/ZYn1ce4ZuMOCmYMUSosrx
         Vhc9CE7QJ+saigv9mFH1xW0An4dIyF7f42ZodxSn3fYD/0Dn13AYBl7qiXSIyBJ4wvoY
         Xp2dHshiJb7Gf+6LFL/KmTs3K7RL/vv2yFVrHWX70RuVbyirLIyEsiVEgDHgUZr5fZ3S
         240Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Vh5MuTZX0xtaFylPc5morN8QD2kp7GolTmmF27Hc4YM=;
        fh=Z93eGhZOn4AVKMo6QxaG/S1JTFOOKAc+oTxaGIdpVCY=;
        b=MKnxR5j1SKSjkCdqLr6/J7pxdujtMIQ64Sfg69J3xTR9MBRzyBhgEk4JEmGQKlR12g
         0kDVqbfgyj69XzqZggLSPNw7FvbueS30PDiPhLouQ3Maz7bjKFfzvhcMy75aCGJkTpwM
         y6lxld3hVpo/RKcNV/eEK795+nF91/0iHBuBl5gPgEwuSlLqMXyLECocJJ82+Yx+ManA
         k5Da7xg34a1SThLUMHyKPeDAfZy0H8uJA6mNyU8pAIRJ7gmBCjpEbHyG9ahCwysWCvcU
         UEvToaC84Uvf5+jtZ65t1AD+4ib2EBy1AHKAhGXqKTwA34Flev8KQ5iypff9tUKxMDFf
         JN7w==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779296337; x=1779901137; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vh5MuTZX0xtaFylPc5morN8QD2kp7GolTmmF27Hc4YM=;
        b=UfeIFZKUpYWDIFpLVfmOX2eHZaUwYrPq5q9bxfOlW56I933Hof2MH02158rqaYecvs
         eEyUHVQLaCzXAtONEPztwzKh68mHoOKb3pGbJ/xwGN4v+dAyGNSSSITSYxbxVUlcvY5V
         O4mm+oQYFPvvyU6GcVOBWogPYBkQex1bml8UojT4Nq+MMHnidWZ3nU3yx/4oB6RT1fPI
         IPtmxsM14n/IievU551MhJHdp1i4o5Xf5FBAlwgSBsoneRpHnJI/uwS+SBQ8t4/d+UrO
         TGR5+VgTYqn1Bjj1TjLwIStHqEjbhcMwiv02fWFpLLOWuRCnCIbo6JlWJcSxBjiXHNj9
         NQPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779296337; x=1779901137;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Vh5MuTZX0xtaFylPc5morN8QD2kp7GolTmmF27Hc4YM=;
        b=PONa2F42JkeIuASrxB1h+kTVDFQzrXd8K6hRg2f3dV7qI3vrsLro1JE9QHSANQpk/d
         YOX8nUSjsaNJ1hfTkcnyI5RFUHjbrM1p59gswR8sVuOkqgYuoNLERu/4Q61jqUKi/zeI
         XuaVUXz8c1ulpNHQyO+rGjyVCnZQiOi+WhTK95Bt5/MhHbSkNYyKHojh6KeIZ8/FcNfs
         rZrEx267azGX8SoRLAV0n+dN8yk6Pvukby+PapxY/KKQQcyntG3GckAS1kAfLMvQa0pE
         OzZda/fXiY7M1Iy4K53jTZ1J1BSgXDmPEXvfY2fbZ/Ar+B+YSklkkkjLaR1RkblM7TLe
         JoCw==
X-Gm-Message-State: AOJu0Yxwi6g4jZyLc3+UMms8udvEt8EH39YrV3AwTpvHr5RiYCayDMdW
	Y5gEMJldmRyuw9dOPfPfAEDuNTn1TH/qtMiZe5QlAcCyyuOmlxWYv//B8IfKrINH7bUlnow9QQ9
	JaPy9cW4rYQD3ps8FGLJ6eXTSV75qe7rLKjGkX+xLbtcdt5vAFoeFhYtO3WWxJxmfyMFp/hfD5k
	gbM4Hg03kr/SZ4nA0Em1Nza9MuJVeBsNEI
X-Gm-Gg: Acq92OHU4AxVgRkUBmS1Hyby6HzBRvQil/eRPE2Ko8Ggtv5VwmtXkVI8K849lWoFRfV
	RZNepeKz9k536i0sEY5Emoff7pb1Ao4QhIAS7UaL2X2vMytAo9JgIAtiRF7ot5OOkmCTClt/2r4
	qmOR9Up50J564ysEBjfPKXz5x4qNW6/r/ZDJuQOxu4TBaroOuUvqaw0NgDiI7Cf1e9nodhBshRk
	jA9PRCj8tM/PyW+zBs16JBKyWzyM29XtXBV
X-Received: by 2002:a17:907:3944:b0:bd5:378:10fe with SMTP id a640c23a62f3a-bd517812d87mr1332170566b.11.1779296337553;
        Wed, 20 May 2026 09:58:57 -0700 (PDT)
X-Received: by 2002:a17:907:3944:b0:bd5:378:10fe with SMTP id
 a640c23a62f3a-bd517812d87mr1332168966b.11.1779296337030; Wed, 20 May 2026
 09:58:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260520162148.390695140@linuxfoundation.org> <20260520162158.452078806@linuxfoundation.org>
In-Reply-To: <20260520162158.452078806@linuxfoundation.org>
From: Tomas Glozar <tglozar@redhat.com>
Date: Wed, 20 May 2026 18:58:45 +0200
X-Gm-Features: AVHnY4JCWoPDByH1h3FbnlWBk7V9B6-mKZPQDTnnXQWu1iJwRKQxiMdn29nqVMI
Message-ID: <CAP4=nvTUdVQN8j_qJnfytGOJMa4LaX2h3Z9-cmDopBhKE87_nA@mail.gmail.com>
Subject: Re: [PATCH 7.0 0453/1146] rtla: Use str_has_prefix() for prefix checks
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev, 
	Wander Lairson Costa <wander@redhat.com>, Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-250801-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tglozar@redhat.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:email,mail.gmail.com:mid,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 92981593CE5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

st 20. 5. 2026 v 18:45 odes=C3=ADlatel Greg Kroah-Hartman
<gregkh@linuxfoundation.org> napsal:
>
> 7.0-stable review patch.  If anyone has any objections, please let me kno=
w.
>
> ------------------
>
> From: Wander Lairson Costa <wander@redhat.com>
>
> [ Upstream commit 265905df83a4c1e78c1a912e1699d7c81d9540e6 ]
>
> The code currently uses strncmp() combined with strlen() to check if a
> string starts with a specific prefix. This pattern is verbose and prone
> to errors if the length does not match the prefix string.
>
> Replace this pattern with the str_has_prefix() helper function in both
> trace.c and utils.c. This improves code readability and safety by
> handling the prefix length calculation automatically.
>

This commit breaks rtla build as there is no str_has_prefix() in rtla
in 7.0-stable. It was introduced upstream in commit 0f4bc9d67a6
("rtla: Add str_has_prefix() helper function") which is not in stable,
see [1] - same error can now be reproduced also on
linux-stable-rc/queue/7.0. Please drop this commit and also the
dependency that pulled it in, commit 4bf4ef5292b9 ("rtla/trace: Fix
write loop in trace_event_save_hist()"), which does not apply without
this.

Not sure what the policy is about 56317dd01bd6 ("rtla: Simplify code
by caching string lengths"), that's another "Stable-dep-of"
referencing 4bf4ef5292b9. It doesn't break anything but was only
pulled as a dependency of what will now be dropped.

[1] https://lore.kernel.org/stable/CAP4=3DnvTootCBXa1VxJLGACVtVNuY_RiiAWVOr=
h+jED=3D4OD0SSA@mail.gmail.com/

> In addition, remove the unused retval variable from
> trace_event_save_hist() in trace.c to clean up the function and
> silence potential compiler warnings.
>
> Signed-off-by: Wander Lairson Costa <wander@redhat.com>
> Link: https://lore.kernel.org/r/20260309195040.1019085-12-wander@redhat.c=
om
> Signed-off-by: Tomas Glozar <tglozar@redhat.com>
> Stable-dep-of: 4bf4ef5292b9 ("rtla/trace: Fix write loop in trace_event_s=
ave_hist()")
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  tools/tracing/rtla/src/trace.c | 5 ++---
>  tools/tracing/rtla/src/utils.c | 3 +--
>  2 files changed, 3 insertions(+), 5 deletions(-)
>

Thanks,
Tomas


