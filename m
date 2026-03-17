Return-Path: <stable+bounces-226769-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cLQENiWTuWk5KQIAu9opvQ
	(envelope-from <stable+bounces-226769-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:45:09 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D2CFB2B014C
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 18:45:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2D63C333D693
	for <lists+stable@lfdr.de>; Tue, 17 Mar 2026 17:22:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 467AE364059;
	Tue, 17 Mar 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="bIQg8uYj"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C73624BF;
	Tue, 17 Mar 2026 17:22:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773768123; cv=none; b=ti4vxy0ntoqcCVQHPiMmFPZuE6vVRwDSCJFMRTjrBrXyALyxv0A0zcOr9S2DYAv2ZrKqsQ4XwF+3rbNC+q1DMyZWfYvlH1opHv7oCsBJEiAwTYUOsVDZLwzU5lvFgo6nMhNJYqp+J59knsZkFE2J06gHW/XCfYtPDajjUbc0bBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773768123; c=relaxed/simple;
	bh=rpT3GtyKyCLhy8bs6n1AP7BvE/KhPX3TKplIl/KK59w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NYBXIyYqT6+kcMqP5MV3Bv8hkPpxKe3nWebSDUdbAh8HeoVHJx5UDfPk3mM+k+bQsc01TtSqnP354AW3+1DWglbbSTO67/fcO0UTTM3JJjAqeMJP8SWsydP3pg/yRlmDESUpSA9H//ox6gcWSlkzmCVVDmhSFx/ioFfWW4ZQyPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=bIQg8uYj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5402CC19424;
	Tue, 17 Mar 2026 17:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1773768122;
	bh=rpT3GtyKyCLhy8bs6n1AP7BvE/KhPX3TKplIl/KK59w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bIQg8uYjjwwvICDoLhd5LxdWEzvpjnkQkuAvBSCeNTPGRFmN/4+WrVyZPxmalyqSo
	 fxI8io70isegrDGaopErGxGJjzhD9ah6GqBEDUhKXn8AqDJ5vR2Tzy5f5hhkb+VFWs
	 /NbW951qGL6H5XWfp75oHcHY0aIYlOSq8pV0PujA=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>
Subject: [PATCH 6.18 235/333] s390/stackleak: Fix __stackleak_poison() inline assembly constraint
Date: Tue, 17 Mar 2026 17:34:24 +0100
Message-ID: <20260317163008.079626426@linuxfoundation.org>
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
	TAGGED_FROM(0.00)[bounces-226769-lists,stable=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[linuxfoundation.org:dkim,linuxfoundation.org:email,linuxfoundation.org:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: D2CFB2B014C
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

6.18-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Heiko Carstens <hca@linux.ibm.com>

commit 674c5ff0f440a051ebf299d29a4c013133d81a65 upstream.

The __stackleak_poison() inline assembly comes with a "count" operand where
the "d" constraint is used. "count" is used with the exrl instruction and
"d" means that the compiler may allocate any register from 0 to 15.

If the compiler would allocate register 0 then the exrl instruction would
not or the value of "count" into the executed instruction - resulting in a
stackframe which is only partially poisoned.

Use the correct "a" constraint, which excludes register 0 from register
allocation.

Fixes: 2a405f6bb3a5 ("s390/stackleak: provide fast __stackleak_poison() implementation")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
Reviewed-by: Vasily Gorbik <gor@linux.ibm.com>
Link: https://lore.kernel.org/r/20260302133500.1560531-4-hca@linux.ibm.com
Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/s390/include/asm/processor.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/s390/include/asm/processor.h
+++ b/arch/s390/include/asm/processor.h
@@ -164,7 +164,7 @@ static __always_inline void __stackleak_
 		"	j	4f\n"
 		"3:	mvc	8(1,%[addr]),0(%[addr])\n"
 		"4:"
-		: [addr] "+&a" (erase_low), [count] "+&d" (count), [tmp] "=&a" (tmp)
+		: [addr] "+&a" (erase_low), [count] "+&a" (count), [tmp] "=&a" (tmp)
 		: [poison] "d" (poison)
 		: "memory", "cc"
 		);



