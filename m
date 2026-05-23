Return-Path: <stable+bounces-253909-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YEMvI0dlEWr7lQYAu9opvQ
	(envelope-from <stable+bounces-253909-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 10:28:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B1CB5BDDA2
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 10:28:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B94C0301FA52
	for <lists+stable@lfdr.de>; Sat, 23 May 2026 08:28:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 842F634DB46;
	Sat, 23 May 2026 08:28:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfkhPQr/"
X-Original-To: stable@vger.kernel.org
Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D6F3537E8
	for <stable@vger.kernel.org>; Sat, 23 May 2026 08:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779524904; cv=none; b=CfE1hQc0V2K/ZSXttlDrfYiuPYjtvVMFcnOj5quiZUiRoW6WMBvSGhDxzpaGcD7mxOp7J6xcpu4+OkTA6Q8bj7yEtDAbckLkemLc6MyFZYLjl7QSIuH8vGacRtntNDS6URVIiIEbWCA3WHdod0acV5z9f1TqalM7Hxg1Du0vr8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779524904; c=relaxed/simple;
	bh=SJYthm/hJjyvZnHoxcP0FN011OD9BRe6ay27b+7gC+U=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jiXAhbWs0V3Jd4QQCPuZ2rIh+C5JMrRjpqRvFV7VD8suYGajfD0AA2nF3TmuyIRr0uvQNbc0eujUsgZ739fJqwpvO37y3QuIXkSqg4Fw8/siTEgtit7WHs+uTCPeShcfWv5QyDJwDPZnBGk5IaK7f1PXV/clsQEuP+BnsE+B5+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfkhPQr/; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-5aa21fa024cso5712341e87.2
        for <stable@vger.kernel.org>; Sat, 23 May 2026 01:28:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779524901; x=1780129701; darn=vger.kernel.org;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=EhmWhWD9464Uoh3KFvCuWff7V4Zp2a8qUYWAxJoJ59c=;
        b=HfkhPQr/smgQ0JTETyFkjiCEB5kJoXcBpyiy/8c58BQPRHfZ56uC5Afv9aSLcdlk7l
         qgCahylv+/WUSGOrrAGwuSEhKgWhbqlfQfEn29B+5K90EymTLQCcbdujzBxHzMiwKaN5
         8mKWSnJNXr/c7tQ/gbAOm8vrAs4uiVwBalq5Sz2BSoe3WcqxUpzIgsr/tljV682k08ug
         UiML6DUfxehgEo2bjKvnylPIqBWvSJy1CJCa2g6gVk41bwN2nrYKZPuYWxQ+474I0Luz
         gteiU5XXn+4jhBYRMaENtrUxm8ZjwWZLt06sypgyTE703erJAl/8ynM3c8twBiuiAUd9
         kBgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779524901; x=1780129701;
        h=mime-version:references:in-reply-to:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EhmWhWD9464Uoh3KFvCuWff7V4Zp2a8qUYWAxJoJ59c=;
        b=VHWz/cLTwqCMBfIs2aNmSBTraWkA9O/21gitEoNPg0/agUDHj+JQ6ZekwF1mIjWAkc
         wlWvQP2TodNTxlnRQrxFcxhWiBXV1iXfWTwtSozVhuJrx7D1atZmBQYgkeGHGpKRUzyY
         L5mgliSLaBrTQdw3MXgyNHAhts87tUtWykSZNQyy2PrA+W6VSmGoD0iRjTsiO6IjSt6j
         M5cv+4nWHFCQe9wzt4O9Wj8dwCPe/eNDkcOE/jR82bxML8K3c+ncVvc90ZuPtPTRWKfK
         K+4I4LO+MsxEApzJkZ3rrktSkmfgvdiGC4N1goJC8IrhcvwM96uRR4RhmABZ1vgyasxa
         ZbKQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dyGeU93zE7AvJTJtcnD1RzXTO/KnZbwnUrCh3+hnMSo9Ugx/wWwZDicYy15knNnelaWHFw40=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyek/pIUWxwDVcNHNB6QJwCIoD/c26qpqG2nD7aTjHqhRAOQ84F
	dpQtMeuyT+8pv3lzTIHEEt2CxnTbpb+WATbSOEYIyVZVg8OWcVAfMZPx
X-Gm-Gg: Acq92OEDLZ/DFawkUeLgaFrROEYpelC5OruhdOq/g8rPB6Rf00Ek2HCmUMJGdWy0P44
	1qdxnBXi58jsZX41yjYYfEOzdl4bM5YsmYgvhf+/cFU3a57bTnN1eeQtK/LigcrLlHC60NfpYlx
	4je9YfOFFRlEAhk6j/Meov3Tn8eZbzJDZ8P3AcWuoD9lLS/8Mk5OQhsX7ex4PGQJ+bijms4Tqkp
	kaA2EEtuu2aIZVV1waoMw/gseFhWQmHs+rEOoOBzQAtyVz+N4zN1at2RWrPAuWNzluOSdYt3jOG
	aIC1BFYwHiRG/x9TRyj+JKgfvXZGEdiYqWjX7JZHGWU7M42yrib6K/qXKqmqKIQeR93dE54kXp4
	ktsg1sE+RmPmH7r49SO+ZvhwsCGjCeRKKpgR1doc6n/E5ZYX4r4uC3ZBb0aGIGJ2tghQKp0nntA
	meydJC4xcJTu/dW09vCwJ7nCJSmd3V7cQN
X-Received: by 2002:ac2:5446:0:b0:5aa:126b:4504 with SMTP id 2adb3069b0e04-5aa323c4508mr1870160e87.23.1779524900655;
        Sat, 23 May 2026 01:28:20 -0700 (PDT)
Received: from foxbook (bfk48.neoplus.adsl.tpnet.pl. [83.28.48.48])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5aa32ceb27dsm995789e87.45.2026.05.23.01.28.19
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sat, 23 May 2026 01:28:20 -0700 (PDT)
Date: Sat, 23 May 2026 10:28:15 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on
 command timeout
Message-ID: <20260523102815.5c05c70a.michal.pecio@gmail.com>
In-Reply-To: <CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
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
	<20260523022944.59799d83.michal.pecio@gmail.com>
	<CACaw+exPdwXVsJc5Xr=vN1WJt8XR46=X0-8PP=+5dWY5zUrKeQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="MP_/8AsFH90U3UhJQJ44ORrK+_/"
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[multipart/mixed,text/plain,text/x-patch];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-253909-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+,1:+,2:+];
	DKIM_TRACE(0.00)[gmail.com:+];
	FREEMAIL_FROM(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	HAS_ATTACHMENT(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 1B1CB5BDDA2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

--MP_/8AsFH90U3UhJQJ44ORrK+_/
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

On Sat, 23 May 2026 00:47:28 -0300, Desnes Nunes wrote:
> Hello Michal,
>=20
> On Fri, May 22, 2026 at 9:29=E2=80=AFPM Michal Pecio <michal.pecio@gmail.=
com> wrote:
> > Sorry, I forgot about the most important thing: crash kernel log,
> > or at least the IOMMU fault message showing the bad address. =20
>
> I was indeed intrigued and almost sent it without you asking for it :-)
>=20
> The crashkernel's fault address is shown latter on down below, but now
> I have attached the full kexec dmesg too.
>=20
> PS: Note that the debugfs file 'memory' from before contains the
> addresses of the main kernel, not crashkernel's addresses:
>     - From main dmesg:
> [    6.728105] xhci_hcd 0000:80:14.0: Device context base array
> address =3D 0x000000010a958000 (DMA), 00000000f542e3ba (virt)
> [    6.737602] xhci_hcd 0000:80:14.0: ERST deq =3D 64'h10a95a000

Neither debugfs dump corresponds to this dmesg, addresses don't match.
And it doesn't look like the guard pages patch is working here.=20

But maybe it doesn't matter. Your "memory" files show a clear pattern
of consecutive page-sized allocations (example from after.zip):

102fb6000 DCBAA
102fb7000 CR
102fb8000 ER segmnet 0
102fb9000 ER segment 1
102fba000 ERST=20

We can make a guess that the faulting address is the ERST, which
definitely should be accessible to the host controller.

This simple patch logs ERST allocation and freeing; as far as I see
nothing else touches that mapping.

If the ERST is somehow freed before starting the HC, that's a bug.
Otherwise, it seems you were right that you have some IOMMU problem.

Regards,
Michal

--MP_/8AsFH90U3UhJQJ44ORrK+_/
Content-Type: text/x-patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=xhci-erst-alloc.patch

diff --git a/drivers/usb/host/xhci-mem.c b/drivers/usb/host/xhci-mem.c
index e76e321e119f..3f1e25bcb7ee 100644
--- a/drivers/usb/host/xhci-mem.c
+++ b/drivers/usb/host/xhci-mem.c
@@ -1815,6 +1815,7 @@ static int xhci_alloc_erst(struct xhci_hcd *xhci,
 					   size, &erst->erst_dma_addr, flags);
 	if (!erst->entries)
 		return -ENOMEM;
+	xhci_info(xhci, "alloc ERST at %pad\n", &erst->erst_dma_addr);
 
 	erst->num_entries = evt_ring->num_segs;
 
@@ -1867,6 +1868,7 @@ xhci_free_interrupter(struct xhci_hcd *xhci, struct xhci_interrupter *ir)
 				  ir->erst.entries,
 				  ir->erst.erst_dma_addr);
 	ir->erst.entries = NULL;
+	xhci_info(xhci, "free ERST at %pad\n", &ir->erst.erst_dma_addr);
 
 	/* free interrupter event ring */
 	if (ir->event_ring)

--MP_/8AsFH90U3UhJQJ44ORrK+_/--

