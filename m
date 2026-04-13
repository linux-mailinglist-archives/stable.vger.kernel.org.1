Return-Path: <stable+bounces-237671-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sL2BBoNv3WkgeQkAu9opvQ
	(envelope-from <stable+bounces-237671-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:34:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id AE74B3F3E9C
	for <lists+stable@lfdr.de>; Tue, 14 Apr 2026 00:34:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 2B39330275B5
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 22:34:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DA0F39DBC9;
	Mon, 13 Apr 2026 22:33:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dJkzuIf3"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4017F39020C
	for <stable@vger.kernel.org>; Mon, 13 Apr 2026 22:33:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776119612; cv=none; b=iLqrssrE+obhdIoozixYHJroqM46ugkx6MdOtGv6sR5qLn85PJROfDUcuZnSrYRFQaxF7Y4Hvg6KVVStJE+WCjIABY4rsJZfY86KgIaTeTVy4a2wwoVtrapw6f1PlEx3EiB3w5+Aw8SyQEIagzuUmon5h6cDsjwyKiU23f5X+pM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776119612; c=relaxed/simple;
	bh=lhD6FtXLIn5PaqVXSfroWTMGFDCiskoF20ApYKZawIM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pfwSRq+Hy0+kz99+lAm5Kj+HS8rgXLnGicZdgWHspOOyOMON/AUmsplVIPMhDeVMTHorslJHcAIs48EMxGM1i1z6orU4ww7qUuBNqIm5RxOtunj4d9oMnMy+D20YU7ZCEyAxcYu7tUbZyc/rjdtN/3plstqxs6f2fTFTpfRlMBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dJkzuIf3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2641CC2BCAF;
	Mon, 13 Apr 2026 22:33:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776119611;
	bh=lhD6FtXLIn5PaqVXSfroWTMGFDCiskoF20ApYKZawIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dJkzuIf3Pz401yM12L0/Vh/SCWltIOOFWmQVuEqh26WfapSbjQC5AGQDJYXBnYZKz
	 qugLy8mSMxqJfJ1PIS1/a0aLwygQrr2Q5/79fLmdcWenw9jrXzfSf84GotVsWJDgui
	 2mpwfuFH2cMN0/rw/prjXV95usYxP2JAIle14AOWEIVEcfUZmuLsj4AAdiM0BEiDd5
	 Ja5mSIvdkQohxoUO4PzgOJTmUqplQXiGGeVusqcZ/J/T7F6uDS3mQGKtklLkuQe07X
	 zjfOmAVUurelyGt9AVce8LeV41kjhlTrjW0QRRZbIMUkzHhVZAN7O0TORSEI8lEJO2
	 clBaoqXq7wXrg==
From: Sasha Levin <sashal@kernel.org>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: Sasha Levin <sashal@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	stable@vger.kernel.org,
	"Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH 5.10 290/491] ACPI: EC: Install address space handler at the namespace root
Date: Mon, 13 Apr 2026 18:33:29 -0400
Message-ID: <20260413223330.3761071-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <dce92963d28f3419e014c428a0b243f4fe638109.camel@decadent.org.uk>
References: <20260413155819.042779211@linuxfoundation.org> <20260413155829.901289649@linuxfoundation.org> <dce92963d28f3419e014c428a0b243f4fe638109.camel@decadent.org.uk>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-237671-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	TO_DN_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: AE74B3F3E9C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Mon, 2026-04-13 at 22:17 +0200, Ben Hutchings wrote:
> It appears that this can cause regressions, which were fixed by commits
> 71bf41b8e913 ("ACPI: EC: Evaluate _REG outside the EC scope more
> carefully") and 0e6b6dedf168 ("ACPI: EC: Evaluate orphan _REG under EC
> device") upstream.

Dropped from the 5.15 and 5.10 queues along with the following
dependencies:
  - "ACPI: EC: clean up handlers on probe failure in acpi_ec_setup()" (5.15, 5.10)
  - "ACPI: EC: Evaluate orphan _REG under EC device" (5.15)

Thanks for catching this.

