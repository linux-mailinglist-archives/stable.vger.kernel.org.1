Return-Path: <stable+bounces-222494-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UgNsLXLepGnUugUAu9opvQ
	(envelope-from <stable+bounces-222494-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:48:50 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E9091D22CF
	for <lists+stable@lfdr.de>; Mon, 02 Mar 2026 01:48:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 45CA0300D90E
	for <lists+stable@lfdr.de>; Mon,  2 Mar 2026 00:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DA2F1DD889;
	Mon,  2 Mar 2026 00:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b="MIe8Fl9p"
X-Original-To: stable@vger.kernel.org
Received: from linux.microsoft.com (linux.microsoft.com [13.77.154.182])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F25CA10F1;
	Mon,  2 Mar 2026 00:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=13.77.154.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772412526; cv=none; b=JcdxR6ZEBJz+SzJsQ0hrLqMHivrkIT62EDmVC2moX2UVdgCI9SIbISLzl4KCHTIONq5+8f08kXY5HSJP0+zleP2idji8fFOsM8GyeDJxTGJrxORffxif2RjZgQ95kDk8mlEasY/yKNTEfD1WuaSAw+zj48LzwouK7vLa5ENrXI0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772412526; c=relaxed/simple;
	bh=BR1O1he6PPCMO8FScHiunGasIstkotycKge37INNBcE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gi9C3QT30NPmiUFzhmoZxaZIIpffe201NZ9F0pcNpsimouSQocGvKDkY4X/vWXml4FCaZt6sGWitJ0i3FFUQLHUuzmAcnfUBnt+zssMK5Q3r2tgsNsFuakES1D6egizRHX5r/jpQSFdjy9TBfQB841xrCRT5gFjNj2oY/IlWNJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com; spf=pass smtp.mailfrom=linux.microsoft.com; dkim=pass (1024-bit key) header.d=linux.microsoft.com header.i=@linux.microsoft.com header.b=MIe8Fl9p; arc=none smtp.client-ip=13.77.154.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.microsoft.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.microsoft.com
Received: by linux.microsoft.com (Postfix, from userid 1158)
	id A602720B6F00; Sun,  1 Mar 2026 16:48:44 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com A602720B6F00
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1772412524;
	bh=BR1O1he6PPCMO8FScHiunGasIstkotycKge37INNBcE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MIe8Fl9paepaG8TviAGcYVf1uNVjLsux5QUUFSBe4KGoEAacpn7oQ4wifB54+dNGy
	 6VlCg/SAm2k4d7cCp/2NAdBMxerboCVAguDvnxJjbe88qgPJHJFN1it8bB+eqW8JyS
	 QQi2CLfdHbDLpQv5FdKhvQAObjQcjlp6hWb0oYew=
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
Subject: Re: [PATCH 6.6 000/283] 6.6.128-rc1 review
Date: Sun,  1 Mar 2026 16:48:43 -0800
Message-ID: <20260302004843.182026-1-hargar@linux.microsoft.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260228180659.1583364-1-sashal@kernel.org>
References: <20260228180659.1583364-1-sashal@kernel.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	R_DKIM_ALLOW(-0.20)[linux.microsoft.com:s=default];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222494-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[achill.org,linux-foundation.org,kernel.org,gmail.com,linuxfoundation.org,microsoft.com,nvidia.com,vger.kernel.org,roeck-us.net,lists.linaro.org,kernelci.org,lists.linux.dev,nabladev.com,gmx.de,sladewatkins.com,linux.microsoft.com];
	DKIM_TRACE(0.00)[linux.microsoft.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[hargar@linux.microsoft.com,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.microsoft.com:mid,linux.microsoft.com:dkim]
X-Rspamd-Queue-Id: 2E9091D22CF
X-Rspamd-Action: no action

The kernel, bpf tool, perf tool, and kselftest builds fine for
v6.6.128-rc1 on x86 and arm64 Azure VM.


Tested-by: Hardik Garg <hargar@linux.microsoft.com>


Thanks,
Hardik

