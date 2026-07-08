Return-Path: <stable+bounces-272693-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id QdIiO1F7TmqLNgIAu9opvQ
	(envelope-from <stable+bounces-272693-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:31:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 0376D728BA7
	for <lists+stable@lfdr.de>; Wed, 08 Jul 2026 18:31:13 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="j5Y/+nm7";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272693-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-272693-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3D81E303E644
	for <lists+stable@lfdr.de>; Wed,  8 Jul 2026 16:18:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EE4742DA53;
	Wed,  8 Jul 2026 16:18:14 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9CF342DA43;
	Wed,  8 Jul 2026 16:18:12 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783527494; cv=none; b=nn3VymO4OQGR1Zo6FHdiRVsptXXSiAWqXbpsWUIK9+WwYPecZQ1uLaoep/VVHUYBuZlRp19Ycym6C4JGoUpNzTqVhM1cHzmD+M3daJcFAqCqXceJVhTzolgHbb5e5N0QgwW++A2cwwSNE+jMOzQ5VA5lCfE9ZsRNEdtMf+IWpko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783527494; c=relaxed/simple;
	bh=jNsVCa9sTInE6can+kIbi2s5bzi8FEA3QkWcregF/jo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FJ9D2SbB7sy+8BPHfv1+7LYczTqM+G2gaD1dPS0215aDxKLfRgQTszs89agvkkRS9xmlN5rCNb80uohSo85OP7aSgorKVIiyAvVSrkKUEvj6P2D3HdMrTh38e7K7sArnXnhvXmfFqsAxFep1Jir7VkZ4cgbz+Wi+FJFJpvYHgfk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j5Y/+nm7; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D25E1F00A3A;
	Wed,  8 Jul 2026 16:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783527492;
	bh=y752DrbBFFJ8XerVisGtOLzv8nsy5PhYRKi3Iy7oc5I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j5Y/+nm76DxQqxVQ2O+uA2O29guRVqRiECEnMndzrX6O1QnnGoIxp2bjapqLS2BHu
	 jVJFtqTe3UugvZNfBbhiRRNC2C5dzNv78ys6CYuC1x7c3La4ymr/QOU9C1SC/ELw9C
	 UtxVp80PMuvpJqW6zgM8iKoa0pRA8QDTVTmAmj4MuUy9sbe6S0HRJapHaQq1eCSqkQ
	 vITo2wO/XYgiIIlxI3nq5Q/sKSYW/K7QydMN4dv/+K9ad5hrS2QHakeJLErVlgknES
	 fagUYCD9M7NlJr1Cdn2xNEudUV4lb+ZY7JRq5CF2pLt/IRAMNRAagZOz01v0W0Jr2A
	 N7vZ4ppo4339g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	linux-mm@kvack.org
Cc: Sasha Levin <sashal@kernel.org>,
	jiayuan.chen@shopee.com,
	jiayuan.chen@linux.dev,
	yingfu.zhou@shopee.com,
	willy@infradead.org,
	Andrew Morton <akpm@linux-foundation.org>,
	Huang Ying <ying.huang@intel.com>,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5.15.y 6.1.y 6.6.y 1/1] mm/vmscan: flush deferred TLB before freeing large folios
Date: Wed,  8 Jul 2026 12:18:00 -0400
Message-ID: <20260708120502.agent5-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708041237.289026-2-jiayuan.chen@linux.dev>
References: <20260708041237.289026-2-jiayuan.chen@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272693-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:linux-mm@kvack.org,m:sashal@kernel.org,m:jiayuan.chen@shopee.com,m:jiayuan.chen@linux.dev,m:yingfu.zhou@shopee.com,m:willy@infradead.org,m:akpm@linux-foundation.org,m:ying.huang@intel.com,m:linux-kernel@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[10];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 0376D728BA7

On Wed, Jul 08, 2026 at 12:12:36PM +0800, Jiayuan Chen wrote:
> Flush the deferred batch before freeing a large folio inline, the same way
> the order-0 path already waits for the flush.

Queued for 6.6 and 6.1 with Matthew's Reviewed-by added, thanks.

> destroy_compound_page was recently renamed to destroy_large_folio.
> So it would be conflict when this patch was applied to 5.15/6.1

It actually applied cleanly to the current 6.1.y (that tree already
uses folio_test_large()/destroy_large_folio() there), but it does not
apply to 5.15.y, which is still page-based
(PageTransHuge()/destroy_compound_page()). Could you send a tested
per-branch version for 5.15.y? 5.10.y has the identical vulnerable code
shape, so a 5.10.y version would be welcome as well.

-- 
Thanks,
Sasha

