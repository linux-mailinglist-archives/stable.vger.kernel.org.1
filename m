Return-Path: <stable+bounces-260135-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 296dJL9QIGqC0wAAu9opvQ
	(envelope-from <stable+bounces-260135-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:05:19 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E266398B0
	for <lists+stable@lfdr.de>; Wed, 03 Jun 2026 18:05:18 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cazp2wIr;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260135-lists+stable=lfdr.de@vger.kernel.org" designates 104.64.211.4 as permitted sender) smtp.mailfrom="stable+bounces-260135-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 4A436316702A
	for <lists+stable@lfdr.de>; Wed,  3 Jun 2026 15:16:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB83A3D16E9;
	Wed,  3 Jun 2026 15:15:00 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59901DF73C
	for <stable@vger.kernel.org>; Wed,  3 Jun 2026 15:14:59 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780499700; cv=none; b=uQybYC9fH/9O8phM7IDMzmpuazu+I8CcI9kbX1XHH2FdpGO/d1c6ksKkYENcwazeKFChvzb8LNugjqg97j5jZXIOXxipoX5iwkHDJxtyFeaO7adMhHy8vEdAapn8RAl6Wk13l9oSr3rgYlCsbKD9UN1BkYilI0BJ5jrwOVd9YZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780499700; c=relaxed/simple;
	bh=QEQ/eFpLtEeoPG9YgBSolMRkT7cve05AjpsZBSBbgQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qaoCTQMZa7TGmqlkD5K38aPXequsS9vIf+grI3V3WmWMmHtsMjkPX6OGuxXhLqgThVDupQsdFu9FIM2QVc0qSyNOq/MR7en3KH4O2MUIxKYvu3IIC83GXFflgiWF33U4FKHxm4RPT7yS3MzpH66//GEzpAIaxoFmTpadDk8Mr+s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cazp2wIr; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E15C1F00898;
	Wed,  3 Jun 2026 15:14:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780499699;
	bh=mjokqiqOfjTzeJNyyYGkPmrt5y+rsu6XbvIMEA1xrhU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cazp2wIr/SG5Wk4lLdLKms9Zf8l9+l3KGeCd/PZjghwHWmbplz48uW0Ww2R7lo8Cx
	 ICfHezDE5YwAWw3R5YqvJ31lJpnsGJa1O/AjdALT9lHoDSIoMTg3I7kOfZ13j/UmV+
	 zkQe0/9jVeeHEZmXWh/ypt9vvr/8Z6czn+vKbgAiG7Nw57A3E3sZGxHY595BpJSfUk
	 4YVw8uENzyeyHqParfuycu9zDdpbEGeo+hc6pbcAsay2TFRruGaAQLE6J1hQrs55RR
	 fihXC2CQBOwuCqtQL5ESNss1vrxIImx55cl1CACY6djT1lKBcP6ydtAONL8n3lf/G9
	 Z1jbhhb/Jdvgg==
From: Sasha Levin <sashal@kernel.org>
To: Lee Jones <lee@kernel.org>
Cc: Sasha Levin <sashal@kernel.org>,
	vi@endrift.com,
	stable@vger.kernel.org
Subject: Re: [PATCH 1/4] HID: core: Add printk_ratelimited variants to hid_warn() etc
Date: Wed,  3 Jun 2026 11:14:25 -0400
Message-ID: <20260603151458.2404783-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260601083642.908433-1-lee@kernel.org>
References: <20260601083642.908433-1-lee@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-260135-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:lee@kernel.org,m:sashal@kernel.org,m:vi@endrift.com,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	RCPT_COUNT_THREE(0.00)[4];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ALIAS_RESOLVED(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	SINGLE_SHORT_PART(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E3E266398B0

Queued for 6.12.y, thanks.

-- 
Thanks,
Sasha

