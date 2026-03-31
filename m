Return-Path: <stable+bounces-232117-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YC65F+79y2mcNAYAu9opvQ
	(envelope-from <stable+bounces-232117-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:01:34 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 13EB236DAAF
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 19:01:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id B1F773115BA4
	for <lists+stable@lfdr.de>; Tue, 31 Mar 2026 16:53:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04013426D12;
	Tue, 31 Mar 2026 16:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="cNmyhAwy"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BADAD4035AB;
	Tue, 31 Mar 2026 16:51:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774975919; cv=none; b=qlwEaR9aNVw6LetestO1Rd3XLbpz+M4Ka8gm8SDrbmudY3v0CQuANRo+FC4gYRLbKy7JcHECdPzIUowemTmPZWmAy7AgEsncLg8GbB0e//RrTXi85s0BtgsxbW8gSsrUSlDgqqMGQIp9bf/0FuXHZ3dKrPfpdnJWWYcH10eDenE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774975919; c=relaxed/simple;
	bh=weeiqqYx6VjhLQkHhiHL8jNeI/7WHmluWC8RWQBST2I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GuPWcdpuw5ganfi6J7FEtpiuDj2XcI4BCZRnBOM9mByDBlF9Yuv3KhiXFrDUWU70Zy7qIEOCCXkMiCUsBAiCi/CRn3HeWZkBX5XeZ2cGyg1509Qtbnp26uPB7k5lMz8jByjJSS8NaPpvJ9n7GUcsgnZfc+DJS+ea/e0I5qNq3dU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=cNmyhAwy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50C60C19423;
	Tue, 31 Mar 2026 16:51:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1774975919;
	bh=weeiqqYx6VjhLQkHhiHL8jNeI/7WHmluWC8RWQBST2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cNmyhAwyd1uDgj7i3Ka49mjSipkMP8ae182W8ER4bN/KvgzJTr4KLq8JdGktz6Dho
	 Wfvd3AtU2lRyMussPBrTQ1xeC7WM37iSxwLj1lR3adDtYz86CGq4SqobjWiQp/mzDh
	 fwFsXa4GMSFB2qhB43QwuH8xHCEviFQy9+A99gwY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	stable@kernel.org,
	Ilya Leoshkevich <iii@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.12 136/244] s390/barrier: Make array_index_mask_nospec() __always_inline
Date: Tue, 31 Mar 2026 18:21:26 +0200
Message-ID: <20260331161746.675119290@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260331161741.651718120@linuxfoundation.org>
References: <20260331161741.651718120@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-232117-lists,stable=lfdr.de];
	TO_DN_SOME(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	MID_RHS_MATCH_FROM(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 13EB236DAAF
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.12-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Vasily Gorbik <gor@linux.ibm.com>

commit c5c0a268b38adffbb2e70e6957017537ff54c157 upstream.

Mark array_index_mask_nospec() as __always_inline to guarantee the
mitigation is emitted inline regardless of compiler inlining decisions.

Fixes: e2dd833389cc ("s390: add optimized array_index_mask_nospec")
Cc: stable@kernel.org
Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/barrier.h |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- a/arch/s390/include/asm/barrier.h
+++ b/arch/s390/include/asm/barrier.h
@@ -62,8 +62,8 @@ do {									\
  * @size: number of elements in array
  */
 #define array_index_mask_nospec array_index_mask_nospec
-static inline unsigned long array_index_mask_nospec(unsigned long index,
-						    unsigned long size)
+static __always_inline unsigned long array_index_mask_nospec(unsigned long index,
+							     unsigned long size)
 {
 	unsigned long mask;
 



