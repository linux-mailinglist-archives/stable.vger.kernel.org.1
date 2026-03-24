Return-Path: <stable+bounces-230198-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WIq6EgTCwmmjlQQAu9opvQ
	(envelope-from <stable+bounces-230198-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:55:32 +0100
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EBC331978E
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 17:55:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CE3E3311FFA3
	for <lists+stable@lfdr.de>; Tue, 24 Mar 2026 16:46:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 113FE4035A2;
	Tue, 24 Mar 2026 16:45:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F3EelZoI"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7E93402B83;
	Tue, 24 Mar 2026 16:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774370717; cv=none; b=tK/JTyKPiUngVckFZzYlH0Cb4ogs4LlBkn85X1zIT8HB/qJtdHarzsjlFEkzfO/wvj7AfqoF9XTZ4omHv2X5Zt/WdSjWf5RQWAbkECb1+ZB50Kzp+K7TXoWoZ936GrOR9yfQjdhUotTZIt63BYuiBseamw41//x2OxzhpfPyzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774370717; c=relaxed/simple;
	bh=LeG2KCV4/Hdn4qXx/XVMXDyOrpBMwTVPU8WDTCFX66g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SDmdJ51lbWMfcH5FbwE49wycHQAU39pYz2XLHUUE+8+NK4NGJ0sIOcArkyPXzE5I0l4ZJ+x2MqzBSuazJ/NRwQGxAlm2hlMCkUJtv0Uvff0Ab22UT+6JikMG0Zy8UHQ0/NV9VPF+pc1LQ/dzTo15fOOolZ7029EXKqodtpQxHdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F3EelZoI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576ABC19424;
	Tue, 24 Mar 2026 16:45:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774370717;
	bh=LeG2KCV4/Hdn4qXx/XVMXDyOrpBMwTVPU8WDTCFX66g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=F3EelZoIcJQ1XA+ysw6NxwI536GEqBp+VkCuljehKMNIw0NOGJRpa8jL1sZcCTXb/
	 uk3UB5t6ossBcqiX+x+/BX/jMKVzPs1B7JjeDTU9PieqRXg/H/i9DFW7jXwx1bJtEZ
	 vFbAIjQxsOH45bKyg8y7trijjLRltq7xvYWKKHMZf6ueifgQMdPckKMv4IP4l7pstB
	 CEETFN7gccIeWJjrvD1LzVnkOzYW0BK1G8AgQd7UlLMoxkH8Mhu6S/NKVXdj2hWrAg
	 3REGvblO5r7gYRHEJw3er9xPfLbRhsLt1yEnBC1+UrBOGHed9vEr/Ivp+60EDkzoQu
	 YbibBFfjHjRiA==
Date: Tue, 24 Mar 2026 10:45:15 -0600
From: Keith Busch <kbusch@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: stable@vger.kernel.org, patches@lists.linux.dev,
	Jonathan Cameron <jonathan.cameron@huawei.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Dave Jiang <dave.jiang@intel.com>
Subject: Re: [PATCH 6.19 378/378] cxl/acpi: Fix CXL_ACPI and CXL_PMEM Kconfig
 tristate mismatch
Message-ID: <acK_mxmLlvD5vQog@kbusch-mbp>
References: <20260317163006.959177102@linuxfoundation.org>
 <20260317163020.886316423@linuxfoundation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260317163020.886316423@linuxfoundation.org>
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-230198-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[kbusch@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1EBC331978E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Mar 17, 2026 at 05:35:35PM +0100, Greg Kroah-Hartman wrote:
> 6.19-stable review patch.  If anyone has any objections, please let me know.

No objection, but a little confused how this got to stable before
landing in Linus' tree. Does stable pull directly from downstream
subsystems now?

Speaking of upstream, will the CXL maintainers be submitting a pull
request for the staged fixes soon? I'm just getting new bug reports from
people testing 7.0-rc, so wanted to check in on that.

