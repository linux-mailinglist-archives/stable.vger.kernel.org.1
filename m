Return-Path: <stable+bounces-263206-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id oQvpDAwGMGrRLwUAu9opvQ
	(envelope-from <stable+bounces-263206-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:02:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 2168B686E7D
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 16:02:51 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=n8R6xhDb;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-263206-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-263206-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D0D61308591C
	for <lists+stable@lfdr.de>; Mon, 15 Jun 2026 14:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 101DD3F4109;
	Mon, 15 Jun 2026 14:02:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F25A918DB26;
	Mon, 15 Jun 2026 14:02:39 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781532160; cv=none; b=Jx1rfqol2MbM6Z73H/ZxCyGu2d4Ses4DjY/TM44wUjYGwNiTMhzjbg4wl8kYeltnHIgPXBjetnLNbALUVB8wN+BDamkQIWBY6AZKz5ow0/ISFXcLpXmWyVM3wQo14GBr4yafWkRzlXIJmSGXUHmyS4Ka4Zyr29v54xra4w6oIAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781532160; c=relaxed/simple;
	bh=O2oz+YnWJmC4JgtulW/2JODfUkQWfikW4hVPPr2vh3Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=uxCo3SjrBwNVxUVzL9RNehNOdiTIN3BJyZ0VG1iPmXRqodm0ShA/1KxS2M3kJWp1tnF8ShwJihAzNYsVvkQ2bSZAQyeu2kKIAZuao3DT4qA8Iktdli/oF+OkCQ55Mm1SCGryiGPGLbxmVn4+aWuDqa0PJWlDM0kjp7E56z6YaCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n8R6xhDb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91ADD1F000E9;
	Mon, 15 Jun 2026 14:02:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781532159;
	bh=O2oz+YnWJmC4JgtulW/2JODfUkQWfikW4hVPPr2vh3Q=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=n8R6xhDbQNeH0CpiO3pxS4wzkXwpkFOPTjjuix9kl2zZLbclLlOcjy9j362vGhm4S
	 QTwkyAEQ7eFelnlgSnwckrefqMl1sMmWz3zggI1hfw7YGnW9gzG8ZjVQxxelBchh3T
	 sudVbslxvZnc8yUscHmviLNd+JRhLn6pl5qpW8ZKW5BToHShUNlYDBAN9kgfOsv9TA
	 MJzwwZqhuxq+Gw9I7BFg2i5+pW5OEgpMvVZ1Rph4YCR01Me22nBXvfZkn3qTtPe+uk
	 62ebY8co1aqpXXuFFGi7Gcq38x4zboiWwm752cw/TweZ58FiXlBSnCGZcmPX6M9wXB
	 cn15dg91j9zRA==
From: Sasha Levin <sashal@kernel.org>
To: bpf@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	ast@kernel.org,
	daniel@iogearbox.net,
	john.fastabend@gmail.com,
	andrii@kernel.org,
	martin.lau@linux.dev,
	song@kernel.org,
	yonghong.song@linux.dev,
	kpsingh@kernel.org,
	haoluo@google.com,
	jolsa@kernel.org,
	menglong8.dong@gmail.com,
	eddyz87@gmail.com,
	shung-hsi.yu@suse.com,
	stable@vger.kernel.org,
	mykolal@fb.com,
	tamird@kernel.org,
	Zhenzhong Wu <jt26wzz@gmail.com>
Subject: Re: [PATCH stable 6.6.y v3 0/4] bpf: linked scalar precision fixes
Date: Mon, 15 Jun 2026 10:02:34 -0400
Message-ID: <20260615132154.0001-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1781194510.git.jt26wzz@gmail.com>
References: <cover.1781194510.git.jt26wzz@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-263206-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:bpf@vger.kernel.org,m:sashal@kernel.org,m:netdev@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:ast@kernel.org,m:daniel@iogearbox.net,m:john.fastabend@gmail.com,m:andrii@kernel.org,m:martin.lau@linux.dev,m:song@kernel.org,m:yonghong.song@linux.dev,m:kpsingh@kernel.org,m:haoluo@google.com,m:jolsa@kernel.org,m:menglong8.dong@gmail.com,m:eddyz87@gmail.com,m:shung-hsi.yu@suse.com,m:stable@vger.kernel.org,m:mykolal@fb.com,m:tamird@kernel.org,m:jt26wzz@gmail.com,m:johnfastabend@gmail.com,m:menglong8dong@gmail.com,s:lists@lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[21];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,vger.kernel.org,iogearbox.net,gmail.com,linux.dev,google.com,suse.com,fb.com];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2168B686E7D

On Mon, Jun 15, 2026 at 00:58:37AM +0800, Zhenzhong Wu wrote:
> This v3 targets 6.6.y and changes the backport strategy based on review
> feedback on v2.

Queued all four for 6.6.y, thanks.

--
Thanks,
Sasha

