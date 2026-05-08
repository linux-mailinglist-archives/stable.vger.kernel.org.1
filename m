Return-Path: <stable+bounces-244768-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eF74Ehj1/Wn5lAAAu9opvQ
	(envelope-from <stable+bounces-244768-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:37:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FEC74F7D97
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 16:37:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1B1E83097BD6
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 14:30:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C2763E9589;
	Fri,  8 May 2026 14:30:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DHP7CqVi"
X-Original-To: stable@vger.kernel.org
Received: from mail-dy1-f182.google.com (mail-dy1-f182.google.com [74.125.82.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1D92355813
	for <stable@vger.kernel.org>; Fri,  8 May 2026 14:30:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778250639; cv=none; b=IYPbDmeDZkuR8XqsO5rPBS7+gLtd4WYgomDi2nUXJgR7X5DguV9tNN1sWkx69seuFKQyRzR5qtmMwyhKuR2YCV7N5G/KfA0cKvbn9DIeJwar4qvhNWEEcUWz/BamiUnSjo3eqsp9uhQH6D5r3bWgZKtsyQ/CdznivZRSsxnGlq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778250639; c=relaxed/simple;
	bh=dA3ssTeMPL2h0yAgyQCV/GL+K8IFVy37Jn+FniNYOcE=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=TodQtVxbv7Ppuzaz8WbZaEbyyGVYTFFITGJ87jheqtOdPhGKgc6T37lWmxPaMP6U5EYhtO0XFRZulgKwY+SG6snUjQM+t//L3VAxcnkQUryWholdxAAoSl8MLkB8K9PRbIl9Ok5+FPKEV7L+LcO/7ahPGGNNZPaka/B/Es84+Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DHP7CqVi; arc=none smtp.client-ip=74.125.82.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dy1-f182.google.com with SMTP id 5a478bee46e88-2f0d3e07e30so5361899eec.0
        for <stable@vger.kernel.org>; Fri, 08 May 2026 07:30:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778250637; x=1778855437; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dA3ssTeMPL2h0yAgyQCV/GL+K8IFVy37Jn+FniNYOcE=;
        b=DHP7CqVip+ty72wN1zgLyhdOeh9HyW7nG0h60pQ3LCGBWzZ5a+p2IvqN8ytgx2HRxu
         VzT9eRRzjAmYF2EtpH0C737+CUlKxLUuxxEqY5fCx34M2/EwHKGo/fUvPJ3a/1USkDFd
         d2kJWSdgdzXsG1TSz6HOIO94+VuCYIOUGdObI53pQzde5eMvpKq11NX491YMY9EA3ezH
         PbPEsIsGhPmUY5SG3MNZWTPDG++kIh5JC18XO3k19LK4hDIpWAnd99ZKO+et47uy7Adc
         Ro1+03S4lofZxa1pELPstjKSfTkXt6I3Btd+mrDwUnhZXTehGv2IJGMnXKi5qxx3tRSz
         h8vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778250637; x=1778855437;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dA3ssTeMPL2h0yAgyQCV/GL+K8IFVy37Jn+FniNYOcE=;
        b=X69CXzxLpXHMH+dp+Tkie29xuPGCySCWsUgJI2m9JBnxVdjN6tN6jQNGTd2FQsQ0rK
         e7ca+LrTpOWGkSZf8B42+FCONBRdPlNJNN/wz5H/EX9FQ7u/+sLsXfQsZdFHTGVjWTVx
         47/U1Ctde/hLJu55waqWEKtOtq2yTxirmnVaEVxF2Xnii02Wpg46//4r2YsyDMTuG4JZ
         YpI8LbfjKT1YnK7hvoHn70e8jKQKhDbPWCX73FeN5ZkAHazXUwhy36Tq1JNcqL/U+6dw
         gd/uHU4s3lkQbFaVvgTw82KIpIqdYqhobgdqSxE52I1J6jcM/l3xoxBqGotGoIBGwipl
         NruA==
X-Forwarded-Encrypted: i=1; AFNElJ9Hq8OplTHs75ZuZD8wUznPObL/XDI3Y5Uq6K0dS2nER1oLPK44xyznNOUmBbOsxJZQmBXqn2U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzV49HOyjOuVbXDnDtEQpcgryHq3YoCaLrb/VGTbSBVtW25136Z
	GoNNss6JsDzUmU9Zwo89qwkNI8MWcoNYKD7rCNrBX71WAQzmQ9LSueDs
X-Gm-Gg: Acq92OFPipO15FYvYI6OayuoxlaLUJifne5OswLN5GVZHuwcgABkfuW6pQ8PW2cb+as
	3MjHtC13niXSp+gk1Q/2wNaHpYKgZQhV7xtOHxwqdDVA+/2CbkP4yt6NRqkIy8JofMUm3nV9AdD
	wkat5J2i259z/tCFTBQ1fafpK21/Zl/oTBI2sMBRxTNYw0AanEQajYm6M7u7Fh4PVGheFPeclId
	YGzcgYmtsluZTWsF2t01MoiSiQJ45K/Cv/cGn88twZRli91djqB66hmdmQX6WBKrw2Q6V76c2FO
	aDsF3Fm0mygswWWsuBP33f84n/wxAOpyjW/zIYt33LKGr1lVixs5OjaYnh4FR2gb+W9OPlBjWRv
	xzUUulnlNXDXKZjB5Qs3tqiOmwVXDOa20Z+mueShbEVD8Im1AIUz0w0gZXsxeSI7IPXjbqQJuda
	4S5vo1psURWxl7zq2URJD8uWSTtMqN4Cmz2iS0kIhtDxHv
X-Received: by 2002:a05:693c:2c01:b0:2c5:b23e:48a9 with SMTP id 5a478bee46e88-2f54b266964mr6364127eec.25.1778250636710;
        Fri, 08 May 2026 07:30:36 -0700 (PDT)
Received: from ehlo.thunderbird.net ([2607:fb91:1bc2:493c:ac39:c332:9a80:788a])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2f8862d3047sm2749565eec.10.2026.05.08.07.30.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 May 2026 07:30:36 -0700 (PDT)
Date: Fri, 08 May 2026 07:30:34 -0700
From: "Derek J. Clark" <derekjohn.clark@gmail.com>
To: =?ISO-8859-1?Q?Ilpo_J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
CC: Hans de Goede <hansg@kernel.org>, Mark Pearson <mpearson-lenovo@squebb.ca>,
 Armin Wolf <W_Armin@gmx.de>, Jonathan Corbet <corbet@lwn.net>,
 Rong Zhang <i@rong.moe>, Kurt Borja <kuurtb@gmail.com>,
 "Pierre-Loup A . Griffais" <pgriffais@valvesoftware.com>,
 =?ISO-8859-1?Q?N=EDcolas_F_=2E_R_=2E_A_=2E_Prado?= <nfraprado@collabora.com>,
 marshall@shzj.cc, hyacinth@shzj.cc, platform-driver-x86@vger.kernel.org,
 LKML <linux-kernel@vger.kernel.org>, stable@vger.kernel.org
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH_v11_07/15=5D_platform/x86=3A_lenovo-wm?=
 =?US-ASCII?Q?i-helpers=3A_Move_gamezone_enums_to_wmi-helpers?=
User-Agent: Thunderbird for Android
In-Reply-To: <0d4c9865-de40-39b3-20fb-398f8480530b@linux.intel.com>
References: <20260507180507.912966-1-derekjohn.clark@gmail.com> <20260507180507.912966-8-derekjohn.clark@gmail.com> <0d4c9865-de40-39b3-20fb-398f8480530b@linux.intel.com>
Message-ID: <69290AC0-839A-4F8E-B272-4128A617A503@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 8FEC74F7D97
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.95 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	XM_UA_NO_VERSION(0.01)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-244768-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,squebb.ca,gmx.de,lwn.net,rong.moe,gmail.com,valvesoftware.com,collabora.com,shzj.cc,vger.kernel.org];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[derekjohnclark@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On May 8, 2026 7:21:22 AM PDT, "Ilpo J=C3=A4rvinen" <ilpo=2Ejarvinen@linux=
=2Eintel=2Ecom> wrote:
>On Thu, 7 May 2026, Derek J=2E Clark wrote:
>
>It seems there are a few nits still to address (they were too many so I'd=
=20
>want to try to do inline editing)=2E
>

No problem=2E I'll try to get v12 done today after you're done with the re=
view=2E

>> In a later patch in the series the thermal mode enum will be accessed
>> across three separate drivers (wmi-capdata, wmi-gamezonem and wmi-other=
)=2E
>> An additional patch in the series will also add a function protoype tha=
t
>
>prototype
>
>> needs to reference this enum in wmi-helpers=2Eh=2E To avoid having all =
these
>> drivers begin to import each others headers, and to avoid declaring an
>> opaque enum to hande the second case, move the thermal mode enum to
>> helpers where it can be safely accessed by everything that needs it fro=
m
>> a single import=2E
>>=20
>> While at it, since the gamezone_events_type enum is the only remaining
>> item in the header, move that as well and remove the gamezone header
>> entirely=2E
>>=20
>> Fixes: 22024ac5366f ("platform/x86: Add Lenovo Gamezone WMI Driver")
>
>This change doesn't seem to exactly fix anything so it shouldn't have=20
>Fixes tag=2E
>
>We want to only have Cc: stable in the prerequisites for some other fix=
=20
>that comes after=2E
>
Makes sense=2E I wasn't sure, checkpatch flagged it as missing a fixes tag=
 and I figured it was easier to drop than to have you try and find the orig=
inal commit=2E I'll drop that for the formatting only patches=2E=20

Thanks,
Derek

>My plan is to take patches 1-9 through fixes branch and then merge fixes=
=20
>to for-next and take the rest through for-next=2E
>


