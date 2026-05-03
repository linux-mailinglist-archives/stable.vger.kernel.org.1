Return-Path: <stable+bounces-242800-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MEIWHbFo92kehQIAu9opvQ
	(envelope-from <stable+bounces-242800-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 17:24:33 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D71D24B63E4
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 17:24:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 75AE5300998E
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 15:24:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6BD822EAB82;
	Sun,  3 May 2026 15:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="swG1EO4J"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f50.google.com (mail-qv1-f50.google.com [209.85.219.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A46662EA731
	for <stable@vger.kernel.org>; Sun,  3 May 2026 15:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.50
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777821867; cv=pass; b=t6yjxkepeKyd1RINwd+4dPMF6GPUm2xnKD+pPF9M4y9nBtT75elicZvTsXppD8SJgB3zBTECztWlrHAz7KgcPv7Jyw/c3zNhnSICeU/FxaWDb08PP4RI4YnG0Uv6Ev6j6Ess1Cctdmy3kn4cvebOwl0TShRXck9IXYoMl5wcCBI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777821867; c=relaxed/simple;
	bh=qErxFlaQsMJljN65R/Za1i2arUaAHxn36XGOWaQZ+XI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GrZZ8Hsr5fmnPYcTw/eCZ413exXNsBYVPxh2+pXqOpKsIwos9RaRzeZfdD7Hp+5fa6X2cBx8Sq2An9PCNIOvlAGlB0IURjUdxUbnduZgPZm06hdolk3z1/A7dbumQ8WCXXyHg7LIBGjYuNoSxOvpimEnJeWETrhbwJtvF3/Mzig=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=swG1EO4J; arc=pass smtp.client-ip=209.85.219.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f50.google.com with SMTP id 6a1803df08f44-8b7f937ef44so3713276d6.0
        for <stable@vger.kernel.org>; Sun, 03 May 2026 08:24:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777821864; cv=none;
        d=google.com; s=arc-20240605;
        b=lyGkF7oYO6bV1TUUnVY6RksOod6MPIBZyxPNI/OtPr+lSF5qhNsPQJY0tqhi4CW0Kl
         ygzy/05XNY7IEekBlQtfrWvhSAzDMeJMzNFpBm26gwAJXDHJKFZeBIkGDEeufM+dcn1h
         /TszcESn/jIE0/NKBL8Zt1D2QhD54XyUNQUE8lsnIcYw6il/n77ouMFXMmlIaBRyV3Wg
         Cz9by/8uojnzAOVoCBn6k8JG+95Xhmy27W/dLzc5RxUcaTYgEcQQrcvs2KBRTBv4eIC6
         By4yhs3hScLuiXnoXSWdBQFLPmS3myMAJwTeLi56390vBlgdiJqlN86Z4hvX4ByTmPgw
         L3Pg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dk44ltyjNXeb94AL68tKtmcqm1AiCDfhD8eU6ZDxGXM=;
        fh=aV7m87Qd8kQbUHAxn792LYpAkPwbGYCS5++8LQs3b2c=;
        b=jMClv6xcs4kd98JtCSkp3rycJ/kQIiraW7W5MaBk5LnRu+xHARHWd5JpKYPFkAm0WL
         tk5BT6fyzwWbyWaVnb/B++9cug/WM+X1HJFdlXIoi7QLby2Z9VNk0dnYKhl/PmN2cfhN
         2iJuQxfgIYz6yPv9oxy0vyOYl5AtlHaPobvSRzsEupqUIYn0o+HJaR3x9OWP9m2hYgQw
         3VjZrWwRt/9tU0vqfiZAe1wl5276ocGDj6J6kscsskgsEJad9lkVsdbGjEknmqok/Cd2
         XdYo6wn4dJnuJW7hEz+aFOCj+yOPmpZTYHtHbVdhUD+FIXW56xyDzwhykunlZTzbhvbw
         KMdA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777821864; x=1778426664; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dk44ltyjNXeb94AL68tKtmcqm1AiCDfhD8eU6ZDxGXM=;
        b=swG1EO4JtKGflB1Wie5G+9wUlJ4nDmm00FzWVCnr90nmDVI9/NLqPT4TwbRNxNqb8V
         JmEVvxMmtDCkU/j1qsfmF/G9qkXiC4wTP6ep/jpRJ1ot227djzu72zmqbYemo+5zFXOP
         hi1WxQQV7gJ4619lSSPeETwRUxD9YhAA7RQC4W7D5kARQ7dkG/azDkKJfzmoqG+Q9wMZ
         FYbe9MVCvd/SBm9vSRKrVwaeDbHqFE33huH2IgRmRF7XhzdHeFUY9nQlQLw0t2eWobwf
         yymjA8HjhtJmBDrPznYvUw5N1Z6+dfgOLADQc3b/8Y89WW0UxPgknDALjf6IhioV8rw7
         J/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777821864; x=1778426664;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dk44ltyjNXeb94AL68tKtmcqm1AiCDfhD8eU6ZDxGXM=;
        b=Yvpw4o6/8WqE6KhlxrGmgAGlNgiM69ivW2UKEBAWEewzgGK0gDqPxov4nUcuhtp5/6
         Lp0gD9UZdd/b5zfQNGSZ8rxxtE9j6qS4iwrGJhsTghzyDHH6HIDsKSETUB8MnpLqAxpc
         RNSWUBzeknV3W8BrytlBVcufOfnGwmTqDA+HmmTUUnHJ8v7zgS2yGSrCqfHkAW9z1gtw
         5WnJS8yrrqs/feBAIRZMHwW4f8Vi6LsCQW/1OTOHQ7TXisbPG1jMKJDUsrqEl6n6gD94
         IeZNaQIfGkzD6s5CdCXFqF2YTM1JsDrQnNxnV/uZVjlVTfuYHot4vSF+HCJWZJxOmPHz
         NSHw==
X-Forwarded-Encrypted: i=1; AFNElJ/jQ+FojjI231IT2hMs8/i+apf/X4sqAS5gCl02zBNfpUAu+jM4OeSvVlcmF1rBR66r1r6ub8g=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTj1t9RQ5Z4D+HdW8TWnQ3Q5fDeR0FHF9k6Jyc22rzBQ036+97
	r4vmDka1GlDbd+1fpyKOjqu6lY/UcMFMZGUTudahhQgBMTcwCgPGOnD4VNexexaiQTYO2YguU/H
	iinx61J7bjXIXxwMC4fwjDEuk6cgrK4s=
X-Gm-Gg: AeBDievnzEQSvmkLYNLK+c3M07bt2b7kiAIB2ehDU5ZTen/1EQnhr40ZFo9HBH6rOe3
	9IuPcYTMqF4CD8xYtpq+dzGrPspkFhMEoNbtrhLKW0bHAq8L4hi439oMH7Mib4PYy8m2uZUKFtP
	QcQjzQ9W0hRx5qR7lKpQOBxQJWjkzdAW+D74Gs1PkqSJwdJY3kDEwTPgCAtLHi29KEaHg4H2UKL
	QItAlopOtFdFehNt+AndgiYJ6H7idtwaoT6uireVgGOXneMGZwRxefsef7MVth60lzsrPSf/1k/
	fUX/Vwkcz/vMPRprpHMPpJgJuqndVTxkNeXqoN9KBSU9DeVfHW4VKKmsvI5664nXNzvxcwNgFMc
	CvaiQEUEI9XWGomeNA4Sn8zEfZ7h+ZgF3Qim2s2BbvbgaQyZYJaRkmoTW1vA1A9gH1VYOa5XrKZ
	JWVg4rxGWUhB9L6DjhUNDFjD2nizdSL6s=
X-Received: by 2002:a05:6214:478a:b0:8ae:655f:28a4 with SMTP id
 6a1803df08f44-8b668d10e79mr102257526d6.40.1777821864469; Sun, 03 May 2026
 08:24:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260420144747.662761-1-michael.bommarito@gmail.com>
In-Reply-To: <20260420144747.662761-1-michael.bommarito@gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Sun, 3 May 2026 10:24:11 -0500
X-Gm-Features: AVHnY4LlGeS7TKEajg81BwnSaFWaKd4qKkA01CnCJWCOClc8KMuKvIz3J9czej8
Message-ID: <CAH2r5mv5wV6xJfmTNx3dTbs1wTDyYpLPsdq53butKq1N_OvAoQ@mail.gmail.com>
Subject: Re: [PATCH] smb: client: validate dacloffset before building DACL pointers
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org, 
	Paulo Alcantara <pc@manguebit.org>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, 
	Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>, 
	Bharath SM <bharathsm@microsoft.com>, samba-technical@lists.samba.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D71D24B63E4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242800-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[smfrench@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[samba.org,kernel.org,vger.kernel.org,manguebit.org,gmail.com,microsoft.com,talpey.com,lists.samba.org];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

merged into cifs-2.6.git for-next pending additional testing and review

On Mon, Apr 20, 2026 at 10:44=E2=80=AFAM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> parse_sec_desc(), build_sec_desc(), and the chown path in
> id_mode_to_cifs_acl() all add the server-supplied dacloffset to pntsd
> before proving a DACL header fits inside the returned security
> descriptor.
>
> On 32-bit builds a malicious server can return dacloffset near
> U32_MAX, wrap the derived DACL pointer below end_of_acl, and then slip
> past the later pointer-based bounds checks. build_sec_desc() and
> id_mode_to_cifs_acl() can then dereference DACL fields from the wrapped
> pointer in the chmod/chown rewrite paths.
>
> Validate dacloffset numerically before building any DACL pointer and
> reuse the same helper at the three DACL entry points.
>
> Fixes: bc3e9dd9d104 ("cifs: Change SIDs in ACEs while transferring file o=
wnership.")
> Cc: stable@vger.kernel.org
> Assisted-by: Claude:claude-opus-4-6
> Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> ---
> This applies on top of
>
>   [PATCH v2] smb: client: validate the whole DACL before rewriting it
>   in cifsacl
>   https://lore.kernel.org/linux-cifs/20260420001131.2865776-1-michael.bom=
marito@gmail.com/
>
> so that the new dacl_offset_valid() numeric precheck sits upstream of
> that series' validate_dacl() structural check at all three call sites.
> The two patches are independent fixes for different bug classes on the
> same three entry points; applying this one without the KCIFS2 v2 patch
> first will fail on the build_sec_desc() hunk because the trailing
> context line "rc =3D validate_dacl(dacl_ptr, end_of_acl)" only exists
> after v2.  If you prefer a different ordering, happy to reroll on a
> plain mainline base instead.
>
>  fs/smb/client/cifsacl.c | 35 ++++++++++++++++++++++++++++++++---
>  1 file changed, 32 insertions(+), 3 deletions(-)
>
> diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
> index cb4060ba5e31..87d2a58fc8b4 100644
> --- a/fs/smb/client/cifsacl.c
> +++ b/fs/smb/client/cifsacl.c
> @@ -1263,6 +1263,17 @@ static int parse_sid(struct smb_sid *psid, char *e=
nd_of_acl)
>         return 0;
>  }
>
> +static bool dacl_offset_valid(unsigned int acl_len, __u32 dacloffset)
> +{
> +       if (acl_len < sizeof(struct smb_acl))
> +               return false;
> +
> +       if (dacloffset < sizeof(struct smb_ntsd))
> +               return false;
> +
> +       return dacloffset <=3D acl_len - sizeof(struct smb_acl);
> +}
> +
>
>  /* Convert CIFS ACL to POSIX form */
>  static int parse_sec_desc(struct cifs_sb_info *cifs_sb,
> @@ -1283,7 +1294,6 @@ static int parse_sec_desc(struct cifs_sb_info *cifs=
_sb,
>         group_sid_ptr =3D (struct smb_sid *)((char *)pntsd +
>                                 le32_to_cpu(pntsd->gsidoffset));
>         dacloffset =3D le32_to_cpu(pntsd->dacloffset);
> -       dacl_ptr =3D (struct smb_acl *)((char *)pntsd + dacloffset);
>         cifs_dbg(NOISY, "revision %d type 0x%x ooffset 0x%x goffset 0x%x =
sacloffset 0x%x dacloffset 0x%x\n",
>                  pntsd->revision, pntsd->type, le32_to_cpu(pntsd->osidoff=
set),
>                  le32_to_cpu(pntsd->gsidoffset),
> @@ -1314,11 +1324,18 @@ static int parse_sec_desc(struct cifs_sb_info *ci=
fs_sb,
>                 return rc;
>         }
>
> -       if (dacloffset)
> +       if (dacloffset) {
> +               if (!dacl_offset_valid(acl_len, dacloffset)) {
> +                       cifs_dbg(VFS, "Server returned illegal DACL offse=
t\n");
> +                       return -EINVAL;
> +               }
> +
> +               dacl_ptr =3D (struct smb_acl *)((char *)pntsd + dacloffse=
t);
>                 parse_dacl(dacl_ptr, end_of_acl, owner_sid_ptr,
>                            group_sid_ptr, fattr, get_mode_from_special_si=
d);
> -       else
> +       } else {
>                 cifs_dbg(FYI, "no ACL\n"); /* BB grant all or default per=
ms? */
> +       }
>
>         return rc;
>  }
> @@ -1341,6 +1358,11 @@ static int build_sec_desc(struct smb_ntsd *pntsd, =
struct smb_ntsd *pnntsd,
>
>         dacloffset =3D le32_to_cpu(pntsd->dacloffset);
>         if (dacloffset) {
> +               if (!dacl_offset_valid(secdesclen, dacloffset)) {
> +                       cifs_dbg(VFS, "Server returned illegal DACL offse=
t\n");
> +                       return -EINVAL;
> +               }
> +
>                 dacl_ptr =3D (struct smb_acl *)((char *)pntsd + dacloffse=
t);
>                 rc =3D validate_dacl(dacl_ptr, end_of_acl);
>                 if (rc)
> @@ -1709,6 +1731,12 @@ id_mode_to_cifs_acl(struct inode *inode, const cha=
r *path, __u64 *pnmode,
>                 nsecdesclen =3D sizeof(struct smb_ntsd) + (sizeof(struct =
smb_sid) * 2);
>                 dacloffset =3D le32_to_cpu(pntsd->dacloffset);
>                 if (dacloffset) {
> +                       if (!dacl_offset_valid(secdesclen, dacloffset)) {
> +                               cifs_dbg(VFS, "Server returned illegal DA=
CL offset\n");
> +                               rc =3D -EINVAL;
> +                               goto id_mode_to_cifs_acl_exit;
> +                       }
> +
>                         dacl_ptr =3D (struct smb_acl *)((char *)pntsd + d=
acloffset);
>                         rc =3D validate_dacl(dacl_ptr, (char *)pntsd + se=
cdesclen);
>                         if (rc) {
> @@ -1751,6 +1779,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char=
 *path, __u64 *pnmode,
>                 rc =3D ops->set_acl(pnntsd, nsecdesclen, inode, path, acl=
flag);
>                 cifs_dbg(NOISY, "set_cifs_acl rc: %d\n", rc);
>         }
> +id_mode_to_cifs_acl_exit:
>         cifs_put_tlink(tlink);
>
>         kfree(pnntsd);
> --
> 2.53.0
>
>


--=20
Thanks,

Steve

