Return-Path: <stable+bounces-233833-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yGj1Kccz1mlZBwgAu9opvQ
	(envelope-from <stable+bounces-233833-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:53:59 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F9E33BAF9E
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 12:53:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 85D0F3083833
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 10:52:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A67203BADA0;
	Wed,  8 Apr 2026 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZhG67efA"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697983BA23D
	for <stable@vger.kernel.org>; Wed,  8 Apr 2026 10:52:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775645528; cv=none; b=KWwN5Q4wo+zTxD2koDpQoC3xhxf2MWPKjX4rZLVPkahWn6Ozoyfay/l9b3EoKUNrAA3Ar2PbWDeLv8dfBlMyyendFfz2dj3Xy0TwavOWPG81Vc43tXHacQdXWd6M6ayO5lz85RtD1git6tmFFftBKO5VYs0iCLfiZcYeL1ytBEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775645528; c=relaxed/simple;
	bh=yDu0gC7eq+O6pDFcogAkMHO8eV8lkcwTMB4+UoqtFKg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NnEMF5G/IT6gDWo3zRABdt9HYfHJ3qHirI8nmC8ErellnQuqIcb4iIe/o23wjCBZ7Snb7jHfzfwdVlZ10vCyyTp/Q/Z3wmdEChb+YlcceuFwCjs98EwGLKszQ8foOOIoFYuy9Ck1Xu5VhfXI1PqHmpc3kQ9JAsL/P4qFVQlTB0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZhG67efA; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9446DC19424;
	Wed,  8 Apr 2026 10:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775645528;
	bh=yDu0gC7eq+O6pDFcogAkMHO8eV8lkcwTMB4+UoqtFKg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZhG67efAMngwJXZSlCoRBFieZXVyggtSLsK33fb05hevRqg9Enwj1wzJRkIxNfRLQ
	 meavoFU+iYj71k9vHcQU7xehOMM2Nw1HAPc515sgWxk5u6R7xN810klFBXivY0nnjF
	 04anKzk6Hjftk+wzDpaS6o0frWKR1/z18B2XM4iG08JvBynMLU/0AmyofPEwfOwCQm
	 H4nx0abvoXBeCIlZCHV5wH5olsCVLNf1iGc/SKLWFGEGorAIW7i6mfaB5XB32zit1+
	 UbYI8fvXcHWielrwluPJZnOLgt8x54hE7ytAr+JtfbfdVZy7HdBu+ot9YFge1h4M1X
	 9e5kRr2/RyNUg==
From: Sasha Levin <sashal@kernel.org>
To: SeongJae Park <sj@kernel.org>
Cc: stable@vger.kernel.org
Subject: Re: [PATCH 6.1.y] mm/damon/sysfs: check contexts->nr before accessing contexts_arr[0]
Date: Wed,  8 Apr 2026 06:52:06 -0400
Message-ID: <20260408105206.946496-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331052959.77831-1-sj@kernel.org>
References: <20260331052959.77831-1-sj@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-233833-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3F9E33BAF9E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> check contexts->nr before accessing contexts_arr[0]

Queued for 6.1, thanks.

