Return-Path: <stable+bounces-214417-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qPf8OmJShGkx2gMAu9opvQ
	(envelope-from <stable+bounces-214417-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:18:42 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 97182EFCE0
	for <lists+stable@lfdr.de>; Thu, 05 Feb 2026 09:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 79C51300D456
	for <lists+stable@lfdr.de>; Thu,  5 Feb 2026 08:18:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D95B8360758;
	Thu,  5 Feb 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WJPTJ9oj"
X-Original-To: stable@vger.kernel.org
Received: from mail-qt1-f194.google.com (mail-qt1-f194.google.com [209.85.160.194])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7750B355049
	for <stable@vger.kernel.org>; Thu,  5 Feb 2026 08:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.160.194
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770279503; cv=pass; b=Xfhe8YQ750j0a16EvgjgYIWxSpj9bAGHbX6fH5OFjvtnrOJjnV+ItVvULDDrB/FUco/0yPD0uoMYg/02IlZG9ELL8xr6x8JoOaDMa89LfTv7GQpc+WtmLYBlRBgbKpWatbkJKx+hvjfe3EaZyMl6RYSXJgId9LPjcGnFID2Fcy0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770279503; c=relaxed/simple;
	bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=l1ktDM2bwKCT+FdG59Jqjz+IgNoM0xhwzEIj+9R2XJtW9KeYHrbQp2JVHhbcCVyxMrIyMzEfcCH2VdEWsAwS30BNorzfX/z6J7wjatVJdWEBqXQvVD7LWSBmsJeNDow/XTj3qSoenw639/ScfejYNXF3O80koeQEs9f8Ihnj7Sg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WJPTJ9oj; arc=pass smtp.client-ip=209.85.160.194
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qt1-f194.google.com with SMTP id d75a77b69052e-50146483bf9so8280561cf.3
        for <stable@vger.kernel.org>; Thu, 05 Feb 2026 00:18:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1770279502; cv=none;
        d=google.com; s=arc-20240605;
        b=SXOfnBoXvFMo4VKujAuHi/eVgf+sk3IQllhRfbCjGPco+AaFlc98SV0KZkInHUMO0T
         4P7vFaiNjbEmGIgt3pQ1/61FjCgqPXN01V/QdMyw0GvuUBJhyEtl1kVPLcFDye/0pc0W
         gELgDIBRDOoNoxoryfLtusM4X9kJ6k1Fbgk3eO6Na6nq5nmX5WqEIgr8BDBVoRR1ByTI
         ycVoXDqwSZoRrApsJGZTdo+ydyJtgmXg7PifpZe+75LdqarADIv/Kss2G25VluJ4Qox1
         SkZqzHaUh6VHtXL9KoZNZPqxPvTIRTI1sRWXSwkPCciRBe7Et/w+g2A4qGPaIJpvGG3F
         9KTA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
        fh=SMmY17q6fkMPoni/yoNxW7aW3hdzD0ZZWFVSuaVBgxM=;
        b=eBhA9SCke8WHwN87bEAS9ltTl/+BJ+jAHSvjxIblZ/E9h/nPOYS6DReIyO5kgiq1yG
         i7/Ydn9/HW893YzJaYqBEDbPWhUmmTsPmeTfNbuiJp338w64SjgLVzPmDcsYSCEWo3WM
         Ney0GOZrYbMya4pZnRxTmbQHL114QHu210E4Lg1rphbRLee4Qc1GOgYUHd0wSqgOuoaz
         YZ4eT2rq11TWK9hOfFKLkh56LswPd7zQ7N6wlxq5978HQMF2l0voOlLiH/tYe8OyE3EM
         spl5LYBejovUCwzTGF4pAMCOZLKuVEDcA9P5E2JcOEBZdRx7kP0u08uClV2T9KrO7ghp
         4KNA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770279502; x=1770884302; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
        b=WJPTJ9ojBzj6DNngLToHBl2X0/oGQkvDV4kjObfvklfHyT6N6h42fRgzVndYvLmvvE
         1rEDuviD0PcCOtMDJRCz/1YrrLSHJYDy0Vg0Q+5bqs002Y2yabAg5l+XRHhBtH6Uv1gk
         yjLtOZRkfMLvk6FV7qMH9Rl1q0kjQPcDZEIFVOTdqduBtrCrxBAjFm6t5FrfEzirSkPC
         Kp96uWeR+YJbgO05CABaas7bqUluLGO9Wc9LQxVs82P+UH+SoUDq4iEK78B+6NdgOnSh
         11J4ueohKbX4T53An8eflVAqPzWb52/3AkBa/1tZeF+Yfcb8Y5Z6P5ONJYwL1lGHWtef
         BKxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770279502; x=1770884302;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=dEHmEZtfljzeKDJhyqfkp2NPnFNEfyMYV12kR3/lE68=;
        b=GYhNQkeerzvu7RZpDZbIsKexyycUK64a/KSajvRR9h3zX75tXKMfHIZn1B/9kczS4Z
         jFmH3/uVTb1l7I5YwzhGRPtwltJVvUljInasBJE3VRjD/dE/Fna62z6wBovlo2E2tDDS
         mb9I3Ap0p2SJuW1L4I968oW9ch08qJ8gf1TaceoLMkoSNbxl+MQoyagRLuXAtSl8wRo2
         QccfnpfSmxD94j88m3riYAVSGoYgh8nHZetK+rs3eDvCGhl+Uc4G64XGAcCZt5lSQtmk
         gnpwq06ccrbub+8RzhEhee6PJSPbpJEZXqmdnGxiCqKS7YgfDwKYKcORTMdup0yMd8i3
         fY5g==
X-Forwarded-Encrypted: i=1; AJvYcCXZoA5ytUIEb9QAKW30kovb3/wH0n/kZXhdaWs0MnLtuCoYwvCQc9O46VS4yFDEg+1lImp82Zg=@vger.kernel.org
X-Gm-Message-State: AOJu0YwTB4T8fuhDwq3WbyKtUPtmqdBbWwlw4jgySssJJI8hVtW4Umbr
	4DhCtDhIHsrBL+RfILyPSMRXB+MFiHlvYYx42dV3P9UA88ZlOaY2g/5eMwtUFV/8JTlnbdjp7d7
	t33FjcUUGhNGon3JPlfonkeh9XXaJKI4=
X-Gm-Gg: AZuq6aJYDhmBz/u12egB8Qwxr1etxD4xo6eINJpLLpkn2BKlgJZ7UJ0RTgT90RcTrNA
	eHaHXuKbtRWgNAqU57MqlnndjK0Ta46Ecrtt8VuL3pCc/N9TbS3yhZwPHNLld3tLAfCIuCkB9/t
	+7sfi0B0mzshqOeFU+r5mVS8urbqEGc8GND1NzDSVcesl3m2YzuYA7fbCxK0np520F5oKXCKIEI
	ufAD0R/fBUTsGQpZmgwd4TH5o5QenMvsnv2A8AdVYntMvjD2zzVATU64ZMmvV5fI4Ere+ASWgCj
	Myg26EwlgMhycScREbUhRaaaIfJ6N0uv2h5q8Coxt63Jw7+VWSZtah0TWYFegqIi/ow=
X-Received: by 2002:ac8:5942:0:b0:4ee:275c:28d7 with SMTP id
 d75a77b69052e-5061c1e24dcmr70234931cf.75.1770279502432; Thu, 05 Feb 2026
 00:18:22 -0800 (PST)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260205075445.43347-1-enelsonmoore@gmail.com> <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
In-Reply-To: <IA3PR11MB89868B6110780F90795E4ED7E599A@IA3PR11MB8986.namprd11.prod.outlook.com>
From: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Date: Thu, 5 Feb 2026 00:18:11 -0800
X-Gm-Features: AZwV_Qi279RFUb8dryBzOPG7K4OPVJ4GK9tbcGC43GVruOveblEFmaOLVgoO04w
Message-ID: <CADkSEUiNrMCGzECO2t+Stx7Xnk=bCAp+mk=99FrMZFq4wOmgFQ@mail.gmail.com>
Subject: Re: [PATCH net-next] net: intel: fix PCI device ID conflict between
 i40e and ipw2200
To: "Loktionov, Aleksandr" <aleksandr.loktionov@intel.com>
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>, 
	"linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>, "Nguyen, Anthony L" <anthony.l.nguyen@intel.com>, 
	"Kitszel, Przemyslaw" <przemyslaw.kitszel@intel.com>, Andrew Lunn <andrew+netdev@lunn.ch>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stanislav Yakovlev <stas.yakovlev@gmail.com>, Alice Michael <alice.michael@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-214417-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[enelsonmoore@gmail.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable,netdev];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,intel.com:email]
X-Rspamd-Queue-Id: 97182EFCE0
X-Rspamd-Action: no action

Hi, Alexandr,

On Thu, Feb 5, 2026 at 12:13=E2=80=AFAM Loktionov, Aleksandr
<aleksandr.loktionov@intel.com> wrote:
> Commit message could be more detailed.
> - Why the PCI ID is being reused (if known) Is this actually a reuse afte=
r EOL, or is there a misunderstanding? The commit message hand-waves this c=
ritical detail.
> - Whether this is documented in hardware datasheets
> - If there are bug reports of the conflict in the wild
I don't know any of this information. I found this conflict via a
script I was motivated to write by noticing an ID conflict between
r8169 and 8139too.

> If it's quite critical fix why not to send it to [PATCH net] ?
I used that prefix because the patch is against net-next. It will make
it into stable versions regardless.

Ethan

