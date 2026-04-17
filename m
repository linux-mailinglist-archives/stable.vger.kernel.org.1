Return-Path: <stable+bounces-238389-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oE4CMjaf4WkJvwAAu9opvQ
	(envelope-from <stable+bounces-238389-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:47:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DA78416541
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 04:47:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D9B15302119F
	for <lists+stable@lfdr.de>; Fri, 17 Apr 2026 02:47:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED912EF652;
	Fri, 17 Apr 2026 02:47:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U5fngzlY"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF8951F1537
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 02:47:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776394033; cv=none; b=IuQMnlC/uUgJERoa0sCJRp3Dkj6ikduC0ZL8t0+BxwcTd/maEvDdMkjLheLseUbJuOoIOq/mExNwhewpvH/zgnPQC/MtY0q9TO2Vm4QnknfgpWs49WL3Ejl8YnCvmliGRf3jUiwiAgRxi/xCjD3HhSusFnF/bTa7ApKZ3dk4W9U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776394033; c=relaxed/simple;
	bh=ag30l3ZtgL468KA3t+V/54BIptC5Ir8/kedwWC6NrEU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=To0cTOqFPbc4lP9WCZowmByErBXxyU+/3Cd6iv9Fs4PUxDxdvtHNBfkfm18hZU3yQdpvV2U47XII+apgMQr95x1mE7+V0nt0AR0kcsnfaLqBqc5SnW4saCfN0ar40yrWlrLITMxO0IhbgogrlstnQYQHUvuhA07KV2MhRdQ54rE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U5fngzlY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67624C2BCB6
	for <stable@vger.kernel.org>; Fri, 17 Apr 2026 02:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776394033;
	bh=ag30l3ZtgL468KA3t+V/54BIptC5Ir8/kedwWC6NrEU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=U5fngzlY1zgzop3mljeI2ezz9/vYkufvhLv0EgVM/TsGEr1M5DISNUTrlqtRAKOkZ
	 m9f6nWfDTzjJED1Y0fIC8UY1FIEIqkAusbeajlnydUbN4oAiLvyVSpWF+gkmxWnxfx
	 oFWv1Ieyizs0RNUk7hqjiEEo/ZixcwEk147vc0lSGC2/yTEkhgg3TIR9SqU7YR1/dt
	 jDuKG1FgIsCvhvBDXs+7pBavbhKBu9ODCCXvilnAujak6Ah0tF4JylWa4+zO6ViSGf
	 Ku7pSgRgmB+Ihj2ceP5QYJvpZL2VvPvTDUH4/JTOQdeR2F0GzRzPh8F/EQA1r3ftD6
	 o7eIbgqpS94nw==
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-b9c01854477so44997766b.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 19:47:13 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9oqaWjWMFsMh2XfnKK2TAidRonb53yzcy7hQbuIvecAc6vJlXcrpia2kY0B1vOsvs9hzTUSJY=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw+KTsM2tj3ur/GupCSskU2l42eud31IvlGSGpQaR01ObTiEtLq
	NZVFrubOTefbIK6qdT55o/SI4OrqKLljVsmfY8I3+BAsPboYNe/ctW+dHEOibuWdCZCIm0cNBaT
	vRXwcPHYC1RoSWO89AIlZIFXa9AmB2cw=
X-Received: by 2002:a17:906:c145:b0:b94:1df4:3525 with SMTP id
 a640c23a62f3a-ba41bad0123mr47054066b.1.1776394031997; Thu, 16 Apr 2026
 19:47:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260416200439.2987930-1-michael.bommarito@gmail.com>
In-Reply-To: <20260416200439.2987930-1-michael.bommarito@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Fri, 17 Apr 2026 11:46:59 +0900
X-Gmail-Original-Message-ID: <CAKYAXd94w_Mi0gzAKrHiMnV2LsVk-Rzo6JcGtXNbEJZG4xXF4Q@mail.gmail.com>
X-Gm-Features: AQROBzBRonctEOhm_0Xni-0WQTv6zF5MG4w8OvP7PAUiLUDZd7Fz8lsWruW5q94
Message-ID: <CAKYAXd94w_Mi0gzAKrHiMnV2LsVk-Rzo6JcGtXNbEJZG4xXF4Q@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: validate num_aces and harden ACE walk in smb_inherit_dacl()
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Steve French <smfrench@gmail.com>, linux-cifs@vger.kernel.org, 
	Sergey Senozhatsky <senozhatsky@chromium.org>, Tom Talpey <tom@talpey.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-238389-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,vger.kernel.org,chromium.org,talpey.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8DA78416541
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, Apr 17, 2026 at 5:05=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> Another one on the smbd side this time. smb_inherit_dacl() trusts
> the on-disk num_aces value from the parent directory's DACL xattr
> and uses it to size a heap allocation:
>
>   aces_base =3D kmalloc(sizeof(struct smb_ace) * num_aces * 2, ...);
>
> num_aces is a u16 read from le16_to_cpu(parent_pdacl->num_aces)
> without checking that it is consistent with the declared pdacl_size.
> An authenticated client that can set a crafted DACL on a parent
> directory can declare num_aces =3D 65535 while providing minimal actual
> ACE data.  This causes a ~2.6 MB allocation (not kzalloc, so
> uninitialized) that the subsequent loop only partially populates, and
> may also overflow the three-way size_t multiply on 32-bit kernels.
>
> Additionally, the ACE walk loop uses the weaker
> offsetof(struct smb_ace, access_req) minimum size check rather than
> the minimum valid on-wire ACE size, and does not reject ACEs whose
> declared size is below the minimum.
>
> Reproduced the ACE walk OOB under UML + KASAN by constructing a
> 12-byte DACL (smb_acl(8) + 4-byte undersized ACE with size=3D4,
> num_aces=3D1).  The old 4-byte guard passes, then reading
> ace->access_req at offset 4 within the ACE triggers:
>
>   BUG: KASAN: slab-out-of-bounds in kcifs3_test_inherit_dacl_old
>   Read of size 4 at addr ... by task mount.nfs4/220
There is no kcifs3_test_inherit_dacl_old function in ksmbd. How did
you reproduce the problem?

