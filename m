Return-Path: <stable+bounces-234725-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eAr6FMSm1ml9GwgAu9opvQ
	(envelope-from <stable+bounces-234725-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:36 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id CF69F3C2553
	for <lists+stable@lfdr.de>; Wed, 08 Apr 2026 21:04:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 354E931D9D82
	for <lists+stable@lfdr.de>; Wed,  8 Apr 2026 18:40:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EA43D75AF;
	Wed,  8 Apr 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HnTWKy12"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39B18B67E;
	Wed,  8 Apr 2026 18:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775673601; cv=none; b=Iv7TNIcxnapBWkjfCI9rbnpcD/6AsUNgvMK+TJmptUax81D1bhYuum11EIX2JRdaS0wJihXSDvYHtfkS7BonQWkydVYU/IZM7NBYy7/6FifElFX+xreLw/2Ox9ifZUDA5CpXuP1liXwHJSy9LXFB9hTuIa38xV86CZ5e72fYdFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775673601; c=relaxed/simple;
	bh=iUi4nhaRTNB4iyPw7mzkRDoY0VSzD+LqMFcus23npyg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ceP+74XjoCyoOhqi3agA2bdA0g8jD4D9m9Oz5qcXr0ig2n2t0pFwG/WetH25QT3vF7iYAPVIap/46Nsrp1q5279wUbbcJuOd+nIwsmgpfkYMGTCp/AcqJW693w1wMCbLpPZBYjfn287VDp5T1HBRvuVfgR301z4ArQ5SY5QH8Lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HnTWKy12; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4774C19421;
	Wed,  8 Apr 2026 18:40:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1775673601;
	bh=iUi4nhaRTNB4iyPw7mzkRDoY0VSzD+LqMFcus23npyg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HnTWKy123QvDDvoHKTezjySoPcSuSN4Uzxe78Z+DQQRAH6if1cuptcMs6xKbwhXT9
	 1Q9xA7dc5RNnOI+QlGfBgXdbNTFuI9U64N5gKWgKJRwbpWCEl4lqh7iPD7R1Ox7d+m
	 Fkd6y2prziYfnzfLb9tD8U99719ZPb+5s4b/TdtU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	kernel test robot <lkp@intel.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.12 018/242] io_uring/net: correct type for min_not_zero() cast
Date: Wed,  8 Apr 2026 20:00:58 +0200
Message-ID: <20260408175927.754052620@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260408175927.064985309@linuxfoundation.org>
References: <20260408175927.064985309@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-234725-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[intel.com:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,kernel.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: CF69F3C2553
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

Commit 37500634d0a8f931e15879760fb70f9b6f5d5370 upstream.

The kernel test robot reports that after a recent change, the signedness
of a min_not_zero() compare is now incorrect. Fix that up and cast to
the right type.

Fixes: 429884ff35f7 ("io_uring/kbuf: use struct io_br_sel for multiple buffers picking")
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509020426.WJtrdwOU-lkp@intel.com/
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/net.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -1122,7 +1122,7 @@ static int io_recv_buf_select(struct io_
 		if (sel->val)
 			arg.max_len = sel->val;
 		else if (kmsg->msg.msg_inq > 1)
-			arg.max_len = min_not_zero(sel->val, (size_t) kmsg->msg.msg_inq);
+			arg.max_len = min_not_zero(sel->val, (ssize_t) kmsg->msg.msg_inq);
 
 		ret = io_buffers_peek(req, &arg, sel);
 		if (unlikely(ret < 0))



