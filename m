Return-Path: <stable+bounces-241813-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAskH8uG8WmchgEAu9opvQ
	(envelope-from <stable+bounces-241813-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:19:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB1F048F182
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 06:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CAD61303A139
	for <lists+stable@lfdr.de>; Wed, 29 Apr 2026 04:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3315437CD34;
	Wed, 29 Apr 2026 04:19:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="WP7MpNsD"
X-Original-To: stable@vger.kernel.org
Received: from out-183.mta0.migadu.com (out-183.mta0.migadu.com [91.218.175.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59C28175A7E;
	Wed, 29 Apr 2026 04:19:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777436357; cv=none; b=QiF4c+z91wfgR0Kq3hMpOBbvdnZlj+ALCfvhukYEFNHDP8xDmLMgZu3M/PGuvQXOTJ49b2sq4EMWuJPaosGv7O9yZp7ISTR92f0ssejvNgh3Q7tACJXV7HpVZ8RhXKZhG5DnfUdwqTuGFao5ozrKjlnhMZDET3VNAQbF2pXLjak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777436357; c=relaxed/simple;
	bh=bw0qJOox+Dck+nB+/7DVwghKkNsp1T7hgyHMM4i1Wb4=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=k10cuvVjB+oWH1CdBVRViKA2o+TPSAu8Jfv88X/qUhEWnNtIijm57qowQjINVE8EofwZC+VAWm33SxknCdZIGYcycRIE6HO9k7XFeVdLX8SJQdawyHsjaEclCSiYs67wiv6QnXllj1aduCC2c2Bdk6iwtP24LeBuzteaT2Rw2l4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=WP7MpNsD; arc=none smtp.client-ip=91.218.175.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=us-ascii
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777436343;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgdkPDsgSgyFBEabURf3W75QiN4fDtGI45IFE9lTYH4=;
	b=WP7MpNsDlyw+uUIvXwQLhMDusj9kfWjZhgawN6yMi1hHqW0eD31IZPqp3Cwh+IbLopMsho
	2yl/q6fB1znPpkEvLkzL3zkFgSMcooH0E3cFH3R/OrL77HAcmH8dUMWNPRTehx5bIagm+S
	jSIsJEnan3SMjR2iEK4BVFruFG1ya/g=
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
In-Reply-To: <afF7vI_fNXs4mCVA@localhost.localdomain>
Date: Wed, 29 Apr 2026 12:18:08 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Dan Williams <djbw@kernel.org>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org,
 David Hildenbrand <david@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Rafael J Wysocki <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <A3EF6D95-E3B9-4228-9AED-A7018ED494C5@linux.dev>
References: <94F5B89A-008A-4EDB-920F-31B4895C2699@linux.dev>
 <c6e1df1e-be5e-2468-d46e-453985ba1e79@huawei.com>
 <afF7vI_fNXs4mCVA@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>,
 Miaohe Lin <linmiaohe@huawei.com>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: CB1F048F182
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241813-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,intel.com,gmail.com,kernel.org,kvack.org,vger.kernel.org,lists.linux.dev,linuxfoundation.org,linux-foundation.org];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.949];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:mid,sashiko.dev:url]



> On Apr 29, 2026, at 11:32, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Wed, Apr 29, 2026 at 11:08:51AM +0800, Miaohe Lin wrote:
>> Right, I missed that. Thanks. But I'm still worried that there might =
be potential issues.
>> For example, this function could be called while lock_page is held. =
Acquiring lock_device_hotplug
>> while already holding lock_page might cause problems, though I =
haven't seen any specific issues yet.
>> Also there might be some other potential scenarios that haven't been =
considered. Hope I'm just
>> overthinking it. :)
>=20
> lock_device_hotplug is a mutex lock, and we already take other mutex =
locks while
> holding lock_folio in other paths, so I am not sure I see what should =
be special
> in this case.

Hi Oscar and Miaohe,

I saw sashiko's report [1] related to folio lock and =
lock_device_hotplug.
Seems it is possible. You can correct me if I am wrong.

[1] =
https://sashiko.dev/#/patchset/20260428085219.1316047-1-songmuchun%40byted=
ance.com

We could fix this by calling action_result() without holding folio lock.
What do you think?

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index ee42d4361309..bc76066547ce 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -2534,8 +2534,9 @@ int memory_failure(unsigned long pfn, int flags)
         * Abort on fail: __filemap_remove_folio() assumes unmapped =
page.
         */
        if (!hwpoison_user_mappings(folio, p, pfn, flags)) {
+               folio_unlock(folio);
                res =3D action_result(pfn, MF_MSG_UNMAP_FAILED, =
MF_FAILED);
-               goto unlock_page;
+               goto unlock_mutex;
        }

        /*
@@ -2543,16 +2544,15 @@ int memory_failure(unsigned long pfn, int flags)
         */
        if (folio_test_lru(folio) && !folio_test_swapcache(folio) &&
            folio->mapping =3D=3D NULL) {
+               folio_unlock(folio);
                res =3D action_result(pfn, MF_MSG_TRUNCATED_LRU, =
MF_IGNORED);
-               goto unlock_page;
+               goto unlock_mutex;
        }

 identify_page_state:
        res =3D identify_page_state(pfn, p, page_flags);
        mutex_unlock(&mf_mutex);
        return res;
-unlock_page:
-       folio_unlock(folio);
 unlock_mutex:
        mutex_unlock(&mf_mutex);
        return res;

>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs


