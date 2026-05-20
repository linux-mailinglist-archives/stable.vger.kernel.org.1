Return-Path: <stable+bounces-249746-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OGw/OtU/DWoxvAUAu9opvQ
	(envelope-from <stable+bounces-249746-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:00:05 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 592E7587A8A
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 07:00:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id B5926306124F
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 05:00:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D56C34DCC8;
	Wed, 20 May 2026 05:00:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bxKj4SLm";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="nGlB8jh4"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D69C91FECAB
	for <stable@vger.kernel.org>; Wed, 20 May 2026 04:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.133.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779253200; cv=pass; b=EqzQxohklTHN2NAT7KBB129sea3fZD6ED0yftpMAjRygnxwcSecxdr9aix2G6dIdSWr9fEVxB5fXj3/u1XgEgnnOoep6whdUvVJYFwRX+dQweLbV5Gva3gkeEEPOZDSNim+FTk/VQ5I+pl40GG1rnptVzgej2ae30wD73rrxBbo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779253200; c=relaxed/simple;
	bh=Z1uxCw3zZO9bUH+FnDZDKZ7GDL97GPj9FHdkLQxm17c=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NVOOYTaNmbWqQP69xFErc0GThL5/p4WMbszq3mLWq5CZr8AqbpUVC5HLDlGlLPabmqhAapb66ah13fu32RlnqCF6v7RwRgh+/GiUNPK1lmYZxsowuajgsIjxXjvFPNbqF4rhCMWArwRFPReluAZUpgxGDcS8aarG7/C+UycDah0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bxKj4SLm; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=nGlB8jh4; arc=pass smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779253196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4fXcXTMjN5E14vNudCgt+sQCbyj9NlGQvtVZAupleTM=;
	b=bxKj4SLmw5zgGNjyyPcayb/6VJEYR1vCkwJxNJwPKa9GjfTUdE5NQWrUttD3OZlSK0pffF
	5vO00rmL8aCIl90mdLFnIpbZpZ3gbryaEaSlQBhr33RdKzJjSHwWtTu8GJpRzUeohCTuYQ
	5b1lDsbJuXJ+KqLtzcnwKuF2WOwVKVU=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-A4grbUxHO6mHUyZAU1DGzQ-1; Wed, 20 May 2026 00:59:54 -0400
X-MC-Unique: A4grbUxHO6mHUyZAU1DGzQ-1
X-Mimecast-MFC-AGG-ID: A4grbUxHO6mHUyZAU1DGzQ_1779253194
Received: by mail-ot1-f69.google.com with SMTP id 46e09a7af769-7dcd9061254so12995506a34.0
        for <stable@vger.kernel.org>; Tue, 19 May 2026 21:59:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1779253194; cv=none;
        d=google.com; s=arc-20240605;
        b=JjgYVbdnpBx/6e3y/oMRMsl5eAe3cEpJo3KJCgwV3iwhOOKfxZ8AHnOGuMRMzNc4jk
         +809gQXLo4KS+I+YDeRYgpJDZS/E6Gpp/Rv863rj5l8ScUgc7cXgAiyhex38fOT3+zyr
         A2a7KpJjNGzN+w4hbnT31C4WkbxbVOp13L/v3r1+J0SiA8V3CovGq8S1rYxPLtmbN1d2
         UOstoT9AfCd0TJ5nmhX3WI0RUv/wnBijOUsi5mPDxQ9Ltp1GNKV8p5TTs9f1bM0WK+9S
         U+gKnq2rPt1ybb6U0mn196M+EYnB+SUAIbNIzbrnWnTyXcXnKpQCwtsNPC5kkqoeAQ0P
         iEKg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=4fXcXTMjN5E14vNudCgt+sQCbyj9NlGQvtVZAupleTM=;
        fh=NZUOKjAJEhMNM2LrTovODB1h3Vl/VAo2VYYm7qxIYlU=;
        b=kdTvbO4Woebxr6PNSetipzMGx/Pgb7f3LbN4YkEH5W0xYCb11GAUFwgOqMhvuTbMIn
         brSiEZ7wDOXREXcWuFWjcWMzt36tyxjBAUHfC1h3bV8uJ6OQSaVSoMNrt2F+qO4gEqtD
         DLESQlM34bOdI29a+mLXy4ueTUYGDMfiMusOugv+6BVBAKdp5zUbEJM4kNT0JV56MWXv
         /ZjySsv4FJllOdmGmGUM9we5JP/71f8+pMJwH8/XIyd6JOyFu84px85qngCMQFjDngrJ
         AwCMyIz86B7GIT5qnLY7tERyel2Vp9r5wDOZepu7S/8YKfQxulAp3J/qEXtKieqfl5oW
         +jGA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1779253194; x=1779857994; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4fXcXTMjN5E14vNudCgt+sQCbyj9NlGQvtVZAupleTM=;
        b=nGlB8jh4c3yoE+/TDBYLzZO9N/nWIpDcHR/e8cozpAq1H/j9SyY9gVPj4de3aE2mAl
         7Yn/HG7mzBgV+5f8oko4zJNTgpbDtmdL8AHAOeKmFIxedLZGHgVxrjXuUlXSbokhx1FE
         7onABLcKh6ZR4pOHncSfpU9Mn7plZIb1newuIoxU9AjO9407sc1kdHBP4osKHVvciitY
         9tzeXRg5Jyr7DWYmWPYfnwg2bg9l77HtYiPUSBbJw4IEKVMyDZd1HgHJ34kn4QtmWjoN
         +sJkwnahuS0agIkrA2J+AL/JEeTDbuTj9FtpsSa8hbKvUlz7L6i85VfO/Iv8hg0MjoD4
         CbXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779253194; x=1779857994;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4fXcXTMjN5E14vNudCgt+sQCbyj9NlGQvtVZAupleTM=;
        b=cvnzUbM1S5gR1aIvXe6c5KkgvemwTi6VoTj6PqVEqz8OUXU3g8FGQ15ARKrWpEfSt7
         9RHr4Ato7g4dyf3b9tiUtSuB/60Qm/ut+Rg+7G89oS/nNl5DT3ycXbVFKpDm0hAa8hsw
         HG1jxUzVNjfnNc02uiQfN14fiyWYM3B2YkYKfdER2//ZelQF1CSsMl/YRXAF7Ngnehjx
         ZuFQBcI2JuYGQ8rIMfoR1SDtlAmotw3t8SjShOCry/+XCj4d4KJ7J6sXiEB5etLqa4CD
         BofGZMH30kgG2POaLLIoIQDguaoa4IpHRQh0zirYyWNtWeP+5RxF9KU8KpxH9GOol+/4
         KlWQ==
X-Forwarded-Encrypted: i=1; AFNElJ/lc9FVtBl5x50NHldMXH2SnQgKSxIs+Lqx9L6zU4Xfp9PWQuPE5bpRynMS77gJ+J5cmljZwvU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwQf1MIcY7cdHeca0mYjwEpktMuCPiA0fZkvPmPkxOoo/0Xr0LY
	lMOaExCmYupF1lD2mKgJDzRKLyFAGR9BT8lbeLhQPtx4S5ug+q4EzWQmKXBQWueRV6PqA9MCt8S
	IdxrgxeTudZJA0WuDi6T3u4QW+h2RA9KBySSlp6sSeAyy9u/f84ffVstZNERpllAqV6GEIDORED
	3YIHu21Q5+4u1Auzq9/C9RGmwaolYObFS3
X-Gm-Gg: Acq92OHypI0/Eva7WcoAmu00bwkPCPPLMq5jOcy3G05nMLZUMRUNK/d5AsSGtrFSn2s
	XCd749Nzp/MfNTlY6MWDOUWbHK35NHa8ufjWsYKOT7z5J7zkt9/09WqjfSwggavVD7qEYaxwich
	r+zOMmjfp2cayD/ad7NJ+XGO7dev0MmIPIUbLYfEOHZHg4q4V7vV7aP04KtizV5I01ejXCLVEIj
	Y/XzN9bBZd//wuEwheY4xc2ZH90UflDb4Ry
X-Received: by 2002:a05:6820:83cc:20b0:696:6440:9e1d with SMTP id 006d021491bc7-69c94375914mr10102128eaf.39.1779253193326;
        Tue, 19 May 2026 21:59:53 -0700 (PDT)
X-Received: by 2002:a05:6820:83cc:20b0:696:6440:9e1d with SMTP id
 006d021491bc7-69c94375914mr10102111eaf.39.1779253192710; Tue, 19 May 2026
 21:59:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260430014817.2006885-1-desnesn@redhat.com> <20260430104850.352bd946.michal.pecio@gmail.com>
 <CACaw+exdPSVSfdAob7+d-xH=JEjBbPpY_z1cPPU6rzXx4wUZpA@mail.gmail.com>
 <20260430235453.2288c973.michal.pecio@gmail.com> <CACaw+ewwM_5eqyGW5=+THwHsYPs7u3NT096AFQdt6x4E6HcWtA@mail.gmail.com>
 <20260502114644.76e6b5a3.michal.pecio@gmail.com> <CACaw+eyKh7buHDoDyTOe8O65FP5cSXYdzCcQvwqKw=1DwX26oA@mail.gmail.com>
 <20260502235517.089ba5bf.michal.pecio@gmail.com> <CACaw+ewOTVh49tnkz+cRr0SD_Z-LmYrMWhFUrsik6YF83mPBtA@mail.gmail.com>
 <20260503071749.6abda137.michal.pecio@gmail.com> <CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
 <20260503213111.117db3a1.michal.pecio@gmail.com> <20260504093118.615ff480.michal.pecio@gmail.com>
 <20260518083339.507e24bd.michal.pecio@gmail.com>
In-Reply-To: <20260518083339.507e24bd.michal.pecio@gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Wed, 20 May 2026 01:59:41 -0300
X-Gm-Features: AVHnY4JM9tN7VvnDoYGL2EV7oJuiZYKknTxuDFWDnyY6Ey47mOlnQbcNTIJjp68
Message-ID: <CACaw+ewSWTo72fSk2Q7ZzCM8pNuyrX5ua+qA=SZOQuNNMKSA5Q@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249746-lists,stable=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[desnesn@redhat.com,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[redhat.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 592E7587A8A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello Michal,

On Mon, May 18, 2026 at 3:33=E2=80=AFAM Michal Pecio <michal.pecio@gmail.co=
m> wrote:
> > The chip IOMMU faults shortly after setting USBCMD.RUN =3D 1.
> > Such fault is expected to cause HSE assertion and usually it does.
> > You will probably find that HSE is already set while Enable Slot
> > is being queued, even if it was clear in xhci_gen_setup().

I've just read HSE at these places and confirmed that HSE was already
set even before queuing the enable slot trb, even though it was
previously clear in xhci_gen_setup().

Also, now digging more into the IOMMU debug messages, I have found out
that IOMMU also faults a Write of the network driver, prior to the
xhci Read fault:

=3D=3D=3D=3D=3D=3D=3D=3D=3D
# lspci | grep "80:1f.6\|80:14.0"
80:14.0 USB controller: Intel Corporation 800 Series PCH USB 3.1 xHCI
HC (rev 10)
80:1f.6 Ethernet controller: Intel Corporation Ethernet Connection
(19) I219-LM (rev 10)
=3D=3D=3D=3D=3D=3D=3D=3D=3D
...
   [Tue May 19 10:06:31 2026] PCI host bridge to bus 0000:80
   [Tue May 19 10:06:31 2026] pci_bus 0000:80: root bus resource [io
0x2000-0x8bff window]
   [Tue May 19 10:06:31 2026] pci_bus 0000:80: root bus resource [mem
0xb8000000-0xbdffffff window]
   [Tue May 19 10:06:31 2026] pci_bus 0000:80: root bus resource [mem
0x8000000000-0x9fdfffffff window]
   [Tue May 19 10:06:31 2026] pci_bus 0000:80: root bus resource [bus 80-df=
]
   [Tue May 19 10:06:31 2026] pci 0000:80:14.0: [8086:7f6e] type 00
class 0x0c0330 conventional PCI endpoint
   [Tue May 19 10:06:31 2026] pci 0000:80:14.0: BAR 0 [mem
0x8000200000-0x800020ffff 64bit]
   [Tue May 19 10:06:31 2026] pci 0000:80:14.0: PME# supported from D3hot D=
3cold
...
   [Tue May 19 10:06:31 2026] pci 0000:80:1f.6: [8086:550c] type 00
class 0x020000 conventional PCI endpoint
   [Tue May 19 10:06:31 2026] pci 0000:80:1f.6: BAR 0 [mem
0xb8100000-0xb811ffff]
   [Tue May 19 10:06:31 2026] pci 0000:80:1f.6: PME# supported from D0
D3hot D3cold
...
   [Tue May 19 10:06:32 2026] pci 0000:80:14.0: Adding to iommu group 20
...
   [Tue May 19 10:06:32 2026] pci 0000:80:1f.6: Adding to iommu group 29
   [Tue May 19 10:06:32 2026] pci 0000:81:00.0: Adding to iommu group 30
   [Tue May 19 10:06:32 2026] DMAR: Intel(R) Virtualization Technology
for Directed I/O
   [Tue May 19 10:06:32 2026] PCI-DMA: Using software bounce buffering
for IO (SWIOTLB)
   [Tue May 19 10:06:32 2026] software IO TLB: mapped [mem
0x000000003b000000-0x000000003f000000] (64MB)
   [Tue May 19 10:06:32 2026] ACPI: bus type thunderbolt registered
   [Tue May 19 10:06:32 2026] DMAR: DRHD: handling fault status reg 3
=3D> [Tue May 19 10:06:32 2026] DMAR: [DMA Write NO_PASID] Request
device [80:1f.6] fault addr 0x115106000 [fault reason 0x39] SM:
Present bit in Root Entry is clear
...
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: xHCI Host Controller
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: new USB bus
registered, assigned bus number 3
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: // Halt the HC
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Resetting HCD
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: // Reset the HC
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Wait for
controller to be ready for doorbell rings
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Reset complete
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Enabling 64-bit
DMA addresses.
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: HCD page size set to 4=
K
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Starting xhci_mem_init
=3D> [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Device context
base array address =3D 0x000000107513c000 (DMA), 000000002c3aab07 (virt)
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Allocated command
ring at 00000000ee0da32e
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Allocating
primary event ring
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Allocating 34
scratchpad buffers
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Ext Cap
00000000a35d82fb, port offset =3D 1, count =3D 14, revision =3D 0x2
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: PSIV:1 PSIE:2
PLT:0 PFD:0 LP:0 PSIM:12
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: PSIV:2 PSIE:1
PLT:0 PFD:0 LP:0 PSIM:1500
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: PSIV:3 PSIE:2
PLT:0 PFD:0 LP:0 PSIM:480
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: xHCI 1.0: support
USB2 hardware lpm
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Ext Cap
000000006d495f89, port offset =3D 17, count =3D 8, revision =3D 0x3
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: PSIV:4 PSIE:3
PLT:0 PFD:1 LP:0 PSIM:5
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: PSIV:5 PSIE:3
PLT:0 PFD:1 LP:1 PSIM:10
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: PSIV:6 PSIE:3
PLT:0 PFD:1 LP:1 PSIM:10
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: PSIV:7 PSIE:3
PLT:0 PFD:1 LP:1 PSIM:20
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Found 14 USB 2.0
ports and 8 USB 3.0 ports.
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Finished xhci_mem_init
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Starting xhci_init
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: xHC can handle at
most 64 device slots
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Setting Max
device slots reg =3D 0x40
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Setting command
ring address to 0x107513d001
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Doorbell array is
located at offset 0x3000 from cap regs base addr
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: // Write event
ring dequeue pointer, preserving EHB bit
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Finished xhci_init
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: hcc params
0x20007fc1 hci version 0x120 quirks 0x0000000200009810
=3D> [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: PATCHED
xhci_gen_setup: USBSTS: 0x00000001 HCHalted
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Got SBRN 50
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: MWI active
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Finished xhci_pci_rein=
it
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: supports USB remote wa=
keup
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: xhci_run
=3D> [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: ERST deq =3D 64'h107=
513e000
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Finished xhci_run
for main hcd
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: xHCI Host Controller
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: new USB bus
registered, assigned bus number 4
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Host supports USB
3.2 Enhanced SuperSpeed
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: supports USB remote wa=
keup
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Enable interrupts
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Enable primary interru=
pter
   [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: // Turn on HC, cmd =3D=
 0x5.
   [Tue May 19 10:06:37 2026] DMAR: DRHD: handling fault status reg 2
=3D> [Tue May 19 10:06:37 2026] DMAR: [DMA Read NO_PASID] Request device
[80:14.0] fault addr 0x1075140000 [fault reason 0x39] SM: Present bit
in Root Entry is clear
   [Tue May 19 10:06:38 2026] usb usb3: default language 0x0409
   [Tue May 19 10:06:38 2026] usb usb3: udev 1, busnum 3, minor =3D 256
   [Tue May 19 10:06:38 2026] usb usb3: New USB device found,
idVendor=3D1d6b, idProduct=3D0002, bcdDevice=3D 7.01
   [Tue May 19 10:06:38 2026] usb usb3: New USB device strings: Mfr=3D3,
Product=3D2, SerialNumber=3D1
   [Tue May 19 10:06:38 2026] usb usb3: Product: xHCI Host Controller
   [Tue May 19 10:06:38 2026] usb usb3: Manufacturer: Linux
7.1.0-rc3-30e0ff6d6a83.debug xhci-hcd
   [Tue May 19 10:06:38 2026] usb usb3: SerialNumber: 0000:80:14.0
   [Tue May 19 10:06:38 2026] usb usb3: usb_probe_device
   [Tue May 19 10:06:38 2026] usb usb3: configuration #1 chosen from 1 choi=
ce
   [Tue May 19 10:06:38 2026] xHCI xhci_add_endpoint called for root hub
   [Tue May 19 10:06:38 2026] xHCI xhci_check_bandwidth called for root hub
   [Tue May 19 10:06:38 2026] usb usb3: adding 3-0:1.0 (config #1, interfac=
e 0)
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: usb_probe_interface
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: usb_probe_interface - got id
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: USB hub found
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: 14 ports detected
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:00:0d.0: Get port status
2-1 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:00:0d.0: Get port status
2-2 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 000=
0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:00:0d.0: set port remote
wake mask, actual port 2-1 status  =3D 0xe0002a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:00:0d.0: set port remote
wake mask, actual port 2-2 status  =3D 0xe0002a0
   [Tue May 19 10:06:38 2026] hub 2-0:1.0: hub_suspend
   [Tue May 19 10:06:38 2026] usb usb2: bus auto-suspend, wakeup 1
   [Tue May 19 10:06:38 2026] usb usb2: suspend raced with wakeup event
   [Tue May 19 10:06:38 2026] usb usb2: usb auto-resume
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: standalone hub
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: no power switching (usb 1.0)
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: individual port
over-current protection
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: Single TT
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: TT requires at most 8 FS
bit times (666 ns)
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: power on to power good time: 20m=
s
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: local power source is good
   [Tue May 19 10:06:38 2026] usb usb3-port14: DeviceRemovable is
changed to 1 according to platform information.
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: trying to enable port power
on non-switchable hub
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-1 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-2 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-3 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-4 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-5 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-6 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-7 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-8 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-9 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-10 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-11 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-12 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-13 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
3-14 ON, portsc: 0x206e1
   [Tue May 19 10:06:38 2026] usb usb4: skipped 1 descriptor after endpoint
   [Tue May 19 10:06:38 2026] usb usb4: default language 0x0409
   [Tue May 19 10:06:38 2026] usb usb4: udev 1, busnum 4, minor =3D 384
   [Tue May 19 10:06:38 2026] usb usb4: New USB device found,
idVendor=3D1d6b, idProduct=3D0003, bcdDevice=3D 7.01
   [Tue May 19 10:06:38 2026] hub 2-0:1.0: hub_resume
   [Tue May 19 10:06:38 2026] usb usb4: New USB device strings: Mfr=3D3,
Product=3D2, SerialNumber=3D1
   [Tue May 19 10:06:38 2026] usb usb4: Product: xHCI Host Controller
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-1 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-2 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-3 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-4 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-5 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-6 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-7 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-8 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-9 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-10 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-11 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-12 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-13 read: 0x2a0, return 0x100
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-14 read: 0x206e1, return 0x10101
   [Tue May 19 10:06:38 2026] usb usb3-port14: status 0101 change 0001
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: clear port14
connect change, portsc: 0x6e1
   [Tue May 19 10:06:38 2026] usb usb4: Manufacturer: Linux
7.1.0-rc3-30e0ff6d6a83.debug xhci-hcd
   [Tue May 19 10:06:38 2026] usb usb4: SerialNumber: 0000:80:14.0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:00:0d.0: Get port status
2-1 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:00:0d.0: Get port status
2-2 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] hub 2-0:1.0: state 7 ports 2 chg 0000 evt 000=
0
   [Tue May 19 10:06:38 2026] usb usb4: usb_probe_device
   [Tue May 19 10:06:38 2026] usb usb4: configuration #1 chosen from 1 choi=
ce
   [Tue May 19 10:06:38 2026] xHCI xhci_add_endpoint called for root hub
   [Tue May 19 10:06:38 2026] xHCI xhci_check_bandwidth called for root hub
   [Tue May 19 10:06:38 2026] usb usb4: adding 4-0:1.0 (config #1, interfac=
e 0)
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: usb_probe_interface
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: usb_probe_interface - got id
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: USB hub found
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: 8 ports detected
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: standalone hub
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: no power switching (usb 1.0)
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: individual port
over-current protection
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: TT requires at most 8 FS
bit times (666 ns)
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: power on to power good time: 100=
ms
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: local power source is good
   [Tue May 19 10:06:38 2026] usb usb4-port1: peered to usb3-port9
   [Tue May 19 10:06:38 2026] usb usb4-port2: peered to usb3-port12
   [Tue May 19 10:06:38 2026] usb usb4-port3: peered to usb3-port8
   [Tue May 19 10:06:38 2026] usb usb4-port4: peered to usb3-port7
   [Tue May 19 10:06:38 2026] usb usb4-port5: peered to usb3-port10
   [Tue May 19 10:06:38 2026] usb usb4-port6: peered to usb3-port3
   [Tue May 19 10:06:38 2026] usb usb4-port7: peered to usb3-port4
   [Tue May 19 10:06:38 2026] usb usb4-port8: peered to usb3-port5
   [Tue May 19 10:06:38 2026] usb usb4: port-1 no _DSM function 5
   [Tue May 19 10:06:38 2026] usb usb4: port-1 disable U1/U2 _DSM: -19
   [Tue May 19 10:06:38 2026] usb usb4: port-2 no _DSM function 5
   [Tue May 19 10:06:38 2026] usb usb4: port-2 disable U1/U2 _DSM: -19
   [Tue May 19 10:06:38 2026] usb usb4: port-3 no _DSM function 5
   [Tue May 19 10:06:38 2026] usb usb4: port-3 disable U1/U2 _DSM: -19
   [Tue May 19 10:06:38 2026] usb usb4: port-4 no _DSM function 5
   [Tue May 19 10:06:38 2026] usb usb4: port-4 disable U1/U2 _DSM: -19
   [Tue May 19 10:06:38 2026] usb usb4: port-5 no _DSM function 5
   [Tue May 19 10:06:38 2026] usb usb4: port-5 disable U1/U2 _DSM: -19
   [Tue May 19 10:06:38 2026] usb usb4: port-6 no _DSM function 5
   [Tue May 19 10:06:38 2026] usb usb4: port-6 disable U1/U2 _DSM: -19
   [Tue May 19 10:06:38 2026] usb usb4: port-7 no _DSM function 5
   [Tue May 19 10:06:38 2026] usb usb4: port-7 disable U1/U2 _DSM: -19
   [Tue May 19 10:06:38 2026] usb usb4: port-8 no _DSM function 5
   [Tue May 19 10:06:38 2026] usb usb4: port-8 disable U1/U2 _DSM: -19
   [Tue May 19 10:06:38 2026] hub 4-0:1.0: trying to enable port power
on non-switchable hub
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
4-1 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
4-2 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
4-3 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
4-4 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
4-5 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
4-6 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
4-7 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: set port power
4-8 ON, portsc: 0x2a0
   [Tue May 19 10:06:38 2026] usbcore: registered new interface driver
usbserial_generic
   [Tue May 19 10:06:38 2026] usbserial: USB Serial support registered
for generic
   [Tue May 19 10:06:38 2026] hub 3-0:1.0: state 7 ports 14 chg 4000 evt 00=
00
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
3-14 read: 0x6e1, return 0x101
   [Tue May 19 10:06:38 2026] usb usb3-port14: status 0101, change 0000, 12=
 Mb/s
=3D> [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: PATCHED:
xhci_alloc_dev: B4 TRB_ENABLE_SLOT USBSTS: 0x00000015 HCHalted HSE PCD
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: // Ding dong!
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
4-1 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
4-2 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
4-3 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
4-4 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
4-5 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
4-6 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
4-7 read: 0x2a0, return 0x2a0
   [Tue May 19 10:06:38 2026] xhci_hcd 0000:80:14.0: Get port status
4-8 read: 0x2a0, return 0x2a0
...
=3D=3D=3D=3D=3D=3D=3D=3D=3D

> > 1001680000 is close to valid addresses like 100167e000 or 100167c000.
> >
> > Possible causes:
> > - xHCI or IOMMU driver bug

Since it happens on different drivers, it is starting to feel like
iommu bug that only happens in this kdump scenario.
However, init shouldn't be stuck waiting for the lock that hub kworker
task is holding.
The system should be able to reboot automatically after capturing the vmcor=
e.

> > - HW corrupted a pointer
> > - HW accessed something out of bounds
> > - HW dereferenced a stale pointer from the original kernel
> >
> > Do you happen to have more of those logs saved, are they all like that?

Since the last time we interacted, I lost access to the system and it
got formatted - no more old logs. However, I've got the system back
today and had some interesting developments.

> > Any chance that 1001680000 appears somewhere in the main kernel's log?

The fault addresses do not appear in the main log, nor anywhere other
than the DMAR fault addr messages in the crashkernel's log.

However, by comparing the previous log messages from the past kernel,
to the ones I saw with the new kernel I built today, I noticed the
same 8K displacement from the fault addr. Maybe an iommu driver bug
clue?

=3D 7.0.0-clean =3D

=3D> [Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: Device context
base array address =3D 0x0x000000100167c000 (DMA), 00000000d042f7e3
(virt)
=3D> [Fri May  1 09:46:40 2026] xhci_hcd 0000:80:14.0: ERST deq =3D 64'h100=
167e000
=3D> [Fri May  1 09:46:41 2026] DMAR: [DMA Read NO_PASID] Request device
[80:14.0] fault addr 0x1001680000 [fault reason 0x39] SM: Present bit
in Root Entry is clear

0x100167c000
0x100167e000
^
0x2000
v
0x1001680000

=3D 7.1.0-rc3-30e0ff6d6a83.debug =3D

=3D> [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: Device context
base array address =3D 0x000000107513c000 (DMA), 000000002c3aab07 (virt)
=3D> [Tue May 19 10:06:37 2026] xhci_hcd 0000:80:14.0: ERST deq =3D 64'h107=
513e000
=3D> [Tue May 19 10:06:37 2026] DMAR: [DMA Read NO_PASID] Request device
[80:14.0] fault addr 0x1075140000 [fault reason 0x39] SM: Present bit
in Root Entry is clear

0x107513c000
0x107513e000
^
0x2000
v
0x1075140000

> I see a certain lack of interest in finding the root cause of this.

Actually, I've just come back from a bereavement leave. During that
time I also lost access to the system which I got back today -
apologies for the radio silence.

> I have done a simple test on my own HW: writing bogus CRCR to cause
> IOMMU fault when the first command is submitted. I found that not all
> HCs reliably set HSE in this case, but obviously none of them ever
> complete the command properly.

Wow - good to know! I guess I would had expected to have HSE always
being set in these kind of situations in the command ring register.
Just out of curiosity, how did you figure out that only some HCs set
HSE? Tested on a few HCs or inferred that somehow?

> It seems that unconditional hc_died() on Enable Slot timeout may not be a=
 bad idea.

That was the idea of the original patch when I saw the HSE at that
point of the reboot sequence after the vmcore was captured.
However, different from my original patch, only one
XHCI_CMD_DEFAULT_TIMEOUT is enough (even tested a few weeks ago after
submission).

Now if we can't trust that all HCs will reliably set HSE on scenarios
like this one (iommu issues on the crashkernel?), the unconditional
hc_died() starts to feel like a safer approach.

> Makes me wonder if the same shouldn't apply to all commands
> besides Address Device, they typically only timeout due to HW issues.

In the past (commit c311e391a7efd101250c0e123286709b7e736249 "xhci:
rework command timeout and cancellation,") all commands used to wait
for a timeout of XHCI_CMD_DEFAULT_TIMEOUT - even Address Device.

>
>

PS: there was a big iommu PR a few days ago - all the results from on
this email were performed with a recent 7.1.0-rc3 kernel checked out
at 30e0ff6d6a83.

Best Regards,

Desnes


