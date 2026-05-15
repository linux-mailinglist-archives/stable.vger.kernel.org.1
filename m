Return-Path: <stable+bounces-247301-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iANUKilyBmqyjwIAu9opvQ
	(envelope-from <stable+bounces-247301-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 03:08:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 27D2C54843C
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 03:08:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 65DFC30570D3
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 01:08:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AFDD367F2E;
	Fri, 15 May 2026 01:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i1MwaPxK"
X-Original-To: stable@vger.kernel.org
Received: from mail-ot1-f54.google.com (mail-ot1-f54.google.com [209.85.210.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CFC28686
	for <stable@vger.kernel.org>; Fri, 15 May 2026 01:08:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778807308; cv=pass; b=bGjE0eIOhFIEFpzrovkjTa+QDL+xZ9WAz/9WkceddpFBIkH9dK0XuysAv1TkW04jRuVVM4GuOY5nNZ1Wbc4J//mTDMqk3Xr1J2EWv8tOGPPOIsTUAl8lk0N6IwEvEpMMuXCVAJHA0/7AW8jJ24v2GU3t/0Y+eM/as7uYWmrRoTs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778807308; c=relaxed/simple;
	bh=Tjy+wLAt76/SgLvXzCA18dCPcMxTTSJKx0uzseG+k/4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=uCux4aop6e0JkLmFSDpQUTK19256nhZ/FJxKH5eFkj0QemNtSfS0HCOJSGwW2c8wqXPmn5yaqXpx+NtriWBH9cjM+E4MCnjRtgFoobN1VYll7ooT57s3vBa9tl2b+H99JlGt9VF8xF5CPG1QciTX3nGkld9yTIhq3jAJFCi4qk8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i1MwaPxK; arc=pass smtp.client-ip=209.85.210.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f54.google.com with SMTP id 46e09a7af769-7d4c383f2fcso6990934a34.0
        for <stable@vger.kernel.org>; Thu, 14 May 2026 18:08:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778807304; cv=none;
        d=google.com; s=arc-20240605;
        b=f8tD3RCh2eiCnX38f2kMInx5armTiboPu5pgMI6Zl/V2LZFNykWKaiFgwdN6s9Rc5E
         hfiTK6dZXQkxexPeekaogWArxorxS2gk9Oz+YyRTo4GEDgrapsHVg6J3NGT8mWS6ICtl
         Vbtecly3uw2G9RI9emPO0Rgeh6OC/HuySHi2AxV6ahVkhQuWrmkbf9wwScNNQOaVagj2
         rK14j1j/fdyyB8TRDXEplNL2R+GkfrRCpbSqIFljzY9pNHBHjCZigQHn21EQLIZtKf36
         ExK9Me/w2W84rDdShvIC0YrmWpqUaqwrQCi6WDhGrkvZeEUO+yY1WygbaZHwi4oLnex/
         7IUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4uAqE+q2UzPII5vnt4wx5yy+f2NRVPMEBmYSwydEl30=;
        fh=reRn+pdYIl0Cw8jdM7BR2gkSgfuNGx1aDVXEeJdGNvk=;
        b=hHqwO51i15XugZT2EpssuK0k1DQz4hGhusvBhiRtLWVYtTw8/YfRQLgOltcuHxCk5Q
         JVXJDnaYj6cVvTAn3NcdUhyHw31RQXXDx/ICD9MjF3UMekM2XrzLLbLZq/k0/jGaJDUt
         gf3Ws4d7ACUv5mHAL3KAoflPlzrQQ3XB6Vz+H8VKAZGaTqZAW7m9ZHQpWwZGzjASpGX8
         tTC2VWK7jv9INTl7+VZNIqWfTmBYqZOEdC3qjB5NHj5nj7VH7UF39CNur8u4mVkvAyDV
         ZkyRH1JIz7BIt/HaWd1vpzgueL2AwhRSqu+3Vy/csuHNY4dG4ap5Gw52C42ZdEEHcmJj
         u8KQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778807304; x=1779412104; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4uAqE+q2UzPII5vnt4wx5yy+f2NRVPMEBmYSwydEl30=;
        b=i1MwaPxKlJBj6YnS33rrgrCoAF74MxK+bSVTgeZN5u86Iqj+xrX0paCiEVEqmSBk19
         uT1MRbVCdWh95NSkLnJS6lkPbDwBMZFSrfuguUrvJASsjkd+jDSCT/0WPaefPDXgZ9NQ
         oqJxyiNqaYwmoPKHH8o95KlkGklmKHLfGokGEukZFZRu9ik+0+lY2HKrvfigWhz/HvGl
         8qWzQXPYQ+IFjjTCT0Dx0v4tMRbnO2OlXZUcepqMfmjB+1zPnU7A3hzpsS6TbWPsYQIo
         QEA9KIAuZcz69lzZpEXsy2gF4Vk2EcPDZGxrY4EXS6/9kTb+Twit2qyvyrrmZ5FBSpJ8
         rv4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778807304; x=1779412104;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4uAqE+q2UzPII5vnt4wx5yy+f2NRVPMEBmYSwydEl30=;
        b=HTnKUhtPnt4vX++Xp6sGKDEJ26QNzyg2lvitg0NvNCo6VBphObe2IJ92vZZfssCHwk
         sWNAZQre6+9Y3fUStJHmgSgK1dGiM3Fa93kmKC5kXjQWBKtHstdiQ1csZ/9DmoV/MgO3
         6yEMeMOP0I4CYwPpg9No+Se29cM81z3hMudAxV52tx/CQ9K7vXfli0piFjgPQ5QcnJRz
         e31pffQvRRNpgPHjqVdSXtDv+2KrwlvUzIr+tQsXiRqKIvU3n12V3ORj0RjAdgjv3fNw
         +nDdhsk6oATrxPjawpAEQSeamt4pb1XHyvVZgq9865+PhHGG23+U/OvU98sc5iVRGnga
         Qkhg==
X-Forwarded-Encrypted: i=1; AFNElJ+IX4V2CQ+O5PJ7I3yQS2yEt3Zyxb6DLf9tOFJZoKtqGUCZ5hK49P/p8s6d03nYUeabvp/7TlI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwzAPOKUVQtKa0A2asZNFwibltIui/l8lVztBuoCsXIy3go7zjV
	MPb+XS1sDYEid01My2EQhMY6vsHRteICy4I4C3gcqyVhmrOvxY66o8n95jQ12t8FcZ/FK1sUllA
	ehvU/cj3h1S32hwk4z1Ex5XuakC8FX3o=
X-Gm-Gg: Acq92OHjrPqQZWEEoyU1Ib5wcwbE6e2e5khvnbZ+7928qhZnEUYj3cpLMJ0Q4HdlWL7
	cGsE8wAux7qKGgXSIcL9pAzgi4n7Oyd27aHrSsFC1CNCio7Ah8mz1vLGvzS3MBO6XHKx4lxUrLO
	8pypwL6sh34nU8naaDvK7ifgvYeQkkzoicwN47m+aFLQfDrl9D8Cf5mdLphELwjUxGmPfEWyD7Q
	2X4ZqSQTXqNMFhUT+rHFJvoEaZ5NIxh6xCok85jSsE19G9D/XkE43LPjzY1L6IgTsPd9fiP43gn
	btQQR3JUtv8AAtKvWViyKv7kbbwssdNUW+QPTp8i3KcVj0Ad6Q==
X-Received: by 2002:a05:6820:2982:b0:67e:160c:36ba with SMTP id
 006d021491bc7-69c9bfb1664mr1186419eaf.48.1778807304424; Thu, 14 May 2026
 18:08:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260513-kfarnung-ath11k-srng-clear-pointer-state-v1-1-bc700dd8b333@gmail.com>
 <ddd1601d-2eef-4a52-af16-594223449c8c@oss.qualcomm.com>
In-Reply-To: <ddd1601d-2eef-4a52-af16-594223449c8c@oss.qualcomm.com>
From: Kyle Farnung <kfarnung@gmail.com>
Date: Thu, 14 May 2026 18:08:12 -0700
X-Gm-Features: AVHnY4Lvlc5Ig89TV5C-ke-68Gt-iwIwGCcyok9295LT1kww5dL6ntxLMQaGick
Message-ID: <CAOPSVF3RgoV0e2EGbpy8t36mPKnn95_KWGt4_xSL7B9m6pv_RQ@mail.gmail.com>
Subject: Re: [PATCH] wifi: ath11k: clear shared SRNG pointer state on restart
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
Cc: Jeff Johnson <jjohnson@kernel.org>, Muhammad Usama Anjum <usama.anjum@arm.com>, 
	Baochen Qiang <baochen.qiang@oss.qualcomm.com>, linux-wireless@vger.kernel.org, 
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org, 
	santiagorr@riseup.net, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 27D2C54843C
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-247301-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kfarnung@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Thu, May 14, 2026 at 8:16=E2=80=AFAM Jeff Johnson
<jeff.johnson@oss.qualcomm.com> wrote:
>
> On 5/13/2026 9:52 PM, Kyle Farnung via B4 Relay wrote:
> > From: Kyle Farnung <kfarnung@gmail.com>
> >
> > LMAC rings reuse the shared rdp/wrp pointer buffers without going
> > through the normal SRNG hw-init path that zeros non-LMAC ring
> > pointers. After restart, ath11k_hal_srng_clear() can therefore hand
> > stale hp/tp state from the previous firmware instance back to the new
> > one.
> >
> > Clear the shared pointer buffers while keeping the allocations in
> > place so restart still avoids reallocating SRNG DMA memory, but starts
> > with fresh ring-pointer state.
> >
> > Fixes: 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and r=
e-initialize again")
> > Cc: stable@vger.kernel.org
> > Link: https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=3Do9wV=
cFMc6f-yhmSBcZqQ@mail.gmail.com/
>
> I'm going to change this to a Closes: tag in my pending branch

Thanks, that all makes sense.

I'm still running the fix locally and haven't seen the issue again after 9
suspend/resume cycles.

>
> > Signed-off-by: Kyle Farnung <kfarnung@gmail.com>
> > ---
> > This patch is the result of investigating suspend/resume failures on a
> > Lenovo ThinkPad P14s Gen 5 AMD with ath11k.
> >
> > I originally proposed extending the existing ath11k PM quirk for this
> > platform, but after discussion in [1] and bisection the issue appears t=
o
> > be a regression introduced by [2]. There is also a parallel report in [=
3]
> > that appears consistent with the same root cause. This patch keeps the
> > intended no-reallocation behavior from that change, but clears the
> > preserved shared SRNG pointer state so restart begins from a clean stat=
e.
> >
> > Testing so far has been limited to local suspend/resume cycling on the
> > affected system. The issue was originally reproduced on v7.0.4, and the
> > patch was also built and tested on top of ath-current with repeated
> > suspend/resume cycles on a Lenovo ThinkPad P14s Gen 5 AMD.
> >
> > [1] https://lore.kernel.org/all/CAOPSVF04q6uvVdq8GTRLHBrVMdpt9=3Do9wVcF=
Mc6f-yhmSBcZqQ@mail.gmail.com/
> > [2] 32be3ca4cf78b ("wifi: ath11k: HAL SRNG: don't deinitialize and re-i=
nitialize again")
> > [3] https://bugs.debian.org/cgi-bin/bugreport.cgi?bug=3D1132343
> > ---
> >  drivers/net/wireless/ath/ath11k/hal.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/net/wireless/ath/ath11k/hal.c b/drivers/net/wirele=
ss/ath/ath11k/hal.c
> > index e821e5a62c1c0..0c0aeb803018e 100644
> > --- a/drivers/net/wireless/ath/ath11k/hal.c
> > +++ b/drivers/net/wireless/ath/ath11k/hal.c
> > @@ -1387,14 +1387,21 @@ EXPORT_SYMBOL(ath11k_hal_srng_deinit);
> >
> >  void ath11k_hal_srng_clear(struct ath11k_base *ab)
> >  {
> > -     /* No need to memset rdp and wrp memory since each individual
> > -      * segment would get cleared in ath11k_hal_srng_src_hw_init()
> > -      * and ath11k_hal_srng_dst_hw_init().
> > +     /* Preserve the shared pointer buffers, but clear the previous
>
> Since you are touching it I'm going to change this from the obsolete
> networking block comment style to the universal block comment style with
> /* on a line by itself
>
> > +      * firmware instance's hp/tp state before handing them back to FW=
.
> > +      * LMAC rings reuse this shared memory without going through the
> > +      * normal SRNG hw-init path that zeros non-LMAC ring pointers.
> >        */
> >       memset(ab->hal.srng_list, 0,
> >              sizeof(ab->hal.srng_list));
> >       memset(ab->hal.shadow_reg_addr, 0,
> >              sizeof(ab->hal.shadow_reg_addr));
> > +     if (ab->hal.rdp.vaddr)
> > +             memset(ab->hal.rdp.vaddr, 0,
> > +                    sizeof(*ab->hal.rdp.vaddr) * HAL_SRNG_RING_ID_MAX)=
;
> > +     if (ab->hal.wrp.vaddr)
> > +             memset(ab->hal.wrp.vaddr, 0,
> > +                    sizeof(*ab->hal.wrp.vaddr) * HAL_SRNG_NUM_LMAC_RIN=
GS);
> >       ab->hal.avail_blk_resource =3D 0;
> >       ab->hal.current_blk_index =3D 0;
> >       ab->hal.num_shadow_reg_configured =3D 0;
> >
> > ---
> > base-commit: 54a5b38e4396530e5b2f12b54d3844e860ab6784
> > change-id: 20260513-kfarnung-ath11k-srng-clear-pointer-state-91d8ab07e5=
e2
> >
> > Best regards,
>

