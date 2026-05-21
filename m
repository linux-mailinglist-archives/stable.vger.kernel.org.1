Return-Path: <stable+bounces-253528-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SJhnDUUND2p7EgYAu9opvQ
	(envelope-from <stable+bounces-253528-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:48:53 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B9BB95A63F2
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 15:48:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2DF3F30FCE2E
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 12:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF2163D9022;
	Thu, 21 May 2026 12:56:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ycfnr0Qb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742133D9024;
	Thu, 21 May 2026 12:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779368168; cv=none; b=YslTE+CSr3W3bVcyPr/2z5b4elhrdyMPW+QNjUTRm7vdd4MjZRmyKtfM1p1SVR1ZrGIS2SsDZ9pj7cApEC7hfOJiTx2Z4+LMNTR/g2wkqXS+R8vNS7XlyNyu4obqicYNQGGLioTbh6cEvoHi4rQtNe1lmiwGYU+SSJUt/ew8d2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779368168; c=relaxed/simple;
	bh=eMvfHEL7MtvLfkaOfm4Ac40HGyLNl15M0ikcIJJ8dvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rUpDkfRq4pQSr3acY7yTmjtNGmyHAZXRqZoVcpnvUcCV9BkdaLvXctD2uP/UVWVeANq3ObKSgaKZOK1WYJ6lhPQVmJcBAERHFDureSmOwSyzEzwZdQp62UYnNoqkCVqofXwiXOCCWlTxOgPnRImH5nztdsMl/Oh+rHkEB4mSJIU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ycfnr0Qb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31F4E1F00A3D;
	Thu, 21 May 2026 12:56:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779368167;
	bh=eMvfHEL7MtvLfkaOfm4Ac40HGyLNl15M0ikcIJJ8dvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ycfnr0QblCmhyYgideIIYkwRnZxcali9+y+iz1S8su5YZRYBFUhIPG0l7pbqq1k8U
	 Safp78AcRSh4FL8L4DKbAoFeekYUszs+j0IAN5/xRI6K2pXH0mZ3DQg+ZQO8H1+2pS
	 Oi95FDeF6Zz7tsiRZkcOCZdSf2pYv8/19RxFShqAqBn35gd17vPFkB4oyiJlB+hD8f
	 AkN0kh2ts+oV4xJA1DgPshsLTn2PVC6Q/osJojwEwCAgba6fg6IDVSVRDTdK+1bm35
	 qLMYkDfnQidLyP30K62FB1E7a/yF7v5S4hYCULZIkk4gpFMeE6wBVw6YMnWM0B9lcw
	 Kaf5MxyiS+n1A==
From: Sasha Levin <sashal@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	patches@lists.linux.dev,
	Amir Goldstein <amir73il@gmail.com>,
	Chunhai Guo <guochunhai@vivo.com>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Gao Xiang <xiang@kernel.org>
Subject: Re: [PATCH 6.12 011/666] erofs: verify metadata accesses for file-backed mounts
Date: Thu, 21 May 2026 08:55:52 -0400
Message-ID: <20260521-erofs-6.12-drop-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ag37lbajmtyv9xBd@debian>
References: <20260520162111.222830634@linuxfoundation.org> <20260520162111.476779194@linuxfoundation.org> <ag37lbajmtyv9xBd@debian>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,lists.linux.dev,gmail.com,vivo.com,linux.alibaba.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253528-lists,stable=lfdr.de];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: B9BB95A63F2
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Thu, May 21, 2026 at 02:21:09AM +0800, Gao Xiang wrote:
> Could you please help drop this too, the same reason as:
> https://lore.kernel.org/r/ag3qlMOcTYM2FBUQ@debian
>
> I will address this backport manually later.

Dropped from the 6.12 queue (along with the 7.0 and 6.18 counterparts).
Thanks.

--
Thanks,
Sasha

