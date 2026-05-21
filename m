Return-Path: <stable+bounces-253525-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4LnSKQ4JD2rREQYAu9opvQ
	(envelope-from <stable+bounces-253525-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:30:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 4665E5A5CF0
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:30:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 8DF76333240D
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3040F3D7A10;
	Thu, 21 May 2026 12:56:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P5VeYSit"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3C133D5C07;
	Thu, 21 May 2026 12:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368165; cv=none; b=FUC+lYi3uNFlloxjck4r7KRY+2cKyNN3ZY6DpOgFcx2dkMXAimmzjvxYK2ZA/uj+rcPCdOmCOnGYz8W0tSTBWEllLlLhGqexWHHpBISMZZCEM38DhMBk78GPALycMAQfeDFXRStk4xiidqL5RlbumCdwHS61C8PtwBOqzlPksAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368165; c=relaxed/simple;
	bh=cGAOEk/BS9g0ORqNG3RPLiO05FOY6U45mKLq8mlH1DM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fiDxV5Rv+WfDaP+IinaUshg/c1IR0W7ExbQWAzzZ/0Aai29CKAskD2O59/xPCGmmIjMje9Dpj/qDJrYzVvO5Cp5BQQLWuTCci6aAmVXUSBD+MEighV9+vzYdXfylVnGaK80D2+hVEAdMT9dz4qWV5JpAn8yuw7MnUiEmd74d9bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P5VeYSit; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81D51F00A3D;
	Thu, 21 May 2026 12:56:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368163;
	bh=q4KkQorSbqg5xss/YHGbVyOANe6/d0XJCXGzLOian7w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P5VeYSit4YdJkaiGa5yPaC76P/sU8nGN8G1xequMyGVSaq+gOvYTplqJ1LhAQCXzc
	 0aFRGbKzv+LIM2opUFdMY2ifizbspA7C0Unm3//8u6IvwPffidSqht7tVGg2gcexi7
	 otSMXd94RGjsGQcb6mFg2xaMGGH56gyWGyVdcUhGs9KpOFhwr8Gs53/lY07/A4jF0i
	 +CkfJuBr7zO81hGe9JaXWC5kDK73at7dRmYhPQwPwvfZ8Kcn7NGTFYACovdiPgkdcL
	 Ju022uZVLcdJLs13b4MgDvPEE45LUuhuJ6hh5OkdCG0ZZZfaeHGPzR2rgmO2Va7GzH
	 tqG3mpRhW1WXQ==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
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
	sudipm.mukherjee@gmail.com,
	rwarsow@gmx.de,
	conor@kernel.org,
	hargar@microsoft.com,
	broonie@kernel.org,
	achill@achill.org,
	sr@sladewatkins.com,
	Florian Fainelli <f.fainelli@gmail.com>
Subject: Re: [PATCH 6.6 000/508] 6.6.141-rc1 review
Date: Thu, 21 May 2026 08:55:49 -0400
Message-ID: <20260521-6.6.141-perf-dso-rel-drop-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <fbe52f15-5b34-4e03-88e0-005ae6200a60@gmail.com>
References: <20260520162058.573354582@linuxfoundation.org> <fbe52f15-5b34-4e03-88e0-005ae6200a60@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,linux-foundation.org,roeck-us.net,kernelci.org,lists.linaro.org,nabladev.com,nvidia.com,gmail.com,gmx.de,microsoft.com,achill.org,sladewatkins.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[21];
	TAGGED_FROM(0.00)[bounces-253525-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 4665E5A5CF0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, May 20, 2026 at 01:33:49PM -0700, Florian Fainelli wrote:
> perf fails to build with:
>
> util/symbol-elf.c: In function 'dso__process_kernel_symbol':
> util/symbol-elf.c:1379:7: warning: implicit declaration of function
> 'dso__rel'; did you mean 'dso__get'? [-Wimplicit-function-declaration]
>     if (dso__rel(dso))
> [...]
>      perf tools: Fix module symbol resolution for non-zero .text sh_addr
>      [ Upstream commit 9a82bfde4775b7a87cd1a7e791f46f83ae442848 ]

Dropped from the 6.6, 6.1, 5.15, and 5.10 queues -- the dso__rel()
inline came in as part of the dso refcount refactor that was never
backported to those versions. Kept on 7.0/6.18/6.12 where the inline
is present and the patch builds.

Thanks for the report.

--
Thanks,
Sasha

