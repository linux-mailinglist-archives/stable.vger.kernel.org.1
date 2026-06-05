Return-Path: <stable+bounces-260783-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id 7OaKGdclI2rHjQEAu9opvQ
	(envelope-from <stable+bounces-260783-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:39:03 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E571864AFEB
	for <lists+stable@lfdr.de>; Fri, 05 Jun 2026 21:39:02 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=ayyVTVAm;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-260783-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-260783-lists+stable=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id A8FF0301CFBC
	for <lists+stable@lfdr.de>; Fri,  5 Jun 2026 19:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41AA444A71D;
	Fri,  5 Jun 2026 19:37:37 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3192C41B355
	for <stable@vger.kernel.org>; Fri,  5 Jun 2026 19:37:36 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780688257; cv=none; b=T/nJYhuSsDqq6/R8JPpw62Mu5wb/RXSxa0gpY7oM0rFwln0OBJL92zeVCGX0urPffNrdOlgPH2jIl8DBBEzWL12nimbeo2xphufsrjlwPm9W8l9cnY+4Dyrv2Zb+Tfq4/OPcydvjL3aKwHZ8qghayzAR5rX8gbEK42xUO5oHS/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780688257; c=relaxed/simple;
	bh=fGKHpOrKyzcaN165ZFG+JvHbXtU9pb48j4QftNiABNE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bH9mi3Y8AeS95hhQ4hRyt9TCXkRvyyqo3KE5EUlpUMVuMnghH+Zb421Wco/IsKfhZI1p4JM4XlIyoQ1MllZkVxpcuVw/+Bpcps/D6gyl+uDwUmXcxk4sB/Uk1mqa+Sn9wsZqH7GtAwFG/ChcfJ4AxLEI7N/r2lBFu0k9NBcCPw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ayyVTVAm; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C0A41F00899;
	Fri,  5 Jun 2026 19:37:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780688255;
	bh=rDyEOOv7PTvKfquzsf+pdrP3W8bHBbKo8aeZo1IbZ7A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ayyVTVAm26In0yFfoQg3/I+Nwqw20/JgHRVJPMPZfpL9JaytrrjF6tQ+FgBsAtveQ
	 R8HzY278u2MheyJGX/aYyuZuKd3uxwxUrRa5LDz2SZty5qHtKlsapg6JW5rXsDsVHS
	 Hj0QdQyxeX4jji3qgTZ9JQGXM0AiL77bWPkp0T8WV4kYtBzm9Bsjfr3ufmen2kh7jk
	 dsSY+IC0XU2Or9ZvOZNpXy2XIlE9xwf+ORL4ByQNxpA/repdeoATLFjGNVRmMwwm6o
	 YTMSHnyne8iFeBueb3J7hWsxRvhneeJsq4jEz9wGz47fxo6BJz0T1LEnICdT9Mj1Bf
	 1yLrJ9ExLlZwg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>,
	acsjakub@amazon.de,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Vegard Nossum <vegard.nossum@oracle.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH 6.1.y] netfilter: nf_tables: restore set elements when delete set fails
Date: Fri,  5 Jun 2026 15:37:09 -0400
Message-ID: <20260605-stable-reply-0002@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260604083245.77985-1-acsjakub@amazon.de>
References: <20260604083245.77985-1-acsjakub@amazon.de>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-260783-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS(0.00)[m:stable@vger.kernel.org,m:sashal@kernel.org,m:acsjakub@amazon.de,m:pablo@netfilter.org,m:vegard.nossum@oracle.com,m:gregkh@linuxfoundation.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: E571864AFEB

> [PATCH 6.1.y] netfilter: nf_tables: restore set elements when delete set fails

Queued for 6.1.y, thanks.

-- 
Thanks,
Sasha

