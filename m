Return-Path: <stable+bounces-272776-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id Yd/bOOj0TmrIXgIAu9opvQ
	(envelope-from <stable+bounces-272776-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:10:00 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 6970272B997
	for <lists+stable@lfdr.de>; Thu, 09 Jul 2026 03:10:00 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=CNCRDg89;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272776-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-272776-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 3F67230D73B4
	for <lists+stable@lfdr.de>; Thu,  9 Jul 2026 01:05:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B06A538C2DE;
	Thu,  9 Jul 2026 01:04:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2161D38D3EF
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 01:04:54 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783559096; cv=none; b=RjnhuXwaJ+y+OGxTdaz1KAIQtM1RoNGDK7cNnOKZkrSfP2qaBSrkC+4gHkj+HpVMr+msvGAJ2fgeCkg6p4S172Eqcsdvc1kSYpKQQbYRhADrREPMY3+mxS5RJloscPwCpo0bpEzgSI1DbYVosOslEA8ay995SzbmB+HNnadnLUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783559096; c=relaxed/simple;
	bh=8QUExRJTo2K++2VPjUC3JYAGu/pSrkUBYnVqqD0hrew=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rziUFe2rolcBCleT3PLLa1PANX8cOMBsbjEpTeaFlc/UFduKpYzcgB4kVXuXL/DzV3dhRZ3ynqLwj0CvCYwrIEPgNf0rAjmxMF85kdg3RW97TJA8IGmSR9a0DqpdF7+r+zMmeK2RI0CGhznx7/L1XGp92vVM7Cw3b1yzx0biZPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CNCRDg89; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BD061F00A3D;
	Thu,  9 Jul 2026 01:04:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783559094;
	bh=8lPF4LvJLl1uWKhscqc7t8ljIdwptSB+An6FOxpXAoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CNCRDg89ohYfJw2WzoTGnSEZAVZSuSz6GE6lI2hYBfFTyKmM3G/jKNSksXQN1rxzK
	 /o2BQnxpxnVHfshvmcN78jFr2FDkQ7tFKjgOTfmdqnbuyun3QNUNgSI9AJF1q53vST
	 9NWGb59VgjWiuea1AnvvFovTt5yB7neYDW5p6T30AAm3Ir3gXtukYjGcg5eMmUOCYB
	 fJCAs4XSQqZ12lZEU2WBZajR431u9u3OnO03IY3OAj8q/rR5TdRwZhifC9Bq2unPN+
	 ljORehq12+jqGkWkKN5EJENsbpXDKxg7Ztup0cY06Q2vIPiydrokcpRZKiP48Jd8cA
	 Cg4gz0mem25Jg==
From: Sasha Levin <sashal@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Pedro Falcato <pfalcato@suse.de>,
	stable@vger.kernel.org,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Matthew Wilcox <willy@infradead.org>,
	Song Liu <song@kernel.org>,
	Eric Hagberg <ehagberg@janestreet.com>,
	Zi Yan <ziy@nvidia.com>,
	Gregg Leventhal <gleventhal@janestreet.com>,
	Lance Yang <lance.yang@linux.dev>
Subject: Re: [PATCH stable v2] mm/khugepaged: write all dirty file folios when collapsing
Date: Wed,  8 Jul 2026 21:04:47 -0400
Message-ID: <20260708194323.agent5-0003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260708151357.353173-1-pfalcato@suse.de>
References: <20260708151357.353173-1-pfalcato@suse.de>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:akpm@linux-foundation.org,m:david@kernel.org,m:ljs@kernel.org,m:sashal@kernel.org,m:pfalcato@suse.de,m:stable@vger.kernel.org,m:viro@zeniv.linux.org.uk,m:brauner@kernel.org,m:jack@suse.cz,m:willy@infradead.org,m:song@kernel.org,m:ehagberg@janestreet.com,m:ziy@nvidia.com,m:gleventhal@janestreet.com,m:lance.yang@linux.dev,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-272776-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6970272B997

> Fix it by fully writing back the page cache (and waiting) when collapsing
> file THPs. Doing so provides the guarantee that no dirty folio will be
> observed while there are active THPs. To fully ensure this is safe, the
> invalidate_lock needs to be held while doing the writeout, so that
> do_dentry_open()'s page cache truncation excludes this write-and-wait.

Queued for 7.1, 6.18, and 6.12 (with Willy's Reviewed-by and David's
Acked-by from this thread), thanks.

-- 
Thanks,
Sasha

