Return-Path: <stable+bounces-271786-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id kbq6BCnAR2reegAAu9opvQ
	(envelope-from <stable+bounces-271786-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:59:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E8657032D9
	for <lists+stable@lfdr.de>; Fri, 03 Jul 2026 15:59:04 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b=BsHuSI9Z;
	dmarc=pass (policy=none) header.from=gmail.com;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-271786-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-271786-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=2")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 7A053305874C
	for <lists+stable@lfdr.de>; Fri,  3 Jul 2026 13:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 225F33D9031;
	Fri,  3 Jul 2026 13:47:06 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 479BC3D953E
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:47:04 +0000 (UTC)
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783086425; cv=pass; b=jK9qJGfJpQMHLZnOlZC97YMoJIGw/buD2beTau2wFxMx9QMDM3ONX4hiAHS5nbLo7m3w+CNMrFFoYSupI50lBL49CS7X0ff1+hrKjExO0fAl0KMSgUb+c6G4Zq9H+6b6LZ//wFN0ddhvLqY9HnEdFoL9K/QvYByAaJkdpw2ua/s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783086425; c=relaxed/simple;
	bh=G0Cun/sv5TG4it8HOQFdrnlDKaUupn6OAuYwGu89JEQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tGFbvw6W49QzHxj8n31bIYF89IcsPUR4IM+trEEfgOrEIMXAkGVhHFcuuGTvGSclY2WXjDF06x33LFBYYu8zLOZbh/l8xVUW+2TwXfJf/xNxDC9wsMCjPOIz3zQWNPA5L0oE2wahEBh/udkVVROcUS8fsVYn1JNIQ+RZ2KTyVZ0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BsHuSI9Z; arc=pass smtp.client-ip=209.85.208.41
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-691c5776f35so937491a12.3
        for <stable@vger.kernel.org>; Fri, 03 Jul 2026 06:47:03 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783086423; cv=none;
        d=google.com; s=arc-20260327;
        b=cdz3NHsQUKtznUZoN5Om37mho5YFHbv0QXgLBe3SSWWgBflvYDX0gY/8S2wkhmH/mr
         RURSZWrHopoutKumISyqEwBVsVOpcCa+Oj8eJ2AptFA1RdIuLXsoJM6PjP5egctZvJ1D
         IrGVvcJvJoBEcwUazZ+/k/bVLWbac6x3TOP/0MyVDC7rccXP11yYaUbUS9GjpFG4DrRe
         Z2M5TMi0ZTYBeaUnD8Al6fWpbCtQ6mOBrDWsSIZKuyrxMbC8J/sl0j8AhhWCPx62Vrhw
         dZPaLOKbhGAQIRnaSgwpL7LSzTijzFOx6QA2ZjHqzhFOPu7WQs4wjFu9Eq/dJn+DIXMP
         0/iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G0Cun/sv5TG4it8HOQFdrnlDKaUupn6OAuYwGu89JEQ=;
        fh=4P1bJ04033QpEyoN2eS2xe3SH1ln7h2/Eu1KFKn1RJQ=;
        b=budnff9gIQ6DtStZiZupBgNj6HZc2qQ+0TRczbyHru0qKuplWWs+zHisMnlhySCReL
         c8+K3T+l/17czCrYR5OMoGY9BZJihP+w2adLlSpKoqqBuMq483ODc5hYMv01apMx8Hu1
         F4HXE1EJh3T3JCKBK4OFfZd9QG2rni9GnHTAcIQmJayFyB7gTF2MxmJajEGJRrnIwvkA
         yJL2/cczM2TLaoLz+H68Uy1ZLWVNT1qQHD2cyQfxeagUhG8wnArz1nGBlJHaVufeYuN9
         he3BncAx/M5fATlMYaCdtKYFDLupZ776gPFEjxh3d9E0QlkjswNgI4decf/yORBQHOU/
         qgnQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783086422; x=1783691222; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G0Cun/sv5TG4it8HOQFdrnlDKaUupn6OAuYwGu89JEQ=;
        b=BsHuSI9Z2atWPA1RAOvtGdfEu3m8HCv6u7nm6v1YFkJD6ca1qI52bFcvERVTkU5oVx
         gDejIKa4FRNs1w8xlep+JepXVwhYSSHpoZyJJSc7gh9Ftbd7GJTNUDzTgsjpGWGIG7Gh
         vkIqQSXRGwXnvyZ2W1pSQ2qbW/MLf3QySAt9CECPwfJOQ/qWsp1Q3zXS8mkn8oXIzlcV
         wEWemWHFsied28qjfwQC+KLLAEk3uOyY29m3b3Ae7MHeTWTuzc1H6L+NVC6Cvldh5hzI
         MRBx4zkeIla3IWCpu+3UlxdtQjwGkAbjUjJgtJvAqwakSN1xfUrROcDhmnqRF1pdzNo7
         R3vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783086422; x=1783691222;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=G0Cun/sv5TG4it8HOQFdrnlDKaUupn6OAuYwGu89JEQ=;
        b=OaPEWk3eGmiMZ9HOPH+kPl5SvsfASeSHnMC27BXzU1wVfVp76N60aQ9snJBl889vUy
         lvxo7Koz1za3Za4FFSE7ZteS8SR72XFkP8yzYcizY8yPAQpUoFt4TpECf41h6fp18SCq
         ynQj7ojexN9TyfFaTMHTgBN0j2xNwHwr8ONnvN84NTuplgRakNE/Be0jGwkr22XzKxOs
         N9p5APvkArFT/Pweo/3vp2OdpQLU2k715qpV0pQxE2Z5/7pzLZjXdJd7ZyAdkrdX74fu
         ElhFPWHhvcDFnJNKZW8iG5Z2cwjXOLZdiF6FecCJs+rGy20vCBkOVncoAZLz2troGGdl
         Nh1w==
X-Forwarded-Encrypted: i=1; AHgh+RogHnHPEhkMnDhoC6wNBOKuR7SfJ8NPL8m9UHrEgNPctFFbevy3MJgKMJiVBXHN2VLrFrfLSCI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwqJyXZwW497QjNlTahqkXnMIwCHkr3YlCULhOgrF9l75tZTTEn
	5sGsnSCH1688VTvUQjCoZM/C9nZkMkJUiog/lac2P8ASzXEpQYyoDosQ+80oI63w92RGe3aO+ws
	n2lEgjaAqKnRVinP40Pr5MauNNF0El94=
X-Gm-Gg: AfdE7cnlDhr6IB6xgvU53FL6+bjX9RimfTotKfXe25q32DNxV/pMkP2/cnDhwkG7uNh
	UHNRGGBY8gXX0ywXTWWysTsRNtgw8B9nyyJ+ZpoU/lxoncNg96t8llzoNmqMyavYmUrhsg7XqM2
	Hb68N7yXY9DWmnUGySTTFcVnqVzRzRPfoZX89Fpw2HjkWaMe/YvlvxmvU2fNfjPW+Z009++74wm
	dge8Q7g81+fXyw0sNS1XhYINlO/pAVfB9HBdLd3le5IY9OPFseUwkg0pSMCud7V7Gd7I4sFCA==
X-Received: by 2002:a05:6938:a08e:20b0:c0f:de3c:dce with SMTP id
 a640c23a62f3a-c12aa136d83mr322721266b.41.1783086422164; Fri, 03 Jul 2026
 06:47:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260701163310.GB6517@frogsfrogsfrogs> <stable-reply-xfs-235-fstests-66y-20260702213502@kernel.org>
In-Reply-To: <stable-reply-xfs-235-fstests-66y-20260702213502@kernel.org>
From: Amir Goldstein <amir73il@gmail.com>
Date: Fri, 3 Jul 2026 15:46:50 +0200
X-Gm-Features: AVVi8Ce43HwF7-ts3rhOcPkeuNZOA4woXfj768vFVH3SS2Roxor3ADq11c4OZCc
Message-ID: <CAOQ4uxg8AsBL=hrHY8H+U3gPM8aHg1C2-WDXnCAe3CFCOsBQ9g@mail.gmail.com>
Subject: Re: [PATCH 6.6 0/4] fix kernel crash for xfs/235 test
To: Sasha Levin <sashal@kernel.org>
Cc: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>, Carlos Maiolino <cem@kernel.org>, 
	Fedor Pchelkin <pchelkin@ispras.ru>, stable@vger.kernel.org, xfs-stable@lists.linux.dev, 
	Christoph Hellwig <hch@lst.de>, Catherine Hoang <catherine.hoang@oracle.com>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, lvc-project@linuxtesting.org, 
	linux-xfs@vger.kernel.org, Leah Rumancik <leah.rumancik@gmail.com>, 
	"Theodore Ts'o" <tytso@mit.edu>, "Darrick J. Wong" <djwong@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:sashal@kernel.org,m:hamzamahfooz@linux.microsoft.com,m:cem@kernel.org,m:pchelkin@ispras.ru,m:stable@vger.kernel.org,m:xfs-stable@lists.linux.dev,m:hch@lst.de,m:catherine.hoang@oracle.com,m:gregkh@linuxfoundation.org,m:lvc-project@linuxtesting.org,m:linux-xfs@vger.kernel.org,m:leah.rumancik@gmail.com,m:tytso@mit.edu,m:djwong@kernel.org,m:leahrumancik@gmail.com,s:lists@lfdr.de];
	TAGGED_FROM(0.00)[bounces-271786-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	FREEMAIL_FROM(0.00)[gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[amir73il@gmail.com,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[linux.microsoft.com,kernel.org,ispras.ru,vger.kernel.org,lists.linux.dev,lst.de,oracle.com,linuxfoundation.org,linuxtesting.org,gmail.com,mit.edu];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,mail.gmail.com:mid,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 9E8657032D9

On Fri, Jul 3, 2026 at 6:07=E2=80=AFAM Sasha Levin <sashal@kernel.org> wrot=
e:
>
> On Wed, Jul 01, 2026 at 09:33:10AM -0700, Darrick J. Wong wrote:
> > On Tue, Jun 30, 2026 at 07:39:32PM -0400, Hamza Mahfooz wrote:
> > > Any idea on potential paths forward for getting this series in
> > > particular into 6.6.y?
> >
> > Run fstests, and if there are no new regressions, ask sasha/greg to
> > queue it.
>
> Thanks Darrick.
>
> Hamza, could you apply the four patches on top of the current 6.6.y
> tree, run fstests, and report the results here? The series was written
> against 6.6.84-rc2 about 15 months ago, so a fresh run against today's
> 6.6.y would both satisfy Darrick's condition and confirm the series
> still behaves on the current tree.
>
> Once a clean fstests run is reported I'll queue the series up for 6.6.

To be clear, it is not likely to expect a clean run.
What we want to expect is no regression from 6.6.y to patches 6.6.y.
A run of test group auto (-g auto) is the minimal sanity requirement.

TBH, this series is quite subtle, so this bare minimum sanity is not much,
but it's enough to make sure no silly backports mistakes were made and
it's probably better off than leaving the known bug in LTS.

Thanks,
Amir.

