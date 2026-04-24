Return-Path: <stable+bounces-240638-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yOwhH/RV62nkKwAAu9opvQ
	(envelope-from <stable+bounces-240638-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:37:24 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2792845DD44
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 13:37:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 095B63037EC6
	for <lists+stable@lfdr.de>; Fri, 24 Apr 2026 11:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B174A3AB272;
	Fri, 24 Apr 2026 11:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="LliVyQzJ"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 508683BD642
	for <stable@vger.kernel.org>; Fri, 24 Apr 2026 11:35:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777030516; cv=none; b=HanyJ0TmIxQ7dJJA1sYJUE1oPD3O2hJQsOs+vk4VQAqnaBpvYENvAx3QgoyoOJ0QgNO/sC5J6VU49Aes1owCMQcGOM69AToeTGU9XNF2W5CSzvAFr1MCBgN1+DKhiu5OGelNej5UINdMM22ShPs4V1YCQqVAYWrMJk/Fsa3uu5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777030516; c=relaxed/simple;
	bh=ZCCtA1mcKjUMKaDhy47sGrs8WL6RjiWw6Rh/Z1tn+JU=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=j5EnsOXUNrw8loDedlgTR6FShFloiLsIqkSvrUPXIRk4NeBxE8D3XiWviWRpKsxHiQO5j2W+YQTnCyWfT7wqP+rt1+4R2O9zZQSMA+kb0IU3juV7emINg9lJ6m1IGm4F7Lb8N1zqq4RDshFAjFjqEyBOFymshZJEpRF8pJsR1Fk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=LliVyQzJ; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1216)
	id 12C0B20B7167; Fri, 24 Apr 2026 04:35:13 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 12C0B20B7167
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1777030513;
	bh=ZCCtA1mcKjUMKaDhy47sGrs8WL6RjiWw6Rh/Z1tn+JU=;
	h=Date:From:To:Cc:Subject:From;
	b=LliVyQzJqRm/fF1doJAX0osrfdjY0zwPCRb19kdp1ULC0b+Sp3Z/q+H9PG58cWRtV
	 LaUbVmTHdK6VRu6eCGkBrbhiCon2JQc7fRvnPmMwZQNZKhEPl6s4ohpyOpYODqzZJy
	 SBn8qkujIGIrpLlzjKQTrQ3DFg5XW3aNqX0EmSFU=
Date: Fri, 24 Apr 2026 04:35:13 -0700
From: Hamza Mahfooz <hamzamahfooz@linux.microsoft.com>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>,
	Jeff Barnes <jeffbarnes@linux.microsoft.com>
Subject: [REQUEST] crypto backport for 6.6
Message-ID: <aetVcb8pSITaiGg7@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Rspamd-Queue-Id: 2792845DD44
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-240638-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hamzamahfooz@linux.microsoft.com,stable@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net:mid,linux.microsoft.com:dkim]

Hi,

Please include commit 35e13e0eacf4 ("crypto: testmgr - Hide ENOENT
errors better") in kernel 6.6, as it resolves a kernel panic.
(you will also need commit fc0f08317135 ("crypto: testmgr - Hide ENOENT
errors") to have it apply cleanly).

Link: https://lore.kernel.org/r/20260407192859.270745-1-hamzamahfooz@linux.microsoft.com/

