Return-Path: <stable+bounces-210698-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eD7SNVl1cGktYAAAu9opvQ
	(envelope-from <stable+bounces-210698-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:42:33 +0100
X-Original-To: lists+stable@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8502552389
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 07:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DE852508FF5
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 06:40:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 36BB541C2FD;
	Wed, 21 Jan 2026 06:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="InV3kXnt"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8A373644DC;
	Wed, 21 Jan 2026 06:40:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768977619; cv=none; b=hvwJxZ+0/I1Y+0OTSoWxEPQIRzPeV913IHWBRsX2maVY93OMM/Rm9/OROlXZcCfx+pHnjdcF7OIPS/LZcKRZjfwSJHxUhGk5FbWx1HojBrV2yi8z3ph+eURK2Qpmrlk8BnRTDfCaC3ODAaUIsCeCnm3v3z4p1uo2nhpNVfTwWe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768977619; c=relaxed/simple;
	bh=4iUG7rwb9S6rcDB1VukD+be4x0LJo+fGtwH7rT2pSyo=;
	h=Date:Subject:From:To:Cc:Message-ID:MIME-Version:Content-Type; b=OPD2leCSlVFqom73jMkb+X+t+LafgIEG2ZADUf1gcO2thWy/E2tyZ+Iv/ZkZs6oAcfKo23bkGi7XHEgkgzYyi4MetUM9HTIxWPMLxD9XujJ7heVpwruWxOg0vZqejvyrUSGW7KD9mVWSAHYev88rpK2f2BwtszE/wrDBdcEMaP8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=InV3kXnt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A643C116D0;
	Wed, 21 Jan 2026 06:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768977618;
	bh=4iUG7rwb9S6rcDB1VukD+be4x0LJo+fGtwH7rT2pSyo=;
	h=Date:Subject:From:To:Cc:From;
	b=InV3kXntxsz+drHiS25XEsbhTkuOUTXA6KQDRfPMHDU985XEA/7YML7/lHBXamgKD
	 0HcHIGeXXajMrIGBRkYdstQuR1oFGhG3NtV2/3WP2moHNZzo83HX+Lkk0bXN8bH4bG
	 R0VhqlrmXxAHIhbJq5140YHQhfSg42J7vik+AgdpkedSvCSU9Uj70OFErqg9HCjcy6
	 M6v7LbSQRmzL0cizrzG1DSk5otOIgHpcQ17RkbyQPdob7BPQ686XtTApwFhAEeyEZ1
	 cBshz8HZ50tZxkabfi12m+hXUv5Ot293wwRaWg2OK4+4lkSaw74TLwlLjJuAtDBksB
	 a1j5c9RJal2wg==
Date: Tue, 20 Jan 2026 22:40:17 -0800
Subject: [PATCHSET] xfs: syzbot fixes for online fsck
From: "Darrick J. Wong" <djwong@kernel.org>
To: cem@kernel.org, djwong@kernel.org
Cc: stable@vger.kernel.org, r772577952@gmail.com, r772577952@gmail.com,
 hch@lst.de, linux-xfs@vger.kernel.org
Message-ID: <176897723519.207608.4983293162799232099.stgit@frogsfrogsfrogs>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[vger.kernel.org,gmail.com,lst.de];
	FROM_HAS_DN(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-210698-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[djwong@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	TO_DN_NONE(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: 8502552389
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hi all,

Fix various syzbot complaints about scrub.

With a bit of luck, this should all go splendidly.
Comments and questions are, as always, welcome.

--D
---
Commits in this patchset:
 * xfs: check the return value of xchk_xfile_*_descr calls
 * xfs: only call xf{array,blob}_destroy if we have a valid pointer
 * xfs: check return value of xchk_scrub_create_subord
 * xfs: fix UAF in xchk_btree_check_block_owner
---
 fs/xfs/scrub/agheader_repair.c   |   14 ++++++++++++--
 fs/xfs/scrub/alloc_repair.c      |    5 +++++
 fs/xfs/scrub/attr_repair.c       |   26 ++++++++++++++++++++++++--
 fs/xfs/scrub/bmap_repair.c       |    5 +++++
 fs/xfs/scrub/btree.c             |    7 +++++--
 fs/xfs/scrub/common.c            |    3 +++
 fs/xfs/scrub/dir.c               |   10 ++++++++++
 fs/xfs/scrub/dir_repair.c        |   16 ++++++++++++++--
 fs/xfs/scrub/dirtree.c           |   18 ++++++++++++++++--
 fs/xfs/scrub/ialloc_repair.c     |    5 +++++
 fs/xfs/scrub/nlinks.c            |    8 +++++++-
 fs/xfs/scrub/parent.c            |    8 ++++++++
 fs/xfs/scrub/parent_repair.c     |   20 ++++++++++++++++++++
 fs/xfs/scrub/quotacheck.c        |   15 +++++++++++++++
 fs/xfs/scrub/refcount_repair.c   |    8 ++++++++
 fs/xfs/scrub/repair.c            |    3 +++
 fs/xfs/scrub/rmap_repair.c       |    3 +++
 fs/xfs/scrub/rtbitmap_repair.c   |    3 +++
 fs/xfs/scrub/rtrefcount_repair.c |    8 ++++++++
 fs/xfs/scrub/rtrmap_repair.c     |    3 +++
 fs/xfs/scrub/rtsummary.c         |    3 +++
 fs/xfs/scrub/scrub.c             |    2 +-
 22 files changed, 181 insertions(+), 12 deletions(-)


