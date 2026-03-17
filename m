Return-Path: <stable+bounces-226091-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QNduLvluuWnjFAIAu9opvQ
	(envelope-from <stable+bounces-226091-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:10:49 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A6E12ACB99
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 16:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DC92D318269C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 15:04:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06D603EAC82;
	Tue, 17 Mar 2026 15:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="d3ToPGl4"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D41BB3EB7F7
	for <stable@vger.kernel.org>; Tue, 17 Mar 2026 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773759870; cv=none; b=Qxkanbt26BwcX1It+E/AywwavrsmG3XmHOnKkgL5OKGNO8kL8ldWmysHgUe6rIE8Kr4BajYbpsM/JKmFjtyr27qa4gDNevbtYRikgenLeQGie5IzBKwFJff5WeVqe6nTlqFM72NPwLkhytQh7DGbV1SRocEFrQ+ATqJDjK8FRv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773759870; c=relaxed/simple;
	bh=nyyQ0Jvz3W/XNGjrwr8eHjNjr0NtH31Go7ucCSr4ZaE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tDNo5N/IyXWrxlmGnFCz2psKPL+9mNPOefzAVILWfc32h4cHvUTyI7t11QuGBlI+oqIYuiFY0/qla1dgSjGRjFe+ANe4dVVFvG530moqZnIvcVVmd2awNWOsoBn6PjcplFXF2FV0H5VuxqlYDnl4aT+AdTEcG1pdpLcj2WAbt9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=d3ToPGl4; arc=none smtp.client-ip=209.85.218.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Received: by mail-ej1-f44.google.com with SMTP id a640c23a62f3a-b9382e59c0eso983967866b.0
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 08:04:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1773759866; x=1774364666; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EmqB68e8zeRsyZnE5g39KuBJf3fup+iDfgcaGkuezTc=;
        b=d3ToPGl4fBYD3Az472z6HzOEMjsGavA2TMP68vFVdB8+/RiVM2nEQNEDJL+V3Ik7Ph
         ju61AT2PRHS/57zcmnw+2AXoiM/YuL+W+54cbwHYFYTwsQdVra2mBXBmITh/ALwtvd5X
         ZST9gdSmHh76iu8VUTJuCuTv4+UkrBR7KJp8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1773759866; x=1774364666;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EmqB68e8zeRsyZnE5g39KuBJf3fup+iDfgcaGkuezTc=;
        b=MDJRvGMcs6CS4tv9zKtpCjxBJk2UPmIeiWnE9ztrASFg5Ia1M4UHgj0IQLQfw4fpxv
         IkICz0EHQ8wdkoQJfhkH3uUyicmlb3QbsNFdJLvxk/Q2sjPuW+PFIwaWh6sG6HSMSw11
         jt/e/kT6qOO2OvZmF9wXOGoWwc4i7Pgo2BkpeKx25FUCXmrWcn5WeiY9Og8RRlxfYgIg
         ey1neMZzuUc2kfORCeqWgeXVpkpoHdmzn/f2QxI1YepEdmyyYoJTy1t3oWsle4dd9Bpy
         nx/fu1CGJcdo4jKyyb30hL/PLUeHJsyGOFgrfNDc/GoVFomMgzJyvuz8SiRfWZlvidkQ
         6kRw==
X-Forwarded-Encrypted: i=1; AJvYcCVh8gkqJGPo6Y2Mqx5ScW/lZCabC8MZe4clhzW1zPIYr6VDC037d3xCg1nQ6wa45pbwdGrM0Ik=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz5uRyOKhlJ2/if5fHOnYsp3dCon6lDPW+YkmWu0lvK+2Y7NRrW
	hPiR0AtHMExdESpHvSFTUBlqXVKUuHVV8caqd9QEXcxZVcDitO/9LCZjlEQwdelZt/8ILW72W0v
	TXAq2vQ==
X-Gm-Gg: ATEYQzxeG6R2+Js6nYIEMGtH59doQeCl1e+GIkvea3+E94mlTAUzPFTwlTTAm1oP3jp
	m5WZOrqo6pqr1L0H72/LUgkX596nAEj0TfLb9xPKnAbZ/eM6vJjkD9cq8io133uzpdcXnJV7z+E
	Q4uUsBlnghzseQQZkoyiYK9mSq2t1BJso1XyNCK8yYxqeRbyEzYCNIOngMkES9iypiLKAU7joIm
	WhJwFBuirwF8WT5N7EGYW/NVdGp1fs01REYqJqPghPbVdC5cVO/q45DlNraeveWUHP8u73lQ7PE
	u4/tl+FRLeR4NtWUXIG0llNChkjU0aIxzCD3GiPmuyN4gDNZx9DOb+Q/4wQPZZgkTqpR9qi0OPQ
	MEWaFZCYOmBidOvjrzhOmEV6Z0L8hWD9rJX0zuo4NLHLUaT2U+UkMmgTsm83KituWPD3cJ8ACGI
	UgalIqnMix9hvzypXxJsAOa3Ve0dXwPmI9wMRVzNV8MsqOl+nGRNuuFiwp5JxWGQ==
X-Received: by 2002:a17:907:da7:b0:b97:d11b:5b7b with SMTP id a640c23a62f3a-b97d11b7917mr399143466b.48.1773759866400;
        Tue, 17 Mar 2026 08:04:26 -0700 (PDT)
Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com. [209.85.221.43])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b97f13ee5c0sm5503266b.5.2026.03.17.08.04.25
        for <stable@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2026 08:04:25 -0700 (PDT)
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-43b4d73463dso547924f8f.3
        for <stable@vger.kernel.org>; Tue, 17 Mar 2026 08:04:25 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCWJ6Q7qFf2fx+JtlsKxrDXdlsJC1CH9eSxvafChW/0qx2vCpUKozdpm9ymvMamwQoD3gQJW04g=@vger.kernel.org
X-Received: by 2002:a05:6000:310a:b0:439:de1d:74ae with SMTP id
 ffacd0b85a97d-43a04d868c3mr32139912f8f.22.1773759864635; Tue, 17 Mar 2026
 08:04:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026031716-vanquish-boots-d9b3@gregkh>
In-Reply-To: <2026031716-vanquish-boots-d9b3@gregkh>
From: Doug Anderson <dianders@chromium.org>
Date: Tue, 17 Mar 2026 08:04:13 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VuMD3K8k_jM3S6du9x8F0rzJ=fdPRFTiOSDEkN+uPWKA@mail.gmail.com>
X-Gm-Features: AaiRm52VosXbnQJHo2eq9Flopr3BDMn44f_7B4_hlMatwo9-JB9pN272-fpzuvo
Message-ID: <CAD=FV=VuMD3K8k_jM3S6du9x8F0rzJ=fdPRFTiOSDEkN+uPWKA@mail.gmail.com>
Subject: Re: Patch "drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not
 used" has been added to the 6.1-stable tree
To: gregkh@linuxfoundation.org, stable@vger.kernel.org
Cc: franz.schnyder@toradex.com, stable-commits@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chromium.org,none];
	R_DKIM_ALLOW(-0.20)[chromium.org:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226091-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[chromium.org:+];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dianders@chromium.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,toradex.com:email,chromium.org:dkim]
X-Rspamd-Queue-Id: 2A6E12ACB99
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Greg,

On Tue, Mar 17, 2026 at 4:54=E2=80=AFAM <gregkh@linuxfoundation.org> wrote:
>
>
> This is a note to let you know that I've just added the patch titled
>
>     drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not used
>
> to the 6.1-stable tree which can be found at:
>     http://www.kernel.org/git/?p=3Dlinux/kernel/git/stable/stable-queue.g=
it;a=3Dsummary
>
> The filename of the patch is:
>      drm-bridge-ti-sn65dsi86-enable-hpd-polling-if-irq-is-not-used.patch
> and it can be found in the queue-6.1 subdirectory.
>
> If you, or anyone else, feels it should not be added to the stable tree,
> please let <stable@vger.kernel.org> know about it.
>
>
> From 0b87d51690dd5131cbe9fbd23746b037aab89815 Mon Sep 17 00:00:00 2001
> From: Franz Schnyder <franz.schnyder@toradex.com>
> Date: Fri, 6 Feb 2026 13:37:36 +0100
> Subject: drm/bridge: ti-sn65dsi86: Enable HPD polling if IRQ is not used
>
> From: Franz Schnyder <franz.schnyder@toradex.com>
>
> commit 0b87d51690dd5131cbe9fbd23746b037aab89815 upstream.
>
> Fallback to polling to detect hotplug events on systems without
> interrupts.
>
> On systems where the interrupt line of the bridge is not connected,
> the bridge cannot notify hotplug events. Only add the
> DRM_BRIDGE_OP_HPD flag if an interrupt has been registered
> otherwise remain in polling mode.
>
> Fixes: 55e8ff842051 ("drm/bridge: ti-sn65dsi86: Add HPD for DisplayPort c=
onnector type")
> Cc: stable@vger.kernel.org # 6.16: 9133bc3f0564: drm/bridge: ti-sn65dsi86=
: Add

Yes it belongs in the stable tree, but it has a depedency. We need
commit 9133bc3f0564 ("drm/bridge: ti-sn65dsi86: Add support for
DisplayPort mode with HPD") _before_ ${SUBJECT} patch in order for
thing to work properly.

I thought I got the syntax right, but maybe I didn't?

-Doug

