Return-Path: <stable+bounces-228272-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YKfvHFRLwWlbSAQAu9opvQ
	(envelope-from <stable+bounces-228272-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:16:52 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 177002F4134
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 15:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id DBA3430AC4CD
	for <lists+stable@lfdr.de>; Mon, 23 Mar 2026 14:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 148713B389B;
	Mon, 23 Mar 2026 14:04:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rqyk+0mP"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0BB23ACEED;
	Mon, 23 Mar 2026 14:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774274648; cv=none; b=n7dohtx6wTC0VjD3GmLamipbD2N6au8B3cEkrBm7bmzksZtuZVq1SXhdzOjOyySoE9hx3Ij4Av6rxnfzgNCPT55KWVDtbeqtA89R9sqtg2kwEfWqVOSoThN/Qv+UsAqjMzbUU32q28EPB4Agj5/LEUGt/9JMN1/xORJIAmtTBPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774274648; c=relaxed/simple;
	bh=55sq75iMqIrjKW8eBAvsGFrbRIKTLMHkOcF/2L2lEwg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DbTT/gKC4cV+MFiR8cw3xFE2bL3vLPsbPh5KAgae9belElyy4q4fdfIu/NTTbInZN8mIHgid7llndzv/Sk29meuTkKrjN4gmdimGWjvdtQ4VClbAKAUxu5Nb6rhVr22AoK2ckTMoye0BZmD8+17errdcxvoj24BBQVQZsvi5FR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rqyk+0mP; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 452EBC4CEF7;
	Mon, 23 Mar 2026 14:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774274648;
	bh=55sq75iMqIrjKW8eBAvsGFrbRIKTLMHkOcF/2L2lEwg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Rqyk+0mPQDclYmCorsjPU2DcP2Tf+JfLBAgErmOFw46GMlPLeaBV3NDUNigH1/+SL
	 ahY4zFs/4hE1dQXxODoWbmOgoTBbfT+vVCxMNnvakO4dar/MOiS7A+yk+SEEgvXtMc
	 HlRQhXuwCbSKRDhXsgoKgntSOb4Q70a3Fx2CKPbM=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Francis Brosseau <francis@malagauche.com>,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6.18 063/212] io_uring/poll: fix multishot recv missing EOF on wakeup race
Date: Mon, 23 Mar 2026 14:44:44 +0100
Message-ID: <20260323134505.765599371@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260323134503.770111826@linuxfoundation.org>
References: <20260323134503.770111826@linuxfoundation.org>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-228272-lists,stable=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,malagauche.com:email]
X-Rspamd-Queue-Id: 177002F4134
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Jens Axboe <axboe@kernel.dk>

commit a68ed2df72131447d131531a08fe4dfcf4fa4653 upstream.

When a socket send and shutdown() happen back-to-back, both fire
wake-ups before the receiver's task_work has a chance to run. The first
wake gets poll ownership (poll_refs=1), and the second bumps it to 2.
When io_poll_check_events() runs, it calls io_poll_issue() which does a
recv that reads the data and returns IOU_RETRY. The loop then drains all
accumulated refs (atomic_sub_return(2) -> 0) and exits, even though only
the first event was consumed. Since the shutdown is a persistent state
change, no further wakeups will happen, and the multishot recv can hang
forever.

Check specifically for HUP in the poll loop, and ensure that another
loop is done to check for status if more than a single poll activation
is pending. This ensures we don't lose the shutdown event.

Cc: stable@vger.kernel.org
Fixes: dbc2564cfe0f ("io_uring: let fast poll support multishot")
Reported-by: Francis Brosseau <francis@malagauche.com>
Link: https://github.com/axboe/liburing/issues/1549
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 io_uring/poll.c |    9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -254,6 +254,7 @@ static int io_poll_check_events(struct i
 				atomic_andnot(IO_POLL_RETRY_FLAG, &req->poll_refs);
 				v &= ~IO_POLL_RETRY_FLAG;
 			}
+			v &= IO_POLL_REF_MASK;
 		}
 
 		/* the mask was stashed in __io_poll_execute */
@@ -286,8 +287,13 @@ static int io_poll_check_events(struct i
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			}
 		} else {
-			int ret = io_poll_issue(req, tw);
+			int ret;
 
+			/* multiple refs and HUP, ensure we loop once more */
+			if ((req->cqe.res & (POLLHUP | POLLRDHUP)) && v != 1)
+				v--;
+
+			ret = io_poll_issue(req, tw);
 			if (ret == IOU_COMPLETE)
 				return IOU_POLL_REMOVE_POLL_USE_RES;
 			else if (ret == IOU_REQUEUE)
@@ -303,7 +309,6 @@ static int io_poll_check_events(struct i
 		 * Release all references, retry if someone tried to restart
 		 * task_work while we were executing it.
 		 */
-		v &= IO_POLL_REF_MASK;
 	} while (atomic_sub_return(v, &req->poll_refs) & IO_POLL_REF_MASK);
 
 	io_napi_add(req);



