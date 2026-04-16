Return-Path: <stable+bounces-238284-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YFOTBI6s4GkCkwAAu9opvQ
	(envelope-from <stable+bounces-238284-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:31:58 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6067F40C665
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:31:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A572309FEE0
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B4AC3921D7;
	Thu, 16 Apr 2026 09:26:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTc5fIjb"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f45.google.com (mail-yx1-f45.google.com [74.125.224.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE7E337C11C
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776331615; cv=pass; b=GeOn9q5f/6p9QX05COgNeW9Ba4qZortWYOiLIyFHaNyDgMDTNFqavMbBixAOtP+itQgqZGvfcVoTozcdWxqhyHcaS8FCnr23qEEwWP3FepuqFvvX8aeCjb3wC2u+23pKEk8bZHGmRnSi5JyRvgpg0Orr6ao315/sVUVU04jbJ7c=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776331615; c=relaxed/simple;
	bh=lepRdiQn9/eZXEMWuI5dqLJ/MiRv1qjPyxgCY3ndUqU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=O+ZC4VX1xRPX1lzXOP7PBo7JyBJPAXm8fNcrGBN/YNvMSvlgScM32flKP/9GL+exaFw6f8kVHIkxV7vnF2uuW1L9PxeCrxKLdJzmKhOtfdAsv9+UF01CGyH+yA7hGgr1e6WE89Hf9jGtM/+NkrbF09V50s4KBSCCJ/C0sff+dXY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YTc5fIjb; arc=pass smtp.client-ip=74.125.224.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f45.google.com with SMTP id 956f58d0204a3-651bf695701so2525845d50.2
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 02:26:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776331613; cv=none;
        d=google.com; s=arc-20240605;
        b=YlYZoGG2QgSt0HRNBPckjse3GCIxOOBWAoqAIgXoADSiKlAL0IrYPpe3gVtndjuNOA
         +sMnWoaTkY8gYNoTh7UTYR6rrFO5UDc3SnWVOaKfhMmmYOo4wqOAhfaVqTCTRPVRGH0N
         nZhClCnkpuDu5GkZPNWBKS6Lz2W04kdGH2YjfZe67wswBMRXVNxNNXhcjPAZ16egZtVb
         eZmYJXikCYBRh2/kNXVsr9/DvzvY6fiUIadKGIAFGuna5x7VUY2h+keaT/7JMH6JkTmc
         bqE6oCTT72p44EIh3hXCcheztaCM87Fo8YHJGMRYb8k3Yk9wTiDuf6ZFJ0s9Hr85cWPg
         94oA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=lepRdiQn9/eZXEMWuI5dqLJ/MiRv1qjPyxgCY3ndUqU=;
        fh=9R+oYgADT92c8B8kN05QpR1ldfDyXdsoZ1h7fA0rQiA=;
        b=KE3Ww7KqTmm6KDLWaS24mG1faOL2+/zWlqdtmc+Kf4yUr9WHZZtQbQVB54iZenoxDH
         2lKWskQYKzt2NlZAItiXx6Po9vU/W2WjamAqHoip0pJvLvk/XjPyN54n6GnuYi/UeOyX
         XrqjTbvJmDDXvEnv7f74hh/QyrwsOvW5ldVLbqMxRQj2DcO8OZISqi+UTzl4i6tXjUwX
         AOo8CRSEB1Qma/X2Nq6JbsRyX4xVGIq6P2wtrrTpeeCpVxOgfzy2SIHCCgcSyQjHwdaz
         CH7sQaF/41PnbGFCxPvBHLrr2iYC7kucMQXdojm32MNAidjdghd3TTncerDwO9Uhrswx
         5CVQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776331613; x=1776936413; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=lepRdiQn9/eZXEMWuI5dqLJ/MiRv1qjPyxgCY3ndUqU=;
        b=YTc5fIjbffa2rBHnvzua/iyBe5XNce+bWa+5hpIA/EXPjt67rsn63qP5ThYg9IoL0I
         xOIY1nnRzn6AJR+/O55oIlQwQe+N+WSsK2koY+FPXKeaetnVtQU6bmcNZMAtyrn+szp2
         yfnqaz8qkpSnyRYpfd9DdgCjDUnDtQazY88H8uhlSsBZX0rjzXMTHxp8tTDt7om8sdCT
         9YDU9GTdfht/5AysASL0ENcWPWFl8+Y6hnyxD22Bs2I0YpF5gAnFGyGxPadcz6YnWWiS
         2aSid6iY/IwN3ahah5yGoKnwo+WMexoAr7ALAe3E3YitcnketbAYrKnfLd5oIG/OKZH9
         C4zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776331613; x=1776936413;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lepRdiQn9/eZXEMWuI5dqLJ/MiRv1qjPyxgCY3ndUqU=;
        b=Yr33/38ASxx0D9ANclwCzzPINlRr0+4lX6vHcXaAkP4X5iAVt+LBrlvRm55y5IWugR
         HSJqs0dZc9OS9Mi6/FjtZ9O5esMfkwom7pvEB0UEUXmL2yCWAH0+xDaziLqNdBwGW9IS
         syHLmBrP8s5/L9BC90mW2WGOuOYmUaUvWWUIkqehkd45xCsgg4iqluH29vlKNjFSnb6L
         PmaXSxR+U0n9isEr/BDLConYvZG/wuHPhIgEn2mATQxG3xvw+454vrmTKEk7BH3aE1CL
         SChPugAXCkF5q0zPGnLzjLulTdNEz6nKQxYv/+wgCk+DOS1m8tW58YO8qLdw+5BaiaQI
         VGSw==
X-Forwarded-Encrypted: i=1; AFNElJ8Xc4/Kcs/DlwZmKSLAYhLZKcE01xPo7e9teZAzx3ioHYNstXQaXfh/EbecrDpbc5Dz+oZnk3s=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyygi17peGKVXrGNjpBRlET8oScbAJu+6gT26v1SCEHOJCVvGUx
	h8c8DGpUha3L0wfLssdxkbedXC4igoHDiXXsQg1angQulb4HWDi8HCg6VrL1N1kE8dmpcWNQVbl
	HJfDYZeifJLMGkDqcOrx0LQ+Tg0OrH+c=
X-Gm-Gg: AeBDietCq77zbh27ggqWA6FBapIOGqtZynLQSYO0voP0R+Hn1ApRkfAyI9wsEgzGCzt
	Oj1E8g75lZFxuvNqkLu/hbTHfwVqDRG++t8vqtNn++OFz3OKSps74+Ox287/TlbEZq67V3mOFko
	yCJrhKwO9o3Jh4Egni8Fe3oubQjV9PB68XRrTnjbQjNTQrivRu8ID4uiegk6KvGIaRQiZTRmmKW
	Q1FgFhAnDFspdeZH5cvgsRjMaN0toDX6eFza3CLwTiGcpoRQD8TAvGyqwk5H7XkrcQmlJ8jG9Cd
	WJwowqIcB71h+iydJKRC
X-Received: by 2002:a53:4c09:0:b0:650:323f:38ab with SMTP id
 956f58d0204a3-65198b46eb5mr17648238d50.34.1776331612986; Thu, 16 Apr 2026
 02:26:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415175038.3633384-1-lgs201920130244@gmail.com> <CAOesGMghHi5bEcec9L6d1YUec0Cn5uEs8MrjdoT-zHSr-FJ8pQ@mail.gmail.com>
In-Reply-To: <CAOesGMghHi5bEcec9L6d1YUec0Cn5uEs8MrjdoT-zHSr-FJ8pQ@mail.gmail.com>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 17:26:38 +0800
X-Gm-Features: AQROBzCqgemqCFHMimaIzwZJyIjw_4UL4YAye85O0rVKaDneU7CcT1Ee7huckxM
Message-ID: <CANUHTR-XcTO4jy_TNe7tHcPPpVh_o_+-hgJtLBxN5MWupcvQ3A@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: fix reference leak on failed device registration
To: Olof Johansson <olof@lixom.net>
Cc: Benson Leung <bleung@chromium.org>, Tzung-Bi Shih <tzungbi@kernel.org>, 
	chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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
	TAGGED_FROM(0.00)[bounces-238284-lists,stable=lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,lixom.net:email]
X-Rspamd-Queue-Id: 6067F40C665
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Olof,

Thanks for the review.

On Thu, 16 Apr 2026 at 05:47, Olof Johansson <olof@lixom.net> wrote:
>
>
> This looks like slop to me. It doesn't even compile (there's no local
> 'ret' variable in the function already).

You're right, I missed declaring the local ret variable in this
version, so it does not compile. Sorry for that mistake.

> This is also a no-value fix, the chromeos_ramoops structure is static
> data and not dynamically allocated. Please don't burden maintainers
> with these kinds of "fixes".
>
>
> -Olof

My reasoning was based on the implementation of
platform_device_register(): it calls device_initialize(), but if
platform_device_add() fails, platform_device_register() returns the
error directly without dropping the device reference initialized there.
Based on that, I thought the caller might need to release that
reference.

That said, I understand your point that for this statically defined
chromeos_ramoops device this is not a useful fix.

Thanks,
Guangshuo

