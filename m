Return-Path: <stable+bounces-254339-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sDwyNkeZFWqNWgcAu9opvQ
	(envelope-from <stable+bounces-254339-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:59:51 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BFC75D5EF7
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 14:59:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BFB27304C9F8
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 12:54:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE050238C36;
	Tue, 26 May 2026 12:54:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="EKucJNjP"
X-Original-To: stable@vger.kernel.org
Received: from out-178.mta0.migadu.com (out-178.mta0.migadu.com [91.218.175.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48397223702
	for <stable@vger.kernel.org>; Tue, 26 May 2026 12:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779800057; cv=none; b=BbJ/vqV1vferN6a/b9GRt+jrnBWyMit58igORTuCxWJwnVLsbazWWVd6i8XDShVOsWgYcfZ+EZ2GtHHTNkmHLNITXHXZUmi4nHGikh+LvOnI5JHgwdNXW26hIBq0NHFN9nThU0UtW9ZbJwZRbE0I//D9C4zExjlO13Qdel80bxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779800057; c=relaxed/simple;
	bh=8NFmtjNVk6yqSf59PQPhoTYEdjcxCUFRSGiq2LjpJPU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SOhF36ATcMaFfzF4SHe8mWWuIBW434VRO/8ba94dZLaG7Ngy0kHpK8SFMvHu8lIqCzYpGYGUiGXpCtxsYBEFnyRWjdJyqTvXMxgWDD2ow2BuaOJSzca6inso6pS/J5fLmQ1w3Ap/30rpSZ1/HswAv1nrK4rPs5F8MfURYgp0kbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=EKucJNjP; arc=none smtp.client-ip=91.218.175.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1779800044;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8NFmtjNVk6yqSf59PQPhoTYEdjcxCUFRSGiq2LjpJPU=;
	b=EKucJNjPDOyhy/Ct1wzGkugYgHG38e4JHfUiB89+kwZuDSasTGZUEoc1YDrz5Tlx3cQgBS
	nbFBvy3MoCeQXc3AEh1D5EiRZA7JxcqK8wuhQb/KM8RElSncECRexNGouS6+eizOvOXxUG
	BRDHXzkKV0rGmVw5LE4kz+EpbfTed0o=
From: Lance Yang <lance.yang@linux.dev>
To: yintirui@huawei.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	ljs@kernel.org,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	liam@infradead.org,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	djbw@kernel.org,
	apopple@nvidia.com,
	wangkefeng.wang@huawei.com,
	chenjun102@huawei.com,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm/huge_memory: update file PUD counter before folio_put()
Date: Tue, 26 May 2026 20:53:51 +0800
Message-Id: <20260526125351.58831-1-lance.yang@linux.dev>
In-Reply-To: <20260526101355.1984244-1-yintirui@huawei.com>
References: <20260526101355.1984244-1-yintirui@huawei.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254339-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[19];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:email,linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,huawei.com:email]
X-Rspamd-Queue-Id: 4BFC75D5EF7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Tue, May 26, 2026 at 06:13:55PM +0800, Yin Tirui wrote:
>__split_huge_pud_locked() updates the file/shmem RSS counter after
>dropping the PUD mapping's folio reference. If folio_put() drops the
>last reference, mm_counter_file() can later read freed folio state via
>folio_test_swapbacked().
>
>Move the counter update before folio_put().
>
>Fixes: dbe54153296d ("mm/huge_memory: add vmf_insert_folio_pud()")
>Cc: <stable@vger.kernel.org>
>Signed-off-by: Yin Tirui <yintirui@huawei.com>
>---

Thanks! Feel free to add:
Reviewed-by: Lance Yang <lance.yang@linux.dev>

