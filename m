Return-Path: <stable+bounces-253757-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ANxWMe00EGqqUwYAu9opvQ
	(envelope-from <stable+bounces-253757-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:50:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 424B45B2796
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 12:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 69E693028B40
	for <lists+stable@lfdr.de>; Fri, 22 May 2026 10:43:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8F1F13CCFC4;
	Fri, 22 May 2026 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qji63ydE"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE034CFCD;
	Fri, 22 May 2026 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779446586; cv=none; b=LGDJ45R0nvquKeLpa65xFRPig990hi+Czt87gYItCypluGFMWiyEd1VW5Wy1Fx8+/LhrV1bLnOYwgsRGIM015+t7sqQoAAs/4ZzGjxrtRlumg4D7sLoWyHG+Dpsg5YZwPJCkc3HZh7FJdfrInbZwa+uSJqLmDY3KFr7O5o7JSHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779446586; c=relaxed/simple;
	bh=FHmf2xdSVf/eguERHywz2g11fhEteH69tz1QYzDX0OU=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=V92EoscU/70oH5cIbW/WnkYKyW0+3zkyXWDHrRbNBkopPXwBfsSYOiBsoPMwWAwlDkD2lQh6r1jNesLbbsOa9UPRRb7CpZ3U1rByGS/gJM/8/JNkz/dzymla0K3QNNHEyt1SK7BhPvy+1L7yGqSMqbiWHgEjNr0SXeNjhMPAHSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qji63ydE; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0B4F1F000E9;
	Fri, 22 May 2026 10:43:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779446584;
	bh=FHmf2xdSVf/eguERHywz2g11fhEteH69tz1QYzDX0OU=;
	h=Date:Subject:From:To:Cc:References:In-Reply-To;
	b=Qji63ydEIYpNL9my5S7XNCj0b5I6VxwLdCGbHK+CtsKJIIs7VbHAUrC7/xpHegUxN
	 FoL4MxAVnl6g0+n7+i72TFQbcT+hsp8paNUAAy7fKhnCUGbLzkR/VnREySlYpWgsnz
	 bt+dOfksfpRFCR7e9MyLYUmwnRR8ZTVx6r/hWE/QtLla/YLWq+lBYGrt/sZ6IZF5BW
	 MQpgb2tHz8z1eLxPf1G1P3DPqvMs728OpH36AWLf/Az7OQfzthb7TZo8PLO2UrntFr
	 OQj7KM8xk4Jdaa4D4javNKO/awWgCbgkCpyNKGCyZwT/uBTk7qq5fWm0q+CoGmF04h
	 CvJ2VkNQiSwyg==
Message-ID: <1ee68533-144c-42f2-94c8-d6ef7c1dc644@kernel.org>
Date: Fri, 22 May 2026 12:43:00 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] device property: set fwnode->secondary to NULL in
 fwnode_init()
From: Danilo Krummrich <dakr@kernel.org>
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
 <3888011e-789a-40e9-b222-c5522a6b7037@kernel.org>
Content-Language: en-US
In-Reply-To: <3888011e-789a-40e9-b222-c5522a6b7037@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-253757-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[oss.qualcomm.com,kernel.org,linux.intel.com,gmail.com,lists.linux.dev,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[15];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 424B45B2796
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 5/22/26 12:40 PM, Danilo Krummrich wrote:
> On 5/22/26 12:24 PM, Greg Kroah-Hartman wrote:
>> Sure, but for now I'll go take this one.
> The follow-up commit 7eba000621ff ("device property: initialize the remaining
> fields of fwnode_handle in fwnode_init()") is already in driver-core-next.

s/follow-up/v2/

https://lore.kernel.org/all/20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com/


