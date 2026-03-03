Return-Path: <stable+bounces-222870-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EPS8Fh/YpmnHWgAAu9opvQ
	(envelope-from <stable+bounces-222870-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:46:23 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D12E11EFAC3
	for <lists+stable@lfdr.de>; Tue, 03 Mar 2026 13:46:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id EEFAC3030D94
	for <lists+stable@lfdr.de>; Tue,  3 Mar 2026 12:46:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9DBA535CB7C;
	Tue,  3 Mar 2026 12:46:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Ngm8OrQA"
X-Original-To: stable@vger.kernel.org
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 042A435BDB7;
	Tue,  3 Mar 2026 12:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772541978; cv=none; b=poh/uP53vAXpk+bgDE4oRt5sEE5jOUtUSk3YXh5abQjYx7XAB8jYBjqSPfU14XG/AT6SNABxnx6XL3XBiB8ylpXShz2rei0vDIr5YByi2JvTckkFQJChzBqzpNuiBjfPy0OU5PkexNEFswYh3ufqWc/hSiPSRO9HVEqhbU7zNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772541978; c=relaxed/simple;
	bh=jt8uR0lCRfCdQSqQHN/0E45hZPHquwTEKnJj45cNbT8=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=flBtzgYvQYTwQ5eS9f2qYz8FYIwrBL2PCxTuh9euY8hLmNPbjjQf64Lpd4f+r4VwqF22pcN76xacfs0EICKKQvk+wJi6DCiYnxWNHf1Ww2opxlysNbG6+oRe6cioMQr+HF1NL8TJ/eDBR3cTbDqMZDIXZOHx7fcqfE79DKZY34g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Ngm8OrQA; arc=none smtp.client-ip=198.175.65.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1772541976; x=1804077976;
  h=from:to:cc:in-reply-to:references:subject:message-id:
   date:mime-version:content-transfer-encoding;
  bh=jt8uR0lCRfCdQSqQHN/0E45hZPHquwTEKnJj45cNbT8=;
  b=Ngm8OrQACAqLltEhT1sc8JNYnC4JbleuUZpBD9dU1aRBIOKOq6coLr9Z
   TbByaxeK6QsB2faqXrlrqeBBsVN0NmsgYuwbJg4xUHScHa3lHupBelsPb
   vxD/I7Q3Ai5grk6JJ/v3idiFT2FZnDW/WU6kIyiLYS0QO4WpQhRr/ylr2
   pNEtdEZqF5IbEs3p4AC8C+MLBhO1bnr48LxqasYYT6ZspY28fUAR7fLVK
   WC05jUj8jdk6No1PT2FdCTiGz+sbZQ8WJHU1SWhLhvykgZZJIIvQKCvVh
   XfstFIY8d+rKiJl8e9m01WGlXamVweUOoxoUnFOfapBPhrvZGqP0sZx9s
   A==;
X-CSE-ConnectionGUID: P7pavWZUTUGPGDx31p739w==
X-CSE-MsgGUID: jiIyCDyjTIuD4nICLtmhsg==
X-IronPort-AV: E=McAfee;i="6800,10657,11717"; a="90974337"
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="90974337"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by orvoesa102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 04:46:13 -0800
X-CSE-ConnectionGUID: q1KkaAs4TdG2M9NeKcUc3A==
X-CSE-MsgGUID: qg+XSqZcR/WqzRYXVmJbgw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,322,1763452800"; 
   d="scan'208";a="241007711"
Received: from ijarvine-mobl1.ger.corp.intel.com (HELO localhost) ([10.245.245.62])
  by fmviesa002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Mar 2026 04:46:10 -0800
From: =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To: Prasanth Ksr <prasanth.ksr@dell.com>, Hans de Goede <hansg@kernel.org>, 
 Mario Limonciello <mario.limonciello@dell.com>, 
 Divya Bharathi <divya.bharathi@dell.com>, 
 Thorsten Blum <thorsten.blum@linux.dev>
Cc: stable@vger.kernel.org, Dell.Client.Kernel@dell.com, 
 platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260303113050.58127-2-thorsten.blum@linux.dev>
References: <20260303113050.58127-2-thorsten.blum@linux.dev>
Subject: Re: [PATCH] platform/x86: dell-wmi-sysman: Don't hex dump
 plaintext password data
Message-Id: <177254196461.1768.8814922241426906056.b4-ty@linux.intel.com>
Date: Tue, 03 Mar 2026 14:46:04 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.13.0
X-Rspamd-Queue-Id: D12E11EFAC3
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[intel.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	R_DKIM_ALLOW(-0.20)[intel.com:s=Intel];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[intel.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-222870-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FROM_HAS_DN(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ilpo.jarvinen@linux.intel.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[9];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:dkim,sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo]
X-Rspamd-Action: no action

On Tue, 03 Mar 2026 12:30:51 +0100, Thorsten Blum wrote:

> set_new_password() hex dumps the entire buffer, which contains plaintext
> password data, including current and new passwords. Remove the hex dump
> to avoid leaking credentials.
> 
> 


Thank you for your contribution, it has been applied to my local
review-ilpo-fixes branch. Note it will show up in the public
platform-drivers-x86/review-ilpo-fixes branch only once I've pushed my
local branch there, which might take a while.

The list of commits applied:
[1/1] platform/x86: dell-wmi-sysman: Don't hex dump plaintext password data
      commit: d1a196e0a6dcddd03748468a0e9e3100790fc85c

--
 i.


