Return-Path: <stable+bounces-210818-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SI+OJmIjcWl8eQAAu9opvQ
	(envelope-from <stable+bounces-210818-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:05:06 +0100
X-Original-To: lists+stable@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 40B475BC85
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 20:05:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 031B878785E
	for <lists+stable@lfdr.de>; Wed, 21 Jan 2026 18:18:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B79163382D3;
	Wed, 21 Jan 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="XpiMLGQ1"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6979933FE09;
	Wed, 21 Jan 2026 18:18:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769019485; cv=none; b=kE5Z/tluaoakx8qM38+9etKA/7EF/d9frbpDaCNSmYdFMV4uUOylAtCZoSnWzIM8EMlHLN+dDfEVlSLaKSDHvapd41ctSSQlPXhXECn+nS9luh12GWtGRA4HOn/HHwYTmuNQY3XsJvVxUFrYnJ0f8TMio3GP/iFzvCRPTgtrOw8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769019485; c=relaxed/simple;
	bh=DJQdbZWJKwFZQnx9KyYvMGaaO+w/ERxAAhzUKewt0x0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=skI10WFeuvvWO7QuDpdkuSNBPuv1gfrsG8QNe3ZNhlG8Oz8z9upCJYmBE1lYfuqCAUWab5dSZ1f01ZOjzmWLrL5VdQngHVXNQTotmYVZremfgQP8ekkRNQOTPxpx6zNH03stIqLSw7FTbqrYmjpkZwUbJE4rknIbmkPpSayBJSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=XpiMLGQ1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6847FC4CEF1;
	Wed, 21 Jan 2026 18:18:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1769019484;
	bh=DJQdbZWJKwFZQnx9KyYvMGaaO+w/ERxAAhzUKewt0x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XpiMLGQ1QpkMzkKiH85SjoCJJ7suLc0Qh6zMWQ9x58jsIEWjiLlVIHMKZxkHtXvCa
	 4GczKXqhoilzve9gVLDoVUXwmkNGDpnUKmf56IPp5mD5Z/0PhyqiAhkzLf2Yl5T3Zq
	 5Bd0aXDsTLLYM5mHpYFDWe0uCGtHl5+ac5Eo+yRI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Morduan Zang <zhangdandan@uniontech.com>,
	Ard Biesheuvel <ardb@kernel.org>
Subject: [PATCH 6.12 002/139] efi/cper: Fix cper_bits_to_str buffer handling and return value
Date: Wed, 21 Jan 2026 19:14:10 +0100
Message-ID: <20260121181411.544361197@linuxfoundation.org>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260121181411.452263583@linuxfoundation.org>
References: <20260121181411.452263583@linuxfoundation.org>
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
X-Spamd-Result: default: False [-1.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-210818-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[linuxfoundation.org,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[5];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: 40B475BC85
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

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
@@ -162,7 +162,7 @@ int cper_bits_to_str(char *buf, int buf_
 		len -= size;
 		str += size;
 	}
-	return len - buf_size;
+	return buf_size - len;
 }
 EXPORT_SYMBOL_GPL(cper_bits_to_str);
 



