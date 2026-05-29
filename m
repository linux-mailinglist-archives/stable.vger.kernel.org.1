Return-Path: <stable+bounces-256639-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MBoXF3ycGWq7xwgAu9opvQ
	(envelope-from <stable+bounces-256639-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:02:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD85560335A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 16:02:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 18CB8301C12A
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 13:59:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3835A3438BA;
	Fri, 29 May 2026 13:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="P+SGP86L"
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f202.google.com (mail-pl1-f202.google.com [209.85.214.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D557525782D
	for <stable@vger.kernel.org>; Fri, 29 May 2026 13:59:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780063167; cv=none; b=DfZYgYSPTXhrbLIV6erQYvj7RSVsnHrp4wzTw9tpW9bijXKSfS/iuFzrrtbLnjeMqupK/ZNbWK2xBng9MbvIkwURAZlJ7S95wEKts1TDkho5aYop4y42iw0BfwmGpqmCkYpO/MvWPMUWdeMaxfK0fyYfyj4i55gk7JECp+kHn6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780063167; c=relaxed/simple;
	bh=9HqZNwsNG1F1vtCVm3KrwBhzoVWHvN278IIZISdmlTU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=nT0AVbShCUkGG5GMC0ZkOM1Qj0GLW1UpwsLZTrK3Vh7IKxB45CL4BMqh5ookFDbk3ih/GxyFSv2vYw9jYQC+r5yHZpGYqVyIVP5CzVG3ybpaqBGfB/81MC8b4t9FxPpnXbzDlnspxWZ9HACmw/m91CZ3htX8ncMjVLK2tsYhSXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=P+SGP86L; arc=none smtp.client-ip=209.85.214.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Received: by mail-pl1-f202.google.com with SMTP id d9443c01a7336-2bc6899bfb1so151568985ad.2
        for <stable@vger.kernel.org>; Fri, 29 May 2026 06:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1780063165; x=1780667965; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KxhLxwcFvH/MI0JZc5MSAm4YaLXkHF02XbmM1toWiqM=;
        b=P+SGP86LAtGuF9KVaoG18G1E61lpaGjJa6fq5OT+7VzFy/yx5iSLFLR7P4r7rehkeV
         NQti62dh70uA/kyHeCt0441CSzVTLhk3pKLtDpmjHY4cdq7czqNxC4vrWLD1gMzk8Tbf
         lTY+U39vG9471sTCtPiF4YT0j8KY+DeMd26x+81jS5FLWvixpVcXB5GTWRXP/lmb6KSw
         zU8O0RCyLV/wYughaBaDh/IZzmvqrY0AbDobxSqLKMbDFoV90m4jGAO16UqPX5Z3HXwI
         h81dw3jkwSlXFUfu3uL5VEWQgrT3j9U7xEeLIdRawSCQ79ynKW/m6rQOcmX5ojcjdeLZ
         NlLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780063165; x=1780667965;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=KxhLxwcFvH/MI0JZc5MSAm4YaLXkHF02XbmM1toWiqM=;
        b=UslAXPXYWM7TkzasupQ+d4wpuUQgYDgQFmgUB+VPqf8UY3aNUuLZUDq8KkLu2bjTNU
         dOVwny8LZLFHF1CiW6iNbdPVbvria0EquN2LeqUSBQbbcMknRXflUIqgw1aI2xz3zDhZ
         hDQEDO6h50vg5qe3N2CuRJJbIeKnnIypH+IPt0O4NvtMIoutluGDfyjY66q2NSTQ++GA
         Zd/YofFY+E+vQcjQ4695iNl72LCOA7f/ovrBA7vEUPacPdbUpSKDf9iDoQGARqSNK+7K
         yx8Z7iD1IkewHD2SaqsGosZqdnQj/EAHk9jVBfuGSuPypF852cKquNLF9vh6+fm0oSZj
         BTsg==
X-Forwarded-Encrypted: i=1; AFNElJ8iIAkZZHyKi0cwDicq+ILr7GVvd4ZWK2oFShOPty6tbcfXSBz5MjRzISZc0shnIDPNIV40df8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwG3WlkqtE92bJe6WKdSf7gRn1vHgQKYmpTNqhFyrT/bWRKjl8p
	YUaHOFf015wF5a9wSRD7aMNyUlk3zSQJ0CLSqbpg67wSvPm1Tt6VrROMR1YRQ3lXQ4nbCpxAyJX
	B2a0kUg==
X-Received: from plho6.prod.google.com ([2002:a17:903:23c6:b0:2bc:bdcd:c51f])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:902:da4d:b0:2bf:1cd7:1855
 with SMTP id d9443c01a7336-2bf2099fd54mr37529405ad.20.1780063164851; Fri, 29
 May 2026 06:59:24 -0700 (PDT)
Date: Fri, 29 May 2026 06:59:24 -0700
In-Reply-To: <99613b74-44db-4233-9480-26cc04bc0c7b@suse.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260529091714.287963-2-clopez@suse.de> <ahmTjp-95M5IjGxu@google.com>
 <99613b74-44db-4233-9480-26cc04bc0c7b@suse.de>
Message-ID: <ahmbvDGHvORqofrj@google.com>
Subject: Re: [PATCH] KVM: x86: Take PIC lock on KVM_GET_IRQCHIP path
From: Sean Christopherson <seanjc@google.com>
To: "Carlos =?utf-8?B?TMOzcGV6?=" <clopez@suse.de>
Cc: kvm@vger.kernel.org, pbonzini@redhat.com, stable@vger.kernel.org, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, 
	"maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Avi Kivity <avi@qumranet.com>, 
	Qing He <qing.he@intel.com>, "Yaozu (Eddie) Dong" <eddie.dong@intel.com>, 
	Marcelo Tosatti <mtosatti@redhat.com>, 
	"open list:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[google.com,reject];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[google.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256639-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	DKIM_TRACE(0.00)[google.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[seanjc@google.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CD85560335A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Fri, May 29, 2026, Carlos L=C3=B3pez wrote:
> On 5/29/26 3:24 PM, Sean Christopherson wrote:
> > On Fri, May 29, 2026, Carlos L=C3=B3pez wrote:
> >> When userspace issues the KVM_SET_IRQCHIP ioctl to set the state of
> >> the PIC, kvm_vm_ioctl_set_irqchip() grabs @kvm->arch.vpic->lock before
> >> updating the state. However, the KVM_GET_IRQCHIP ioctl to retrieve the
> >> same PIC state does not grab such lock, potentially causing torn reads
> >> for userspace.
> >=20
> > Meh, if userspace hasn't fully paused the VM, save/restore is going to =
fail
> > anyways.  Heck, torn reads is probably _better_ than the alternative, b=
ecause
> > at least that might cause visible failure during the restore.  If there=
 are
> > concurrent modifications in-flight, then KVM_GET_IRQCHIP is going to re=
turn
> > stale data (assuming userspace doesn't redo KVM_GET_IRQCHIP), i.e. save=
/restore
> > will effectively corrupt the guest.
>=20
> Right, do you want a v2 to at least prevent userspace from reading a
> torn state? It seems wrong to have this asymmetry with KVM_SET_IRQCHIP
> and other save/restore ioctls (e.g. KVM_{G,S}ET_PIT).

Yeah, please send a v2.  I 100% agree there should be symmetry, which is wh=
y
it's tempting to drop the locks for SET :-)

