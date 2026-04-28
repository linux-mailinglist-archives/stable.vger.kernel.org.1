Return-Path: <stable+bounces-241521-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCBqDeJ98GlSUAEAu9opvQ
	(envelope-from <stable+bounces-241521-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:29:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D6B794816BD
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 11:29:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1EFE630AD466
	for <lists+stable@lfdr.de>; Tue, 28 Apr 2026 09:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F99933064A;
	Tue, 28 Apr 2026 09:22:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="VTVmlSyp"
X-Original-To: stable@vger.kernel.org
Received: from out-177.mta0.migadu.com (out-177.mta0.migadu.com [91.218.175.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B4B1364E92
	for <stable@vger.kernel.org>; Tue, 28 Apr 2026 09:22:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777368129; cv=none; b=REt9Ni+SpBT2fiKgMM4LhccUhJ4nKIlDsCPAnQNhwiLpsMfVfaQ45lwp5prWoMDdKuU3uo3hspEMwMcM77HF0RMWdKbz57WgySwdiy+Z7b0z1lupTH7AQbtHoVBS4wC4mN5ZR06laaFB2hgI4PyxNcGtxmpHKqS6+89IP0B6HWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777368129; c=relaxed/simple;
	bh=xwdhCIsDzsUndt0fN1DFv5y4ol6vuXneCPXfkJ3rv3I=;
	h=Content-Type:Mime-Version:Subject:From:In-Reply-To:Date:Cc:
	 Message-Id:References:To; b=eqsL1mAiyw5pFcZtElyIxTNTL7fTqSlCj+VHa7BF2mWUma+tl/xW2xjUV94Z5/t4TNh7YSzKnU4qMrxSQOJX0QasOeuujypXbfl25dV2efWl1kQAzkRHJDk8zsRnGENRT/tIcRhjbyAWFVAzNmqyAGBGWsBjnRiq3n7cqapafQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=VTVmlSyp; arc=none smtp.client-ip=91.218.175.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Content-Type: text/plain;
	charset=utf-8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1777368114;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xwdhCIsDzsUndt0fN1DFv5y4ol6vuXneCPXfkJ3rv3I=;
	b=VTVmlSyp8aaq5f+XaDvS0eCOTZ71PIuGmarywfT1eOlsw3168ofTjyocykCuCTxym/Z0kv
	uvn14YRvzKs0CdBkfTeGlN38AUcIlktOHnJQpMfKaWBnyICUchCrgy5EO80eEPug/YhDHT
	jk5BeXB8BaVebZN/UatMguhrgiXPS4g=
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
In-Reply-To: <afB7Go7JqhIpjU5J@localhost.localdomain>
Date: Tue, 28 Apr 2026 17:21:00 +0800
Cc: Muchun Song <songmuchun@bytedance.com>,
 David Hildenbrand <david@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "Rafael J . Wysocki" <rafael@kernel.org>,
 Danilo Krummrich <dakr@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Vishal Verma <vishal.l.verma@intel.com>,
 Ying Huang <huang.ying.caritas@gmail.com>,
 Dan Williams <djbw@kernel.org>,
 Miaohe Lin <linmiaohe@huawei.com>,
 Naoya Horiguchi <nao.horiguchi@gmail.com>,
 linux-mm@kvack.org,
 linux-cxl@vger.kernel.org,
 driver-core@lists.linux.dev,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <4542EE05-E18A-486F-ADF7-E72F71D9A327@linux.dev>
References: <20260428085219.1316047-1-songmuchun@bytedance.com>
 <20260428085219.1316047-4-songmuchun@bytedance.com>
 <afB7Go7JqhIpjU5J@localhost.localdomain>
To: Oscar Salvador <osalvador@suse.de>
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: D6B794816BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MV_CASE(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-241521-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[bytedance.com,kernel.org,linuxfoundation.org,linux-foundation.org,intel.com,gmail.com,huawei.com,kvack.org,vger.kernel.org,lists.linux.dev];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[muchun.song@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[bytedance.com:email,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,suse.de:email,linux.dev:dkim,linux.dev:mid]



> On Apr 28, 2026, at 17:17, Oscar Salvador <osalvador@suse.de> wrote:
>=20
> On Tue, Apr 28, 2026 at 04:52:19PM +0800, Muchun Song wrote:
>> memblk_nr_poison_inc() and memblk_nr_poison_sub() call
>> find_memory_block_by_id(), which requires device_hotplug_lock to
>> serialize the xarray lookup against memory block removal.
>>=20
>> Take device_hotplug_lock around the lookup and nr_hwpoison update so
>> the memory block cannot disappear between xa_load() and get_device().
>>=20
>> Fixes: 5033091de814 ("mm/hwpoison: introduce per-memory_block =
hwpoison counter")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Muchun Song <songmuchun@bytedance.com>
>=20
> It might have made sense to join both patches? Anyway:

Either way works for me. I=E2=80=99ve been following the 'one thing per
patch' principle. If I still need to update v3, I can merge them;
otherwise, I=E2=80=99d prefer to keep it as is. I'm a little lazy. :)

>=20
> Acked-by: Oscar Salvador <osalvador@suse.de>

Thanks.

>=20
>=20
> --=20
> Oscar Salvador
> SUSE Labs


