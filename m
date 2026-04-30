Return-Path: <stable+bounces-242145-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id aCcwGPd382mt4AEAu9opvQ
	(envelope-from <stable+bounces-242145-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:40:39 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 041604A4F8C
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 17:40:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 235ED3001FFF
	for <lists+stable@lfdr.de>; Thu, 30 Apr 2026 15:38:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F7F3290D2;
	Thu, 30 Apr 2026 15:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTKO1+k6"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0972E2C08D4;
	Thu, 30 Apr 2026 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777563528; cv=none; b=Ovz1g9ErKZazoFYgRQlDsp3m0Je/lFcnKEaqv9Pc4HLBj4Tr9IVFyvdYY8CzVDzPOJeC47kuHf2zFfxCLiEHrBHrYT1Jbs+/B7+DCEuIUGJpc1zxeY7agmwX7FQAN99xd4phiniZmF4qdMnwUVnsTdZa/RdvGBv6mUilljcpBkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777563528; c=relaxed/simple;
	bh=8OolfLwWwxTmLUkqeMTXK9OIOZKt5KSDF1NSjnW2kL0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=khAppTekrp0xrUTn5BiKUyTzlxxlYD+vu7YIN5OeaPA/jCm0h6JkkyJbc2io+wS/K02ezhsyT3CM4mmP6YnnIsk2MDzjtsm8mrCmlqjvnpDOfRrP5GVWjA7Lo50jAqTmFOW0DBFlvb3HWJxI/3TQB9r68UxRj7eveybLATUqTU8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTKO1+k6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECDD4C2BCB3;
	Thu, 30 Apr 2026 15:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777563527;
	bh=8OolfLwWwxTmLUkqeMTXK9OIOZKt5KSDF1NSjnW2kL0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MTKO1+k6e4KsB4vN8Qz2H3X9XzIX5BQ2eRM3SjOI/tCLKTDl6LH8uH5CLNnHFcb4k
	 s/BwW4XJ4jCfNNunZDL7wfPqIiYMR4WCHxsrAJN+DOzMNMiTkRwoQ0d9cm3n+uOnJs
	 oo8wqMh1jkM78zP5AXXHOtnbUnP9ZSN0fSU4BtN7sI1l6pIcR9JYBEpImVPq5rCRei
	 D9H+MCe023NPDxPlj9KK07MaAAMcwj3T5kHGfFp3VpuJzoQTEWSnrdvzSyphCo/B6/
	 fvcjQwZzaNJm3t8y4sPqUtu8k9y1iyaLQ8li8+e+HN2KTrQUdyOwj8DRd3nawSCQpF
	 hWmhxgs9IWdqQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Rafael J Wysocki <rafael@kernel.org>,
	Danilo Krummrich <dakr@kernel.org>,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] driver core: reject devices with unregistered buses
Date: Thu, 30 Apr 2026 17:38:43 +0200
Message-ID: <20260430153843.3517839-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430091718.230228-1-johan@kernel.org>
References: <20260430091718.230228-1-johan@kernel.org>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 041604A4F8C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-242145-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Thu, 30 Apr 2026 11:17:18 +0200, Johan Hovold wrote:
> [PATCH v2] driver core: reject devices with unregistered buses

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] driver core: reject devices with unregistered buses
      commit: 13c7c1752b6c

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.

