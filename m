Return-Path: <stable+bounces-244826-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KV1MrJR/ml/pAAAu9opvQ
	(envelope-from <stable+bounces-244826-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:18 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F9554FBCCC
	for <lists+stable@lfdr.de>; Fri, 08 May 2026 23:12:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EA1E83044223
	for <lists+stable@lfdr.de>; Fri,  8 May 2026 21:11:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DF8B423173;
	Fri,  8 May 2026 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XB90VjvI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60229423172
	for <stable@vger.kernel.org>; Fri,  8 May 2026 21:11:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778274713; cv=none; b=IYI9E5OTJdgp8xf8C+KIjxz+Ks3OTBj/lo7cLqqvwclD+zODhEe4i8UgG39cpC/7p8XcUQOcEQBgZdl79pw/fYZEQY1WDDA1IKCU22t/k6HWAErT7+KZZULtOzn+HSBKsJvXkSAEK2T8+XYV0q3X/uydvNPA8UM6MHQSGuIaoBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778274713; c=relaxed/simple;
	bh=V5oLQ64CrKr85ohADYEgabaXLtWaV9hgcrnU0L8glA0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q4X3T1BG0+L/0MUoAuMcGuRSD9WwLMytc2A6L/w8yfRBmxVOPSUp8+pQ1vybOlBhZ3kqhX0aZIa8DmFFfksERNSP88/ODJmR1XVsiZ4Hz8JHX1Y3gPeb6/FDPTHDWK35RTVRTJthrHJBhsF9RHrz7RYh7uXCLXcwwIhKisezjcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XB90VjvI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5DF7FC2BCB4;
	Fri,  8 May 2026 21:11:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778274713;
	bh=V5oLQ64CrKr85ohADYEgabaXLtWaV9hgcrnU0L8glA0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XB90VjvI67AutuBnJUJNGVjiyvwZktFz+oNvGdGL4SXaGDhLyh6zf+Am/dVQKZwcu
	 JnBRnWR0nUBI1eGIGvFRVMd/8Kg9bMLDhdyYcx0fX8ES8LRE0wb7T9klKtph+BAJqZ
	 4dn7qO3MRWMzIYl9mM4dbEU2VwjoSKd6gKEMSPRzz9aufZRjdtXZgj6LB6QbJ4upOG
	 5phHc1Zw4XDPLNCZkH821azgf0WEpTEqG7DZhZ+UXX1FHANBz/rio7IL+EBJ++BTcg
	 t+BtuVDFOsBuAJudCf0w+6mNyi2TOz69/npfXw6282YgZCUMx3Aoqe8jjxr6mwLR8+
	 vkhhlYkqOtTyw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	rick.p.edgecombe@intel.com,
	dave.hansen@intel.com,
	tglx@kernel.org,
	torvalds@linux-foundation.org
Subject: Re: [PATCH 6.12.y] x86/shstk: Prevent deadlock during shstk sigreturn
Date: Fri,  8 May 2026 17:11:40 -0400
Message-ID: <0e89a8eaea0b6084-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260507235348.1394848-1-rick.p.edgecombe@intel.com>
References: <20260507235348.1394848-1-rick.p.edgecombe@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 8F9554FBCCC
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244826-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> Subject: [PATCH 6.12.y] x86/shstk: Prevent deadlock during shstk sigreturn
>
> The mainline commit was 9874b2917b9f ("x86/shstk: Prevent deadlock during
> shstk sigreturn"). It depends on a separate stable submission of upstream
> commit 52f657e34d7b ("x86: shadow stacks: proper error handling for mmap
> lock").

Queued for 6.12 and 6.6, thanks.

--
Thanks,
Sasha

