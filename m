Return-Path: <stable+bounces-233705-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id GMWkKB5B1Wk73gcAu9opvQ
	(envelope-from <stable+bounces-233705-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:38:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1FB453B274D
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 19:38:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A6A203042984
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 17:35:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20BB7345CA1;
	Tue,  7 Apr 2026 17:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F4cAwiv6"
X-Original-To: stable@vger.kernel.org
Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84AD8344D90
	for <stable@vger.kernel.org>; Tue,  7 Apr 2026 17:35:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.170
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775583330; cv=pass; b=d6CcJOwJgcI6IP7h8hl/cVEiu66SEC8zLsvAiildlGOcBwhjCjIclrOOZS8TTflpJTX6yoSw5s2gauRZ5YIllPG5XPsrIrodWp1KG+4KmqAbGrdO36ydrQrkqVVdP886JnmpXlSddR/S7mySXMBi+YhlZK7MbhupT/uSge3i8eM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775583330; c=relaxed/simple;
	bh=bVcou+Gprm8jI+MgNIWQTYr42AbaKd/ho0YCL94TYdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Sta8NbzQmXNAEKThv5KaegLm3X/s0s9J77sZZSs424GhVMfdGxWa6pzNDLFf9I3CgSvzCJA6fiX+n+BEei331DPoVi5JyPd5ReYUwPzU8PlzvSS5HTJNCUgR+BPJreLFZJMIT+qfHMbUNpJP71UgPXyjfODcPhEfBW4gUbQvc5w=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=F4cAwiv6; arc=pass smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-56d8a5f0e44so74639e0c.1
        for <stable@vger.kernel.org>; Tue, 07 Apr 2026 10:35:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775583328; cv=none;
        d=google.com; s=arc-20240605;
        b=eoeEnBAo9iNo56xR5mnAvAHbeq1VAnBTJPstrX//5Gnel/X+u+mEQav1T7SFsP2bB4
         j1v6tPhNqAj2ep+sT1m3WLezWcAMk0F1m/OZyC3ahsOoA+PTT81lY3IYGsYa3PHloE4e
         ZzjLDuPJ55/Nh18ltiadmgZcY1eB7Tg59EBbwM8v9jR9SdRsbqatrsdBPzjr0TmsE2GR
         ntu2PnlMbNXZFxKtnk9YN5KWwWx6pHmXho/zQU2DVbA7ik0af8S2e7S6paAzB9Ic2nk8
         T9SviyeAZAgJWlf8CxOZu/dEK5/PnIW+pARbQ/sg0c60xr/HlpyxrigulmVW42TJnJKR
         +A4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=d0d7dSyKzAyZ8PECEnJjvu70SAnmL644NrgpjRWVsEo=;
        fh=WT/hvakML7n17Ucb3ZzDWfHgzRAQrxBnw38y356JQPI=;
        b=lWw7DDC7HYNslzHOFSxjsPWJPXadb1nZSoCXBug/NRY+oZzLDUkNS6GUVdKFvtlg9a
         DN8zNyjas8lBcSkJV+/i5qXKhoEma5UCQOnswECHIlsVzXNiWcjp+nqBezTtVZN8OWIj
         XF7wCYipCU+HOlqbUNVoKDRbcxKIgqbjTui4RXmUy76i7jIiFKaixwdg6sFv95to0I3r
         N5MWDbYV5HwhJ980SVZjcbsDlBbivNmgdHnPOrLELB8oRfkYHaMnUYj9Eqk1hEiZSX/X
         PVREYCntgnmZfyvqhaVB8rcMguauUxo+BrgOvxmkn02VLEyyJ8HvLFa1WPmoJtgR19WP
         b5dA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775583328; x=1776188128; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d0d7dSyKzAyZ8PECEnJjvu70SAnmL644NrgpjRWVsEo=;
        b=F4cAwiv6xG/b3XUADEDIdJBqQk+j2gWcrri+DtPEKJAT1/ca5p83YNVNnFdmqf+GSQ
         eZeeGa7hP3mYZhXf7thT7tPM4zkpW9+S6XOkrqMnWxh4x796RbGY9ppMZeVaKsKDYL+M
         7oLTJNGRzLx1Jmz2GHKgtuH565TI6OMyL6MoGx5hmBlrlwZlZ7ziAHFtS1ACjdPfZyuX
         se3NPNCFbnMiMdjcNyONdB1YmSQkbtEaTvqNKMECRJawfHzoM6oknl2g4pF1bFejaPsK
         j+PSffQb7eXJiWAVviiaMm9jCOP6PR5COpBfL/hhpHoj4V4XLuTCNGWJb0pH0DqqlOZ9
         70RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775583328; x=1776188128;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d0d7dSyKzAyZ8PECEnJjvu70SAnmL644NrgpjRWVsEo=;
        b=ZFxX8w9OzWoxTqc89Fe9ORNn70Sw8B4irEG8QLIbY0NptMp6wd5LU3kKM11pDHYf9W
         7AbkKHmmqyAYBrPkUWLSLDb/k9pYJiJnsQsWIFRtyWRnC9umrGhaMg8p0UMWv3kUQTnR
         eL8asq2jqUoQjx6qoipq03LpAvkGJH8pbxzCwO5egWgR1/oObEEx9exyX/3bCD/3o3K5
         T9d+TZ/cUAW/wHTvtauStMpDZF9ZQsGvSlgVZC1FOKL1H0wSdWkSRG/FkaFi8u00d5Wn
         fEAi6CbwwYBwJ2WN4HfqeKfSBRPKdFd34VSdqUpNnx5S75PTFuco06WvJeVGk+sg3xqI
         mZDw==
X-Forwarded-Encrypted: i=1; AJvYcCXqfUJiMkYNmilzhhCDF7T3lzDZtIVnfHyZGCvjOa0f9GHTqu499PlL+EJSAYnHfj0Z4quC/DE=@vger.kernel.org
X-Gm-Message-State: AOJu0YztLw5y6ZxhalBn8ARJCMWP8iqYfK0OQPudvGbObkqBThm6/5nD
	lRiSEyBO2UVXCkVGc8LBd/b7S18zVh9eRQnZoOrm8HQ79M4v97QagFNV0wND3t5j0cRCr17YKz1
	Yg/DMGS8nBj/M7JkCqVpiNJa0Z8Ka8us=
X-Gm-Gg: AeBDievjDquMmnA0d8xzL9ziBlPk+JjuOX7APiMQEzWokjMy4JZZUHkyL78bWd5ddG5
	Abazeu3uMexp4Y6LehJCe5i0n+GB+9nFU2/+0y2xMd3OMd+kzddT/w9PTD64rISojLFIiTaCEc8
	tjRaPb1zxQXtpKSTsMR5/6tyV/XOYK4hRHG/KIf906hd1ECvYHY+qpIPD+eBC0OubdsyQYW5tpk
	IO7IYVzvqxpf0unEpvpC6nJYMxXYE3BAyRLiCfKbmNh/TxrP1uL28Swwe99Ah9D+z1rXwF45Z44
	qIQ7GT6gc2SBUqDtTiFlwktj2Dq515S4fcUJTh7E
X-Received: by 2002:a05:6102:94d:b0:5f8:e41e:e5cc with SMTP id
 ada2fe7eead31-605a5034c28mr5433959137.9.1775583328358; Tue, 07 Apr 2026
 10:35:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260406234739.29926-1-joshuaklinesmith@gmail.com>
 <20260406234739.29926-5-joshuaklinesmith@gmail.com> <d4622e31-4012-4c05-9288-529b0bb0aebd@candelatech.com>
 <CANs=ypgdgB_3stm5bCvO8RTat-sxs0N6SAaeYSQ-dyq43U-ZBg@mail.gmail.com>
 <ddc4ccfe-27e0-7558-9b5b-27b4c4fe54b3@candelatech.com> <CANs=ypgceH4NL5xOr2C1FPp8KvDCcUWTu10i+DiXntuOmAfJVA@mail.gmail.com>
 <5e197844-804e-51d7-a1de-e9e7686bad0a@candelatech.com>
In-Reply-To: <5e197844-804e-51d7-a1de-e9e7686bad0a@candelatech.com>
From: Joshua Klinesmith <joshuaklinesmith@gmail.com>
Date: Tue, 7 Apr 2026 13:35:15 -0400
X-Gm-Features: AQROBzAV6xaHAvXHRyVUe2RM59GmP1ed74mWrJcyksvjS9RgAmFB4oykGjkFOUg
Message-ID: <CANs=yphvbzzDHFsZZexSW-7YZTU5zRc4P_iapvCH=NK0f_XbMg@mail.gmail.com>
Subject: Re: [PATCH wireless 4/4] wifi: mt76: mt7925: fix RCPI chain 3 mask in
 sta_poll RSSI extraction
To: Ben Greear <greearb@candelatech.com>
Cc: linux-wireless@vger.kernel.org, nbd@nbd.name, lorenzo@kernel.org, 
	ryder.lee@mediatek.com, shayne.chen@mediatek.com, sean.wang@mediatek.com, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-233705-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[joshuaklinesmith@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,candelatech.com:email,candelatech.com:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1FB453B274D
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 4/7/26 Ben Greear wrote:
> If you talked some AI bot into finding non public source, or if it can
> actually generate useful c code out of vendor binaries, then I am not
> sure how legit that is to even post.

Hi Ben,

Thank you for raising this point. After considering your feedback, I
realize my workflow has involved analysis of proprietary vendor
binaries, which raises legitimate provenance and licensing concerns
for kernel submissions. I should not have submitted patches derived
from that process.

I am withdrawing my outstanding patches from this series. I will not
submit further patches based on this workflow.

Going forward, I will limit my contributions to fixes based solely on
publicly available GPL-licensed sources and will clearly document the
source and rationale in my commit messages.

Thank you again for taking the time to flag this.

On Tue, Apr 7, 2026 at 1:31=E2=80=AFPM Ben Greear <greearb@candelatech.com>=
 wrote:
>
> On 4/7/26 09:58, Joshua Klinesmith wrote:
> > On 4/7/26 12:31, Ben Greear wrote:
> >> I am more concerned about the trickier patches that you have been post=
ing
> >> that is utilizing work from upstream vendor code.  How much of that is=
 pure
> >> AI driven?  How much testing has been done to see if there are actual =
stability
> >> or performance improvements when testing actual hardware?
> >
> > Hi Ben,
> >
> > To be straightforward: my workflow involves pulling GitHub issues into
> > AI prompts along with firmware analysis tooling to identify potential
> > fixes. I have an MT6000 available, but I have not been doing thorough
> > on-hardware testing before submitting. That is a gap I need to close.
> >
> > I will hold off on submitting further patches to the mt76 driver until
> > I have a proper test workflow in place and can verify changes on real
> > hardware.
> >
> > I appreciate you raising this directly.
>
> Please be sure to add note about using AI to patch submissions,
> and link to original bug reports you are trying to fix.
>
> Possibly some of this is useful, but you need to do significant tests
> with real hardware if you are proposing non-trivial changes.
>
> If you are referencing publicly available upstream driver source, then
> be clear about that and provide links.  'Reverse Engineering' could mean =
a lot of things,
> some of which is grey area for patch submission.  If you talked some AI b=
ot
> into finding non public source, or if it can actually generate useful c c=
ode out of
> vendor binaries, then I am not sure how legit that is to even post.
>
> Thanks,
> Ben
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>

