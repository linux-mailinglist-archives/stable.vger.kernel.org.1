Return-Path: <stable+bounces-272412-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id nEqDI33mTGoWrwEAu9opvQ
	(envelope-from <stable+bounces-272412-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 13:43:57 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id EF15D71B0FB
	for <lists+stable@lfdr.de>; Tue, 07 Jul 2026 13:43:56 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=cLE9+oCb;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "stable+bounces-272412-lists+stable=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="stable+bounces-272412-lists+stable=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2178430CCDD5
	for <lists+stable@lfdr.de>; Tue,  7 Jul 2026 11:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22B8F3F88BA;
	Tue,  7 Jul 2026 11:37:36 +0000 (UTC)
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA9773F8890;
	Tue,  7 Jul 2026 11:37:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783424255; cv=none; b=i1XJo2m4chpWQaIi8qYW6Iwq8S7d7qyBW0SkTM460VvnMXTTUiZ0XYPqT5bPNQP0VTgCLzu6TBt003bpeMNoyb0ftOcNIRPN/X4Zr41nnlHQPYdqre+yh4U9pTQBRZIo0MUkd8R600jCED6juS7I/30pdjFVivfx1a+HuPWtdI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783424255; c=relaxed/simple;
	bh=PUo+3K0Q1NJfep5hQqfQlWTmat/wLFDSiUbXhXpAano=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=hZMzSDKwXethSaYLGfScBbCxFLk/cux02DM/LbyW+3e7+KU0/5FY+e3v4q/+vud1YA5n5FlVO5OKdkaG2UxZ/TLuvELjE4bH8lO/zsQ9CTzRPc6ddlYS6ul/h2knMN6E+hRNNXP3jfon7uhMpHeaMyKgSzeYvcWs/VN+I4OgjWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cLE9+oCb; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 412761F00A3A;
	Tue,  7 Jul 2026 11:37:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783424254;
	bh=+k86CLm+gnkbII2jSjaE+dGWoQpJrqTR4ETI0quIwtI=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date;
	b=cLE9+oCbezyPcC0+8Heu2Ji1XNFSW4st9sTnw7G3A88T1ysFPI0e/sv0SpJXxRuy0
	 BtDrhBUgWV2jsaAjpTd2bofRkxJxcOQcL0tUHwE0rAxzdqgxtk/lBdYUYPo1xqnJuU
	 jen/H8h6wPfCSqqviHwTCJ1z78TwDdBv4LjrWCjndx5M5axT8rpeiAxImy1VpSHIEe
	 5dDZ4edPgpZdFSs4HRhnrDssI3/VOW1iOD7YaL0cu2YHyzs+d2yRq7gxgSYoez4k0F
	 vQ19RzZMH1yU3Y7G1R6rh4drg4bbFb3/BNm1PQLd1PRRne+bOlo2xfwBKkcwugDz2I
	 ldJhaq/8vytdw==
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org, Weiming Shi <bestswngs@gmail.com>
Cc: "Darrick J . Wong" <djwong@kernel.org>, 
 Brian Foster <bfoster@redhat.com>, Christoph Hellwig <hch@infradead.org>, 
 Xiang Mei <xmei5@asu.edu>, stable@vger.kernel.org
In-Reply-To: <20260702162000.3548359-4-bestswngs@gmail.com>
References: <20260702162000.3548359-4-bestswngs@gmail.com>
Subject: Re: [PATCH v3] xfs: fail recovery on a committed log item with no
 regions
Message-Id: <178342425298.389943.1711934889930818397.b4-ty@b4>
Date: Tue, 07 Jul 2026 13:37:32 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.15.2
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-4.66 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	FORGED_SENDER(0.00)[cem@kernel.org,stable@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:linux-xfs@vger.kernel.org,m:bestswngs@gmail.com,m:djwong@kernel.org,m:bfoster@redhat.com,m:hch@infradead.org,m:xmei5@asu.edu,m:stable@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-272412-lists,stable=lfdr.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	TAGGED_RCPT(0.00)[stable];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: EF15D71B0FB

On Thu, 02 Jul 2026 09:20:00 -0700, Weiming Shi wrote:
> If the first op of a transaction is a bare transaction header
> (len == sizeof(struct xfs_trans_header)), xlog_recover_add_to_trans()
> adds an item but no region, leaving it on r_itemq with ri_cnt == 0 and
> ri_buf == NULL.
> 
> The header can be split across op records, so later ops may still add
> regions; the item is only invalid if the transaction commits with none.
> The runtime commit path never emits such a transaction, so this only
> happens on a crafted log.  It came from an AI-assisted code audit of the
> recovery parser.
> 
> [...]

Applied to for-next, thanks!

[1/1] xfs: fail recovery on a committed log item with no regions
      commit: 92d2d133c6cb38582fd52e6fa903ff0b6a00918e

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


