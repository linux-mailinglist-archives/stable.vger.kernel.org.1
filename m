Return-Path: <stable+bounces-272994-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id lv9rGQXZT2qIpAIAu9opvQ
	(envelope-from <stable+bounces-272994-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 19:23:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B93F0733CCB
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 19:23:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="hGO/Yqow";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272994-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-272994-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 850FC303B724
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 17:20:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F46643CEEB;
	Thu,  9 Jul 2026 17:20:51 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f178.google.com (mail-qt1-f178.google.com [209.85.160.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2DEE438023
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 17:20:47 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783617650; cv=pass; b=bmhTKvaWKWUtT7PAiCgIq9McbmKbuhysmyoW5Ajemfq23Y9rZvc34AuzLAoBdgaoMMWi+LZ7LaiC9ujFGtq/b/6CMPbQm2ohRwCcDCMwS1qwkFMt9aqdD8+pR7tUKY+IF8fVirlEOAyMlyWVnjZBeeRGXF/hY0qNHwJAaMnoeDw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783617650; c=relaxed/simple;
	bh=hZEcX9rblnHI1tsJplsNee/jZEe49yUqRXD5BZMzDas=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jYrqoFDOA4wOo8/tIolBpAmz6BTxzstplFagMgIGgqFPgqAbD9nD7xJTYDYlCtmpU13Fxc2SnTVbnfvo+6oc1ZMPwNUftCCoQ65ilEhYziOzk0yT+edH32prDSU0Tn1h3JbJ45q21Wk4XAkPcR8HlX1h8x9D+uqGuH7dHEB51fo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGO/Yqow; arc=pass smtp.client-ip=209.85.160.178
Received: by mail-qt1-f178.google.com with SMTP id d75a77b69052e-51c167c58f2so224411cf.0
        for <stable@vger.kernel.org>; Thu, 09 Jul 2026 10:20:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783617646; cv=none;
        d=google.com; s=arc-20260327;
        b=WoP+emQ7QD4zU1g2oH7OJQYX4u82fHYgUbxc9MySzDEFoP9JioYZV76iT8FiAk4ZIk
         4pPxicEnahDwbEl3hLysC+eh3dmOpgZS0NQqJBTBYvDTHcJSnY8fazozd8jWqN85bGab
         P7OrquuHgAr/8k33EL3DO9wn6beldpBU6aHb/96OGtQabVNATKXukllJgl34tQAArTJJ
         Vo3VdI6wevAAptDJyj0yvKTKVQ92Fw94MLqa0CyfIqKeLu+KTydJfkdTTOUz1e0ckY3t
         oEXSTfkw30waSDk7bAUJ1GOH7g8rqcjl8gRI3GKSmqhEXiEgjtttkRXdJANSARPFnpk9
         3qxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jQaRVb2grf2n8MZJwInN/ZiH3PD15ePDY6cdHPu1aO4=;
        fh=hmwDeSgSUVU2I6ldhfjYgFa8jTeFiqco241jmRDNk40=;
        b=m9ZouAL/1zL/LzFqOqcXJhNN4um7749KTDOBtCILaTfySWL/zZHGF4YbBbJRazEPPP
         8eahFHLwrcga9B3mpqjCW2iXsI0kOl5cB3QjjEFBmpmozmraZ14If1x1haAPyn3OZ+uc
         S6ga6VmgPQwEqoIcUnx74RDfAEJ2fXRhLTF9xyjOmUkn6Ky9+qjIHZiAdzjRN3vsSHiR
         wU3pqI7vLyvyBpJ3Yr2h7M4AMMmX8CMjt2ap25LFQrhYPoybksd74XysXk7Vhvl/vbTP
         tj3gFn1qdiaHThPoGB2M2TBa+vaLfZJkjoJDowbO38Zq8NkHWmOK/w6wtQMROMHZKUQ2
         x9WQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783617646; x=1784222446; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=jQaRVb2grf2n8MZJwInN/ZiH3PD15ePDY6cdHPu1aO4=;
        b=hGO/Yqowmf+zfdOA3xkz0XnaQv9IVvY9bBvb7K1wrmz0BAb/00wVT4hLSJC3bD5xbt
         Zsgx7+nenuQdcPjghInQFPPlsC74wZsB4fW6ONEp7hKspjxomUpw6gJvzo4FEvmJ7zpA
         NVY4eXkDMcxvEVJLVNkBT44ZtLwzhGIbYrZ8TsWrfWzzO53Uf0TqyLeVYcaOL+yOJAmp
         vXacGI2LsJZkh2R2yhDc524gDPx1TOENsP5QltEcPL1O4tlHJYxqR9WhzMdIdnXQ2W8C
         p5CpAaQLsAE/rpkm5Z2Ih9nIsTnY1b3HNQJdk/XZCeD1JzePWnuEVH3XsW2ifmZM+Kxy
         xAqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783617646; x=1784222446;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQaRVb2grf2n8MZJwInN/ZiH3PD15ePDY6cdHPu1aO4=;
        b=RfN6u73XvC+JGySAZhXZO5U81s5GWtBZmHxC8ra5GqW1PNl5jaRfS87kuG4fJHVDPw
         4HxRD0yLa2//CjMPUTscRoJxvRejZJpdlw5dms0qpsbR9AhjuIOKGvIczWiOB4idkv2c
         LjpcrsIjnCau8NEZfYTVjjSy0zTR/AhkThUvGTKEQJljmys8/RWzI76flZt5Wo+0eXJm
         GMA62sOMarA6uMS28hsrOod4RGEnaKzu1fJ7Qll3b3fA/9q1wRM1+PjRCqfCuBsRWsYA
         18UUr+yzY+NcV8oHoYBb4LjR2pqFwwWiBwhW010mHdY8WsFKozDCW5KAS01sNMHT7GLN
         Fk0g==
X-Forwarded-Encrypted: i=1; AHgh+RrQbOR73DRWWsRj2dB+4ToMq0Kecgn3vcpRz7Jpyxf+r7/QqehuPWPYwMODHB+kdIFAXVL6U5Y=@vger.kernel.org
X-Gm-Message-State: AOJu0YxZzIVXp+8i8uQfLt8ItgWCwclmviNjbUyUcGfcNUY5MvG9vsNY
	c5KocC4U6FBAUdvwv47/YutCaoOF7okWdOAFaAsrNmQr+16h+ieUlVxF298B0v+593cfXN9Kv6i
	NrFaxTn9Fs8B25QXh2VQTtRDZGnSLICM=
X-Gm-Gg: AfdE7cmZFfz/NLkYX1R1CeW9nbyef4TlwZAkmC473ISvmTdXtg+gwgAVpRu7rcfm2O+
	eW1MQffwgTRk7xGJLAghCHqpd/incM2pAdfUsjy3lE3VXilqeadWhtL1F8Z//858Wqyh/iMAc6k
	W+g3kz0bMMp8B0UvV3iiem4+/Tmo1TpBshkooGCHU3k8HtPsTZml3irFIoAHmlCvK80sBuK4Sw4
	QNF/FkCpERVan/wWtIeVEOXb66+/XPB51/e/aed9VcEaXrRi7Zi2mFirM42snq0cKpY925x7Nzl
	CgCiC5TzdX+1X6QT2gOCv0kqSt5NhphLrj4BHPWpFWbOr+39MjrFx3beyZXj1GxMxRPM6PqztRM
	Z811wyT4XNbka0zsPLfIv6QYs65T3+1UrzKGYnj3UAKhjS2VWKSCtOvjKhvDxGFWICgV1cTZH5M
	JJdGGa7kzDAzs=
X-Received: by 2002:a05:622a:5812:b0:51c:241f:a6ee with SMTP id
 d75a77b69052e-51c8b3f5885mr82413791cf.62.1783617645460; Thu, 09 Jul 2026
 10:20:45 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260709155440.2132459-3-doebel@amazon.de>
In-Reply-To: <20260709155440.2132459-3-doebel@amazon.de>
From: Steve French <smfrench@gmail.com>
Date: Thu, 9 Jul 2026 12:20:33 -0500
X-Gm-Features: AUfX_mxl_KFuVChnk7HcmXkZiK3KIvyhwjAH-myKz4uegSqaarxusCibAKEfqT4
Message-ID: <CAH2r5msvEGdEJvyV5sWcZjQ0SjMOwXP_Ad4eKN7etHtXS1vwbA@mail.gmail.com>
Subject: Re: [PATCH] smb: client: set SB_I_NODEV to prevent device node injection
To: Bjoern Doebel <doebel@amazon.de>
Cc: Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, nmanthey@amazon.de, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-272994-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:doebel@amazon.de,m:pc@manguebit.org,m:ronniesahlberg@gmail.com,m:sprasad@microsoft.com,m:tom@talpey.com,m:bharathsm@microsoft.com,m:linux-cifs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:samba-technical@lists.samba.org,m:stable@vger.kernel.org,m:nmanthey@amazon.de,m:linux-fsdevel@vger.kernel.org,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,vger.kernel.org,lists.samba.org,amazon.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amazon.de:email,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B93F0733CCB

Setting SB_I_NODEV is apparently not done for any remote filesystems,
and AI search confirmed that it probably isn't a good idea to set it
for remote fs.  It is more of a thing in pseudofilesystems and not
needed for network filesystems.

e.g.

"Is there any benefit to setting SB_I_NODEV?

Today, probably not.If you grep the kernel, you'll find SB_I_NODEV is
used in only a handful of places, and those places generally involve
pseudo-filesystems or internal VFS assumptions rather than remote
storage.  Setting it on CIFS or NFS is unlikely to change behavior,
because those filesystems have worked correctly for decades without
it. Most remote filesystems don't set s_iflags because almost none of
the SB_I_* flags are intended as generic filesystem capability flags.
They're mostly internal VFS state, and SB_I_NODEV in particular has a
very specific purpose.  SB_I_NODEV does not mean "this filesystem
contains no device nodes." It means something closer to:  This
superblock is not associated with a block device.
or more precisely: The VFS should not expect a backing struct
block_device for this superblock."

Has something changed?  How did this question about SB_I_NODEV come up?

On Thu, Jul 9, 2026 at 11:05=E2=80=AFAM Bjoern Doebel <doebel@amazon.de> wr=
ote:
>
> From: Norbert Manthey <nmanthey@amazon.de>
>
> Set SB_I_NODEV on the superblock by default for CIFS mounts. This is
> consistent with how other filesystems handle untrusted remote content
> and prevents the server side from injecting device nodes on the client.
>
> Fixes: 2e4564b31b645 ("smb3: add support for stat of WSL reparse points f=
or special file types")
> Signed-off-by: Norbert Manthey <nmanthey@amazon.de>
> Assisted-by: Kiro:claude-opus-4.6
> Cc: stable@vger.kernel.org
> ---
>  fs/smb/client/cifsfs.c | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
> index ea4fc0fa68cac..35eee2f9899d5 100644
> --- a/fs/smb/client/cifsfs.c
> +++ b/fs/smb/client/cifsfs.c
> @@ -208,6 +208,9 @@ cifs_read_super(struct super_block *sb)
>         if (sbflags & CIFS_MOUNT_POSIXACL)
>                 sb->s_flags |=3D SB_POSIXACL;
>
> +       /* Prevent device node opens from remote filesystem by default */
> +       sb->s_iflags |=3D SB_I_NODEV;
> +
>         if (tcon->snapshot_time)
>                 sb->s_flags |=3D SB_RDONLY;
>
> --
> 2.50.1
>
>


--=20
Thanks,

Steve

