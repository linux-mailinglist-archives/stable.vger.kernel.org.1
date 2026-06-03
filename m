Return-Path: <stable+bounces-260131-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id IScwLbpQIGqB0wAAu9opvQ
	(envelope-from <stable+bounces-260131-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:05:14 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 367DC6398AB
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:05:14 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=OtTfK3j1;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260131-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260131-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 173C53084C50
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:16:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E539F3D1AB9;
	Wed,  3 Jun 2026 15:14:56 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00603D1709
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:55 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499696; cv=none; b=LaLEyAoGg5z5q9ylgCI2MfuRMJX2ak1PYF2tMTZvKFJkkzxy9iTGN803qfogLzfVFoh0zz3PSDAvL7zG2EuwI5o8nTmhcytnXLNstdB/dHCTBar+ujhKlBwUCZVW7JBvDaHzvE41oc9EBHvjq0Qki7zqTfH/EeJstRs9MeeU3CY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499696; c=relaxed/simple;
	bh=x2CyR83K8Ui/zDUZ89B7pi39PinAtPOk+fTNyDbzn4I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Lb9HfsKZqMd3Q8iSRHBLcIYT53vQvnwRbTWV5NZR252JFYrR1wYx3RoIUfu1niUVkVK/E6H/BA4Y9D7W+n//mkW5+izwCzF/NuqjHYsURwHMpDw/k7HhunltK5gu0YxM9+RqhZ1h8HSKeSo4Idd5wvDXn4FsQvnUBew6WHabnZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtTfK3j1; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6DEC1F00893;
	Wed,  3 Jun 2026 15:14:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499695;
	bh=4Kj4voNkYXV/vTBaXRccNGRUErzTkLYlawm8sg0S9go=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OtTfK3j1LcIUQN2h7gmJm3XnuqZwU4rArFWu2/n5cmI+BNCwQZOGZZEm+/qPiVRDD
	 N5N1WHDsaG1jwiotBvVQJ5Y0q0sD41N4vRgWCeQ4gNTGSKeSHnu1tYaC97LYKod44t
	 Fb460qBvWUca+FMOQRwruU7goq+TrO3tFPy3XkxH+WoKYlFirSR1FndbkPZduGsbpy
	 jpZ2PCFfMaqX9RncakiA2BzlO8nqhGwR/b20MWPrsZD9Y0RsB69YhpUl8JH6M5QG/v
	 jZxwOvdubHqTTvQv0mRaPE78RkCximD8DAq2DRpgsuxdeVIQvwYP7WejJDCZjxZOGw
	 ZA/ijeIUrATbg==
From: Sasha Levin <sashal@kernel.org>
To: "stable@vger.kernel.org" <stable@vger.kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	Oliver Neukum <oneukum@suse.com>,
	Hans Verkuil <hverkuil+cisco@kernel.org>,
	sean@mess.org,
	Jan Kiszka <jan.kiszka@siemens.com>
Subject: Re: [PATCH 6.18.y, 6.12.y, 6.6.y] media: rc: ttusbir: fix inverted error logic
Date: Wed,  3 Jun 2026 11:14:21 -0400
Message-ID: <20260603111500.item062@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <f92f7417-9ba4-4a16-9f4c-77bcf212784a@siemens.com>
References: <f92f7417-9ba4-4a16-9f4c-77bcf212784a@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260131-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:oneukum@suse.com,m:hverkuil+cisco@kernel.org,m:sean@mess.org,m:jan.kiszka@siemens.com,m:hverkuil@kernel.org,s:lists@lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_HAS_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	RCPT_COUNT_FIVE(0.00)[6];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 367DC6398AB

Queued for 6.6.y and 6.12.y, thanks.

-- 
Thanks,
Sasha

