Return-Path: <stable+bounces-244979-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UHV8LJxk/2lM6AAAu9opvQ
	(envelope-from <stable+bounces-244979-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:45:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4ABF2500892
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 18:45:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 40478300A8DD
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 16:45:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E79C2FF66A;
	Sat,  9 May 2026 16:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SOhQ6UM9"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f67.google.com (mail-qv1-f67.google.com [209.85.219.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9218D2DC791
	for <stable@vger.kernel.org>; Sat,  9 May 2026 16:45:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.67
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778345111; cv=pass; b=qi76gi1VztLDOc/9NfIQMeXyvsjg7KI8FmIQukBT/i4D+hukT3wJCCafFkCoA6WjlTBxP/QvJnvdpsTVL5RuWXPjXxYl4fkDHgquSkOPV8828JE9wNiC6hEjZg5hE5ltecUmkoBgmlZ6VXfClLk1opNraMtSQfjChUFmsSkHey8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778345111; c=relaxed/simple;
	bh=RTDsNVE3ocqjOsopP8iwGEg0f1/zwRBYg7404Npk/Nc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=paRlG0/GPfMdztBHi9eEUVqc+zuikBmARW7f2bPp2dfadXmdKSDjNBpxEuMD/nGK8Ea91S8t0rgo9mWl58Fc3ZhP8qn0+Jux4tdoLBvqXKJsAzxWVh+RHRuphGDTn2LF2LaDeazRYoTV7mHILKW6l+oQlCgXG+4zNFFBjKNXFfM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SOhQ6UM9; arc=pass smtp.client-ip=209.85.219.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f67.google.com with SMTP id 6a1803df08f44-8b7dccd6fe4so21976516d6.1
        for <stable@vger.kernel.org>; Sat, 09 May 2026 09:45:10 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778345109; cv=none;
        d=google.com; s=arc-20240605;
        b=C7JxsHmv5iVMdIDyg+oZwqf4O8sCEbfKsTW9PzZtvoncv7tCZk0f/rud0YLsPkrBLj
         PKINHbRUGfwMxoZOmkJDq62gJQ9UCe7xL6qns5lh8bWJa5hDT1r8IzABX5LqKVJBRE0W
         WerN54GYmi2SwhMc3zlXMdRehG0jUVE4RzG4OR9cq7FTom1gPu3/t2aaHcNti4tJZOTQ
         1fQVDmSFocYxFtOuGFEg9OmsJIucRY18uyFmmpJa8kLo8znoYcXP9pjZ2PzvnxisaaTb
         gTxWvHOF7Ggomyhn3sJhJ3s4FQSz2wS092SnMeGqTdRLAepsuFrqNFnz4/dCp32eDP/4
         1/mg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=RTDsNVE3ocqjOsopP8iwGEg0f1/zwRBYg7404Npk/Nc=;
        fh=d4Wp6RtcaDgEFVoVWNd6SIuNROqtnzu+NVBCUPESzt0=;
        b=XrLNQJdsq6yufbmVgNEY05vwIeEnr3veu8TAdQEUqIn06ykgjXR7O3v+G+SHGSp02U
         FHS/wjyBoTtKuO54lOedtEMKv80ulurXliGQ6KgAgGNSO65klebxWR0GucphcycoVxGO
         XrV74VYvcUDMfYTzm/G53k2RH50r9YFQXwmeOJfcaajnHPVNuocZ01dkFf9Yj6IcfZif
         MpgepaUMG4r3HApu3Tru1J98qHQ4bUtq5wLNCDzJrMfJ6qKhAlCnI4oCMCYlJwXM48Ow
         6TuAEvDvcAL+UbdM7RLsDl0iRWjFUYCQAIWNwXqTMo3q/Y1BdRZwxWR12e6s//b1m53r
         D8mQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778345109; x=1778949909; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RTDsNVE3ocqjOsopP8iwGEg0f1/zwRBYg7404Npk/Nc=;
        b=SOhQ6UM9iW5Y1ORgNK8DhGe7xJp6pTWgCmD9IgF8e88Eo7LwNFDIjgpKXMOiEQeToN
         BaCNr6fVJ6FN8EMJ74d2YZOw8ebOb/6y9FOGlbHZTR9shiA9WtE2mTI6eqK6zoMTOYhe
         FTwxPHRXDLUI+COGw/hHFhWCP4w+DkbeQefXAs3cnip9XpQeIpofEuqiYBydTQav7vEL
         KZwWtyA8b3IPZKx/SSBe0Xoz3YAVz8Y4drMt20vc38WF0IMtzq9b/qZgpfaYnLmPKY25
         VRO4MLcFwrIDQWXFcZHhdc/ysKjLXPObNyXdzxmkwDC5rGCG65p+/UPBzgF1nsfimeL2
         +aAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778345109; x=1778949909;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RTDsNVE3ocqjOsopP8iwGEg0f1/zwRBYg7404Npk/Nc=;
        b=Xl+Zp/N/oPd/R7vJeKVP1wrGSFMsaQSMwdHXXvsfIzVE5808wRw6ue3yDl9D2pOS7P
         PmAuA7PhkwqFuaE8oHKDqc4XuBLCKDGv8NXMXnwJW9HmL33nt4TPcZ+gAgOe9uTVhwp/
         Ryv4j9k/hG82UiIYwoX/RdiV+0EcgAXR4yc0oItxwuBAaSwto/2GMsvMuOuPeCnd1+5g
         4IsONUYwo6EsViGp3Sxl4o87fyO4o1ZlgR2CxhnBtAzUeNQZpE0YW8H7WG46xv6D3f8r
         E6GeH52TTYTbtq+PlbiRa2ZMwcfgWF1K4Slo8qI5Na4jajovBVAsIjD/MkQzTJzgqUCr
         GFUQ==
X-Forwarded-Encrypted: i=1; AFNElJ9ipCPmysZ4GpT0rj/CDQiYX6uCetHDdiA2YO23J7D8Zbi9Cckwo3YR88X9wFHXE3Oba9T0UOM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxCCpORAs3GvWedCM0Ehx8zarq7Pj/pMvf6bh4le/2/juZEFoSQ
	tHNbP9pxmyL+vJiVrGdInBMkM7IIkv4X7aK9XC6Zl1uNmlvvLgdfSvTBsKxW5K6JR7X1Z80pkmT
	Cysj55zGyj4Vt0+td3yAs+jU/dMjMcNk=
X-Gm-Gg: Acq92OF8Cftj7hjDV6AJxvqYKF3/h5RDRbGptj4vC/s2Qa4+c5EHxBlIMRlJPfLDJpY
	SFZlmiZEbcIP4p0SARTH9F8V4xY+i2wgFaWf0wQZah0Fgo0Q++y9vvpNzQ0MN3vD2nK41mIOYon
	ZXSCoalvLRjRp+pGIyWPqaUL35M3HHsKaSw/WbHJKHd/QLbxVKBuVMxezvsQ9iTwZAlpk3bko2c
	93xufWr6R+F4xnB1doZvykGmGyXq6M92YxpyKDoWRcFRls5H95TxYlTr3JHIsung/Yv7PI84564
	hDNlx6GfELcRmsdE2M65MYetLude3n7NbCLwHCwxQ7jFjxezVQw8umh0dvGzbNYJ5cqz
X-Received: by 2002:a05:6214:48e:b0:895:498e:e9dd with SMTP id
 6a1803df08f44-8bc42784279mr256622446d6.2.1778345109540; Sat, 09 May 2026
 09:45:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260509014246.21649-1-enelsonmoore@gmail.com>
In-Reply-To: <20260509014246.21649-1-enelsonmoore@gmail.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Sat, 9 May 2026 09:44:57 -0700
X-Gm-Features: AVHnY4KgdnUDXFOPNu9q7392VVUMqFCBpgGPyfSaViyblkIGEqmRglq6axhe8Qg
Message-ID: <CADkSEUjuzsGLnL5N43dc6sa6bH8nGBr_U=tf-nXNAkTD7N=Cug@mail.gmail.com>
Subject: Re: [PATCH] mfd: twl4030-power: fix stale ARM machine ID checks to
 use the DT
To: linux-arm-kernel@lists.infradead.org, linux-omap@vger.kernel.org
Cc: Russell King <linux@armlinux.org.uk>, stable@vger.kernel.org, 
	Aaro Koskinen <aaro.koskinen@iki.fi>, Andreas Kemnade <andreas@kemnade.info>, 
	Kevin Hilman <khilman@baylibre.com>, Roger Quadros <rogerq@kernel.org>, 
	Tony Lindgren <tony@atomide.com>, Lee Jones <lee@kernel.org>, Jon Hunter <jon-hunter@ti.com>, 
	Benoit Cousson <benoit.cousson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 4ABF2500892
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-244979-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[12];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 6:43=E2=80=AFPM Ethan Nelson-Moore
<enelsonmoore@gmail.com> wrote:
> The twl4030-power driver contains two checks for ARM machine IDs via
> machine_is_*() macros. These checks are incorrect because the two
> platforms concerned now support only FDT booting, which does not use
> machine IDs, and therefore they will always fail.

I have been informed that this is not correct and the kernel still
considers the machine ID when booting with FDT, though there is still
value in updating the check because it allows removing the machine IDs
from mach-types. I will resend this patch with a fixed commit message
after the 24-hour deadline.

