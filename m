Return-Path: <stable+bounces-223469-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Egn8H+X+rWk++gEAu9opvQ
	(envelope-from <stable+bounces-223469-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 23:57:41 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CD792232950
	for <lists+stable@lfdr.de>; Sun, 08 Mar 2026 23:57:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C0E123013255
	for <lists+stable@lfdr.de>; Sun,  8 Mar 2026 22:57:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A91DF352C22;
	Sun,  8 Mar 2026 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l+5HlSG6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C5430C361;
	Sun,  8 Mar 2026 22:57:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773010655; cv=none; b=OD7sNHxJMzrpn6dD9zfLReDCFe5IeyU0ulcT97mtmeaBHr8wfApFGhLw5uerjX6m9K8EuaNRfdxtrXdg66KcD4cfMDxFrCrvAa6KxhND2qvd5aGnLu9M2YAiZj3x3GgsBi2xpC/9Tx5uA+DGTyzqSxqHNrCcUZgLEtMo3PZ1v7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773010655; c=relaxed/simple;
	bh=ZOJ72oPZsRu+xMwquAb+ZZVrruw6imeSEYptHT8O3Po=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TYeap1WVBVC/XYqw3DSEmlAa0Cp6FrQBEn73UeALNP6U2kWzMWsJBd8GopXkQKKk1PEpuOEpTzK2wjZjBlD5Ho6PcESBZ5PwgCrntgLk++KqxAC1h9HZLKr5IlL9m+l77FeoeHOyutP17M24m5p+MFQLMYfUG24O/65JACRFgx8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l+5HlSG6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA7D8C116C6;
	Sun,  8 Mar 2026 22:57:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773010655;
	bh=ZOJ72oPZsRu+xMwquAb+ZZVrruw6imeSEYptHT8O3Po=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l+5HlSG6e94taQUfx8yhbisqeha0oQZ3NyJXNiW4uzmYqOCb1NNym9XzAIbwlQsw2
	 mszbzooN5/3Dh952IevwDmafn4SimCe3vUYLhfNMEwFSaPgy6MMd1SceDxdMv5D8C3
	 TL+/4sIhqzeCuj4BxPgdhXmF4ck6uG1KQN+sUDnHmLA9GqNH9Xp7DU1z8wX2wSjk6a
	 VD+hZuWFis3HvGnn6pB2aKvTZoz7GFDNpEw0pcWxZhmNqAosPG97ZzPOoaKsp6iv7y
	 JZj5AilQm/PnpPt2E9yMTLr1sdHahGG6dWX1sKMwMnnp/i0ohM6BHZGRzKkPZ2qxZg
	 66HGufW9gPDug==
From: SeongJae Park <sj@kernel.org>
To: Jianhui Zhou <jianhuizzzzz@gmail.com>
Cc: SeongJae Park <sj@kernel.org>,
	aarcange@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	jonaszhou@zhaoxin.com,
	linux-kernel@vger.kernel.org,
	linux-mm@kvack.org,
	mike.kravetz@oracle.com,
	muchun.song@linux.dev,
	osalvador@suse.de,
	peterx@redhat.com,
	rppt@kernel.org,
	stable@vger.kernel.org,
	syzbot+f525fd79634858f478e7@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/userfaultfd: fix hugetlb fault mutex hash calculation
Date: Sun,  8 Mar 2026 15:57:27 -0700
Message-ID: <20260308225727.77058-1-sj@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260308134152.6877-1-jianhuizzzzz@gmail.com>
References: 
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: CD792232950
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-223469-lists,stable=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[15];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sj@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.992];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,f525fd79634858f478e7];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Action: no action

On Sun,  8 Mar 2026 21:41:51 +0800 Jianhui Zhou <jianhuizzzzz@gmail.com> wrote:

> On Fri, Mar 07, 2026 at 03:27:00AM +0000, SeongJae Park wrote:
> > I just found this patch makes UML build fails as below.
> >
> >     ../include/linux/hugetlb.h:1214:16: error: implicit declaration of
> >     function 'linear_page_index' [-Wimplicit-function-declaration]
> 
> Thanks for catching this! As Peter pointed out, the
> !CONFIG_HUGETLB_PAGE stub is actually unnecessary since
> mfill_atomic_hugetlb() is only compiled when CONFIG_HUGETLB_PAGE is
> enabled. I have removed it in v2, which also fixes this build error.

Makes sense, thank you for the kind update, Jianhui!

I also confirmed mm-new that updated with the v2 doesn't cause the build error.


Thanks,
SJ

[...]

