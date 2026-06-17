Return-Path: <stable+bounces-266618-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Hm8UIjAAMmpKtgUAu9opvQ
	(envelope-from <stable+bounces-266618-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 04:02:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA28696083
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 04:02:23 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=ankey-net.20251104.gappssmtp.com header.s=20251104 header.b=tOQJtQCx;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-266618-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c15:e001:75::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-266618-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 87F0330034A5
	for <lists+stable@lfdr.de>; Wed, 17 Jun 2026 02:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D72B2DAFB0;
	Wed, 17 Jun 2026 02:02:16 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB7B82848A8
	for <stable@vger.kernel.org>; Wed, 17 Jun 2026 02:02:14 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781661736; cv=none; b=Jo05sB4kGerlLCaLI4I/zfpSXJIDXJvuYHNLWSQg6f3nFe9oUITNYvqO5LeqRSRDMx3RMoybbIqvNmas6kFjJpZyhivcvJwob3tTPgKdqv5C60o1M0GySOtptONISCjBjBuxALnhQ7+LIlg/IYZK+DyvsMJr1UdwwQLuARYwRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781661736; c=relaxed/simple;
	bh=/6qqonAB1rvfwi0nHfBcjTnP0l6KSbTgCUpfm1TzYf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 Content-Type:MIME-Version; b=i4ls2JMKXcYMI5A9t2hbTxZU479AY8zsEODEiSG0YYpqt9sayhT7bCCpQOfbD5lzjuuohfIpspd/CgNcE1O9wSz1Py6QLoJopEVi6YkcxPx18qbemZjH26aVbQZzeJKOuglLJunkAQQW1ceQT8GryLsxBQz7PRGnyEoMi76bX00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ankey.net; spf=none smtp.mailfrom=ankey.net; dkim=pass (2048-bit key) header.d=ankey-net.20251104.gappssmtp.com header.i=@ankey-net.20251104.gappssmtp.com header.b=tOQJtQCx; arc=none smtp.client-ip=209.85.214.179
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2c40397e746so32059005ad.3
        for <stable@vger.kernel.org>; Tue, 16 Jun 2026 19:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ankey-net.20251104.gappssmtp.com; s=20251104; t=1781661734; x=1782266534; darn=vger.kernel.org;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z7ztbMiRRaO/C1m+UU2CZ46ifpbNE3xQILmUDMNi364=;
        b=tOQJtQCxmO8sWi2mM1fh9NbmclYDichvbh8WHbygZw17Zn5GoApHfy2ktyo2wuH7lK
         jzRF8CgBklu+OV83/NHJxPlGbhm2LbAyipRS/a09aalFDcaaUNESMELmfXxYomfa9aTc
         vOH3hmx9VeopheqyQtAcElaVq1W40UNnBE0eC47ygMAVkx48Ka0oS825sPy/XB0VwAcK
         5ZsrrhtVu66uEd7cqg08yLQUztFx96Co1p4EvcdRA+62kIZRSTt+LwtzKVkvEJ3tmcL6
         f2vjjwbNYfW3bB0F1X8F5Xec0FOMONnraiDd/zDk2JNTguRw3xQkuhbWEICBnCFTBXdE
         24Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781661734; x=1782266534;
        h=mime-version:content-transfer-encoding:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=z7ztbMiRRaO/C1m+UU2CZ46ifpbNE3xQILmUDMNi364=;
        b=XeRSu4RY74G/6RJjWPR6t4qJ+1s/YjNvSpfBhkWKojkw+BR2ofu4e5TZWqouY+L5UA
         FxGvAEdxcPGp7NS6Z1A3yKWmRi6d21vKAMZoWFf9vMVoLZ2kHlFmsTEcA9Qyqzx+QFPD
         g1GfDVHypzjRPECh9BCjmurrPdAgdxoKvx33c1Y6KVGVmkmbqEx8UwMLO6c9JYu6Wunn
         FoN5tQhd4lexSVHiXyN5HERfQj2j3x8qkeN3EhPZ9LfH1w4mcojpPL17GCS5ke9NyVMB
         RBVT2xwzaTkDg+51z6vDRwRUucp7vzFlH+FGo7TRSCV2DiOsH/zIxPkN8KAKX7+r4hMk
         a5JQ==
X-Forwarded-Encrypted: i=1; AFNElJ+7XLUnmWaMOqqrCoFQ9CQNsVxU0XLHRc+buJgBAi5F/PhEZ/Te5BdGiXH0JK/FhQLqpV/1OaU=@vger.kernel.org
X-Gm-Message-State: AOJu0YzSFFp+3FrOjCn7v4kTfB9TNg1MumMiJkRx84wpjqUSwYxig9NJ
	vDoaNBGnEDMi0cw473t7tOsZLLObCNjMo5Qkm0673s22OnXX3pJ5awhVa3b8Bsi938YiZpbz1VS
	JM/c=
X-Gm-Gg: AfdE7cm60OvTfOqBOB95GQD4QuVEm+MjEi8o5rK1H1cALbN9h8l7w/7DdJqy00///eB
	35Z8tMvESizs+xHNAlIa7l/vxVt3FhI9Oqhtlyvd+d8IIYP4KBF2g5VSmb2UDStjd9eNaoOkJtW
	iGKk4Z+YPlRc49M1jzPswg6bvwNIAOyvXFWBOnwu0bd30bxaVlX+EtIWLf+/H+hZpPe/h163vDP
	+YAseh6glYGvDpCmDg3WWsroAam9dbm9RYRwI+KP/dakgtq1+BXF1muUAaX+XmDtSZZwpXYg3b+
	JkD1YJaYG79mZ7Wx1Yatp9A7l6TjZ9z95w2fwQl6WOfJ0KK4bNLK4+3QZARNkr8qvHi+Oz+53TZ
	BZt0SrESsdrviCvebU474brzbSTqQpCcmlmLWrJ2IwMeNbv3osFzNjq6dqpX2skfqisw0pS2F2M
	ALErTpBSoGdD+2kcReSiAi0AEJ6gFrIUoKYx1VWwBrmhwQEnM485t355d+UJaJO2Eg4ZJo8k3VQ
	AOWGt7K9ihEW8qJ3zVOuO6psMc=
X-Received: by 2002:a17:902:fc47:b0:2c2:8659:da43 with SMTP id d9443c01a7336-2c6bbf7cdeemr15372715ad.4.1781661733790;
        Tue, 16 Jun 2026 19:02:13 -0700 (PDT)
Received: from atimofey-ld1.linkedin.biz ([20.29.181.177])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c6a3ee1052sm25075775ad.48.2026.06.16.19.02.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 19:02:13 -0700 (PDT)
From: Alex Timofeyev <sashka@ankey.net>
To: Jason Gunthorpe <jgg@ziepe.ca>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org
Cc: Parav Pandit <parav@nvidia.com>, Edward Srouji <edwards@nvidia.com>,
 Vlad Dumitrescu <vdumitrescu@nvidia.com>, stable@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH rdma-next v1 0/2] RDMA: fix cross-NIC same-host IPv6
 RDMA-CM connect
Date: Wed, 17 Jun 2026 02:02:12 +0000
Message-ID: <1781661732.reply1-sashka@ankey.net>
In-Reply-To: <1781545579.1-sashka@ankey.net>
References: <1781545579.1-sashka@ankey.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[ankey-net.20251104.gappssmtp.com:s=20251104];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-266618-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:jgg@ziepe.ca,m:leon@kernel.org,m:linux-rdma@vger.kernel.org,m:parav@nvidia.com,m:edwards@nvidia.com,m:vdumitrescu@nvidia.com,m:stable@vger.kernel.org,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FROM_HAS_DN(0.00)[];
	DMARC_NA(0.00)[ankey.net];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[ankey-net.20251104.gappssmtp.com:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashka@ankey.net,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashka@ankey.net,stable@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,ankey.net:mid,ankey.net:from_mime]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 7FA28696083

> You need to setup policy routing or a VRF so these local routes don't
> show up the way they do. We shouldn't be mangling the loopback routes
> in the kernel, and removing the check is not correct.

You're right, and thanks for pushing back on this.

I've been testing VRF all day and it solves the problem completely,
with no kernel changes. Putting each NIC in its own VRF moves that
NIC's addresses out of the global v6 local table (255), so the
cross-NIC same-host destination no longer collapses to lo -- it
resolves on-wire to the real egress device:

  # enp49s0np0 -> vrfdata0 (table 100), enp193s0np0 -> vrfdata1 (101)
  $ ip -6 route get <dst-on-other-local-nic> from <src> oif enp49s0np0
  ... dev enp49s0np0 ...        # was: local ... dev lo

So neither addr_resolve_neigh() nor validate_ipv6_net_dev() ever hits
the local shortcut my patches were rewriting. The check stays correct
and the loopback routes stay untouched, exactly as you said.

I validated it with the actual workload that motivated the series, not
just rping: a 3-node DAOS cluster (two engines per host, one per NUMA
NIC) on a kernel WITHOUT these two patches -- only the upstream prereqs
fa29d1e8877b + c31e4038c97f. All 6 ranks join and stay joined, and a
pool created across all of them comes up healthy. That covers both the
same-host cross-NIC path and the cross-host path, all over v6 RoCEv2.

One observation in case it's useful to others who hit this: VRF
self-RPC relies on c31e4038c97f -- once an address is homed in a VRF
table, is_dst_local() needs the RTF_LOCAL test rather than the old
IFF_LOOPBACK one to still recognize it as local. That commit is in
v6.18 but not in linux-6.6.y, which is the stable base we (and
presumably other RoCE-on-6.6 users) are on; might be worth a stable
backport on its own merits, independent of this series.

Given all that, please drop this series -- I'm withdrawing it. The
right fix here is configuration, not a kernel patch. Appreciate the
review and the steer toward VRF.

Thanks,
Alex

