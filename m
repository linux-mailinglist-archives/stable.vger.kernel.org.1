Return-Path: <stable+bounces-256923-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UD48EuQGG2o4+ggAu9opvQ
	(envelope-from <stable+bounces-256923-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:48:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id D572F60DD4A
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 17:48:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 30C6F300598E
	for <lists+stable@lfdr.de>; Sat, 30 May 2026 15:48:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2171432B103;
	Sat, 30 May 2026 15:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FsZoIXBg"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DEAA30674D
	for <stable@vger.kernel.org>; Sat, 30 May 2026 15:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780156102; cv=none; b=rNuPYlKfVHMXWODhFR+XykHvKf1U3jxILK9FW5rBcZd5L0Nx4Rc+vfxe/SdWNGmklejuoareAYDPx6Ut1auSDTJ61m0QsWOTAQuZvIeJWqcd4cfbiKBjg2vQRv+BhOdpHlsdC4Xy1rmgIID1AstNQu0JbxEdBvpvG6pqNMprRQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780156102; c=relaxed/simple;
	bh=KK5trfHvQP+eLuUaa3rCS/v+f3tqRJ3ZdeYUUatbILw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRmtquTcgcm9KSii4WUxYaVsZWpHr9D3DByujFhbkZpySdNUDZsNi4leoBUFd2U0dj+qMBkrXm8bIqwEPyUBixeo8CuBfM2Z9LZMRBURysGd7BIAo+IUCWWNvVdBt51Dd4KL4GvNbLhIl2PKKEM6PSioPlj/Ca+Dp8zIyoP2XNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FsZoIXBg; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DFFB1F00893;
	Sat, 30 May 2026 15:48:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780156101;
	bh=KK5trfHvQP+eLuUaa3rCS/v+f3tqRJ3ZdeYUUatbILw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FsZoIXBgTvB5lVzQ+Ynh/AMfTc2melNO+DKt4h+Ut2x8cnA5gkbXh8NjUBHPDGbmP
	 4diH3SG3+gzlOg/9QugKEsuAt4DHihEmTP57V8hmpYHF5w95ulURcDakYzVrhmsVMu
	 FTwQNOLAXBTM4UWrKsosAg57IBt1oaoIY8q9QNmFIj2b0gHTMRDFOU8f76dqQrnIZj
	 /4Ch/aLCtAIt9ragvyMt6BQg7C/xWZ0JXa+VXu9LSu3L2+SlrsCwcxL7FpmDyY4ejA
	 HBlGvIrEyGz89XmZMdCdJS4I8VVVQGTSGf4L7OOzApohNmXtFiY0/O6oxHOsLsU75t
	 GBhXIG1chuKIw==
From: Sasha Levin <sashal@kernel.org>
To: kernelci-results@groups.io
Cc: Sasha Levin <sashal@kernel.org>,
	gus@collabora.com,
	stable@vger.kernel.org,
	KernelCI bot <bot@kernelci.org>
Subject: Re: [REGRESSION] stable-rc/linux-5.15.y: (build) mixing declarations and code is a C99 extension [-Werror,-Wdeclara...
Date: Sat, 30 May 2026 11:48:17 -0400
Message-ID: <20260530150204.sun4i-decl-after-stmt@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <178014594367.7862.7999857847041901052@330cfa3079ca>
References: <178014594367.7862.7999857847041901052@330cfa3079ca>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-256923-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: D572F60DD4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> New build issue found on stable-rc/linux-5.15.y:
> mixing declarations and code is a C99 extension
> [-Werror,-Wdeclaration-after-statement] in
> drivers/gpu/drm/sun4i/sun4i_backend.c

Dropped the offending patch from the 5.15 and 5.10 queues. Thanks!

--
Thanks,
Sasha

