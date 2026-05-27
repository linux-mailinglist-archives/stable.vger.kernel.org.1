Return-Path: <stable+bounces-254665-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 5huHMcNKF2qaAAgAu9opvQ
	(envelope-from <stable+bounces-254665-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:49:23 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 3ED135E9A64
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:49:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8A226304AF98
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C173B19D4;
	Wed, 27 May 2026 19:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V9bjadob"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926E83B19BB;
	Wed, 27 May 2026 19:49:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911358; cv=none; b=foc62orVQZlLmkIbZrwdtIigPu7SA3uPDKRcrCfrUvikSqGmxjq3PExX3K79RTYtL/K6sVikHH6QkVRHIxbKFxXoCpzWY6rXEVsDSdQXjEcKOM/h5WviOaE894Ilr1WDw32h+9Ul2inB1hSK/+CFt59WArXRJqs7zL/d4vB0zJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911358; c=relaxed/simple;
	bh=5GJFHkrSa+bxpqoV/I+Z7s+0/NL7EyQrEZSwD+hHdHQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NKLjO64IeO4kzb91Fo3tNWs7GN5AAXMRVk37fvCRk+8QQQ+ogne9TxFcE7itsT9hVwI+4iJWp3G/likdNZYS1/exJVAX9/t/UniHSwyc6p1P0GkvwBFhp5gpjt6g/NmqDBxMdRCPJXDOcoQkUjmG5rxFmbJHa+4nFJ43HHjqZZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V9bjadob; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E5071F00A3E;
	Wed, 27 May 2026 19:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911357;
	bh=5GJFHkrSa+bxpqoV/I+Z7s+0/NL7EyQrEZSwD+hHdHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V9bjadobAk10i/uj2JHpqUqhCCu2pvRx9IfnZTpMRgTdp6iGkM17GBP75KnicUA8j
	 iKni3PmnWx/OWJJgV63j68CFCf98EYVTpuaXgrh5KowjXB72AuNs71qSjJY3rQRKJb
	 NcMQ9wYkt/otSylgwsKrApkZeV7QhaHtYG2EMdxbrTq9w6Ksz0hFWzqdL4g43U5H6h
	 XKUN+Cq0y46hC0CvnXM3LLGkYsit7lQ815+IxjqsRkMRp2+XWkEchOkzAYbW8MB5WZ
	 ufZDtXcafvR9vYeTDOUu0TBxa75ZYbOvASx91KahcP4e/+Siw5fGb7SzYVmFq54LuU
	 V4C3pTiYoieXQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Alice Mikityanska <alice@isovalent.com>
Subject: Re: [PATCH 6.18 648/957] ice: Remove jumbo_remove step from TX path
Date: Wed, 27 May 2026 15:48:57 -0400
Message-ID: <20260527-agent5-item003-ice@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <CAD0BsJXt3QurRvFmOGNzh1juYYcQEst=3aYJmHiCCf-4DCZCVw@mail.gmail.com>
References: <20260520162134.554764788@linuxfoundation.org> <20260520162148.582539866@linuxfoundation.org> <CAD0BsJXt3QurRvFmOGNzh1juYYcQEst=3aYJmHiCCf-4DCZCVw@mail.gmail.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254665-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[8];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3ED135E9A64
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> Sorry for the late reply, I see it's already applied. This commit
> depends on "net/ipv6: Drop HBH for BIG TCP on TX side" (part of the
> same series [1]). As far as I see, this dependency was not applied to
> stable trees, so removing this step from the drivers is not correct.
> Either this commit should not be backported (reverted), or the entire
> series can be backported, if eligible. This consideration applies to
> all stable trees.

Thanks for catching this. Reverted 8b76102c5e00 on 6.18, 6.12 and 6.6.

Because 8b76102c5e00 was pulled in as a Stable-dep-of for 1a303baa715e
("ice: fix double-free of tx_buf skb"), the double-free fix was reverted
on these branches as well (it would otherwise conflict). The branches
now build cleanly, and 1a303baa715e can be re-backported once a version
that does not depend on the jumbo_remove change is prepared.

--
Thanks,
Sasha

