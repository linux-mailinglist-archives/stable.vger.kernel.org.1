Return-Path: <stable+bounces-259940-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id jeJGN2mPH2rNnAAAu9opvQ
	(envelope-from <stable+bounces-259940-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 04:20:25 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4044C6339F8
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 04:20:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=Ts02qBNu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-259940-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-259940-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 04E203022AB8
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 02:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCAC73D3D07;
	Wed,  3 Jun 2026 02:20:20 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1841E3A9632
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 02:20:18 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780453220; cv=none; b=FMwyUJ3RxOmKzSfkxjKa2f9WKHsl+1cjQIX9AiJdt7gBTWBDmMfiHegNZA1jOT06KyQCH6p5iXe2xsOqkgdoTx5AEg45ua9Rm9YKmfSz6vWaGelGbSXtgI0+NqTbeee2CX4i+iLikJUvr4EGNNjf22UEdP7VP7EjgmHvEl/GYz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780453220; c=relaxed/simple;
	bh=HgxEtv+A2qKraBVAuqP+/2iLx0+3LmLFpvkFLTooJAE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=b70C3xTyGQ9KOowYyaJpBA/TYcvV2fxHmJX0k7d7jxfqnF/O1RRQRUh5iIHUqR+F7ZMI1q2nBHOU9zT3RXzss+Kpi3mLoqJDL/nplHabYcNEHLV6pyWGC8UWTuxDXNUSbd9Iq6ukfCOZta0TizFivZcCzlbsBQNbe5qTbMuyrFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ts02qBNu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1C1E1F0089C
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780453218;
	bh=HgxEtv+A2qKraBVAuqP+/2iLx0+3LmLFpvkFLTooJAE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc;
	b=Ts02qBNu4eDgGECt4dv3TbrbDlX+7snlrk1F86/erHHSKzB92F2vJQ/sxD/OTxxcs
	 NJkkbugjxE8gjJKCH4jimG82H1PLHMoMYfhiAAqoWS8U7W314glaLmdEeQbooic9xz
	 2TXKxUbFUvx07n7ADjUUzcw8hr5zboC4vX9P0ikGav37JGny/IoyXM2ev9qalp+3/p
	 cdNHJf6piUNGs/us/11nBbNLMjTiMm+IXV+0R9wmZZ8SZD0xpgpPIdxmR4BYuzqVsO
	 xPnAI/qp4yImAfdJDdv/Bdvc7V7A3/axEF/kcQy/qBCdaX2/gJiKqt4rj7AdzpxfBD
	 /9qRAuqwL9bRw==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-bec3ffb95dbso465190266b.0
        for <stable@vger.kernel.org>; Tue, 02 Jun 2026 19:20:18 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AFNElJ9KX8woXLtB4W6+yfNnIETPtO3AOYBvAG+p7sTEX5m6H2AdB5uOqKtoau5CBzBOf/DcFi7miEs=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8O6RdKCUJ3F5H4xZvdlj//Ym6b3WZRRp70dKRTiPNtq7uDLWb
	5hJQjf519pbUkZNXRb5LgJbF60YGwyVf0Z6NpRi3HFj3wF0Lpx54AiVjt67lVpeipPPjPFqot+F
	tBUYqhkOMtXExd9D8mgMfWmVANMRcyYc=
X-Received: by 2002:a17:907:7290:b0:beb:7b50:3a7b with SMTP id
 a640c23a62f3a-bf0ac40aff4mr45067366b.6.1780453217454; Tue, 02 Jun 2026
 19:20:17 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260602235646.23581-1-hemparekh1596@gmail.com>
In-Reply-To: <20260602235646.23581-1-hemparekh1596@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Wed, 3 Jun 2026 11:20:05 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_hNhenv7_+HtyZ66zyw5bCyN16ki2RTRf5BEYyCkxGYg@mail.gmail.com>
X-Gm-Features: AVHnY4LPDH63fHGyXR5ToGAYaxEwE0MdRK87mQcFQ5V7YsmEbTyQVwyAVM-jwWY
Message-ID: <CAKYAXd_hNhenv7_+HtyZ66zyw5bCyN16ki2RTRf5BEYyCkxGYg@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: fix out-of-bounds read in smb_check_perm_dacl()
To: Hem Parekh <hemparekh1596@gmail.com>
Cc: Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[samba.org,chromium.org,talpey.com,gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-259940-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:hemparekh1596@gmail.com,m:sfrench@samba.org,m:senozhatsky@chromium.org,m:tom@talpey.com,m:hyc.lee@gmail.com,m:linux-cifs@vger.kernel.org,m:stable@vger.kernel.org,m:hyclee@gmail.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4044C6339F8

On Wed, Jun 3, 2026 at 8:56=E2=80=AFAM Hem Parekh <hemparekh1596@gmail.com>=
 wrote:
>
> The permission-check ACE walk in smb_check_perm_dacl() validates the ACE
> header size and caps sid.num_subauth at SID_MAX_SUB_AUTHORITIES, but it
> never checks that ace->size is actually large enough to contain
> num_subauth sub-authorities before compare_sids() dereferences them.
>
> CIFS_SID_BASE_SIZE covers the SID header up to but excluding the
> sub_auth[] array, and offsetof(struct smb_ace, sid) is the ACE header,
> so the existing guards only guarantee the 8-byte SID base, i.e. zero
> sub-authorities. compare_sids() then reads ace->sid.sub_auth[i] for
> i < min(local_sid->num_subauth, ace->sid.num_subauth). The local
> comparison SIDs (sid_everyone, sid_unix_NFS_mode, and the id_to_sid()
> result) always have at least one sub-authority, and an attacker controls
> the ACE revision and authority bytes (which lie within the in-bounds SID
> base), so they can match one of those SIDs and force the sub_auth read.
>
> A crafted ACE with size =3D=3D 16 and num_subauth >=3D 1 placed at the ta=
il of
> the security descriptor therefore causes a heap out-of-bounds read of up
> to SID_MAX_SUB_AUTHORITIES * sizeof(__le32) bytes past the pntsd
> allocation. The security descriptor is loaded by ksmbd_vfs_get_sd_xattr()
> into a buffer sized exactly to the on-disk data (kzalloc(sd_size) in
> ndr_decode_v4_ntacl()), so the read lands past the allocation. The
> malformed descriptor can be stored verbatim via SMB2_SET_INFO (the DACL
> is not normalised before being written to the security.NTACL xattr) and
> the read fires on a subsequent SMB2_CREATE access check, making this
> reachable by an authenticated client on a share that uses ACL xattrs.
>
> Add the missing num_subauth-versus-ace_size check, mirroring the
> identical guards already present in the sibling parsers parse_dacl() and
> smb_inherit_dacl().
>
> Fixes: d07b26f39246 ("ksmbd: require minimum ACE size in smb_check_perm_d=
acl()")
> Cc: stable@vger.kernel.org
> Signed-off-by: Hem Parekh <hemparekh1596@gmail.com>
Applied it to #ksmbd-for-next-next.
Thanks!

