Return-Path: <stable+bounces-217575-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IkKFA5fmGnzHAMAu9opvQ
	(envelope-from <stable+bounces-217575-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 14:18:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C043C167BF0
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 14:18:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1BCB4302F41F
	for <lists+stable@lfdr.de>; Fri, 20 Feb 2026 13:16:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34A7E2D8382;
	Fri, 20 Feb 2026 13:16:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b="eaazT5cT"
X-Original-To: stable@vger.kernel.org
Received: from mailrelay.tugraz.at (mailrelay.tugraz.at [129.27.2.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 195E613E41A;
	Fri, 20 Feb 2026 13:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.27.2.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771593416; cv=none; b=fg5V8ga8ny6CWP1OD7eoGZZ0W0mjyPD4KJ49e4jRHwIgBjH+GQSdXedFGLK5luUszseD7I0dwMSmdYJT6izCGWJ9gzh6WbreYrdAzwVwZqPZQ7dg2EIWEMMzsSerKJN7iEd5JOLoH9YNQPG4AAgvLWx8G3haelFbmW/6GteikxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771593416; c=relaxed/simple;
	bh=aTWwcMaHAewOUgIPXjFl8UHorrMJKcNe6bG06jNwkec=;
	h=Mime-Version:Content-Type:Date:Message-Id:From:To:Cc:Subject:
	 References:In-Reply-To; b=gKL9Zzn2Iq95GhEgFakHRUKo3PEBSqkxjAwOaM08m4yd0zh3oprV4MxuRh8DKWP+N9gKIMmTivu4ucycXZyknF+EXP+dEoSB2GFoO4OPPscDqdBhX9CQ/6/FGpOeby8ytynKHsksSQaKhe8maHLsiqwAerCGcmlLZ0ROLXfhMww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at; spf=pass smtp.mailfrom=tugraz.at; dkim=pass (1024-bit key) header.d=tugraz.at header.i=@tugraz.at header.b=eaazT5cT; arc=none smtp.client-ip=129.27.2.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tugraz.at
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tugraz.at
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tugraz.at;
	s=mailrelay; t=1771592794;
	bh=TI6pL5l6NcVbZgYUegCvNR9UgHAy5UP25eLtZeSKxCI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=eaazT5cTRW+EmP9R7NcUzYa45LVOLatiiLUOcMzvdWN9lfGzeX29bdLd/qNpldzjp
	 H4k/GSXyuZm4J45UVCM9WU9kn74dILYyfVBtb1sf1Dt4wLm3tiTSrOTpgS3JqnJDQK
	 X62nEBE+FP1RbCCCeqd1oGpQylYoQhte6/o1Gfqs=
Received: from localhost (unknown [129.27.152.14])
	by mailrelay.tugraz.at (Postfix) with ESMTPSA id 4fHVr968vzz2xP0;
	Fri, 20 Feb 2026 14:06:33 +0100 (CET)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8; format=Flowed
Date: Fri, 20 Feb 2026 14:06:33 +0100
Message-Id: <DGJT8E07A37R.2GC7KEDWEI7R@tugraz.at>
From: "Ernesto Martinez Garcia" <ernesto.martinezgarcia@tugraz.at>
To: "Marco Elver" <elver@google.com>, "Alexander Potapenko"
 <glider@google.com>
Cc: <akpm@linux-foundation.org>, <mark.rutland@arm.com>,
 <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
 <kasan-dev@googlegroups.com>, <pimyn@google.com>, "Andrey Konovalov"
 <andreyknvl@gmail.com>, "Andrey Ryabinin" <ryabinin.a.a@gmail.com>, "Dmitry
 Vyukov" <dvyukov@google.com>, "Ernesto Martinez Garcia"
 <ernesto.martinezgarcia@tugraz.at>, "Greg KH" <gregkh@linuxfoundation.org>,
 "Kees Cook" <kees@kernel.org>, <stable@vger.kernel.org>
Subject: Re: [PATCH v1] mm/kfence: disable KFENCE upon KASAN HW tags
 enablement
X-Mailer: aerc 0.21.0
References: <20260213095410.1862978-1-glider@google.com>
 <CANpmjNPJV-aQKnQ7Mtr6e8_12UR3C2S3abJx_ePFWmS1WV_UVg@mail.gmail.com>
In-Reply-To: <CANpmjNPJV-aQKnQ7Mtr6e8_12UR3C2S3abJx_ePFWmS1WV_UVg@mail.gmail.com>
X-TUG-Backscatter-control: odR5CN6y6BwYAgRjfEtHZQ
X-Spam-Scanner: SpamAssassin 3.003001 
X-Spam-Score-relay: 3.6
X-Scanned-By: MIMEDefang 2.74 on 129.27.10.117
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[tugraz.at,quarantine];
	R_DKIM_ALLOW(-0.20)[tugraz.at:s=mailrelay];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-217575-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[linux-foundation.org,arm.com,kvack.org,vger.kernel.org,googlegroups.com,google.com,gmail.com,tugraz.at,linuxfoundation.org,kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ernesto.martinezgarcia@tugraz.at,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[tugraz.at:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tugraz.at:mid,tugraz.at:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C043C167BF0
X-Rspamd-Action: no action

On Fri Feb 13, 2026 at 11:50 AM CET, Marco Elver wrote:
> On Fri, 13 Feb 2026 at 10:54, Alexander Potapenko <glider@google.com> wro=
te:
>>
>> KFENCE does not currently support KASAN hardware tags. As a result, the
>> two features are incompatible when enabled simultaneously.
>>
>> Given that MTE provides deterministic protection and KFENCE is a
>> sampling-based debugging tool, prioritize the stronger hardware
>> protections. Disable KFENCE initialization and free the pre-allocated
>> pool if KASAN hardware tags are detected to ensure the system maintains
>> the security guarantees provided by MTE.
>
> Just double-checking this is explicitly ok: If this is being skipped
> enablement at boot, a user is still free to do 'echo 123 >
> /sys/module/kfence/parameters/sample_interval' to re-enable KFENCE? In
> my opinion, this should be allowed.

Should work, as the late enable codepath is:

- param_set_sample_interval()
	- kfence_enable_late()
		- kfence_init_late()

While the check is only present at:

- mm_core_init()
	- kfence_alloc_pool_and_metadata()
		- kasan_hw_tags_enabled()

However the late activation triggers BUG_ON or KASAN invalid access
issues at the moment:

	~ # dmesg | grep 'disabled as'
	[    0.000000] kfence: disabled as KASAN HW tags are enabled
	~ # echo 100 > /sys/module/kfence/parameters/sample_interval
	[   30.440993] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[   30.442418] BUG: KASAN: invalid-access in __memset+0x10/0x20
	[   30.443275] Write at addr f4f00000c2e34000 by task sh/1
	[   30.443420] Pointer tag: [f4], memory tag: [f1]
	[   30.443448]=20
	...
	[   30.445742] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[   30.445946] Disabling lock debugging due to kernel taint
	[   30.459644] kfence: initialized - using 2097152 bytes for 255 objects a=
t 0xf5f00000c1c00000-0xf5f00000c1e00000

Likely because the KFENCE pool/metadata memory is allocated and tagged by M=
TE:

	[    7.590336] kfence: initialized - using 2097152 bytes for 255 objects a=
t 0xf2f00000c1600000-0xf2f00000c1800000
	...
	[    7.710112] kfence: initialized - using 2097152 bytes for 255 objects a=
t 0xf1f00000c1600000-0xf1f00000c1800000
	...
	[    6.627959] kfence: initialized - using 2097152 bytes for 255 objects a=
t 0xf8f00000c1e00000-0xf8f00000c2000000
	...
	[   19.137156] kfence: initialized - using 2097152 bytes for 255 objects a=
t 0xf3f00000c1e00000-0xf3f00000c2000000

Which seems to be an upstream bug of KFENCE+MTE, as I can reproduce the
same issue on mainline 6.19 without the patch applied:

	# uname -r
	6.19.0
	# cat /proc/cmdline=20
	root=3D/dev/vda console=3DttyAMA0 rw rootwait earlycon debug hash_pointers=
=3Dnever kfence.sample_interval=3D0
	# echo 100 > /sys/module/kfence/parameters/sample_interval=20
	[   45.555499] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
	[   45.556989] BUG: KASAN: invalid-access in __memset+0x10/0x20
	[   45.557844] Write at addr f8f00000c3032000 by task sh/148
	[   45.558063] Pointer tag: [f8], memory tag: [f4]
	...
	[   45.560695] Disabling lock debugging dHey thank you will take a looksie=
 and tell youe to kernel taint
	[   45.574599] kfence: initialized - using 2097152 bytes for 255 objects a=
t 0xf4f00000c1600000-0xf4f00000c1800000

Disabling and enabling won't trigger as the KFENCE pool is not freed on
disable. To trigger the bug it is required to go through the
kfence_init_late() path: KFENCE disabled at boot time.

	Note: Tested with qemu-system-aarch64 -cpu max -machine virt,mte=3Don (10.=
1.3)

Changing kfence_init_late() pool and metadata allocations to
use the __GFP_SKIP_KASAN flag fixes it:

	~ # echo 100 > /sys/module/kfence/parameters/sample_interval
	[   19.488734] kfence: initialized - using 2097152 bytes for 255 objects a=
t 0xfff00000c1600000-0xfff00000c1800000
	~ # cat /sys/kernel/debug/kfence/stats=20
	enabled: 1
	currently allocated: 1
	total allocations: 12
	total frees: 11
	...
	~ # echo 0 > /sys/module/kfence/parameters/sample_interval
	[  778.414494] kfence: disabled
	~ # echo 100 > /sys/module/kfence/parameters/sample_interval
	[  784.215866] kfence: re-enabled
	~ # cat /sys/kernel/debug/kfence/stats=20
	enabled: 1
	currently allocated: 2
	total allocations: 32
	total frees: 30
	...

But this requires adding __GFP_SKIP_KASAN as allowed in
__alloc_contig_verify_gfp_mask I think. Unsure if there is a cleaner way
of doing it, or if changing __alloc_contig_verify_gfp_mask could break
something else unexpectedly.

I would be happy to try to submit a patch for it :)

