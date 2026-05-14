Return-Path: <stable+bounces-247273-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IAuhKXAVBmp3egIAu9opvQ
	(envelope-from <stable+bounces-247273-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:33:20 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id A2848545E61
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 20:33:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id AFABE300808D
	for <lists+stable@lfdr.de>; Thu, 14 May 2026 18:33:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8671E3469E6;
	Thu, 14 May 2026 18:33:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="L/+mXZep"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f97.google.com (mail-yx1-f97.google.com [74.125.224.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C3E2BDC26
	for <stable@vger.kernel.org>; Thu, 14 May 2026 18:33:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778783595; cv=none; b=sfShsPF+aKOqpRIcekdo7sJTcRV2z2Am4O3RzHDnUdkc6q9d2NUVEyZGxYW97Xs2Y2q+dR40ZZGtUJoKxgFDB7YWD8KbsufzYdWrty1V6fpvc2g19ODQ/uNW3OFHD/lNkVSr8/yTXEGEY7wS7/bipgaEtLioQApSiMuEfPTLUaw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778783595; c=relaxed/simple;
	bh=QhmiKoP2YxH2+pI3eF4I7UNa4YXPbxKejfmCtpkeBRs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q12QektI1dIx71V6CL09f+7Md2nw0MIPhOzOITqNamRJWdIt2Q9LYXUslrYsFjQ1YM2YFuEzxd+5kuka27WxswJinP/6+qG7MgMnr+5cec5fC6/4tXjSiJtsV9F69LNq4zM75qJ8JTD3Lc39ScCTFVjBI3fBQdO6dQol/YpqvqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com; spf=fail smtp.mailfrom=broadcom.com; dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b=L/+mXZep; arc=none smtp.client-ip=74.125.224.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-yx1-f97.google.com with SMTP id 956f58d0204a3-65dd9b25829so4814548d50.3
        for <stable@vger.kernel.org>; Thu, 14 May 2026 11:33:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778783593; x=1779388393;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pcv8Se3tLwiUr7YtCwvbzAyKdSfs26X8n9YpsJ7OXMk=;
        b=oqsVANciwOVYyCgsb3KfV6/ob36w7GbdXkB8FqkXhn2/AED2dHBF100iTaCQrewNDB
         UZX7t0DSVacKLv2NmqBqLckUITH5bjyH8L8EUOT1K9dtRafPOVB4ZcDljBj2+Hg5leBo
         2STdYJYJuF8nJuxcA7CNUB4gFd/BAtxiUo/qGH7Ux84cYBKoJRYZJyaTqvEVRghQ6bWy
         ikuEJlLR/2P12XD82IfZF3D4cHl0y5IzYc38YoD8N/Vl+djwdGHHfSR8ppwhj1w/YqZK
         1LvLIvR9YFBsKwf76iqQSuIFYZ5xEJvaeRy33H1EooktZLHW5uR5crxCfHh1NqPvceNJ
         GuyA==
X-Forwarded-Encrypted: i=1; AFNElJ/4J5+YfIu1uHHmvUt3aR5CCLHsx8nymih+NP9UCVZlngRiU+8gLsKL2vmSz3ILY0W7qJ7vy2o=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7CHMT7FLzBnV0gq5v+D+OKpf9hOQi1pscSkR87IU6fdGzC8vV
	6vZIELh+YOFQzzNPyVPSvkOly5u4hPuwemzddhoOFTFTwr9OdLb2QQf9zvSTj0Cq8c/kmcKvK95
	cyCgnc1aANRZ7MTUkEIdpI1Pg6XCCxKVc54nfUrRnhETfAoPEqEhFqbJol0FTtUCBcj4cphMk58
	XhrRGqr4olkt4hCL3ZP2laKfAXGxjv1kIRrgcMCS1O7dcTSlEZrRxLgl0W6tNlUXcGc62NU8RyS
	ImfK3Nw
X-Gm-Gg: Acq92OHLVjTB/XkhxWEjejgen3TR/Q7gslGCprX2s/x/J4dTmOMcNmTfXyBTcARW4EX
	Z3dEW2fsAnZqdoBWatQWsN949kVC1RrBdYQS6bNz+AFjpOOtiVyzdV//H2C+DuQHmLVVpeFZ0a7
	EVJkM8XipVM0D5woH2KgF6mgW7CWkv5J5mTakcRE9F74wMhifdrOSWpFpTWN0ZcJILML2SaQfVF
	FikqQG9KRTT/H2exnKWoaHMhAAl5EHk59av14oyG75k+bysPO/6jhWWpRLXHeX/BMs9dFM4vGUh
	nNfIKRm6WDDb3jc9+Int7STSTXkcUWWS6RFzV1dDzpwjx8NHuxy9gp9ZEuwXIRLvmil81FhTj1C
	cjOTysAzL1HTPtUtzuraiWAgWDdNbXbFH9QN+Ih9c6ERez0+ztcI+7hUeGmB2SGcGtDDUGbqNS3
	S0w08OMSthYf/f7XJNKyNU/ydk/HgJyzHIqx/LYDcy0tO//tdpa6mumqwXFXNIUIMf24s=
X-Received: by 2002:a05:690c:64c8:b0:7bd:5b06:b35e with SMTP id 00721157ae682-7c95c9ede3fmr4973557b3.47.1778783592526;
        Thu, 14 May 2026 11:33:12 -0700 (PDT)
Received: from smtp-us-east1-p01-i01-si01.dlp.protect.broadcom.com (address-144-49-247-121.dlp.protect.broadcom.com. [144.49.247.121])
        by smtp-relay.gmail.com with ESMTPS id 00721157ae682-7c7f619071asm2366237b3.23.2026.05.14.11.33.12
        for <stable@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 May 2026 11:33:12 -0700 (PDT)
X-Relaying-Domain: broadcom.com
X-CFilter-Loop: Reflected
Received: by mail-lj1-f198.google.com with SMTP id 38308e7fff4ca-393c9ff86c8so4193271fa.2
        for <stable@vger.kernel.org>; Thu, 14 May 2026 11:33:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1778783591; x=1779388391; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Pcv8Se3tLwiUr7YtCwvbzAyKdSfs26X8n9YpsJ7OXMk=;
        b=L/+mXZep9wYhUp/Q5/ChfXoLM9vTxbG0bu5Xg2jFtcnVXXEVg3HsZok0NZIigzEkmb
         C3JJdJdf5rzb9d2YY4JCz0UMSkQFhbsT3En2BMKVG0iK3ZsyaRQg5tKlyNbVmyeJfCCJ
         oFXUtOXoNGNfPC3un69bPnZE46y2LKF00QikM=
X-Forwarded-Encrypted: i=1; AFNElJ8YTelRXYju5DjV8PGdFDcc5C2hgPn8NsWPJ7Ga7DblJ3ox/7FPGMo6HDiVcaAGHmLpaEb1URE=@vger.kernel.org
X-Received: by 2002:a05:651c:1143:b0:38e:d870:1db4 with SMTP id 38308e7fff4ca-39561f48e4dmr574961fa.22.1778783590621;
        Thu, 14 May 2026 11:33:10 -0700 (PDT)
X-Received: by 2002:a05:651c:1143:b0:38e:d870:1db4 with SMTP id
 38308e7fff4ca-39561f48e4dmr574801fa.22.1778783590070; Thu, 14 May 2026
 11:33:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505222728.519626-1-zack.rusin@broadcom.com>
 <20260505222728.519626-10-zack.rusin@broadcom.com> <CAO6MGtjWxBRydOb1txcnySbLXJ49J=U2O-QdPo5WtmQoNxv5tw@mail.gmail.com>
In-Reply-To: <CAO6MGtjWxBRydOb1txcnySbLXJ49J=U2O-QdPo5WtmQoNxv5tw@mail.gmail.com>
From: Zack Rusin <zack.rusin@broadcom.com>
Date: Thu, 14 May 2026 14:32:56 -0400
X-Gm-Features: AVHnY4JbmegsIzoEuEC8wbxgBWh9xWm-jwZlcaECb9brxYghVC2JfmD_nGJFc4k
Message-ID: <CABQX2QNTvLkLrdtvD8kntyCBn9UmvMZFrwy7+cQOOp3SfaxxXw@mail.gmail.com>
Subject: Re: [PATCH 09/12] drm/vmwgfx: enforce cursor size limits for MOB cursors
To: Ian Forbes <ian.forbes@broadcom.com>
Cc: dri-devel@lists.freedesktop.org, maaz.mombasawala@broadcom.com, 
	stable@vger.kernel.org
X-DetectorID-Processed: b00c1d49-9d2e-4205-b15f-d015386d3d5e
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000149bcd0651cb5435"
X-Rspamd-Queue-Id: A2848545E61
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-4.26 / 15.00];
	SIGNED_SMIME(-2.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[broadcom.com,reject];
	MIME_GOOD(-0.20)[multipart/signed,text/plain];
	R_DKIM_ALLOW(-0.20)[broadcom.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247273-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,broadcom.com:email,broadcom.com:dkim]
X-Rspamd-Action: no action

--000000000000149bcd0651cb5435
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 14, 2026 at 2:18=E2=80=AFPM Ian Forbes <ian.forbes@broadcom.com=
> wrote:
>
> On Tue, May 5, 2026 at 5:27=E2=80=AFPM Zack Rusin <zack.rusin@broadcom.co=
m> wrote:
> >
> > +
> > +               if (new_state->crtc_w > cursor_max_dim ||
> > +                   new_state->crtc_h > cursor_max_dim) {
> > +                       drm_warn(&vmw->drm,
> > +                                "Cursor dimensions (%d, %d) exceed dev=
ice max %u\n",
> > +                                new_state->crtc_w, new_state->crtc_h,
> > +                                cursor_max_dim);
> > +                       return -EINVAL;
> > +               }
>
> we should probably just check against dev->mode_config.cursor_width as
> this is the maximum width userspace should be setting.

Not as is because we don't correctly set it. Only iff we fix that, we
could consider that. Even then we need a MOB_MAX_SIZE check, because I
don't think we can guarantee that SVGA_REG_CURSOR_MAX_DIMENSION always
fits in SVGA_REG_MOB_MAX_SIZE. Fixing mode_config cursor parameters
and ensuring they fit within svga's cursor and mob limits is a
separate change.

z

--000000000000149bcd0651cb5435
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
QSAyMDIzAgxhPxw+eieHWB40hPkwDQYJYIZIAWUDBAIBBQCggccwLwYJKoZIhvcNAQkEMSIEIOqL
3C7Fpark/0usMj+vqgyTSeyvOb/aMS6Civx7rg/2MBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEw
HAYJKoZIhvcNAQkFMQ8XDTI2MDUxNDE4MzMxMVowXAYJKoZIhvcNAQkPMU8wTTALBglghkgBZQME
ASowCwYJYIZIAWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQcwCwYJ
YIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABEYliBqgUesgml3cHyHxCiOVkoXNIxBgaotoXjh
yAvcnUQAOlkbPwLGrt4yEyosg2UxcoQjlmfCyQgDtHWflVtw/PlI3BPBJEgIgh3I5AU360qnZG2y
hg7pF5iQ9e1EWAe2FC/f94h1GY2PHg0hYNJSlcWH2e5QGH0ewTHbF7LjIX6LXt/K3hvAplvisr7P
g+K1svF7UuP4rS5IP/zBokWlJVQ/MtmybFnpQZz/rW+HVNmmtYuqi9PCCIpktAibb8pJ5+PJ0HCU
82DeKsQ9IRnJbRAyPKRY51aZ8isvFxayE68kU2dbVSrcNVlGtDEIQyshCQ9hW7VpHxCeBohtXJ8=
--000000000000149bcd0651cb5435--

