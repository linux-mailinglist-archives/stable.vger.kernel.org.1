Return-Path: <stable+bounces-211834-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mChPHVvMeGmNtQEAu9opvQ
	(envelope-from <stable+bounces-211834-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:31:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A51995BCF
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 15:31:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 055593025A42
	for <lists+stable@lfdr.de>; Tue, 27 Jan 2026 14:31:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9220D35BDAD;
	Tue, 27 Jan 2026 14:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="UrI1Pd4I"
X-Original-To: stable@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC63C26F296
	for <stable@vger.kernel.org>; Tue, 27 Jan 2026 14:30:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.216.47
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769524260; cv=pass; b=fow+9FWjyMDroTtJBbJSyHZnRZUvK3uHUsjy1rXddXQ4Cltw5jN/FNxJWe80JephgAUrT0KitzfwTSetr15IEIikhCEKMeLtEpyUgfwWHDWeQxk0L0duKgklR/MhowFx0tbv7I40wRSTLKQSoZ0p4wf5dXjA7+zMgrSUc2e6pFI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769524260; c=relaxed/simple;
	bh=4L+1CduCICSFsgHUjcOkN7OHpLxEb9vbNkxHmmODV1s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Ar0CV3Z0DHy/iWHYj0TdyvDwini8LBrU5j2CFCasDVqK408lgovXhz0of9zDx3fNDZzr49+Kwh4yEt2ve+Tcn0y135ThMeO7YKXrbcm8qSoqV2PyWIXd87MEeCWj0t+3ywWbjMD1u/XNC41+KGxCFOcdcbuvjOmtif2iDf6W/Mg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com; spf=pass smtp.mailfrom=arista.com; dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b=UrI1Pd4I; arc=pass smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=arista.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arista.com
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-34c5f0222b0so2988854a91.3
        for <stable@vger.kernel.org>; Tue, 27 Jan 2026 06:30:58 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769524258; cv=none;
        d=google.com; s=arc-20240605;
        b=JPYRZrLCfxNIOoHjgXcJkTehajJvEUrgfGaG/dTlwPtPnwH0rt82KW6mdIgezOQARD
         GVNc7qCcb+QfNoVWHG5EY3IlFKX4hWBEKBe/qS/jsJKTcyjbxhtl/h3moXHqdtJt0yT+
         0qgUqZankcH8ojG/z4mpopqkO+Jlb5MxmkHw4+xJPXQw9OtIksz6/6PzOuxRuXEXGgkl
         B18CJncna1SeLJTpC1Smx8C4fDYRtuajnpFTh6Rv6T5imShfjpMz/7veowgAK9Jn8haG
         wYqtUzhnii5w+OTkotM/WEVeb5qUyp029z667bxeh15CzHRVfpfKvozG6AyWH3S4NWSQ
         fpVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=lFyubrDcBylJR63Yd/XGljSBiwiYbuY900HDnys/iak=;
        fh=PQ+zEws8VT2XsuOSDc+TnhQj87xD1JU16bHiwdvcCWs=;
        b=EvcOB7zV6G8ajyFuEDCiDVBzmiqq+cjhnjyPbSm7eL6njETfUd3N8W0XL7DoHHhlU0
         HswTk8AJT008lyxXvvfB79uwvvNmRebXA1lis62TillDLbR3WKST7ILn1jiek8ZQpnMf
         S1Sn51v5ma3XYQB5+LKQJPEemTf9aiOxEWlnpxAn2v+R2KJAzkbERqpT8I+qVAmYA1xe
         n9lh536SW3o5WxXtXUi1EzYZ7HhdjW5yyK5OTdrvInqNPsi6Ih9kYZddfo63O8wqMjPk
         J1u3zUJdk+TAF6ohXh5kUzSdGEXBbbpjbRNDUxGls5ssxIfClIFeJGYKF1UrslXkM3xZ
         HoHw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1769524258; x=1770129058; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lFyubrDcBylJR63Yd/XGljSBiwiYbuY900HDnys/iak=;
        b=UrI1Pd4IPugpem4HPJfJXlQMlWX6aj69E1mR6VFoqA7ZFvC1MvYiVCvcg3yGgVmyaO
         awRjaG9fczBF5Y2VNkO/vyfFOqphG6Cv+3rNcD65WgHu7Gq9XvmAwIvCVhqs+KvXMpEO
         jhbeahL0iAc+mbKVsRfdeGrWkJKt0nj4R5D6yTo/GRFqNx2ScMMyyc5CEiwQ7tzOXIA1
         ZGQ9rCGMKAYWShY/jB/at3ImQpOGLWEtsMMMUj2/MFEHQ6kT3HR8LNresKlng4ShZIDZ
         3FvSgpZI6qQnTfU7xkV93bJst3nOrARuKdWfPdjbu5fStWNt+CMEu9RRSeiBT8xA52Zs
         FXcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769524258; x=1770129058;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lFyubrDcBylJR63Yd/XGljSBiwiYbuY900HDnys/iak=;
        b=qFh/BHNPd0jfMspS+piTfS7l7gY2KApVSgi3cRf4UlcLEncUJNgEpYISJCjSExbilC
         RdCXsJwfN8rlDIsyyrAi3GIrbqT8jXcXiOUWkNATlCP0JHV7nV/Jo+y/AC4YGJrYmQJh
         5wHMvst3eSiU5Cu1zCar/xL/0s80cCTDYScG6/x6r63BMJSlxi1CpxHQxEmzHh+h6HQl
         GVSioU9Ffz+X7wjYsu2LaO+5fGPMu14Rpk3+N5nBz0yLt12zPV3woW7Xb4AdL64GtAhV
         fYcAVGwwENkk2/vO14yUCauWIBMz9yluYtYTAPyqUF/qbFH3/rLpHXvx48sHQrXGY/2z
         UDow==
X-Forwarded-Encrypted: i=1; AJvYcCV4J57ya+IAEx8zXJzAE3Zy5tXCjMcu6Sh9R2y4B2ItEoCiiTUhdsBAWBwqPrXJ6Nodkskgp+8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxUEFAiMa/6FRn+SyjlQ5wtxrmd95R7HUzaVat9u6WkeeDvX5HN
	4Z+8JUKXA68W+PuwP27KQTegwHEWJNSWb1PelnN38P2B+ei4NvxwZtdrFJwmfp+is0BaiVKrhcP
	5lXJgQRYCnLJxGuBQWdz7RFtAxCUcF36oqgzC4/NP
X-Gm-Gg: AZuq6aJXoY9WZqfeO0q1fKmDXe+Vkd+vwsnhvn+N1qiyFQGRsGvQuodPVdZKSV7vA/3
	qpoKUsi4IVIIT15FAlCg6ZIcel2mst4xPEVIkQJ6Ck8spOobj9lKWjbosZrBZNUJQqxI0pmY411
	/ITnT5sXgdQNulVRtTsAG87jXsqJF2Oq2BH7NZohto5dk7Ti9qPBCkRYxcca6Ei2al/41TkQ109
	UU6DoRxXkVv9PujbG3ojB8WyM1HQoIk0tUb9gxDoy9KNff5YBvKeZWQ6ov9RIED8foAn0U7X97/
	k3C/V/Roh8Zq99jf6w5dHeU15j7AWUIvrVp3p0kwSZ8nlFW3rwW0vq6ra1JiHkPVGqFOMcvrgMY
	KO8yrWWsgKqrv1UbJk5bO
X-Received: by 2002:a17:90b:51cb:b0:340:a5b2:c305 with SMTP id
 98e67ed59e1d1-353feccf407mr1736081a91.2.1769524257987; Tue, 27 Jan 2026
 06:30:57 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260127-ima-oob-v2-1-f38a18c850cf@arista.com> <16c446c001a96a9878ddec9726430d7001c3f47b.camel@huaweicloud.com>
In-Reply-To: <16c446c001a96a9878ddec9726430d7001c3f47b.camel@huaweicloud.com>
From: Dmitry Safonov <dima@arista.com>
Date: Tue, 27 Jan 2026 14:30:46 +0000
X-Gm-Features: AZwV_QiPE-wr7bzvtCNR8Zj6-bvGnDiuzbDIAnCn8Y0x5J3sx1pzHd8HlA92AzM
Message-ID: <CAGrbwDQWo8Eebtu4FHsahtJTOkw4jXgncm4paFY6uyU_GkqVtQ@mail.gmail.com>
Subject: Re: [PATCH v2] ima_fs: Avoid creating measurement lists for
 unsupported hash algos
To: Roberto Sassu <roberto.sassu@huaweicloud.com>
Cc: Mimi Zohar <zohar@linux.ibm.com>, Roberto Sassu <roberto.sassu@huawei.com>, 
	Dmitry Kasatkin <dmitry.kasatkin@gmail.com>, Eric Snowberg <eric.snowberg@oracle.com>, 
	Paul Moore <paul@paul-moore.com>, James Morris <jmorris@namei.org>, 
	"Serge E. Hallyn" <serge@hallyn.com>, Silvia Sisinni <silvia.sisinni@polito.it>, 
	Enrico Bravi <enrico.bravi@polito.it>, linux-integrity@vger.kernel.org, 
	linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org, Dmitry Safonov <0x7f454c46@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[arista.com,reject];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[arista.com:s=google];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-211834-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_CC(0.00)[linux.ibm.com,huawei.com,gmail.com,oracle.com,paul-moore.com,namei.org,hallyn.com,polito.it,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dima@arista.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[arista.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arista.com:dkim,mail.gmail.com:mid,huaweicloud.com:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0A51995BCF
X-Rspamd-Action: no action

On Tue, Jan 27, 2026 at 2:28=E2=80=AFPM Roberto Sassu
<roberto.sassu@huaweicloud.com> wrote:
>
> On Tue, 2026-01-27 at 14:18 +0000, Dmitry Safonov via B4 Relay wrote:
[..]
> >       /* 2nd: template hash */
> > -     ima_print_digest(m, e->digests[algo_idx].digest, hash_digest_size=
[algo]);
> > +     if (algo =3D=3D HASH_ALGO__LAST)
> > +             ima_putc(m, "0", 1);
> > +     else
> > +             ima_print_digest(m, e->digests[algo_idx].digest, hash_dig=
est_size[algo]);
>
> No need, the last one is ok with ima_tpm_chip->allocated_banks[algo_idx].=
digest_size.

Cool, let me check it and I'll update it in v4.

Thanks,
           Dmitry

