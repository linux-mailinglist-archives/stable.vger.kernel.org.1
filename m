Return-Path: <stable+bounces-256527-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mMRYLHI0GWqdswgAu9opvQ
	(envelope-from <stable+bounces-256527-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:38:42 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0635FE092
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 08:38:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 628CC31D28CA
	for <lists+stable@lfdr.de>; Fri, 29 May 2026 06:34:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF8263A9001;
	Fri, 29 May 2026 06:34:11 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from bregans-1.gladserv.net (bregans-1.gladserv.net [185.128.211.58])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3411E5702;
	Fri, 29 May 2026 06:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.128.211.58
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780036451; cv=none; b=bzfl0ZiqkX+l07wuyj+NE0rXgaquwvxqTisW7fXOeJj3Is1CcT0r5hHaavPBZcBfFq9gWIYI9T5h/Fx4D/ISm9iXlFyP8JtJa+zNlTUR7f789dMOMmapE13jLB22l+FRpYg8Dmad07WuncTRKJ/xH7DXxJqvQi37l9teuNSWNIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780036451; c=relaxed/simple;
	bh=Z1nQSRVLKkGqvtBrXMvlzdinuPXcDhuG4ErIuUPhHqk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H+zdC753aFEScHsiSLQsOeT8pPjeFAyK0NdilFQPl5WihiUPv7/eFoDnWYujIVaRTI08T32qeNaJ7pMCNJObw3PD2pg6vqJ70BCduJSLmKbvZQwa7xWn+/bynJonOmZ8XGkZvaKPdLgR9oK29raU1er8c3bXTg64QcZvrlNnQp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net; spf=pass smtp.mailfrom=librecast.net; arc=none smtp.client-ip=185.128.211.58
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=librecast.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=librecast.net
From: Brett A C Sheffield <bacs@librecast.net>
To: gregkh@linuxfoundation.org
Cc: stable@vger.kernel.org,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	torvalds@linux-foundation.org,
	akpm@linux-foundation.org,
	linux@roeck-us.net,
	shuah@kernel.org,
	patches@kernelci.org,
	lkft-triage@lists.linaro.org,
	pavel@nabladev.com,
	jonathanh@nvidia.com,
	f.fainelli@gmail.com,
	sudipm.mukherjee@gmail.com,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	sr@sladewatkins.com,
	Brett A C Sheffield <bacs@librecast.net>
Subject: Re: [PATCH 7.0 000/461] 7.0.11-rc1 review
Date: Fri, 29 May 2026 06:33:58 +0000
Message-ID: <20260529063403.35197-1-bacs@librecast.net>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528194646.819809818@linuxfoundation.org>
References: <20260528194646.819809818@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [1.54 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-256527-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_NA(0.00)[librecast.net];
	RCPT_COUNT_TWELVE(0.00)[21];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,linux-foundation.org,roeck-us.net,kernel.org,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com,librecast.net];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[bacs@librecast.net,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.969];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,librecast.net:mid,librecast.net:email]
X-Rspamd-Queue-Id: 4A0635FE092
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

# Librecast Test Results

020/020 [ OK ] liblcrq
010/010 [ OK ] libmld
120/120 [ OK ] liblibrecast

CPU/kernel: Linux auntie 7.0.11-rc1-g547c0212c36f #1 SMP PREEMPT_DYNAMIC Fri May 29 06:18:58 -00 2026 x86_64 AMD Ryzen 9 9950X 16-Core Processor AuthenticAMD GNU/Linux

Tested-by: Brett A C Sheffield <bacs@librecast.net>

