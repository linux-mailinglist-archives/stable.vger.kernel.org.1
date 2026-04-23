Return-Path: <stable+bounces-240473-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eJpxD24H6mlCsQIAu9opvQ
	(envelope-from <stable+bounces-240473-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:50:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 94E084517B0
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 13:50:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 20C323016D25
	for <lists+stable@lfdr.de>; Thu, 23 Apr 2026 11:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB3C33E9596;
	Thu, 23 Apr 2026 11:50:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gFa3K2qh"
X-Original-To: stable@vger.kernel.org
Received: from mail-oi1-f172.google.com (mail-oi1-f172.google.com [209.85.167.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4F6893E6DDE
	for <stable@vger.kernel.org>; Thu, 23 Apr 2026 11:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.172
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776945000; cv=pass; b=X+izjaedMzBRLpocl6yHMqATVo92SdfdV81PkzOuDSBWSPS6VgS8wPxK8mAjt8tD3ENAViiAcRQAS3Kn/DTNcZh3fb1QvgHXWoa2vKvNxMFy6sP940jmiK0/9wMwPG6rWoShlQioAIil8Su1kfmdpEH8gqdFzI/ji6stv8E7pto=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776945000; c=relaxed/simple;
	bh=NMysmFkGdL7lDHKDD0+dBK5B2PGw1As91n2z5R0Wi3U=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Guww+U572tUOlUlgxIqhVQp+VlFNATb2N14TMz7XsOef+a9HaYwj9koe7EvWT7yG+dJTFTBYEVD3kj2/K0JF7ZEE8ERELadkzuQGnLYsrBnkZBlxEJQheoiYtb+obHWJX1stZ0T3+hAyVermofgsLwKyP9TKl6yAL3dLQjMR7UQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gFa3K2qh; arc=pass smtp.client-ip=209.85.167.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oi1-f172.google.com with SMTP id 5614622812f47-479ae363aaeso3697643b6e.1
        for <stable@vger.kernel.org>; Thu, 23 Apr 2026 04:49:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776944998; cv=none;
        d=google.com; s=arc-20240605;
        b=aipvvOwxKS0iEi6jNiHBWrj8MbBgut1H9+vQoZuduK4ns8Z5SWIkGIYL7F1w8EwbtU
         nKYBaDZchIG5M0HvM9grBmEPwBUwBWrb3htpFgUV4FeJye1DgCIPIYskLpRId1IbWhxe
         eU2ZeR9LPo+Etw28yeZFSrKYBvjwfU0kYOyn6RR0A8ehH2vJs4OefwGo5swnO1hnyoln
         pP5xINH8WYvdKjPEtJeEXAyabXE0kYIhRh3XOp3ulm4JoOKx/+2jbSW3GF0O1n/q6grV
         N4GjU+uN8+3kvYvPUzVW2wg4Mo0eOLCAoOsW+eDKUTJuP23BXQpXcxuKw7lSQ5FRGGwF
         GkCQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=NMysmFkGdL7lDHKDD0+dBK5B2PGw1As91n2z5R0Wi3U=;
        fh=MBpsBgP/sP8kWawKOm3XSTkpauLEdPqRmoWO0K7zKi4=;
        b=ieJqzu8aYUAzonq+Wlly2Wu+/si47hmBFybkr7cekA2/Xx9oeg5rRoS58EcIvwCa3W
         Qvz3WmEtFdzt0Ft+nx56c4c7VXfbUq2QL1QcAKgRNHaxLbHGN+C0aOhqU26tymcXEmLT
         xtgWOEgGACHgg9Aqk5XnKZ/bk9Ztt2kg+sM7TzplH6xqbG+eO8OgoSUUzQsx062lag/E
         b2eOkH3Ic2fP+sGb9Pcbns4jqbysGk4iFSXHIK7bkBkXF2vm5XpRMCrYGekqiK6UTVzz
         IXuq5RXJhthSdZzCWkbkMbkB7ehsznYSXWrPaAfbaUSZuhYlf/Do2fYNYIuJZSnBH+9d
         aZfg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776944998; x=1777549798; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMysmFkGdL7lDHKDD0+dBK5B2PGw1As91n2z5R0Wi3U=;
        b=gFa3K2qh/HYr9L/MnZ/fmd+PRW+xo8o9ONa3ErnzQtWbZ6ORwlVpo+845CGNN2DVhO
         AZgfbtTFhf3PX62s/QHqxcEaA7KHfZhuOp4EJZVC9Iy5fI5gc4ZmYU+dHCzDhyrhjK8g
         h6ZkS9nWJvNrAT5vC0BvRTASXhJoIPt/ctLYGVhQ/99wX+dnwkCzDvBpkebk2yYL2H6U
         eoJozTcEMG2+yZUPqHpaxWuwoS9zl+x36iIfeDla+ffUCCQxidPYhUCIUyhD75Swpf9Q
         rCUBfzmDDjQ0/AJiqk7MWO1VRonS/gIslmh4ZZQLxtZBQKJdKcXhgdsVxFXrDk5Un5U5
         SL0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776944998; x=1777549798;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=NMysmFkGdL7lDHKDD0+dBK5B2PGw1As91n2z5R0Wi3U=;
        b=BLpEQfJP9LvPwqnocsEtkR+4aqIDUEKQBhZIZ1X6IUvZqMN1jXvz+BqPPDJ8pA4HzA
         QrW1oiRQPuWnmpl042WlqOVlKlO+WpaOpM8u0bT8V4DKDetxYy8LOUNQjzyHJVHf9rmZ
         58TrmSaVb6TYEfDSk68k4Ew5EK7T3SbpfyW53zJzmzv/K9x7qyVGEdDLsqnegjzWhWuj
         uABPuURnOsr7qrwt/GvU8Jp3UCH7B4/fV1Pk0fY4lJI3Er7mLPrjQoUeqW8jHh3rvAFY
         rB2do4nXCP/GkwizZVyqlc1RkVjV8kTLgIcXpJoi2WUCYznca/cwerfdXbX5RFGzuXVt
         2D9A==
X-Forwarded-Encrypted: i=1; AFNElJ/96/tPm4CiRRYDtIpvLfNpRFFTfWkd67yTuEQY5U/mJrkZMU6dZutmwoFw515CfEbK4NgVp8c=@vger.kernel.org
X-Gm-Message-State: AOJu0YylThxWwLvgGw0oXt13zFs+90VoR9re2lQ++cCczaZS0XNNiwlL
	F1BSV/dQS7lf506N8YhXKrFlVxErDPktWTY34VCXI3Z7WoPdggDpJnTjuYr7rR87emuZ8gjCzw6
	wplHdIwxZVFjhGK0Nqi5/gckbGG427og=
X-Gm-Gg: AeBDievY09kXjpdWRbea4SJlFBLxXCEtbvnFWMyJ8Fvl8z3eIEWe4kQpzIOjH6H6QEr
	2Vs24OD3PuB+3v6TsXz1sOx9okWKVJfhL4KjaydB8JkWWafr9A+iA6rsCbyqCxyTs+xe5yRasar
	JLJPDFvmcW5aWoFeA4xqGwvkcvZaJKLJyvCkVmwi3VOdmASDa2kE+ee575QPI25mKO8lV+fsDmG
	F7Ks4SYE5zqtn/xZBbE2uamIr5DCX3YVKzqCXkQgWWcHlmPzCsQ9oCTUy5j//WkbGniKrxubHzF
	ZcFZj9mwaNRMBqXurDQ9
X-Received: by 2002:a05:6808:ecb:b0:47a:4fd:95f0 with SMTP id
 5614622812f47-47a04fd9f84mr2979376b6e.12.1776944998182; Thu, 23 Apr 2026
 04:49:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260331061657.79983-1-mikhail.v.gavrilov@gmail.com> <IA0PR11MB718531C51736C57114D6DC2CF850A@IA0PR11MB7185.namprd11.prod.outlook.com>
In-Reply-To: <IA0PR11MB718531C51736C57114D6DC2CF850A@IA0PR11MB7185.namprd11.prod.outlook.com>
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Thu, 23 Apr 2026 16:49:46 +0500
X-Gm-Features: AQROBzCsr1tF7ROC5cSogOzcFX4U95VM00zHhQ_fb0LBMmia49ui3DZvV8SxZFk
Message-ID: <CABXGCsM8T4e8kaaO_bauHnN0yE5cxwkkcN+eAJWE8hnJ8RdSRw@mail.gmail.com>
Subject: Re: [PATCH v2] dma-buf/udmabuf: skip redundant cpu sync to fix
 cacheline EEXIST warning
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>
Cc: "kraxel@redhat.com" <kraxel@redhat.com>, "sumit.semwal@linaro.org" <sumit.semwal@linaro.org>, 
	"christian.koenig@amd.com" <christian.koenig@amd.com>, 
	"dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, 
	"linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, 
	"linaro-mm-sig@lists.linaro.org" <linaro-mm-sig@lists.linaro.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-240473-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[mikhailvgavrilov@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,intel.com:email]
X-Rspamd-Queue-Id: 94E084517B0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 1, 2026 at 6:15=E2=80=AFAM Kasireddy, Vivek
<vivek.kasireddy@intel.com> wrote:
>
> Acked-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> Will push this one to drm-misc-next soon.
>
> Thanks,
> Vivek

Hi Vivek,

I see the patch landed in drm-misc-next (504e2b4ab97a, tagged
drm-misc-next-2026-04-20), which targets 7.2.

Since the patch has a Fixes: tag and Cc: stable, would it be
possible to also cherry-pick it into drm-misc-next-fixes so it
makes the 7.1 merge window that's closing soon?

The bug is reproducible on current mainline and affects users
with CONFIG_DMA_API_DEBUG_SG enabled.

--=20
Thanks,
Mikhail

