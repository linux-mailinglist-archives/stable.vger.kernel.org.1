Return-Path: <stable+bounces-241330-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KNKQM2Rk72mHAwEAu9opvQ
	(envelope-from <stable+bounces-241330-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:28:04 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D9654735FE
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 15:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9B7FE301A5D9
	for <lists+stable@lfdr.de>; Mon, 27 Apr 2026 13:26:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A31133CEBBC;
	Mon, 27 Apr 2026 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Db8CIdVq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6581B3CEB84;
	Mon, 27 Apr 2026 13:26:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777296385; cv=none; b=H5tE2IgFsGNSxuFFK08DQU/b6XUrgoaIERZwTTP/job0rlOsNcFH6iQubPpQ01sbu3l3qmCTJCnMpagM4yodZHC/bX3zKbYm+RdQplJqhM+Ax9pmb47L1nrPJVYN+mUG8lPiPK3LwxxtkWccZ/IP1D5Q2xlTNFfpApJqJBXa9nc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777296385; c=relaxed/simple;
	bh=87aWx7xhsAQb2FDwkSkXZ1QoTCDGxsiTk72A/vQl/rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Message-Id:Date:
	 MIME-Version:Content-Type; b=YQ8WFbTByrRF6gm8bR6UZlKdRYrubp1/CQpcnIR4DygU6L8Yh+cJJrE3f7qAbS7Dz0xbSoFBCqNuxvO/grswUnAJBCjtyU2DBfDVqD0XhJac2Ri3LUpEPiKPcJUthztv+WsMX0fPJC8117OgiAp10Y1jCylds7Wei/vthI77Jxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Db8CIdVq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1F5C2BCB4;
	Mon, 27 Apr 2026 13:26:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777296385;
	bh=87aWx7xhsAQb2FDwkSkXZ1QoTCDGxsiTk72A/vQl/rE=;
	h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
	b=Db8CIdVqwYXVOvI/70lsDNkEOrwD8d97wAukc/tUs6IZAKEV6ts2uenc7dJoYDqAs
	 MZc9/+g2Po81nnivaT1kuDzjs361YDRq6LEZ4GYf8qf/UGu/aFStvEPv/gi3/OU0tp
	 +FTRPWZ2H7PLA+9PAXvoPUf2K/ntRnjLPZAoySY2DfGry2PguHie5UB1167axvseYb
	 PP7vyefTK2+/emXKWDm6QWMfUFmJb1QgUPjbIsw5BlZe4iL0t22hxqZ6xq6nya/Bax
	 C4EXD2kJ0skyPiEWEUL87mbs+ZK8uID0F9V4TlpS/k5Imi+LT4O1n62hffBwpx4+ZF
	 nSqAj3alpNm/w==
From: Carlos Maiolino <cem@kernel.org>
To: linux-xfs@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Wilfred Mallawa <wilfred.opensource@gmail.com>
Cc: Hans Holmberg <hans.holmberg@wdc.com>, 
 "Darrick J . Wong" <djwong@kernel.org>, 
 Wilfred Mallawa <wilfred.mallawa@wdc.com>, stable@vger.kernel.org
In-Reply-To: <20260417021628.2608734-3-wilfred.opensource@gmail.com>
References: <20260417021628.2608734-3-wilfred.opensource@gmail.com>
Subject: Re: [PATCH] xfs: fix memory leak for data allocated by
 xfs_zone_gc_data_alloc()
Message-Id: <177729638335.100803.1638951468319151843.b4-ty@kernel.org>
Date: Mon, 27 Apr 2026 15:26:23 +0200
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.14.3
X-Rspamd-Queue-Id: 6D9654735FE
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-241330-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_TO(0.00)[vger.kernel.org,gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[cem@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]

On Fri, 17 Apr 2026 12:16:30 +1000, Wilfred Mallawa wrote:
> In xfs_zone_gc_mount(), on error, a struct xfs_zone_gc_data allocated
> with xfs_zone_gc_data_alloc() is freed with kfree(), however, this
> doesn't free the underlying folios or the rmap_irecs.
> 
> Use xfs_zone_gc_data_free() to correctly free this memory.
> 
> 
> [...]

Applied to for-next, thanks!

[1/1] xfs: fix memory leak for data allocated by xfs_zone_gc_data_alloc()
      commit: af47a4be6a90c8bfc874f9994ac9c15813b9718b

Best regards,
-- 
Carlos Maiolino <cem@kernel.org>


