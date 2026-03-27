Return-Path: <stable+bounces-230582-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0G+nBGIHxml2FQUAu9opvQ
	(envelope-from <stable+bounces-230582-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:28:18 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 657F233F1B5
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 05:28:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DE7F0301DB9B
	for <lists+stable@lfdr.de>; Fri, 27 Mar 2026 04:28:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D7333783B0;
	Fri, 27 Mar 2026 04:28:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TXwt7Ynw"
X-Original-To: stable@vger.kernel.org
Received: from mail-yx1-f49.google.com (mail-yx1-f49.google.com [74.125.224.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44F0346FC6
	for <stable@vger.kernel.org>; Fri, 27 Mar 2026 04:28:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.224.49
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774585694; cv=pass; b=TytCYFOtErs8Tytlc8jdU4VNCZCqYrTOyRJ+VlCsCht0NxZspdkzSVUJYfKrkW8AOr3c+BRy4DOZMV0CesYRlFXIHNFmvI1PYyJNvb6ZLsqL3IWskHlEIFbvGySUY/wiq8VA4MOx2LufsxkRYDgxY+j+jTqmg5aj0oo2eEm43Zw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774585694; c=relaxed/simple;
	bh=jakFhMCD69DsLpY3kFU6AB1vGvQB29CsKVpIrpzX+4c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQ7Y4YbBATcGLfNtZefxgdOKgvDaneg8pjqyE0Odo56n6bmoO83ZNT2xw3Rnw1PwDr9KJCJCjRF7MOo7sHWjJG8Mi33S/Qq1lIgkEYAYGdcyWde7CKQgMa3dNk35xmEV87N6n7aYpyZ5754ckC5dn+uYJdqgswEe6F/FqECOB10=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TXwt7Ynw; arc=pass smtp.client-ip=74.125.224.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yx1-f49.google.com with SMTP id 956f58d0204a3-64ad8435f46so1732723d50.1
        for <stable@vger.kernel.org>; Thu, 26 Mar 2026 21:28:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774585692; cv=none;
        d=google.com; s=arc-20240605;
        b=Dq9jthFiBLd0noHcbH8yFQycasdZtAMevfuK+ZSgNjuXXZ/NuxRNzzX7sWOsqcOrGk
         bLhAAVmwcCAFNAvZz1RmF8OSdP2tabQUWuK0zDRS0y3nl3h6OnKoXM86vffKIf13opeF
         2ZbFJ87QVnHxbwqU3U42/SlHXpWlCDM036EHSPHNjYJXrgt6FbhNT/iQTtcI40HkrASH
         1U99By3czh2XDswwb4WGrdGdJ/cfft2U86UcdkxNyyqvxB1zoIN66QoJZZCQtJkHNnWL
         m/MT6Ol/70eRVUsJ4/pn/JH+dRLXwgmf0HUp+r04SZ9RZ9q9Z84UTjd+zMSGx+E1DLIT
         m91Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jakFhMCD69DsLpY3kFU6AB1vGvQB29CsKVpIrpzX+4c=;
        fh=jcMJBodtssHg0UdjPomBFe1el1Sn200iBnceHiG0pic=;
        b=liuFXD+TXW28TbvsnAANMRvDpH4ToWua+zAXLW7gxQlzo+/9VQp0CpQVKXIgWmSbMB
         7Qvkfd0CECvil9lE2AAFE/ACPRz57o0xl/a77kd5PGnoeSp5PsF2dGgioJhgslHiSMiy
         zrHMqe8EGAeGaYKTYUj/YY16DWFNJZbVOL1YMxH52pAC1VgJb9N6YqeIoMgsMIwigSYR
         rVt37Lui9XrWoteek3GmI2TcHfteoHbpZtvChbZtGrEKEL7SYk+dnDl4/RhtOsLj5YMo
         v9DIRLNzoFqDH+WoNzxkk8Fw8u4Yeu9HT9+BzvOGcKlv6xKivKwpla/EPU4Ujh70d4FE
         zDVg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774585692; x=1775190492; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jakFhMCD69DsLpY3kFU6AB1vGvQB29CsKVpIrpzX+4c=;
        b=TXwt7Ynwm7sOZkzYuVN30XrppseyqLEDXjOate4oPx76CrSd8SqDs046v8aykAb17R
         bXLoiQYxHA5Wb1yh4g8bdJoe9H3aX9FgprhgsSXJIvmKY94QQd10zJ/boDNWgVi62RaM
         fj4FZ9Es/e/2TtgpCp77VBXSIv4ZYwdoBvXzovvroe3W4HjTMDHteG6J0hWzOZ9NIZKL
         T3AWThWM50gzecWvvhAoHDYntXESBq5ingt1GQ3VveEctZ4acYOLr4iaOYxhq/g2dCuA
         QcNeoDp1hqaiJ22DH3ZmEtfc5D/0aXovN9GObwjwsIvCh6kW6aGFaLaTYsHPsXA4o4Fu
         usjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774585692; x=1775190492;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jakFhMCD69DsLpY3kFU6AB1vGvQB29CsKVpIrpzX+4c=;
        b=D1gGXJNknNs+NrZ0WJoFGdSq5IxZfXoYbNGj7NWrFIJt3JUk/7B1qgKbfFebaFL9N3
         7vEEvS2WrRGGN0pOe0p/Hc2LqnbwtN4/0EnzeQsePw1vNX7Zx4NFYREhhDei7dqj3VmP
         GMPr7lp/0fAhFSBSteTglyRNgLqksaN+ho/2CDbrWPvBG5m7QLbeHlNVpNm12DKNp/D6
         zevMcVHPPgrVtpC7ki6JBGO/2hqcx+a1adeMvhZ2G7cNxg98s0MNI0/ZuDPE8QdjWl0g
         NODxCrWk/t0T4RjneOqfBubP41lbdV4Pu54ynDZl+ykQbJuYzMdQX6Ua3FrBGGxvlGyi
         Ax7Q==
X-Forwarded-Encrypted: i=1; AJvYcCWXPeBjmDJhOET2kpidxVUmgf24y+/40gwjucP59FJpFvYnyiKsknuaUGsaCudOuKCTtBZIn+A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUQeTexGjaV64ttVSO/cvHt7Aepek0L3PNdlEU3bCNNlnk9eVu
	WogjrWhen8YRHK8uigTvq/fajnP76FvEXHdNN8PqiIVMQYG12bslUlqe9a0UMaaUySmgsJfA3xz
	zuZPiizYsshrvCVN8crtQnfCFuDOcIL2W9o4MLhNPvA==
X-Gm-Gg: ATEYQzyIQjdFiqvzFXt/21DmR5gJxFYN5TU9B8cjqLr+RNG8L+auWfjwuqU6ML9+cN4
	otHopYfzaYqZG33uevhM1cwM9R2YlnTq10tM0g+JIjZZ0kjwyH6nTL5dEfwm7D9mvsyEwk2PIZZ
	wRU/vM58QgQQEUG2SI9N3mDZNsmC5T3B9XoFzZcMXlZqPR8t1exYi9/lCPsfdmuwWMoQmpRKD5s
	NEaqOs6NKdSUh7lxCdPaS/IW8RwT9R4BE7AkLM60YQIAbUnNjmdO1WV3polLWN+Z1hp+SSgtYgN
	QWMFcS8=
X-Received: by 2002:a53:bd4f:0:b0:64e:e90c:5686 with SMTP id
 956f58d0204a3-64ff7417d08mr873587d50.58.1774585691678; Thu, 26 Mar 2026
 21:28:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260326171412.1109402-1-lgs201920130244@gmail.com> <acWGi1aMWrk05GLz@ashevche-desk.local>
In-Reply-To: <acWGi1aMWrk05GLz@ashevche-desk.local>
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Fri, 27 Mar 2026 12:28:00 +0800
X-Gm-Features: AQROBzC5CjMqHXdYO97F-H_3DE-327XbLa8gWvM6xdBJFcBp3PMZ3_cmUEPhXQ4
Message-ID: <CANUHTR_0Rv3dmuA=9dpjQar+AtzfreSNN7d0w3zFG9-yZBMh8g@mail.gmail.com>
Subject: Re: [PATCH] auxdisplay: line-display: fix NULL dereference in linedisp_release
To: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: Andy Shevchenko <andy@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	=?UTF-8?Q?Jean=2DFran=C3=A7ois_Lessard?= <jefflessard3@gmail.com>, 
	Ingo Molnar <mingo@kernel.org>, Thomas Gleixner <tglx@kernel.org>, linux-kernel@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-230582-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,linux-m68k.org,gmail.com,vger.kernel.org];
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
	FROM_NEQ_ENVFROM(0.00)[lgs201920130244@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 657F233F1B5
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Andy,

Thanks.

I found it by manual code inspection while reviewing the teardown paths aro=
und
linedisp_unregister() and linedisp_register() error handling.

Best regards,
Guangshuo

Andy Shevchenko <andriy.shevchenko@intel.com> =E4=BA=8E2026=E5=B9=B43=E6=9C=
=8827=E6=97=A5=E5=91=A8=E4=BA=94 03:18=E5=86=99=E9=81=93=EF=BC=9A
>
> On Fri, Mar 27, 2026 at 01:14:12AM +0800, Guangshuo Li wrote:
> > linedisp_release() currently retrieves the enclosing struct linedisp vi=
a
> > to_linedisp(). That lookup depends on the attachment list, but the
> > attachment may already have been removed before put_device() invokes th=
e
> > release callback. This can happen in linedisp_unregister(), and can als=
o
> > be reached from some linedisp_register() error paths.
> >
> > In that case, to_linedisp() returns NULL and linedisp_release()
> > dereferences it while freeing the display resources.
> >
> > The struct device released here is the embedded linedisp->dev used by
> > linedisp_register(), so retrieve the enclosing object directly with
> > container_of() instead.
>
> Makes sense to me. How did you find the issue?
>
> Geert, do you agree with this change?
>
> --
> With Best Regards,
> Andy Shevchenko
>
>

