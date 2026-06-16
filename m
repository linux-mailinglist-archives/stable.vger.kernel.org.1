Return-Path: <stable+bounces-263519-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 4/mnFtK7MGoHWwUAu9opvQ
	(envelope-from <stable+bounces-263519-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 04:58:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D8BCA68B94D
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 04:58:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cwbVEM+x;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263519-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263519-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 40407302C79C
	for <lists+stable@lfdr.de>; Tue, 16 Jun 2026 02:57:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2206E3C277C;
	Tue, 16 Jun 2026 02:57:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1984237C91E
	for <stable@vger.kernel.org>; Tue, 16 Jun 2026 02:57:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781578673; cv=none; b=drd5JU82IkvalPcAvx+EG8Q4eKMGCYfk/6Y7qdZolsk69BZqYxLENezDEei1cDUiw2ZPQO4JpwxXsXjRHONR0BUfqiQfkorUyUw0Or32KDiMjuSbbznaPZvJhVC3o9qTt+kkixlBPMSlvXtKroYx9Ft4D9uETJ3ISF+LrtrbsJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781578673; c=relaxed/simple;
	bh=yWnYu809aw4VyCjiZEjn8QlrNbMDvllsqr7kEpvozXQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IJ5NMycYzFf4+ZiTnhXQQ7bt0Q3P43AXstZGDmI1POVWhjm+M4vJgmjTIj7mPjRGy3lWM8JwCkO/T3JuMnYe7bKK7yZR7D5QjgzHdxhsdA19YcjsajZ4Lltb38hZvTKgkGdFiDoWWqQj+vBvoGAb+MVBm630pHIHWpJBbnAqX64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cwbVEM+x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 902101F000E9;
	Tue, 16 Jun 2026 02:57:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781578673;
	bh=yWnYu809aw4VyCjiZEjn8QlrNbMDvllsqr7kEpvozXQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cwbVEM+x2hpfKtqgGBNPWkX3kluPEvtDvdlwzMqVrp1SwhS1dbeXgk5plHwCDIE6Y
	 5h0LZTcAjQ5Pi4munZnob4NgoQQWRdUXasQUy7Kkc1w0dbp5I72JPvDP/lVtaJw7tb
	 Z2ZhMmgi0KXVg80z1F/sYQEDFzbZEmTnZ7kv4Wqd0GYlyf3R8znNxoSuQdQgE+QGTv
	 DOGMoL4/W/obouMBrVjVS3EKs5Xt1qCLhkskpE3jz8s1pAxGPybbgvuZ3YRjWpoe8+
	 zmWMoZvUNNPGhb6fFVsyFvCWx7jPeLfNmaxVtiyy+Nq6r6E6vyMfWkyNnC3tTU7XtK
	 CjQ5QKsOuz3eA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Lorenzo Stoakes <ljs@kernel.org>
Subject: Re: [PATCH 6.12.y] mm/hugetlb: avoid false positive lockdep assertion
Date: Mon, 15 Jun 2026 22:57:43 -0400
Message-ID: <20260616130000.1000001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260615160955.258138-1-ljs@kernel.org>
References: <20260615160955.258138-1-ljs@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-263519-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:ljs@kernel.org,s:lists@lfdr.de];
	RCPT_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D8BCA68B94D

On Mon, Jun 15, 2026 at 05:09:55PM +0100, Lorenzo Stoakes wrote:
> [PATCH 6.12.y] mm/hugetlb: avoid false positive lockdep assertion

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

