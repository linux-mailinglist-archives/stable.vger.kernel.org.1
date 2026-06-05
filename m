Return-Path: <stable+bounces-260788-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id UZ2zNDUmI2rdjQEAu9opvQ
	(envelope-from <stable+bounces-260788-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:40:37 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 582FA64B015
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:40:37 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=efnUxADh;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260788-lists+stable=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="stable+bounces-260788-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B55D230421E0
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A847B44A730;
	Fri,  5 Jun 2026 19:37:43 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99F26404BCE
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:42 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688263; cv=none; b=FVhEFVOBzBaBczRWmtxs7CaF2kwWxCy1OYQ9zUtCIMxlsfAMpQDCL43vSvBcyTKKn/G3tpg6TBPlUXMwFfMKNi9RB92EnpP/wXs44YC2+zEmUbTfHj+PJ1CZdK3dsanWQId1fTdH0KkwAbr8jDz67+PnHMyfOyq5UBUr6sO+fnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688263; c=relaxed/simple;
	bh=Bde7ot8rzYSUh8X/lDTON7mMb3S4WJ/8zewVrMJL4Ks=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TJMDIuexqxKUVNu44UkIkvEhgoU7J/d2yj7it6jfn5LnY3aYenywuYBhNbelPhcfpNCQf51JTmrtyC8zsyCFW7Xsap3EhTTwSmmUMAAm0gvIWDh7BsAFZdVUQ8a6oOJ+L4+CAjYYfXhc63BMhxn1Nn+Mm1xb9SWhJQEiXMJjwdA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efnUxADh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9DBE1F00893;
	Fri,  5 Jun 2026 19:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688262;
	bh=CAArwDjU28DAOvmztJxXveNkswPh9QF1LvwE7iptNXg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=efnUxADhWwH9pYaJRtfEedBLaAzLBk/6fmM41BG5G7xhchmvwzXjVLrkNyLt/AQeX
	 cz0oe0nFpvkqYDBDEQ26w2zfc3CSBUt/gS5zYDHgjVZUlKz+xl1zmLi46vfx564OpZ
	 od6F2NnEQYkWeSSAIIIC9GNoKfpcMpESaOkPVWRuuYrx+IyXxF9r71a0OX/zjiju6A
	 r6wuAm5ZNjZ0wbAndLg0W7L9hEUD1DGdighkIQhAZOe0GyBr6q/Ma83jy4BuAmZvzv
	 lSo31M0rFLsPhU+/RbgZMxbfPvA2/6e4FjDP4SS6fjGWFJ2KNj76KMbK0h41uLW3kG
	 sMzRobZFUeiTA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	luiz.von.dentz@intel.com,
	Doruk Tan Ozturk <doruk@0sec.ai>
Subject: Re: [PATCH 6.6.y] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync
Date: Fri,  5 Jun 2026 15:37:14 -0400
Message-ID: <20260605-stable-reply-0007@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604095229.69087-1-doruk@0sec.ai>
References: <2026060418-factsheet-oversold-deba@gregkh> <20260604095229.69087-1-doruk@0sec.ai>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-260788-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:luiz.von.dentz@intel.com,m:doruk@0sec.ai,s:lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 582FA64B015

> [PATCH 6.6.y] Bluetooth: hci_sync: fix UAF in hci_le_create_cis_sync

Queued for 6.6.y, thanks.

-- 
Thanks,
Sasha

