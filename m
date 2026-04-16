Return-Path: <stable+bounces-238297-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qA2QFLe24GlYlAAAu9opvQ
	(envelope-from <stable+bounces-238297-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:15:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 53A5940CC83
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 12:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 0D565300D55E
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 10:15:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B375C39DBC7;
	Thu, 16 Apr 2026 10:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gKXuQdC9"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97339EF02
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 10:15:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776334511; cv=pass; b=DFEXrVfr+6GnFunxxcL/YK6GnX1g5sl/MH3X+VGPk7JTiDqS7qtz6b3QsOh93ob72B3THLqpmOYAES0bLsXgDYKgaq8KXE7UgwGEEVn/Lch9mVfydI7Ok8KCF38RPWUefaXdSH9c/xMhcs5OOYYICZVauvcgkVGOpHv6GKkQTzw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776334511; c=relaxed/simple;
	bh=W14sY8rFVQP5R86DvhFB8pwK3PIqD2viK/+q2E9YJ5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=heogdfqpenAxNvGHJmEvaiD2h04rVrYq8oniDwgduMhHqumy69JDBG2gz3xgvO8ASGyehwwDMis2dYTk7IR9/z2vmGb703egdrmF0Hn2DsBxSJTk0vf3l98d6gXDh11V+LWqRnGJnp807FKKY7pwqcj6hlSNgFkpsCKXlOG3RSE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gKXuQdC9; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-64d5a7926cfso7441931d50.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 03:15:09 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776334509; cv=none;
        d=google.com; s=arc-20240605;
        b=OTTEzQg32FM7RFIMIyZSs/GMGa64nieanycUq9O+OhjfaKpsB4GZCtrWvnqhJ/MhP3
         yFeE2QazEYKfhePvB+JuD1gD0e/aANVD9eJUfD5NdXtoAG6OYF/JBch/VHmFgBYski7o
         NDQy0fYkIloliRKI1fjRPnJmCrYVqqDG3yVUJitPOSsPzhb1kCiXDBjy3f47fWVqCzJg
         0RJfmVauYc2SkwWyoZ6YhpDBhDDGOdN7UeJTWFhexDtCUF0v6Td0yOMmHvRqPrWRoitX
         5bbB9zictcmdzaMBEf4pTecPbMy7+E4m8crsyb6Hi6SJPDY6y2F0FYaFkaYgwatVaF//
         LaEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=MIU0mNT5q/kCll0NZpz4oa7I+7IP+1P1zx78jkbqb28=;
        fh=G1GoUl97crp5+jTQavr/euItc2K6baHPLlaCCN/khOs=;
        b=E7lFfcOytMonwIOXT41H6WGdrczzXmj56C856Zcft82M6iQenRxoEKWv27Vw8JzBqx
         7GUnot7UWtFoWUy/HlKdLhg+4KCPHPP/uhBjoddd2dQKooK9pxS9ZJo/bquzAoaf7PPK
         bab6hgtar6+JjxkOzBD8cPNaQGQcnEADXxHLHRoe773jIC4bdztFwCNtUDoDqsk332q9
         MTMnbNjMnwtfwy7BSRfxd1TwVCmr2cTbFD0+9I5Unix2PObLxOFmgtllcoawYFiGrV+6
         LU57YB8Hqykq16+e3QxmkUkBRNhNPbHO3jJTPg43U7IfH3hzqc7NOcgoqR+bu7WuMWzO
         AhNg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776334509; x=1776939309; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MIU0mNT5q/kCll0NZpz4oa7I+7IP+1P1zx78jkbqb28=;
        b=gKXuQdC91ojrprddfuB+MM5IqwwSTDX3RwvSyRUgLazw8NYB0gwlLSis5TQ5hfqGJ/
         3n8oWodXQIc3Oepd0gK8snZoq6EUdx5d1IhNAU9vu2nxLslkGyBmOTpGjb8AMxPnRAGH
         3qYYaj7pix3wE2VsIANblF6vCuIz46REiZBk/r+K3Ik9atZY+F7/VVC0I/jkyijkf0v0
         3E3XQxildQhQlmwR2/HxjE99+zJwmGwVqLPIn0rxdZc215ttJUSvdgT22lb6s2MJ8Go+
         ebwp7NrOG8gtsmiU48hIbobm/zUSW0vxXg4yFUiD3BWOh9WQvbNJfjk1x7jNMGNOQF2c
         xUJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776334509; x=1776939309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=MIU0mNT5q/kCll0NZpz4oa7I+7IP+1P1zx78jkbqb28=;
        b=IqSNRoucIsYgE//snKrzekJ+yl10VdQfsg11AE4lU9hGYKICBJePfCEDFjjaSVdIlJ
         BAUKNDCnalZNsiLQA9Ra0mSmb9G4ye3yOZaH6dzuRaE6J9mrZ3ybMnRhgV+2X5j/akiR
         p/rqJwtHFH5FaKLrhpgbsS9iF+UK0HmCWQtgTb7EegPmpoVmyv6T2sG4aDtPXyW2CRbi
         oxSezCIuoUQvnWtCkQrjrOmNgFchAGUb+PRrKr+24Md64Jae2Bcgy91kSOmo4bFHwrYq
         pj6A8RAB9URM0dlSzxwowi/VeivqolB48UEsYDC+KMs7vAZstVOi9k1A0BU4n6TVl/oV
         oK9Q==
X-Gm-Message-State: AOJu0YzhAvxmB9eSXZpOqgkUcCnCNfl3uAG/jlqNYPUToYfu/gvV6KUr
	6mjdZl/gYkdRp4EtqejzkzU03EB0NZGNvKASH9EweO31In8wQhTzMhuWhQSkK3pI7eOv/sGCjd+
	HXgOfZwxfRuEhSE2jjxuOA1Uk7sGUi5c=
X-Gm-Gg: AeBDiesKiTYJXuPahgKp8mRZC0CjiLQ2Jp0X6oIhbq/HW4ST6CCnVRMr87Pkggb0Nwd
	jbpBLj3J1JVnuaAT/bNhwyFNE9NZFtZLGt0Hde2gamZyfN7zaZiwfJTrxCmBbDMOcN84fPMhtED
	qsgrghoJITgajqvdjbpAOwwckuskgAeM2uNsgHrfyb1/zn2Swoo7XckspCj+azQMFg9b7X5kz9Q
	M7th5W5rYBM0OQjl7d5Jx5YQ4HLbi4TBNCNj4GMyYK94iuDHmzri5ZkNocFsT9/cbyjYYidgHbb
	prDUGOTOAj94x5Pd39v4
X-Received: by 2002:a53:df4a:0:b0:64a:d04e:a340 with SMTP id
 956f58d0204a3-65198a57036mr16625320d50.11.1776334508728; Thu, 16 Apr 2026
 03:15:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260412133356.2536585-1-lgs201920130244@gmail.com>
In-Reply-To: <20260412133356.2536585-1-lgs201920130244@gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 18:14:54 +0800
X-Gm-Features: AQROBzAzpUVwDqsuwaFup_uU3Pw92c3_Go_sblTv00ait3DeiQxzl9cHn1aUjew
Message-ID: <CANUHTR-s4dJCy8j2qXtsgTX8N9SFTJiipYnaM5TngUBpRWsqxQ@mail.gmail.com>
Subject: Re: [PATCH] misc: microchip: pci1xxxx: fix IRQ vector leak in gp_aux_bus_probe()
To: "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>, 
	Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>, Arnd Bergmann <arnd@arndb.de>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, linux-gpio@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-238297-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 53A5940CC83
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi=EF=BC=8C

On Sun, 12 Apr 2026 at 21:34, Guangshuo Li <lgs201920130244@gmail.com> wrot=
e:
>
> gp_aux_bus_probe() allocates IRQ vectors with pci_alloc_irq_vectors()
> before initializing and adding the second auxiliary device.
>
> When pci_irq_vector(), auxiliary_device_init() or auxiliary_device_add()
> for the second auxiliary device fails, the function unwinds the auxiliary
> devices and ida allocations, but leaves the allocated IRQ vectors behind.
>
> Add a dedicated error path to call pci_free_irq_vectors() after IRQ
> vectors have been allocated successfully.
>
> Fixes: 393fc2f5948f ("misc: microchip: pci1xxxx: load auxiliary bus drive=
r for the PIO function in the multi-function endpoint of pci1xxxx device.")
> Cc: stable@vger.kernel.org
> Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
> ---
>  drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c b/drivers/misc=
/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> index 34c9be437432..5e1f99a35100 100644
> --- a/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> +++ b/drivers/misc/mchp_pci1xxxx/mchp_pci1xxxx_gp.c
> @@ -93,14 +93,14 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id
>
>         retval =3D pci_irq_vector(pdev, 0);
>         if (retval < 0)
> -               goto err_aux_dev_init_1;
> +               goto err_irq_vectors;
>
>         pdev->irq =3D retval;
>         aux_bus->aux_device_wrapper[1]->gp_aux_data.irq_num =3D pdev->irq=
;
>
>         retval =3D auxiliary_device_init(&aux_bus->aux_device_wrapper[1]-=
>aux_dev);
>         if (retval < 0)
> -               goto err_aux_dev_init_1;
> +               goto err_irq_vectors;
>
>         retval =3D auxiliary_device_add(&aux_bus->aux_device_wrapper[1]->=
aux_dev);
>         if (retval)
> @@ -113,6 +113,9 @@ static int gp_aux_bus_probe(struct pci_dev *pdev, con=
st struct pci_device_id *id
>
>  err_aux_dev_add_1:
>         auxiliary_device_uninit(&aux_bus->aux_device_wrapper[1]->aux_dev)=
;
> +
> +err_irq_vectors:
> +       pci_free_irq_vectors(pdev);
>         goto err_aux_dev_add_0;
>
>  err_aux_dev_init_1:
> --
> 2.43.0
>

I re-checked this issue on our side and found that my previous
analysis was incorrect. This patch is therefore not needed.

I'll drop this patch.

Sorry for the noise, and thanks.

Guangshuo

