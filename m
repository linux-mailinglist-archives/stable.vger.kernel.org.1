Return-Path: <stable+bounces-222917-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QCt5Kj4bp2m+dgAAu9opvQ
	(envelope-from <stable+bounces-222917-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 18:32:46 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE211F4A6F
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 18:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8D09D3015D24
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 17:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E99F428499;
	Tue,  3 Mar 2026 17:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKZ7IED+"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E833E7162
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 17:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772559163; cv=none; b=JP78lR20CGm3ZnGbiAyaxvOJpvBUCtIvtBHsjDk+MR9pupIAlm7u5cdyjeTi0SGP1BBXUBUMRSzrmIJLvV9jqmN87Qx3r9ecfp/d7Ufjz0PCjXW61Cy4X8DphCXFX7jwgDvMqULVfuAvhig+yL1EzLNYVVvclSe9ako5bIgxSQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772559163; c=relaxed/simple;
	bh=QSLfbdC0sQ6OKC02upcBtCsQq8vNKhZu69qDiniK9ck=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=fHqNbtRGGU8UanwO0ItEPh1+YXTDIoUOUPJ7hiBIc6ptrWvmA+NyN0mWtpqRHtyEnHfC90njH/I+SARIdaf0u2VlqqsQcwjCQoS9XqSndCwVYtjEq4sM06Xzb0YLcrLMZLGgvL3eFxFcf7Zkvc9CRS5YsZpi3rJarYjSSi5fF2Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKZ7IED+; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-483abed83b6so49755565e9.0
        for <stable@vger.kernel.org>; Tue, 03 Mar 2026 09:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772559160; x=1773163960; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MsWzxLM40+G5660pg9qYSB4crP9FXQmc2eGQLniMFbc=;
        b=PKZ7IED+XFvhfCa+KHo+vDWcqJpVpkR9+TSZnfYebxicBGuut7s/Nk+gmjFsqTYvob
         FA/NQRzJPgtp8BvtaAYX6VzINBmMCnHnYTjay/jOtncwqUy0U6FQZDS/9DzhrT+EFq/P
         UdwsOK49zVQRjo3ZZeddvz8XLpdbJ7K4e+t1Xapz8yk8TCph/O8kq0ZHIQ5qgS8W/9/G
         g8zstyXk9JyQaX5hVxJQ68XsIxP85Kzqenl4exflMwy4HIp68pyyy3TngzyqKGkc4fCU
         6J0nQqRZWlPFirq/no2NTVaQ7aAvFnbmVP3gF5QSwbUN4vODeuqh/Un1erlf8erSkgxY
         HuEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772559160; x=1773163960;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MsWzxLM40+G5660pg9qYSB4crP9FXQmc2eGQLniMFbc=;
        b=CmPERpEcGt8X4tuk0/XSiaX802oCO+RpWo8ascPdOQtQHu0CJJZ1JAHim5yEmJJw/L
         uBSfF7hXFUhp+uuu191/F7Wtf6t7/jXg75DJ0Nu4rxZK32AiB6j3Ui/l/Al5KegvRsUz
         WJ6PkxbA1DCJnClUcp4oBEmGvCPeE1CPAW7jBIQMiJZyA8ZPQ6cP+vvZySnIKG0rlmZO
         uy2zcTHWGX8vK9fjHtZkqNxpV7GYCGsw9ExW6tXW7PS/wlOuhI5yQhtk5IKZKw+QySn0
         cxt8f5+ACW6F1eXhWbCThzNQWTuPQp7BdEh3tA2C9LdCfXPJhcZOrtfuPsbcos4Ktr+Z
         EXnw==
X-Forwarded-Encrypted: i=1; AJvYcCUMdMCjdfOAw2cYNYOtHjQN7IZIxT3FWHLYdPSXIQq0Rks8oqI0bYOqoxnubQo/emqi49dYjI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypcFrX56RKKSojj2ht3WgU2Lr/Yzip6NMBn7ymGU9ZL/kzA91O
	hTQT0KOtZCaP+piwu9DYu2WS9sxXfFaWBilRjNu4nYFB3uwWcjGwwA0j
X-Gm-Gg: ATEYQzyqXKTJbEMx2pQuK8ubcgUmxn+9pMdTTMepLJ9aRAnJhTP1U/6vxxVD48RP0Bw
	NXOMjPZBvrxSuXYP/bmQAVckmUCnskbsxULFF+AbN39NCDsEN8tY/Osx189pky9q96l6bKZOzyT
	UiPMzoJWqln/odJZG8pL3OBKE9WYPYskTu8Fv4tAPVAXSrNStyf1WTK36We8+XlnY98alRjQoGu
	dGSvWjh3K1WC0o77ivmiyDjN8Cj//qCvJUKC4HH4m/idfPKdXp2nNFNQz+Ba5EYvXbgk504FoEt
	31wRtSUH+BWF4uZbgHwRkFUmQlVrV2tOTnIOKOiQaQ0TU7TC8Vafxh6ladlQ1TvxJu4+wDNYhKP
	voiIKphJ4avOl6HnTAz1h7W2oNVzcB5Fg8P2ge94Ryysh39Ktj1y0CJXJBLTmvrtlsYrsmJsK+1
	4312Z62BOZDs35RIAkIinONEKdky27JnjN/X3LVGZV
X-Received: by 2002:a05:600c:674f:b0:477:df7:b020 with SMTP id 5b1f17b1804b1-483c9bde826mr284998005e9.18.1772559160210;
        Tue, 03 Mar 2026 09:32:40 -0800 (PST)
Received: from holly.home.arpa ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-485133a9511sm24583545e9.17.2026.03.03.09.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Mar 2026 09:32:39 -0800 (PST)
Message-ID: <ce07b65b86473acac101c4854f6201d05597d48c.camel@gmail.com>
Subject: Re: [REGRESSION] 6.19.4 stable netfilter / nftables [resolved]
From: Jindrich Makovicka <makovick@gmail.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>, Genes Lists
	 <lists@sapience.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, coreteam@netfilter.org, 
	netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	stable@vger.kernel.org, regressions@lists.linux.dev, "Kris Karas (Bug
 Reporting)" <bugs-a21@moonlit-rail.com>
Date: Tue, 03 Mar 2026 18:32:39 +0100
In-Reply-To: <d43b9da4-99ee-4516-9bec-71a9de19618e@leemhuis.info>
References: <a529a6a9a2755d45765f20b58c5c11e2f790eacb.camel@sapience.com>
	 <45f03b0b-fe8f-4942-bad1-3fbde03d4be1@leemhuis.info>
	 <143e1a402ad78dd7076516a6ceb637f378310b16.camel@sapience.com>
	 <10537f2b74da2b8a5cb8dc939f723291db39ff84.camel@sapience.com>
	 <2026022755-quail-graveyard-93e8@gregkh>
	 <b231fcdb6c66a7b24dcef3ee5c35c5f612d5c1a7.camel@sapience.com>
	 <9d110d860c0c7e110d018ea53a7666eba275da20.camel@gmail.com>
	 <d43b9da4-99ee-4516-9bec-71a9de19618e@leemhuis.info>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 2CE211F4A6F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-222917-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[makovick@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 2026-03-03 at 08:31 +0100, Thorsten Leemhuis wrote:
> On 3/3/26 08:00, Jindrich Makovicka wrote:
> > On Fri, 2026-02-27 at 08:39 -0500, Genes Lists wrote:
> > > On Fri, 2026-02-27 at 05:17 -0800, Greg KH wrote:
> > > > On Fri, Feb 27, 2026 at 08:12:59AM -0500, Genes Lists wrote:
> > > > > On Fri, 2026-02-27 at 07:23 -0500, Genes Lists wrote:
> > > > > > On Fri, 2026-02-27 at 09:00 +0100, Thorsten Leemhuis wrote:
> > > > > > > Lo!
> > > > > > >=20
> > > > > >=20
> > > > > > Repeating the nft error message here for simplicity:
> > > > > >=20
> > > > > > =C2=A0Linux version 7.0.0-rc1-custom-1-00124-g3f4a08e64442 ...
> > > > > > =C2=A0 ...
> > > > > > =C2=A0 In file included from /etc/nftables.conf:134:2-44:
> > > > > > =C2=A0 ./etc/nftables.d/set_filter.conf:1746:7-21: Error:
> > > > > > =C2=A0 Could not process rule: File exists
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xx.xxx.xxx.x/23,
> > > > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^
> > > > > >=20
> > > > >=20
> > > > > Resolved by updating userspace.
> > > > >=20
> > > > > I can reproduce this error on non-production machine and
> > > > > found
> > > > > this
> > > > > error is resolved by re-bulding updated nftables, libmnl and
> > > > > libnftnl:
> > > > >=20
> > > > > With these versions nft rules now load without error:
> > > > >=20
> > > > > =C2=A0- nftables commit de904e22faa2e450d0d4802e1d9bc22013044f93
> > > > > =C2=A0- libmnl=C2=A0=C2=A0 commit 54dea548d796653534645c6e3c8577e=
af7d77411
> > > > > =C2=A0- libnftnl commit 5c5a8385dc974ea7887119963022ae988e2a16cc
> > > > >=20
> > > > > All were compiled on machine running 6.19.4.
> > > >=20
> > > > Odd, that shouldn't be an issue, as why would the kernel
> > > > version
> > > > you
> > > > build this on matter?
> > > >=20
> > > > What about trying commit f175b46d9134 ("netfilter: nf_tables:
> > > > add
> > > > .abort_skip_removal flag for set types")?
> > > >=20
> > > > thanks,
> > > >=20
> > > > greg k-h
> > >=20
> > > - all were rebuilt from git head=C2=A0
> > > =C2=A0 Have not had time to explore what specific change(s)
> > > =C2=A0 triggered the issue yet.
> > >=20
> > > - commit f175b46d9134
> > > =C2=A0 I can reproduce on non-production machine - will check this an=
d
> > > report back.
> >=20
> > I had a similar problem, solved by reverting the commit below. It
> > fails
> > only with a longer set. My wild guess is a closed interval with
> > start
> > address at the=C2=A0 end of a chunk and end address at the beginning of
> > the
> > next one gets misidentified as an open interval.
> >=20
> > commit 12b1681793e9b7552495290785a3570c539f409d
> > Author: Pablo Neira Ayuso <pablo@netfilter.org>
> > Date:=C2=A0=C2=A0 Fri Feb 6 13:33:46 2026 +0100
> >=20
> > =C2=A0=C2=A0=C2=A0 netfilter: nft_set_rbtree: validate open interval ov=
erlap
> >=20
> > Example set definition is here:
> >=20
> > https://bugzilla.kernel.org/show_bug.cgi?id=3D221158
>=20
> Does that problem happen with 7.0-rc2 as well? This is important to
> know
> to determine if this is a general problem or a backporting problem.
>=20

Yes, the same problem shows up with 7.0-rc2. I updated the bugzilla
attachment to reproduce the bug just by feeding it to nft,

# uname -a
Linux holly 7.0.0-rc2 #25 SMP PREEMPT_DYNAMIC Tue Mar  3 18:17:21 CET
2026 x86_64 GNU/Linux
# nft -f test-full.nft
test-full.nft:1643:1-25: Error: Could not process rule: File exists
12.14.179.24-12.14.179.31,
^^^^^^^^^^^^^^^^^^^^^^^^^

Regards,
--=20
Jindrich Makovicka

