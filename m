Return-Path: <stable+bounces-269402-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 8z4xJB38P2r+awkAu9opvQ
	(envelope-from <stable+bounces-269402-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:36:45 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C2086D24BD
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:36:45 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KR9io5fM;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269402-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269402-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2B83D303799D
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 16:35:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C633F3115AE;
	Sat, 27 Jun 2026 16:35:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6261A31717E;
	Sat, 27 Jun 2026 16:35:41 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578143; cv=none; b=R8AE44LV7QMfULGZuYE7CRBLOooa3IgHemTNfWsxZ90eKNsPfH/nf4IsZg/qZ8GDb5exj3SlJH8a+rRL0V9YEOjv94oz/zR0xxb1Nbw1q5pCtm7CzO9xuR6ZPyb7rpOwGbhuQLG8n0ZNjYE3ANerv0gNqJxF3ohY69Cn3tMtRKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578143; c=relaxed/simple;
	bh=j81zY+ENowzvmHdgZU/Kabqrxc+PPWoHxK6BkPIFzDE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TA73b36s86hTE+msNkDiQr+kWgJDJfPJWEpAQL18cSZuW0jItaOHUxPlg0nfHkyxMPQZZTWuRAEkfz7MEu4b5TeOGirIYYoazW/gD7Ev6GGPw9oRcjOEmQi1oGI/1EUIPQW50f5kAdIqtr29riVan5caz7yz1bct6AC4jeYiz/s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KR9io5fM; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 424B21F000E9;
	Sat, 27 Jun 2026 16:35:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578141;
	bh=/VhMs8dfIJPax9GDvj+2M3vwD2Sp7pTJxSUPoerARsg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KR9io5fMceHNCq+qNTAmI0BsGhJnXVourx67Tnde5IgBlmZEi7msVrYzuC45KMXge
	 J1m32CMpIDGwFyXnpflmXlEcc4suaHc88uqgjsKlVuDUrUnBBeZrGHPrkEoElIZigJ
	 pva7NZBOxEUk7rHRW0Scta39gQJ+JPxJvWvqcONiVQUUa2YBOeL+w/rDupeqQSRr9/
	 NXa9dUFpMaxg6wLla8VWEVLHQ4z54lXiITbs3mOQED7XFtidcznvE/tLegrYX/PuuM
	 YAG0Y4gw9Zg8995hrgoszH/TXPqy/Nzv+HSXyei9sm9GmY+qVgFI50qizswnuZ1vSf
	 tXJ498WwP3lPw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org,
	mani@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Paul Guder <paul.guder@example.com>
Subject: Re: [PATCH 6.12.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"
Date: Sat, 27 Jun 2026 12:35:28 -0400
Message-ID: <stable-reply-item012-pci-qcom-612-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260627080913.14002-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260627080913.14002-1-manivannan.sadhasivam@oss.qualcomm.com>
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
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269402-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-pci@vger.kernel.org,m:gregkh@linuxfoundation.org,m:mani@kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:paul.guder@example.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3C2086D24BD

On Sat, 27 Jun 2026 13:39 +0530, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> [PATCH 6.12.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"

Queued for 6.12.

-- 
Thanks,
Sasha

