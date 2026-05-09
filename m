Return-Path: <stable+bounces-244959-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oCRWOjBG/2mo4AAAu9opvQ
	(envelope-from <stable+bounces-244959-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 16:35:28 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C7B3500148
	for <lists+stable@lfdr.de>; Sat, 09 May 2026 16:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C7AB302A509
	for <lists+stable@lfdr.de>; Sat,  9 May 2026 14:32:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFA5B3947B7;
	Sat,  9 May 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a8JDdvsN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81EC03939C0
	for <stable@vger.kernel.org>; Sat,  9 May 2026 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778337127; cv=none; b=T00dk6hOKx589lk1cMdIIHOfYuoagmLkT8oRPiejqFn9oeYcAYgKfvlATitYcJiBXY2GU9mic8+CAm6/jv46Q96zddwpwfF/cjXyaRNGj5wuqjHzMwkXZlX8RrcsG4PUzISI5wFoTF8yLg/T8KvtYKYvh8XetttWi+mmckmwzAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778337127; c=relaxed/simple;
	bh=TEzaMXa4lKNAJIA9AA2wtObObFMu9eb66eNrbvWCTww=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=WYG3CU15uFBUNpsfap9IRFFk9IZhwi7mtJmx0YLVvdhI830+64B2ZlIQki9XmE0EEmw/VNpx3C2/LA1aC869QOdD0xgAFSIIvUfRRMzxyZdKbHeGgAzOOOpz6TzfZs14fvAIZVjBZr3BH4fRStXkwFaCN8lfoq15Iu3zOA9nFcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a8JDdvsN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85B93C2BCB2;
	Sat,  9 May 2026 14:32:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778337127;
	bh=TEzaMXa4lKNAJIA9AA2wtObObFMu9eb66eNrbvWCTww=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a8JDdvsNc5Ijh0ruEOEBr4aOPYp95OX3zGXqjwmcCSoxTclW5WCvMlzX7cGBfEIom
	 /L7Zmr8Cp4tCg04cRvwzMq1vsjQAn6P+6CYmYI1rO+hUpynSy+ds4jbzKtFCtE4x+P
	 8mtskJ9hbUHylt/2pO0CwvCBxcxn6AfRdR4ogh4wOHs+jXEXi5IwCFgbZHiz7gh1so
	 6fjvQgVxeOYkDDUJx1rwGBBZRj3GgFDodG6Y7ZaVMfjP+gISm76Ui207376KOb0gR7
	 x5Eq4szYShynupIHTP4P2I/29iMng1UybLVlfui5W7Xo3jyppWkTwZ0Xh51SNrJNLh
	 ndYMYKzC+5X1w==
From: Sasha Levin <sashal@kernel.org>
To: Greg KH <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Yuan Tan <yuantan098@gmail.com>
Subject: Re: [STABLE] Backport requests for net/crypto fixes
Date: Sat,  9 May 2026 10:32:00 -0400
Message-ID: <20260509143000.stable-reply-0001@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAPuPA7LbrC=2gbvD6xJ14hAW5NphBePvUiUu1j2c5aM2W_Ey=w@mail.gmail.com>
References: <f0c6e3a5-2043-4611-9f6d-515aeb4922f6@gmail.com> <2026050731-copper-enactment-3ca4@gregkh> <CAPuPA7LbrC=2gbvD6xJ14hAW5NphBePvUiUu1j2c5aM2W_Ey=w@mail.gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9C7B3500148
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-244959-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-0.998];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

> 2) 426c355742f0 ("net: af_key: zero aligned sockaddr tail in PF_KEY
>    exports") - targets 6.12.y and 6.18.y; cherry-pick is clean.

Queued for 6.12.y and 6.18.y, thanks.

> 1) 629ec78ef860 (mpls seqcount) - cherry-pick conflicts on 6.12/6.18;
>    I'll send manually-resolved patches later.

Sounds good, will look out for the resolved versions.

--
Thanks,
Sasha

