Return-Path: <stable+bounces-263712-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id SSlKO4hDMWq1fgUAu9opvQ
	(envelope-from <stable+bounces-263712-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:37:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F76C68F691
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 14:37:28 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=gmail.com header.s=20251104 header.b="FM/NYQm/";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263712-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-263712-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=none) header.from=gmail.com;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7D85731BD165
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 12:35:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6337361DCB;
	Tue, 16 Jun 2026 12:35:18 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D8D2C3248
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 12:35:17 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781613318; cv=none; b=WQFkHEA5KyFG5QugfQ5sSm2i6127mYMhV5Iqn7NQUjI3U9zgNbnQLR/YyGCpF46ENWKizsspIo/CJQN/q8Mc0yz68x2g2KPsJumYBbhsS1aHWxWl1/ZEq6blJ8SufRUzeahbmmU+1nj5eBPcLzsSDNKhbuhFG45sfMixf95CKBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781613318; c=relaxed/simple;
	bh=ETdUkWmUMOLSm7TtxUX69mqgYG8eFTikRfIxPw/5Ih4=;
	h=From:To:Cc:Subject:In-Reply-To:Date:Message-ID:References; b=MRcHDCoQBob/ukg6DtmSlbNqmOylXLcvoyRtCu189R4ccr5Pw1GsOPakJXMLF8A7z7QKlRMEwZXPG1XCGGobPjeaHvL5Qo/tUvSV+rxT1TXa/UMux8GgFjcs6AdlMJ2cFikamBSZMlmAmBQheV6G5lw8wV2pqPtSlbFa51WBI3k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FM/NYQm/; arc=none smtp.client-ip=209.85.210.177
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-842288702fbso2093087b3a.1
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 05:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781613317; x=1782218117; darn=vger.kernel.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=BAYzqTyjLrIOI8jk2lCoOCBWo5ysdxV0s0gT6irQrOA=;
        b=FM/NYQm/8LrA97/fvrCWZk6U4G4g4e9p9Z2mftaAOAGbVgp/b6qPHOYV3eNbgb68rv
         cUn0vjocNW2krYtwXTJO7XdKyKBuMdTtHXgWpyDfOuU2eYYjdMtFCywmtqPai4FVp9Bk
         bislPeYh4C2Pmaqfi/0fEFKsd1+mXYNg0noye+YUZw9vXSW4z6/a+PQdRcTxFgj+5XRm
         x4aHkNcIxIvNr/skAae4XqqjQ+GqyUgFYyuf56QGKquUQSpkSEbBZEAaPG/4ZfS8KaET
         isFV9ERBHQXhhMsLvJfJZdUPpSlabN7gT6MoppR84l3KUhHrmX9lh8eTZz5oLzT7ozbZ
         MNiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781613317; x=1782218117;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BAYzqTyjLrIOI8jk2lCoOCBWo5ysdxV0s0gT6irQrOA=;
        b=nT5sD7r43HrvSoK9/me/fauhsGN6o+Q++IPsuR5D73XWwIQ/4EeYqoRi6ofa0ST4V5
         E4F9MBSVtVqjlmuGP3SfZOMzw5wTWJODN8u8mmgKf5DipWGKhzduQSpx/hRdgYbzjdOW
         N5yTP59sYtjwu0GzCOf/7PEEFKHKFFo0uU8v3j/S9SsyDw9WiXco48S+j1ymd+IgU8jw
         BZee9zmyHWrm5pq1qOfDnqKH1413mjPnCkg+18K6ID80/OIKHr9Lci9W2a+pFCTE0ZK6
         B55ufm0f5OnA48pGX1gP3zhZzC367k9v7jK6U8hsEljeEQJ0vqGYMGGk3CmHx5Ta7pp9
         ZcGQ==
X-Forwarded-Encrypted: i=1; AFNElJ/dwXXKeha6zS863UZWv/OAST4BM9bn2Htrx2Bk7TSdkDBYFgwzLfcHYZg98e/S6WvfZrz2z00=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx533twW5BhV6JTqJ+SEAx/82KfiQzdP8graklAnYshP41ZOGTw
	/amrMSyTRwaMvU1oIlfgnASE+/QKIVCUqa1jB8gjbSCHJzBLQZWpCV+o
X-Gm-Gg: Acq92OGKhcLJ3vTOopzg/2kIBlBRqOIVyj2tIFAPs7J8gj1EhtM6efpkY+/hOrUHfNp
	q5DtkF8CYTELqQyRxVN6jPHWCUdxovYjFfGJqJ3mtDOqq6FmzbKL8niey3zUEmZjRu9QH7uR/I9
	0ncXjWEdOaVN9a/tuwcGf09mo6syEo+GMYa4a/9G7M93SPmcOgu5yq7vOJ9Y86HYoD3Qv2eC0eg
	iwohmk3Fd35jUjV7zQP/1GU9Ib7lgs9Z5mRiLijjdsgpGPMXxLxYm/PiIi9SZQN6K9JAt/aQCm9
	Wp6ivmXGNdFyvUaw+EOPwlzFRV7k+vt6YJgTf2x3uw3TVSzhfpBp5iC1hyVhELq9njtEmPNaf3K
	zlPyncw/EYwFph0W9CW5JmUvKBLPaMOc19hqqjCPLa165qrk80yV5BPSI1+YHBFPFV3dv3u5VK+
	sL7gWj++DxzTVA3jSWr+Nrd6sY2Q==
X-Received: by 2002:a05:6a00:8d6:b0:842:688f:3089 with SMTP id d2e1a72fcca58-8434ce832c2mr18655919b3a.30.1781613316626;
        Tue, 16 Jun 2026 05:35:16 -0700 (PDT)
Received: from pve-server ([49.205.216.49])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8434ac9c4c0sm11794275b3a.3.2026.06.16.05.35.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 05:35:15 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Amit Machhiwal <amachhiw@linux.ibm.com>
Cc: Amit Machhiwal <amachhiw@linux.ibm.com>, linuxppc-dev@lists.ozlabs.org, Madhavan Srinivasan <maddy@linux.ibm.com>, Vaibhav Jain <vaibhav@linux.ibm.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>, Anushree Mathur <anushree.mathur@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>, Mukesh Kumar Chaurasiya <mkchauras@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, stable@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] KVM: PPC: Book3S HV: Validate arch_compat against host compatibility mode
In-Reply-To: <20260616161011.835c90f0-38-amachhiw@linux.ibm.com>
Date: Tue, 16 Jun 2026 17:38:37 +0530
Message-ID: <a4suelh6.ritesh.list@gmail.com>
References: <20260609053327.61563-1-amachhiw@linux.ibm.com> <cxxqerzk.ritesh.list@gmail.com> <20260616161011.835c90f0-38-amachhiw@linux.ibm.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20251104];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263712-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[16];
	FREEMAIL_FROM(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[linux.ibm.com,lists.ozlabs.org,gmail.com,ellerman.id.au,kernel.org,redhat.com,vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:amachhiw@linux.ibm.com,m:linuxppc-dev@lists.ozlabs.org,m:maddy@linux.ibm.com,m:vaibhav@linux.ibm.com,m:harshpb@linux.ibm.com,m:anushree.mathur@linux.ibm.com,m:gautam@linux.ibm.com,m:mkchauras@gmail.com,m:npiggin@gmail.com,m:mpe@ellerman.id.au,m:chleroy@kernel.org,m:thuth@redhat.com,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[riteshlist@gmail.com,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4F76C68F691

Amit Machhiwal <amachhiw@linux.ibm.com> writes:

>> > diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
>> > index 3449dd2b577d..7472b9522f71 100644
>> > --- a/arch/powerpc/include/asm/reg.h
>> > +++ b/arch/powerpc/include/asm/reg.h
>> > @@ -1356,6 +1356,7 @@
>> >  #define PVR_ARCH_300	0x0f000005
>> >  #define PVR_ARCH_31	0x0f000006
>> >  #define PVR_ARCH_31_P11	0x0f000007
>> > +#define PVR_ARCH_INVALID	0xffffffff
>> 
>> Logical processor version is defined as part of the PAPR spec. We should
>> ensure that this invalid PVR is also documented in the PAPR spec.
>> 
>> If you have already taken care of that, then please confirm and feel free to add:
>
> Regarding the PAPR specification documentation: The PAPR spec documents
> the valid Processor Version Register (PVR) values for each processor
> generation (POWER8, POWER9, POWER10, POWER11, etc.). However, the
> PVR_ARCH_INVALID value (0xffffffff) introduced in this patch series is a
> KVM implementation detail used internally to mark invalid compatibility
> mode requests - it's not an architectural value that would be defined in
> PAPR itself.
>
> The validation logic and the use of PVR_ARCH_INVALID as a sentinel value
> are documented in the kernel code and commit message.
>

But that still worries me on what if PAPR wants to re-use this value for
some other purpose in future. 

BTW, thinking more about it, if we purely want this to be in kernel only,
can we instead add, something like:

     bool kpvr_compat;   /* Does kernel supports this PVR */

rather than re-using & overloading arch_compat which has values that
comes from PAPR spec?

Thoughts?

-ritesh

