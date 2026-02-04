Return-Path: <stable+bounces-213871-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cIjuLGRpg2kbmgMAu9opvQ
	(envelope-from <stable+bounces-213871-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:44:36 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 392ADE9436
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:44:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5F27B30D0083
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:15:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EA4341B36C;
	Wed,  4 Feb 2026 15:09:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Lynb4GAq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0181741C2ED;
	Wed,  4 Feb 2026 15:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217793; cv=none; b=SdLwQ9dsgNCqnleqDenaGooRXQ28Ve6PgzqhX6GbOaXi1DH5V8bVqAH8dzRTEjMEWHib0VXvYcgm6E1UcGmQISpyBBt2U/Y9SJWEqCumff3BTu4YLD7VJt7orkati5wbLMOKSiRoPkOCUlHA0uVWmZ5PY5pAwf9CTnAd49eC/ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217793; c=relaxed/simple;
	bh=QNKITXtv52Lof4M3NqfjR0+vta00bbkYPIKj3GX3BwE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQfX+cXyD+mUg2lDmdKjolDgNFOKm01AAXIG5qiYQm5P+ozCdTNKjKpXEC+JZ73RHiMUrqTmgCLerUoDp80zhxUJKlYeLSgX70B4fcpXfTrriSQqp4szE/V2dhL7nAQKNB8ameg88Jz0vG0GLyZtTduNP7YWI6UCjdsjHuOkh/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Lynb4GAq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B953C4CEF7;
	Wed,  4 Feb 2026 15:09:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217792;
	bh=QNKITXtv52Lof4M3NqfjR0+vta00bbkYPIKj3GX3BwE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Lynb4GAqZU+91CEQ5W00mXFM7HXmqQxDx8JHXfyATB/5gkUQOVPbVBiaXyAOg7HAW
	 Q4IaLDEmB/5JE/wSuLzs9gc+M8fBAd5DS513fE8rWGVAYh9KZBcKAzP9XVTx6b8xo9
	 L2tO/j8R1SW2wswvBjOZNxEkZtyqBmftwMLtbVBg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Thadeu Lima de Souza Cascardo <cascardo@igalia.com>,
	Jakub Kicinski <kuba@kernel.org>
Subject: [PATCH 6.1 119/280] Revert "nfc/nci: Add the inconsistency check between the input data length and count"
Date: Wed,  4 Feb 2026 15:38:13 +0100
Message-ID: <20260204143913.921131194@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260204143909.614719725@linuxfoundation.org>
References: <20260204143909.614719725@linuxfoundation.org>
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
X-Rspamd-Server: lfdr
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
	TAGGED_FROM(0.00)[bounces-213871-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid]
X-Rspamd-Queue-Id: 392ADE9436
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>

commit f40ddcc0c0ca1a0122a7f4440b429f97d5832bdf upstream.

This reverts commit 068648aab72c9ba7b0597354ef4d81ffaac7b979.

NFC packets may have NUL-bytes. Checking for string length is not a correct
assumption here. As long as there is a check for the length copied from
copy_from_user, all should be fine.

The fix only prevented the syzbot reproducer from triggering the bug
because the packet is not enqueued anymore and the code that triggers the
bug is not exercised.

The fix even broke
testing/selftests/nci/nci_dev, making all tests there fail. After the
revert, 6 out of 8 tests pass.

Fixes: 068648aab72c ("nfc/nci: Add the inconsistency check between the input data length and count")
Cc: stable@vger.kernel.org
Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@igalia.com>
Link: https://patch.msgid.link/20260113202458.449455-1-cascardo@igalia.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/nfc/virtual_ncidev.c |    4 ----
 1 file changed, 4 deletions(-)

--- a/drivers/nfc/virtual_ncidev.c
+++ b/drivers/nfc/virtual_ncidev.c
@@ -121,10 +121,6 @@ static ssize_t virtual_ncidev_write(stru
 		kfree_skb(skb);
 		return -EFAULT;
 	}
-	if (strnlen(skb->data, count) != count) {
-		kfree_skb(skb);
-		return -EINVAL;
-	}
 
 	nci_recv_frame(ndev, skb);
 	return count;



