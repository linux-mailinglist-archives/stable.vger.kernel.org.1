Return-Path: <stable+bounces-248850-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sKDUNLlaB2orzwIAu9opvQ
	(envelope-from <stable+bounces-248850-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:41:13 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61DC55556AF
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 19:41:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6C924316EFB1
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 16:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F05DD3ACEE6;
	Fri, 15 May 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="02SlFQ6q"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B26B83FF1D8;
	Fri, 15 May 2026 16:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778862789; cv=none; b=iNbKQE3gAhqsua3vNqEFAa6vH0dUxg7y7IGP3CZ6TEdLjw+WG71KwxDShs6H+btC81xbPpfAYck3lWXHMxlmEFLMTwq7QH2HrHzk0T/qdMdeRWs/wCewFhhj0q4eZWIeX72u/I9BOtZa5sBk7gqUEfC9opNlTCkgbz/zpf056GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778862789; c=relaxed/simple;
	bh=Fb0bYGFjnd22uaAxHG/NfgXmp/lEfKO9MqbtdMFTpwk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UkF4X5ZlQmUMnHLjqmb9a2AEt8C0HM/a2B99P3lTgEYf29k2KzfSj7uVYYi46DdMVY3X8qaOIrFHKnLjUlvrTbaa4MwgN20deCEPsicx31C0c73gZqZ29pqOWUcH83BXe0hEHMe78qwropRIrCqhGaQu28DTqsJBerpe8iMeQ+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=02SlFQ6q; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 079EAC2BCB0;
	Fri, 15 May 2026 16:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778862789;
	bh=Fb0bYGFjnd22uaAxHG/NfgXmp/lEfKO9MqbtdMFTpwk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=02SlFQ6qKxtVVFiJaYpybOVqMmRjEy6G3OwXlpJssCNJlajpHcAMUrd8kO/vl88N8
	 +RTzaHWlIgo24UzcQqkPOyJ5gaa/WoJfEiu1m2RBcEOxIz7yXLVM8kAUvkr4HHf9Z6
	 ZXgsi4WIulg1FNvYzFu1p61FJFA4KdkBc+zwkUoA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Kai Aizen <kai@snailsploit.com>,
	Pavel Begunkov <asml.silence@gmail.com>,
	Jens Axboe <axboe@kernel.dk>,
	Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Subject: [PATCH 7.0 184/201] io_uring/zcrx: warn on freelist violations
Date: Fri, 15 May 2026 17:50:02 +0200
Message-ID: <20260515154702.564489203@linuxfoundation.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260515154658.538039039@linuxfoundation.org>
References: <20260515154658.538039039@linuxfoundation.org>
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
X-Rspamd-Queue-Id: 61DC55556AF
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	TAGGED_FROM(0.00)[bounces-248850-lists,stable=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,snailsploit.com,gmail.com,kernel.dk,oracle.com];
	MIME_TRACE(0.00)[0:+];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[snailsploit.com:email,kernel.dk:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,oracle.com:email,linuxfoundation.org:email,linuxfoundation.org:mid,linuxfoundation.org:dkim]
X-Rspamd-Action: no action

7.0-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pavel Begunkov <asml.silence@gmail.com>

commit 770594e78c3964cf23cf5287f849437cdde9b7d0 upstream.

The freelist is appropriately sized to always be able to take a free
niov, but let's be more defensive and check the invariant with a
warning. That should help to catch any double-free issues.

Suggested-by: Kai Aizen <kai@snailsploit.com>
Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
Link: https://patch.msgid.link/2f3cea363b04649755e3b6bb9ab66485a95936d5.1776760901.git.asml.silence@gmail.com
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/zcrx.c |    2 ++
 1 file changed, 2 insertions(+)

--- a/io_uring/zcrx.c
+++ b/io_uring/zcrx.c
@@ -587,6 +587,8 @@ static void io_zcrx_return_niov_freelist
 	struct io_zcrx_area *area = io_zcrx_iov_to_area(niov);
 
 	guard(spinlock_bh)(&area->freelist_lock);
+	if (WARN_ON_ONCE(area->free_count >= area->nia.num_niovs))
+		return;
 	area->freelist[area->free_count++] = net_iov_idx(niov);
 }
 



