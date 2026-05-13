Return-Path: <stable+bounces-246920-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mDkwOmqhBGqbMAIAu9opvQ
	(envelope-from <stable+bounces-246920-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:06:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 60E1D536BC2
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 18:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2CE5930E98AC
	for <lists+stable@lfdr.de>; Wed, 13 May 2026 15:48:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E905D495520;
	Wed, 13 May 2026 15:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ePZpomXW"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f42.google.com (mail-dl1-f42.google.com [74.125.82.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C37534CFD0
	for <stable@vger.kernel.org>; Wed, 13 May 2026 15:48:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778687315; cv=pass; b=i+2cnjQ5s+TAA1GU3fJOXOZueitKepIEpk7osT9oe6twgigJfR18avLhUzrSAKiRltGB/Sa5ONSHJqO5Mvc20Vq8dtX7ttKPMYwbvyjM5he912d3Dw4UQPsiVRex90dyDfvmvHdKTRAXKwSYUxnikQZMO7fcULMIWUpyMQOCA0M=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778687315; c=relaxed/simple;
	bh=9ViwzoXBatv2NUYDSl5OrZXZ1uGAyyzF2HcYq0vGdLg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YzU/KOiAeH3+BAxYCvLor9ZMN5AoFi56tUqPpPV8Q+OGOI925QKp9lPPTNPjtSEMN5WECsXZdjU7BxPC3Uw+STrBWk8hHIDzYLVfGeT6t1eg6CdbfyVrvtQpL0c3V9zQX3dFajS6xZ530y+fNMNHKMXfXHUTz7k4K6IhXbq/jlw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ePZpomXW; arc=pass smtp.client-ip=74.125.82.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f42.google.com with SMTP id a92af1059eb24-13246a5110bso608301c88.3
        for <stable@vger.kernel.org>; Wed, 13 May 2026 08:48:34 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778687314; cv=none;
        d=google.com; s=arc-20240605;
        b=c+U4iFEgRW2QFP4B3Ne+0ariVPFlLCCn1OtEU3nE5TGejFte41uGsQxFfcizVXfdOE
         JDC7AxC2VmHtjgskX8+9bOTvWR5kdlU6xTqVLeGeXH6/vx+6ftIWxcDrfuXp1uW6bSt0
         6ywza80xkS/oLSBZh6iBwn2Np71/HUEqkTzXW3p/ks0CbJEFVsiHF+P8LNtHpvr9aJHB
         +aQduCRs9otXogZ2qcDjOXfc8mp739lY88SxlUdE12r61x5hpB4znv0Sd1WNpnSTLLwz
         EGGyhGUypfUX8bgCZmRKkOZD0JHe6lK0hNgA0ok51v0y6Kg7lDu0fMjxr41jaPPHVgfx
         k3TA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=9ViwzoXBatv2NUYDSl5OrZXZ1uGAyyzF2HcYq0vGdLg=;
        fh=nSbf8gR6zl4CBpveuW+Lm3gIBBDzpBbJc+AEwDmkbS8=;
        b=RkPHIMP307nM/88fUqFQ1O4SAiLjXdQMsTIPotxrYEWatgIGFaEhR7C0qyLDZ41Iw+
         YvolndspnZQwgtXs+5KJz+sxpG65aNMAAGfurZgbBruF7wIKYhr5TYsBBri704BX+nGR
         2AQR6aSeiU1ExL6WHvhRWcdCeg6gS3fCV+MVDwnoq+eqmZ+1SRca5rx35HlvGOH8fNAq
         /053p+0VXN0QdmMQ2NXtWWlRIieSzMg6AS+vjMTsK1JCIvNzanxOpszcgXm4IL02DteL
         71h3M3RifYIXKSFgeg2th15rkwXscsdaVO3GpYfWnFSGRZL/fvEPtgXg/mo25qhwSglM
         tsJg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778687314; x=1779292114; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9ViwzoXBatv2NUYDSl5OrZXZ1uGAyyzF2HcYq0vGdLg=;
        b=ePZpomXW0nt4BwzpgNwkpszZlpW0M3L5wnN1c+TqgOTXad5FgCj4YCHT4T4Y2p7gZM
         kSMXpTRLUi6l1rEliqC9SlwjZ6C0c5IMPiY5LEt4OP2cl7LbpM2N1gdfK1ywhbViLU+J
         PmtC/0Q0Z/Y2JKCfkk9qOlrrm2mklqz08pCzW2B56xhZVbq6cDPsMJ0q0LeSMnpEMWtb
         Q5YZ3f59F2s79n4osu+UikGmGI4z1LQee02ELzx1a+5jY/6twKLLYmcLCAKhQ8QQi1mM
         O1X45VZRIkAaSdrVQp3EqZBz7qKXcT++xxYOvWnAngS62Ds8cHW7SRXjIs8VZjFHibDF
         +hZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778687314; x=1779292114;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9ViwzoXBatv2NUYDSl5OrZXZ1uGAyyzF2HcYq0vGdLg=;
        b=nl4mWIzt923olebtmup/CE2cf8xi5u8dj2Yo/WeGSIBXFfy0RpRvMmDF1KnvSvJmv3
         bgxJ9kCkYGUfWBrP+/vBreYRAYhualFbGnRH1FkbFlhBGTxXhbPt7ULcmVr6GPGBaMQz
         WM6Ti7BC+WbkhlRJDgZgm1ntEkycDt5VJ9exFYu2bBPcViiDM4PyW5LD6gG20CYS2Mhl
         ImlDezAx/PVZy5dFheKB7ORfOH1UOGLE+khF7e+sc9MNSRuNjGGxCnDMHspbjMMGKCM0
         TKojlhMtXkmiWb8I4TbCJs6WQ2GnZ7XgFdMNbuwp4vkCSZtpBtORi5glAu0vQR2EHyow
         H4qA==
X-Forwarded-Encrypted: i=1; AFNElJ8Q0bC7Kf46ZOzrPE2xaqUzg5iWLA98gtzl6x77dN6j8xmTSiAxCtcRT496hC5FqtMWjPOqT/k=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw5+IfCkBf6bnQariIv7SVu9wbRiWQEJLVhXaovr6DAQIx7LZqS
	7ISbo9Suq67NUpRdjvzDZpXx4Mbv63Oo4R0sa1NH82hgyAEwaZRIB/uamZbFjOFLFjkfFoOgPlk
	kBCrUJ8w2zEjd9SEQ2lENGZN4ApBvL4E=
X-Gm-Gg: Acq92OGNbTYYmygKCaebNO0jIc243QoOiY1B0myEghQEnQPESaG/9oKEEuiVfHnqDgd
	vSAk25wZJZlDabKDH4p0KkA4lWEYJu+4RBm6VPOjlkHD2uFa9EFCj2WND5sLFqScxknp145/VgG
	JnSE8cgaOMvBqtuTYnoHvHUYNGXpK+cN/8uaSOnqKqtB/2b+TxKZjHG3d5YZMRLcIyYMcgR5XB3
	/m1xlH9aMAjFn/kkjsUiZc5sBfEletg18jkrupHDvYDT83+VMQxf78ObWz1uB9NGzJUQfptuH/l
	tHG2MYvR9fuhsmM4vU35G0e8IJs9eKLQP389h3l8z9PT0OeKXL6sfrGESb7QLXt5layJtknEP0v
	Ua1+kb2cr0sw4ijkmlZlqrI8=
X-Received: by 2002:a05:7300:e425:b0:2f3:3835:2005 with SMTP id
 5a478bee46e88-301198748bamr1226522eec.6.1778687313541; Wed, 13 May 2026
 08:48:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513145425.1579430-1-arnd@kernel.org>
In-Reply-To: <20260513145425.1579430-1-arnd@kernel.org>
From: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date: Wed, 13 May 2026 17:48:20 +0200
X-Gm-Features: AVHnY4LbTrmrS9TyU9LR4vM776F1M6zVZyBYrHuDnEqo4hrsMhud8cQe5uMH7DA
Message-ID: <CANiq72nbRw14wdZA4GH17K22Krh4ujB_wtuv9u5RQTGtidpq0g@mail.gmail.com>
Subject: Re: [PATCH] [v2] iommu, debugobjects: avoid gcc-16.1 section mismatch warnings
To: Arnd Bergmann <arnd@kernel.org>
Cc: Will Deacon <will@kernel.org>, Joerg Roedel <joro@8bytes.org>, Miguel Ojeda <ojeda@kernel.org>, 
	Andrew Morton <akpm@linux-foundation.org>, Thomas Gleixner <tglx@kernel.org>, 
	Nathan Chancellor <nathan@kernel.org>, Arnd Bergmann <arnd@arndb.de>, linux-kbuild@vger.kernel.org, 
	stable@vger.kernel.org, Robin Murphy <robin.murphy@arm.com>, Kees Cook <kees@kernel.org>, 
	linux-arm-kernel@lists.infradead.org, iommu@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 60E1D536BC2
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-246920-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[15];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[miguelojedasandonis@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Wed, May 13, 2026 at 4:54=E2=80=AFPM Arnd Bergmann <arnd@kernel.org> wro=
te:
>
> With some more experimenting, I found that marking these functions as
> __attribute__((noipa)) is both logical and reliable.
>
> In order to keep the syntax readable, add a custom macro for this in
> include/linux/compiler_attributes.h next to other related macros and
> use it to annotate both files.

Acked-by: Miguel Ojeda <ojeda@kernel.org>

I double-checked that GCC 8.1 implemented the attribute in commit
036ea39917b0 ("attribs.c (decl_attributes): Imply noinline, noclone
and no_icf attributes for noipa attribute."), which also happens to be
our minimum in Linux; and that Clang indeed does not seem to support
it (not even a mention of it in their repository).

If you don't mind, please add underscores (i.e. `((__noipa__))`) and
place it after `__noinline__` to keep it sorted (the file is meant to
be sorted by actual attribute name, though some entries were added
that break that, but I will clean that and a couple other things up at
some point).

Thanks!

Cheers,
Miguel

