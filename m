Return-Path: <stable+bounces-230965-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +H49MtVTyWnrxQUAu9opvQ
	(envelope-from <stable+bounces-230965-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:31:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 751FA352EEA
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 18:31:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 50A89300617D
	for <lists+stable@lfdr.de>; Sun, 29 Mar 2026 16:31:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294CF37D105;
	Sun, 29 Mar 2026 16:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dHG7ShdT"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCEA0225775;
	Sun, 29 Mar 2026 16:31:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774801863; cv=none; b=c+4MYbYxlLInE+iXWMzmQppwtao84cuon9G9ycHLKoxT9Mcw5OK05f2xJZSzNazkJlSagcDtJTe/7Z+dWIbLFHj2GwlEv8+hDXgQnfr9Dm9x2lSbYRfvWJrhWMfwsSrLajFixp6YAcc4gsDK5x4BvtL3QpJucZq5QoBPsJPCBUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774801863; c=relaxed/simple;
	bh=jfomB9Uz3yQOLGJFFYlU4E/h6qSYhn0UQnLbpdiUXjE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mAi6M4si8C/rE8wn0c3XMIHnoPz2y3aZb0+4B/m4V1QEIBLr0SLTxaNUa9AWoHN9me6yyZMcw15WkH8/CBkCSCrPdETwcTIiQ1dmWf/rO3KmAyX/OkE+J/CavOJ2QZGl74glu9DiTl0Ni+Di2TM9FyOoz/0qyunbbNsyX4rgXDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dHG7ShdT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3AD00C116C6;
	Sun, 29 Mar 2026 16:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774801863;
	bh=jfomB9Uz3yQOLGJFFYlU4E/h6qSYhn0UQnLbpdiUXjE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dHG7ShdTq4l3d6sHIW1dKby7NFGmjqzGd+TXp57D8BVzl/iJVCDKDzB0LI1tnyGxl
	 siLf+hTFcVFIh/pMHqOdC1PcYNjRxbXsDjrf+6njnToTCRJp7j5DP/ghiyhDYQvQtR
	 zjNa8XKhNh5twdNNd1cOdEGd8n0YLYgz8OFG0QuFx54mB+avi4B1uVaiuji9EKRmKQ
	 OMcPOhhHK/BawZLeRvMH3KSoRRwM10J3FAyFsjCmCr7NRPUlw8qCTU03efBkaKpbkn
	 figLIapySep2Ym99cd7Z8BkaK4EzHJVp+GHr6IEL82cg1Ptj7Mc/v1257RdRhn7C49
	 XDfuDmqdwwvaQ==
From: SeongJae Park <sj@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	"# 5 . 19 . x" <stable@vger.kernel.org>,
	David Hildenbrand <david@kernel.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Lorenzo Stoakes <ljs@kernel.org>,
	Michal Hocko <mhocko@suse.com>,
	Mike Rapoport <rppt@kernel.org>,
	Shuah Khan <skhan@linuxfoundation.org>,
	Suren Baghdasaryan <surenb@google.com>,
	Vlastimil Babka <vbabka@kernel.org>,
	damon@lists.linux.dev,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org
Subject: Re: (sashiko status) [PATCH 0/2] Docs/admin-guide/mm/damon: warn commit_inputs vs other params race
Date: Sun, 29 Mar 2026 09:31:01 -0700
Message-ID: <20260329163102.58683-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260329154917.47598-1-sj@kernel.org>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230965-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 751FA352EEA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Sun, 29 Mar 2026 08:49:16 -0700 SeongJae Park <sj@kernel.org> wrote:

> Forwarding sashiko.dev review status for this thread.
> 
> # review url: https://sashiko.dev/#/patchset/20260329153052.46657-1-sj@kernel.org
> 
> - [PATCH 1/2] Docs/admin-guide/mm/damon/reclaim: warn commit_inputs vs param updates race
>   - status: Reviewed
>   - review: ISSUES MAY FOUND
> - [PATCH 2/2] Docs/admin-guide/mm/damon/lru_sort: warn commit_inputs vs param updates race
>   - status: Reviewed
>   - review: ISSUES MAY FOUND

TL; DR: I believe those are not issues.


Thanks,
SJ

[...]

