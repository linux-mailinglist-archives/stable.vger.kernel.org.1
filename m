Return-Path: <stable+bounces-269254-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id DkS4Lw+9PmrnKwkAu9opvQ
	(envelope-from <stable+bounces-269254-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:55:27 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D85C6CF7FA
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 19:55:27 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=S1ZJdKpa;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-269254-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-269254-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD293305D9A0
	for <lists+stable@lfdr.de>; Fri, 26 Jun 2026 17:54:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94D5E3A7F6E;
	Fri, 26 Jun 2026 17:54:48 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B9483A7F66
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 17:54:47 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782496488; cv=none; b=GcT7n3CR7hnl5gpe4T06zdS0l6jl4DE8/tshW/+e14M91Vb8xhsydv8G3ECdz+tOTtMYl860G6ZwlldGtGoLKT9mwNJVRks6LzfoSeSbHTI4QZifoRCBhcIotbWAIqviGC46LT5XgB/iH4EWDFqkUYgTKb8gekBGplAwtWHvKtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782496488; c=relaxed/simple;
	bh=xP1hE/kiDK1RcZ8UcHonlrjWBwN5/XTba/2JU15/5RQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=alfOOQlwWYqchXodH7cFJta3tvy5SIe7P8OSGq6Xap05eVBOQrFpXFnid+IT0dwOljzwKYmrHABmIZycwlz4BWQWW3iKuDC9uM5JlmZKIs8EGIs9zYUVL46UacgVyApm/CFjL0c1kfC7KKw3l08G4Q0Cyy9NHjEdOHWbMq8MREQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=S1ZJdKpa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D1F1F00A3E;
	Fri, 26 Jun 2026 17:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782496487;
	bh=mJsz3LYA9sbvctI+AfrGpW/NYWRG+T95iea37SGtAK0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=S1ZJdKpaOS8+2LCh/trrE/h1lMRNZymgShmlG3xnkhfQxwT2BA+pTO/TRCie/hPWb
	 hjRwYI5gxEiwIj/8Qf0JiJGDyUZ/rnH7IbpqrG8fQD80g928vjkTQepeDLiOXvlp+R
	 krGvHANCLx8XcaP8S7DtFbA85Y0XFd/rnJoMR2Y0Fhd5inVemem1A7jRzA0e4rgLbW
	 3zjDhIarpUOcahyhVrTO/K/YRqsbzB4OxP4kPnv2sA8dlKu4deekFk1zcLBNryLW4e
	 C2KYIsRhzWsZc7wDds1+/ZsysLEgcwZ4gOFAaKLVrEHDhH0u4RJXR57N5FC8OkYUyC
	 DKcXJXB2FWejA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org,
	foss+kernel@0leil.net
Cc: Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org,
	brauner@kernel.org,
	Wentao Guan <guanwentao@uniontech.com>
Subject: Re: [PATCH 6.6.y 0/8] eventpoll: fix ep_remove struct eventpoll / struct file UAF
Date: Fri, 26 Jun 2026 13:54:18 -0400
Message-ID: <stable-reply-item005-eventpoll-66-20260626@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260626041403.85968-1-guanwentao@uniontech.com>
References: <20260626041403.85968-1-guanwentao@uniontech.com>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-269254-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:gregkh@linuxfoundation.org,m:foss+kernel@0leil.net,m:sashal@kernel.org,m:stable@vger.kernel.org,m:brauner@kernel.org,m:guanwentao@uniontech.com,m:foss@0leil.net,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,kernel];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 3D85C6CF7FA

> [PATCH 6.6.y 0/8] eventpoll: fix ep_remove struct eventpoll /
> struct file UAF (CVE-2026-46242)

Whole series queued for 6.6, thanks.

-- 
Thanks,
Sasha

