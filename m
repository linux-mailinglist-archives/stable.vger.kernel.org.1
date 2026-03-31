Return-Path: <stable+bounces-231419-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uNoDGSvCy2mnLgYAu9opvQ
	(envelope-from <stable+bounces-231419-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:46:35 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E335E369AA7
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 14:46:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1CF8D3068F17
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 12:39:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C84D3DFC71;
	Tue, 31 Mar 2026 12:39:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pDenDHUN"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0ED373603FA;
	Tue, 31 Mar 2026 12:39:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774960780; cv=none; b=bj0ObEbnsvxSaCx46r3DypHkjdt8Lro/Q40/gccqAPx7x963880Z2omHyqeXz/8irQkukwnQSmA1+gvxCr+tqOZVfYgHONJFyFMlA84/oJq0J5j4z0ZynUkukHwBI4bBjDb5lm5XQKr63jvLpMm6dKign1k6Lk3wkEpdbnHTKqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774960780; c=relaxed/simple;
	bh=M/Hqmm8ZfhkqxHNDyMS5I/Nq20jDynT23Sq1dpCa89c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=d+S5K4S2peyDDjZNbzu9Y2EcSlcONzRRlOJBUb1XGW5RREs9Rv8poiSr40M/zt6KKDgxnFoUOxtLMPltKXPopYWGRX0UhvKuvhQlen6lV4+bHwPy+ArHXctJiUWc4+FqJEawtkmt0tF2oM9oXuU8TmzOUfnvc81KbZjBBzDkwaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pDenDHUN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C2A8C19423;
	Tue, 31 Mar 2026 12:39:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774960779;
	bh=M/Hqmm8ZfhkqxHNDyMS5I/Nq20jDynT23Sq1dpCa89c=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=pDenDHUNVhFJ1sPNEUNVmwsM7mrSNdnqYp85rCzaOM/t+01hIB7XlfhrPgMnTO8as
	 8/VYCdClfhl9pjtShLzvICZ+zEoU/OHa5ApQGVB59U0LWTqV5evJkBWeT/NECpf0pE
	 dY4gh76A18su6oh5qEKGe0qvjRSUaO94vhBvD1z+zrZ5mWpXX2+xcsu+MBoo9e6qLJ
	 bEaMpCQZVlQFh2Aa1tnPWwyjXjABj7GLsTBeiYIG5yePK+zqSWzuvo8wJVPJFOSw2d
	 h/T+lq7MfwJjSIg+RMlJySpPKT3Qc1v4/DsQLbeYh6e+YPz6FW7FURKtkyCMpSviOF
	 NAF//W9yAo+lg==
From: Lee Jones <lee@kernel.org>
To: Lee Jones <lee@kernel.org>, Herve Codina <herve.codina@bootlin.com>, 
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, 
 linux-kernel@vger.kernel.org, Brian Mak <makb@juniper.net>
Cc: stable@vger.kernel.org
In-Reply-To: <20260325223024.35992-1-makb@juniper.net>
References: <20260325223024.35992-1-makb@juniper.net>
Subject: Re: (subset) [PATCH v4] mfd: core: Preserve OF node when ACPI
 handle is present
Message-Id: <177496077812.3887811.9279307706881587061.b4-ty@b4>
Date: Tue, 31 Mar 2026 13:39:38 +0100
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Mailer: b4 0.16-dev-ad80c
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-231419-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lee@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E335E369AA7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, 25 Mar 2026 15:30:24 -0700, Brian Mak wrote:
> Switch device_set_node to set_primary_fwnode, so that the ACPI fwnode
> does not overwrite the of_node with NULL.
> 
> This allows MFD children with both OF nodes and ACPI handles to have OF
> nodes again.
> 
> 
> [...]

Applied, thanks!

[1/1] mfd: core: Preserve OF node when ACPI handle is present
      commit: caa5a5d44d8ae4fd13b744857d66c9313b712d1f

--
Lee Jones [李琼斯]


