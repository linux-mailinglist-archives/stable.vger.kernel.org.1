Return-Path: <stable+bounces-254679-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOKBEntLF2r0/wcAu9opvQ
	(envelope-from <stable+bounces-254679-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EE9AE5E9B91
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 21:52:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 567883068093
	for <lists+stable@lfdr.de>; Wed, 27 May 2026 19:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5412A3B27EC;
	Wed, 27 May 2026 19:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyCA1TJD"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEE4B3B443F
	for <stable@vger.kernel.org>; Wed, 27 May 2026 19:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779911380; cv=none; b=KbIQ8g4pQG0jHWc0HKrnpHHqEGopWwZHIXCR5rsL9nOdTmZPrpZgV29W2BpD7DyQeUZwI+hjIle+v+edurho+/KIIG4ldamBPjo7pL5zhR51KM3n7DaDZcUg8f7KQIvlEDVT+ZQa4yI0Cve9Q7i4hj84lGa73NSIPww0g4LbMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779911380; c=relaxed/simple;
	bh=8Fcjd+pXPd4M1iVxV6Lw9ajddAAe4W/RLJsICU+bGRA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cyWD8Cj/aPTZ5afUBR200wWGtrO4BtqNThERmXfkqn0oGb1puJhYG+/8whNFR7HoXced5MMzU+bv+G1I5FAydepfjw3WbQ5TlqYhChj8eUHk9/tydTrHSLuzTqPendehfA4xbdHG44v9CcNn1+eL1BIY5LhIsVtXt8FsakU9/QM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyCA1TJD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABFBD1F00ACA;
	Wed, 27 May 2026 19:49:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779911378;
	bh=8Fcjd+pXPd4M1iVxV6Lw9ajddAAe4W/RLJsICU+bGRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jyCA1TJDMWugJyuJEF1wtTrw2DnatynP+Zug1zW35MuKOUksJE075ExusIuAUspUF
	 vK7jXWKGUNC7bNuckVCn1KM3Wk/77PwNYg1hjQpMWzS7vyPjznq6vvDouqTZH2lNLL
	 HiUqosYN05DW0O7TwZP4aTMELdazoS41LG9dhH7DXkDvf8uTcDo+YW/ILd9Fm9uti+
	 eQfev0y9rz26tGEGtgM+X3T0lS/HHKMaYOcMVDssquizMnMjjuv9mfI+9tPRIiUZvv
	 qefEDBe7+IeaR+RrRRyqB8+2Y+WW1O7UHYHXsndY0F2sy3AzXtA7Vx3N5sxSoeU+9+
	 latHNtUg6kviw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	lukas.bulwahn@redhat.com,
	catalin.marinas@arm.com,
	will@kernel.org,
	rostedt@goodmis.org,
	mhiramat@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	Gyokhan Kochmarla <gyokhan@amazon.de>
Subject: Re: [PATCH 6.12] arm64: Kconfig: Remove selecting replaced HAVE_FUNCTION_GRAPH_RETVAL
Date: Wed, 27 May 2026 15:49:11 -0400
Message-ID: <20260527-agent5-item019-arm64@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260526192440.81431-1-gyokhan@amazon.de>
References: <20260526192440.81431-1-gyokhan@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-254679-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[10];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: EE9AE5E9B91
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

> commit f458b2165d7ac0f2401fff48f19c8f864e7e1e38 upstream.

Queued for 6.12.y, thanks.

--
Thanks,
Sasha

