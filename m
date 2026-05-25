Return-Path: <stable+bounces-254172-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMwoGIRsFGoTNQcAu9opvQ
	(envelope-from <stable+bounces-254172-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:36:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CB90A5CC5D3
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 17:36:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D392F304890A
	for <lists+stable@lfdr.de>; Mon, 25 May 2026 15:33:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB81328B4FA;
	Mon, 25 May 2026 15:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jG1V/87W"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7724F2E7F3A
	for <stable@vger.kernel.org>; Mon, 25 May 2026 15:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779723206; cv=none; b=s5thWC9hORkLBwXFGnn8hz83RfE/bHQ1OW2xZFV17REJtpQgJVdCb5vQqz66MZ3feP156YEgNHkG8Ub7Ox+nBosFR+qp1nKJU39xHJTZ7GjVaXiaMOniLA0BZuvTRoes7MJOynLeXbWqvTZ8IZ0kFKlsmKudz7janD7vCwvIAhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779723206; c=relaxed/simple;
	bh=Q7nyvNxWNum8pYHLZTZtWGze0dp+I2wHfKEkrHxy+U0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UQxyMypZD12eSRlGOJdtWqzobrsILev0LJuVHs6aHGy+Bb1hMdD6+HclhOu6hwtK9oAs0VyaYxig2dyJYkAAt0x/mn+8Ih7l34ax5fMlTgvpsYMf9hwVxUQmqHWZcuDEbpDfFBNA9RXdMZ6PL9dyGneCSaZ1fIhwkafXKm1G7ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jG1V/87W; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90D031F00A3D;
	Mon, 25 May 2026 15:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779723202;
	bh=vmhaU4LehgEhuU8XsjmmDhht9DuapNxBxNm/utdjoWs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jG1V/87WJXJ/K5t2Q9ZXNqR9j2glu+n0iHQ4kz7C0TIk+ofDRJypIPzjfgk0cInNX
	 OUQ85Qe3pneVj5zjNB9Hob4Gw7cJq8j1iab6wxmau+Fszcra/9BLWbDMrBSx84GV5d
	 xi3t/ZppDX1cs/BvTvKX+BO6aQ40cy9AHL7vO38iRl/CmphtNY4TmcWize8kUQ2aL/
	 t1GV+Hd7kSGNQnRQA3rywe8LRhLs6NL02Ct53nAB9vpY5ixfovWxVQKnNNeH7qtAl6
	 mgWmEJXlzBIPO0zKDydXVgWoQDVK8XorGQDSq77vSptfqz8ujhRspT/7xYn4eQxylW
	 yHYqiv8CEyb8g==
From: Sasha Levin <sashal@kernel.org>
To: seanjc@google.com,
	pbonzini@redhat.com
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Rajani Kantha <681739313@139.com>
Subject: Re: [PATCH 5.15.y] KVM: x86: Acquire SRCU in KVM_GET_MP_STATE to protect guest memory accesses
Date: Mon, 25 May 2026 11:33:08 -0400
Message-ID: <20260525152512.agent5-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260525091427.11691-1-681739313@139.com>
References: <20260525091427.11691-1-681739313@139.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254172-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: CB90A5CC5D3
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, May 25, 2026 at 05:14:27PM +0800, Rajani Kantha wrote:
> From: Sean Christopherson <seanjc@google.com>
>
> commit ef01cac401f18647d62720cf773d7bb0541827da upstream.
>
> Acquire a lock on kvm->srcu when userspace is getting MP state to handle a
> rather extreme edge case where "accepting" APIC events, i.e. processing
> pending INIT or SIPI, can trigger accesses to guest memory.

Queued for 5.15, thanks.

-- 
Thanks,
Sasha

