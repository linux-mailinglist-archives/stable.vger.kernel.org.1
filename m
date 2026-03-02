Return-Path: <stable+bounces-222498-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WHPNDFfgpGn5ugUAu9opvQ
	(envelope-from <stable+bounces-222498-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:56:55 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC9E1D2388
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:56:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E05313012C60
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 00:56:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C132D1EA7DF;
	Mon,  2 Mar 2026 00:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="QkvXiaA/"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AE1A1AF0BB;
	Mon,  2 Mar 2026 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772413010; cv=none; b=RM0YrB17AJb0iF/bVk+a367aaAiUWLPeCqLDNO6mx0TZ9iKw5pJq56tNlBzK6YT67iosn7ahv5zV2rxB3vWntV7YsYaGMYiMucNDLnnUAWkv9rB0q8PZdqfSpOi7j1liQwTskqkcmmqvgv1tevLABHzUbv4+xHahFQa7qi4EkvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772413010; c=relaxed/simple;
	bh=PSw5HeOrvSVKRKKFI6Unj9OUKoIJPBRnCWIKHhtwuAk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gBtCjL3BwCm2NoTvfUr4dn77mZKGoETok5lks+A7KytKc6Uxo7mXbmqQcWRDfLYv7SqaCLW8vUADbmSFlLpe/sXOdIEVTddKxJL2cY8Ep+GNu+h/ww5ciOE0l7cugVBgZStZHU12aOioc2YHVSSXIk1EJptcetBFI+yQ8Xnr4H4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=QkvXiaA/; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id 0DD6D20B6F00; Sun,  1 Mar 2026 16:56:48 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0DD6D20B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772413008;
	bh=PSw5HeOrvSVKRKKFI6Unj9OUKoIJPBRnCWIKHhtwuAk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QkvXiaA/6j0aTAYcHNVQ+Opg9TYCB6wNqeO9I4b6Xyspz9GiZOZ+Vf2TwjOVv+YKB
	 VuGAOy87xk7hT2mIiBJP4o0fqngCdIo4TTAdE/o1J19iVhS4O+N0PGvOL7Lvirs0dc
	 3HVKFAXRvfCXdeG1URraFJOYu54BCwUpS6lpysDk=
From: Hardik Garg <hargar@linux.microsoft.com>
To: sashal@kernel.org
Cc: achill@achill.org,
	akpm@linux-foundation.org,
	broonie@kernel.org,
	conor@kernel.org,
	f.fainelli@gmail.com,
	gregkh@linuxfoundation.org,
	hargar@microsoft.com,
	jonathanh@nvidia.com,
	linux-kernel@vger.kernel.org,
	linux@roeck-us.net,
	lkft-triage@lists.linaro.org,
	patches@kernelci.org,
	patches@lists.linux.dev,
	pavel@nabladev.com,
	rwarsow@gmx.de,
	shuah@kernel.org,
	sr@sladewatkins.com,
	stable@vger.kernel.org,
	sudipm.mukherjee@gmail.com,
	torvalds@linux-foundation.org,
	Hardik Garg <hargar@linux.microsoft.com>
Subject: Re: [PATCH 6.12 000/385] 6.12.75-rc1 review
Date: Sun,  1 Mar 2026 16:56:47 -0800
Message-ID: <20260302005647.182416-1-hargar@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260228180001.1567994-1-sashal@kernel.org>
References: <20260228180001.1567994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.microsoft.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222498-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,linux.microsoft.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hargar@linux.microsoft.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: AEC9E1D2388
X-Rspamd-Action: no action

The kernel, bpf tool, perf tool, and kselftest builds fine for
v6.12.75-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

