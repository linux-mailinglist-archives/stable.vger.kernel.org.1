Return-Path: <stable+bounces-267331-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ujQYAw/eNGqYiwYAu9opvQ
	(envelope-from <stable+bounces-267331-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 08:13:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FC376A40D3
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 08:13:34 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=leemhuis.info header.s=key2 header.b=IdKmgC6e;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-267331-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c04:e001:36c::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-267331-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=none;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 56D3F3051FEA
	for <lists+stable@lfdr.de>; Fri, 19 Jun 2026 06:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D25356749;
	Fri, 19 Jun 2026 06:13:32 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [46.38.247.119])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 481B7279DB1
	for <stable@vger.kernel.org>; Fri, 19 Jun 2026 06:13:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781849612; cv=none; b=JFIdWH4zJlXirk4/IkD+19SEnJJtYo54I/oDlcI3ZsMM48zL/w0kBysm//aeGv1yjpOkgK0CRCmsJxrsVcITHxw/8Rmiq1/WnD7zNFgLIQ+tTWRRrKtYyJycMd0m5/kn0x162jng5IN+NirM3tIwR7SP0Tc7qEBPQfx9RnyeDtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781849612; c=relaxed/simple;
	bh=czHk8w3aW0ot0ieg7/97cVBD3UZziSY+VYYFIALRKGY=;
	h=Message-ID:Date:MIME-Version:From:To:Cc:Subject:Content-Type; b=ZAKxNK/4Gf0EXd4TkaJEGwJFgWi/alwKdfbZfdm+chVH7bdEfiNy+uFBHH9xMYhVAisRs1R9NN8LsCShzd6ZSO0l4+KuGeQVTXbQ/YqQEeuo3GXS6oH+YKF45b8ixW4XXRI39+ACUDDqnJ6GMj+JuhbU/ZrzHaXaTdTDkyMkxyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=IdKmgC6e; arc=none smtp.client-ip=46.38.247.119
Received: from mors-relay-8404.netcup.net (localhost [127.0.0.1])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4ghRrQ1JYbz8KK5;
	Fri, 19 Jun 2026 08:04:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1781849078;
	bh=czHk8w3aW0ot0ieg7/97cVBD3UZziSY+VYYFIALRKGY=;
	h=Date:From:To:Cc:Subject:From;
	b=IdKmgC6eWDAMvV8+xO8QU63CA3Satz5GDObqUQNIInA3X0pwrrINL7MO3Z7wZFm10
	 Ql/27DNyMpwFcTigbC9wRCSuGEjFZLR+Dn0saSszq2n9BvLoUzB3Dpr9oSDSoM/85H
	 RzwAjL+hjKed1tdPfmfVpce4z+XS807XM2hPlx018LY1X+dXII3m0eceGrcWZj/SVI
	 RIKxbISF2CJKWxDNRo0IWV5S8tWqgfYMaBOmL997gzUuBUgc7IXvSGU59CyUi551IR
	 U2bkagK9x0LQYnNNsxyPNqcySMuvLq6yJuyEGPqzS80cgkcv7SPgqVu1lrw62CDDbe
	 fBDJP5s8tywBA==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8404.netcup.net (Postfix) with ESMTPS id 4ghRrQ0bkxz4xBv;
	Fri, 19 Jun 2026 08:04:38 +0200 (CEST)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4ghRrP1VCcz8sWT;
	Fri, 19 Jun 2026 08:04:37 +0200 (CEST)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id 6C40F603E6;
	Fri, 19 Jun 2026 08:04:36 +0200 (CEST)
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <91281f28-eccf-4681-8f62-faaa8a3ba529@leemhuis.info>
Date: Fri, 19 Jun 2026 08:04:35 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
To: Greg KH <gregkh@linuxfoundation.org>, Sasha Levin <sashal@kernel.org>
Cc: Linux kernel regressions list <regressions@lists.linux.dev>,
 "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: Some 7.1-post fixes that might be worth picking up rather sooner than
 later
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <178184907669.3850665.2040641172586175528@mxe9fb.netcup.net>
X-NC-CID: zuL8hai15E4PBgNtliaoXe0FH4QXsqTcOhOBY6r79lFmYMhdcGs=
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-267331-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:regressions@lists.linux.dev,m:stable@vger.kernel.org,s:lists@lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FORWARDED(0.00)[lists@lfdr.de];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 6FC376A40D3

Hi Stable Team! From the regressions point I think it might be nice to
pick up the following changes for the next round of stable updates (e.g.
7.1.2), as they seem to fix regressions I've seen multiple people report
with 7.1:

* 426e5846eba75f ("HID: Input: Add battery list cleanup with devm action")
* 12f58a6caad3be ("drm/amd/display: Fix Color Manager (3DLUT, Shaper,
Blend)") [v7.1-post]
* 342981fff32802 ("drm/amdgpu: drop retry loop in
amdgpu_hmm_range_get_pages") [v7.1-post] (Alex provided a backport for
this in
https://lore.kernel.org/all/20260616130531.738887-1-alexander.deucher@amd.com/
- this one affects 7.0.12, too)

Ciao, Thorsten

