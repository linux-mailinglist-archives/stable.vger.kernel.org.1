Return-Path: <stable+bounces-247410-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +Do+EaLHBmrjnwIAu9opvQ
	(envelope-from <stable+bounces-247410-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:13:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D621D54A631
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:13:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 22C9E3008E27
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:13:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E01D3E3DA8;
	Fri, 15 May 2026 07:13:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a/GdluoM"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13D493E3D9A
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829189; cv=pass; b=k8WysMFt21PMWNf2AQRMiJH/w4sNK/WNzHmplEBj9aX4RLMHcXZHfitds4ylfWdLGh2cnus3G/pICrSqsuKX0jmIhlyrVRX9Sq+qPLuc7zLUedUPXx9R1R30JypPqNRzenAVwqRQrQxpH70xwvmtjbCu4TtWdpFCWSVFEYvu2HA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829189; c=relaxed/simple;
	bh=S7ddnipWjLOwYJTELZ8FIzOfFMA9tq60NbUkvylgU6s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZBZffJVIThS1EHEGNqgmUE0xaV4v56fFBQfcr/DVDFPZg8CFeJUYthYfhhGYGC1+2ceZiZgaoUnyaGXfvcZAZc0+ox5nLIS6DZWg3zYB7Dl/FO6Hx0KpOVUEOoPu42MK2PUzWBbgcVTkjiicwGIAtTPRhBKMO4r/pm6SyBn5R54=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a/GdluoM; arc=pass smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-bd124546379so775616666b.3
        for <stable@vger.kernel.org>; Fri, 15 May 2026 00:13:05 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778829183; cv=none;
        d=google.com; s=arc-20240605;
        b=jAJVUtdXcn00gvCJM2tDLUpm/QcJE+IX3GktlVy9B/pT16U2tYjTT29GWIDz8Ji58R
         AMQBKflrur+17eLOrFszQvSPLfB1QAK/aVg0oq1Pm3Cvm0gmcoi3b9cnV8VVNSa6z3Qh
         bhjcAnrw+4EmDWzTWGZ+DNvbMO2HXCIBwfHW6p8D1hoZ3dd+DXOciiWfS4envuc9lJ1y
         8UcvDe8Tg6F4Jsi3Cv/fdF7f7g73naX/9Y/OrYSBG/R/xptnpDBWzXErUx1B5HOfHOgv
         Mwt/JeQS+UkFP9YWe7VcgXfFUM90tnsJs5FXEf9ZgjZFWJO6C8k+0QvEPPQSjOqN3ipG
         bYwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=Ix7vmPqNZWMZqcHI6zoC70N7EBCK6BerDUnPmxhvt1M=;
        fh=TOh+3m4KXzaI4RPJFKPSCCoRRlI6hRluedPldYrwHP8=;
        b=IW/HyQPWDua53V3diA3nFF5uafOqozOhPR1DC0s9eHR8i2NzhOPhT53n/eB2/7Eafz
         D+oGYqpZZwuaH4eqEqqYHDErNx0+n3giSXAN19HjgDiRYQ2g/QV4TUIefvM9GojG5e83
         F47uQqEEdCfTDMxyVjPhaTa+SmcOf2DqceU4UTKuMq7KV5B3Dz8NX3PHWv8hQy0FY9UF
         WDy7yZnS/vMlj47F/IhaWPyhqr7o2f8HAYOd4v2Bc0W4HKhXokEmD5qylQfSskEajfPD
         gDY0NJca9/lC+ih+xOnx6iM89D5n641C4iOREHuhl23PJ9NBO5iMPuFFhFK+sDuu4eLZ
         pTTw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778829183; x=1779433983; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ix7vmPqNZWMZqcHI6zoC70N7EBCK6BerDUnPmxhvt1M=;
        b=a/GdluoMZ1YVUjQDiHjXAaICljxwU8kakn/Ba8i8AOkFzrqxnVXMb4ePfW8+T+U1z6
         x359Kv4GU5mQJL38AAMoZWV9KIDzH8L+XXxPAb82IT6+aSh3Y9n01RrSRTc81YWkJTH9
         +HSWc3q8UJGClE0kfmI0fqZy6pmTh1el4d7JrOaCnjSd2S/Cb7LOj2kiPJrguoOSUe7/
         1hSWc/2vI/miQyrwOG8EgyZs4twghEuzxr0ENwQbEg5M2NmfzzcUsrhRoAlcxns+5Avo
         89z+Twsqnw4LZlFnngChsu/MrL2NsoUb592KCgtrHdGrxTKUUdmwR7Bt0ABgYHmUNKGA
         vf5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778829183; x=1779433983;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ix7vmPqNZWMZqcHI6zoC70N7EBCK6BerDUnPmxhvt1M=;
        b=C9WSY8urgUWwxSvI4J11xEPo4RIulekaLqtoP5ZLWQhaWJvDmH+bKh2jYEktHakxnF
         +PWzMv1zAIBGJXgjBsOqSLEL+0n3Xz4jfX3hMfch5oLB+mHrOvKSHd51aS0GAG9By0FJ
         NsZt0IK8o7rfEIQntDhcfidmFBKnOpV6gryZ5vqkv/ThMmNGyyUNFfLtdbbwe0A2P596
         AAqkC8YevGgcmXoepCZ8Jr1qaSdJJzOHb2RQXVSQM+pboeSyihHtQtoKNKNP9kfCF+bx
         5gFJiCltW/fG/eaboRqJepmKeH/TVxZ1mnNSNyENQnQ5frSwjmTP/tSW+iCLk9cwDuu0
         MZ/w==
X-Forwarded-Encrypted: i=1; AFNElJ9jweRujw5rMURv+VyrH4XrZIJENTM+J/lwAwK+2tJWHwiEEbKuGwdMFMj5vvqKmYI5hnQ0rY8=@vger.kernel.org
X-Gm-Message-State: AOJu0YxbcrwInv/Ix0MNqsvc+euenMNjbLM9JLBYqEogBIXcIAr1bjWM
	k+t45Z7cl2JEHtBNlBRvdoXwtEpQAPSDBqh69l9PCckuCUsVBLqrtybxgwQVpsBhgRKljP67tYg
	Z2QdKp+GpXVKMUfzA6GnuspcO4IY6GSs=
X-Gm-Gg: Acq92OHUyBRwbfHDyW/sXQhZ8z+vMqPvtAJHscHh+gVnVc+wEcjJK3DMDn4CuaWMkxE
	KU46tftLSOj01sbxpLAv+jCcqxIIp+sgaVDOTXcAe9Fa+gbFv65uIX4as5xPA+eCeIpbOur/SJp
	GzqNCT+wTpRLbxiZRd2Gp9OTHveC2omCcqd9zpqdGVS56TREwutCONrsA/uN3FEMtgV2FzuO91P
	rmUd97DHlcur5tnHSUALPNd1I9a9RzNxsg+6FQ7A0xmZ3FbBCxApU4kSSJUcg4jJJepV3hM6FaB
	1IEI5bJRvVNTtvMmDXzoDlfcaZQTqoiUks3r7AnZ2s0YzlRaYQpf4EsuEa8DPvqOHC79rzHx+KE
	+/uTc12w=
X-Received: by 2002:a17:907:940f:b0:bd2:aeaf:470c with SMTP id
 a640c23a62f3a-bd51795b268mr134230766b.40.1778829182958; Fri, 15 May 2026
 00:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260514174342.28451-1-sozdayvek@gmail.com>
In-Reply-To: <20260514174342.28451-1-sozdayvek@gmail.com>
From: Andy Shevchenko <andy.shevchenko@gmail.com>
Date: Fri, 15 May 2026 10:12:26 +0300
X-Gm-Features: AVHnY4KpHdklZDsD-c8l-nEXfWLvpP2_mynX3_xCaEu44y1XUvh25i0SD7RwRpg
Message-ID: <CAHp75VfsA_LsbEKjxoeMdbhPbWj7OHZ7=0SYNA3c=ZLj_M94Bw@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: line-display: fix OOB read on zero-length message_store()
To: Stepan Ionichev <sozdayvek@gmail.com>
Cc: andy@kernel.org, geert@linux-m68k.org, hcazarim@yahoo.com, 
	gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: D621D54A631
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247410-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,linux-m68k.org,yahoo.com,linuxfoundation.org,vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[andyshevchenko@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	FREEMAIL_FROM(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 8:44=E2=80=AFPM Stepan Ionichev <sozdayvek@gmail.co=
m> wrote:
>
> linedisp_display() unconditionally reads msg[count - 1] before
> checking whether count is zero, so a write of zero bytes to the
> message sysfs attribute hits msg[-1]:
>
>         write(fd, "", 0);
>
>         -> message_store(..., buf, count=3D0)
>            -> linedisp_display(linedisp, buf, count=3D0)
>               -> msg[count - 1] =3D=3D '\n'  ; OOB read
>
> The kernfs write buffer for that store is a 1-byte allocation
> (kernfs_fop_write_iter() does kmalloc(len + 1) with len =3D=3D 0),
> so msg[-1] is a 1-byte read before the slab object. On a
> KASAN-enabled kernel this trips an out-of-bounds report and
> panics; on stock kernels it silently reads adjacent slab data
> and, if that byte happens to be '\n', the following count--
> wraps ssize_t 0 to -1 and is then passed to kmemdup_nul().
>
> linedisp_display() is reached from the message_store() sysfs
> callback (drivers/auxdisplay/line-display.c message attribute,
> mode 0644) and from the in-tree initial-message setup with
> count =3D=3D -1, so the OOB path is only userspace-triggerable via
> zero-byte writes;

Isn't it also triggerable when  PANEL_BOOT_MESSAGE is left default
with PANEL_CHANGE_MESSAGE=3D"y"? (However these double quotes makes me
wonder if this even works, as usually we compare symbols against plain
'n'. 'm', or 'y' (without any quotes).

> vfs_write() does not short-circuit on
> count =3D=3D 0 and kernfs_fop_write_iter() dispatches the store
> callback regardless.
>
> Guard the trailing-newline trim with a count check. The
> existing if (!count) block then takes the clear-display path
> unchanged.
>
> Affects every auxdisplay driver that registers via
> linedisp_register() / linedisp_attach(): ht16k33, max6959,
> img-ascii-lcd, seg-led-gpio.

In any case this seems a legit report, I will take the change.

--=20
With Best Regards,
Andy Shevchenko

