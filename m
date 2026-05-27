Return-Path: <stable+bounces-254462-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2i/EJhhNFmqxkgcAu9opvQ
	(envelope-from <stable+bounces-254462-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:47:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 36BFF5DE5BA
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 03:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7BE78301363C
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 01:47:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D6823002B3;
	Wed, 27 May 2026 01:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SN82+6ZH"
X-Original-To: stable@vger.kernel.org
Received: from mail-dl1-f51.google.com (mail-dl1-f51.google.com [74.125.82.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF2572773CC
	for <stable@vger.kernel.org>; Wed, 27 May 2026 01:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.82.51
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779846420; cv=pass; b=gqrSBkX2/Kh/9+RT+EHvnZTT6shmmVA1HGdzDlAcKJyhEB9gfkRzzJbScS4T5hdFwCgFAjQkV06Q5rPAP6bVlVi1+r5RTJEh/rXzUtnRhDDKWZaA6bAY7DY1mf0zChdkC3KsqVZR4ZBYGpeuxiBb873VuLiGYhTqaU3BBfhtwls=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779846420; c=relaxed/simple;
	bh=+04r+7H/Ff8/JI7yjuNcO/cMN2j9uJ3molBSVlXXxb8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JnX8mTPSiHJJc4SxYgr6//OzvXJIlrFpjljg8sx95Of/2hVGDoEB6Fo3/ih9qzgu+BrXlx7e2KE9AEz6sM/+DN2AUEJxLOzp2pD4mpK4RYR8rtm26p52nmoiRZxNBIyJEQPTU/ccExu8sswHizspO9mA/yMfH3BX4QRoL+b1U0k=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SN82+6ZH; arc=pass smtp.client-ip=74.125.82.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-dl1-f51.google.com with SMTP id a92af1059eb24-132d1b2519eso5738537c88.0
        for <stable@vger.kernel.org>; Tue, 26 May 2026 18:46:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779846418; cv=none;
        d=google.com; s=arc-20240605;
        b=k7o+C28gYwG1QomxSFz9Vldvewf3a04K1fQQfDKrRWlqT3olaL4By2QjtCfunleb0+
         k0Rl43XNkkTJeewdGmBwB7I1YgHqRtBvACMqNFnlX/ecVZmYaTTziBf8SUx6Lv8mUaJg
         DDZaIaMDIVvW9dAWsIp6pnYRIEPBJ25hkUSY3OcGu+tEKVXnfWihuhYxWQ5liKPO7mcW
         ew1bpL5fG4nlTZace/AeuN0pkb6Q5oWkIeFz6XItqGdw10OJtNsOsE3QXTw/zvME7y/7
         pgfnZhRua6Hvf7ixm6dDhWcb4lcSyIq0gwFIHLjlRVQa2YmAOvt0FuXlQihZh0oMKtKl
         sLWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=+04r+7H/Ff8/JI7yjuNcO/cMN2j9uJ3molBSVlXXxb8=;
        fh=xFS3JV1Vn2gbW0HzZQgfZL7TASXvjVxEpEU+Ma+JeIo=;
        b=jfW1S1TKXIlnxv2R8PlEVKOC3iMmyvpqw0Qu0mYjjRPeD2mD6365XPpR9OWf6zvDbR
         fENjHlToWgJM1UuCTx1mJyjyuANtbte4zP5lD9ZkWFBJTLiKRPcZzKpmFAod1eBTeZYk
         I+qvqiRQ491Kvl8pVdCYaqzDBK66JJ3GJL/98cMfQFvWJu81G6h/nzvglTloyRA1O/Hw
         dY9LApIXMhGBBOhdM7xVGfpJlyMzpBEE+J7wwI70TnobvVgNfsOYIrhAm/zecBbcgqIk
         plL069pCJit3i8Ps0VuTh6CHIFlkF4wyRFOmADRQjrCyqgYhKoQ57VJ8jxZqO/blG+BE
         5xwg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779846418; x=1780451218; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+04r+7H/Ff8/JI7yjuNcO/cMN2j9uJ3molBSVlXXxb8=;
        b=SN82+6ZHAEvroF0csEksfNoSkCRxpX82huKPXAgMmXU9JZZrb6Prt+E3vq+zPbsY6t
         uTCgWjBVlZDcx3Vn3QROrdXkqyVesQ6tNuGxeAFZcQFrA3MfNkMgDkruEzUpS1dOCi3t
         k/wZHkUqi6UadIEDNBCaZHg9mcrMIHFd6Us+0aTO/n/aKTinXcsRz5mLngNP1/F7EbNO
         rYwduKi29YnsBKd9elgJcUJ9/T2C/uwPczxnhy8V+AbtYXp9tv8tDJjkB6kup+28RtZo
         +XZxt3HU0BxiEuNg/MSbA7Lsphmbsdk7zGFTxcVZVa9IrYfj2u95oElhg2ylFLzBNlBF
         zA4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779846418; x=1780451218;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=+04r+7H/Ff8/JI7yjuNcO/cMN2j9uJ3molBSVlXXxb8=;
        b=GKp6bkmSW3m+8h1OHZnOsted5vipE/E57eomIv43Asm/LathE1ZG9xtP+ynPFr4qH8
         8Y4skgPKUG/BjHPzYM5neXWJDSb9YFff/0Snk6M+JrV0Pi/NPQziaxz/yYGlK3Zy5cIo
         GFvRJBKYF5sBWV0FzdNsDFps8aTEQCjDFOWLstLKXyUi/M6fOH6onKaPPGP66jAqFmfI
         321X+3IgP6KKR8OWjhQgoWnt34R1PEW0ABK/e1aGEbC72nweIMXoUliEh9sb3F+AZlhq
         2Q2MZVKRpaR9W4pPmhcgopV0fE4VHQqXhY5P0d6Z1nAIg6xVXonDIJFVz/fXMhofwnHR
         S58w==
X-Forwarded-Encrypted: i=1; AFNElJ+b6yk02bHzVX/SZ+rxdwI2w2+o3N2qU6SCs0nOr/X1dPPuWKV/CzB+jeA7iGFmp/YK4RXcz1s=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQo66leSC5lj+82o0iJZDxc83XjZu/wTgvjuLWwaOBtP8gGNqx
	lbSEyep0nBSqSeG8rzuAWKLE/EV9ltvvb0miD7C31wi6/fKJ2coog7PGQoCoFwMukMGDHFm0fc3
	3yhk4kKCgQAXagQhAF1RxQM9k+pUPhnI=
X-Gm-Gg: Acq92OFgAHnfw4CROVE+E7EMj2oqg3UH/F1pxMA67DS4fsrgbpsfF/UArlifHurJQ5/
	2U5nps3Y/NbZ60Y83ca58vZV64qXhtVw9xsMQN/9CrH2L6PAITtyPhbbA1Sg42qBhH5wSQakpgi
	1/A+SbSETjy0MyqojXpxQ6/8NLKlKw2sk5+btc8gsiITbua0I9m7uFblNqIfsWtAjb6OtXLmHQY
	nHPQqWwEwc282nLU+rkCjcqxaqPXfiRsvfxaj9kmtZ+8ILDCvz1TkVYKUvrlOmC+HNglfVwZZee
	NxjIKcOqz9BWOapC9VMaAkf+qwmTUdUP9Y/G3Trg
X-Received: by 2002:a05:7022:313:b0:137:1ae1:bc19 with SMTP id
 a92af1059eb24-1371ae1bfe7mr2334555c88.5.1779846417889; Tue, 26 May 2026
 18:46:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <SYBPR01MB7881F8D11D2930BB84215253AF0D2@SYBPR01MB7881.ausprd01.prod.outlook.com>
 <20260526180233.4323832d@kernel.org>
In-Reply-To: <20260526180233.4323832d@kernel.org>
From: Yuhao Jiang <danisjiang@gmail.com>
Date: Tue, 26 May 2026 20:46:46 -0500
X-Gm-Features: AVHnY4IkCZ3xS069Ov0wNSWJciSMcrWEH40NF12aPNiUZ8pKKwxyYuBAVL5md_A
Message-ID: <CAHYQsXQ4qQa9nLc6re=Oobyojv3FVG9Pc+3KVEq4qKXEq3kXYg@mail.gmail.com>
Subject: Re: [PATCH net] octeontx2-af: cn10k: restrict LMTLINE sharing to same PF
To: Jakub Kicinski <kuba@kernel.org>
Cc: Junrui Luo <moonafterrain@outlook.com>, Sunil Goutham <sgoutham@marvell.com>, 
	Linu Cherian <lcherian@marvell.com>, Geetha sowjanya <gakula@marvell.com>, 
	hariprasad <hkelam@marvell.com>, Subbaraya Sundeep <sbhatta@marvell.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254462-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[14];
	FREEMAIL_CC(0.00)[outlook.com,marvell.com,lunn.ch,davemloft.net,google.com,redhat.com,vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[danisjiang@gmail.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[gmail.com:+];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable,netdev];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,mail.gmail.com:mid,linux.dev:url]
X-Rspamd-Queue-Id: 36BFF5DE5BA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi Jakub,

I worked with Junrui on discovering this bug and preparing the patch.
I found the bug and reported it to Junrui, and he helped write the
patch. There may be some overlap with other work.

Thanks.

On Tue, May 26, 2026 at 8:02=E2=80=AFPM Jakub Kicinski <kuba@kernel.org> wr=
ote:
>
> On Sun, 24 May 2026 15:29:29 +0800 Junrui Luo wrote:
> > Reported-by: Yuhao Jiang <danisjiang@gmail.com>
>
> Really? I thought I saw this reported in Sashiko..
>
> https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260520154157.143931=
9-1-michael.bommarito@gmail.com
>
> Either way, Marvell folks - please review.



--=20
Yuhao Jiang

