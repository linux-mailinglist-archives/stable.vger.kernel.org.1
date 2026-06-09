Return-Path: <stable+bounces-262152-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id XIOGMKJkJ2qgvwIAu9opvQ
	(envelope-from <stable+bounces-262152-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:56:02 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AA265B7AF
	for <lists+stable@lfdr.de>; Tue, 09 Jun 2026 02:56:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=HASS1J5t;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-262152-lists+stable=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="stable+bounces-262152-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 88CB930DC2A5
	for <lists+stable@lfdr.de>; Tue,  9 Jun 2026 00:52:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E7852FDC3C;
	Tue,  9 Jun 2026 00:52:25 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E39A654763;
	Tue,  9 Jun 2026 00:52:23 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780966345; cv=none; b=Tbp6Cn1AdbXzM7JAM6BQ5Q60SOxIvlypQIL98qtlUdW9IHQkx5P0vfVgUx++KGIlR/vDKg8Q0juNlcz6y96qvsgbVr8iHd2w6q3PV6YXLEHGaz14SYIsLwhT+BsmMsI3JuWdeRl7iOD2y5QWAX2ECKuGZc+bY9IqK5NElkMUA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780966345; c=relaxed/simple;
	bh=z73HwLVnnq2+zeo30gLl5GrbC4oK1UqZKltRwRTcJPw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=anbwK0aDXctwv+EMjL6YqqvH1GcuwGP+Lyi440n8hjQqCXzdwJ7Dsk09yW9QX+OT9Ws1OB6j44i17tAu7r1XOByFfikEB8Yk3iXFs2znjOGMeuoo8asfnfIA/KujcNV43zIk9Q55Sbwx9BYxA4oN18ur3xOfVrTSBGOs3hg/k8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HASS1J5t; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57C8F1F00893;
	Tue,  9 Jun 2026 00:52:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780966343;
	bh=z73HwLVnnq2+zeo30gLl5GrbC4oK1UqZKltRwRTcJPw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HASS1J5tHtPOjb9zAvimiAvI77xPsvMFoR3clutZ5xCCx+GKXd/gR9EsSOqemR3S4
	 DJtICHylvl61OlPN0d8Zd7TFXs8EJs+O2vlRqn6Jt5KN8aZw1PQdwqicttqQuXLBdY
	 pfiqhAcEmQaU6xDHEVov0aS6xujmWyyjMoXMsKXxQLF5F2jFgtDJESgvHZDbI/gFR6
	 0CLbjjDrwS+pHBepG6ufMX602PQrBAPskhMWCVMtUcsn29glNsb5Ypg58qniSiI4Et
	 zpRBhpG9tPzGL66zDfwLHRUGKzALCrp2zSNTBhiAmloK5mt0UEphEH3vqTFHWnPuAW
	 97ivpud/u2DTw==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	stable@vger.kernel.org,
	khtsai@google.com
Cc: Sasha Levin <sashal@kernel.org>,
	patches@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	raubcameo@gmail.com,
	andrzej.p@samsung.com,
	balbi@ti.com,
	kyungmin.park@samsung.com,
	linux-usb@vger.kernel.org,
	Jianqiang kang <jianqkang@sina.cn>
Subject: Re: [PATCH 6.6.y] usb: gadget: f_ncm: Fix net_device lifecycle with device_move
Date: Mon,  8 Jun 2026 20:51:59 -0400
Message-ID: <20260608-stable-reply-0013@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260608053636.2797024-1-jianqkang@sina.cn>
References: <20260608053636.2797024-1-jianqkang@sina.cn>
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
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[12];
	TAGGED_FROM(0.00)[bounces-262152-lists,stable=lfdr.de];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:stable@vger.kernel.org,m:khtsai@google.com,m:sashal@kernel.org,m:patches@lists.linux.dev,m:linux-kernel@vger.kernel.org,m:raubcameo@gmail.com,m:andrzej.p@samsung.com,m:balbi@ti.com,m:kyungmin.park@samsung.com,m:linux-usb@vger.kernel.org,m:jianqkang@sina.cn,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FREEMAIL_CC(0.00)[kernel.org,lists.linux.dev,vger.kernel.org,gmail.com,samsung.com,ti.com,sina.cn];
	FORWARDED(0.00)[lists@lfdr.de];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	TO_DN_SOME(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 93AA265B7AF

> [PATCH 6.6.y] usb: gadget: f_ncm: Fix net_device lifecycle with device_move

I can't take this one (6.6 or 6.1) on its own. ec35c1969650 alone opens a
userspace-reachable NULL deref in eth_get_drvinfo() that is later closed
upstream by e002e92e88e1 ("usb: gadget: u_ether: Fix NULL pointer deref in
eth_get_drvinfo"), so applying this commit by itself trades a UAF for a DoS.

Please send a complete backport that also includes e002e92e88e124 (as the
follow-up patch in the same series) for both 6.6.y and 6.1.y, and I'll queue
them together.

--
Thanks,
Sasha

