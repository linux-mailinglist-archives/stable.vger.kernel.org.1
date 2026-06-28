Return-Path: <stable+bounces-269445-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id wU3xHjCWQGrLgQkAu9opvQ
	(envelope-from <stable+bounces-269445-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:08 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 66AE26D3067
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 05:34:08 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=i0v0bqfC;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269445-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c09:e001:a7::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269445-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E628F300A4A1
	for <lists+stable@lfdr.de>; Sun, 28 Jun 2026 03:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93D492773D3;
	Sun, 28 Jun 2026 03:33:49 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F977271471
	for <stable@vger.kernel.org>; Sun, 28 Jun 2026 03:33:48 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782617629; cv=none; b=OMZhPTKXV7aL7g/2baFYdNs53FPTBr4ay0P6dDW3RKiCvLidhLYoA6mNkTBG7Qz5MRaNcTs2jujiMr/SLJpD2uAz2ygKDpFaW37tUstoSJvbuY6rKftwjS4sO7JAOaHAnmptQoPQQcL6Ci+FwNbiMd4gq1a1KbTBYvojZ88bfFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782617629; c=relaxed/simple;
	bh=QnvkAfOZVaQn5xyDv9YRDyyQUEF5N8fy/29X8gpx0k0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nb9TV2VUeL1OL9FXuEP+Fcevm3KBEqegt02uW1tJD/Ly4HKJRXQU0S0rYsNzE9pdYvpTuZHOj5/GETyRbJhRS0rO1OfD0a3Zr2Alc2gUIRpU/hqL4YXluUvmtyHKPBklHb4Iy+SbSYzmX2fWtcEPK9hv3aXjn5Vrw+vqWc7pKWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i0v0bqfC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2DA21F00A3D;
	Sun, 28 Jun 2026 03:33:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782617628;
	bh=QnvkAfOZVaQn5xyDv9YRDyyQUEF5N8fy/29X8gpx0k0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i0v0bqfCb4eFXrCsy50tT2XuO49jQPMjsOl/+t/vr1Jm6RlqIHk5ofyF1sbOQl3j6
	 l4fEH917WuZTCW5FlFifL7KCRfGRe0RAM4ICMX6iDyukLemTwaGZs+nr70joXg5KQn
	 BCPXRQvrbcRqBhGnt7Od4MBA8tvi2pM/giHfiix3U/+0j6m9SfPJIkNrxjlhuL9/S2
	 ObNqdxR5m0FSBQAzSBtpPuOZPJlh+HpGjZYhcsvZ9DeNbmBAv9yQ4mVWngPVZYM7ot
	 cDXEK5vhvaFnBfcWb3Oe6qn7SG1OojVEnvuaeVoBxDDxGX8Wg1TUi0EeAiMaHBf40Z
	 Ka+BXdDAcWTIg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH 5.15 00/25] batman-adv: 7.2 merge window fixes backports
Date: Sat, 27 Jun 2026 23:33:37 -0400
Message-ID: <20260628032401.0007-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626161105.124113-1-sven@narfation.org>
References: <20260626161105.124113-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-3.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-269445-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:sven@narfation.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 66AE26D3067

On Fri, Jun 26, 2026 at 06:10:39PM +0200, Sven Eckelmann wrote:
> [PATCH 5.15 00/25] batman-adv: 7.2 merge window fixes backports

All 25 patches are queued for 5.15, thanks.

--
Thanks,
Sasha

