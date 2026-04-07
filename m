Return-Path: <stable+bounces-233523-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKdWF+XD1GmmxAcAu9opvQ
	(envelope-from <stable+bounces-233523-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:44:21 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B9C023AB79F
	for <lists+stable@lfdr.de>; Tue, 07 Apr 2026 10:44:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8F19A300E710
	for <lists+stable@lfdr.de>; Tue,  7 Apr 2026 08:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADB05397E9F;
	Tue,  7 Apr 2026 08:43:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="U8bvurur"
X-Original-To: stable@vger.kernel.org
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95D34C97;
	Tue,  7 Apr 2026 08:43:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775551428; cv=none; b=KTwnH1PEa0xoZXXc3ecWxfY4PpwceLqquEEQTRBWn+xeHwSWvj/nqiCg+K1gD/QenRD+CV7c1HsV39kn8QSUtvUjXrwEtdTV+/LZ2W8GuHsEM0JrUEn1eE08biymzqs6Y+zmrsrF0Y4LnfGI2g8md4DqIicp7OA38ArsERWssHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775551428; c=relaxed/simple;
	bh=yBLiVzjBRJft8vkh+7dn+QeKm7TtX8g2EDLLFcDXOZY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=TKjyhj7vIa8roj9mlXeKwO63gOEUNeHxXDZSVA2oGHRxLpltGLTMsBsu3AKzTb9jma9ROGEZ0I7f7O+NrBy2lfHM0YCB7Wc3pno5bn94cfZuseKgOlGCWpUDOXY9fyaAP051bdS6Y972gfdeCz4uOD2PKx5xQZ5/IxEd7OREV6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=U8bvurur; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7D5DC1D6F;
	Tue,  7 Apr 2026 01:43:40 -0700 (PDT)
Received: from [10.57.87.42] (unknown [10.57.87.42])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8594C3F641;
	Tue,  7 Apr 2026 01:43:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1775551426; bh=yBLiVzjBRJft8vkh+7dn+QeKm7TtX8g2EDLLFcDXOZY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=U8bvururo5b1ps+KdeqNiZedG+dYujaDyNUBLnI5D3ezXZ76ozBXVKrKkte0h1gQ3
	 KhrRvUK/4bauOvy0bt/z3ZnAtclb5oWoHQKyxrlTaHGqKZKxOAzB4XElR0vAPyGtIg
	 jN/i3x5oZOztXV7dewzuwpwnlzJI+jcJqSpt2jhg=
Message-ID: <beacee23-c177-47a1-b8b5-743844b617a8@arm.com>
Date: Tue, 7 Apr 2026 09:43:42 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] arm64: mm: Fix rodata=full block mapping support
 for realm guests
Content-Language: en-GB
To: Catalin Marinas <catalin.marinas@arm.com>
Cc: Will Deacon <will@kernel.org>, "David Hildenbrand (Arm)"
 <david@kernel.org>, Dev Jain <dev.jain@arm.com>,
 Yang Shi <yang@os.amperecomputing.com>,
 Suzuki K Poulose <suzuki.poulose@arm.com>,
 Jinjiang Tu <tujinjiang@huawei.com>, Kevin Brodsky <kevin.brodsky@arm.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
References: <20260330161705.3349825-1-ryan.roberts@arm.com>
 <20260330161705.3349825-2-ryan.roberts@arm.com> <ac7VD4Z85nS30GCp@arm.com>
 <ac-W9oNM_O5RTtaf@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <ac-W9oNM_O5RTtaf@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[arm.com,none];
	R_DKIM_ALLOW(-0.20)[arm.com:s=foss];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[arm.com:+];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-233523-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[ryan.roberts@arm.com,stable@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[11];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,arm.com:dkim,arm.com:mid]
X-Rspamd-Queue-Id: B9C023AB79F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On 03/04/2026 11:31, Catalin Marinas wrote:
> On Thu, Apr 02, 2026 at 09:43:59PM +0100, Catalin Marinas wrote:
>> Another thing I couldn't get my head around - IIUC is_realm_world()
>> won't return true for map_mem() yet (if in a realm). Can we have realms
>> on hardware that does not support BBML2_NOABORT? We may not have
>> configuration with rodata_full set (it should be complementary to realm
>> support).
> 
> With rodata_full==false, can_set_direct_map() returns false initially
> but after arm64_rsi_init() it starts returning true if is_realm_world().
> The side-effect is that map_mem() goes for block mappings and
> linear_map_requires_bbml2 set to false. Later on,
> linear_map_maybe_split_to_ptes() will skip the splitting.
> 
> Unless I'm missing something, is_realm_world() calls in
> force_pte_mapping() and can_set_direct_map() are useless. I'd remove
> them and either require BBML2_NOABORT with CCA or get the user to force
> rodata_full when running in realms. Or move arm64_rsi_init() even
> earlier?

I'd need Suzuki to comment on this. As I said in the other mail, I was treating
this like a pre-existing bug. But I guess linear_map_requires_bbml2 ending up
wrong is a problem here. I'm not sure it's quite as simple as requiring
BBML2_NOABORT with CCA as we still need can_set_direct_map() to return true if
we are in a realm.

I don't know what it would take to run arm64_rsi_init() even earlier, but that
would be the best option from my point of view.

Thanks,
Ryan


