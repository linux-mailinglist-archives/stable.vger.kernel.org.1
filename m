Return-Path: <stable+bounces-240001-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SA9/M+qS5mnGyQEAu9opvQ
	(envelope-from <stable+bounces-240001-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:56:10 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 73FAD433D67
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 22:56:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EEBBA30115B2
	for <lists+stable@lfdr.de>; Mon, 20 Apr 2026 20:56:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C51F399346;
	Mon, 20 Apr 2026 20:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qxmPKIJ6"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87EC0388375
	for <stable@vger.kernel.org>; Mon, 20 Apr 2026 20:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776718560; cv=pass; b=pFroOaLUos23OQhXy5Yk2pBTk1ca4J7dpt4gV6Tj3pMOVOIZJ6zsWlnvLQ8D9tjAnq9p3NWpbqtYr6mHqjoQYHryUsENPUYp38NTd3cTz92Cnpln53ciLKqkZf/0dFBdmYZu+kH8nCfFg1noeRBtkQoqEft5xD+T5K5/369uPJw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776718560; c=relaxed/simple;
	bh=jQsef1nrrUFXEEwHzi13OXBwDXb3hcJzxauEMF9wkIg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ANYYAjyuTseY14jOL8LT0ogkPHWhv+MgLuBPNvPJRpvv4NQndpwhK9mHHb3cmrcO4wfkPE/MSZRrVAtxwJbRBoaEoC0QjL8aiwvLCg4jtmywHpsJxnDceidtEwzmRugxByiOnwjBnTMOby3nDBASlxRVwegIzFNhg8iEPIwAYTQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qxmPKIJ6; arc=pass smtp.client-ip=209.85.219.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8a032383008so36560646d6.1
        for <stable@vger.kernel.org>; Mon, 20 Apr 2026 13:55:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776718558; cv=none;
        d=google.com; s=arc-20240605;
        b=Bitb3lfKPs3dcmN0cthApBecUByn5Sv0M0QCfkNY9FYwE6nFt6MiN51VYQhyTc6/H2
         djvKTJ0zstP6/0jSFf+fVn/KwguVNmoNb5BMfXuYupFD6Aljg4MSgdIvlsT7Ky4Gigf6
         AWKwM2Bf/jOqlgywmVA9DWqeCFCPUXR4VaO/6MloqfkEN7vr85eBxEkqDgKtftGMk13p
         Hui/fME24U9D93Ovdax7uiwy66USI0cZLg6Rv19Xxd/Yr1Rg+pTOwavzTZg+Nxo9fcyf
         5Z272Dmxv5mgJAfocBOkV66bR4IvAdKjmGGmdSDt1o6eKcpQwS9h5LwhQC/OLsccVmc0
         3WyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=SkOn3Nx+drgx8Ekbv4vlvgPE5Sw0mB11UeBSsIadLQw=;
        fh=2ixmgNAxY+ifeDd+/cyX2sGkHdfhE/sXg0LpFBCOCNA=;
        b=Z48UaDN0Vzak1UkD1E/z6RywO6r4m/haZ1Rqv3ZEGmd123wyqOyNcnnPiWl0DO/phm
         xcykf+t43tmCaS9+zARIl+G7C8paF/9BrQl1lNKDf+xnshCqABWPUtUoycHrv9W+XTjK
         65etI2oLaU/p9G6a3xMMJjsnMYyBmssPNqY8ifR5e0dVzcofRwUsVXIJ8Ulry4P51ovG
         HSHeaH+3NkOZ0eIExeWq4wgCyUciznXs3Ef2ryvCnSnHO5YpXDalftBqfFgpcgwEybqW
         F25XYhBtXN5C1F+xBhf9wcRuE7yJ1GPKAx9BgDRQVVerVcAGzkw9U8BhoMjlIycynSLK
         OAWw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776718558; x=1777323358; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=SkOn3Nx+drgx8Ekbv4vlvgPE5Sw0mB11UeBSsIadLQw=;
        b=qxmPKIJ6JYZBy/NJIi0KaMiTGEfCokx+4xaKdoBzCxuQjI5FsE20y6wTmtetlIlUv7
         2xY7LGGkvbOjpfc4onR2fm81BMsKUhqjUcqUdqf+kE5QHFZiwtoAwLrOqAVS8/dXxCwJ
         V4cZp1jEJAGiWBl3xqUNpR3EUPjSwZmsDOMAYTMrV6wMdwERHxCbbltManzHgU7QtDRo
         G5i0t0yZqWEWBneiOiGlhaKFgHeIVnxhH6rtA+1kY/q9FI+AOeP6DcxZYq5NYD0JliEr
         sw1bR/S7hdx7WLNQcnjtrlZ3Qrez9JPetI3jOkXXGn+Gp2TOiYPALKVxCb89i3/Q5fD/
         CLew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776718558; x=1777323358;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SkOn3Nx+drgx8Ekbv4vlvgPE5Sw0mB11UeBSsIadLQw=;
        b=jd89kyRfkuVsEoHhsl11MANNxumecmiiBpIw7VINF6hdKW4zaMklQoFeQuTriXDd84
         2bwCPneUsg4ySmnpklfQHO0k3wfsMG7Cwf52QCTHdQizwabHGqc9FbXENiOEVcB9QcF+
         aEisoBfVei/nI46C+C9WcPdqFWttU7Z2YIpgxPfIJbBqKTKGddB0pV0XPQx/DK8xfJWB
         +NGcUERhFEb7IVvwEAmBUo+QuRo+iJWhcQ1o+V9WymYM6Rsk8v2eRcIUCZOlbn9YRsAF
         9gpzZt/8bOkhX4g+wTszg3z0/w1hVrg+fgh3v5u2gIkjoHbOllBTSnvXOZOwIVmn4wpv
         ldww==
X-Forwarded-Encrypted: i=1; AFNElJ8YrpJ3pQYZGyjQRO2yJMJGAXzu3fv6iQsXBW6E6I9WXNm/5/WXf9KpJOJ2hp5QWQlg6K/is3I=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXr7MC7hefdE560HwUEgFYtq1GSZS5A0FPHXezzsMNvRlgNhay
	PeMddTunCPBDs1iONWHhsVOz3e1VcEHh5L4clt39xwx1YUh+HmIxlcqAYpqHYlTGmT2c+DlOxiy
	CmF4KgoujCOR2+r+maNgGq+ZjDA1z6iA=
X-Gm-Gg: AeBDietKwfe66GQUNSaCVJFHKlNkXzLQpAWC9nxJqjx59bSukyRua4wAFWhS+lu4E8Y
	5UuR71KNm55SzhWmp+i4c9H+z7Lix8beuPXmFP27+8bAg1TQPjF3tljYheDKau5xlpw5LeEhZYC
	Fo/Scw7031LERtclrjisX2C/Mlq89Vo0D7+sO/2mt8cyfCH6B4ia4N+NlB/2y33FbuVg/UtmEmS
	XZD+hNvIkvd9y7fszmco9VQKff4ZFZIoL/mEcAc9adOM48OJGXVMJFvlNTXPjTI7MIZtlyyTyKd
	/cx69vBZFpvDHFJWNUjWkAAawHTOqtSmBNuXFzMmiRHZw176XpawSAxQVZe0TGnvg6vcQ1rnJ7q
	ALaDMyjthrkN7jldEPm692Cgw5f9hkb4kNqAvKS5HFZpWtZVHZ4/+ViCFaYqbf05WcePA6kxTCx
	lykrbZ8HSfFPf15+DEL/c91sEV4ma7ukU=
X-Received: by 2002:a05:6214:40b:b0:8ac:ba63:a1b1 with SMTP id
 6a1803df08f44-8b028176865mr263218276d6.49.1776718558402; Mon, 20 Apr 2026
 13:55:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420135058.469990-1-michael.bommarito@gmail.com>
In-Reply-To: <20260420135058.469990-1-michael.bommarito@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Mon, 20 Apr 2026 15:55:46 -0500
X-Gm-Features: AQROBzD8qRbzGNoHBRFQQ-qhVLxIr37bW187p-BIkjgp1HOYAQyTfXz4z952k2Y
Message-ID: <CAH2r5mtNhVtN65gYcbPqxOXMD_Fm3FcHFcURLmF8yma2zKk1aw@mail.gmail.com>
Subject: Re: [PATCH] smb: client: require a full NFS mode SID before reading
 mode bits
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: linux-cifs@vger.kernel.org, Paulo Alcantara <pc@manguebit.org>, 
	samba-technical@lists.samba.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000008a9ef1064fea863d"
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	TAGGED_FROM(0.00)[bounces-240001-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	HAS_ATTACHMENT(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]
X-Rspamd-Queue-Id: 73FAD433D67
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000008a9ef1064fea863d
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

This patch wouldn't apply due to a conflict with "smb: client:
validate the whole DACL before rewriting it in cifsacl"

Had to change "end_of_acl" to "end_of_dacl"

See attached.

On Mon, Apr 20, 2026 at 10:14=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> parse_dacl() treats an ACE SID matching sid_unix_NFS_mode as an NFS
> mode SID and reads sid.sub_auth[2] to recover the mode bits.
>
> That assumes the ACE carries three subauthorities, but compare_sids()
> only compares min(a, b) subauthorities.  A malicious server can return
> an ACE with num_subauth =3D 2 and sub_auth[] =3D {88, 3}, which still
> matches sid_unix_NFS_mode and then drives the sub_auth[2] read four
> bytes past the end of the ACE.
>
> Require num_subauth >=3D 3 before treating the ACE as an NFS mode SID.
> This keeps the fix local to the special-SID mode path without changing
> compare_sids() semantics for the rest of cifsacl.
>
> Fixes: e2f8fbfb8d09 ("cifs: get mode bits from special sid on stat")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
>  fs/smb/client/cifsacl.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
> index c920039d733c..a62c8a733779 100644
> --- a/fs/smb/client/cifsacl.c
> +++ b/fs/smb/client/cifsacl.c
> @@ -831,6 +831,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *e=
nd_of_acl,
>                         dump_ace(ppace[i], end_of_acl);
>  #endif
>                         if (mode_from_special_sid &&
> +                           ppace[i]->sid.num_subauth >=3D 3 &&
>                             (compare_sids(&(ppace[i]->sid),
>                                           &sid_unix_NFS_mode) =3D=3D 0)) =
{
>                                 /*
> --
> 2.53.0
>
>


--=20
Thanks,

Steve

--0000000000008a9ef1064fea863d
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb-client-require-a-full-NFS-mode-SID-before-readin.patch"
Content-Disposition: attachment; 
	filename="0001-smb-client-require-a-full-NFS-mode-SID-before-readin.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mo7obp1u0>
X-Attachment-Id: f_mo7obp1u0

RnJvbSA1YTM5ODBmMzAyNzU2MDFkNjllMDY2MjkwZDI4ODRiYjVhZjJkZDI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBNaWNoYWVsIEJvbW1hcml0byA8bWljaGFlbC5ib21tYXJpdG9A
Z21haWwuY29tPgpEYXRlOiBNb24sIDIwIEFwciAyMDI2IDA5OjUwOjU4IC0wNDAwClN1YmplY3Q6
IFtQQVRDSF0gc21iOiBjbGllbnQ6IHJlcXVpcmUgYSBmdWxsIE5GUyBtb2RlIFNJRCBiZWZvcmUg
cmVhZGluZyBtb2RlCiBiaXRzCgpwYXJzZV9kYWNsKCkgdHJlYXRzIGFuIEFDRSBTSUQgbWF0Y2hp
bmcgc2lkX3VuaXhfTkZTX21vZGUgYXMgYW4gTkZTCm1vZGUgU0lEIGFuZCByZWFkcyBzaWQuc3Vi
X2F1dGhbMl0gdG8gcmVjb3ZlciB0aGUgbW9kZSBiaXRzLgoKVGhhdCBhc3N1bWVzIHRoZSBBQ0Ug
Y2FycmllcyB0aHJlZSBzdWJhdXRob3JpdGllcywgYnV0IGNvbXBhcmVfc2lkcygpCm9ubHkgY29t
cGFyZXMgbWluKGEsIGIpIHN1YmF1dGhvcml0aWVzLiAgQSBtYWxpY2lvdXMgc2VydmVyIGNhbiBy
ZXR1cm4KYW4gQUNFIHdpdGggbnVtX3N1YmF1dGggPSAyIGFuZCBzdWJfYXV0aFtdID0gezg4LCAz
fSwgd2hpY2ggc3RpbGwKbWF0Y2hlcyBzaWRfdW5peF9ORlNfbW9kZSBhbmQgdGhlbiBkcml2ZXMg
dGhlIHN1Yl9hdXRoWzJdIHJlYWQgZm91cgpieXRlcyBwYXN0IHRoZSBlbmQgb2YgdGhlIEFDRS4K
ClJlcXVpcmUgbnVtX3N1YmF1dGggPj0gMyBiZWZvcmUgdHJlYXRpbmcgdGhlIEFDRSBhcyBhbiBO
RlMgbW9kZSBTSUQuClRoaXMga2VlcHMgdGhlIGZpeCBsb2NhbCB0byB0aGUgc3BlY2lhbC1TSUQg
bW9kZSBwYXRoIHdpdGhvdXQgY2hhbmdpbmcKY29tcGFyZV9zaWRzKCkgc2VtYW50aWNzIGZvciB0
aGUgcmVzdCBvZiBjaWZzYWNsLgoKRml4ZXM6IGUyZjhmYmZiOGQwOSAoImNpZnM6IGdldCBtb2Rl
IGJpdHMgZnJvbSBzcGVjaWFsIHNpZCBvbiBzdGF0IikKQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5v
cmcKQXNzaXN0ZWQtYnk6IENsYXVkZTpjbGF1ZGUtb3B1cy00LTYKU2lnbmVkLW9mZi1ieTogTWlj
aGFlbCBCb21tYXJpdG8gPG1pY2hhZWwuYm9tbWFyaXRvQGdtYWlsLmNvbT4KU2lnbmVkLW9mZi1i
eTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9jbGll
bnQvY2lmc2FjbC5jIHwgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYg
LS1naXQgYS9mcy9zbWIvY2xpZW50L2NpZnNhY2wuYyBiL2ZzL3NtYi9jbGllbnQvY2lmc2FjbC5j
CmluZGV4IGM5MjAwMzlkNzMzYy4uYTYyYzhhNzMzNzc5IDEwMDY0NAotLS0gYS9mcy9zbWIvY2xp
ZW50L2NpZnNhY2wuYworKysgYi9mcy9zbWIvY2xpZW50L2NpZnNhY2wuYwpAQCAtODMxLDYgKzgz
MSw3IEBAIHN0YXRpYyB2b2lkIHBhcnNlX2RhY2woc3RydWN0IHNtYl9hY2wgKnBkYWNsLCBjaGFy
ICplbmRfb2ZfYWNsLAogCQkJZHVtcF9hY2UocHBhY2VbaV0sIGVuZF9vZl9kYWNsKTsKICNlbmRp
ZgogCQkJaWYgKG1vZGVfZnJvbV9zcGVjaWFsX3NpZCAmJgorCQkJICAgIHBwYWNlW2ldLT5zaWQu
bnVtX3N1YmF1dGggPj0gMyAmJgogCQkJICAgIChjb21wYXJlX3NpZHMoJihwcGFjZVtpXS0+c2lk
KSwKIAkJCQkJICAmc2lkX3VuaXhfTkZTX21vZGUpID09IDApKSB7CiAJCQkJLyoKLS0gCjIuNTEu
MAoK
--0000000000008a9ef1064fea863d--

