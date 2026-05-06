Return-Path: <stable+bounces-244407-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QJaZOtpP+2lFZQMAu9opvQ
	(envelope-from <stable+bounces-244407-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:27:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 69C9A4DC287
	for <lists+stable@lfdr.de>; Wed, 06 May 2026 16:27:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6650D30C1F55
	for <lists+stable@lfdr.de>; Wed,  6 May 2026 14:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2383846AF3C;
	Wed,  6 May 2026 14:16:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="O3MFG9vk"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E7573ED11C
	for <stable@vger.kernel.org>; Wed,  6 May 2026 14:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778077003; cv=pass; b=T58GSh7oralXQ42hgArUb0fKdazQxjc2Mygn4fKtINzokNDBspkGMIedH199zW5fVpE3thevTOiFsDoL2dpjwk+ZYdkaEiBs/gXC7D/3Twl01rJRsrwO5ZfOU3SkYyg4BxSbw0R++GwyhPqIN/MFAeFpcgEWLHbekeRx/++ZtZE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778077003; c=relaxed/simple;
	bh=BO0inazC7nIhHzK/RqjC5uR0srzp6ZDE+sGZyuMr2xM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jNfSwtdA/VV8d2VNYi89IMV9qOlySoMgu+Sp0IuzXJbPWe7az7FbDblvknefYY+suyqmXgydjvqr0NyLs2h4IHpkGGnLikEdVZXE7pfc6X8GROGYx5iX+ZLDOnhrkpCwlI+IxtuZuw2quN4qTpv0hI/eUiDafo7hN2w2m2zrb4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=O3MFG9vk; arc=pass smtp.client-ip=209.85.128.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-7bd5dde63dbso66958317b3.3
        for <stable@vger.kernel.org>; Wed, 06 May 2026 07:16:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778077001; cv=none;
        d=google.com; s=arc-20240605;
        b=asbcIwUnKfIrLJlkipg1zN8v7oGX2TJOaAr2fgycn5KjWk+oXqGDAUApVQxNw54KMP
         tHINudhqR6NYmS2YrM31TIPil/EnyOfn8DpNP4+G/LaTZWZwVF8eh/xBQfmjlgZKoaZv
         WQRvaU1ZQzTtHDBn94Xt6EkVr8tdW5Msmroiz9iE4EklNvB1CpRo9icwdMmxEDki/lIx
         hhUBXdt6YGltjdmaIwVzeazvlbSwsalrd2U/MR8HligIIGkFTFm6m1ITEQS+LKwz1wvS
         vT7WA9u0KQUz3njgmZH5oX0XMtP1sLsM0M3QsMRgHs1w5Fc+053TfOk4AcLhY4Fibrtj
         Qb0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=vxGTLSi9EMDgbvFwJLkFrQfjW8cmX9Z3HmTaLl84F/0=;
        fh=QT+WoL9+YU/w3EGcl9BfuLTv2Q2HfPlvlkkmAioOfVM=;
        b=Smni+DwF4mW0GxA2RvQVtxCN0DBeQOmoesg27U+szW0H9ZJRBCnnE7BV2nLohGvrwM
         YaSRqX8jcvKg0S00QB7G9Mh76c/GJoSMgmpFKuXbfNsMTI8RLXXp1bLgzzbUVXReYi5o
         BNjJytMifUeovqW+7pYyPUqDQlgQCRUJ0UKrDLgdx85osMuRT3ntEu7C1PaOzR98Q5bu
         x3PTvpBsAbPBzeoo3/PIUCHdw0qkY8nN1XPbwLjA+JkE5GPSt+7/zUst+364gGlzg2Ek
         q5sRG0dKIQE45lhsiYdd+8LAFlU2uQXuZkVKVVD5TsL86j7hYD7VomJeDzhxl90QzxD9
         KDfQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778077001; x=1778681801; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vxGTLSi9EMDgbvFwJLkFrQfjW8cmX9Z3HmTaLl84F/0=;
        b=O3MFG9vkS/Rc9ZGtyXSLXmwtOnrbwZG9JxdqeXASyTqnMGTaUuIFdL/8XFK22ZZL9F
         dalPAIXbZ9qfBtzvdleY6Xbg1RJNjyz8paKpmqqUzbi5Gld314zRj2n/yhzIGXYHi3yo
         uCWub3P9dZ87l9lIQqAhwLbnQZBMkcoThfPQ7691kp1nMffYplWzD460ZieljT6iMqwP
         pj2GX60j+rJh7ZQx9dMDCEakY28ttg+Jyq0NMGP3GR+YQQ722QI1svkMgwlh1BlePckN
         yyvT3pm9hyEBC7MKseiYLhrsj+itYK0lNFYM16bUSv/yoLo+h2wm5bIqJxAH1MGliOUu
         Ktpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778077001; x=1778681801;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vxGTLSi9EMDgbvFwJLkFrQfjW8cmX9Z3HmTaLl84F/0=;
        b=IMVEpdELrjbHkJrp+fxfIXcyvDM/4C+sEvrSiYWBx0FuUB8BPrp1yghmukrzf0uVi8
         u7KDkPpoZ47ERvbYr6owGBwlW0NJ+Lexvc/h/qHgEyAiayY+yGVYtEIUSOq1WhIsJMNV
         Y/bQw6s9srf6Nn3UAyFSOvvX+1o6Vid+R4x8ZyHsBIVLTtSeYu0LB9v5m7AEev3iHGms
         AZcxSSf77zkrjhAy6uMGKQ6PETvgc6N4zKvx5lYjoSXlD0fafSQMLFAIrd4td03VHaK0
         QJi7VgwkabjLFSy2EHTX0C4NH3uthZ2JFCwYhWxUQmPphP1zPMNNZDfiGIKELWZDfC/f
         Bk2A==
X-Forwarded-Encrypted: i=1; AFNElJ/Y/rZF7j5dRuKdhZCG470LH+vqGGLXg/NDfwRbeqjCXzucHLuZwGo7jGQFuaqXdityEQNg7Ic=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTe+FKGC3Demcr4OeGugmVgOnUm1wO7zLIolyO+X9MF0xRXPA6
	DXuAr3PLihH4rbpjVRxXBHeNAIRBe/98s+lglnv9EYJX56eO3AKj4A/IAFzpjy3R5Voqj3zUmVd
	qXyh89z9va7j/ate3DMYiG7VyHpK2iLM=
X-Gm-Gg: AeBDieutqoiYYlK1lPsaAmWzdQ6+0AyGYLb6FaZBdPZHSMXR6Z/Fn5yvCWk9D4IF6zk
	BxgaOsHczRkvYn/LlifnEZQ3Gn60ISiNPIwD5PIubCuu4otVsm0Qtniab0oYgOuuIJsWxj/mBAx
	8yNaYCDOhIrzMwhfB+SENuTtGM3Cq1vmn5M9sPrQ3WKerS2GTIhqwNuEqlOYI/rj4dvpk86pYo7
	i+r738FBqgI+cn0kSxnMOIjp4g8JMzkRtWOPVtunkHnmyO+3FiQFSrLxxZiZ9feKR82Le+Djn1B
	IBqLs6vYYocu7Dz7QTmvb7GqHK1TBTgIlFPvX8ilmZ8xAcHMWA==
X-Received: by 2002:a05:690c:10:b0:7b4:657d:bd5d with SMTP id
 00721157ae682-7bdf5e89316mr40655117b3.30.1778077001190; Wed, 06 May 2026
 07:16:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260501112023.338005-1-sprasad@microsoft.com> <20260501112023.338005-2-sprasad@microsoft.com>
In-Reply-To: <20260501112023.338005-2-sprasad@microsoft.com>
From: Bharath SM <bharathsm.hsk@gmail.com>
Date: Wed, 6 May 2026 07:16:30 -0700
X-Gm-Features: AVHnY4I_xPVwU3LeqsN8XTWUSXz1NIExjYj6-xyUUPP5SFkn_3D5obBBB9o83R4
Message-ID: <CAGypqWx3zYp0yo2PmAvSCYuMRmiCDdJGSUwzSN=8US2aFrWNbQ@mail.gmail.com>
Subject: Re: [PATCH v4 02/19] cifs: abort open_cached_dir if we don't request leases
To: nspmangalore@gmail.com
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@manguebit.org, 
	bharathsm@microsoft.com, dhowells@redhat.com, henrique.carvalho@suse.com, 
	ematsumiya@suse.de, Shyam Prasad N <sprasad@microsoft.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 69C9A4DC287
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244407-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,manguebit.org,microsoft.com,redhat.com,suse.com,suse.de];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bharathsmhsk@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[10];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]

On Fri, May 1, 2026 at 4:22=E2=80=AFAM <nspmangalore@gmail.com> wrote:
>
> From: Shyam Prasad N <sprasad@microsoft.com>
>
> It is possible that SMB2_open_init may not set lease context based
> on the requested oplock level. This can happen when leases have been
> temporarily or permanently disabled. When this happens, we will have
> open_cached_dir making an open without lease context and the response
> will anyway be rejected by open_cached_dir (thereby forcing a close to
> discard this open). That's unnecessary two round-trips to the server.
>
> This change adds a check before making the open request to the server
> to make sure that SMB2_open_init did add the expected lease context
> to the open in open_cached_dir.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
> ---
>  fs/smb/client/cached_dir.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
> index 04bb95091f498..64e22c064fa0a 100644
> --- a/fs/smb/client/cached_dir.c
> +++ b/fs/smb/client/cached_dir.c
> @@ -286,6 +286,14 @@ int open_cached_dir(unsigned int xid, struct cifs_tc=
on *tcon,
>                             &rqst[0], &oplock, &oparms, utf16_path);
>         if (rc)
>                 goto oshr_free;
> +
> +       if (oplock !=3D SMB2_OPLOCK_LEVEL_II) {
> +               rc =3D -EINVAL;
> +               cifs_dbg(FYI, "%s: Oplock level %d not suitable for cache=
d directory\n",
> +                        __func__, oplock);
> +               goto oshr_free;
> +       }
> +
>         smb2_set_next_command(tcon, &rqst[0]);
>
>         memset(&qi_iov, 0, sizeof(qi_iov));
> --
Reviewed-by: Bharath SM <bharathsm@microsoft.com>

