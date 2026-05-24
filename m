Return-Path: <stable+bounces-254020-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sO94FLzrEmpt5QYAu9opvQ
	(envelope-from <stable+bounces-254020-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:14:52 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 14E355C2544
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 14:14:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F0B40303C63A
	for <lists+stable@lfdr.de>; Sun, 24 May 2026 12:10:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 769C339659A;
	Sun, 24 May 2026 12:10:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jnfe8JzJ"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B515D395AEC
	for <stable@vger.kernel.org>; Sun, 24 May 2026 12:10:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779624607; cv=none; b=uF3YQm9k1IhaAxRydZvCF1lnmkgkdzsk1R0iX52E1/fxcdepqyLCQYO2pNbv00fY0fvkUqyPqNYfxjZ4Ni+WH5GUMLOReTTZZae2uLW7Oyq4EIqxPsaevsgEKFl4C4x0toJU6pkBhZEToyCLj08Yt6TYYCAD9voKmLgYWGbv7ZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779624607; c=relaxed/simple;
	bh=Hl9QoSe9XJTLFSgazDj1a8o5f+32uOFaFnhjfznZRGs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Cp7PjvF+kZ4RqrgBbqFGi3yLiv4wMyXIIpKUd4bLGwYCCLMH+8rYJeQWT+ZgWQdxWiEN0/+4wtFTJcVO/TWrz9HqbyTwOzDh8S48LqzblGFwP7ZScaVGwO2DZJ1WqGMWzaMFqVL2UqoCPQ0BMHoz+nIzNlK+m0HrF8XxoEUnx0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jnfe8JzJ; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 249A41F000E9;
	Sun, 24 May 2026 12:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779624603;
	bh=J9BXVb3slJU1Eu9UJPNqqVJ94Fcdm0PgUFuFxcsE4Pg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jnfe8JzJj7EANjCL0xCcNYHhdf68WIk6gSqIALerBEDIkHlggjMfJYwhvEZj+y/Wx
	 341BoiuaRY9tk+PkrQBBWyA4e8p1KPN0SHbsFNo4yeZXqYrwxUTyXIM4S+ZDSfK+N6
	 t0MAqyWnn50FoP1cp86+XOvO0s1fuqL8aZ+6N3f00m42jGePTzjFK9lXQo6pR97Zck
	 PpUNKLaaHYz6HPN9iviW3hde4pVpDAddamWPvg7FwwCQTzoWXhDMd/BxlEVIeJjnBS
	 Wp/atBddzLabUaJXVnjLSnYKyRHJp+etNPcNkahg6u8QtFcvsP7/n8JqQOFaNjlgpU
	 75xMZ+uw4heCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	nh-open-source@amazon.com,
	Danilo Krummrich <dakr@kernel.org>,
	"Gui-Dong Han" <hanguidong02@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"David Sauerwein" <dssauerw@amazon.de>
Subject: Re: [PATCH 6.6.y 1/2] driver core: generalize driver_override in struct device
Date: Sun, 24 May 2026 08:09:59 -0400
Message-ID: <20260524-stable-item011-queued@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520140200.45804-1-dssauerw@amazon.de>
References: <20260520140200.45804-1-dssauerw@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[kernel.org,amazon.com,gmail.com,linuxfoundation.org,amazon.de];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254020-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 14E355C2544
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Queued for 6.6, thanks.

-- 
Thanks,
Sasha

