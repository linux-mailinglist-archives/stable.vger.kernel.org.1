Return-Path: <stable+bounces-213762-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kPz/Nvtig2nAmAMAu9opvQ
	(envelope-from <stable+bounces-213762-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:17:15 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FB72E83A7
	for <lists+stable@lfdr.de>; Wed, 04 Feb 2026 16:17:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 61F403078EB4
	for <lists+stable@lfdr.de>; Wed,  4 Feb 2026 15:09:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5528242188B;
	Wed,  4 Feb 2026 15:03:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ndcgYg2k"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 178562BD036;
	Wed,  4 Feb 2026 15:03:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770217422; cv=none; b=UE6fO/jHqshTLX+IhOdzIi9PIiNQet9heCsADZqI1p7ZbdAhKaZBFUdfs9OJwFlR3cAJA4kk9XJEZ2Hdv8pMGkd+fiMqhssZhzbs6oMjSh1qAi3X40hUhRm1bFdUEwCqihnHjwbNxmhzWiEAY6cwmwc1LhY/CRXsU+I9366dcvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770217422; c=relaxed/simple;
	bh=T/udowldE5CHtOMfAUpKPUT0AEPDJOy9nBM0MXh9lOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TjonXMbVLDFhekIT/lgrEzTGWg02sNJSJJkHixngVZDY0KsYNZ2oM0lFn+Hh22M7JG9xHam65vsQjY/HqZauiykSvRHoZO/baraIPeOWIg5uyf7d7ueLNWDoRZbI2HYvETJnmp3Pw0Ucy/qXSBYnH8wVQaCYO3YkSHFmcJyp4Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ndcgYg2k; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB78C4CEF7;
	Wed,  4 Feb 2026 15:03:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770217421;
	bh=T/udowldE5CHtOMfAUpKPUT0AEPDJOy9nBM0MXh9lOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ndcgYg2kJBbJs/e7VW9mddKFcab41UKpKkF/l7DvvsSYUzWzydXNuhb1aB+H8PT7R
	 1IEzwaRCeNOkN4rlRIrSli4BLfJzk0UqzIRUdcZxxUFFLqRyuq6Q/uHfMDMJ83d8hF
	 w5ClZC1Y0ZBug54c9avfprMWlyZfNvZvwoeRBxXA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Morduan Zang <zhangdandan@uniontech.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.1 002/280] efi/cper: Fix cper_bits_to_str buffer handling and return value
Date: Wed,  4 Feb 2026 15:36:16 +0100
Message-ID: <20260204143909.709622026@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-213762-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linuxfoundation.org:email,linuxfoundation.org:dkim,linuxfoundation.org:mid,uniontech.com:email]
X-Rspamd-Queue-Id: 7FB72E83A7
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Morduan Zang <zhangdandan@uniontech.com>

commit d7f1b4bdc7108be1b178e1617b5f45c8918e88d7 upstream.

The return value calculation was incorrect: `return len - buf_size;`
Initially `len = buf_size`, then `len` decreases with each operation.
This results in a negative return value on success.

Fix by returning `buf_size - len` which correctly calculates the actual
number of bytes written.

Fixes: a976d790f494 ("efi/cper: Add a new helper function to print bitmasks")
Signed-off-by: Morduan Zang <zhangdandan@uniontech.com>
Signed-off-by: Ard Biesheuvel <ardb@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 drivers/firmware/efi/cper.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/firmware/efi/cper.c
+++ b/drivers/firmware/efi/cper.c
@@ -161,7 +161,7 @@ int cper_bits_to_str(char *buf, int buf_
 		len -= size;
 		str += size;
 	}
-	return len - buf_size;
+	return buf_size - len;
 }
 EXPORT_SYMBOL_GPL(cper_bits_to_str);
 



