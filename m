Return-Path: <stable+bounces-242232-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id S95NCFoW9GlV+QEAu9opvQ
	(envelope-from <stable+bounces-242232-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 04:56:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9112A4A9DBA
	for <lists+stable@lfdr.de>; Fri, 01 May 2026 04:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 87AF8301A1F5
	for <lists+stable@lfdr.de>; Fri,  1 May 2026 02:56:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A0D32EA732;
	Fri,  1 May 2026 02:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="pR1/V6/q"
X-Original-To: stable@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B85D285C91
	for <stable@vger.kernel.org>; Fri,  1 May 2026 02:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777604177; cv=none; b=pP0Ms0KX6kImhzuxcO1hb+jUZwODflBe/Fx67eu42LZWKbRUJ+4KDarioo7wgUT9iaTyrUyjDPfBnbMSkpr79B/a4voUjRJ0X/HPsUg+aSEs+T+vad0HG9vkh7JE+OGJCirEYkUcQGQcAjTObzl0u0gYNt7CANyiFVsHmIPQshI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777604177; c=relaxed/simple;
	bh=OzFf8IXRVbYQTRERWmhi4Gau4qI+ard8q8aBvde/xAg=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=PLm1S9b3mTln2b5aL6MdV5j272T4HoD62THuVrn7UcWggyrq2zZSH4w/D28fcMRp49BG4wGVqk1GfTwkchK31ke9AXYWt15yNgXDJNILoYsy8K4ALjEpc4tiLErd0kxOtDSz/3SiR07jbDmPj6VrHlzbocTNcoW/Td/ugSpb0NA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=pR1/V6/q; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777604163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OzFf8IXRVbYQTRERWmhi4Gau4qI+ard8q8aBvde/xAg=;
	b=pR1/V6/qpV+GN44kVDka7D4dqFdY2WTJYK/vqPYvWOHqMaJHINcU1ag8cD+x4K6EX5Q+K9
	8vOYFOCmwwZYjnajkk3cPsRC+X7Sh/xq1gbXeL7lEy2lDw7Pkqt1xi09L1D/wafbwNt+d9
	BZtjVjMHrD7JWlEe3MId1ZvkKP0r8lY=
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3864.500.181\))
Subject: Re: [PATCH v2 3/3] drivers/base/memory: fix locking for poison
 accounting lookup
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Muchun Song <muchun.song@linux.dev>
In-Reply-To: <20260430085058.f566bdc2aa5c19a54936da30@linux-foundation.org>
Date: Fri, 1 May 2026 10:55:06 +0800
Cc: "David Hildenbrand (Arm)" <david@kernel.org>,
 Usama Arif <usama.arif@linux.dev>,
 Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Muchun Song <songmuchun@bytedance.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Dan Williams <djbw@kernel.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rafael J Wysocki <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <89000C13-1AAD-489A-B70F-73ED909EF4DD@linux.dev>
References: <20260429101134.1358607-1-usama.arif@linux.dev>
 <b67ff3f9-8661-45cc-b408-6a7b611d31c1@kernel.org>
 <C2C5188E-76BF-444C-BF2D-8BDC1410BC61@linux.dev>
 <20260430085058.f566bdc2aa5c19a54936da30@linux-foundation.org>
To: Andrew Morton <akpm@linux-foundation.org>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 9112A4A9DBA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-242232-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linux.dev,suse.de,huawei.com,bytedance.com,intel.com,gmail.com,kvack.org,vger.kernel.org,lists.linux.dev,linuxfoundation.org];
	RCPT_COUNT_TWELVE(0.00)[18];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:email,linux.dev:dkim,linux.dev:mid,linux-foundation.org:email]



> On Apr 30, 2026, at 23:50, Andrew Morton <akpm@linux-foundation.org> =
wrote:
>=20
> On Thu, 30 Apr 2026 15:59:33 +0800 Muchun Song <muchun.song@linux.dev> =
wrote:
>=20
>>>> Lockdep would flag this as sleeping while atomic when acquiring =
mutex I think.
>>>=20
>>> Another thought would be, that we always call the inc/sub from =
memory failure
>>> code while we hold a folio reference and the page is not poisoned =
yet.
>>>=20
>>> That way, memory offlining cannot continue and the memory block =
cannot go away.
>>>=20
>>> So we'd let out page reference keep the memory block alive.
>>=20
>> It seems unnecessary to hold lock_device_hotplug if the user already =
holds a
>> refcount on the page. I'd like to drop this patch.
>=20
> Dropped, thanks.

Thank you so much for helping me with this.

Thanks,
Muchun.

>=20
> mm-hotfixes-unstable still has
>=20
> "mm/memory_hotplug: fix memory block reference leak on remove"
> and
> "drivers/base/memory: fix memory block reference leak in poison =
accounting"


