Return-Path: <stable+bounces-253864-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8CJYEgn1EGrNfwYAu9opvQ
	(envelope-from <stable+bounces-253864-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 02:30:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E054F5BC037
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 02:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3CC043018BD2
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 00:29:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C5751DEFE8;
	Sat, 23 May 2026 00:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="q9+HAMMB"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA5D21A6827
	for <stable@vger.kernel.org>; Sat, 23 May 2026 00:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779496191; cv=none; b=oGIhZDDyPgEZWRUHzfeAg9d6akA+Q5FT3ib5FH19GN6/xeEspmxHa4QhAMFP/LUmb+fRodvULKrFRcWo51QP+pWiuDCaX7wYgtEMEJ9d6SFcTEfUBKc49eB32dQNveXZpglnkYazk5iO7ZggYR5NcEwXQ8jS80eZModuvLwvcvc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779496191; c=relaxed/simple;
	bh=w6E0YRreyAwApnZtybobqMm+JuPyTSoPhzeahJUKmwM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSdD/sB+94naeX0oVXgQKzKiNmI4uhfPEBTYHltTWd5tgUO16fx3skH4ZtNQpbZMy9TnB6CGvyfbATaL2LuYh1zdoftN8gDqGoFDuiEhTCPMtfU7ywqLuCfxj1BIMEQ5m8dkBsFvwFiQi/ttIuLqzn6Y7MjL4fJ8m1uofJVlJhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=q9+HAMMB; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-4904fd4f6aeso2651755e9.2
        for <stable@vger.kernel.org>; Fri, 22 May 2026 17:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779496188; x=1780100988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w6E0YRreyAwApnZtybobqMm+JuPyTSoPhzeahJUKmwM=;
        b=q9+HAMMBbmbOmEtIX8nFjPojvDY0AgEJVmYfCRXC+6OIFPyZHlMa1RLHiXcjUiFH+v
         WdA9PrElzj367yrEL5TabZcMLKXiuOD1jthxRDq50VvdgdbjsJe7LviTVWuDd6dJ4fyX
         fiUvRYX1opuJnCf380ofr05Oc4tzwWu+2CzvU1vBeqOODsieGCr8g8riQ+GzpNeS49zR
         tvjl2waepwQ6kdGtxLGbtr816d87qSEDDp3Z8fFJeHpkCQuacHntlTd93cgQFkqHWI3B
         07tUBZeaaZCNBJJleRyNwL2qN4gfi8c1QAQmsp/worRWR5VnWAZAykjdhu75K3b0dvSv
         NERg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779496188; x=1780100988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=w6E0YRreyAwApnZtybobqMm+JuPyTSoPhzeahJUKmwM=;
        b=QwVzqeAJarCq0T42KKLY1TYkbH3gQw+BAeT3MBYpQcf7vS6T8MasFAOdw8ChA7Eqjr
         TF8Xk9MhU7jNkzSzkeMobqV7pBYH9152tCNp77EDUr+/TeTZgmiYQN40h7eQDVtgTOxH
         A6o9G0HYA3Mf2UsiY0C365iHpyjJVce6HykUjyA2QuMfHx8QVp7N3iBvpNC2J+GDmzQf
         Go+pNX7shgvQfE/SvnkQta37bvPovd2gQffqgKG6ydcBWtxABIOneftSjTZKPPcOEKcT
         W221nbESDqDVnsj96sUIsUAGPjzlez/MFDAuB8nyMdD3RStBc1TnoGp6wKW7fkBqpBCZ
         q+wA==
X-Forwarded-Encrypted: i=1; AFNElJ+yWfDAxqrE25K4vDSnA40Oo4VQ1Y7NVR8RZBNVd9UNFkpvR5ODAExbx7bpH1cDdz0XOGJK0YI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwAm4/lHxthiHWcYlCcfnEChGzmIiqfoKUCVgoqRabb9I/CrH5e
	2JBEtcFJetJdartv59A98fRboK60aioh540UVsjKlJia7UaBFKbRqJT6
X-Gm-Gg: Acq92OF76B2bDrQQoI0nFNKt/o0awKKGwUWoASvlCG77+SjUC+tUSVWPJ8yYlDwIuny
	DUWDSa8kFSdjQ5BrFvd0oBBuGzphJ2ZHHXxWHZoUjiOHSZ/TKmNn7Zo479WdBj5I9/etqwle1VD
	G7308C+MpDMo7lg2vw9MJCuxvMAxciNKChBIKDiv/CLlcSJybM0X51jEgYWr8BeDgaaHijv0dyK
	bkGa5P4boloBwr/cBhLDXBunOWbq3Gm6sJYq0toCgWZ53ZpEMr9pEpwEUPG/TGfnbZ1cAdZXDWS
	FIdWWrg/3tmJS3DPf8dDEnPfpb0dWZxHT4B4Jk7wwJWUmvwcoHoEnQc5JijgPbFGpeprsJSTrPZ
	OQxM3MtzVgM0rVV1pT7s7yTVc+8p1sWfGkaZBFYA0mv4ofbGdBkRr3BeNBv5OAooRezTqtEq65k
	OAdNGKEhqLJ1fDDAxMC5on9IaFfUh9wdur
X-Received: by 2002:adf:e005:0:10b0:439:c18f:5aaf with SMTP id ffacd0b85a97d-45eb38bafbcmr6665775f8f.34.1779496188044;
        Fri, 22 May 2026 17:29:48 -0700 (PDT)
Received: from foxbook (bfk48.neoplus.adsl.tpnet.pl. [83.28.48.48])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-45eb6cce0a4sm7355058f8f.12.2026.05.22.17.29.47
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Fri, 22 May 2026 17:29:47 -0700 (PDT)
Date: Sat, 23 May 2026 02:29:44 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on
 command timeout
Message-ID: <20260523022944.59799d83.michal.pecio@gmail.com>
In-Reply-To: <CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
	<20260430235453.2288c973.michal.pecio@gmail.com>
	<CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
	<20260502114644.76e6b5a3.michal.pecio@gmail.com>
	<CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
	<20260502235517.089ba5bf.michal.pecio@gmail.com>
	<CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
	<20260503071749.6abda137.michal.pecio@gmail.com>
	<CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
	<20260503213111.117db3a1.michal.pecio@gmail.com>
	<20260504093118.615ff480.michal.pecio@gmail.com>
	<20260518083339.507e24bd.michal.pecio@gmail.com>
	<CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
	<20260522110328.0d3eecd8.michal.pecio@gmail.com>
	<CACaw+ezqEO_PgjGeYCLq5hA2eKczFXgmZLa8qjPtVJZCGwsdsg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253864-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: E054F5BC037
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, 22 May 2026 17:45:22 -0300, Desnes Nunes wrote:
> Hello Michal,
>=20
> On Fri, May 22, 2026 at 6:03=E2=80=AFAM Michal Pecio <michal.pecio@gmail.=
com> wrote:
> > If the bug is deterministic it should be fairly easy to nail it down.
> > Attached xhci debugfs patch adds a list of almost all memory the xHC
> > is allowed to access, including (if I havevn't missed something) all
> > mappings it is allowed to access before any slots are enabled.
> >
> > Please apply, reboot and then:
> >
> > zip -r before.zip /sys/kernel/debug/usb/xhci/0000:80:14.0
> > # trigger crash kexec and the bug
> > zip -r after.zip /sys/kernel/debug/usb/xhci/0000:80:14.0
> ...
> > And since the bug may be an out of bounds access by the HW, if you
> > don't mind running slightly experimental patch to a critical subsystem,
> > please also apply the DMA guard pages patch. I've been using it for a
> > few months without issues, but YMMV. It helps determine which mapping
> > is accessed OOB.
> >
> > Note: DMA guard pages may casue USB to stop working before kexec if
> > it's a HW bug masked by memory layout, or begin to work after kexec in
> > case of some IOMMU subsystem issues.
>=20
> Please find the requested information in the attachments below.
> Kernel was patched with both patches.

Sorry, I forgot about the most important thing: crash kernel log, or at
least the IOMMU fault message showing the bad address.

However, in this case it's moot because it seems that the HC didn't
fault after kexec and it worked normally - debugfs shows that USBSTS=3D0
and some device has been successfully enabled.

(It's a little odd that CRCR.CRR appears to be clear, not sure what's
the deal with that, but it's same thing in before.zip as well.)

So either the bug isn't as deterministic as we thought, or one of the
patches "fixed" it, and that could only be DMA Guard Pages. If you
can't reproduce the problem with guard pages, please remove that patch
and post before/after debugfs again, plus crash kernel dmesg.

Regards,
Michal


