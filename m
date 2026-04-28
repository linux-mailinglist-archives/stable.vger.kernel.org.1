Return-Path: <stable+bounces-241490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wE+oFUJu8GmgTQEAu9opvQ
	(envelope-from <stable+bounces-241490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:22:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C615D47FEC4
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 10:22:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A76C0307868C
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 08:16:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13D8B3D349C;
	Tue, 28 Apr 2026 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B3AqKqoj"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B6A53CFF44
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 08:15:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.52
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777364154; cv=pass; b=ZrsSaHG8dVZPdQls2abbFcOr6f+6DadWXkZKRB4wtmS+/vIZRFk4GVeYUlCfxceZKDaEPApGeAkKPkFRNVeM1LHLAClMLPnaTx9vMvUrspFwZIkGvSaJUw0tokqsqP8TZIln6qNv/SX17iQr7zlnLunftCXIvrT8N85nbNilFKM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777364154; c=relaxed/simple;
	bh=KlcjeiG2q6/hWPJ95X5cbFemPX7rmwo7+sX+LsWddpQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bjU3wvgYXeWANzT3yD6fnamzafRxgx94RkKekLTKU2gjx1lNhsKIhS3sA4kmnIPq3ztv7riNcHahUDdzvofjt7Up9QC8GWjzEQptAbD8n461TGOl/802v7xLNakPPMtt66Y+6A7OsDMrHBPo0fSEh2FLatjH/uF42hYlGTcoX30=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B3AqKqoj; arc=pass smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-59e5aa4ca41so10864183e87.2
        for <stable@vger.kernel.org>; Tue, 28 Apr 2026 01:15:52 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777364150; cv=none;
        d=google.com; s=arc-20240605;
        b=SyzpqbKLbi4RLcr+hJ3P56xfd6h/uJEd+OwmbZXpnSM+694H8KDSaZykM+k7BIFhTZ
         wVJWgM7yXvhHbF42Ld4M1Ev+8ORkC06AbYySlJqcmwnHVm6SoasgzTk96JN9kWRHCfgj
         hnDRLe6U6/srK4WeZ+Y4SW4Fv/NQv9RDyGctflNsNIuQrR0xZfBH5ZQ4Ua0gDYZ5NhF7
         lokQYGrsY3yHKZj1Equ6dBv7zUQPGcbfqq6hwhT07XNKlCF8PDHo+EOUGz9OR0BXiiWe
         nTeWxpZSBbDbRPsB7qMChuPzyy6ww1RKPhdtcf9zBOrcsdcqTiFq0DDlgcZ4U8lvpy9+
         r9VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=wjfqRtDxAeF40hBuLKq3STaSSCgQmItO5OYkY6XEFg4=;
        fh=KlCmG/X+AybCUO6+pcpD+YMD6zPikZW8j5OLb+FGS+U=;
        b=FK8XOU7+34k8zw5s7Dw7ZHus07Y3em+/1b/67zgVEB2W/tCF/SpMQ8msCBbInhvf+7
         tG9cDCVpFk6Gy3EUi0wjxzlkx6dRG6Zh73vrtOa5E3QQ/pwtuL2JbwaIKmPvPDjVfLhR
         pM/rQsDXJZYtml1Fc6RCOLlXPPzS10m2wsYkmJoDUriZemOf01smoF+65U/2CVVCNVcr
         88lB4c54hggMQK95F/qawQk6xgjoaeOk/gPpiAIk1eIb9u1lA+jjyJDpin1OtYWT27lm
         nDcpoJsmox0uUzPBZL0BmNseAjRzYqvRIGy0/52gszYcF7vRURhBF3n3gp7PUm6ISRor
         8l3A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777364150; x=1777968950; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wjfqRtDxAeF40hBuLKq3STaSSCgQmItO5OYkY6XEFg4=;
        b=B3AqKqojccSyL8CAnbP1M24jm9SeZwSfmOrtMtfKo0gP7Q21kIC7s/2TPLZFu4Izjd
         3HIz7pAFTnlsErjFSBydIbLJFKVMneGPwXGFu5LWh9k+AmWeZMygr2Lp95o4N/f6Yjlb
         Bh1R1+7PBJyC2Ih3vONilFKzG9i4QHAZj9eYn/HK1XUcm6NzuZ69uyhV558k3r7GbFXH
         nD8+oLNhL4/M3jOGR9L4RJ86t+X4WwQM9U+gokgF44h611IIZAK4VpCE3qXyMquAyQD9
         MaFRZSPPSIfmyBn+gIcXwU7oIf0FBPnGUaK3q3gwwEfH85DxbXK/0Y+GFhKBIDueC6mY
         1gcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777364150; x=1777968950;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wjfqRtDxAeF40hBuLKq3STaSSCgQmItO5OYkY6XEFg4=;
        b=GwEGiQ4Vj+4wN9jAEHNHKx4h/p5P2/4DgLkpdcnPcqN2AzB0LVa4Q803ki+5JXbVxd
         5G7ihw8E0DG3TOfshsNXJcD2KTb00wWKBRgZZ1TpJD7795mR/fm7k67NsS9CgHA1hcNy
         P9RIx64Kn9oVj/ynEVjGGZPl6aYdYoi8R4ygoSKYneAUio0WlJmSmQGJIHYzpSqmycVv
         R9+FNLpbxL3qqzPCDTk4K0Wmu9aATNBGIUIftKEOL6UalaNHUjRk5eRnnOntQCBmBNIP
         K/HbMw/Jrxg/5RVV4AdZooXNRKs07fOa365ZoakdZHZPiv1WoeR7t9k8V7ocuk69AhVj
         /w/g==
X-Gm-Message-State: AOJu0YyIUZ90fb4/axjSb/+ZddwzMbCwdtCVZynbTbR2TDegyQ8ahYvl
	uc+gknUXbmCvs9VSQskPyeCJz+PZf3YLNfPS62anBnJ6Tjq7yB8Y49DEWM6byQjUimWM6ZNRhU9
	UTZFHqpt6x4Ggf+ZoAnd76RapcRqUlwQ=
X-Gm-Gg: AeBDievPgTjXtuCr8pjdQW80xPZ91O0dZRu+6Z+kLczrvclQLuwGnNIqW1i7droBWqN
	Yy8QjWZSCPoEeKNeO9BM8sDItvWnijhFyRo8WwRJjm4vm3dGGRrKY120QFwyqmFF0KDacOnbOPH
	4qa7xnu1rvgQl+60wEd+85zf6SQYdqaAuFUPaACYUNHgnl07RUzJDZ00suZ9Qv7t94WeI+mn7NC
	Ub/U3CfnR1mvvvFyc5LYor2y8pIinjVaAb3H02Pv8vY77xT4HaIGLWBLv3dFuQ59O734FC4JN7Q
	TXKN3fcbS64vU/7xM7efx1elCU4Fvw==
X-Received: by 2002:a05:6512:3b11:b0:5a2:b903:3b43 with SMTP id
 2adb3069b0e04-5a74660485amr902698e87.7.1777364150184; Tue, 28 Apr 2026
 01:15:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260419222355.5842-1-rand.sec96@gmail.com> <5584ba17-bc68-4d3a-aa63-0e18c3eff22a@omp.ru>
In-Reply-To: <5584ba17-bc68-4d3a-aa63-0e18c3eff22a@omp.ru>
From: Rand Deeb <rand.sec96@gmail.com>
Date: Tue, 28 Apr 2026 11:15:38 +0300
X-Gm-Features: AVHnY4J8dhmB2u9wuwORthp5dyqu6Vxb_-qwMg6EvD05Cu-TYFkzssn_rw5LVZM
Message-ID: <CAN8dotkWCxBT-Sg=Sv+nbZCdTD=DWoHL=Kb2atFoo2KgcCjzSQ@mail.gmail.com>
Subject: Re: [PATCH 5.10.y] ata: pata_sil680: fix result type of sil680_sel{dev|reg}()
To: Sergey Shtylyov <s.shtylyov@omp.ru>
Cc: stable@vger.kernel.org, axboe@kernel.dk, linux-ide@vger.kernel.org, 
	linux-kernel@vger.kernel.org, deeb.rand@confident.ru, 
	lvc-project@linuxtesting.org, khoroshilov@ispras.ru, 
	Damien Le Moal <damien.lemoal@opensource.wdc.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: C615D47FEC4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-241490-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[randsec96@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[wdc.com:email,linuxtesting.org:url,omp.ru:email,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]

On Mon, Apr 20, 2026 at 4:11=E2=80=AFPM Sergey Shtylyov <s.shtylyov@omp.ru>=
 wrote:
>
> On 4/20/26 1:23 AM, Rand Deeb wrote:
>
> > From: Sergey Shtylyov <s.shtylyov@omp.ru>
> >
> > [ Upstream commit dafbbf5c57dd6ae01d20b894bc2200e9d9834c4e ]
> >
> > sil680_sel{dev|reg}() return a PCI config space address but needlessly
> > use the *unsigned long* type for that,  whereas the PCI config space
> > accessors take *int* for the address parameter.  Switch these functions
> > to returning *int*, updating the local variables at their call sites.
> > Get rid of the 'base' local variables in these functions, while at it..=
.
> >
> > Found by Linux Verification Center (linuxtesting.org) with the SVACE st=
atic
> > analysis tool.
> >
> > Signed-off-by: Sergey Shtylyov <s.shtylyov@omp.ru>
> > Signed-off-by: Damien Le Moal <damien.lemoal@opensource.wdc.com>
> > Signed-off-by: Rand Deeb <rand.sec96@gmail.com>
> > ---
> >  drivers/ata/pata_sil680.c | 30 +++++++++++++-----------------
> >  1 file changed, 13 insertions(+), 17 deletions(-)
> >
> > diff --git a/drivers/ata/pata_sil680.c b/drivers/ata/pata_sil680.c
> > index 7ab9aea3b..fe60f884b 100644
> > --- a/drivers/ata/pata_sil680.c
> > +++ b/drivers/ata/pata_sil680.c
> > @@ -47,11 +47,9 @@
> >   *     criticial.
> >   */
> >
> > -static unsigned long sil680_selreg(struct ata_port *ap, int r)
> > +static int sil680_selreg(struct ata_port *ap, int r)
> >  {
> > -       unsigned long base =3D 0xA0 + r;
> > -       base +=3D (ap->port_no << 4);
> > -       return base;
> > +       return 0xA0 + (ap->port_no << 4) + r;
> >  }
> >
> >  /**
> > @@ -64,12 +62,9 @@ static unsigned long sil680_selreg(struct ata_port *=
ap, int r)
> >   *     the unit shift.
> >   */
> >
> > -static unsigned long sil680_seldev(struct ata_port *ap, struct ata_dev=
ice *adev, int r)
> > +static int sil680_seldev(struct ata_port *ap, struct ata_device *adev,=
 int r)
> >  {
> > -       unsigned long base =3D 0xA0 + r;
> > -       base +=3D (ap->port_no << 4);
> > -       base |=3D adev->devno ? 2 : 0;
> > -       return base;
> > +       return 0xA0 + (ap->port_no << 4) + r + (adev->devno << 1);
> >  }
>
>    And why exactly is this needed in 5.10.y?
>
> [...]
> MBR, Sergey
>

Hi Sergey,

This is a direct backport of upstream commit dafbbf5c57dd.

It fixes a type mismatch between the helper functions and the
PCI config accessors (which expect int), as identified by
static analysis (SVACE).

The intent is to keep the code consistent and avoid issues
flagged by tooling.

If this is not considered appropriate for 5.10.y, I=E2=80=99m fine
with dropping it.

Thanks

