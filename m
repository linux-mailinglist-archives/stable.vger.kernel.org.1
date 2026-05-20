Return-Path: <stable+bounces-249720-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id G8pEJ3UGDWpWsQUAu9opvQ
	(envelope-from <stable+bounces-249720-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:55:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C77C586687
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 02:55:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 16133304BA5B
	for <lists+stable@lfdr.de>; Wed, 20 May 2026 00:54:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25E6F2D5C91;
	Wed, 20 May 2026 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eg9bwUC1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F01712C21C3
	for <stable@vger.kernel.org>; Wed, 20 May 2026 00:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779238472; cv=none; b=OovWUG/r10bgLOJGszo0XhnNxOgksX5j2YMjacGAH2SAoFH0VYj6A5y1IE5MaTb5R38u4liuCxtGFYYTm+k8cM4qnw2lqbUpd0gDN1RMhZJGyisMrfPoyvPvn7ZfrnOB6Nz7l/KJZjDY2ZIDdtY+uB9PyYbsgutTJAlJ6HxuB/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779238472; c=relaxed/simple;
	bh=77TDdl0DPKDwBEIH74qB70TS0fUeNMlX1Uh1OGe4Rc4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T8y0sQTvGBHN0p1TyZPicQgADm3mFYp8biSmuczJCs2r7tzp3PeAOmZ912ShvW9CjtIoW50T95sLmiJqZDDLHrkwcGlJ11mbZEjHkjc/GMhQkmR5oqo7MvcCK1x+vaTpIq+FGV9uoQoXXsOPI+Zai+gY5U2g0LwpPPrTRG7uwI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eg9bwUC1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FA4A1F00896;
	Wed, 20 May 2026 00:54:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779238471;
	bh=77TDdl0DPKDwBEIH74qB70TS0fUeNMlX1Uh1OGe4Rc4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eg9bwUC1AH2WJcjCIwXg9nE+LByH5AbRu9+ZPNyTSKbm4g6pJa9vi2b4ol0oM0mFb
	 iBMuJGkV+s2YdIjMmNWRE5iqzEaSlnzw/FCDYdF0CjKB0RAKtESxdIMiYzyXvYhPaw
	 LbgHEdzYDQ11CYJOVzRKcIdzI3e4j0w03uuxDUDfqGGDaOMGQWISy3YnTfCLFJ5cIn
	 syySDvp/7oKY4xH4adzi+UGB8RiLHb3Z//oky/+W84RWdiMV6A75aIdiIFc/P3g/Qo
	 ZTO039BQx4tHf5HF4b3Qfo0uNIl16UVCdGBkiELwG0tfq8Md0QBraGACfCGtNQfWXv
	 RaA5pXptNiOUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Michael Tretter <m.tretter@pengutronix.de>
Subject: Re: [PATCH 6.18.y] media: staging: imx: configure src_mux in csi_start
Date: Tue, 19 May 2026 20:54:20 -0400
Message-ID: <20260519220508.reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260519141436.784770-1-m.tretter@pengutronix.de>
References: <2026051552-pasta-scariness-9d08@gregkh> <20260519141436.784770-1-m.tretter@pengutronix.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-249720-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 3C77C586687
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, May 19, 2026 at 04:14:36PM +0200, Michael Tretter wrote:
> After media_pipeline_start() was called, the media graph is assumed to
> be validated. It won't be validated again if a second stream starts.
>
> The imx-media-csi driver, however, changes hardware configuration in the
> link_validate() callback. This can result in started streams with
> misconfigured hardware.
[...]
> Move ipu_set_csi_src_mux from csi_link_validate to csi_start to ensure
> that input to ipu1_csi0 is configured correctly when starting the
> stream.

Queued for 6.18, thanks.

For completeness: this fix also applies to 7.0 (it was missing there
too). I queued the upstream commit as a cherry-pick into the 7.0 queue
in this run as well.

--
Thanks,
Sasha

