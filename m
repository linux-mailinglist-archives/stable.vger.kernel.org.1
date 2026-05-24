Return-Path: <stable+bounces-253989-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id /I69Ngd3EmpXzwYAu9opvQ
	(envelope-from <stable+bounces-253989-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 05:56:55 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A9635C1546
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 05:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id DEFFE300F941
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 03:56:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9132329DB6C;
	Sun, 24 May 2026 03:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b="HPaafM+f"
X-Original-To: stable@vger.kernel.org
Received: from mout-p-201.mailbox.org (mout-p-201.mailbox.org [80.241.56.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395B01E1E16
	for <stable@vger.kernel.org>; Sun, 24 May 2026 03:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.241.56.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779595010; cv=none; b=mkXZas5JhOFGn1R2ZMkiwN6jgXQQGZe9QFKifBRSQMmdpjPjf5A8/b47h1B7OT1I+ITf0e2/vRu0O2dw9dyErNmqzs4BpvigcSLbW7fnQO1gxvjQyxSEtpo12Cap+h0NsN54vW+zjcQvMSKyY3NJdrzy4Y9jgo7t5zr5OM4g0Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779595010; c=relaxed/simple;
	bh=2x1P+vjKTB2F07fEPckD8er4DnqQIMaw2HXzap+rQFs=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=GMgWfelvrzu6dqkXLAioc5bAXHrnGw4QmeN3TMbDQiGDHwd3K+tNl0PSgJ4yuNoEkpY3C7vyC7hUrXUKQJVVZi6IC18xtAoahm/dUUiO21m2E/mRzbqK12DXu41JLReKzscN2jeX3gt0KrG/mxA8Np7QfE+clm9dFyRQBx5C2JQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org; spf=pass smtp.mailfrom=mailbox.org; dkim=pass (2048-bit key) header.d=mailbox.org header.i=@mailbox.org header.b=HPaafM+f; arc=none smtp.client-ip=80.241.56.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=mailbox.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=mailbox.org
Received: from smtp1.mailbox.org (smtp1.mailbox.org [10.196.197.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mout-p-201.mailbox.org (Postfix) with ESMTPS id 4gNQDk4gy0z9tkP;
	Sun, 24 May 2026 05:56:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mailbox.org; s=mail20150812;
	t=1779594998;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=zGe3Tx+jZg2x2Mi1aldqbieT0N3WVolxBA3N8r2vRTs=;
	b=HPaafM+fLGc1+vdKUneEcWU/Q2McLFLd5Y5VzyS0cXyZxb/722iX3KYuk2XFVJH7avtWky
	ud+8oJh726CtI+TdDp2EMYrH4kzvlZI2AdSB728DJvZD3eg6ucYXBCbK4UKvbhAwjqgpYo
	Re8kiHlhs6BLy7e8E3PrU2YohZaMSNWbpHtP30vIhTl1xGXk++CfYuTtcwGFdqXlyAWGm2
	shUmTYXOEd28Lyv8GZAKr1Jt2PReb+MWxB1fge7dJLZ38jsDtdPO408jbe6Rw8s+VXejW8
	rQJHCE6RMe2cQ+Nx36plUJSb87fwo1fJ4/QdF1t55eP7ZnPiOncND6Zi6D9a7w==
Message-ID: <9e585f6c-84e9-4b2e-9899-6770bd2c42fe@mailbox.org>
Date: Sun, 24 May 2026 05:56:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Language: en-US
To: linux-stable <stable@vger.kernel.org>, Sasha Levin <sashal@kernel.org>
Cc: Ian Rogers <irogers@google.com>, Sun Jian <sun.jian.kdev@gmail.com>,
 Namhyung Kim <namhyung@kernel.org>
From: Marek Vasut <marek.vasut@mailbox.org>
Subject: Linux 6.12.91 / build breakage / perf cgroup: Update metric leader in
 evlist__expand_cgroup
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MBO-RS-META: 9j37cocwbr14teq13191hehac57arps8
X-MBO-RS-ID: 881c87258648c983268
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[mailbox.org,reject];
	R_DKIM_ALLOW(-0.20)[mailbox.org:s=mail20150812];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253989-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[google.com,gmail.com,kernel.org];
	TO_DN_ALL(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[marek.vasut@mailbox.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[mailbox.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MIME_TRACE(0.00)[0:+];
	RCPT_COUNT_FIVE(0.00)[5]
X-Rspamd-Queue-Id: 4A9635C1546
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello everyone,

the following commit landed in Linux 6.12.91:

d26e31446c0f ("perf cgroup: Update metric leader in evlist__expand_cgroup")

However, the first_wildcard_match field does not exist in Linux 6.12.91, 
which prevents perf from being built:

"
$ git grep first_wildcard_match
tools/perf/util/cgroup.c:                       if 
(pos->first_wildcard_match)
tools/perf/util/cgroup.c: 
evsel->first_wildcard_match = pos->first_wildcard_match->priv;
"

Either this commit should be dropped, or 137359b7895f ("perf 
parse-events: Use wildcard processing to set an event to merge into") 
needs to be backported too (?).

Furthermore, it also seems 7cfcd01f33fc ("perf tool_pmu: Factor tool 
events into their own PMU") calls parse_events__term_type_str() which is 
also not defined on 6.12.y .

Thank you for your help !
-- 
Best regards,
Marek Vasut

