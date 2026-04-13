Return-Path: <stable+bounces-236403-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KAexBhIZ3Wn3ZwkAu9opvQ
	(envelope-from <stable+bounces-236403-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:54 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 23C7F3EEE5B
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:25:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id F10713065CC9
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:13:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1955326A1CF;
	Mon, 13 Apr 2026 16:13:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="vuXutKho"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D073F26E6F8;
	Mon, 13 Apr 2026 16:13:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096815; cv=none; b=Rc6zzCB9/r/m6cFg0T6/jYGt/Hp0MHSLk7mT/1WWQhDUZG+iC/w7wOaXmWJzkY5LMd4IEsXojHldAeOP2EuBGCXFBy+8mCp1PRDRpc9nzawj6hY8IBZ9g9KvHu3wya2pl6zI3AJcHjfLZYVz9zN2NwxKqqJdSP3e8pnT2AsdqrU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096815; c=relaxed/simple;
	bh=0kcqJoEFTtPc19U3vza0dHsqCeFHv6miCRuH+V4VNDQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FRvcs2HSJBxywE3K24EYuZGZfpKXheeBYiynJQAyjsJySqwHgV72ibGBZEMkKOj7ViKOlY8OQ/kUG+22RE3H521qPwMaktRRjrKJa9xdJXCd/8IEj5ac/sJZ5D1dbY5QXJ7QdnSF5K5AIjPhMq6oe9NAMT9rWa1Mp7zzZZHyFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=vuXutKho; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684F9C2BCAF;
	Mon, 13 Apr 2026 16:13:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096815;
	bh=0kcqJoEFTtPc19U3vza0dHsqCeFHv6miCRuH+V4VNDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=vuXutKhoErX23HiOyCVESxm5iZarwMRbZHHXGK1weU0JLRoSmwy+W4D4fg0uB5O7s
	 ak7nj1zXMI9mPrn04+Bb+OJJpgAe1XrbeO1H1mz8MaqSYjPDjPFldR+M2sYGxsN/91
	 kpu0Ubz8uW0k0UMcdjvj/pVkO8xyZb90OZEuFBGs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.12 53/70] net: qualcomm: qca_uart: report the consumed byte on RX skb allocation failure
Date: Mon, 13 Apr 2026 18:00:48 +0200
Message-ID: <20260413155730.164772923@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155728.181580293@linuxfoundation.org>
References: <20260413155728.181580293@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,iscas.ac.cn,gmx.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-236403-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[iscas.ac.cn:email,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,msgid.link:url]
X-Rspamd-Queue-Id: 23C7F3EEE5B
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Pengpeng Hou <pengpeng@iscas.ac.cn>

commit b76254c55dc8f23edc089027dd3f8792554c69fb upstream.

qca_tty_receive() consumes each input byte before checking whether a
completed frame needs a fresh receive skb. When the current byte completes
a frame, the driver delivers that frame and then allocates a new skb for
the next one.

If that allocation fails, the current code returns i even though data[i]
has already been consumed and may already have completed the delivered
frame. Since serdev interprets the return value as the number of accepted
bytes, this under-reports progress by one byte and can replay the final
byte of the completed frame into a fresh parser state on the next call.

Return i + 1 in that failure path so the accepted-byte count matches the
actual receive-state progress.

Fixes: dfc768fbe618 ("net: qualcomm: add QCA7000 UART driver")
Cc: stable@vger.kernel.org
Signed-off-by: Pengpeng Hou <pengpeng@iscas.ac.cn>
Reviewed-by: Stefan Wahren <wahrenst@gmx.net>
Reviewed-by: Simon Horman <horms@kernel.org>
Link: https://patch.msgid.link/20260402071207.4036-1-pengpeng@iscas.ac.cn
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/net/ethernet/qualcomm/qca_uart.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/net/ethernet/qualcomm/qca_uart.c
+++ b/drivers/net/ethernet/qualcomm/qca_uart.c
@@ -100,7 +100,7 @@ qca_tty_receive(struct serdev_device *se
 			if (!qca->rx_skb) {
 				netdev_dbg(netdev, "recv: out of RX resources\n");
 				n_stats->rx_errors++;
-				return i;
+				return i + 1;
 			}
 		}
 	}



