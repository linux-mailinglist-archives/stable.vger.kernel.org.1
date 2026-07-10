Return-Path: <stable+bounces-273287-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DuIRM60kUWqv/wIAu9opvQ
	(envelope-from <stable+bounces-273287-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 18:58:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2288473CCFD
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 18:58:21 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="F0t/s9XP";
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273287-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-273287-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 473A7302F392
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 16:56:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0961543D4FA;
	Fri, 10 Jul 2026 16:53:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B453E43DA55
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 16:53:31 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783702414; cv=pass; b=Wx7Su8hWkUYVJozAZOVXlOsPLBVbWZWB6m1tGz7WnsK/xpQv4x15ddC5HjmgZgHxSyDKnar7mUIPO66r9GI3euMYx8UsqlmX89cxUuaoKdOaLQqnWEfSj81cQme8ZKRKrJ0tAyB5UaYCbZ/l42a2oz2ITK1oyGRCk5t5fYfIXAI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783702414; c=relaxed/simple;
	bh=sh2rgKkO4vakz349Bs2qGYUyCofEHNHCVR7gaYL1B+A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=d2aP2SefRfRXX1sMGCF8DHflAfnEUSR8+Pu7Jf29KJmmhcNUDgsPX1/iC3AzInnLd+h1QMPvfIglB+LfDaNHOR22qRWB94pXwFTxcuu2gMPNRbUg42PBmle57dVuAuMExCXv776gwTM0ClBjZMfh9Za5tH81DMCYJESbCBPsTV0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F0t/s9XP; arc=pass smtp.client-ip=209.85.219.45
Received: by mail-qv1-f45.google.com with SMTP id 6a1803df08f44-8ee6912d86dso8873096d6.1
        for <stable@vger.kernel.org>; Fri, 10 Jul 2026 09:53:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783702410; cv=none;
        d=google.com; s=arc-20260327;
        b=Io3Eg8c980F0To9kWJWxCn68j0aP/6C8ox9u8jjRifg1qEd4aDT1YVeLqdTSdeFqx8
         /tzgJZTzkzSROpjGGaTtAaAC5yhJoUZhwVgIJaul97ZuVcXX2zC2rnzn5nnc830qNMJm
         7lmNjgTvzS1Ou9JhdBs7peyAyjMocS6YqHg/cp7ZUQcjnFa9/19HGnQNwmpjMQFXlbOV
         Qlr1yuPqc98fSgOuSSN4rrGPflHnIARwfgW+vUelKbMBB9MDlVJlgZ+CYnWH/qabaWWJ
         wMiWWtY1KCn3ehNKDQbIP7W0gqKv4JIaLhuSHbIc+s3ZriuGlGMvjbWolEbGmGxQLCO4
         3Xfw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ECI5IhnPRnGOgmvpWFYd+7dPzotRRtzBx7qL4XrCfvc=;
        fh=BQ9dMuE4dcPqQcWq86K5chijcz7CmR45epVKqsbnWWs=;
        b=VKMZzjAXJOd5OzUMRBhrwaYM7mh+xGB70U2NYNu+oI00BrSI3BEMKrnIV4NaPEMbF1
         paqCTAQydJS2aR9SYY29X1j2Z8WQBV/WvIMaHbQc7GhUoe4ryKlAlW+mV+CMtYWeiYRy
         1CVVgbK4OgsAy+0jxJaROfi2fkQjpHdfOrmFCs3vfnjLrm7eXn5MU/C2jQJqFuIONJn+
         cGmjZRe88He+4k7YzdDWnmKxJsSWle6hw/Kj+uokw5nQ2QYvAuOom4boAAieDvIYqZ7m
         +tuqzsu93aUV2+j4WbYsiErPjK4xNWoCAnDU7ulE5uZ1o6htDJQ5o/SCysQNZHEShILt
         pu+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783702410; x=1784307210; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ECI5IhnPRnGOgmvpWFYd+7dPzotRRtzBx7qL4XrCfvc=;
        b=F0t/s9XPp/cTvF4Mbp02Nhzpm+3t5uWkKoh3g3Dx9yPRrtGQ+fvJjGlHLPOQTlpI0J
         1NDvXkkhQs7wpgNf1hEdg1fqBINw2RR2YUb/vBq7Oqxxf721A8OII9UBcYyrzxiLr6JR
         /fjxPe7T94A8/TDLQGHWTZC3c3q0fnzK4dyQ9DjDsCtKadpAzFo2dYwnonVq+9OwKCNk
         2YIOfdH/+riYYQ+IMUAwwCaBJnKBD1+ComsKOi/vnt2Cw3px4yQ0ajVQ2xQNNOhx7Pwa
         x/HB1PWhtiVulijLh5oAu8YpzGqky1fe5CC9bC+UAJzA4AFa5OQbHeRui0F49ezmjkKl
         ki2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783702410; x=1784307210;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ECI5IhnPRnGOgmvpWFYd+7dPzotRRtzBx7qL4XrCfvc=;
        b=spYtJEObCXM84vgjMEqBXyVvOamVNiorGwqMyDk/lvWL8KFkO9XwHzY4b5Qjrd7kcL
         HMNRGbh2/GMb5/2EHUuTpvb8KABQ2I1ksbVPipJlHhIf+yqEJUPJ0gVZUmS1QBZD70Z2
         Pl+zcvNSo9Oh0ZABiK5lfkT9UUlzsl98V0fLBTWl9MqOUrjwjLJuUIdG5STb62Ga8WXG
         NPI//y0LEeWjLGcsn36DvhNtpZEV7tyiisQym8U9EdKxhqAJ4IQfpWxWd7rUhGP2E/Lj
         vHbUCCYncL+k/laXQCh2S9FInpXm09F1ebgJDDHaL3nVgRmc6WnFQxdJqQ2zJ0hnW4Nw
         bb8Q==
X-Forwarded-Encrypted: i=1; AHgh+Rordll9aiOuAEx5DT1xTpEgJ1jplKgF3ItTaLKfiQvreRTZNFVKd2+LL54K3b7+ztGzIoVuh6M=@vger.kernel.org
X-Gm-Message-State: AOJu0YycY4c+7e27BKUX2Ny4N2d4R1ys4LSsIYXHJDcgviTmSjht62rc
	ykBHn8jnUTCbeh61lzUjrb31+mluiQRyYoM2IVH9wRvLKCW1bslhII1LcnnogRIdtHjDwXWgn2r
	2aJPTs0rUTsHa0ZQ76FJIDIy80WoBaps=
X-Gm-Gg: AfdE7cnZhBKcVp/17PtpmxXEP4n7YAgR+XZD2wGgT2uhkhr5jkMBk0cK6Vj9ZqGZ1U9
	cM5bBQRRVBbF04mON15N+zmSpNVq5i242J2Mp4FwH3UOqzpeUi9PHMaT9T/fZdL8V4GTlmgLjX0
	hjg87UpPODjvUEjk16L+6vuZqfrjZHLW7f72ZI73B7ufHwZMM93TYUcSlJo+OPCsv0uj8SWnzLe
	eAPM38WLX+6zyVZEXEThEf7/dD3FYvlzHUyxB1pgaUKA979DeFGVJNCDp5yPJCHAqHqy30p3TuE
	3thd7jT4t5wzfOC1tdGji269Oh2fh61ihAyXa+hA
X-Received: by 2002:a05:6214:590c:b0:8ef:5103:df9e with SMTP id
 6a1803df08f44-8fec07d407amr146637396d6.8.1783702405016; Fri, 10 Jul 2026
 09:53:25 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260710022932.3741311-1-michael.bommarito@gmail.com>
In-Reply-To: <20260710022932.3741311-1-michael.bommarito@gmail.com>
From: Justin Tee <justintee8345@gmail.com>
Date: Fri, 10 Jul 2026 09:53:00 -0700
X-Gm-Features: AUfX_mzB6NY5-r9woFXPAWIrMvWpGzwtwgNIeOQYOY4j24PTnnUcebtYzYymwHs
Message-ID: <CABPRKS_3BSeCjaujZyrFKNfUeN7=ND1xu0jKnyK5UQDHvq0M+w@mail.gmail.com>
Subject: Re: [PATCH 0/2] scsi: lpfc: bound EDC descriptor TLV walk
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	"Martin K. Petersen" <martin.petersen@oracle.com>, Justin Tee <justin.tee@broadcom.com>, 
	Paul Ely <paul.ely@broadcom.com>, James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273287-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:michael.bommarito@gmail.com,m:James.Bottomley@hansenpartnership.com,m:martin.petersen@oracle.com,m:justin.tee@broadcom.com,m:paul.ely@broadcom.com,m:jsmart2021@gmail.com,m:linux-scsi@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:stable@vger.kernel.org,m:michaelbommarito@gmail.com,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[justintee8345@gmail.com,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[hansenpartnership.com,oracle.com,broadcom.com,gmail.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[justintee8345@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2288473CCFD

Hi Michael,

There are already current plans to address this concern in an upcoming
lpfc version update.  Please stay tuned when we post the version
update.

Regards,
Justin

On Thu, Jul 9, 2026 at 7:30=E2=80=AFPM Michael Bommarito
<michael.bommarito@gmail.com> wrote:
>
> An adjacent Fibre Channel fabric peer or device can crash an LPFC host
> with a malformed EDC ELS frame. lpfc_els_rcv_edc() trusts the EDC
> descriptor-list length from the received frame without checking that it
> fits in the actual ELS payload, so a short frame with an oversized
> descriptor-list length walks the TLV list past the receive buffer and
> trips a KASAN slab-out-of-bounds read in the ELS receive path.
>
> Patch 1 passes the received payload length into lpfc_els_rcv_edc(),
> rejects truncated EDC headers and descriptor lists larger than the
> payload, and avoids logging a third payload word unless it is present.
> Patch 2 adds same-translation-unit KUnit/KASAN coverage: a benign EDC
> frame that must still parse and the malformed frame that must now be
> rejected.
>
> Reproduced with the KUnit/KASAN test on f5459048c38a: stock trips
> BUG: KASAN: slab-out-of-bounds in lpfc_els_rcv_edc after the benign
> control passes; patched rejects the frame and both cases pass.
>
> Cc: stable@vger.kernel.org
>
> Michael Bommarito (2):
>   scsi: lpfc: bound EDC descriptor list by payload length
>   scsi: lpfc: add KUnit coverage for EDC descriptor bounds
>
>  drivers/scsi/Kconfig         |   7 ++
>  drivers/scsi/lpfc/lpfc_els.c | 195 ++++++++++++++++++++++++++++++++---
>  2 files changed, 189 insertions(+), 13 deletions(-)
>
> --
> 2.53.0
>

