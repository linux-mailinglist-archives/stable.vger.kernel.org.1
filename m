Return-Path: <stable+bounces-242860-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yPprNcdL+GmQsQIAu9opvQ
	(envelope-from <stable+bounces-242860-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 09:33:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 330724B9614
	for <lists+stable@lfdr.de>; Mon, 04 May 2026 09:33:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 640843009144
	for <lists+stable@lfdr.de>; Mon,  4 May 2026 07:31:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B8DD2EA171;
	Mon,  4 May 2026 07:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W9ZSuEah"
X-Original-To: stable@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5897B2BEC27
	for <stable@vger.kernel.org>; Mon,  4 May 2026 07:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777879888; cv=none; b=PQKeZGysh3EqTQuv14I7XQRExSZLDCwuA2z0yTJETNT14uYz8EENk31DjPkI8xhx0f4aeIXeqQHnFrMw6OjzGwak7agn+GsxDaRNojPXqZytWoLD4961cVhye4tCO70jWssjN5aOGqS+1IhDt9+L3FvHdsMmcQiMtEmjywe3VMk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777879888; c=relaxed/simple;
	bh=YSB5SQmQmqXs7OoK/OoQ5a2W1FhgmfKgwxP5ajgxFU8=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ru3SaYlTwSuE1MIQaQ5EwyBujpUf/aw8g8d5SMoc/9sO2ABVabSj+eE8SPczApumFdf94WXCZd6kwxybBWWM0fiWfKI3BRbQSA0IYtB7ABd1vj6ynzSEt/0o57k5cE/vkc/vUlIEhsK17b+v0Dn3Gj+UPNrk6pj44lwpRv0P3Os=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W9ZSuEah; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-488a14c31eeso26713015e9.0
        for <stable@vger.kernel.org>; Mon, 04 May 2026 00:31:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777879885; x=1778484685; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CatfaxbBgZQ3LQXPfEhaZbjDP184rQ7dewMd5HLOFbs=;
        b=W9ZSuEahfN+B27Yo/Iq8SyYIpXBgHgdkFI1IiU9mGjuWuUnjxqrOyg6Sp/vLNgFv5O
         euqVDJd7SxJjtUSFuT8hw6rsRgy76NWA0Xv29/1LH+XdChBmyS12v7gTZHw3DkHW7B5F
         sFMIt0vjOST37CkFyTECbWYSLZxIeOOw/uV8hIksP1bLyp8cDJg6lFA8fwrURCZMENB5
         zOxNqha0831z7dO1oF1WI3dNB3WJ56rS7ZJfVxZvGVVKxrg+AnZ9dB5kUowqKYDaGP3Y
         pbgneJXhy5Ri8OhG9BMczOSjDqv9yWfTyKCODqyn8KNvZe0HYjylr0ZLjOQAcsp8nl8F
         VVcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777879885; x=1778484685;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=CatfaxbBgZQ3LQXPfEhaZbjDP184rQ7dewMd5HLOFbs=;
        b=bWrpD9S8koCWle/ggpBUFwuyYJ2dGEWHQg+SFAfvQyF4Zo3ksE9c+K08HGBwrkfRDH
         oqmKzmr5deyLQpywpPLW26oOYxGCamWPJ5seUI9WFOD3kf6wazGq0D+8VsHKGyPKmbtn
         ICDp8dr4YwlC4SrOE4gBIRnsg5nvCX67omhjP9Uge32z5jPQ7VgTcajAqce8PasaYm93
         NgU+uKdGRC2jxDETUndd8WDw2ZrovJ1+YK9fn4zBhmJ/z0rSysxqskJj39YjhgolK8pu
         /Gfy5SoUyvoUyTBFdSOLmqtUbZO61P5qSyi64Kh9+34WNkkzyr9MGi5FRJddBg909jBl
         z/Yg==
X-Forwarded-Encrypted: i=1; AFNElJ/gdixoDQs8wKSquPIVmPa/S3bQmAl87LikIfWnfJSUKVQMrm/5D94gx+ouEoD/UYhJHAfpKoc=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw0PMtiJV/rvYniyytoUzn1FAYpyw/ArdVmqSh1/SdEBY/zvZdk
	AhGY1YLM2UMoYmwfy/MVY/Yzr/S6qq1WECDS8OIZ3SDBJfMDOAq1TKf/Ml6f1g==
X-Gm-Gg: AeBDies3aUnX04dt2zpnoAflfOX+S+SNl8cKY16edyh4PC0VjYn0wbMahLhLBW4+HhL
	+KnCkTvxzVB7DI+QtbfAlw1m+tcsAEM3HO2a0iqhz4kLzXeUrAnjIAOOEaCTB2Pw+DgohHWHCP6
	2beVfWy9ZbOgfrvr61D08xdW27LSYC/ls4c5CQoKOPzbSGDc2to3RW6yN8DoaiLkzjy4xJ1qriz
	X+uctCzW29F4xAvY+ZUXP9bI7Wnq4/IFs40/GwXzCc1Ycww98DgJrRiYVsgixLK/CM+XYG9p/gL
	kLVznFEEyaKV0TEqgpOd8JytHHegoL8YvvEL6qalUEEHsO84KHXEyydMjJmL8T3MxzP2gBTFO1b
	+k+/MH2Tk+wnzsrfp3HfTzzcYn70cSvc7XjZ86vcyAK3uS/Y7eISoo6JuhiEc7f8OUE8UfVGqky
	5GmFnJZdN2yCdATE9+GRewKZKHmd/iK1o=
X-Received: by 2002:a05:600c:4342:b0:485:2a85:e5ec with SMTP id 5b1f17b1804b1-48c6d455f69mr68059795e9.2.1777879884339;
        Mon, 04 May 2026 00:31:24 -0700 (PDT)
Received: from foxbook (bgt227.neoplus.adsl.tpnet.pl. [83.28.83.227])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48a82308d77sm355839375e9.14.2026.05.04.00.31.23
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Mon, 04 May 2026 00:31:24 -0700 (PDT)
Date: Mon, 4 May 2026 09:31:18 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: Desnes Nunes <desnesn@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
 gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on
 command timeout
Message-ID: <20260504093118.615ff480.michal.pecio@gmail.com>
In-Reply-To: <20260503213111.117db3a1.michal.pecio@gmail.com>
References: <20260430014817.2006885-1-desnesn@redhat.com>
	<20260430104850.352bd946.michal.pecio@gmail.com>
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
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Rspamd-Queue-Id: 330724B9614
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-242860-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[michalpecio@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6]

On Sun, 3 May 2026 21:31:11 +0200, Michal Pecio wrote:
> My first wild guess would be that HSE is caused by resetting IOMMU
> while the xHC is unaware of kexec and continuing to DMA old buffers.
> Attached patch checks for this and also tries to explicitly clear
> HSE, although resetting ought to clear it too. But HW has bugs...

Never mind, here's the smoking gun:

[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xHCI Host Controller
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: new USB bus
registered, assigned bus number 3
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: // Halt the HC
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Resetting HCD
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: // Reset the HC
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Wait for controller
to be ready for doorbell rings
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Reset complete
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Enabling 64-bit DMA addresses.
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Calling HCD init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Starting xhci_init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: HCD page size set to 4K
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Device context base
array address = 0x0x000000100167c000 (DMA), 00000000d042f7e3 (virt)
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Allocated command
ring at 0000000016f013a6
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: First segment DMA is
0x0x000000100167d000
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Allocating primary event ring
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Allocating 34
scratchpad buffers
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Ext Cap
000000001bef6947, port offset = 1, count = 14, revision = 0x2
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:1 PSIE:2 PLT:0
PFD:0 LP:0 PSIM:12
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:2 PSIE:1 PLT:0
PFD:0 LP:0 PSIM:1500
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:3 PSIE:2 PLT:0
PFD:0 LP:0 PSIM:480
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xHCI 1.0: support
USB2 hardware lpm
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Ext Cap
00000000a5bcc554, port offset = 17, count = 8, revision = 0x3
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:4 PSIE:3 PLT:0
PFD:1 LP:0 PSIM:5
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:5 PSIE:3 PLT:0
PFD:1 LP:1 PSIM:10
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:6 PSIE:3 PLT:0
PFD:1 LP:1 PSIM:10
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: PSIV:7 PSIE:3 PLT:0
PFD:1 LP:1 PSIM:20
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Found 14 USB 2.0
ports and 8 USB 3.0 ports.
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xHC can handle at
most 64 device slots
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Setting Max device
slots reg = 0x40
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Setting command ring
address to 0x100167d001
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Doorbell array is
located at offset 0x3000 from cap regs base addr
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: // Write event ring
dequeue pointer, preserving EHB bit
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Finished xhci_init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Called HCD init
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: hcc params
0x20007fc1 hci version 0x120 quirks 0x0000000200009810
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Got SBRN 50
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: MWI active
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Finished xhci_pci_reinit
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: supports USB remote wakeup
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xhci_run
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: ERST deq = 64'h100167e000
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Finished xhci_run for main hcd
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: xHCI Host Controller
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: new USB bus
registered, assigned bus number 4
[Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Host supports USB
3.2 Enhanced SuperSpeed
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: supports USB remote wakeup
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Enable interrupts
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: Enable primary interrupter
[Fri May  1 09:46:41 2026] xhci_hcd 0000:80:14.0: // Turn on HC, cmd = 0x5.
[Fri May  1 09:46:41 2026] DMAR: DRHD: handling fault status reg 2
[Fri May  1 09:46:41 2026] DMAR: [DMA Read NO_PASID] Request device
[80:14.0] fault addr 0x1001680000 [fault reason 0x39] SM: Present bit
in Root Entry is clear

The chip IOMMU faults shortly after setting USBCMD.RUN = 1.
Such fault is expected to cause HSE assertion and usually it does.
You will probably find that HSE is already set while Enable Slot
is being queued, even if it was clear in xhci_gen_setup().

1001680000 is close to valid addresses like 100167e000 or 100167c000.

Possible causes:
- xHCI or IOMMU driver bug
- HW corrupted a pointer
- HW accessed something out of bounds
- HW dereferenced a stale pointer from the original kernel

Do you happen to have more of those logs saved, are they all like that?
Any chance that 1001680000 appears somewhere in the main kernel's log?

If not, I suppose we will have to log every single DMA mapping created
by the driver and see if this gives any new clues.

Regards,
Michal

