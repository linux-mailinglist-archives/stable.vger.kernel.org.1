Return-Path: <stable+bounces-226774-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +BycF2mTuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226774-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:46:17 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DD1672B01BD
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:46:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7BAF1326FE05
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B38630C63B;
	Tue, 17 Mar 2026 17:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cXkuyy6x"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEB7C255F2C;
	Tue, 17 Mar 2026 17:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768144; cv=none; b=VpYQFxEvBkft7QhBPf8xYlbnfBn1l2WFjY/SIjuelWgLI+cv3oLbTMgfEt5sZxiFOpA3OH7aCrYFJX0YAnPqDBk6LxxcE4cOBqkJSyTz2ppi36XaW8Dlw2v29chn+ouCKcs69vj2LROnUSVMCgyfoTPbGsr+Z7jiBmsNGUloW0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768144; c=relaxed/simple;
	bh=e5q9W155di7LjAWA5bgkmYy4FZcen3QjpxajVAyKEkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qpmDj+VY8bGcYTCpAhBr/9IheWXQqx0vQB9TmEgcQCUdn2mfauCxwdNy30mPM33GpQ9+ZFCZn2QnM5Im/hIAnDiNYM03q698j9mSmGKUmFyBKRZvwxRwM6XgFTvtqucqo3EpPh9j7D8nhaFdXz5+zvvgMiWjSjfiXqNJscVZUg8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cXkuyy6x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D743EC19424;
	Tue, 17 Mar 2026 17:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768144;
	bh=e5q9W155di7LjAWA5bgkmYy4FZcen3QjpxajVAyKEkQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cXkuyy6xEOJwuOKOqnGP/VEK6dFlMdZaE+51NkOYRNC/r04rCDNZasFUMy5yLM7Qa
	 pkQebuE95bWjtl5+Yz906v+OS6gcjAOZ0Rn+2cHipgwiMt2hWKgn4gJhJ6QnozlqVu
	 mWskvvPNAWECwBMHMxXvMyKkNB2Q0KsWnpJW1+xk=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Juergen Christ <jchrist@linux.ibm.com>,
	Heiko Carstens <hca@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.18 239/333] s390/xor: Fix xor_xc_5() inline assembly
Date: Tue, 17 Mar 2026 17:34:28 +0100
Message-ID: <20260317163008.227144978@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260317162959.345812316@linuxfoundation.org>
References: <20260317162959.345812316@linuxfoundation.org>
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
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-226774-lists,stable=lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	RCPT_COUNT_SEVEN(0.00)[7];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DD1672B01BD
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

commit 5f25805303e201f3afaff0a90f7c7ce257468704 upstream.

xor_xc_5() contains a larl 1,2f that is not used by the asm and is not
declared as a clobber. This can corrupt a compiler-allocated value in %r1
and lead to miscompilation. Remove the instruction.

Fixes: 745600ed6965 ("s390/lib: Use exrl instead of ex in xor functions")
Cc: stable@vger.kernel.org
Reviewed-by: Juergen Christ <jchrist@linux.ibm.com>
Reviewed-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/lib/xor.c |    1 -
 1 file changed, 1 deletion(-)

--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -96,7 +96,6 @@ static void xor_xc_5(unsigned long bytes
 		     const unsigned long * __restrict p5)
 {
 	asm volatile(
-		"	larl	1,2f\n"
 		"	aghi	%0,-1\n"
 		"	jm	6f\n"
 		"	srlg	0,%0,8\n"



