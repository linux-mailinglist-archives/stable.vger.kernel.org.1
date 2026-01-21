Return-Path: <stable+bounces-210792-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iOGnFiMQcWlEcgAAu9opvQ
	(envelope-from <stable+bounces-210792-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:42:59 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E94E35AB04
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B60B876E21A
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 16:26:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4FD623242B7;
	Wed, 21 Jan 2026 16:21:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GR78Qxxb"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0686A2FC871
	for <stable@vger.kernel.org>; Wed, 21 Jan 2026 16:21:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769012516; cv=none; b=e8N9Q5b+fFD5SeLwixHassESadvU5oR7guICOZwqN/4P70PRbpEsQ/55kN9TQU5H/ezC+Y4a5+lTe4/J3dyOZiOlEdHCHddfxXhWb77bY4H472VaszJZ9TaphxZXeMmqP2xrWtWu7oR3E82AbFKO7VYQ2cSAgni9evBLrKP+egg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769012516; c=relaxed/simple;
	bh=WbJDK1HbYXS01nKGFuGRcBcrYpOhKeltwjB6WR/GkME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=BGx6c9jM+5TJyBcuKehX5evC/UJ5rb7xan1KXFP+FvtB/ngaj83GkKYvwBXA5jx4b0iVKdm0nt7hC4cxP7vvCW/8CEiTtDXvOCddqb5bOtQDyIf42Y1oV+Ag0Ia/W+50F0YfO5WuQfP5JQk214dBJHDS4Q5nBrd00z7+QabBagE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GR78Qxxb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7EB76C116D0;
	Wed, 21 Jan 2026 16:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769012515;
	bh=WbJDK1HbYXS01nKGFuGRcBcrYpOhKeltwjB6WR/GkME=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GR78QxxbuqlQC9mDcZNa/pjgrYEA20JeheqP98SpSPCNR92AY5iucrC4H9z6soedq
	 bfFtWhynemCpKGqUgo31EKV7n/CewBzJzW1E4dfGeSAra6nhETE87m+4wPQo54ZQ07
	 m53H99CTzegFo1NzEuGjBluQxj/XNIwmtodRrI2VxqiMz8K8dmz11AQ2pBbOd0NMiM
	 uTmNzx2cuwjZjzNN3Ax1Q4pxV3cFGMc009Jz+thWuewPTCGlB0p+kCFY1GhFegMJLu
	 FQFMVJLcDOCuRBEbXQRm40B1PIEV2eWaopM4QdcMUfBj7ipl84hfd+MYkHEgjriHPi
	 /9j6aDzGbmWLA==
Date: Wed, 21 Jan 2026 11:21:54 -0500
From: Sasha Levin <sashal@kernel.org>
To: Reinette Chatre <reinette.chatre@intel.com>
Cc: stable@vger.kernel.org,
	"Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
	Borislav Petkov <bp@suse.de>
Subject: Re: [PATCH 5.10.y 1/2] x86/resctrl: Fix kernel-doc in internal.h
Message-ID: <aXD9Ig3JMFW2uyu8@laps>
References: <2026012056-existing-collide-49ad@gregkh>
 <20260121025738.1158111-1-sashal@kernel.org>
 <7a7bfbf5-b7c5-4613-91a4-161f0bfb3130@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <7a7bfbf5-b7c5-4613-91a4-161f0bfb3130@intel.com>
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210792-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,suse.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	RCPT_COUNT_THREE(0.00)[4];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,suse.de:email]
X-Rspamd-Queue-Id: E94E35AB04
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Jan 21, 2026 at 08:07:34AM -0800, Reinette Chatre wrote:
>Hi Sasha,
>
>On 1/20/26 6:57 PM, Sasha Levin wrote:
>> From: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
>>
>> [ Upstream commit fd2afa70eff057fab57c9e06708b68677b261a0c ]
>>
>> Add description of undocumented parameters. Issues detected by
>> scripts/kernel-doc.
>>
>> Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>> Signed-off-by: Borislav Petkov <bp@suse.de>
>> Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
>> Link: https://lkml.kernel.org/r/20210618223206.29539-1-fmdefrancesco@gmail.com
>> Stable-dep-of: 6ee98aabdc70 ("x86/resctrl: Add missing resctrl initialization for Hygon")
>
>I cannot see how this patch is a dependency for above since it only adjusts kernel-doc
>in a different file.

You're obviously correct :)

The full dependency chain is:

   6ee98aabdc70 ("x86/resctrl: Add missing resctrl initialization for Hygon")
   63c8b1231929 ("x86/resctrl: Split struct rdt_resource")
   fd2afa70eff0 ("x86/resctrl: Fix kernel-doc in internal.h")

After applying that, I've decided to drop 63c8b1231929 as it's fairly big and
just rework 6ee98aabdc70.

I should have dropped fd2afa70eff0 too.

-- 
Thanks,
Sasha

