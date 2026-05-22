Return-Path: <stable+bounces-253756-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AOUwA+QzEGqqUwYAu9opvQ
	(envelope-from <stable+bounces-253756-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:45:56 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C2FCF5B2683
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:45:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D4323305E05E
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:40:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E46B63CAA3C;
	Fri, 22 May 2026 10:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tk1YenIh"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB18838E13F;
	Fri, 22 May 2026 10:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446446; cv=none; b=kO6s7FJOOpOmjEGRBubOyIvEdu7zgJkdFmpZp3aSkhr+Cai3idme5jtnz35Byup5AFzE9TgORD0RfEOTSFKyLaGNA1jqIsSdIX97lxui+dyEjDPnprHFlAv4x/qPpMZgYHdRFHgQnXB5aDFR86fRZliDNV00NI4ZqNviFlYDuXk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446446; c=relaxed/simple;
	bh=aUzqOGkV27FTm7yYO//ovQeRh4fWP28Kdt1YmQBt5cs=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=LjHzoEtP5oQYVdXCs2TE9skdWfCzn4ZkvwWgl3LVXzey5HPy1/5WdeLBOmROQF1X5060cLfiRD4PS3eeaB1ugLwKcLCPTZy7MC1dTRABnEoVBgps7FB0el3Dzs6D8A29wbQ4XwBjLkyu+kD/G6p6zlDDr/7zaXPVVlctS5GIBnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tk1YenIh; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9F0561F000E9;
	Fri, 22 May 2026 10:40:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779446445;
	bh=aUzqOGkV27FTm7yYO//ovQeRh4fWP28Kdt1YmQBt5cs=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=Tk1YenIhfGkZyuAfvk/Fx0Sqdr3bfJGEXBp438Xs8FlOx7I6u7+LLXImA4rw4xl8s
	 OfykoVuPGbSUOcNy+jVQeVm/vfuYrNpcILSAhLlOqlWfw/gb9u5WR5L0dYzQFGZyGx
	 OL5Dlyts17Ou29tumvPj3S4sKGydXJxUHe4A9OSUzFoNU4SPTkInIgthZm3LuFKWFc
	 bzXL3uoe4NueRqsVsWQ6HDFZWW+RVILhz8nfBr1lCVH3b53LwaOK47bfxSMm8Fyack
	 jdt0/TfkooIKAW8Bp7FFwxM1t2E4AH/DQ+AbPcNeg5MYqUvl1T/ivDYUbIGTennebt
	 Q3ySwZ+76hcvA==
Message-ID: <3888011e-789a-40e9-b222-c5522a6b7037@kernel.org>
Date: Fri, 22 May 2026 12:40:41 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in
 fwnode_init()
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Daniel Scally <djrscally@gmail.com>,
 Heikki Krogerus <heikki.krogerus@linux.intel.com>,
 Sakari Ailus <sakari.ailus@linux.intel.com>, Len Brown <lenb@kernel.org>,
 Rob Herring <robh@kernel.org>, Saravana Kannan <saravanak@kernel.org>,
 driver-core@lists.linux.dev, linux-acpi@vger.kernel.org,
 linux-kernel@vger.kernel.org, brgl@kernel.org, stable@vger.kernel.org
References: <20260506115701.23035-1-bartosz.golaszewski@oss.qualcomm.com>
 <DICUSYTHZ339.3DW3CRNZ32K6U@kernel.org> <2026052254-rug-mug-24cd@gregkh>
From: Danilo Krummrich <dakr@kernel.org>
Content-Language: en-US
In-Reply-To: <2026052254-rug-mug-24cd@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253756-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,linux.intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Queue-Id: C2FCF5B2683
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 12:24 PM, Greg Kroah-Hartman wrote:
> Sure, but for now I'll go take this one.
The follow-up commit 7eba000621ff ("device property: initialize the remaining
fields of fwnode_handle in fwnode_init()") is already in driver-core-next.

