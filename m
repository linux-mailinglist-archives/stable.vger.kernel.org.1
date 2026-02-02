Return-Path: <stable+bounces-213015-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id IMJ0Iaz7f2n+0wIAu9opvQ
	(envelope-from <stable+bounces-213015-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 02:19:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 60A32C7C03
	for <lists+stable@lfdr.de>; Mon, 02 Feb 2026 02:19:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3DA343004624
	for <lists+stable@lfdr.de>; Mon,  2 Feb 2026 01:19:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 437351B4F1F;
	Mon,  2 Feb 2026 01:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="qr5/XE/X"
X-Original-To: stable@vger.kernel.org
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3FCB190664
	for <stable@vger.kernel.org>; Mon,  2 Feb 2026 01:19:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769995175; cv=none; b=cYzlBnjwfa7+TLwDTNOUotWx67zuMK8LlIbHXzBAFONqOJvlIHwBtYMP3jT7EKcfO+eFDg/FY/EjjgAlTjc7emFKmK8XGjuRPk0DmR1z0pqKtgWwRTVsGrN4XVs3vtQVHoFG6RJj5KtFPc8oxo8kQwZt/OzyJ2MPRYaJ+MS8akY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769995175; c=relaxed/simple;
	bh=nDydltF1LQZ9cjsdVDGO/kyIbeOcczo664mY57X7VU0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D0YMMLQHz8KKcZ9zWfqUqGDudkbQ7/kxwKJdhXoYOvtrWYcDh/7mS7uKyFNCcWqAuzqqJknl3+oYObtDNUVVns8V1JIwC3EM0AyLc/tnYANwhO6STRLG0Z/hf6i4uAsjeOggiTOw5SD07u7tKvy1/U9MuwVLteXRCdP2xfkqhPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=qr5/XE/X; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=nDydltF1LQZ9cjsdVDGO/kyIbeOcczo664mY57X7VU0=;
	b=qr5/XE/XVq5TXwygK5y8eidHWrt09lwt/JF+222GIPDYHsvPlEng8rWDLwY0RkN8tlBD2h/3Q
	Bn+TLG+vv2t7D4xcfAhMNI5vvDCgAAiSOr7BuIJoIoQIe7QoqcZFPZpnQjKi75KqZORwYCkjqdN
	sbTJDM6f9g8OJhP3B0GPF7U=
Received: from mail.maildlp.com (unknown [172.19.162.144])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4f47vm6WQtzpStX;
	Mon,  2 Feb 2026 09:15:16 +0800 (CST)
Received: from kwepemg100014.china.huawei.com (unknown [7.202.181.54])
	by mail.maildlp.com (Postfix) with ESMTPS id 683B840538;
	Mon,  2 Feb 2026 09:19:23 +0800 (CST)
Received: from kwepemj100010.china.huawei.com (7.202.194.4) by
 kwepemg100014.china.huawei.com (7.202.181.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.36; Mon, 2 Feb 2026 09:19:23 +0800
Received: from kwepemj100010.china.huawei.com ([7.202.194.4]) by
 kwepemj100010.china.huawei.com ([7.202.194.4]) with mapi id 15.02.1544.036;
 Mon, 2 Feb 2026 09:19:23 +0800
From: Zhangjiaji <zhangjiaji1@huawei.com>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "huyu (D)" <huyu70@h-partners.com>, "Wangqinxiao (Tom)"
	<wangqinxiao@huawei.com>, "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>, Liumengqiu <liumengqiu1@huawei.com>
Subject: lock contention: x86/kvm: Potential deadlock between shrinker_rwsem
 and kvm_lock under high VM load
Thread-Topic: lock contention: x86/kvm: Potential deadlock between
 shrinker_rwsem and kvm_lock under high VM load
Thread-Index: AdySmyxt6ZfKKTQjQGq+FIE+eIgsTQBRISkAAABmVOA=
Date: Mon, 2 Feb 2026 01:19:22 +0000
Message-ID: <a5ebab14f0444f8da03a6fa4d1978793@huawei.com>
References: <505c34d2cef84117b7e995c211efc393@huawei.com>
 <eecb1d2d1f7a44ef8c757138cb1b3755@huawei.com>
In-Reply-To: <eecb1d2d1f7a44ef8c757138cb1b3755@huawei.com>
Accept-Language: en-US
Content-Language: zh-CN
X-MS-Has-Attach:
X-MS-TNEF-Correlator:
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[huawei.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[huawei.com:s=dkim];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns];
	TAGGED_FROM(0.00)[bounces-213015-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[huawei.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhangjiaji1@huawei.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 60A32C7C03
X-Rspamd-Action: no action

Hi all,

I'm hitting a lock contention / long stall issue on an x86 KVM host under h=
eavy VM load, and I'd like to ask for advice on the proper fix direction.

Problem summary
When the host is under heavy VM pressure and a cache drop is triggered, the=
 reclaim path can hold shrinker_rwsem for a long time due to lock contentio=
n on kvm_lock inside the KVM/MMU shrinker, which then blocks systemd in a w=
ay that also holds cgroup_mutex, causing cascading issues (e.g., journald l=
og gaps).

Observed lock chain / flow
From what I see:

1. drop_caches leads to slab reclaim and enters shrink_slab()
2. shrink_slab() takes shrinker_rwsem
3. It then enters do_shrink_slab()
4. During slab shrinking, the KVM/MMU shrinker callback is invoked (e.g mmu=
_shrink_scan()) to reclaim KVM-related caches
5. mmu_shrink_scan() attempts to take kvm_lock
6. Under heavy VM load, kvm_lock is highly contended, so the shrinker callb=
ack stalls and shrinker_rwsem remains held for an extended time

In parallel:

7. systemd holds cgroup_mutex (e.g. during cgroup operations) and then trie=
s to acquire shrinker_rwsem
8. Because shrinker_rwsem is still held by the drop_caches reclaim path, sy=
stemd blocks while still holding cgroup_mutex
9. Other components (e.g. systemd-journald) needing cgroup_mutex become blo=
cked, leading to issues such as logging stalls/gaps

Impact
- Long stalls in systemd-controlled cgroup operations
- systemd-journald (and possibly others) blocked on cgroup_mutex, causing l=
og dropouts / discontinuities
- Overall system responsiveness degradation during the cache-drop operation

Questions
1. Is it expected/acceptable for a shrinker callback (KVM/MMU shrinker) to =
contend on a highly contended lock like kvm_lock while shrinker_rwsem is he=
ld?
2. Are there known recommendations to avoid holding shrinker_rwsem across p=
otentially blocking/contended shrinker callbacks?
3. Would the preferred fix be on the KVM shrinker side (e.g. using mutex_tr=
ylock()/spin_trylock() semantics and returning SHRINK_STOP/-EAGAIN style be=
havior when contended), or on the shrink_slab/shrinker infrastructure side?
4. Alternatively, is there any known guidance for systemd/cgroup codepaths =
to avoid waiting on shrinker_rwsem while holding cgroup_mutex (to avoid loc=
k chaining)?

Please let me know what the most useful information would be, and what dire=
ction you would recommend for a fix.

Thanks,
Huyu

