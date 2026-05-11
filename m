Return-Path: <stable+bounces-245319-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0LNMNI01AmocpAEAu9opvQ
	(envelope-from <stable+bounces-245319-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:01:17 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04D345155F9
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 22:01:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 61092303AA9D
	for <lists+stable@lfdr.de>; Mon, 11 May 2026 19:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BD6B37F017;
	Mon, 11 May 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZAyt90Jj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D3CC2EBBA4;
	Mon, 11 May 2026 19:58:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778529518; cv=none; b=oBp0dOv8wqXQdvOg7zNRE+G+NPMrwNzPl4/CsUJq+TT+ePBCGGeUPlZGmDHfDeehB0u723LWxxuG7ZRAW6ShxFRhwxvoE1PmHMwHLjx9WCm/lt9ocihky96rZmLGLwUJzFvheLR4S+8sj1jQbWccmw7UeKcSH42iUK8JrX4RJ0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778529518; c=relaxed/simple;
	bh=2JCO51qO4+IOkmuGN472rkSyacZbu7U5n+78w54DJrI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EP+4ash0DPBg5/JFealvfRm7tJxYHCB7He+2JOePu6RKJO1df6KabRUjiaVsJVG/06fTLCNqTT/rFQwQ1MmEyxpsuQUZcpcJUGHPUvPQKYZu4Lh2KcgCvObnr2RT0IXZ81sbSPH2iNVel4eGP4QWYXa2YoEcQXPJEVwkoTUjWSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZAyt90Jj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98ABDC2BCB0;
	Mon, 11 May 2026 19:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778529517;
	bh=2JCO51qO4+IOkmuGN472rkSyacZbu7U5n+78w54DJrI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZAyt90JjilyZxyMBv5L5rljVX2ESrOUNOxKX5qfqbFIUPwJMQzSE3aS5OazEwECzv
	 lIgN02Mc8EuJKH48FEAVj5Z6x5e8AmQe9+25J1eiQ2rPQuyygYOCX+vtz2PhSwKVhy
	 VbyIMFzaeKRg2aPaRdh0AYkmH75GtWkZjfLNM2/EpGSd5qAWRDp/rZ71eiZPaWcf3z
	 r0k+n03W1snz3qEOwm2uYXRVhmAGC/YThyl1GCy0S9Emfq61+ZKWywtOrdZ32D7p1q
	 K8WFBSnTYbYnH4/4YqvCcgQLW54JwjkvdNYSIQegQY18JWIWmWPPXLH8sRuOifL9hp
	 Q6FKY0rG7FWEQ==
From: Danilo Krummrich <dakr@kernel.org>
To: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Cc: "Rafael J . Wysocki" <rafael@kernel.org>,
	Len Brown <lenb@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Danilo Krummrich <dakr@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Daniel Scally <djrscally@gmail.com>,
	Heikki Krogerus <heikki.krogerus@linux.intel.com>,
	Sakari Ailus <sakari.ailus@linux.intel.com>,
	Saravana Kannan <saravanak@kernel.org>,
	Rob Herring <robh@kernel.org>,
	linux-acpi@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	brgl@kernel.org,
	stable@vger.kernel.org
Subject: Re: [PATCH v2] device property: initialize the remaining fields of fwnode_handle in fwnode_init()
Date: Mon, 11 May 2026 21:58:31 +0200
Message-ID: <20260511195831.3418395-1-dakr@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com>
References: <20260511074927.9473-1-bartosz.golaszewski@oss.qualcomm.com>
X-Patch-Reply: applied
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 04D345155F9
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,linuxfoundation.org,linux.intel.com,gmail.com,vger.kernel.org,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-245319-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dakr@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, 11 May 2026 09:49:26 +0200, Bartosz Golaszewski wrote:
> [PATCH v2] device property: initialize the remaining fields of fwnode_handle in fwnode_init()

Applied, thanks!

  Branch: driver-core-testing
  Tree:   git://git.kernel.org/pub/scm/linux/kernel/git/driver-core/driver-core.git

[1/1] device property: initialize the remaining fields of fwnode_handle in fwnode_init()
      commit: 7eba000621ff

      [ Fix typo in commit message. - Danilo ]

The patch will appear in the next linux-next integration (typically within 24
hours on weekdays).

The patch is in the driver-core-testing branch and will be promoted to
driver-core-next after validation.

