Return-Path: <stable+bounces-224892-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yCz/KbzrsmnAQwAAu9opvQ
	(envelope-from <stable+bounces-224892-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:37:16 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 22EBD275B41
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 7121330A8967
	for <lists+stable@lfdr.de>; Thu, 12 Mar 2026 16:32:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 09F7938F63B;
	Thu, 12 Mar 2026 16:32:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XSCtjeRa"
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67EB637DE9E
	for <stable@vger.kernel.org>; Thu, 12 Mar 2026 16:32:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.208.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773333133; cv=pass; b=kU5c7Ukq7YwpECgH4DSsQMmxLzX8vSXHFflD8g2f1sR/yfpm/2BtNFCFTKDWX3wugai5CrnOQZhOVt9K+JEtyXjIzpXYh4ncvxTjwvBl5ktO66p8D3VzwkG6iLELZggo1qDt2MYT13IY8M34+RysOUnuGXzkUuU/Mb4yTAkWgBw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773333133; c=relaxed/simple;
	bh=tWC9RmVzhKDMgghyggXAuBjEg1XwifskBDBq5aeqeM8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EHd1O47BmiPblTYvpekUqA18auD9nBAXVk54QtNqqY6OWfyar0Xe09c22zlnnCdk5hj/sbQiS3pT0sAmVhqnWehnVJeaYn2deDhplLFIHrhEvfVCgoLgAa5DFd17A9Zis1LrFW5qiqBeW0vynNfqgTCKskF3jLq7y9X2HssfrDo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XSCtjeRa; arc=pass smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-660a293515fso2144365a12.1
        for <stable@vger.kernel.org>; Thu, 12 Mar 2026 09:32:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773333131; cv=none;
        d=google.com; s=arc-20240605;
        b=d/rYjAqmHuS5d5gsTi4acx69Z59+ZqTeM+DAU2P2dcuF0pK797dp9LJmFPBhv0nGd3
         cMb9gwdPlXcjD8YddCaSHxpIpD7yom8qkDsJLbZGFko0dnoJlMVreo7VoX3SMlFybFIF
         HmbhFK1HcEgIBaT1iPHo1E1+jqEI/+ybB+nLD9SRACpj9lt2ChTBcDOzIB6+RUZeXynl
         HdlhaxbJqsBy9HnnQVErUuJt3xZmtXXppyR/59s8+ViQcUaXPxJWccts58O1/UmsU87U
         o0ynL2rUkrWwFnnZwiEmK5aVWaPUvJhDgNL0GFTRzyRN2wgqfbDLmjDg1gXC1Fo43DPQ
         cdrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:dkim-signature;
        bh=tWC9RmVzhKDMgghyggXAuBjEg1XwifskBDBq5aeqeM8=;
        fh=YTFFAo+osRKG2yVg74xhfEWBPql6ln7Xzxm5Ch5N4cw=;
        b=iuLZAtBFhvnU0/2OB7p1+1PK4r53cy18nbn0BVAKH3O1bwHO8KSPJQHYSjtEwv7BHX
         +i+a8ZNOAYNb0Xvj5jubj36jcN9B4dmm5Fg6MCQiBWkirCDM6C9HlK9YbQGdryRWoovu
         9QnIeCfnnNUIP0KyumRd0zHzs1BrTtzkfnTL0Fa5kF6zQlbI+gWDbtViT+2jXZcqgClJ
         DuNOsSRKf292y/SJ9dEJlAhjftc/dA9WdCkEE5IRxg0IexP9TrykGziiZQMPeusKfUEY
         Bf2S5qADmRHHZFnMVKONn9hur4+/jXvdjcEhWN+m65++3N9+fgjXp1kI61+U6FNPKJc6
         SpkA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1773333131; x=1773937931; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=tWC9RmVzhKDMgghyggXAuBjEg1XwifskBDBq5aeqeM8=;
        b=XSCtjeRaTHxJUpoLaLX4g6oJ5t32QdV4GEctLW1CTKkOxgeVmT96TLWAzuYfjo/BHK
         4CWR2hjke2Kp/m5NO0pCYVf5IaebHaVPQeYGysKh390aJqpuw28pAvl4EQNlp1vwKiTl
         OtxnH3g7ZT2viVvn7b+yrsnjce15GNEU0Tmk5JoqeVou8dwH6KfOSLF4PXdn891MoPJg
         B1l6YzG1cejxvAexIEaMbEsZL59Os+wlV9OW9ld6gCc4XDCh+gpE7R38V2+ls3W6tvxE
         r8djApqfUxPWq3E6pc2ja4e0vBmDY90ge3kbW9edliraT2Wdqmq0/Qnep7RTaaAV7HMm
         QFug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773333131; x=1773937931;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :reply-to:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tWC9RmVzhKDMgghyggXAuBjEg1XwifskBDBq5aeqeM8=;
        b=kezqokA7vtDY3q6Vh4jSfuUapQ70hEkhq4N6ocA4cpRo678DiIHv6sC6dD58YtcqMh
         waJOM/ltqjF9GnZnFNGpyc3RTV1NFUxCHXfzT0ojeKkQ/rZxk4crYlVWUsbJ76eNBHYc
         kK7vWp7SqnnzyUxqgHAVP7YKl3bzT5mDervmsUA9rUxwFi/u0gtoE7EwI8Zy0a02kyGM
         I3moD3g0n+OsR+gxmY7W7C4ZWiAyUSY1mwq/yEI4ItLTaN3vAKiuTDDHdyZ65un7GRE1
         /r07TYZOLrewEJtih7a091lD4lW/JpWyqWaarSHCj6N8BScrt/DQOQPa1/nReySPCIBS
         2y6w==
X-Forwarded-Encrypted: i=1; AJvYcCU2hFUFm3PkL9YJbSiK1VfyGHTktzVzSt8umCDIEaHzz4M0gXPu1ykh1cs0kgfx8JzF6WI1JDU=@vger.kernel.org
X-Gm-Message-State: AOJu0YznYPI5rqHTtPOWXtimHCaU+XXuQG4GOLO/DJ2h2ZWEKyMtDhnM
	qH83GxHy986y6KOTE2Rf2WjqRp+ZUk8C5vxIhxoqm8jLEHEFFhVQTe0VvPX8OX24sDX2yCfQGbk
	c/CAXXEeYMp5Q7ovYDuHFTfR3Wdl0en8=
X-Gm-Gg: ATEYQzz4vF2BuN5jfvym3ZQ5KVisZs5x5TFsvg240Z0Hvz0tobE9/J1xiPPYYvKAAPu
	66fz4dmu9RfUfqfMNZ3XefgE0hH6RYC8htxn0l9FvpZL2CxP6bhmZxl5eOZMhzsPSZpaAILKovP
	OfqFMYeOTioybRVOBHQkRLZTnJ8dbywv79Jeup2fYn1itwCoq5U/qSHSq4eF6xhZcchbTrjgfQJ
	kTR3BWsu4/P96yF87AFkEfcbPPTFC030FYN7zpDnXWt5vkUVsBzH/kNdEz1rqztKoQuDVDgqIwJ
	nShUi8DWpEJn8qeRed/U2ANv1PJjw0qsGCRqJs8=
X-Received: by 2002:a05:6402:f0b:b0:662:fb6b:b39e with SMTP id
 4fb4d7f45d1cf-663bac0e0d3mr10514a12.21.1773333130486; Thu, 12 Mar 2026
 09:32:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAKSQd8WpwYV0rxd7soKDqcv09Oxx1sUZPTHf+b_5hqgbxHcLLA@mail.gmail.com>
 <8176878c-970a-48e3-b237-2c57ed39f7a5@zhaoxin.com>
In-Reply-To: <8176878c-970a-48e3-b237-2c57ed39f7a5@zhaoxin.com>
Reply-To: ludloff@gmail.com
From: Christian Ludloff <ludloff@gmail.com>
Date: Thu, 12 Mar 2026 09:31:58 -0700
X-Gm-Features: AaiRm52lI5pCutV-8bbbaGoxp-8QXL4di8Gwhf1t2PoALN6-MQaybiVrGGLAqYw
Message-ID: <CAKSQd8VnDopiq43cVY=NGpF1vF-5v2j=T=TASNYyc=A4jmr3jQ@mail.gmail.com>
Subject: Re: [PATCH] x86/cpu/centaur: Disable X86_FEATURE_FSGSBASE on Zhaoxin C4600
To: Tony W Wang-oc <TonyWWang-oc@zhaoxin.com>
Cc: me@ziyao.cc, andrew.cooper3@citrix.com, bp@alien8.de, 
	dave.hansen@linux.intel.com, hpa@zytor.com, linux-kernel@vger.kernel.org, 
	mingo@redhat.com, stable@vger.kernel.org, tglx@kernel.org, x86@kernel.org, 
	lukelin@viacpu.com, "TimGuo@zhaoxin.com" <TimGuo@zhaoxin.com>, cooperyan@zhaoxin.com, 
	benjaminpan@viatech.com, QiyuanWang@zhaoxin.com, HerryYang@zhaoxin.com, 
	"CobeChen@zhaoxin.com" <CobeChen@zhaoxin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-224892-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ludloff@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	FREEMAIL_REPLYTO(0.00)[gmail.com];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	HAS_REPLYTO(0.00)[ludloff@gmail.com]
X-Rspamd-Queue-Id: 22EBD275B41
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

much appreciated =E2=80=93 many thanks!

--
C.

On Wed, Mar 11, 2026 at 7:19=E2=80=AFPM Tony W Wang-oc <TonyWWang-oc@zhaoxi=
n.com> wrote:
>
>
>
> On 2026/3/6 04:26, Christian Ludloff wrote:
> >
> >
> > Tony,
> >
> > can you confirm whether F=3D6 M=3D1F is affected or not?
> > (Supposedly that's ZX-D... but the F in the model does
> > make me wonder/ask.)
> >
> This bug existed only in certain early ucode revisions of the ZX-C/ZX-C+
> series CPUs, and is not present in the ZX-D.
>
> > Presumably the 6FE and 10690 microcodes which are
> > out in the wild do not fix the bug, correct?
> >
> > 000006fe_00000000_20110809_8f396f73
> > 000006fe_00000000_20110809_8f397072
> > 000006fe_00000001_20160525_7214d1e1
> > 000006fe_00000001_20170109_25646399
> > 000006fe_00000001_20180726_6e07329b
> > 000006fe_00000001_20180726_6e1e984b
> >
> > 00010690_00000000_20110809_259878a5
> > 00010690_00000001_20160525_3c34fc1a
> > 00010690_00000001_20170109_a8b24dc2
> > 00010690_00000001_20180726_0c55f25d
> > 00010690_00000001_20180726_41faefde
> >
> No, The four patches with the display date of 20180726 should not have
> this bug.
>
> > As for making the code conditional for Centaur/Zhaoxin,
> > stepping E seems to be when FSGSBASE arrived =E2=80=93 and
> > while there are CPUID dumps for 6FE that say VIA Eden
> > it is possible that they too have the bug.
> >
> Sorry, VIA Eden is too old, we haven't been able to find actual hardware
> to confirm this.
>
> > As for making the code conditional for Zhaoxin models in
> > the string, that would require more than just C4600 =E2=80=93 the
> > collection of known dumps includes others.
> >
> Yes, ZX-C/ZX-C+ series CPUs have other strings.
>
> Sincerely!
> TonyWWang-oc
> > --
> > C.

