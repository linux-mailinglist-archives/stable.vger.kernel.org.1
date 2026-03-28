Return-Path: <stable+bounces-230778-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UMKzOUG1x2nvawUAu9opvQ
	(envelope-from <stable+bounces-230778-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 12:02:25 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C59334E22A
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 12:02:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id BBF363017061
	for <lists+stable@lfdr.de>; Sat, 28 Mar 2026 11:02:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5084334F25C;
	Sat, 28 Mar 2026 11:02:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b="knqIx5Ec"
X-Original-To: stable@vger.kernel.org
Received: from relay.yourmailgateway.de (relay.yourmailgateway.de [188.68.63.166])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE3AD1CD1E4
	for <stable@vger.kernel.org>; Sat, 28 Mar 2026 11:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=188.68.63.166
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774695741; cv=none; b=ItQxZTLC50Gq92bT3CsqO/Oln5eTZPd2dC+LgmTsQQ/cguAv26PoilBjpXGyJq65lJzA6uVBmEyTZDN29YuzIBzqegRSNw6pG0orUy/noI3L9mPAuiTVKZdPuG/7JpTLaGU9gLaeR9JGeRM9FRbxikb2IL7utXza9Ej2BF3l1Ic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774695741; c=relaxed/simple;
	bh=veMyYXhxXpqvvFak3Xu/vibDRr1FACsEnYBpoYLNqLM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EeCVXeo+K9xNGiL5QX7qgprnHEd9N6BreKyT3gx6qc60Q8DQyO6DJuK5fR+bXucT3svEUY+Eh1Nsl+uSA4VA59GE+2op+KRSnH0bfbRBEdshchbMmtSh/ouAe/FXrV9Z+qppVLNBOe44BA/aF4Bd0KiW5+WVdR/MyfSS4rhLTXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info; spf=pass smtp.mailfrom=leemhuis.info; dkim=pass (2048-bit key) header.d=leemhuis.info header.i=@leemhuis.info header.b=knqIx5Ec; arc=none smtp.client-ip=188.68.63.166
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=leemhuis.info
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=leemhuis.info
Received: from mors-relay-8202.netcup.net (localhost [127.0.0.1])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fjZ9Q2rrsz44MQ;
	Sat, 28 Mar 2026 11:52:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=leemhuis.info;
	s=key2; t=1774695178;
	bh=veMyYXhxXpqvvFak3Xu/vibDRr1FACsEnYBpoYLNqLM=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=knqIx5EcroiKaWY8ciLF1LuHE+KTkc7g4Y2WBgdwXYevr7+oN0foIsDxP0XcF60lQ
	 HcwE4nD4R0aXlWylpe6waV4lZYOyRDWoT7TYWGEMSH0L2b+QA6E13TNp13OTzzH7OW
	 t2LtZ+HRa+T7rHP9LS58Hrkpwe1ATF/q+v5bGsw7Y04Rq88FwRfjZG8q146mRh0BU8
	 ox3W4n1WYS9eoEpulS7YSEMMVeCqXsWtWhc/f1KJyvjYEmfSxqzF8hDmn1wKT7DP2M
	 rDas0TFaoIHUOI+EKLniXcW3/ltozxa8CqSxuaC5lBwI37VG/gAaAvk9xKXpX3JArl
	 D4qaOmDhesExg==
Received: from policy02-mors.netcup.net (unknown [46.38.225.35])
	by mors-relay-8202.netcup.net (Postfix) with ESMTPS id 4fjZ9H5TwBz44k3;
	Sat, 28 Mar 2026 11:52:51 +0100 (CET)
Received: from mxe9fb.netcup.net (unknown [10.243.12.53])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by policy02-mors.netcup.net (Postfix) with ESMTPS id 4fjZ9G4f2fz8sZg;
	Sat, 28 Mar 2026 11:52:50 +0100 (CET)
Received: from [IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f] (unknown [IPv6:2a02:8108:8984:1d00:a0cf:1912:4be:477f])
	by mxe9fb.netcup.net (Postfix) with ESMTPSA id CDF6B61741;
	Sat, 28 Mar 2026 11:52:49 +0100 (CET)
Authentication-Results: mxe9fb;
        spf=pass (sender IP is 2a02:8108:8984:1d00:a0cf:1912:4be:477f) smtp.mailfrom=regressions@leemhuis.info smtp.helo=[IPV6:2a02:8108:8984:1d00:a0cf:1912:4be:477f]
Received-SPF: pass (mxe9fb: connection is authenticated)
Message-ID: <9652ce0b-bb4c-489d-9e32-89c5af5c8101@leemhuis.info>
Date: Sat, 28 Mar 2026 11:52:48 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Warnings and errors in drm_mode_config_cleanup when booting
 6.19.10 and 7.0-rc5
To: Matt Fagnani <matt.fagnani@bell.net>, dri-devel@lists.freedesktop.org
Cc: stable@vger.kernel.org,
 "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <a8f058b3-ea2c-4af1-a19b-9ae2db46754c@bell.net>
From: Thorsten Leemhuis <regressions@leemhuis.info>
Content-Language: de-DE, en-US
In-Reply-To: <a8f058b3-ea2c-4af1-a19b-9ae2db46754c@bell.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-PPP-Message-ID: <177469517006.2989398.1210444230681612805@mxe9fb.netcup.net>
X-NC-CID: 3WsP+7u+Zi4gE/cxKm3o5AqJYLfRMSltkqsgs8XAORpOmbx8NME=
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_DKIM_ALLOW(-0.20)[leemhuis.info:s=key2];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DMARC_NA(0.00)[leemhuis.info];
	FREEMAIL_TO(0.00)[bell.net,lists.freedesktop.org];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-230778-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[regressions@leemhuis.info,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[leemhuis.info:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 4C59334E22A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Matt, thx for the report.

On 3/28/26 11:30, Matt Fagnani wrote:
> I could try to bisect. The commit
> e493c135980f90c20308d1a98f2e0d1223951e94 drm: Fix use-after-free on
> framebuffers and property blobs when calling drm_dev_unplug was included
> in 6.19.10 and changed drm_mode_config_cleanup https://git.kernel.org/
> pub/scm/linux/kernel/git/stable/linux.git/commit/?
> h=linux-6.19.y&id=e493c135980f90c20308d1a98f2e0d1223951e94

Did a quick search. Turns out this is mainline commit 6bee098b914176
("drm: Fix use-after-free on framebuffers and property blobs when
calling drm_dev_unplug") -- and when searching for that (FWIW, this is
not widely known, but that is really helpful in case like this, as the
mainline commit id is way more relevant) is turns out that is in the
process of getting reverted:

See https://lore.kernel.org/all/20260326082217.39941-2-dev@lankhorst.se/
or 45ebe43ea00d6b ("Revert "drm: Fix use-after-free on framebuffers and
property blobs when calling drm_dev_unplug"") [next-20260327
(pending-fixes)].

Sasha and Greg: you might want to make sure to pick this up.

Ciao, Thorsten



