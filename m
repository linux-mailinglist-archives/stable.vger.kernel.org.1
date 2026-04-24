Return-Path: <stable+bounces-241012-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SHojLsam62mrPwAAu9opvQ
	(envelope-from <stable+bounces-241012-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:22:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A5637461E05
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 19:22:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A39B73006B4C
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 17:22:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D5883E5581;
	Fri, 24 Apr 2026 17:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CRxOgde6"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C823233F583
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 17:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777051330; cv=none; b=Z1fd6I4Cu6rvIRPLCBf//WltfHmRSHM2m6DALUg9E35XyDaeq1V+GE70XFe2GmYUTkMT4RBb5VYe6Vo+095sXgZiObdJ/pAAcD3X/Hk9s8w3eVOdDCgoIzlVtV+s8hhWsrUWyPMYfqM2U+hqMv2KfTelSuVOh4SSYOGyUmYEhcA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777051330; c=relaxed/simple;
	bh=gbZR0raCNNQWWjT/pqfd6zc8qXW6+7hq0+g4RyM+qj4=;
	h=Date:From:To:CC:Subject:In-Reply-To:References:Message-ID:
	 MIME-Version:Content-Type; b=k32Ky9Mfd+p9lG9eWC9N17i7WZu0BaMfz/Lm+QO70YSEr2CJjmj4728tL4f1ra1L0yNtl1z2WGiJw29Sltt1p6taercolDczHT3xggEJ7FmwZTlghLzgkOCu5YgMLKrbJIPaVOiwv8s391K2NekjB1iwFH3zHO2BZ74e7+S7EBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CRxOgde6; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-2ab232cc803so39948535ad.3
        for <stable@vger.kernel.org>; Fri, 24 Apr 2026 10:22:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777051328; x=1777656128; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=gbZR0raCNNQWWjT/pqfd6zc8qXW6+7hq0+g4RyM+qj4=;
        b=CRxOgde6zdw+9UnUQ+O7zmcHuGyyfLBRLvGYt4AAcmEH3HcLUrHo+v8R8Wtoxa/YuL
         Mf7OsVlVqzSKPNrkLB3nyadS958MN0F9WAVuaKmBclNDxwohBnIOgqFVM2ALYXS71xPh
         tr2CFdktVKixsqxmITz+35Dyg/eHwbyTfajmof+9qBZjoOcqoBUu7NLDMp4BNztaVeFY
         /mVmia8ZY+4UmM+7rJ6DbHUBVtL0dAFBKYjbXX6Xs0B+mVVs+P8nUJtq97pRqcNpR9Uw
         /7Qs6EMmpZqg+yDJTvPSgtDVmOTTplkyZyMk5rn4MR3KcNeO4tA4Yibj157wBNBIhNl9
         wsBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777051328; x=1777656128;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbZR0raCNNQWWjT/pqfd6zc8qXW6+7hq0+g4RyM+qj4=;
        b=SHKh3nVg6PIW34TvdX/ugYgO33Do0UwSwSSAq8PFi8xsP1bsAJVjexd2AAUsCatTcQ
         aZaCOXkHTgbHwiowThZdeXMAeiV/7bw3ysuClN4LN1W3yKmv4scaM8biB0N5Nbs5OJIB
         yqSGQ6M7PaPcylY0fy3/GzNmeBwpVmCKpZmhn2ow+7w/GYX/3HghwIBvJasbvJh/ai1d
         JuuL/tB+08d47hk+/+kl9J6IaZEzdkE5i6kxUemUXXXLR6giS6Ttj4fPxCxa5QxL4+Wa
         BLtxqYI4Nqb5GjG+2Ld+GTqxWS8AJKweIX+lXMVtUrRA5upPYMe8Fe1MntNyqeU6ettf
         eKFw==
X-Forwarded-Encrypted: i=1; AFNElJ945l2WBNJIR0jMXrPeYwbE4LlVpG/5IB4ctogqy3k07InTYywAVKB2hESOb68EoMT23tW3rTE=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqsDwjUJ2HvTECR+5//uKyL7GSBgavPH2q2rC6L20JDAPr4j2+
	Xa03VLeNOTqZOVH20O524qy7c9toJcYr/+GzlI6UnSUHkt/bXpibOhiK
X-Gm-Gg: AeBDiesxb00DzZgBJ1t2u1K3LqSf9YtPlwlRmnvui8B4Zgf+Qwt93zEriPoZGxuj7JU
	oTjbDUVV4n62nAjOXMw7pKWaN6z2l5juDQmE0Uhy6kf4O4ywMLugsrppWe/tKjp+eZqyW5ZtXQR
	gx+VYhXxklMiSO2r1h8vAesZEK0xYlcDyHn+vrvBPcQLfIA+ryGSjcFOxKeS+Hl3qxEX6xcoSPc
	84cgrSZcFKEzGAzoWk+cBq/S1uMHjSqatDgx/Kmw9e6kIhuNiFJzIcc/SfIZ6a7yASGwms7K5IR
	lkDk9Jnplp5EfQLbreeRUEfHvPSiRzbw0BB0r3fFYKIDSvkTvidxQEmrWelP4o1WDG4PZEcVfTE
	hbT2lf1tfH1FEpnPuGimIczpmCvi6FDBoO3DucAa4PsKuQrRGU7VlTuG+80nek+oi4xQDp99SQo
	ekz6ZesiEgycr7dhKu6FYaXJc/Lo7y01nR+LgOyX+HbK/3yu2fGg==
X-Received: by 2002:a17:903:2ec5:b0:2b2:5503:1b8c with SMTP id d9443c01a7336-2b5f9eebb7amr357448075ad.11.1777051328152;
        Fri, 24 Apr 2026 10:22:08 -0700 (PDT)
Received: from ehlo.thunderbird.net ([49.224.127.68])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa14487sm243627485ad.18.2026.04.24.10.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Apr 2026 10:22:07 -0700 (PDT)
Date: Sat, 25 Apr 2026 05:22:01 +1200
From: Brite <brite.airgeddon@gmail.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, fjhhz1997@gmail.com, oscar.alfonso.diaz@gmail.com
Subject: =?US-ASCII?Q?Re=3A_=5BPATCH=5D_wifi=3A_mac80211=3A_restore_monitor?=
 =?US-ASCII?Q?_injection_when_coexisting_with_another_VIF?=
User-Agent: K-9 Mail for Android
In-Reply-To: <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
References: <CA+bbHrVWmSpWZ9GBVJ5vffh1qYEye=EWMq9tKA-_uzfW+raC8A@mail.gmail.com> <20260424120807.25005-1-brite.airgeddon@gmail.com> (sfid-20260424_140854_559281_CA03D57D) <9f7df38831598001ac6cd79ab4fb95b4b6e042fd.camel@sipsolutions.net>
Message-ID: <F76D3DCE-DF44-47E6-B12C-B8972C29EB8D@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: A5637461E05
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.96 / 15.00];
	SUBJ_EXCESS_QP(1.20)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com];
	TAGGED_FROM(0.00)[bounces-241012-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[briteairgeddon@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]



On April 25, 2026 1:55:46 AM GMT+12:00, Johannes Berg <johannes@sipsolutio=
ns=2Enet> wrote:
>
>I don't believe that all this complexity is necessary, and the code
>changes have are fairly clearly LLM-created w/o such disclosures=2E
>Dropping=2E
>
Are you saying that the patch itself is created by llm? If yes, is that ev=
en possible? I do accept that yourself or experienced devs could come up wi=
th the simplest of a solution=2E My initial patch was spread across 6 or 7 =
files with a lot of debug lines added to find out the location of vm freeze=
=2E It has taken a lot of time to narrow it down to this patch=2E It's tota=
lly ok if you're dropping this but if you could at least see what this code=
 does and do a proper minimal fix yourself, that would help out a lot of pe=
ople in the community=2E=20

The only time I used the help of ai and google was during the initial stag=
e trying to understand the different variables, structures, pointers etc=2E=
 After that it was just me adding a lot of debug lines to all suspected fun=
ctions but the vm froze even before anything got printed in dmesg=2E Then i=
 added delay between the debugs and was finally able to see where the freez=
e happened=2E This might be totally unnecessary for an experienced dev like=
 you but since I'm new, I found this the easiest way to get to the root of =
the issue=2E=20
I also took help from ai and google to help me prepare the patch file in t=
he required format to be sent=2E=20
I don't understand why you think the whole patch is generated by llm=2E I =
wonder if it was that easy to be done=2E

