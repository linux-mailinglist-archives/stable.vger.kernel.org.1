Return-Path: <stable+bounces-253637-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gIhHAH1nD2pKKgYAu9opvQ
	(envelope-from <stable+bounces-253637-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 22:13:49 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 54C8C5ABACE
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 22:13:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1878F3037695
	for <lists+stable@lfdr.de>; Thu, 21 May 2026 20:13:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C8DD3E6389;
	Thu, 21 May 2026 20:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PwjWJcJa"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03FFF33B6F8;
	Thu, 21 May 2026 20:13:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779394394; cv=none; b=J18ZwghVbvrs63XfwUdX97gbUW044njzlhEA9/a4QZCsHWHDMu4FkdklYF1Iz5qJHvDzkDxxDdqukFBfuInhWmvvCbcECB+fZADGVQuIUZrnWN+LYC/+ioVbJ4X/X7FOLJb1NvAZQQHOlhYJdXvwyKHgT0UoZ9NrLGQXY+hlnx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779394394; c=relaxed/simple;
	bh=PhHT+5qWBxKn0OTE/mSREssg/kXNSb41+uZbkc+pqh0=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=i2F/ZsbMwfWICpWng6X/J2YxrWAvJAIh19EhxwoGe6rzdS/9m60aQrfRlPk1OMvBuKL+tedzYR+6am+KD65SuRN2q/CFVtnMqJ56SBaXt8fJrF3ryE1iCsGBLVPy/Z6ogF4emgeNBd1ZqoY5JJdOI7FOTwcb5jDPcaeiK4QXAV8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PwjWJcJa; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with UTF8SMTPSA id 6F6561F000E9;
	Thu, 21 May 2026 20:13:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779394393;
	bh=2mkrp+7CFhzJFOg4LD6CsVexg7gtohVBtM5IptpBMRQ=;
	h=Date:From:To:Cc:Subject:In-Reply-To;
	b=PwjWJcJagMbdil30Xk4OPToTglPieM1u8DMgZFULIdF60JW13wB+lpvgVl2GySvnu
	 J4mNcc1XAqMXONGmP4Kvcsdtx1ai75jHY2pTKerhKCpjkw8ERI4zXrFowb0RkGCr1/
	 dBCZZxka3VZcrb6JBddQmZ7eqI8aSRWmD3LRkectKPgWKX1gBQaI5ec3qWOi8GpVFJ
	 A+X6+5SUfJK1wchhrwtbT1DSGqJM0LT11HB2eBe3gF3KaLYeCjoPD8FFguOG3d/dlC
	 8IYoJNFKObDLbhZ3EL3bONTTVSQ33u0ZjX+v3k7zbhoNBj2QZbnfeOkMlkQ6gkY3sp
	 7d/VOEHcPhcpg==
Date: Thu, 21 May 2026 15:13:12 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: "Ionut Nechita (Wind River)" <ionut.nechita@windriver.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com, sebott@linux.ibm.com,
	schnelle@linux.ibm.com, bblock@linux.ibm.com, linux@roeck-us.net,
	lukas@wunner.de, stable@vger.kernel.org,
	linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
	matthew.brost@intel.com, michal.wajdeczko@intel.com,
	piotr.piorkowski@intel.com, dtatulea@nvidia.com, mani@kernel.org,
	kbusch@kernel.org, lkml@mageta.org, alifm@linux.ibm.com,
	julianr@linux.ibm.com, ionut_n2001@yahoo.com,
	sunlightlinux@gmail.com
Subject: Re: [PATCH v14 0/2] PCI/IOV: Fix SR-IOV locking races and AB-BA
 deadlock
Message-ID: <20260521201312.GA182641@bhelgaas>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1776839248.git.ionut.nechita@windriver.com>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-253637-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[22];
	FREEMAIL_CC(0.00)[vger.kernel.org,google.com,linux.ibm.com,roeck-us.net,wunner.de,lists.freedesktop.org,intel.com,nvidia.com,kernel.org,mageta.org,yahoo.com,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[helgaas@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[stable];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sashiko.dev:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 54C8C5ABACE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Apr 22, 2026 at 09:32:40AM +0300, Ionut Nechita (Wind River) wrote:
> Hi Bjorn,
> 
> This is v14 of the fix for the SR-IOV race between driver .remove()
> and concurrent hotplug events.

Thanks for your persistence on this!

Can you take a look at the sashiko feedback and see whether there's
any merit to it?

https://sashiko.dev/#/patchset/cover.1776839248.git.ionut.nechita%40windriver.com

