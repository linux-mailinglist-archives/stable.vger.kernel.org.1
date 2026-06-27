Return-Path: <stable+bounces-269401-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id YnerExT8P2r8awkAu9opvQ
	(envelope-from <stable+bounces-269401-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:36:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A66F6D24B7
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 18:36:36 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ACfVTM0x;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269401-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-269401-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5E71B30363A0
	for <lists+stable@lfdr.de>; Sat, 27 Jun 2026 16:35:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51FF2317161;
	Sat, 27 Jun 2026 16:35:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324C93115AE;
	Sat, 27 Jun 2026 16:35:40 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782578141; cv=none; b=iAfYFo1lCB3LHLFRycZunrsIu3yeG7KJxovD1DTgZ9ptb7zjc0LOM+1nZxBupgqbnfFk+PWZa/oQN9x1BUqq6RxhOty0czjLrl5NkjhDZK7nVF+AxMvBEWwtmF4sOeRQTWrnUdD1XY4sWzNLwoSCXLujp6IA40x9v7C9fs5qLc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782578141; c=relaxed/simple;
	bh=uyY5ORe+mcGUeC1MlEHK9/Pnw6N0DhHebw2daP+L3i4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d/q1kEju1NGmSS9pM4hcRwLih+8XqNI3Jeu79kNR47Ib6OPanNbmjm4vsib5zowwoBwZuH1fuLXLSS7Kq/BAasZyYV6X7ml664E9FvqmykDQqbN50syUUnFmFqZOoKETJqFX/SRTWPAd0xb7sTr1qJW5mH2f0tCs4mfBZW9fynU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ACfVTM0x; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A5051F00A3A;
	Sat, 27 Jun 2026 16:35:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782578140;
	bh=BNLx/O08lLRTN8+CHTofGUqyf96b051Nkcpaq8VIpv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ACfVTM0x+volUFr3vn+guv3j47i7CbVlemcG+ZyHIKpujHOnK2B8Cb2UEI9ClqgEd
	 wA/DLb9PHBRCDu+QF37mg/1EFN57ljfAjuEQ6t6/RLRSepJVxCki1rDqXf5kOnSOW+
	 L0MINwP4n00lDVUWiKF2GuKmUMBLDJmdbbWq3AlezVFzWfdufd5JR6nGZu9DSQ9pB4
	 XlYINBjC3Y9PBUFGlTXfiM7i3ARBtC6CDHs3XOzYXK+ylwgQIh42WC54vxXswZYaa/
	 9iASwlliWuIYxK9Tiw9i1dowb/cO4k1kY/i1ttzdj1hp1QUyI2CNydkLcuRXXNhZBH
	 4CZaRIAxHLIGw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	linux-pci@vger.kernel.org,
	gregkh@linuxfoundation.org,
	mani@kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com>,
	Paul Guder <paul.guder@example.com>
Subject: Re: [PATCH 6.18.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"
Date: Sat, 27 Jun 2026 12:35:27 -0400
Message-ID: <stable-reply-item011-pci-qcom-618-20260627162226@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260627080702.11517-1-manivannan.sadhasivam@oss.qualcomm.com>
References: <20260627080702.11517-1-manivannan.sadhasivam@oss.qualcomm.com>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269401-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:linux-pci@vger.kernel.org,m:gregkh@linuxfoundation.org,m:mani@kernel.org,m:manivannan.sadhasivam@oss.qualcomm.com,m:paul.guder@example.com,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
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
X-Rspamd-Queue-Id: 0A66F6D24B7

On Sat, 27 Jun 2026 13:37 +0530, Manivannan Sadhasivam <manivannan.sadhasivam@oss.qualcomm.com> wrote:
> [PATCH 6.18.y] Revert "PCI: qcom: Advertise Hotplug Slot Capability with no Command Completion support"

Queued for 6.18.

-- 
Thanks,
Sasha

