Return-Path: <stable+bounces-236212-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SAsbKMwW3WmXZwkAu9opvQ
	(envelope-from <stable+bounces-236212-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:16:12 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F1C9F3EE857
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 18:16:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D48CE31E510A
	for <lists+stable@lfdr.de>; Mon, 13 Apr 2026 16:07:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 824F630FC23;
	Mon, 13 Apr 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MLlI/5g1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4279D30F545;
	Mon, 13 Apr 2026 16:05:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776096331; cv=none; b=SXwjWVrma+5ampQt815e70td+QgLJ0JqT5rjEftUzTnVu9iroXaSFl7oRZKv1blhH1VLqTjY0FDFOiPY0KZNDiD59KYrCFFsUSsmIFcIh43/4mP/ir/AOqFBWqCn8qS62bSzzQqA/V/nP9YIhndAqAFAn4zRcp+UzfqvPrCBeR8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776096331; c=relaxed/simple;
	bh=ST4cE3HsiuZ0GRv13d33Gisc0XHDXN+xSaPK9gUbBdw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i2/I/HiUcUZ0cueZKIRCsoTWEqZM0HEZPMcAl+7wT8Aq8Zw1+p7NSLezRSdiBzoVx5Ma2uWTfc2SUyaFBK/GgnzUrYMPoBHSShyXiMw4Qs1l9ND4u1ePZSGeYUlRgRWciKXpt9QUqgUZgNOmPhzk4uGI9Xb+oGsfpYdaOvwolog=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MLlI/5g1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE6BEC2BCB6;
	Mon, 13 Apr 2026 16:05:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1776096331;
	bh=ST4cE3HsiuZ0GRv13d33Gisc0XHDXN+xSaPK9gUbBdw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=MLlI/5g1mhp9+dZDgVYRSxRHRFutWKWL9R2aGAgUnfw12WSd+S3yxLJs9WP1rH8ju
	 yVGUQlkF/81C4KrJ3tR0UBbW71owUML9ZGhP8IzhpKyPOFKYbhdTCr0Kx2Wy1DSs1M
	 1ginRdW0qGEWSl3l2ImEPpcv8JI8EXoVEb8r+EA4=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Pengpeng Hou <pengpeng@iscas.ac.cn>,
	Stefan Wahren <wahrenst@gmx.net>,
	Simon Horman <horms@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.19 56/86] net: qualcomm: qca_uart: report the consumed byte on RX skb allocation failure
Date: Mon, 13 Apr 2026 18:00:03 +0200
Message-ID: <20260413155733.656343584@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260413155731.568515178@linuxfoundation.org>
References: <20260413155731.568515178@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,iscas.ac.cn,gmx.net,kernel.org];
	TAGGED_FROM(0.00)[bounces-236212-lists,stable=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,msgid.link:url,iscas.ac.cn:email]
X-Rspamd-Queue-Id: F1C9F3EE857
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.19-stable review patch.  If anyone has any objections, please let me know.

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



