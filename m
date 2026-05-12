Return-Path: <stable+bounces-245363-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gJ+HDddxAmowtAEAu9opvQ
	(envelope-from <stable+bounces-245363-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:18:31 +0200
X-Original-To: lists+stable@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 90914517CF4
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 02:18:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 4D4223023056
	for <lists+stable@lfdr.de>; Tue, 12 May 2026 00:18:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E71EE7B7;
	Tue, 12 May 2026 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lbSCHJno"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8C1347C7
	for <stable@vger.kernel.org>; Tue, 12 May 2026 00:18:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778545108; cv=none; b=ga9X7iSgwjbDMdud/CQYgUwmcmP7xE+PWJN4gbPjsZ2YBVNgOLu3bzPPwGjbRTnVcmi9nAbpZSu1tcl3XoLqqNmgIvZEl3dF3VQYL1ODaHNziSAbSDPvj3GqheAb1Hi8yAKTT7QzXcwpBTqFgOrV9vE9p/gK8deOy4/rlPGJiKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778545108; c=relaxed/simple;
	bh=xlxm7trPNs58hoQC/yGdtOJSu/zrYBWRWL6bQOYrsaw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C4+FL3zCN4Z444+ioRdu2IwqtC9ZddLlvxtg2tBztVHoYRePwibaYPEu+9TI1dilSGl+nZQn4uvKcztUBe1YX6ztkensMVuOnDk3LaoPrMXRMIudbpQ+j3wvLEClU38y6n/NcYNYkvfiSeu9GpLBUbyapuj3EWJVJF4TWBYegpc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lbSCHJno; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCBF5C2BCF5;
	Tue, 12 May 2026 00:18:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778545108;
	bh=xlxm7trPNs58hoQC/yGdtOJSu/zrYBWRWL6bQOYrsaw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lbSCHJnoMaOhbr8MuLUfAs7bZxpUjvqLaC0tA3uj1KIwh2He6WqcM/geVBk/mrrlj
	 vIBkTevP9SazB4POZsrWZyurndeh/WGM6DP9zZIORLE7kuEteaWR04Ntd4p5Ag+T5z
	 6mFilP0Eaclf73162a/r+3K0ZFNGhADbfuQJuaZeRwdim8G7wAmKMtQtDftLZz6PIs
	 3fHF2J33K8CFYULZ09klSKXcBFOgL9xww4mLwB9UZHcOhL3RY1aD1RooENs6jUIRfu
	 Vmfx3/7TEUdHrF7afxk4U84Da27I6g026fn0vmGdnqx/vkCr8pUAkwhxLXFcEeXmRk
	 RPyq8n7vM7CfA==
From: Sasha Levin <sashal@kernel.org>
To: gregkh@linuxfoundation.org
Cc: Sasha Levin <sashal@kernel.org>,
	dhowells@redhat.com,
	guanwentao@uniontech.com,
	imv4bel@gmail.com,
	jiayuan.chen@linux.dev,
	stable@vger.kernel.org,
	torvalds@linux-foundation.org,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeffrey Altman <jaltman@auristor.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	stable@kernel.org,
	Jakub Kicinski <kuba@kernel.org>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: Re: [PATCH 6.12.y v3 1/2] rxrpc: Fix conn-level packet handling to unshare RESPONSE packets
Date: Mon, 11 May 2026 20:17:54 -0400
Message-ID: <20260511220000.stable-reply-item003@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260511074104.60836-1-guanwentao@uniontech.com>
References: <20260511074104.60836-1-guanwentao@uniontech.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 90914517CF4
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	TAGGED_FROM(0.00)[bounces-245363-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,uniontech.com,gmail.com,linux.dev,vger.kernel.org,linux-foundation.org,auristor.com,lists.infradead.org,oracle.com];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Action: no action

On Mon, May 11, 2026 at 03:41:04PM +0800, Wentao Guan wrote:
> (cherry picked from commit 24481a7f573305706054c59e275371f8d0fe919f)
> [Readd rxrpc_skb_put_response_copy which missed in 016725807ce3 in v6.12.86]
> Stable-dep-of: aa54b1d27fe0 ("rxrpc: Also unshare DATA/RESPONSE packets when
> paged frags are present")

Queued for 6.12 (both 1/2 and 2/2), thanks.

I fixed up the bracket annotation at apply time per Harshit's review:
the trace event was actually dropped in bf20f46d94f1 ("rxrpc: Fix
potential UAF after skb_unshare() failure"), not 016725807ce3, so the
queued changelog references bf20f46d94f1.

-- 
Thanks,
Sasha

