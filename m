Return-Path: <stable+bounces-235889-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wHgcBTJx3GnAQwkAu9opvQ
	(envelope-from <stable+bounces-235889-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:38 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8840A3E747E
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 06:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7531F3006B15
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 04:20:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F289E382F39;
	Mon, 13 Apr 2026 04:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ndb4GWYz"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EADA438F64D
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 04:13:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776053623; cv=none; b=k2twZ1rNEydiuyEBrAx1BEE0YpLZCkoxWo4uADKnQPJy6/r9csdFYHjQXPYrCmOcw98uKih5rQoM7dGTDDlbigL8W+aKiauQ5KS4VDzmaArDStky6l4qo91J1gDSz5M4u0IFdI3nIMsNeMey2SDRojiLxKN5QqJWgXsqggvARWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776053623; c=relaxed/simple;
	bh=PXglTrIn5b2u/WA4rIz5+EhrHR/Ebs+QAi4yP+w5RQw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwQrDFBWhTzfk89FgKWKU+HvLZOI9H13sTR0uQDcbLBqjasnEuf1yyD3piyT4CZBhuUPKWqlsP8wXH28fO0+h0GrWw2W+2Wgjfgs02+GDAfv4bwEYFONij27jfp7YL/XKcKJ0xDC/LA0kowWEFTXZH5/43WQVEYTR2+WDPA/mtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ndb4GWYz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EEF39C116C6;
	Mon, 13 Apr 2026 04:13:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776053622;
	bh=PXglTrIn5b2u/WA4rIz5+EhrHR/Ebs+QAi4yP+w5RQw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndb4GWYzKPfKMeIA1fKwqKoPYsjcs/WXLWbFtSKmMFNveptd1h3mMLzv7U8AUrzQx
	 2EbPyGMBD7xYK2/wHZ0xJAxgQLL1kvDEtIX3ppBbGUlUZcy/Tu78mM7K3dwP0HxK9a
	 ioLesiV6uT5EjfrXlnUKbl2kG1B1B417gz2FwqtHIiU+gJDAUCEZQWi6Qn74ITpdle
	 obv7mU+x2rZ8gJESfLDzta2zGfkQuiYqm6se8zUaNkS87tq1jcoZNPkdXxS/ccbYdN
	 D6NYoL3uzOSWebCI9bsA7pvoTVizKvmPXA4mD7LwAqVNhgkam54G+z4wHmqYTo/Ff7
	 KzaX7ePu17bmw==
From: Sasha Levin <sashal@kernel.org>
To: "Maciej W. Rozycki" <macro@orcam.me.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Subject: Re: [PATCH 6.18.y 1/3] MIPS: Always record SEGBITS in cpu_data.vmbits
Date: Mon, 13 Apr 2026 00:13:40 -0400
Message-ID: <20260412120103.mips-tlb-6.18-6.6@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260410005000.48927-1-macro@orcam.me.uk>
References: <20260410005000.48927-1-macro@orcam.me.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-235889-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8840A3E747E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> [PATCH 6.18.y 1/3] MIPS: Always record SEGBITS in cpu_data.vmbits

Queued for 6.18 and 6.6, thanks.

