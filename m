Return-Path: <stable+bounces-260119-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id K/dAM5BPIGo20wAAu9opvQ
	(envelope-from <stable+bounces-260119-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:00:16 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C0A2639802
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:00:16 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="By+I2/JD";
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260119-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260119-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 665E1313B47B
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5333CBE6E;
	Wed,  3 Jun 2026 15:14:45 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DD143B6350
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:44 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499685; cv=none; b=QWA+TCHGEXCBW8/niZIqKEd/6M2Bxu5YEutiXpxJ6mKPgWDxhJYEXUYga9mYcozKd82+mQQuQt4t2VgU5X5OUNJAj5gTeeO7JvQk6+qwQnsOPsUvADVsx0f5DcYNUwqxJ+9PeLT+ahdMMW+NfyWr+xAs0x548PpxmGcez+VVNLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499685; c=relaxed/simple;
	bh=eRNUCBBJINHiVqFx+I4Z9oHzVx/7+/cS+HEGOQ73m9s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=buLe+H1RR/41tC5V5h4P39Ho6YQz7MUs0Pp+YyzPYgYz91pOGgu4j6xBROJ4UNSGTjtZRTy/aqqA9xxdkcu6bELoeNChNnTJX4jHtvwFKuRawCwxF+PIj725il7Ytej2y07terSTqQutq3OLYoUwiLaz495E/LlD5akqnoqWvo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=By+I2/JD; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E511F00893;
	Wed,  3 Jun 2026 15:14:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499684;
	bh=KsM0D1AgDtQF6FePttJck8X/Qmlo3RFVGi1J4IlKj2Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=By+I2/JDXHGKgdPXTaH/0V2iaQzPxuNLnw/3b2nQsUzkcvxsgaeJFLGKEKTOlqfnF
	 3fK57q0oRmwuXO3XyHOVKusDIZ4HmRi80sskWGzyvULRRGgzFtHXn2ZvGPrvO9oFTH
	 WQ2hnVe5ecXGgbQ++2mPfyTNkfOu2u1mQ7jQ14e041amAaKBHrziIvUSRcyn12XzZs
	 aIiumTosI39thA85BAjAhkAdRroWgacK9DNRrGn1b7d+g/bH7aNfKbuaVGaO9KaKZM
	 xuDViEUEBG7WYypiRhpugHa0LGz15txCwPARIQouZlnZZjAvf/bmYe/ylAHFdB/6IW
	 TPV2RSD6FDheg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Peter Oberparleiter <oberpar@linux.ibm.com>
Subject: Re: [PATCH 6.12.y] s390/cio: Restore GFP_DMA for CHSC allocation
Date: Wed,  3 Jun 2026 11:14:09 -0400
Message-ID: <20260603111500.item029@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260602154855.365104-1-oberpar@linux.ibm.com>
References: <20260602154855.365104-1-oberpar@linux.ibm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260119-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:oberpar@linux.ibm.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 4C0A2639802

Queued for 6.18.y and 6.12.y, thanks.

-- 
Thanks,
Sasha

