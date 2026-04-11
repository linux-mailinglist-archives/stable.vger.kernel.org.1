Return-Path: <stable+bounces-235735-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ffk9DGNb2mnb0ggAu9opvQ
	(envelope-from <stable+bounces-235735-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:32:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CC263E0571
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 16:32:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BA3E5300951A
	for <lists+stable@lfdr.de>; Sat, 11 Apr 2026 14:29:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B58B246774;
	Sat, 11 Apr 2026 14:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ue5+mMr2"
X-Original-To: stable@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7219138552F
	for <stable@vger.kernel.org>; Sat, 11 Apr 2026 14:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775917765; cv=none; b=Z8SCfDRdtPuH5X57VSDuOtZyTdnkAbGJr2DP4I6gpMI8L8L6yKhEILLgkphc5gsJB+3+mEEV2b5R1rfWOgWHMsfK23Dea+MDx6Emfzir7gvnoXuwum2k7bDlnFdd77ZqrFCfOx9LHJx4f9Yj+R0Sxb0ojeyPRRfvx1I+bHJRn9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775917765; c=relaxed/simple;
	bh=KrHFq7r4Xovyi5P7utoDg9Lma3g9Qp+emCY4VkvO3AA=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TbFxFU9ZWIsj240Q+AhZv3BQMbOwgnq/iLfvoDzXe3UnhCzxR5i/VUzHTLOJDf6ECf7PonwMJPAP7vE9/V1wvT9QTQrvia75J44tM5wgMEjpwMUz2T0Auba/dWla3DOkJkAx7Ji6nFFpFzJkYwRxPB+yyHgn4jasjRH+pODS22s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ue5+mMr2; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1775917759;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hAPo+F3jMH2I7xItiYLcaM+9S3+H5Eq1ikmT0n242L8=;
	b=ue5+mMr2JI6l0KzmB7iHuu/GYGrv20M/Byg9l+U66V9qTHBKJtg8HUDt8OBOibX0NXZp3X
	ep+l6RAyk7GaqNgsYrfe7SFqpn1CY9DvitpBQGYgg7hCn01OlXHsZYfzR7qWqyfFPtZCuE
	L1CSnGQir9/U6g7ZWPXgFyhlHUqTkcc=
From: Lance Yang <lance.yang@linux.dev>
To: lgs201920130244@gmail.com
Cc: akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	ziy@nvidia.com,
	baolin.wang@linux.alibaba.com,
	Liam.Howlett@oracle.com,
	npache@redhat.com,
	ryan.roberts@arm.com,
	dev.jain@arm.com,
	baohua@kernel.org,
	lance.yang@linux.dev,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH] mm: thp: Fix refcount leak in thpsize_create() error path
Date: Sat, 11 Apr 2026 22:28:58 +0800
Message-Id: <20260411142858.85496-1-lance.yang@linux.dev>
In-Reply-To: <20260411062152.2092967-1-lgs201920130244@gmail.com>
References: <20260411062152.2092967-1-lgs201920130244@gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235735-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lance.yang@linux.dev,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_TWELVE(0.00)[15];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:dkim,linux.dev:email,linux.dev:mid]
X-Rspamd-Queue-Id: 5CC263E0571
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr


On Sat, Apr 11, 2026 at 02:21:52PM +0800, Guangshuo Li wrote:
>After kobject_init_and_add(), the lifetime of the embedded struct
>kobject is expected to be managed through the kobject core reference
>counting.
>
>In thpsize_create(), if kobject_init_and_add() fails, thpsize is freed
>directly with kfree() rather than releasing the kobject reference with
>kobject_put(). This may leave the reference count of the embedded struct

Right. As documented for kobject_init_and_add(), once it has been
called, the error path should go through kobject_put():

/**
 * kobject_init_and_add() - Initialize a kobject structure and add it to
 *                          the kobject hierarchy.
...
 *
 * This function combines the call to kobject_init() and kobject_add().
 *
 * If this function returns an error, kobject_put() must be called to
 * properly clean up the memory associated with the object.  This is the
...
 */
int kobject_init_and_add(struct kobject *kobj, const struct kobj_type *ktype,
			 struct kobject *parent, const char *fmt, ...)

>kobject unbalanced, resulting in a refcount leak and potentially leading
>to a use-after-free.

IIUC, this looks more like wrong kobject lifetime handling and likely a
leak, not a clear UAF :)

>Fix this by using kobject_put(&thpsize->kobj) in the failure path and
>letting thpsize_release() handle the final cleanup.
>
>Fixes: 3485b88390b0 ("mm: thp: introduce multi-size THP sysfs interface")
>Cc: stable@vger.kernel.org
>Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
>---

Apart from that, LGTM.
Reviewed-by: Lance Yang <lance.yang@linux.dev>

