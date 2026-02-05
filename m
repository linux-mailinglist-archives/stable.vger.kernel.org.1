Return-Path: <stable+bounces-214419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iElaLqpThGkx2gMAu9opvQ
	(envelope-from <stable+bounces-214419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:24:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D36CEFDA8
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:24:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A77F2300AC97
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 08:24:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8CA6362150;
	Thu,  5 Feb 2026 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfS3vu51"
X-Original-To: stable@vger.kernel.org
Received: from mail-qv1-f66.google.com (mail-qv1-f66.google.com [209.85.219.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831E6361DC5
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 08:24:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.219.66
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279845; cv=pass; b=PwdcTICaCtEo71zbxiBV/tRZs6I6z9pzi+JGSqEF+gucVcPjFhvTnYYM2k1yFSr/4CGB8719QxL0jPiB7NVrTw0Mv3DQQ9b+9A1mtJG2U51eko/acDcDPLMzeoTk+LSUrsWL0q7/sQFWeUrMY1QJeh0gMpLFaO4i6GLqzDyrxyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279845; c=relaxed/simple;
	bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bXaK0g0P/jDHNsRW8gI0ViHbD6LPtbiCkajasUaEySwHs+r/U+PtaNaYclFCefK1SkRYZxdT87GRtQCVKrDAYGlCtonkru9Gbl6oZkG08I0rkfNWicNdIthT9Bh49qFo9ze2y6OV9i+LsPsoTgakndPUk/lMrRkyoz5+avdXB0E=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfS3vu51; arc=pass smtp.client-ip=209.85.219.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f66.google.com with SMTP id 6a1803df08f44-88ffcb14e11so10095686d6.0
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 00:24:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770279844; cv=none;
        d=google.com; s=arc-20240605;
        b=Auk+8DqRmyk6fGRjxUtS3/uctBpSQ04iBuvPaMz5Lf66GVHkUhenRhSz6+ypIm5pR3
         WkKBo3q45ESDpdCiY5bJmnfiBDgdYdYf00c+r9oC0viXBabiB8GRHNAg8xM8H26ejC8E
         Hwldl/jc81bfxwhE/FZoWmjB/9ccZq680ksL5aLgdZe7+W4fj4bDw3rd7V2FEGj4vdCu
         GWbRwG92gKCeisppor77YBRJBNkxqbCx9RpXx1oSPMZnj0sw7l5aMGDaazsUGhPYXfBj
         JO07SG81PhN//ID4ZhosuEMiK5VjVdpovaHUT5QSOVMomrCqTl4kwDUBK78I1Wiwyvfm
         HLNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
        fh=ToTlaG4Gg0U8Hdqli4vbcnaQVAn93LtN7dDiOlgNrmE=;
        b=gYJ5D9LaqTZYqXu0Cp/Cg875nqJfcjnlOl7L2KJRUcV3gDoH3Opop5Vxmy3Wd8QqcG
         UvO+VaXqj59DHGIpkND7FeT16lUKExTSeI5riRMUm7hhIWmpMvw5qqwUWIMrN6JHry/B
         QgbNXXvPkoi9SSyYoSnw17m1WY5LzN7A0XQ/RUZwtfmTlH+iL1Ogdcnx+1FlMJI5Z29L
         DclPhsnfMhT46W65ugy6aOtRiaORX4ZTyr96oNvxabJT/MTLSuTlDhilKQS7AsnX442N
         Iw1jdg60Eh0EA+Ea/CZYEjEd0M8RDT4/zSqS4L81Aumctx5VoQ8WxTE0UmaEgAs5LA2o
         wIzg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770279844; x=1770884644; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
        b=kfS3vu51fW2wed09gbRGs5gmsjV0kZ/+69FnEXKeFlgRwraur+QkPD/f89jEyt8T+I
         YeN0sCBXopttTJWC0VUp6B81ItdQd96eSjDLsCkWnsccVYf4qmsodCzIAfB7/0hAZreT
         hsfwhpmdYr3kE5Gmc8A4GbJlkNGkVtxJ0yXgvOwqZKsaNSzEIu1e/R+BrL12ukW4iCM0
         ysa+Utqh4NYgBFOUAFE1bfGPhl5OY2EfCt2LmvuvtiZP+EY+s3hDMEdH+NfqeMRJOoq2
         vt8SpbDIImmE+XVRpF7QyS09cCeE/JYGng+5pFdZS5nN7AfhSFhld/tEx5F+Z8IBSWg/
         NNHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279844; x=1770884644;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GX3DfIw4/nlUoK0mVdD5eAocRguJPk8NCBMsKIhLbTU=;
        b=BlpSJFfOcBeP+ZiuTsfmg0XboAfjVd2Jn8Fa+EekaPQFgd8myqCOmRjdOsrrqSDydl
         okNHqWBeFHNT5ClqLA7aGZeamxUQTAcI3q7ancW1cHfUEOtYiadaZ/4nIm38X4PbLiKX
         LZbwSdjVlyEwL8k0NLuunZXvONH7wW33edHb++AV6fu8MJVSQA2G1h9vzDs9S/mmQXzT
         8RtxsEWTP+o9HvXzH2r+gvttCJ9T3bX7mPrzSjbL5mRdx2vHKpsA2MthxtmDoPDUs36w
         szt0LwCLe28SNVH9jNqj4UA2wxwoXpW0leCQKmWL1zm5h3E97ry6Y5xRAOwXfoEfoV9P
         wJkw==
X-Forwarded-Encrypted: i=1; AJvYcCWhx32fVw1JJnq9uZC2C2xrrWdNl22aDj9Ej0+v3jYEQAEP/j4LGSBFXwcdzSOhwSV6c/lr+dc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3f3P1UeQ7PvX8LuMPPzXoDD6bRBaWJuOG8z/CZEgiQjVG3/Fu
	xsMcAf4UPGkgVXwwHP2v5GkhlLWPS9rtziu4cnzoDoHa0C2JEiRtqHeZaZgHfWTQCCYTVq6thQS
	Qoxw1fq8aV/a9KHXGnQlA6HWSy0kEHRM=
X-Gm-Gg: AZuq6aISI/s179sRssNJmvWA/odKMqT8aLkbn8qFlkggrgyBgzPhiuyU4Sq0Eanroi1
	pcq/7Q+slSwsTnymTQSMGfPw3GLwbN0sRIpsPiQDQgn7vxZCXqXhnn8NYKeDK0KdwlDeZXgpCw2
	vShjEV3dMBoj2co/qJQes9FkdxwCvxIbrVyUnUjOaJsTNHQO3T/rII5Qcd7arHY878m14ib6FrH
	S7koyYF53hwIR26sqzKS9eicRBcJFPu9w0A4VThsMgMLJwkXIRAdrYlEN8CRCxepQkhJZr+4ysK
	R5WCupJjJ5hEs3QSf52mJel5jVU2yqtYMv73rEUoYFv5m3XZofR2tH4QqPAihnLtHCc=
X-Received: by 2002:ad4:5743:0:b0:888:883d:ee7c with SMTP id
 6a1803df08f44-895221c64cemr74556836d6.58.1770279844313; Thu, 05 Feb 2026
 00:24:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205075445.43347-1-enelsonmoore@gmail.com> <b7a1e57d6bfde3ea5c9204323341a74325a63ab8.camel@sipsolutions.net>
In-Reply-To: <b7a1e57d6bfde3ea5c9204323341a74325a63ab8.camel@sipsolutions.net>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 5 Feb 2026 00:23:53 -0800
X-Gm-Features: AZwV_QjDshPtNQhbiRoSQ7v_pb5laGun2CBxH2EoHYYJ--lOze85oiN7TE9ObVQ
Message-ID: <CADkSEUiQAZidhX-CJAiTCm3c8PQNM-uenc7ExGg7d2KUVTXyBg@mail.gmail.com>
Subject: Re: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	stable@vger.kernel.org, Tony Nguyen <anthony.l.nguyen@intel.com>, 
	Przemek Kitszel <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Yakovlev <stas.yakovlev@gmail.com>, Alice Michael <alice.michael@intel.com>, 
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214419-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[vger.kernel.org,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sipsolutions.net:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 5D36CEFDA8
X-Rspamd-Action: no action

Hi, Johannes,

On Thu, Feb 5, 2026 at 12:13=E2=80=AFAM Johannes Berg <johannes@sipsolution=
s.net> wrote:
> Right, good solution. How did you figure out that ipw2200 uses OTHER?
> I'd thought about this but was afraid it'd also just use ETHERNET.
I used linux-hardware.org, which is a database of user-contributed
hardware probes. It didn't have any entries for this particular device
ID (which implies the devices affected are rare in the wild and might
explain why no one noticed this before), but I looked at other ipw2200
and i40e IDs - it shows the class code if you click on the individual
probe ID.

> (FWIW, I've found the database internally, but not who maintains it nor
> any historic information in it ... still digging I guess, if only to
> avoid this happening again in the future)
Thanks for looking into this. Have a nice day.

Ethan

