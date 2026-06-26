Return-Path: <stable+bounces-269258-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id zPPCGTa9PmrzKwkAu9opvQ
	(envelope-from <stable+bounces-269258-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:56:06 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 000A86CF81E
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:56:05 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=T9gg+Utu;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269258-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-269258-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D81CE3093186
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:54:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C15643ACA68;
	Fri, 26 Jun 2026 17:54:52 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 800A03AB28C;
	Fri, 26 Jun 2026 17:54:51 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496492; cv=none; b=nvAGGLTUqI8+CuVKGsjB24wSfGh+Lzjr1MAbctuZSseqwNbKjAh2n1QIwU78Vw8yVM/Q3TwiUwOVEBIJc2azwl7djwPwD9WKrtf/Xop2nI3E4AyBpU1gGXc9vBdKN4iDIuk/6yNWvsaURh5q3lt0Aew2rmHRlBT/f3+3Z9UREhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496492; c=relaxed/simple;
	bh=58pkwoKTTU88PAx27+BnWDynnsvY3vRMeVeH7waI0vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gGyJ+oyj42X4+qI0xYgmNxdQt2PGBeC/qzqj8t5n7cGJZRGCg1aVESH1Ugae0f8zboGvxRFt3JuzRkDm8LBcoi+iWlwkuqnYCd7RaQ2r+DYFpC7u6DccUaUeCq6hi+hi/irhDgPxNs9pt2r2g6AxpjRiEDbF8K+5rVIGDO6Wa5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T9gg+Utu; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83A491F00A3A;
	Fri, 26 Jun 2026 17:54:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496491;
	bh=uahxyPEIH6t27GLrs4p650lz88F6UyvLhIoK911HudA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=T9gg+UtuT3oG/JEmrA1jiFe9qMgZbbLgcRN3FGrliuqLGcJaUhyP8GkAdJVArtIFP
	 YAUaJT5MgDMznMRACGJFuQL2N63nr4v30roZo3rHnKy881PTzG/5t2m5I0Db9GS9DC
	 Z93mAyE4X8RQ0EKVO+RiFPcsbrcqMC8DRcoSy6yvoiSUr18NkRta98GaoQiTw60tix
	 2SN9IlpkCkOqgnPzp/j9c/SAUQZM5kyQfVlCTjgszBBxzhxszggSdNyHwHixJJ/fts
	 4EsGcsdB/sQc+uoa3iyYx1vtRsuU6DTdsb5SPyE394gE6EX9FL4WxZexeokcjvJ0Ii
	 z1yzH6SzJju3Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	kvm@vger.kernel.org,
	stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Hyunwoo Kim <imv4bel@gmail.com>,
	Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 6.12.y] KVM: x86: Fix shadow paging use-after-free due to unexpected role
Date: Fri, 26 Jun 2026 13:54:22 -0400
Message-ID: <stable-reply-item006-role-612-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626112405.1777340-1-pbonzini@redhat.com>
References: <20260626112405.1777340-1-pbonzini@redhat.com>
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
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269258-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:linux-kernel@vger.kernel.org,m:kvm@vger.kernel.org,m:stable@vger.kernel.org,m:sashal@kernel.org,m:imv4bel@gmail.com,m:pbonzini@redhat.com,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,redhat.com];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 000A86CF81E

> KVM: x86: Fix shadow paging use-after-free due to unexpected role

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

