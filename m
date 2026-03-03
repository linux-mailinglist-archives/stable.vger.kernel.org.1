Return-Path: <stable+bounces-222804-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EFTPOkuHpmkZRAAAu9opvQ
	(envelope-from <stable+bounces-222804-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:01:31 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B30E1E9EC5
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 08:01:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B17F83046B97
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 07:00:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA060386428;
	Tue,  3 Mar 2026 07:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i0A5ZN2U"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E7738642D
	for <stable@vger.kernel.org>; Tue,  3 Mar 2026 07:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772521258; cv=none; b=Pch8YjSt6er7c6pox8M/8BUrD5fqsCraPEEgSPfSHAyiZKciRgtUFqKEIBjZQM491SlObp3Ej1X3Q8I+xYEQ/bBlm4dRxE5Lkjk0LxaI7O+Ozvjd5gdOMVEPg171+bel6dc7uVkd9IBgk/2TbWAHr/3OUmQmzX0VOKfsVQET22w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772521258; c=relaxed/simple;
	bh=b9rnqGy35VMSCkesVvriXCdG6dEJtwn33l1f7OgUDJ0=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vx+WP8VAx5hVInISB3MDXgAK7xQn0zQ65Vr5oIFXKCEQtnrFBI11nUisy9S5q9aqtSprKnjVCPUql1REflN5EQwQUGxWK8qWGE5I1hcDZTEpTjRxc4zJJ53X3OFIHNExMY0Q4JeVi84bQsN5CN97RVNAtkGlEQObrmia8A27y7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i0A5ZN2U; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4806ce0f97bso44687275e9.0
        for <stable@vger.kernel.org>; Mon, 02 Mar 2026 23:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772521256; x=1773126056; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:from:to:cc:subject
         :date:message-id:reply-to;
        bh=8WrPNsxFmfZpCyYuZIoQyAgYSLblE5qZkSbhBEShgVI=;
        b=i0A5ZN2UlM2D0FAvZj0XmN+s/AXCNlwHYCKOgo5XUHDgq2briz4jJlTwd2aQiNJSjH
         nQF1oYS4UWt0PuUvM9acoQa6WKeEBWazfhlvAiENT6rcrU05suZ0dG0ct04Nooo0hJBg
         nR9pi5S6Y30PFcNYzDA/mb6DKRiLBEofRjBf+/pPVIbW1RWqJjPt3V4SKKSNUQ3KG4RG
         9eykju5Ny5l3GhJudVdCBWbqJyJUcoSOsa+VjlmSjGwAgCRjSesuFD9K7J2VylzdX6DB
         sD7nGZNBoG6oOimd+0dJxLhx1cuv6d1zRtnQsOh96f8eF1BDHqWTjbCluEW05zpZ9zOs
         G1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772521256; x=1773126056;
        h=mime-version:user-agent:content-transfer-encoding:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8WrPNsxFmfZpCyYuZIoQyAgYSLblE5qZkSbhBEShgVI=;
        b=ZwuSTiU6SjFQ+TfBBYDGuCBWdkol00j9gMPSVHQYRcEkj0OWlpEOzXYUES+nJU/y4U
         TsPGYQBt1cCijUZlpBjyOCobzd5JNJUcRMZIcO5/J4+g8TF+xgeiutmZ3lLSqRYJBpDi
         h7dPlRYLBEa10giqT8C6a/33Cyj2ko+jNM3DC6OCyCdeZ66Yy/I/koqHo2DuIz+etJzk
         TOJtk1BOfE65Q7rs3eHhw3OC3q4KBWbOV9FBVvmqLvwgz18uyG6hugri/arUVFuJ+uiH
         1PktgmAzmge8pooij8r6A61uk89QMzo4igm/zyZVL+AHZYTdMM9XSzx6tnn2l7UGgZrc
         IBig==
X-Forwarded-Encrypted: i=1; AJvYcCXgxTF1123TXhXGmlKvpL54J3HOvVfnKn7LSdhzJgNW53Lx4bqbqaWzQhemKFbaWtKAoVwldh0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyYkGbx6VWpkJyFGiY0/1WFbh4r33ErsbasCJ+NBKgiS4fWDa4K
	llnrhhhOg1waIv7ReMXWdc85+yk1uAeQdw1ySmneFpsA/3VzdFL7qk1+
X-Gm-Gg: ATEYQzyi0UC2MIMVnLD+k4r+JDw0j2SQxrDknQ/krSBIn8yATx8HCjxpuyvci7Qy6hD
	EbItp4w0Xgj7xmaFOqySmuw1qWAnfidRPzEb8z5z8FeH/a9vcYJL4Kn7VwEzMAakRSweAiqFNIs
	Awe12qx2qyIsRzurKcwWmNonmRx25EkEsqCKeR1t+aZOQhykEZbcRFT5fb3h69xDkh65inZAgz8
	EaaSc2jV+TDq8ZnocYCgSJL6mV5M3cKCS5MKprdeSzfiC26qDIPeMWnCE0PBfFP5g7XdsUUSXNX
	IEKTAEn8KbAcScd/Ly4/H4mMboI/YRRs1qej0Rmn56zY2stp5dW4Cqtrv/aKDNGTRNZyej4r+F5
	WOQ/yewc/6gH98PGnsD+HtN1IZOsD4dqjA/+ebQvzUrZ39oMteh8uI2qRWNqMzSxzGgTNYqulU/
	ATbyxHQKAe9+jRVYmOwQ1Tb0kJGjHqpSSGDDi8QhcC
X-Received: by 2002:a05:600c:4592:b0:47a:7fdd:2906 with SMTP id 5b1f17b1804b1-483c9bad6femr255088915e9.12.1772521255334;
        Mon, 02 Mar 2026 23:00:55 -0800 (PST)
Received: from holly.home.arpa ([2a03:ab00:1000:1b60:331a:b316:78f6:effc])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b4a121sm321462435e9.8.2026.03.02.23.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Mar 2026 23:00:54 -0800 (PST)
Message-ID: <9d110d860c0c7e110d018ea53a7666eba275da20.camel@gmail.com>
Subject: Re: [REGRESSION] 6.19.4 stable netfilter / nftables [resolved]
From: Jindrich Makovicka <makovick@gmail.com>
To: Genes Lists <lists@sapience.com>, Greg KH <gregkh@linuxfoundation.org>
Cc: Thorsten Leemhuis <regressions@leemhuis.info>, 
	linux-kernel@vger.kernel.org, coreteam@netfilter.org, 
	netfilter-devel@vger.kernel.org, Pablo Neira Ayuso <pablo@netfilter.org>, 
	stable@vger.kernel.org, regressions@lists.linux.dev, "Kris Karas (Bug
 Reporting)" <bugs-a21@moonlit-rail.com>
Date: Tue, 03 Mar 2026 08:00:54 +0100
In-Reply-To: <b231fcdb6c66a7b24dcef3ee5c35c5f612d5c1a7.camel@sapience.com>
References: <a529a6a9a2755d45765f20b58c5c11e2f790eacb.camel@sapience.com>
		 <45f03b0b-fe8f-4942-bad1-3fbde03d4be1@leemhuis.info>
		 <143e1a402ad78dd7076516a6ceb637f378310b16.camel@sapience.com>
		 <10537f2b74da2b8a5cb8dc939f723291db39ff84.camel@sapience.com>
		 <2026022755-quail-graveyard-93e8@gregkh>
	 <b231fcdb6c66a7b24dcef3ee5c35c5f612d5c1a7.camel@sapience.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-8 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Queue-Id: 5B30E1E9EC5
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_FROM(0.00)[bounces-222804-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Fri, 2026-02-27 at 08:39 -0500, Genes Lists wrote:
> On Fri, 2026-02-27 at 05:17 -0800, Greg KH wrote:
> > On Fri, Feb 27, 2026 at 08:12:59AM -0500, Genes Lists wrote:
> > > On Fri, 2026-02-27 at 07:23 -0500, Genes Lists wrote:
> > > > On Fri, 2026-02-27 at 09:00 +0100, Thorsten Leemhuis wrote:
> > > > > Lo!
> > > > >=20
> > > >=20
> > > > Repeating the nft error message here for simplicity:
> > > >=20
> > > > =C2=A0Linux version 7.0.0-rc1-custom-1-00124-g3f4a08e64442 ...
> > > > =C2=A0 ...
> > > > =C2=A0 In file included from /etc/nftables.conf:134:2-44:
> > > > =C2=A0 ./etc/nftables.d/set_filter.conf:1746:7-21: Error:
> > > > =C2=A0 Could not process rule: File exists
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 xx.xxx.xxx.x/23,
> > > > =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ^^^^^^^^^^^^^^^
> > > >=20
> > >=20
> > > Resolved by updating userspace.
> > >=20
> > > I can reproduce this error on non-production machine and found
> > > this
> > > error is resolved by re-bulding updated nftables, libmnl and
> > > libnftnl:
> > >=20
> > > With these versions nft rules now load without error:
> > >=20
> > > =C2=A0- nftables commit de904e22faa2e450d0d4802e1d9bc22013044f93
> > > =C2=A0- libmnl=C2=A0=C2=A0 commit 54dea548d796653534645c6e3c8577eaf7d=
77411
> > > =C2=A0- libnftnl commit 5c5a8385dc974ea7887119963022ae988e2a16cc
> > >=20
> > > All were compiled on machine running 6.19.4.
> >=20
> > Odd, that shouldn't be an issue, as why would the kernel version
> > you
> > build this on matter?
> >=20
> > What about trying commit f175b46d9134 ("netfilter: nf_tables: add
> > .abort_skip_removal flag for set types")?
> >=20
> > thanks,
> >=20
> > greg k-h
>=20
> - all were rebuilt from git head=C2=A0
> =C2=A0 Have not had time to explore what specific change(s)
> =C2=A0 triggered the issue yet.
>=20
> - commit f175b46d9134
> =C2=A0 I can reproduce on non-production machine - will check this and
> report back.

I had a similar problem, solved by reverting the commit below. It fails
only with a longer set. My wild guess is a closed interval with start
address at the  end of a chunk and end address at the beginning of the
next one gets misidentified as an open interval.

commit 12b1681793e9b7552495290785a3570c539f409d
Author: Pablo Neira Ayuso <pablo@netfilter.org>
Date:   Fri Feb 6 13:33:46 2026 +0100

    netfilter: nft_set_rbtree: validate open interval overlap

Example set definition is here:

https://bugzilla.kernel.org/show_bug.cgi?id=3D221158

Using nft from Debian unstable

$ ./nft --version
nftables v1.1.6 (Commodore Bullmoose #7)

Regards,
--=20
Jindrich Makovicka

