Return-Path: <stable+bounces-242802-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ECQTMe1192kpiAIAu9opvQ
	(envelope-from <stable+bounces-242802-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 18:21:01 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A7894B668B
	for <lists+stable@lfdr.de>; Sun, 03 May 2026 18:21:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3528D300B13F
	for <lists+stable@lfdr.de>; Sun,  3 May 2026 16:20:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCB013C944A;
	Sun,  3 May 2026 16:20:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="axaZFjqw";
	dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b="JyM7ldch"
X-Original-To: stable@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D13437DEB3
	for <stable@vger.kernel.org>; Sun,  3 May 2026 16:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=170.10.129.124
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777825255; cv=pass; b=L4jlNDOzFTAgfoytMOhmWJ7l0VEBIay+ifwMUDzsq3cc4+/B8862pcCTPtC7qm4mOPNpWl7L8ALfEv4rgMDNAy+CQHupnPzwlNOIzKWSobFH+HnmzmTb+REnWjWsmKR7S3l6QStZFlTZ/HGlA7zs19heGxbLSS51J58VAJR8nVk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777825255; c=relaxed/simple;
	bh=+JUw3xFzxfcnQn2LyU3VEiPiL1RR8D225jMPuqflnaY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RkbQynY6ODO6bPPhjnz/P9bS+1PiQAtoapgXfD+2QQrJd5KmHcRtVpPfWsPLegZtQFbxbNt7cBhOgBtBT1qPH5/ghd8S0uG05SIxVx0sVF0JTJ7XQT/TIZbgDHIliiDeyFnwPp6l6a02BUw7hqbIHAXdrxMxy0+6N6DvqThtFck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=axaZFjqw; dkim=pass (2048-bit key) header.d=redhat.com header.i=@redhat.com header.b=JyM7ldch; arc=pass smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1777825253;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tjNv2iATyUiXeJoAczC85NxP0QWH5Ffzif2g7G+BF88=;
	b=axaZFjqwIDt0bOozhLVXLvVFadNnwehFML1miGTXT0CkCZUtzEDcXjsVuJcJTiLjcwPTGZ
	CVzQxNKmDfW3YUSeJMWZGmj3nzLq58nPmBGvdTQKdYJ7B7cdi2swVySiSW5/rTFkA5uqiM
	gLwBLeJXSNpSAXPye8QUZnKaAbqT2PQ=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-50sdprKENx6WhwwgG0QsIg-1; Sun, 03 May 2026 12:20:52 -0400
X-MC-Unique: 50sdprKENx6WhwwgG0QsIg-1
X-Mimecast-MFC-AGG-ID: 50sdprKENx6WhwwgG0QsIg_1777825251
Received: by mail-ot1-f70.google.com with SMTP id 46e09a7af769-7dbd60b7ecbso7479036a34.1
        for <stable@vger.kernel.org>; Sun, 03 May 2026 09:20:51 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777825251; cv=none;
        d=google.com; s=arc-20240605;
        b=aENGvB+VShmOWtUxiw9XgYE29Rh6t1L9rYUeSy7yuoBAuROMg1sZsno1LF0etxNd4Q
         ft0ggeBqHGYdKfOJN/0V9vGoUW65atkiGX+fIaZnjmCvv6BLoFomds1YOgN/cr5fKbJR
         pZBg7VEMzBLcEhWw7tIvclP1zmME1tDYcbcDl2iyQn5gft38raqiVHB4YJ9BnaKxkCxE
         L6QVP6f1nb7DnLc8tJJCbxRxvXU8XnzAd5Vbxl3uvoX7nmOt66TwsJOuWuSL3t+do9Kn
         DFZkCchi5TihHm6CneV2a2zmR/yTFVrR/E/C7J+KVZmToc2mUwvn7XBPgJH2Pp8ZMW1g
         Jl+g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=tjNv2iATyUiXeJoAczC85NxP0QWH5Ffzif2g7G+BF88=;
        fh=/SiqBJjqykXjiSrywxIt/thwvfKA6A8+Ewvnk0n2TGY=;
        b=E1EP2StCbPDPxKBMyUqMcnL4+HflRDDZoeLiALnCKS4NAI5gS2R6iciuqVYwyA9js7
         gMmCsZvASEuJAGoBk13i68xKsaIxvCPxyoXPqwsj7z+jv7r3mgXBVOoRbmMw4zmcblLd
         9Vs8lUcbFEVFXMKpwGHIQBp4+Mgx/lbIoxhN8di4C0cgPMSlQwtPg+oqSLsAf4e34tFW
         +OIDM6O+r/t+v/EnJBiWTSfBlsNZ+e0EAckXR4M40ay7IsD4lj8X2OOXxayHhfIaHF1J
         waM7yZWajT07wIeeUMTgCG2dI+UIe/vbXEuNKJVehjz0+3reA9rkWED3I1EbfF2EuE0D
         G3iQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=redhat.com; s=google; t=1777825251; x=1778430051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tjNv2iATyUiXeJoAczC85NxP0QWH5Ffzif2g7G+BF88=;
        b=JyM7ldcht7EJiecXXzkgfTQeLP8gHjd87aHKKSo82w8mbSAP87MtZkyuM7aL6lll6M
         39k6KpPIbRUPMQnspEeKbXjGRCb1Br/OxjlFF8vnAVpBGwh/W4kOP5y3M5GqMK6pYfWu
         3AVizBIKXdP8SEbFQjAeBkoRrtp282KCupVuiSUXj+Bvcg4F7EO3etCeRGbISCJhL1yv
         KgUY/yliJG/TY+m2hAIZSsjudW7pVtWZrvbl+OWkLx8f8UOMZJ9KrInn78gAzRhRex6P
         gvOzH2jou2mRfeQFp79zsiulg+j3o6MGi/IqVa6RDA+Dxzrt2/Vj7lM9ljz3Hlar7A/z
         hQCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777825251; x=1778430051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=tjNv2iATyUiXeJoAczC85NxP0QWH5Ffzif2g7G+BF88=;
        b=L+/Zeo0sPRfCTkW/k12zMTFopDz3YFvDT8CV/obs8uyIzMUEerkdcfgTcx1IoUimdD
         v4veraZRh7uLO9WhhR9wht/ESYOB0HkQgRkLDzlx8lbqRwS0n3/XSdGggrmY8CQzNdiu
         lWLQiJqnSwoh9Nz+LKAalJIAPN6EOw4BQsyQQUyiO+6bqcskETonxe3XsO8QXgDvifwN
         7mfYKHExbPy+jAW1dL/Rf6LkVqWHWAhqSRu6F8KFW6cuBGwmXx+GJ7UyEWeS/bmdcqQb
         FDSjIQrHr+obJZgx/t1AAbhqbwHaS7D7c/7D0tIZrI5aZGssuZyebK6IbvzEadMU6xkP
         JImw==
X-Forwarded-Encrypted: i=1; AFNElJ/162RJT0z4Y3iblbfIQ6F7zzBNaJMscLyyKrkIru0vuuXJ2XucDpVsq9Go3YZFpsGhpFQBjJ0=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlcueY2/zZUEG9Dcz/ZKMXAHJBhwNlUuXej7J2aWRQQCvGoBhP
	Qr29CQvXwoWG13CmYCWbcPs3MDtRng7gi3rvKnQ0NcU8WThSNR2TiK2Nju1unKXD/D0Dqg8Yhu+
	B72ZdjGEXv41XqitfL9FGIK51aoCcMIEauvz3SMB3JrW1FumFiD0uCSZY8OTD7sFyB1IOHE2Xso
	Na1qETSUAQwNX5MVLmG5CzKvFDDVZGKTWH
X-Gm-Gg: AeBDiev+NjiCiDocT9uuVGJjUDKRgyiBLVcd6HueKQ55Aho0lgQRFuy4fobUZn6orcG
	81NGyu0ARhIAueRZ4SB+GxiNqi2Op/t84PRJVkVg7VqlW6hq045Mq8mzyyUFLgs2vkhOplNaF2v
	M3+Uw0wJoQ4aCBMojH4O1Wn0V80BtDFt2WJTzOXpwPIbrXMraNnU3mDvBG+R/TDmzSZKKbM1TWG
	hzooyjAaQ4520MZArK2YfCmyCqdTwmlpkreNWsaUjlxvSYm
X-Received: by 2002:a05:6820:4df2:b0:694:9a0a:6fa9 with SMTP id 006d021491bc7-69697a0c93fmr3196538eaf.26.1777825251211;
        Sun, 03 May 2026 09:20:51 -0700 (PDT)
X-Received: by 2002:a05:6820:4df2:b0:694:9a0a:6fa9 with SMTP id
 006d021491bc7-69697a0c93fmr3196521eaf.26.1777825250800; Sun, 03 May 2026
 09:20:50 -0700 (PDT)
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
 <20260503071749.6abda137.michal.pecio@gmail.com>
In-Reply-To: <20260503071749.6abda137.michal.pecio@gmail.com>
From: Desnes Nunes <desnesn@redhat.com>
Date: Sun, 3 May 2026 13:20:38 -0300
X-Gm-Features: AVHnY4Jp9f-hyBW_keKzHgVPfBEME7pra3QHgYTJNcJvwmV4-uiqKN7yOcOrLW4
Message-ID: <CACaw+ew8uV5g1G-6qZGtVBEYZ3k+fvFrOq3XMyq-Nuhbq5mdnA@mail.gmail.com>
Subject: Re: [PATCH RFT RFC] usb: xhci: Kill hosts with HCE or HSE on command timeout
To: Michal Pecio <michal.pecio@gmail.com>
Cc: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	gregkh@linuxfoundation.org, mathias.nyman@intel.com, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Queue-Id: 0A7894B668B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719,redhat.com:s=google];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242802-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid]

Hi Michal,

On Sun, May 3, 2026 at 2:18=E2=80=AFAM Michal Pecio <michal.pecio@gmail.com=
> wrote:
> Well, that's weird. But it seems you have serial console enabled so
> I guess you should know whether it fails to start or crashes.

Yes, I have been checking all boots and crashes through the serial console.

> It could show on the main kernel before the panic is triggered, if the
> main kernel was patched too. Maybe they are the same kernel binary?

Yes, same patched binary on the main kernel and kdump kernel.

> I'm trying to come up with any conceivable theory how patching xhci-hcd
> could prevent the kdump kernel from loading. Still no idea...

Just found the reason: with the installation of this last kernel, my
/boot partition got filled. Thus, the initframs image was not actually
getting copied to /boot.

After removing a few test kernels, kdump armed normally, collected a
vmcore and no hangs due to the locks of xhci_alloc_dev() or
device_shutdown() appeared.

So, I confirm that this patch, which checks for HSE or HCE indeed
fixes the bug, without having to rely to a
wait_for_completion_timeout():

# grep -i HSE -A5 kexec-dmesg.log
[Sun May  3 11:37:36 2026] xhci_hcd 0000:80:14.0: Command timeout,
USBSTS: 0x00000015 HCHalted HSE PCD
[Sun May  3 11:37:36 2026] xhci_hcd 0000:80:14.0: kill the damn thing
[Sun May  3 11:37:36 2026] xhci_hcd 0000:80:14.0: xHCI host controller
not responding, assume dead
[Sun May  3 11:37:36 2026] xhci_hcd 0000:80:14.0: HC died; cleaning up
[Sun May  3 11:37:36 2026] xhci_hcd 0000:80:14.0: Error while
assigning device slot ID: Command Aborted
[Sun May  3 11:37:36 2026] xhci_hcd 0000:80:14.0: Max number of
devices this xHCI host supports is 64.

Best Regards,

Desnes


