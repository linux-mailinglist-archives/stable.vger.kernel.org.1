Return-Path: <stable+bounces-274628-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id gsETG8XQVmoPBgEAu9opvQ
	(envelope-from <stable+bounces-274628-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BE677599F0
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 02:13:57 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=j7sKMhkF;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-274628-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-274628-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 20E5A312140C
	for <lists+stable@lfdr.de>; Wed, 15 Jul 2026 00:12:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2AB1219E8;
	Wed, 15 Jul 2026 00:12:54 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABBBD42BC48
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 00:12:53 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784074374; cv=none; b=YIxtH2lojHIf3KuZnCeU2qfJG7vCvCtmKG4bOjx0JEXbnqALv2HxmroFYJPFOE8f3tbV0JnueqKAJWqrLUm60p5EhCGJYpwVwxScGfrfo3lJ/pJbJPdc1vymFwzIKu1DK6C7BwuPPrGNVIN5fiDXtCZoP2ZLMUWrVTAeCVBWa44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784074374; c=relaxed/simple;
	bh=woSGkl4EfmH+Mn4QaXImYEag0X3HLdRamaWMqgbUh3M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rN80InFxxN1E55fqIYWQkGSA+VKMEMnXYOfjyzOdD+alRZx7tEogtH/x0X+e079VNS/lWgKxfgaWLLz2WAcosQ+OLSKniF2UQi7SL2ebP3jKhF0CpSWbWgrTzenKEi5Db4bgD+J0vKwsMnmy40T+5fpawAk2NbR777JU/G/2n8w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=j7sKMhkF; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 019421F00A3A;
	Wed, 15 Jul 2026 00:12:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784074373;
	bh=ZqNNHN1/7qz1XsKZ+9iXwkMGFx33d2imyxFlSKdRclU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=j7sKMhkFgqXT4yYtTVQ5hv3xe9I/SQrAp2d/6jpiWbGGzlXl4lEgrBCQ3qTY4XgNO
	 ggpOGi5KbmdpNBFWJgYIDdG8BMVNlmmpUzzClK+5DtHnqdX3PUO4zSaU9knnFausr2
	 drYEgixoROkeKupnHT+6I5gc+ZtYAO0hk+OKSB3x/jLGNAqgJMJJrTdBaKiIyR7z37
	 EqY3cRVe+VCrWNXlqBuI9WFwW4KKLczFV7nz7i66xv+NdZtBdVD660CgtL1fx+B70l
	 6zTjbS9/j8BXQ4QGQYFa9kbOXwOdl+YuckqwmMBV666h/2pzfC+hDY/2v29NOFQcQj
	 YgIr4Nx8am0oA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	"Maciej W. Rozycki" <macro@orcam.me.uk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alok Tiwari <alok.a.tiwari@oracle.com>
Subject: Re: [PATCH 6.12.y] PCI: Always lift 2.5GT/s restriction in PCIe failed link retraining
Date: Tue, 14 Jul 2026 20:12:38 -0400
Message-ID: <20260714200600.stable0009@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713222549.28006-1-macro@orcam.me.uk>
References: <20260713222549.28006-1-macro@orcam.me.uk>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:macro@orcam.me.uk,m:bhelgaas@google.com,m:alok.a.tiwari@oracle.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-274628-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 2BE677599F0

> Discard Vendor:Device ID matching in the PCIe failed link retraining quirk
> and ignore the link status for the removal of the 2.5GT/s speed clamp,
> whether applied by the quirk itself or the firmware earlier on.

Queued for 6.12, thanks.

-- 
Thanks,
Sasha

