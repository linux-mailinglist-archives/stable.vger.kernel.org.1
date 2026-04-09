Return-Path: <stable+bounces-235495-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mAz1EGP712luVggAu9opvQ
	(envelope-from <stable+bounces-235495-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:17:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0276C3CEFFD
	for <lists+stable@lfdr.de>; Thu, 09 Apr 2026 21:17:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 33F3E30157CB
	for <lists+stable@lfdr.de>; Thu,  9 Apr 2026 19:17:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACFCE2EBBA4;
	Thu,  9 Apr 2026 19:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mRxOTARa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B77829992A
	for <stable@vger.kernel.org>; Thu,  9 Apr 2026 19:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775762269; cv=pass; b=j7qpBSa0TJ7Yld+U4lh2GtwNgSn3Nu8J+dvKMBUqicrxZgoH5iZxCVNTNQPZlB5kkwO+9A7fnj9PT75Vl81/n7u7q+1q91PEwRSBCxTQDflcenoUBxFJwmMV5vFo1zQ9oxYQuytLAo08XA7V/WlAfeSHdBrt6BPpMpGhnT9UGTQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775762269; c=relaxed/simple;
	bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RffLi8svbj42sgqetJjv1qL0m3q5qldFF3zPYQuczBi8+RZ8JJRZxk1kyODY1jzCFwQIeo7NkYE0tRG500PD4VwbGTzPnIV6f4ecUR68mVegrl+gV/ddzvfyTfpBhpXuTOPQDZ4hDFvriM7iKv3uB5fnyhdG6UIXLFJ36AyhyP8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mRxOTARa; arc=pass smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b9c755b2cdeso195412466b.2
        for <stable@vger.kernel.org>; Thu, 09 Apr 2026 12:17:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775762267; cv=none;
        d=google.com; s=arc-20240605;
        b=DNRSe0yKN+ytkJHOcB2j5GAQEKr6gCQ1T0d0/P0EwIBVopYuP/XBpGrEg0UcqfbDrx
         0Z1rTJm/trTj4E5UUim3AcpVdpBjcJ78jazKT2MqspEpCxUIs4uL/y6cpVhYfc5crE6V
         vegpvu11/Yjj2PYDvqc+YibtUHv262udj8ug07F+byRtaDfEoGzfEkiOTAOXuB0hidzD
         O84WGOddgK+eiWGwW8XQ0UJF9WQrXTy748/YKvUaM7FnUF0CIUz1gd/B9HOlC8nppZtD
         IVKSJrwgqZgCt2ARD6Wa5ApU7s524G/t9uhsF6UeVEYsdnDczcqF93fnvC6K+eZw7Jr6
         4bCg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
        fh=hK0Wd2TArdDEDvTL9Mo7oIhbaC6SYlmVtCBv1p9rYWk=;
        b=LM8as+FItbUUegubiPjvecdCd892vjzYy24D1J3D3pVNxvElfndb9ZAHcR/fwB5ZR4
         sPj7rfElr7EPFP8ABbN6fZSg4uwDEwo/TvtKRpF8bIeV4f6LrvD2Q1ElfsSA1c5LyfKk
         Nz4DBT/fDidg9Gp4f5rRXBiYDtx4kwgYDHJkDfWu+0ojhTJXvw/m+5KPNxHIxsncofyD
         HAAIR8LZRrTk9SVefFniFL0yE6QAxdOaseWiglDVAicE5TAGYWya6XuZrmv7IjOZciWH
         dTmGkguzklFZnL3AcQ7XRzq9OGLK3iPFYS3yWuZ3WDbNePRDI6E8fNDW+2Km/Czspa44
         n1PA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775762267; x=1776367067; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
        b=mRxOTARa7KEK/i89Nt5wG/esGfHtqRc+wZKzGDt8l+Mf4F47U59XvNjN4jbdK/lFHs
         lYSqDbgpTyAUrkAZHaUxGbQdrh/T0yN9u4CKjdu9DO1Dw5kteYdPnsZyZuLjsqzLj2Kg
         eyYANlMC3dKz0kCiAmf1O03gdy+XLwwslVsH7yXxfYAyizb5H1rFTNW3AXP2D+7lGJor
         7bZ92RNiycke3zY/JjVCA2323jSIetsrvz/M7e8cquGcTetTTtvJQzoNLyXnOMAr7cTH
         2eZvN4UMtNcAbLACq2RgzcvU9uEqq1vjUsfx3/69fDbKzretMvMRgnzK5Em1dmA1FoHP
         rfYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775762267; x=1776367067;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=AEYSbrTBOCDSCGJnM9iFBLwN4LBHhV86/lUpZVRVxGY=;
        b=RsRs49yhZoVaiJN0MWQF3FdU8902RiiLWm3xJojZfRXwGbjWtViy7swX+gRUxrLNOs
         A6/tj5yEDJNxo9UT7QGPWv5BsAAClkQafYKQQDN0VSNbdjR1KCNZiz03/M6TW7ppCMqC
         G3ib/ZH0O6dYfTH3b8Sdc/vWrXcAK7AJ9zteR3o1oEiWJ9d/zZ/Vm1wqfo3MambSgkJq
         ETv0TMFpAgh/4L0hOt7nVH9AXRiox/r7foNx/TmUNAKB1gXOmnnwQbqlDfMl4IVFjhl/
         DTlbD3GqxIEdOJOW2FRvWXTec22M0jNhxA7w4xXt7GTGCk2BpD3NgP5e8tITvGH/f2SD
         m65A==
X-Forwarded-Encrypted: i=1; AJvYcCW/AvKQ8epCPrDwx5SAWbSGZesX0RTZP/1be9nm58giWVRH58muLj5t5B9kwVdPZ8aRKs1kTVk=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz3yq/jyJiQaqRJRa8hyro1A1J4evpDdhjM9JWnU2rHTSIE+VQs
	LOgE77Tin074olOl/mmFhLpPvGgWxbR8KpcFqCmxRMKGhRy4jtgfrOrVBx4pSSOkLUE7asw7zRh
	EIIOzviR9dbvX2v/3lla6rmid0MViecA=
X-Gm-Gg: AeBDievNM9Ts0SuSa4GKW2Z4WbexYajtu0Xz8w0/DNL4MJ2C3XXyA9aWKEisB0kTyKV
	p9XQ+k8y11rPmmupWyN1362Vgm/jeNh/1IClk2HySEWw2pWveacssV+GORwjPMTGdyUoAH1CUhJ
	Do7QFhPxgXYtHfPo8p/2IaLvRsSVz12FPs0BiRfoExNPsHjA9ac2OVHBJ+5u7ayP0zbVq8WJBWz
	5wBOrZvdyVGGsvDoGhXc9/yV2hhWxWYlf4oi4vtdFZXlFb/Z1VKNncOg1+D/3CK9p64tJN5mwEx
	IOjaOh4KvIBMlScWNQ==
X-Received: by 2002:a17:907:3ea5:b0:b9c:80d5:f01d with SMTP id
 a640c23a62f3a-b9d7248489amr28294266b.15.1775762266312; Thu, 09 Apr 2026
 12:17:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260324173527.11321-1-sebasjosue84@gmail.com>
 <20260324201858.46591-1-sebasjosue84@gmail.com> <2o8np813-n9n6-32sn-922p-6qnrq45s7rs7@xreary.bet>
 <CAPnwWgPhb+owa69-pTADpqk=KMWH71EUT6cxwCeT5KGnBWk+Xg@mail.gmail.com> <7qr72215-4q40-qon4-808o-7o639qq90q3s@xreary.bet>
In-Reply-To: <7qr72215-4q40-qon4-808o-7o639qq90q3s@xreary.bet>
From: Michael Zaidman <michael.zaidman@gmail.com>
Date: Thu, 9 Apr 2026 22:17:33 +0300
X-Gm-Features: AQROBzDUKfzKx0I6op-NC1K0D3CmW-7Z4_EpR32Zz1oP0pvTVWsGpsyO6bE_-Mk
Message-ID: <CAPnwWgOMNxU+vPx2a3aX4DDOMiW76sE2enVfCKk7gP+pSsoXgg@mail.gmail.com>
Subject: Re: [PATCH v2] HID: ft260: validate report size and payload length in raw_event
To: Jiri Kosina <jikos@kernel.org>
Cc: Sebastian Josue Alba Vives <sebasjosue84@gmail.com>, Benjamin Tissoires <bentiss@kernel.org>, 
	linux-i2c@vger.kernel.org, linux-input@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-235495-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,kernel.org,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michaelzaidman@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 0276C3CEFFD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, Apr 9, 2026 at 9:29=E2=80=AFPM Jiri Kosina <jikos@kernel.org> wrote=
:
>
> On Thu, 9 Apr 2026, Michael Zaidman wrote:
>
> > The FT260 uses different report IDs (0xD0 through 0xDE) for different p=
ayload
> > lengths, with each report ID defining a different report size in the HI=
D
> > descriptor. So yes, the device can legitimately send reports shorter th=
an
> > FT260_REPORT_MAX_LENGTH, and a blanket size < 64 check would break vali=
d
> > short transfers.
>
> Perfect, thanks a lot for the detailed writeup! I was rather suspicious
> about the bold statement in the changelog.
>
> Similarly to other Sebasti=C3=A1n's fixes to various other drivers. This =
will
> need more thorough check.
>
> Thanks,
>
> --
> Jiri Kosina
> SUSE Labs
>

Hi Jiri,

Indeed. The original patch would have been easily caught by testing on actu=
al
FT260 hardware - short transfers using report IDs 0xD0 through 0xD3 carry w=
ell
under 64 bytes and are part of normal I2C operation. A blanket size < 64 ch=
eck
would break them immediately.

I'll submit a proper fix with per-report-ID capacity validation based on th=
e
HID descriptor.

