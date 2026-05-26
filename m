Return-Path: <stable+bounces-254363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 8INLDv2iFWprWwcAu9opvQ
	(envelope-from <stable+bounces-254363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:41:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B37AB5D6B18
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 15:41:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A615E3056C1A
	for <lists+stable@lfdr.de>; Tue, 26 May 2026 13:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6CD83FB074;
	Tue, 26 May 2026 13:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RLGfZKml"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D9923F7886
	for <stable@vger.kernel.org>; Tue, 26 May 2026 13:38:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779802708; cv=none; b=OjJcAA8Be2pSSvTn8fdCnjmXObDD9gugkfkTSg9VNCgQZXDiwpDac3bVjHNSJb/3gfcJFy0fYmepabDIf2FbQW/Iwrs9oU3jrT5BNatAOIjTdWnkA+DTBzx2OCT3zR8h8Au4rjxZWh44JjUasKonUkTMJoc6VoIfN2UadO4XKQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779802708; c=relaxed/simple;
	bh=FdfB2ixwAgYQevbJLLHboUhJBWMGkrf/jRST537KwFw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CjvG5+Sq3KO6wPpbf2X9COMujOhzOHghpiOPdXCp+zK+kP0C056K7pADfBW1aRzX/9fOOr+zcIrsoJ1YKqtYrDg3zek87wjEXl3tc4f9uVLdkXS7bQXbzbZXvBzM7AMjO0VzgwBYxEOYPYfBcQVYwGx0Wu1Pvv0D3/H9yHT5IqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RLGfZKml; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C91DE1F00A3D;
	Tue, 26 May 2026 13:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779802707;
	bh=dvKHnlfYmEfCV/kMllILuA5QJnBW/3lBBy7wjutRepg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RLGfZKml/662N0GbOdptUU4bOa8M4GWgyEKEqHy03ZP8Th2ES76IEP2nklWNdeKvj
	 qCTz5a4y40ue3tPKXPhLGn42q1OrBIg0xNFFsQnBcwQ8QHiCiKUFxDk1azlz7C+Sy8
	 v4wvt4wUa/sKkdvUxghqH8NoPgsp6/NufuGQnIdIhqjFwVfJeoOdikld/ZVwgvVnzK
	 LBkU4E5yPCSCeY0vF0BBSY607teTwQ53STHcrnn2OLaBW92oWD4em5CVZV3Q/WfVJ2
	 FqSLe9uUrJVlTNjnwkpCqQzxPF/lHQqOIFo0/4PE4pULySOJdMUIj10Ff4XBB1D62l
	 yUypsAir2TU6Q==
From: Sasha Levin <sashal@kernel.org>
To: kuniyu@google.com,
	kuba@kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Leon Chen <leonchen.oss@139.com>
Subject: Re: [PATCH 6.6.y] af_unix: Give up GC if MSG_PEEK intervened.
Date: Tue, 26 May 2026 09:38:17 -0400
Message-ID: <20260526140000.agent5-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526054744.4121-1-leonchen.oss@139.com>
References: <20260526054744.4121-1-leonchen.oss@139.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-254363-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,139.com];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B37AB5D6B18
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 26, 2026 at 01:47:44PM +0800, Leon Chen wrote:
> Backport of upstream e5b31d988a41 to 6.6.y.

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

