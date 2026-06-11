Return-Path: <stable+bounces-262592-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id V3r5BZ4FKmqJhQMAu9opvQ
	(envelope-from <stable+bounces-262592-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:47:26 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7ED66D8CE
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 02:47:25 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=KBVrxxNm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262592-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-262592-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CD47D3195A77
	for <lists+stable@lfdr.de>; Thu, 11 Jun 2026 00:45:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0136A1F09A8;
	Thu, 11 Jun 2026 00:45:41 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39F7136358;
	Thu, 11 Jun 2026 00:45:37 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781138740; cv=none; b=cq+0pT19M0r7Fs2wroxzZEC9MI9QKeh8tX/rCCa5pqLTq3KgQRbUw+a4Se9ykUc7gBkQY8fk4+hDYp0nhIRIoHEu3cEifdzjbAsY52PRO906StjtAnsDGaUUbQqGHRTbpt7iPidP67TPo28vRZc4Butp43mHgHnWIOT6Nm2B0qI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781138740; c=relaxed/simple;
	bh=94ZsnpPxwmbWbsDenSNerAD4OGycaXKaD1ytGbBzGBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gJl8fIhfaI3bj+WRZeANaVLP2WHNZdvxKJ/OguzOUSTDRQFRp+zI40a+oQKEzp5rmv1eDl3hOH9hNZw0HBnPG6KSL6xU2eZhCaWmijL386/pd7KhjZAwja8ZyJhBef1kZO5tlinx0BZXMQIgITkRIZcwzk+TlwgBVdqENv26dpw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KBVrxxNm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C35F1F00893;
	Thu, 11 Jun 2026 00:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781138737;
	bh=94ZsnpPxwmbWbsDenSNerAD4OGycaXKaD1ytGbBzGBE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=KBVrxxNm+V3hY3x2gZuBQ9CtpzKNti7hXsB757IwRLCDPV9QuQD4lmv87Mva/lyJO
	 e3Du2wNL+W4XVwCegLcGI7+SApuDa7PM7aH1HN904g8RQZJd9FQCrsva0hG5/bJOQP
	 2hhJ32JaXnsxWGVGer/t5/XH53iN+rDualOZ+68Elu7uASOp5/2ipZZKUtPgar4wgR
	 N0rqEjuR5bBkPlBv8zmAODOaa9OMNWvtq5SyP7qQc8oz6U88EMgbjkFgJbMrYiIJmE
	 OKR+rCR+6aVT9RDwVoTE71IXQJiXY/8aGAXkf6oZuPqwiLXX90pHOB214DsUthLCYH
	 V3e7Ujwr9feuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Alexey Panov <apanov@astralinux.ru>,
	Oliver Neukum <oneukum@suse.com>,
	"David S. Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Kimball Murray <kmurray@f5.com>,
	Soohoon Lee <Soohoon.Lee@f5.com>,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>,
	lvc-project@linuxtesting.org,
	Zqiang <qiang.zhang@linux.dev>
Subject: Re: [PATCH 5.10] usbnet: Fix using smp_processor_id() in preemptible code warnings
Date: Wed, 10 Jun 2026 20:45:21 -0400
Message-ID: <20260610-stable-reply-0005@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260609164644.31375-1-apanov@astralinux.ru>
References: <20260609164644.31375-1-apanov@astralinux.ru>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[17];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-262592-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:gregkh@linuxfoundation.org,m:sashal@kernel.org,m:apanov@astralinux.ru,m:oneukum@suse.com,m:davem@davemloft.net,m:kuba@kernel.org,m:kmurray@f5.com,m:Soohoon.Lee@f5.com,m:netdev@vger.kernel.org,m:linux-usb@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:andrew+netdev@lunn.ch,m:edumazet@google.com,m:pabeni@redhat.com,m:lvc-project@linuxtesting.org,m:qiang.zhang@linux.dev,m:andrew@lunn.ch,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: CA7ED66D8CE

On Mon, Jun 09, 2026 at 07:46:44PM +0300, Alexey Panov wrote:
> [PATCH 5.10] usbnet: Fix using smp_processor_id() in preemptible code warnings

Queued for 5.10, thanks.

--
Thanks,
Sasha

