Return-Path: <stable+bounces-223159-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aOGgBADXqGlmxwAAu9opvQ
	(envelope-from <stable+bounces-223159-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 02:06:08 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AA32209AEF
	for <lists+stable@lfdr.de>; Thu, 05 Mar 2026 02:06:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E25B23014C27
	for <lists+stable@lfdr.de>; Thu,  5 Mar 2026 01:02:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A19823B61B;
	Thu,  5 Mar 2026 01:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OYTaO5+i"
X-Original-To: stable@vger.kernel.org
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3B57231830
	for <stable@vger.kernel.org>; Thu,  5 Mar 2026 01:02:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772672572; cv=none; b=o1hFRH5WCg8gFQgqXAZ9hAP0ggvyHeCSkH4S1D29d6+xVbp/HRWYWYM0l6ZhrwE2F++UPrq67ylnhiVcSdMYcy1Z0oS5OA3C7A0ub/kij1EkboodcWiuMGDIb7t8rM/JR0Vpa5VlOGyIdTMfgPbz3T7R/UnygnqP/YNoy6he8K8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772672572; c=relaxed/simple;
	bh=01T1wpQkKyfgQWiIuWVBGWyiPJ4zwU2gIDr8R+TyrpI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=BvRNWqxqdwd1RK93p+7DwkC+sMOwpA/Gd9fMsDv4DVE9ujmBU2MIXILrNgAuqsMA1UyF3YBFZh5hUVbv8FLq6aiGZxm68LMNbp/8RFsqW8zyEM5ee2hAb85JD1b9u59eyKYHIff51c6zS1f2u5TKoNWCrF9eLwcGriMxZG35780=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OYTaO5+i; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-7987531082aso73784357b3.3
        for <stable@vger.kernel.org>; Wed, 04 Mar 2026 17:02:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772672570; x=1773277370; darn=vger.kernel.org;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=01T1wpQkKyfgQWiIuWVBGWyiPJ4zwU2gIDr8R+TyrpI=;
        b=OYTaO5+iFUWg7yD0W51E5GirWq+yKdvOfk0DMLiIzwBjyppKm++Wmo9dsADQfOugkF
         pFfILtsfJkEI8gGfKovfpEFPTZn7ebzzSFerNzqfKwhTwUnbjbzmJ1z+slTV+D6FHrvp
         zGKfkKBihXFpv6jrks+DVMz5dWJVRgKu4WYdEte71uyVybEc2U0sWwLzPGP3jxKY48aM
         ctJq4WN6ABbmozQ3XQnyJzMvPD/0uBtRbmN52RyezWLF/9KAKbDZLCOWoImDgluZYo4d
         cJVXWCU4b0h32nLv5K1s5V770azGzQAkgvLyN2+lZ+eFKjRaRbpGQ0wf9OKdSwBf86z6
         YKaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772672570; x=1773277370;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=01T1wpQkKyfgQWiIuWVBGWyiPJ4zwU2gIDr8R+TyrpI=;
        b=uj8CEjWUmXRWCC5Y62dJibFcT3+Re6myPs4ArZ+OywhN1Eh3c9JfCixBvHlVx7lsCu
         jg1Gm1ejGzgiASt9aIdqC7vdS0Uf2IKjbIjlXVnC8kG3Iv8+8ZiCLwIclyST61HYEtvV
         Ia07m+Hi6Ow99TRHyoc+FwrnG9wPIV3VIneerLIIb3y5w/4YB0AN6jp9+Gg1kb1kZ4cI
         L24c8tTeyLJ+0VdAu9QZeoNXNpBcfLqZBRlFoPjobgCcSg6oxIMA0xbmOiIZBr8Ubx4W
         RethGaSIuaxIuK1Yww5B1PY09KVf8riMLUSvLSYK2MGn4tJdPhpyVRW6cMd7nsbyXbJi
         WJ9Q==
X-Gm-Message-State: AOJu0YxelLMeVfT/kN4WvzhIYz2hPaC5ZnWSIXnOk/Xzf7C+6KWTG3FG
	ans+tmpXGVmOzQseUYsjpXb4rszsVm/DWiT5/ZfC59yJMYHZuy62HVETEYyKfg==
X-Gm-Gg: ATEYQzyPldL9RwAFR2gnP4Sn22yfGMCFPHtJqQO+7FzzHTFxomQOJqyv+ofrLdJBKhI
	ncjLXF+6l7fAhuSzH1GYIyZmQKJafFQoIE0ON09WjPbXzc5F3NyujA9xk5ULEhiymkhVLmF+te4
	jYdN+hxse137MUx+8sAZ54V4LNZGaEC2vOqex6npcC0KiVTBrE4rsIsZT69baKbRgP3pT5gjQeM
	brf2Qsucid1Nkczmgd68wbie1xit5uovMdQis/1jrpBNy3+KEv5enyG82kgoa+A0MSPI8g/NWoU
	DMCYDajMZ+UfDAbVWlQpNAlNfFX5REuUAJbcFCoM1U2PzgTTpkeCf1PO76LzUbPErqy4fakanBB
	uPdKKec5UCyF8dgugiUGxB+G2A6wh4pSiXRavCaeCCc7cd+GPgeOeh538YJPmwhJTsH8Syza9BA
	WOHr49hfySDymim2gkj//GbAiNnoUo6xVmTJc9+x1LyV0hTPA=
X-Received: by 2002:a05:690c:38b:b0:796:4b03:7390 with SMTP id 00721157ae682-798c6c01c6emr34466007b3.27.1772672570468;
        Wed, 04 Mar 2026 17:02:50 -0800 (PST)
Received: from devvm11784.nha0.facebook.com ([2a03:2880:25ff:4d::])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-798d2089aa8sm1759957b3.23.2026.03.04.17.02.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 17:02:49 -0800 (PST)
Date: Wed, 4 Mar 2026 17:02:48 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: stable@vger.kernel.org
Cc: gregkh@linuxfoundation.org, sgarzare@redhat.com, netdev@vger.kernel.org,
	mkutsevol@meta.com, thevlad@meta.com, christinewang@meta.com
Subject: Stable backport request: vsock namespace support for 6.18.y
Message-ID: <aajWMBoSgXafmw8b@devvm11784.nha0.facebook.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 5AA32209AEF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-223159-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bobbyeshleman@gmail.com,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_NONE(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,devvm11784.nha0.facebook.com:mid]
X-Rspamd-Action: no action

Hey all,

Would the stable maintainers possibly consider backporting the following
commits to 6.18.y? They add network namespace support to AF_VSOCK, which
addresses a security concern from our users in production.

eafb64f40ca49c79f0769aab25d0fae5c9d3becb vsock: add netns to vsock core
a6ae12a599e0f16bc01a38bcfe8d0278a26b5ee0 virtio: set skb owner of virtio_transport_reset_no_sock() reply
a69686327e42912e87d1f4be23f54ce1eae4dbd2 vsock: add netns support to virtio transports
9dd391493a727464e9a03cfff9356c8e10b8da0b vsock: fix child netns mode initialization
6a997f38bdf822d4c5cc10b445ff1cb26872580a vsock: prevent child netns mode switch from local to global
a07c33c6f2fc693bf9c67514fcc15d9d417f390d vsock: document namespace mode sysctls

All commits are in v7.0-rc1 via net-next.

The intention of vsock is to be used more-or-less as a VM-to-host serial
with free port-based multiplexing. It may be used very early in system
startup, so it is often used as the communication medium between VM
agents and host controllers. The security concern is that any workload
on the host can bind to a vsock port and intercept connections intended
for a different VM's controller / control plane. For sensitive VMs, this
presents a risk. The above patch series mitigates that risk by teaching
VSOCK to respect namespaces, and so allowing the system to restrict
applications that may access the VM's vsock (by use of namespace
isolation).

The feature is opt-in via a per-netns sysctl (vsock.child_ns_mode),
defaulting to "global" which preserves existing behavior exactly.

I realize this may be a long-shot/big ask, as these patches definitely
fall outside of the 100-line diff limit and it is a very new security
feature for vsock.

Thanks,
Bobby

