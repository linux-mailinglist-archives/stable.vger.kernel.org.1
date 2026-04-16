Return-Path: <stable+bounces-238288-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wKwlCemu4GkRkwAAu9opvQ
	(envelope-from <stable+bounces-238288-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:42:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DB2540C869
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 11:42:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3B22B303206D
	for <lists+stable@lfdr.de>; Thu, 16 Apr 2026 09:38:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1EAD39B94C;
	Thu, 16 Apr 2026 09:38:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K4Wjlrtn"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F5F394789
	for <stable@vger.kernel.org>; Thu, 16 Apr 2026 09:38:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.128.180
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776332281; cv=pass; b=RMQHSpxEWMcAYc23TCxb/7Lj7+D9T4ROD/qVdLDCIE8rwtclMwJgjNgkqvYd7AMSMScYkreY6MTCvnJLA8m1LwH8E6C+jY9+8CtjA1xvkvK3MDQAev9YUghdbMOK91l9RBSoUt8xob84vuq9ULgPh4pfYh3gX3wpR0S7cvykWVo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776332281; c=relaxed/simple;
	bh=j5m8GLKyctPkvTPJbSddEnre9c0vDVEj04B2h+D/cmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bxq6BUb/jXNvAbCV4xGivLdMfhtjVO8oOSDHJUOrA4Uppm1BgdVnTZWZMGwx1wUiBzU0k3i5a/5H9sYGMsBqTywJqLRsFYKyCsyUZTetSkD3ABBouDAmz5Hso5L1LFzi90UE3VIcLrdrzZp34kc3UqI/hvCHrO3R9hEKYd+HklM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=K4Wjlrtn; arc=pass smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-79ea87af213so6518137b3.0
        for <stable@vger.kernel.org>; Thu, 16 Apr 2026 02:38:00 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776332279; cv=none;
        d=google.com; s=arc-20240605;
        b=a0r7EFJnIlPm3hOF2a81tmP9PwRXywYFc8Z+BhpyiR0jb/as9U49ooUI80I6IduE2L
         oN5ncHLwo9lUHGdjpn/P0D6C4N9PmwklamQQPIYSJUtQXNDEBDyyWeHE+7sNdD5fAWy5
         TjlGf/c08ckgmM4WfsbH6xuUT0CBjQwfCTkhwSlxGQYoAUZiLuhNaX14l41VsZOOPJvJ
         cIw6kNDOLayQ1VzZdx38kY+3az0AkNTYIlaCl4MdQIpsnoV+kftaXcfdHWMZ439ErSkW
         5auVtu4WEEQx1ku/BxXNuSNQYrpj2Tvn+oBTuwCSs2FZOxqA+QWg5XNWcltwNhwHGu3L
         z/6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:dkim-signature;
        bh=j5m8GLKyctPkvTPJbSddEnre9c0vDVEj04B2h+D/cmE=;
        fh=UpKNdcN+W82Wu8qVdEOw9cQv8fdECG/b3qgeSHbPY+k=;
        b=F/iJj3eXwrEPu+UWPuLdVxpAtTxpLmiTkA9ydcmwaVlwikWzqfrXQGexMNRcacFAq8
         Cqa0e8kNHtRByuzymzlOTE4u9WkAHwxnY+O9HSmcMV0XY1gQOveE3C1spEb7Yas3Iqzb
         ideCBtKKg3S/lZ8BVpTLpEaT2Eztz+KD103nO2AVj0NHkOR6hjROzk8NNhEuP8fESysw
         Wutasdxm/kAFT9IgJcCNcl5mI4ceKyqGjttnFgboWG/gPemyS0kJB3Xs5nHdEcwx/0+H
         OwYjuxtb1QOiNDRjC3dyDlE+d2anWxv2Bf/14s83he9sP755uXP31EKBrpEDdLACaJxj
         Ks0Q==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776332279; x=1776937079; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=j5m8GLKyctPkvTPJbSddEnre9c0vDVEj04B2h+D/cmE=;
        b=K4WjlrtnGT+kHmk3EFGbJVMDeE3Injo2mXfwN3TQwGWJzPYUpQkh8VmFo6ANxaiUXh
         IXZIVMXWgZgIe3h2AwsL6JbA+uSU6Dk5qn6OTwMg0hbmk8G9A+Ys7JcKJVPtO/Y/7Yoa
         /gfVB1pbM5it3DnwAjrPfQkixqOd0jMAsPpMjQ1ZswOpm65isWyH+pYwCS5DFnZG2Sop
         jYS+WsT2y/ZT27VTp+iWcW00ac67rnTOf+inUDDmjr8gTVG+6XCyND2pCjKTHLuGZH6j
         /eoSGnTju7ynCKsvtzfAmfX7yLmSnTSNsP0XnKjcwo1jR2zzkoQK0ECgUXlTZO8gBovg
         s76A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776332279; x=1776937079;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=j5m8GLKyctPkvTPJbSddEnre9c0vDVEj04B2h+D/cmE=;
        b=ZfLr2xththuvfdnawZ/ZCIT7h6gAJC0TswM3gTGCmUxd21LyLjn2MU4aKQFvvUSImF
         V9XrwK5+lEt02vvt0/kqPpwW/2I3ZOIzCqb8mEVP155GucTJnJhccSijytpTlV7DJD6e
         DPqdh09R5Etxskli97VLqwaqq1smTQl33NbdB9D0f36rn/2KMsSAzl7d54y6eKMXxpDk
         eZG+Gj53/oPokS+gI5kREDU1vD3qMiPTewxW4j7AYe5cJ+hzGQRXU1ml4hHzZab4W8SV
         XaVpFHMSlNC1fI0PNrOLysGB37jbOYEJY5TC6GdWZTSW9a2DgdNj/fNiWCRn0qsKt8vN
         JDvw==
X-Forwarded-Encrypted: i=1; AFNElJ9hCBSvv5m5tVi5TMo/sMKwcvqLfTIQHfJrAQCVLVpl/zE/1Y0y9CpTXS2+c6hTeSOXBR5X+00=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRZxtHLkaczqkyrBck/Pti2rk+tLXBgnB2AL/37ifyxKTazHHO
	JT1kntL+Glu5YLU34c6eGkTYtbXavHXUEBW6vY1S80+qeOX0M52ejAqS8n9l0pUNW9fGDnkXPTc
	l1LTS/8cmVdnqdTSTlhosc3jMcGx+JkY=
X-Gm-Gg: AeBDietW9sWBMSpvXE1cl1Dz6j+PaCztEjC9V9lTRvm4wYLBBMKCmrtplqEu8Xvfly6
	fx0PoaFz4doQvxAVmtLzPz/4F75BT8rX+pWMIyvLUmV9EzHuApOvuzMmX3SpHRz6cjtoIstCiSw
	O9XN4VLm2/DgltPHPIFqYwqdZibl4HlBHDVq8YfpiJRolydGHewe7jlxJodsK2UZLQk92UI8dia
	p+gpTKLQPQpBRRr431QCbV7bznDHtDsW9jaIjvQbfRQNdzxbgtjsnkj+dyNn+YwQYcvx3wDgq7w
	U+VXHeNstjMkRYH4Ezb4lY51X31ZFlU=
X-Received: by 2002:a05:690e:1188:b0:651:b61a:4b5f with SMTP id
 956f58d0204a3-652f625fbfamr2412360d50.17.1776332279554; Thu, 16 Apr 2026
 02:37:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260415183436.3763871-1-lgs201920130244@gmail.com> <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org>
In-Reply-To: <463cec4f-a038-4bd0-90df-76e0ef48381c@kernel.org>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Thu, 16 Apr 2026 17:37:45 +0800
X-Gm-Features: AQROBzA4RGhu8VBKDmPs79TXu417TZV9byeGIgxEv-ztLHgyODn2qEOjxkJSt_U
Message-ID: <CANUHTR9toK-PS8qrTd-=ATpSi8xbnXmF87sfRaMDp_jG_eiVMg@mail.gmail.com>
Subject: Re: [PATCH] serial: 8250_accent: fix reference leak on failed device registration
To: Jiri Slaby <jirislaby@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Russell King <rmk@dyn-67.arm.linux.org.uk>, 
	linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
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
	TAGGED_FROM(0.00)[bounces-238288-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 7DB2540C869
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jiri,

Thanks for the review.

On Thu, 16 Apr 2026 at 14:14, Jiri Slaby <jirislaby@kernel.org> wrote:
>
> Hi,
>
>
> What reference exactly?
I was referring to the device reference initialized by
device_initialize() inside
platform_device_register(). My reasoning was that when
platform_device_add() fails, platform_device_register() returns the
error directly and does not drop that reference on the failure path.

>
> How did you verify you did the right change?

After my tool reported this case, I manually audited the relevant
source code and
checked the related core API definitions. However, I did miss the
special handling needed for a static device in this case.

> In particular, what does put_device() do on a static device, even
> initialized, ie. with no device::release? Try it...

Sorry, I should have considered and verified that
more carefully before sending the patch.

Thanks,
Guangshuo

