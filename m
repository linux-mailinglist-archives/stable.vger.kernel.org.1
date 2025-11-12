Return-Path: <stable+bounces-194641-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F7DDC54754
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 21:32:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C7E3E4F2757
	for <lists+stable@lfdr.de>; Wed, 12 Nov 2025 20:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B8E2C11FD;
	Wed, 12 Nov 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b="MMV7TwLQ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18066266568;
	Wed, 12 Nov 2025 20:24:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762979088; cv=none; b=OhCIB2yqHgz3qB0obX6B2iB6qaeqXVe8DWd3T4JbkAvb/ydRkyAY9dbMg9Tetvbaw0neAT1sRPbgaCX2bZh3YgqIZoCKETG9kCQL2bXbfVJRQ1G7T1zFI8oJ9Aek8yae4fUKNwZ1ZAW6RqPCbpiQGs0o3m+dxIwTId9TxFPFAuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762979088; c=relaxed/simple;
	bh=TW9NSBuZC0pCuqNjfj0PDRPjYM0/XDdyBFkYzlhTUz4=;
	h=Date:From:To:Cc:Subject:Message-Id:In-Reply-To:References:
	 Mime-Version:Content-Type; b=O4urPvFt2zIhfjXXBYwjr9zPXBFE9yTZUx2PYgp/CDraMgu8geF7aIcSKMhmV5dqE6DNfT2xYrNAs9gi/9qJatYRUkKcVQ2+p9D5J8Tgoe/5zdtppFevgdLfWRxAMtitxwGdN86WcgNKmZ8S/9hekSzaSKAehG74Zg/Z/HltGMA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linux-foundation.org header.i=@linux-foundation.org header.b=MMV7TwLQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F883C4CEF1;
	Wed, 12 Nov 2025 20:24:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
	s=korg; t=1762979087;
	bh=TW9NSBuZC0pCuqNjfj0PDRPjYM0/XDdyBFkYzlhTUz4=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=MMV7TwLQJIgxVHH9Jfnn46TzH8kkfNaH3YCBvwOtvaROgcrfmaOqvv1Qxyj2a9TSq
	 d59+NX27bhJounNl3b67AuiZlrcIpp9Pcs/XTM8FabyhC4qlmByxyR1JDVPmcsFkgf
	 8YB4+GRYweYr9seeG6OE4aQ5UMPKXUBln5Ehofag=
Date: Wed, 12 Nov 2025 12:24:46 -0800
From: Andrew Morton <akpm@linux-foundation.org>
To: "Liam R. Howlett" <Liam.Howlett@oracle.com>
Cc: Suren Baghdasaryan <surenb@google.com>, Vlastimil Babka
 <vbabka@suse.cz>, linux-mm@kvack.org, linux-kernel@vger.kernel.org, Lorenzo
 Stoakes <lorenzo.stoakes@oracle.com>, Shakeel Butt
 <shakeel.butt@linux.dev>, Jann Horn <jannh@google.com>,
 stable@vger.kernel.org,
 syzbot+131f9eb2b5807573275c@syzkaller.appspotmail.com
Subject: Re: [PATCH] mm/mmap_lock: Reset maple state on lock_vma_under_rcu()
 retry
Message-Id: <20251112122446.e1f2c037550dc591a4d6b307@linux-foundation.org>
In-Reply-To: <aoq7jyue2qamctxmvtlic4nv53phskj6k7iizh7k6kwruwdgxk@qgjnaib7xgze>
References: <20251111215605.1721380-1-Liam.Howlett@oracle.com>
	<8219599b-941e-4ffd-875f-6548e217c16c@suse.cz>
	<CAJuCfpESKECudgqvm8CQ_whi761hWRPAhurR5efRVC4Hp2r8Qw@mail.gmail.com>
	<kfqzb2dfxubn6twcbiu3frihfkf6u34g2rcnui2m63rbc4x4kk@dh3bxvpzpnmp>
	<CAJuCfpEWMD-Z1j=nPYHcQW4F7E2Wka09KTXzGv7VE7oW1S8hcw@mail.gmail.com>
	<aoq7jyue2qamctxmvtlic4nv53phskj6k7iizh7k6kwruwdgxk@qgjnaib7xgze>
X-Mailer: Sylpheed 3.8.0beta1 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 11 Nov 2025 21:18:19 -0500 "Liam R. Howlett" <Liam.Howlett@oracle.com> wrote:

> > Prior to commit 0b16f8bed19c ("mm: change vma_start_read() to drop RCU
> > lock on failure"), vma_start_read() would drop rcu read lock and
> > return NULL, so the retry would not have happened. However, now that
> > vma_start_read() drops rcu read lock on failure followed by a retry,
> > we may end up using a freed maple tree node cached in the maple state.
> 
> Yes, sounds good.
> 
> Andrew, can you make this change and also drop Cc stable tag?

Done.

> This needs to be a hot fix, as Vlastimil said earlier.

Yup.

