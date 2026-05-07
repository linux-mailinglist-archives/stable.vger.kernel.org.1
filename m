Return-Path: <stable+bounces-244490-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id lGFBAfYN/Gl1KgAAu9opvQ
	(envelope-from <stable+bounces-244490-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:58:46 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id C50154E2BCB
	for <lists+stable@lfdr.de>; Thu, 07 May 2026 05:58:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id D423C300BBAE
	for <lists+stable@lfdr.de>; Thu,  7 May 2026 03:58:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E8AEC30FF1E;
	Thu,  7 May 2026 03:58:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b="q/yeivUQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEE2F3C18
	for <stable@vger.kernel.org>; Thu,  7 May 2026 03:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.125.188.122
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778126321; cv=pass; b=p/U62eXMSE2qWziibVZphj0fdqvCAUb9Zk32/kbR8wL9cgnJFdkVWqJUkxfWUhkINUTp6d7v26eEXnlfphkfGPtu+YXnbVHCUuQHwxuR+eJaz6oVx0VDGRRodFDYtQIfGyClANKJJRaByrtY2/naSlYwUt276wlsnqIL57IKVE4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778126321; c=relaxed/simple;
	bh=PkqqHhTDU2kKSizigUNNuogrZzCsb4MyJcq4kMxGR5w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ikyprmfPp7lW5Fr7GVgHN8qq1OBcZBityrTVEY9vlu0cNWRsBfEslkESZ78N6smZvAHloQixX+HnTA9C7HAzYCKUWeslQ0S5NqD3IOe6O6YLZ9nLNCOg0wFxcFMP2j+lk9XWOPOOIG4Bi3io3WNSYMSH1/YKgrEDHKammHYOjHM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com; spf=pass smtp.mailfrom=canonical.com; dkim=pass (4096-bit key) header.d=canonical.com header.i=@canonical.com header.b=q/yeivUQ; arc=pass smtp.client-ip=185.125.188.122
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=canonical.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=canonical.com
Received: from mail-yx1-f69.google.com (mail-yx1-f69.google.com [74.125.224.69])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 6C20E3FBF8
	for <stable@vger.kernel.org>; Thu,  7 May 2026 03:58:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
	s=20251003; t=1778126315;
	bh=ZlR7nQSAJNYWzlQHXwtepHIUtax32vskaI3RhwhSkmk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type;
	b=q/yeivUQVLdYHkh7sabBUd9LX3WwiNmNWLcEUCWFIXGpjqoyYL5zDLJLE4qFCwKDx
	 ovd+oRt2rvJxea9qEFxtG5ABhKJVWQYPnS9BHjiNcBUJkwng0Ebrtw3uUyzLpRgOEZ
	 LFzIdRpfKAdqkLqw5vlYLWcAT5xg4aR5VKaY4auusKSTjLiUUwKkBT5xjKg3BP8FUj
	 OHL0XXCzHbWUPdXVf057zF37O8Xa06xvjinRzLbr4mF1soy0sRQO1Hr+C7jiNOwnTP
	 rigqtWh98KIoarpRh8KB4rGB9Xc6l5DIQFlI0/xgWS3ICg/TrtJW0LhvRdN136qLGr
	 GCfNSz96IJXwaxjLHKL1fa4DEAeFQNVTejCH53KJAG/JDmsB1uWb22rzyRVXPYbVeU
	 UG1jzOXMbum80xEy50wf2xXPkAHHZgYkd+3ufmBwZVZmCC5+eaHJ5k9RCSMxksXSn/
	 3zFrhJi033dsOg3Xqe25IPH16vGuXle4xb3RFL/FxS+GjTnPQKM0381xOrg4zHCnJC
	 6wwBXqm6F3qtAOw4OX1B45sjvLy5BLAfoBhsKWeMpNjgwHYcNqAhTLxV+veL5qCNUz
	 y5KXhh0sz6WFHc776Fts5NWweOksqYhqX4NX8jZFBOl1dU7jLb8yBhEktOHb+nk3iY
	 5968S26c52Eob3XeVvoSLgh8=
Received: by mail-yx1-f69.google.com with SMTP id 956f58d0204a3-65c396d3940so111437d50.3
        for <stable@vger.kernel.org>; Wed, 06 May 2026 20:58:35 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1778126314; cv=none;
        d=google.com; s=arc-20240605;
        b=Nv0ZWKBncRTlBFTUR1iDRy2NTWZ8LBt7KFo80Zynkvk8MphvJ2xFTy9cqLzGpCoDb0
         0ypynFQxcraSKHKcPQq2K3ENnx3huxEZS5WxwnDRf/2nCIi/MIiHvAYJByKJ9UUWTCFb
         6ZYMKo4db6ov3wlPnpLFWvI5swYWZsrJ55TZw9QUMPNf5xGbSIKIWfWphCvQN8rwspxY
         M+P7rmJaCmHvdMNd6I5Lbvxh/xTyN/mZXLVCYLU2O5Mv6bBGv9d6XaL3I3mOS6hI34XL
         i9CkTEEDCsxBhW3FflXORWBq05UanhpemND8dV6/l2bK+pMQzGmvcFgIKT2ejv3P6NAc
         Qqmg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version;
        bh=ZlR7nQSAJNYWzlQHXwtepHIUtax32vskaI3RhwhSkmk=;
        fh=43DEoGqvOIi39drQrXvXtMLwn/RXo5GwloKGIpw8y7Q=;
        b=g19YAvKqXwxhUPMn3qIW+K4OafbOfFfZcfFzDuIXGR5P6ERTNZdhvzec+kJISB256N
         8ko6GErHH1u6bI/AMw9xq54VI3eCznUJ2nlj6BafpmoOO3OkXxDCbvSAbqioSVkiQbd4
         +aUEovENY65Usl4qWwzaBoJZq5RxIWLAoqNbBfMU+g9/xx6T6HgXcPpDJhZrLR7T121m
         Ko9criJdXvrhvR/pWx+3fBtMFvjKpp6Oqb8LlUQ+clAb9DQuYK6UqSejEy55R14Fd9+x
         ZKlA+Vcn4/MWm270jA3Knae2PsSebm3FO9tm3JMRWOPqizTMCGRpgVN+40PvO6ZhnEAr
         l3Zg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778126314; x=1778731114;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZlR7nQSAJNYWzlQHXwtepHIUtax32vskaI3RhwhSkmk=;
        b=P89Buyro+koPeuFX6bPeRy75Y8tEwAt3sVPWhXcGzXoHmmxoYiRv0xcCnDlSfskIec
         KUlKEWjTtI3yUjM/D8Z1tVKgkXgoxm8sN6utjl3Z+J2wP8tQw2PTgCnYnY6avgpinrCe
         uNmJj0TBh089gFXrI12IZE8e9FIsY9BOtnV4jC3erD3IgP8m5G20WtriFwIhv+oYmkVc
         ZgRorhj5ZZ8E7g30qNlRDBYmvGtKMYzD/dg7dlOnke2QGwe3+PQaER/5gbg9dfjL3x/O
         R+z4y3c9ypldUzU5nERWLtAKrLddDIjjttckoy5WgkwggwIuNBj+hVnNSdatQuqykWkI
         O8lw==
X-Forwarded-Encrypted: i=1; AFNElJ8LAGFrYWTRQeBsRkD/B/uH1xVAx7/S9ginNvgvStF6ia5dfo/P4SZmduKZuOGL2Z82CljlEC4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwgzMFZveRCJx28T0QH3vgUUaqQGJ4h7WmlAyxnk6VrgQ+L7W36
	+2jDd8R13m8TYkTJwOps4qPQ7c2BQlI8QmKU7GQyCypIrnc8iHO6DYEapM0IOw0eIM9OLNFkuDP
	paWwoFTI4MTPMq43P+kLih34c1D0h6hLLbCzZMlO3uacX30xhIRg9T6YwCGR0vMsrorkYCumvSc
	XPVba/lPnj17KkcZN0CvE81HXRc0stgsK6bgzPUBCz5ogcXp6q
X-Gm-Gg: AeBDietDFk0gN09m7o3f62D60iKMIBVOnyIVUpQ1I3kCdseqSClBNw32+lvI1HaMQXl
	EMMtk1MgQRIVEL6X7OcruK3NlBFspZqJYU2eay8WO9wHz50bxaR++nPTQKTus5PwKoA9z15P9My
	jZUVMJr7o54z2gaQQtVxMjSOdGTFFmV+EjrKNMvKikWdJ/pRdhYtK73PSI3EsTsceAEqOTbBJj4
	fPiOd4fq1sEXgEoZg==
X-Received: by 2002:a05:690e:4295:20b0:651:bc3b:75c7 with SMTP id 956f58d0204a3-65c7988e8f1mr5453989d50.11.1778126314071;
        Wed, 06 May 2026 20:58:34 -0700 (PDT)
X-Received: by 2002:a05:690e:4295:20b0:651:bc3b:75c7 with SMTP id
 956f58d0204a3-65c7988e8f1mr5453975d50.11.1778126313609; Wed, 06 May 2026
 20:58:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260505004846.193441-1-decui@microsoft.com> <SN6PR02MB4157A5A68BDBC87995FCE85FD43F2@SN6PR02MB4157.namprd02.prod.outlook.com>
 <SA1PR21MB69217F13193ADBD59430FB52BF3C2@SA1PR21MB6921.namprd21.prod.outlook.com>
In-Reply-To: <SA1PR21MB69217F13193ADBD59430FB52BF3C2@SA1PR21MB6921.namprd21.prod.outlook.com>
From: Matthew Ruffell <matthew.ruffell@canonical.com>
Date: Thu, 7 May 2026 15:58:21 +1200
X-Gm-Features: AVHnY4Lmno6AI9zMEcVbyQ9Bwv19XV5Ur5KJJsyVMwqC4jNwWBpl96SPBpb4Fy0
Message-ID: <CAKAwkKtUo5XX_Qh4hSYcbxTWkZP=+i0hZQaPHX78G20MFdz2Lg@mail.gmail.com>
Subject: Re: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving
 fb_mmio on Gen2 VMs
To: Dexuan Cui <DECUI@microsoft.com>
Cc: Michael Kelley <mhklinux@outlook.com>, KY Srinivasan <kys@microsoft.com>, 
	Haiyang Zhang <haiyangz@microsoft.com>, "wei.liu@kernel.org" <wei.liu@kernel.org>, 
	Long Li <longli@microsoft.com>, 
	"linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>, 
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, 
	"johansen@templeofstupid.com" <johansen@templeofstupid.com>, 
	"hargar@linux.microsoft.com" <hargar@linux.microsoft.com>, 
	"stable@vger.kernel.org" <stable@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: C50154E2BCB
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[canonical.com,reject];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[canonical.com:s=20251003];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[outlook.com,microsoft.com,kernel.org,vger.kernel.org,templeofstupid.com,linux.microsoft.com];
	TAGGED_FROM(0.00)[bounces-244490-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[canonical.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[matthew.ruffell@canonical.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[11];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,canonical.com:email,canonical.com:dkim,templeofstupid.com:email,outlook.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Action: no action

Hi Dexuan,

Thanks for making the amendments, and thank you Michael for all your reviews.

Since you posted the diff to the V3, I went and tested the V3 patch.

I have tested this patch on Azure with:
- Standard_D4ads_v5
- Standard_D4ads_v6

with the following images:
"Ubuntu Server 22.04 LTS - x64 Gen2"
"Ubuntu Server 24.04 LTS - x64 Gen2"

with the following kernels:
- 7.1-rc2 at 5862221fddede6bb15566ab3c1f23a3c353da5e1
- 7.1-rc2 at 5862221fddede6bb15566ab3c1f23a3c353da5e1 + the V3 patch

Without this patch, I could reproduce the issue on 22.04 + v6 based instance
types.

I can confirm that with this patch, v6 instance types can correctly kdump and
create a vmcore correctly and restart correctly without running into
MMIO issues.

I can confirm that with this patch, v5 instance types continue to operate the
same as they did previously.

Tested-by: Matthew Ruffell <matthew.ruffell@canonical.com>

Thanks,
Matthew

On Thu, 7 May 2026 at 13:11, Dexuan Cui <DECUI@microsoft.com> wrote:
>
> > From: Michael Kelley <mhklinux@outlook.com>
> > Sent: Wednesday, May 6, 2026 8:14 AM
> > > ...
> > > +                           /*
> > > +                            * If the kdump kernel's lfb_base is 0,
> >
> > Nit:  The case of lfb_base is 0 applies to kexec and kdump kernels, and also to
> > CVMs.
>
> Thanks for catching this! I'm going to post this v3 later today.
>
> --- v2-0001-Drivers-hv-vmbus-Improve-the-logic-of-reserving-fb_m.patch  2026-05-04 17:48:23.486911073 -0700
> +++ v3-0001-Drivers-hv-vmbus-Improve-the-logic-of-reserving-fb_m.patch  2026-05-06 18:03:42.922469286 -0700
> @@ -1,15 +1,15 @@
>  From 5d817788d65febdc0451e8a88277778794fe87b2 Mon Sep 17 00:00:00 2001
>  From: Dexuan Cui <decui@microsoft.com>
>  Date: Thu, 16 Apr 2026 04:30:21 +0000
> -Subject: [PATCH v2] Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on
> +Subject: [PATCH v3] Drivers: hv: vmbus: Improve the logic of reserving fb_mmio on
>   Gen2 VMs
>
>  If vmbus_reserve_fb() in the kdump/kexec kernel fails to properly reserve
>  the framebuffer MMIO range (which is below 4GB) due to a Gen2 VM's
>  screen.lfb_base being zero [1], there is an MMIO conflict between the
>  drivers hyperv-drm and pci-hyperv: when the driver pci-hyperv's
> -hv_pci_allocate_bridge_windows() calls vmbus_allocate_mmio() to get a
> -32-bit MMIO range, it may get an MMIO range that overlaps with the
> +hv_allocate_config_window() calls vmbus_allocate_mmio() to get an
> +MMIO range, typically it gets a 32-bit MMIO range that overlaps with the
>  framebuffer MMIO range, and later hv_pci_enter_d0() fails with an
>  error message "PCI Pass-through VSP failed D0 Entry with status" since
>  the host thinks that PCI devices must not use MMIO space that the
> @@ -31,7 +31,7 @@
>  Azure. I checked with the Hyper-V team and they said the statement should
>  continue to be true for Gen2 VMs). In the first kernel, screen.lfb_base
>  is not 0; if the user specifies a very high resolution, it's not enough
> -to only reserve 8MB: in this case, reserve half of the space below 4GB,
> +to only reserve 8MB: let's always reserve half of the space below 4GB,
>  but cap the reservation to 128MB, which is the required framebuffer size
>  of the highest resolution 7680*4320 supported by Hyper-V.
>
> @@ -42,7 +42,7 @@
>  Note: vmbus_reserve_fb() now also reserves an MMIO range at the beginning
>  of the low MMIO range on CVMs, which have no framebuffers (the
>  'screen.lfb_base' in vmbus_reserve_fb() is 0 for CVMs), just in case the
> -host might treat the beginning of the low MMIO range specially [4]. BTW,
> +host might treat the beginning of the low MMIO range specially [3]. BTW,
>  the OpenHCL kernel is not affected by the change, because that kernel
>  boots with DeviceTree rather than ACPI (so vmbus_reserve_fb() won't run
>  there), and there is no framebuffer device for that kernel.
> @@ -55,18 +55,20 @@
>  and the required framebuffer size exceeds 64MB (AFAIK, in practice, this
>  isn't a typical configuration by users), the hyperv-drm driver may need to
>  allocate an MMIO range above 4GB and change the framebuffer MMIO location
> -to the allocated MMIO range -- in this case, there can still be issues [3]
> +to the allocated MMIO range -- in this case, there can still be issues [4]
>  which can't be easily fixed: any possible affected Gen1 users would have
>  to use a resolution whose framebuffer size is <= 64MB, or switch to Gen2
>  VMs.
>
>  [1] https://lore.kernel.org/all/SA1PR21MB692176C1BC53BFC9EAE5CF8EBF51A@SA1PR21MB6921.namprd21.prod.outlook.com/
>  [2] https://lore.kernel.org/all/SA1PR21MB69218F955B62DFF62E3E88D2BF222@SA1PR21MB6921.namprd21.prod.outlook.com/
> -[3] https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com/
> -[4] https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com/
> +[3] https://lore.kernel.org/all/SN6PR02MB415726B17D5A6027CD1717E8D4342@SN6PR02MB4157.namprd02.prod.outlook.com/
> +[4] https://lore.kernel.org/all/SA1PR21MB69213486F821CA5A2C793C81BF342@SA1PR21MB6921.namprd21.prod.outlook.com/
>
>  Fixes: 4daace0d8ce8 ("PCI: hv: Add paravirtual PCI front-end for Microsoft Hyper-V VMs")
>  CC: stable@vger.kernel.org
> +Reviewed-by: Michael Kelley <mhklinux@outlook.com>
> +Tested-by: Krister Johansen <kjlx@templeofstupid.com>
>  Signed-off-by: Dexuan Cui <decui@microsoft.com>
>  ---
>
> @@ -104,6 +106,18 @@
>  Hi Hardik, I'm not adding your Reviewed-by since the patch changed.
>  Please review the v2.
>
> +
> +Changes since v2:
> +    Fixed the commit message:
> +        hv_pci_allocate_bridge_windows() -> hv_allocate_config_window()
> +
> +    Changed the "kdump" in the comment to "kdump/kexec or CVM" [Michael Kelley]
> +
> +    Fixed the order of the "[3]" and "[4]" in the commit message.
> +
> +    Added Krister's Tested-by.
> +    Added Michael's Reviewed-by.
> +
>   drivers/hv/vmbus_drv.c | 29 ++++++++++++++++++++++++++---
>   1 file changed, 26 insertions(+), 3 deletions(-)
>
> @@ -141,8 +155,8 @@
>  +                              pr_warn("Unexpected low mmio base %pa\n", &low_mmio_base);
>  +                      } else {
>  +                              /*
> -+                               * If the kdump kernel's lfb_base is 0,
> -+                               * fall back to the low mmio base.
> ++                               * If the kdump/kexec or CVM kernel's lfb_base
> ++                               * is 0, fall back to the low mmio base.
>  +                               */
>  +                              if (!start)
>  +                                      start = low_mmio_base;
>
>
> > Modulo my nit about the comment,
> >
> > Reviewed-by: Michael Kelley <mhklinux@outlook.com>
>
> Thanks a lot!

