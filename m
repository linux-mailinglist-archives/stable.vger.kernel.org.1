Return-Path: <stable+bounces-260122-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 0A7GFnlHIGoK0AAAu9opvQ
	(envelope-from <stable+bounces-260122-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 027D9639269
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 17:25:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=NnsUMgsA;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260122-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-260122-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 04F8632A1646
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2F783D6488;
	Wed,  3 Jun 2026 15:14:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9826A3D667D
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499689; cv=none; b=EQnvvpW2e7cab46p9awXfsbt78BD8ILB59HJWY6IyRhawFtGrNDXcfBX91otlJuYdlx+pgXvZx3Trre8taovBWEBWh4vLFmIeiZsaDj35fiA4Kf4w9yBEz2GyRtmhvqC3l4dA9TxmHy7Hj+kZUJME4g7yKLdBeR8if5AWolc6Sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499689; c=relaxed/simple;
	bh=Ezkm9ZFBBVj0vhjm1nG9S2DHF83wuqcJfconYjhLc7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E2DhvV9q3FJXoeA92kWxZqpUbZm385Uoch5WfWYj38eBEL3n0GiWJkAsOelKpVd5iB5h/B+W0UnknGzIgZWF3sZrAEBdOM7eD+AR4ySPNMlNQ8akybWPd18DJVhplvaVnSnqB/eBLMd+c7z1RVPZ7eryd027nBoTAHK0n/ji8xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NnsUMgsA; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99CA1F00899;
	Wed,  3 Jun 2026 15:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499688;
	bh=WYJwWG4x16zLRsI59FJuAW/F/qyAzcv4cTVACN48lso=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NnsUMgsA71fvaWmBQGXzauZIM7JvSNX4UIf4zH1caC92YLafkpvHyuUGXXHj1I3bM
	 +oKQDbnyn3BLO40J9Z4nH8tB5bZ5FZlC4UGWaT8t41igMsXrOQnm4NeB2g0jcvr7qh
	 WGuqHAg0pBctk/ZGQ/ENrDdRdK+7E9HlSuCwr4xEvIMm1Gr4z/2sISKkWNi4eHSOc9
	 7bMD4H3cMP+z/jZoAQV8eaJGJRubC6Z0j5LNtUIeugBbXB8Mu1TQpEQ5+lr042/kbt
	 9pO3RyAwF19vEAlPzGZ26YvJ6oGGgQRJQUX1PTRaCMIhYfz0G/3YH0DkiDfHIasKi2
	 qLlYwtnJ8Mfsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>,
	stable@kernel.org
Subject: Re: [PATCH 6.12.y] batman-adv: tvlv: abort OGM send on tvlv append failure
Date: Wed,  3 Jun 2026 11:14:12 -0400
Message-ID: <20260603111500.item038@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260528194602.258724-1-sven@narfation.org>
References: <20260528194602.258724-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260122-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,m:stable@kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 027D9639269

Queued for 6.6.y, 6.12.y, 6.1.y, 5.15.y, and 5.10.y, thanks.

-- 
Thanks,
Sasha

