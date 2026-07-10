Return-Path: <stable+bounces-273324-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id ZLA7HUxeUWpDDQMAu9opvQ
	(envelope-from <stable+bounces-273324-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:04:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CD6D73E9A0
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 23:04:12 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=A57ajD6z;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-273324-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-273324-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 438F8302BDED
	for <lists+stable@lfdr.de>; Fri, 10 Jul 2026 21:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FA812701D9;
	Fri, 10 Jul 2026 21:03:30 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBEB52D0C7E
	for <stable@vger.kernel.org>; Fri, 10 Jul 2026 21:03:28 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783717409; cv=none; b=qtrgruXlDLmmkyHdTZpdpmVGifJvYARdVC3SDGPXxTmyAG8og0V2ZMwmcYCc9CLWx5qq0E2Ydscc7ODRxE+1erpBDzDckLsdw42dxZ9Dfx8h2jH/d/dO7OyMCRNTysJ/worSvc7hwkptxY2vBkqjLOREQlxnmQk+0+cisDdYFR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783717409; c=relaxed/simple;
	bh=id5Jrb4hjj4X9qHIQpsV7iB6ee2NGuw4Uh8wjv8jPS8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OoJIo96gHmObN1aB6DggD2pHN+axMeYPjeQvAfk1IIDoBZmbHh77TqRN4g6jaibkv6ukJOowAyyiCiaYGH+ruynyRI8TkCeJH9QKfYueABM7b+guUgh/Afzefa9p5U2lN/s+YdGaWwxQgJqU0k2CxgB0fd750z1cnn+oHq0KfZ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A57ajD6z; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B1201F000E9;
	Fri, 10 Jul 2026 21:03:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783717408;
	bh=LNf8tTx8ooX/swGjtYWyFyAfolkS3ym38KFhiBoPDOI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A57ajD6zoR5JKl+cygQJo/acVDH+Zfl9/C6Tgq0rEL0rx/ji8G2w3MyaASQiljqgc
	 NYcWwrx1NK58C/j9r7hPwbi4FZ2A01epeQup94nL+ADYTSS9rdSMc4LjV6S5XQJgqR
	 w3SDHLoGOmA96WAE8NQvHpWwigFU5T0sOfv4z9+Q95/jAWEkrRetLvDxxnUCvxKEuj
	 CLQwgRCcWGq/cEa5lI+JrXixea57gaLBfV+vBKKaLzjOTYIQ+cqUUi2OLEj6vO9eQd
	 kjTlNzdNREWsQZ0bwevcHJd6sGiRV7Kp6x2dKS1Rqf84WDtQ/QccWqWmicH0jwpWrz
	 QSOFx/BpgSM8w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Michael S . Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Philo Lu <lulie@linux.alibaba.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Joe Damato <jdamato@fastly.com>,
	Paolo Abeni <pabeni@redhat.com>,
	Hyokyung Kim <pulpannie@gmail.com>
Subject: Re: [PATCH 6.6.y] virtio_net: Support dynamic rss indirection table size
Date: Fri, 10 Jul 2026 17:03:01 -0400
Message-ID: <20260710163023.agent5-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260710111954.234758-1-pulpannie@gmail.com>
References: <CAGJdW3H0Bv31W5DNaHstXyYxMcVFUnOmzAJ9LAjZOANk1y67OQ@mail.gmail.com> <20260710111954.234758-1-pulpannie@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-273324-lists,stable=lfdr.de];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,linux.alibaba.com,fastly.com,gmail.com];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:mst@redhat.com,m:jasowang@redhat.com,m:lulie@linux.alibaba.com,m:xuanzhuo@linux.alibaba.com,m:jdamato@fastly.com,m:pabeni@redhat.com,m:pulpannie@gmail.com,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 1CD6D73E9A0

On Fri, Jul 10, 2026 at 11:19:54AM +0000, Hyokyung Kim wrote:
> However, the indirection_table was statically sized as
> VIRTIO_NET_RSS_MAX_TABLE_LEN=128, potentially causing issues when
> vi->rss_indir_table_size exceeds this limit.
>
> This patch implements dynamic allocation for the indirection table,
> allocated alongside vi->rss after vi->rss_indir_table_size is initialized,
> and freed in virtnet_remove().

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

