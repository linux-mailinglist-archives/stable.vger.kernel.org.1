Return-Path: <stable+bounces-253812-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCpkNU5/EGrdXwYAu9opvQ
	(envelope-from <stable+bounces-253812-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:07:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E0A005B75C5
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 18:07:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 5AAE830B67F4
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 15:30:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C04125F988;
	Fri, 22 May 2026 15:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="KlzRisT0"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f227.google.com (mail-pl1-f227.google.com [209.85.214.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63A792EC081
	for <stable@vger.kernel.org>; Fri, 22 May 2026 15:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779463853; cv=none; b=VTqlfC1RgKV5EZgGWYe3yQdmET2M6frzMU13s7HS69We8CzHRkHEAHfYS2J73/K0be2PV4e2sblQgXcg03FRcJtOxxQliKU4mRlmxbDh38j9JceHHpKm50m2/su92klWAzzZhllNl5j6gJqc9PLRZviuALFKbp8a4o1g+bsluSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779463853; c=relaxed/simple;
	bh=vrB6Wx/pEh0ILMTHSZYtdDCxUiAU+fQ2tKshH4xmmOo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qEGbincS2axDADqzEtJMZYAbhXx3+VGmgEqgVhJe0Jk25d8PwS12BELXCmuHky7YYjSNgDbvwgb8udYOl54JLRMPi6sRwCAjX/J66lrJ5dpEbDF7+XDSZsdYyv5/JzOn3dKA6Hzv3Py6RHs5cTahfM3JLfYZ+lGUE2p17AMZGco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=KlzRisT0; arc=none smtp.client-ip=209.85.214.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-pl1-f227.google.com with SMTP id d9443c01a7336-2baca4df358so45859505ad.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 08:30:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779463850; x=1780068650;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VoRQXk1AVpDjBu2tvgtz77zXl48JF4l/Uz2NGQkUAb4=;
        b=qze4oZTuEIfrfRgdt9oB+s/xCKAJdmJwf43NAEm5OU63aiMQ2/CIho4wsXHVgsFypf
         6YR6r9YsogV1fJNPsD6Q/1EgGaSmVXw5fqoaitM2A5RZj6M6XyQsIdJuMl+FLZIGCxm4
         O2DF2xehMAomL4M3Pn+gtJSY6O7F9VC5ZMiBkoJiRg8cAVePnXbP7bSzuRuaJ24UPNb0
         2pvYmHk1cVQW2abhOCIXMhTa5esIhizZoXBPzzujDw7g8dbWUHZzLlW0/Q2hKY84TMx4
         ZRlpzSEs75ck9sI79Kva1B8ooLoB0TM2VIPFDCruATfbRc48Xe4vM3gIVpVPMg979MKA
         SE5Q==
X-Forwarded-Encrypted: i=1; AFNElJ/8suS5XmiLLE4SaexRslaa7m39oI4Wf8N2I/goKxX83TiKQuCC9ypXIM69FieC4iroXYNRaAc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzzQRN7c7hDGKex69R8irunFFRJr7+Uzp/Euo+RAZuvaEdp7zro
	Y3xDd89l/plzHf7tssQTjVpl9CkK0sSd2qmx/X9aN0xMKmQMnf5F9RU+JNjQ3rhcvFTkcXQHg/z
	UbtDnffjSct1HN2Iq7/M6Dtmiv2UqSYGxdfsoJRX8C8KXDdBHTUL0lXHj0fyqqEbHbpIqLhLWnD
	IWwJs9ft/hF/DMv9p+spQeGLBXEHabdxTjPk3K4A62Zb9qE/aD2dHEdgTDqAcl7vxRzIYFJVLE4
	90Z6zRu
X-Gm-Gg: Acq92OE7H+h2ko+B0bcRm42VboRQJSF1JJOJJdtUifDN8efBE3NEBTl6UEvtcu89FlA
	LFvEYZq9SvWi6OwKlvUKo0tc6eRxM84vFrd3it0uZPvCQ95xd3lhcWyq/AcghBAmRwF7QSF/FrF
	ZodypKTGWlrBQ1joqnG8B5oKRsCBZ2/dVcnVcQ+UIJD0DzmRJ9ZssY5AHlYG4vv/VEtyH/IymGm
	Uu0Y/uXySEZ8dQeEdU2+IVHdJe4bSPr/0pvUUQZZNgV8Z4Vw/fpUtYpT3ggGlVeju7Ra7cfc8mQ
	qt4JT6MbDmtuAu9KlVWjQZSBiLe5MXGFRHyGQXKIM8BomTWPm3louBLEqDUj1XPe2SEEmokwU4X
	+7/LcBrvoU3DoTwMV0/fQfIUXxcfwY0/e2r85a9NU6yfisjXdBRXdqhR5F052SavXUUoW1rOL9M
	9B1SFh7UZ3T1EPiDFTsWPgnQMqhSudQg6qlDcNCnOZsKE0QQvuxrsWqg==
X-Received: by 2002:a17:902:d4c1:b0:2bd:9728:5e40 with SMTP id d9443c01a7336-2beb074f528mr42372455ad.24.1779463850040;
        Fri, 22 May 2026 08:30:50 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-18.dlp.protect.broadcom.com. [144.49.247.18])
        by smtp-relay.gmail.com with ESMTPS id d9443c01a7336-2beb55942a7sm1263255ad.8.2026.05.22.08.30.49
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 May 2026 08:30:50 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lf1-f70.google.com with SMTP id 2adb3069b0e04-5a86f53a2b7so5995678e87.3
        for <stable@vger.kernel.org>; Fri, 22 May 2026 08:30:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1779463848; x=1780068648; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=VoRQXk1AVpDjBu2tvgtz77zXl48JF4l/Uz2NGQkUAb4=;
        b=KlzRisT0MXFaOVsLAib739rYBBJRnRfJzdydpnmsASzxOlyBtl7hM43NtoShI7KyAH
         jaBVRCp7ZwZy3fmhpFAzcKN2FA5fhuqWoeSuPJv+RjKYwDHX9KHWoPKv61eMn/9tWSAJ
         TgQmiYaKhPGd5cA9EskG6OYBmtILXkyE03vRs=
X-Forwarded-Encrypted: i=1; AFNElJ88jxcJ6qGBwZomN4KMBeXC8dNwz0+HUYufVuGC3xjSC+A2Q5UzSiYsXoguSe6LLmQQ6IrZa7M=@vger.kernel.org
X-Received: by 2002:ac2:5548:0:b0:5a8:8222:7fbb with SMTP id 2adb3069b0e04-5aa323b6fafmr1034517e87.34.1779463847715;
        Fri, 22 May 2026 08:30:47 -0700 (PDT)
X-Received: by 2002:ac2:5548:0:b0:5a8:8222:7fbb with SMTP id
 2adb3069b0e04-5aa323b6fafmr1034506e87.34.1779463847131; Fri, 22 May 2026
 08:30:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
 <20260505222728.519626-11-zack.rusin@broadcom.com> <CAO6MGtiqppOf7wgosneOADpN-A0wPCyWfoqeP+jFOfqMeXNAfA@mail.gmail.com>
In-Reply-To: <CAO6MGtiqppOf7wgosneOADpN-A0wPCyWfoqeP+jFOfqMeXNAfA@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Fri, 22 May 2026 11:30:34 -0400
X-Gm-Features: AVHnY4IEMLBeWUfhXX-UYiE5Yi3OmRaOyhP3ZC9tuAJdenSsT490axKEPDLn9rY
Message-ID: <CABQX2QMCMNbyDvr5PpjNYxV6gQgkyFBBMfBvpjmifx0eLZDLJA@mail.gmail.com>
Subject: Re: [PATCH 10/12] drm/vmwgfx: skip hash_del_rcu when validation
 context has no hash table
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, maaz.mombasawala@broadcom.com, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="0000000000008e665e065269b6cb"
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253812-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:~];
	DKIM_TRACE(0.00)[broadcom.com:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zack.rusin@broadcom.com,stable@vger.kernel.org];
	HAS_ATTACHMENT(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:rdns,sin.lore.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: E0A005B75C5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--0000000000008e665e065269b6cb
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I'll change the commit message and drop the Fixes but the change
itself is still good. We want this code to match the actual ownership
rules, especially if the allocation itself changes and ->prev is not
null anymore.

z

On Fri, May 22, 2026 at 11:20=E2=80=AFAM Ian Forbes <ian.forbes@broadcom.co=
m> wrote:
>
> This is a false positive, deleting an empty/NULL node doesn't do anything=
.
>
> On Tue, May 5, 2026 at 5:28=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
> >
> > vmw_validation_add_resource() conditionally calls hash_add_rcu() only
> > when ctx->sw_context is non-NULL, but the doomed-resource error path
> > calls hash_del_rcu() unconditionally.
> >
> > The KMS validation contexts created with DECLARE_VAL_CONTEXT(_, NULL,
> > 0) in vmwgfx_kms.c, vmwgfx_scrn.c, and vmwgfx_stdu.c never add the
> > node to a hash chain, so the resulting hlist_del_rcu() writes through
> > node->hash.head.pprev which is freshly allocated and uninitialized,
> > corrupting whatever happens to lie at that address.
> >
> > Mirror the conditional from the add side in the cleanup path so the
> > node is only unlinked from the hash table when it was actually added.
> >
> > Fixes: dfe1323ab3c8 ("drm/vmwgfx: Fix Use-after-free in validation")
> > Cc: stable@vger.kernel.org
> > Assisted-by: Claude:claude-opus-4.7
> > Signed-off-by: Zack Rusin <zack.rusin@broadcom.com>
> > ---
> >  drivers/gpu/drm/vmwgfx/vmwgfx_validation.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c b/drivers/gpu/d=
rm/vmwgfx/vmwgfx_validation.c
> > index 35dc94c3db39..45fde7ec514f 100644
> > --- a/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
> > +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_validation.c
> > @@ -309,7 +309,8 @@ int vmw_validation_add_resource(struct vmw_validati=
on_context *ctx,
> >         }
> >         node->res =3D vmw_resource_reference_unless_doomed(res);
> >         if (!node->res) {
> > -               hash_del_rcu(&node->hash.head);
> > +               if (ctx->sw_context)
> > +                       hash_del_rcu(&node->hash.head);
> >                 return -ESRCH;
> >         }
> >
> > --
> > 2.51.0
> >

--0000000000008e665e065269b6cb
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
6U6qgI8F5eiKsQyE0HgYrQJx/sDs9LLVZlaNiA3U8M8CgEnb8VhuH3BN/yXphhEQdJXb1TyaJA60
SmHcZdEQZbl4EjwUcs3UIowmI/Mhi7ADQB7VNsO/BaOVBEQk53xH+4djY/cg7jvqTTeliY05j2Yx
uwwXcDC4mWjGzxAT5DVqC8fKQvon1uc2heorHb555+sLdwYxAgMBAAGjggHYMIIB1DAOBgNVHQ8B
Af8EBAMCBaAwgZMGCCsGAQUFBwEBBIGGMIGDMEYGCCsGAQUFBzAChjpodHRwOi8vc2VjdXJlLmds
b2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3I2c21pbWVjYTIwMjMuY3J0MDkGCCsGAQUFBzABhi1o
dHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMwZQYDVR0gBF4wXDAJ
BgdngQwBBQMBMAsGCSsGAQQBoDIBKDBCBgorBgEEAaAyCgMCMDQwMgYIKwYBBQUHAgEWJmh0dHBz
Oi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwQQYDVR0fBDowODA2
oDSgMoYwaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc2djY3I2c21pbWVjYTIwMjMuY3JsMCIG
A1UdEQQbMBmBF3phY2sucnVzaW5AYnJvYWRjb20uY29tMBMGA1UdJQQMMAoGCCsGAQUFBwMEMB8G
A1UdIwQYMBaAFAApNp5ceroPry1QLdugI4UYsKCSMB0GA1UdDgQWBBQNDn2m/OLuDx9YjEqPLCDB
s/VKNTANBgkqhkiG9w0BAQsFAAOCAgEAF463syOLTQkWZmEyyR60W1sM3J1cbnMRrBFUBt3S2NTY
SJ2NAvkTAxbPoOhK6IQdaTyrWi8xdg2tftr5FC1bOSUdxudY6dipq2txe7mEoUE6VlpJid/56Mo4
QJRb6YiykQeIfoJiYMKsyuXWsTB1rhQxlxfnaFxi8Xy3+xKAeX68DcsHG3ZU0h1beBURA44tXcz6
fFDNPQ2k6rWDFz+XNN2YOPqfse2wEm3DXpqNT79ycU7Uva7e51b8XdbmJ6XVzUFmWzhjXy5hvV8z
iF+DvP+KT1/bjO6aNL2/3PWiy1u6xjnWvobHuAYVrXxQ5wzk8aPOnED9Q8pt2nqk/UIzw2f67Cn9
3CxrVqXUKm93J+rupyKVTGgKO9T1ODVPo665aIbM72RxSI9Wsofatm2fo8DWOkrfs29pYfy6eECl
91qfFMl+IzIVfDgIrEX6gSngJ2ZLaG6L+/iNrUxHxxsaUmyDwBbTfjYwr10H6NKES3JaxVRslnpF
06HTTciJNx2wowbYF1c+BFY4r/19LHygijIVa+hZEgNuMrVLyAamaAKZ1AWxTdv8Q/eeNN3Myq61
b1ykTSPCXjBq/03CMF/wT1wly16jYjLDXZ6II/HYyJt34QeqnBENU9zXTc9RopqcuHD2g+ROT7lI
VLi5ffzC8rVliltTltbYPc7F0lAvGKAxggJXMIICUwIBATBiMFIxCzAJBgNVBAYTAkJFMRkwFwYD
VQQKExBHbG9iYWxTaWduIG52LXNhMSgwJgYDVQQDEx9HbG9iYWxTaWduIEdDQyBSNiBTTUlNRSBD
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIN3f
nujaE5TTdBuCfHD/6pfdC4ZuywHx5GQT9nwb9hMTMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDUyMjE1MzA0OFowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBADg5J8QO6zOlcSs9rmfSPRDA2ks5MEhBxwJCIWTw
cwbtjdhdUCsmMGGC4Kkj113NLmpiuTKcfXl49lAksmddR0QgYL2jb+yx4m59fBDICbiGnhGahF1o
R0Nkhy2HZwXvkfCxcBcBy7flKebckYASMxZ1FdcumtH2FEBI9YylnLEWGYKLfx/6tH04GwxFXB3M
buVO84vNA/svUOuEc5BMfaCXyyytegv4qFrNAex7Vu+1C5M3v1j7fXUrxQ2ZPnlrWUfztPd3AmOB
BlCRNHTLk3hVwLOAPKruBurxb21KNH5eJ40v9mJ+j9LWMzksBh/fBbA0Cxr22gAZKNtNxayN9kg=
--0000000000008e665e065269b6cb--

