Return-Path: <stable+bounces-227382-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KO7xKcxlvGmYyAIAu9opvQ
	(envelope-from <stable+bounces-227382-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:08:28 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A4DF2D2854
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 22:08:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B87D7316261C
	for <lists+stable@lfdr.de>; Thu, 19 Mar 2026 21:07:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9647D3E92AF;
	Thu, 19 Mar 2026 21:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b="Mf2WIcBL"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C212C3AE707
	for <stable@vger.kernel.org>; Thu, 19 Mar 2026 21:07:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773954465; cv=none; b=mlcZAXgY9wBwZaO8c3oY9HqSEGevfs8e8UIu5K71w2OlcoQDZJ+byXgTIq95wCKcgsfowHhIdpGVYe7YaYeC9VcWowTYy2iy+T9ONPjoMxKBIS3q83MdAGWZz/AUQtRGT5msoCf9nS/wWbaJRLLFWuE2U3CuH2kRf2FQv6RMpGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773954465; c=relaxed/simple;
	bh=LIdSmF74+Qy782y4OxXihWI2ikJ7KUlQNEOCOpP650Q=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Vbo8Yn6O2oRq8rq+FLNwgBMSd4wjrFymzQ8jNMIhxk75AEMh4MYCeCTirWn9elZm0vtzSIywHlrVA+np/SRxoiov4XSp+7fTH6TWsLwAA48z/50KjxuhFYTTVmmzRnuZqkuedyE8cHbKpLn1SrREb6/QCq+eiEUtv2TMn8aE1vM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com; spf=pass smtp.mailfrom=dubeyko.com; dkim=pass (2048-bit key) header.d=dubeyko-com.20230601.gappssmtp.com header.i=@dubeyko-com.20230601.gappssmtp.com header.b=Mf2WIcBL; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-64ae2ce2fe1so1691300d50.1
        for <stable@vger.kernel.org>; Thu, 19 Mar 2026 14:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20230601.gappssmtp.com; s=20230601; t=1773954463; x=1774559263; darn=vger.kernel.org;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=W/lLYyO9dsamcqErAahsDucntHDQrTPdMXAJL7p0IXg=;
        b=Mf2WIcBLa7cZxRkOf4JSeRgVwhntFFba4OeVjGaGwlbvS/3a1f5z715wl9NzEfLA/7
         nC6NZtP5WjdonIH+xiGFKXSEp9hpWetw65aQYzRAeRVUAf8aln03gTPmrZdmSqpkaqyc
         1oN1HmlQ5/1VDxBcw/EVKF6ljsNRPq6wtQi8OVuG47Qt1OcmVEUOAEY1sOhzoM6gNftr
         46MY4lBC98U22D2thrBZfKEbo/51GTkDS+SSjU8igv4SUuMKkAR6vvK8xH/ZX+Lcb+RJ
         f1BMn+lYAmSAIUq4cref5Z5hLQqOmz517/GhVMgIUxN2Gqp6hMYgvxjxBIrKER+cs1pJ
         G9Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773954463; x=1774559263;
        h=mime-version:user-agent:content-transfer-encoding:autocrypt
         :references:in-reply-to:date:cc:to:from:subject:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/lLYyO9dsamcqErAahsDucntHDQrTPdMXAJL7p0IXg=;
        b=rzHkJkROxBmD8+UvmG7oN0KClyvxvYZXaK+RxP+81xI++aWLffQF1TsjQG77iiOehz
         wM/qcJvOfSU3NU0WFgImJrcx9BboMakUaOhjtGdgBcXWpIlTrtplceOcaFG5jHVFaK34
         U/cL2gFt2vcy8rHiOcuzKi/GN0kgYkNB8XCdWVamIgSBBBxwFR6Jq5bgow/nW+yGSAac
         dLx2oK7taTJIgj0xDaCjQMeipv70zrS+ij8gnkh/wMvKsI2UiGq2qYjwDkMCJPPuKsk2
         HriHwosNEaUIy89J5cnQf72LFG5Abm+mg47ehBvNk8IgIyYRxd9vhmrBCX8hTD+NCC2p
         5DPA==
X-Forwarded-Encrypted: i=1; AJvYcCXBTawZUrlOFUKqCudP0SsXGiYI8XNElENNj1LNXtvNonGaX++411M21e5hsZENKQaVXJlt9ZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxjUSTz04NyfkmpwiZgvk7oR4nIOoFSQGEbCraAzj4ykp/3IaKe
	fOWNo1bb1Tp3WXhuiHCxAl4j4EH9bodO/faJP6ad/QqkQeo0Lxlg/PpX3eA25A/6ZuM=
X-Gm-Gg: ATEYQzzRl5tZn5BTmz8nTMGSYhnnwKTTzaVcgQ/2u31VbQDh7ZjNO1ewddzO68AHx/O
	ktOGHc4vT4vOR71IIgJO+qYYT7dcyy8Up1i3hRtsR5BtVmpirGfeQpqqmZZDGloBMGvuwqM3993
	n48K2N4nIqZgn67yv+vmgS4lNu3ZbLCq86+azWDLt9kTKDe55C+KiBxkBiALFn9dP3apFQRG/jP
	0NaDoVx3hpmk4fgtkmfyhYexQ8fF9txxb19LdVnyu/r56VjaztOee50XLsjCprH4c5YdbTTZXTF
	J3RvTgVcZQhDpJn/tmOuqw5jqAw5JxAQXkzYFD1uSOIxTPrrVX4rswHdXebpnYHtF/KT402yY/o
	Ws7FiRCmr9mECn5wBsvCV6yJjnuAbozy6VwCIQW1ynLMYh6PBk7M3kiBBlWIQCcco2zx9LOIAi+
	0HkUoe3EXitKGoQB+5Y0Q6b7cUGhlYDQ5Dru4JPA3HGX49ndnFSc7DBTh48nFTxMH/C4fhADi09
	VJt5eMGjq4hZjvylcuN3nhBepiXcrI6ROuNbiq0abUAluWl5BtE0PVKOg==
X-Received: by 2002:a05:690e:1914:b0:64e:599d:f0d7 with SMTP id 956f58d0204a3-64eaa698146mr1116512d50.9.1773954462671;
        Thu, 19 Mar 2026 14:07:42 -0700 (PDT)
Received: from ?IPv6:2600:1700:6476:1430:34be:535:4e85:feb4? ([2600:1700:6476:1430:34be:535:4e85:feb4])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-64eabbf8503sm202244d50.0.2026.03.19.14.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Mar 2026 14:07:42 -0700 (PDT)
Message-ID: <6f007d418831108fb75642d4c44d186ff7048a82.camel@dubeyko.com>
Subject: Re:  [PATCH v2 2/2] hfsplus: extract hidden directory search into a
 helper function
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: Zilin Guan <zilin@seu.edu.cn>, slava.dubeyko@ibm.com
Cc: akpm@linux-foundation.org, frank.li@vivo.com,
 glaubitz@physik.fu-berlin.de, 	jianhao.xu@seu.edu.cn,
 linux-fsdevel@vger.kernel.org, 	linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Date: Thu, 19 Mar 2026 14:07:40 -0700
In-Reply-To: <20260319144955.648380-1-zilin@seu.edu.cn>
References: <e86980b8682bb9ea007d9fdfab8a8530781ebb2b.camel@ibm.com>
	 <20260319144955.648380-1-zilin@seu.edu.cn>
Autocrypt: addr=slava@dubeyko.com; prefer-encrypt=mutual;
 keydata=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
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (by Flathub.org) 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[dubeyko-com.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[dubeyko-com.20230601.gappssmtp.com:+];
	TAGGED_FROM(0.00)[bounces-227382-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[dubeyko.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[slava@dubeyko.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.997];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,dubeyko-com.20230601.gappssmtp.com:dkim]
X-Rspamd-Queue-Id: 0A4DF2D2854
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, 2026-03-19 at 22:49 +0800, Zilin Guan wrote:
> On Wed, Mar 18, 2026 at 10:33:47PM +0000, Viacheslav Dubeyko wrote:
> > On Wed, 2026-03-18 at 23:00 +0800, Zilin Guan wrote:
> > > +static inline int hfsplus_get_hidden_dir_entry(struct
> > > super_block *sb,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 const struct qstr
> > > *str,
> > > +					=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 hfsplus_cat_entry
> > > *entry)
> > > +{
> > > +	struct hfs_find_data fd;
> > > +	int err;
> > > +
> > > +	err =3D hfs_find_init(HFSPLUS_SB(sb)->cat_tree, &fd);
> > > +	if (err)
> >=20
> > Why not unlikely(err) here too?
>=20
> Right, I'll update this in v3.
>=20
> > > +		return err;
> > > +
> > > +	err =3D hfsplus_cat_build_key(sb, fd.search_key,
> > > HFSPLUS_ROOT_CNID, str);
> > > +	if (unlikely(err < 0))
> >=20
> > The hfsplus_cat_build_key() return error code or 0. So, we can use
> > unlikely(err)
> > here.
>=20
> Agreed.
>=20
> > > +		goto free_fd;
> > > +
> > > +	err =3D hfs_brec_read(&fd, entry, sizeof(*entry));
> > > +
> > > +free_fd:
> > > +	hfs_find_exit(&fd);
> > > +	return err;
> > > +}
> > > +
> > > =C2=A0static int hfsplus_fill_super(struct super_block *sb, struct
> > > fs_context *fc)
> > > =C2=A0{
> > > =C2=A0	struct hfsplus_vh *vhdr;
> > > =C2=A0	struct hfsplus_sb_info *sbi =3D HFSPLUS_SB(sb);
> > > =C2=A0	hfsplus_cat_entry entry;
> > > -	struct hfs_find_data fd;
> > > =C2=A0	struct inode *root, *inode;
> > > =C2=A0	struct qstr str;
> > > =C2=A0	struct nls_table *nls;
> > > @@ -565,16 +586,11 @@ static int hfsplus_fill_super(struct
> > > super_block *sb, struct fs_context *fc)
> > > =C2=A0
> > > =C2=A0	str.len =3D sizeof(HFSP_HIDDENDIR_NAME) - 1;
> > > =C2=A0	str.name =3D HFSP_HIDDENDIR_NAME;
> > > -	err =3D hfs_find_init(sbi->cat_tree, &fd);
> > > -	if (err)
> > > -		goto out_put_root;
> > > -	err =3D hfsplus_cat_build_key(sb, fd.search_key,
> > > HFSPLUS_ROOT_CNID, &str);
> > > -	if (unlikely(err < 0)) {
> > > -		hfs_find_exit(&fd);
> > > -		goto out_put_root;
> > > -	}
> > > -	if (!hfs_brec_read(&fd, &entry, sizeof(entry))) {
> > > -		hfs_find_exit(&fd);
> > > +	err =3D hfsplus_get_hidden_dir_entry(sb, &str, &entry);
> > > +	if (err) {
> > > +		if (err !=3D -ENOENT)
> > > +			goto out_put_root;
> >=20
> > The hfs_brec_read() can return multiple errors (for example, -
> > EINVAL). Are you
> > sure that this check is correct?
> >=20
> > Thanks,
> > Slava.
>=20
> I see your point.
>=20
> The current logic follows hfsplus_lookup(), where only -ENOENT is
> treated
> as missing, and other errors are propagated. The original code
> effectively=20
> ignored hfs_brec_read() errors and continued as if the directory was
> missing.=20
> For critical errors like -EIO/-EINVAL/-ENOMEM, failing the mount
> seems safer.
>=20
> If maintaining the legacy behavior is preferred, I can map all read
> errors=20
> to -ENOENT inside the helper instead:
>=20
> 	err =3D hfs_brec_read(&fd, entry, sizeof(*entry));
> 	if (err)
> 		err =3D -ENOENT;
>=20
> Would you prefer to keep the legacy behavior, or is propagating the
> exact=20
> error acceptable?
>=20

I think we can return -ENOENT if hfs_brec_read() fails and continue as
hidden directory is missing. Let's follow to the current logic for now.

Thanks,
Slava.

