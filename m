Return-Path: <stable+bounces-227598-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sJL1IaSJvWnQ+gIAu9opvQ
	(envelope-from <stable+bounces-227598-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:53:40 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 31D722DEF85
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 18:53:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E3ED03168312
	for <lists+stable@lfdr.de>; Fri, 20 Mar 2026 17:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93BD305064;
	Fri, 20 Mar 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pWQ++Bbn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 877372874F5;
	Fri, 20 Mar 2026 17:49:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774028945; cv=none; b=qzY9Nnj/87YwAvGa0ZDrQqWpsMTPfPx6O9QmbTKnTlIYVrtg+3BlqjWWOjm0I3hRmDDeaK7gVRYfjNuGFql5+EvheW5Dq0/EJb6tH0RkGqXtwrf6n3+M1hpqX15AUyKT/INbYAz7vfvwiWryhF4MnXPmv6FdyC+I1Jb2vmDpCI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774028945; c=relaxed/simple;
	bh=x5coYV2m0Hrf853jK3AxLiJPMYhCiTplE5pkNnUBd3s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d80G9FZ/Dvur5jaNGJSw7LPdK0fHlS3Eqegrlsx4mPcixTzRHAppOLJb3kgKU/JO0/YLMzsxze+URTI/sEkSh9jtlOfdX14eRwWjXWIdZ0FOUhVj7fFh37Qc4ysCyHvQZCGpyv8PgQOA/dOgvC3CnJpXurd8wnQzCFeoaqNzdUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pWQ++Bbn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4789CC2BC87;
	Fri, 20 Mar 2026 17:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774028945;
	bh=x5coYV2m0Hrf853jK3AxLiJPMYhCiTplE5pkNnUBd3s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=pWQ++BbnJGdNK5Nxc684tR8zXPop5sbC7wcbUaQJcZwAaxn40MpVo0CpwrGGXb/Am
	 vZSQm93CQ8talTNdSjhcYjj0kEHNyBzHzIQPGeWPatJHWnPZ/V7s8TEpxjZH1va++J
	 TCZz5IVGrhhJtaZd3qCw8hByuO6gs0bPVESa+5eacXUd9J+e2fJnH9ZpqFvz29jlgw
	 cFu0ZI4HUsFRcv8XF+nXoCFNLYTwffIajLtXbHumGG0COkbPKwtSSldZNtGYrNE8eh
	 vH6nwITJIQaRTKYEHb50m4XI5Vdfnn/w/REc/HShm2WZr/Ksdi8r6Owinh4GQDS1Gu
	 Z4Gd1uDSH3/4A==
From: Simon Horman <horms@kernel.org>
To: emil.s.tantilov@intel.com
Cc: Simon Horman <horms@kernel.org>,
	daniel@iogearbox.net,
	ast@kernel.org,
	willemb@google.com,
	stable@vger.kernel.org,
	decot@google.com,
	bpf@vger.kernel.org,
	anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	intel-wired-lan@lists.osuosl.org,
	edumazet@google.com,
	netdev@vger.kernel.org,
	pabeni@redhat.com,
	andrew+netdev@lunn.ch,
	kuba@kernel.org,
	davem@davemloft.net,
	sdf@fomichev.me,
	aleksandr.loktionov@intel.com,
	aleksander.lobakin@intel.com,
	john.fastabend@gmail.com,
	hawk@kernel.org
Subject: Re: [PATCH iwl-net v2] idpf: fix xdp crash in soft reset error path
Date: Fri, 20 Mar 2026 17:48:43 +0000
Message-ID: <20260320174843.137651-1-horms@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260319224159.23885-1-emil.s.tantilov@intel.com>
References: <20260319224159.23885-1-emil.s.tantilov@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[kernel.org,iogearbox.net,google.com,vger.kernel.org,intel.com,lists.osuosl.org,redhat.com,lunn.ch,davemloft.net,fomichev.me,gmail.com];
	RCVD_COUNT_THREE(0.00)[4];
	RCPT_COUNT_TWELVE(0.00)[22];
	TAGGED_FROM(0.00)[bounces-227598-lists,stable=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.913];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 31D722DEF85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
idpf: fix xdp crash in soft reset error path

This commit fixes a NULL pointer dereference that occurs when
idpf_vport_open() fails during soft reset. The fix restores
vport->xdp_prog in the error path and updates the restart check in
idpf_xsk_pool_setup() to use IDPF_VPORT_UP instead of netif_running().

> Fixes: 3d57b2c00f09 ("idpf: add XSk pool initialization")

The Fixes: tag may not be targeting the correct commit. The primary bug
being fixed is the NULL pointer dereference crash in idpf_xdp_setup_prog()
that occurs when soft reset fails and vport->xdp_prog is not restored.

Looking at the git history, this missing restoration was introduced in
commit 705457e7211f ("idpf: implement XDP_SETUP_PROG in ndo_bpf for
splitq"), where idpf_xdp_setup_prog() was first implemented. While commit
3d57b2c00f09 introduced the secondary issue with the netif_running()
check, the main crash fix addresses code from commit 705457e7211f.

Should the Fixes: tag point to commit 705457e7211f instead?

