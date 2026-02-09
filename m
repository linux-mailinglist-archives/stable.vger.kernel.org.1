Return-Path: <stable+bounces-215237-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id WK2xFl70iWl+EwAAu9opvQ
	(envelope-from <stable+bounces-215237-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:51:10 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CB7C911116D
	for <lists+stable@lfdr.de>; Mon, 09 Feb 2026 15:51:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8CF7B310B446
	for <lists+stable@lfdr.de>; Mon,  9 Feb 2026 14:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BFFE537BE7D;
	Mon,  9 Feb 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="F2opifG9"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83A562222B2;
	Mon,  9 Feb 2026 14:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770648133; cv=none; b=OfcORgmF7Q07TmfZSDS5ro4/abdGIRRX9DDtoTTBx/89u7IcZrCnhcPAcjPuQW4l/RL3Q0Gdz8LpzE+B+NKcq9wm9PK6H5Cm/hmqCkfAJOwsnQIVo8nelfn1b4z4EpLPIY6Ec/HStPPHYhYQYHsCnuOL6L/MIwasHMkJ3+HSKvU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770648133; c=relaxed/simple;
	bh=+FhbXcZbD0dCFvaquaCg4eiKVqunVk01Vv3W90kHxq8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=By85Fr21I/uRVstWVNfU2Q1rjSnONt8r3uL8Gd+zKktuvP29yBwsUGqJoSVsPW8eGzHlEYXWhIebHd1AA9kLS/DEuO1lMVgWM4kS2D66dEDfhx4CCFw1vf2Blv/AASc83pNBIsTa+RjBF8vuFiU/+oZ/CDgO2ke5P+8G6TNK78E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=F2opifG9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8FD8C16AAE;
	Mon,  9 Feb 2026 14:42:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770648133;
	bh=+FhbXcZbD0dCFvaquaCg4eiKVqunVk01Vv3W90kHxq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F2opifG9UqrTsai/B/NMCR1YTMKlPvcAnYvOGLu0VEnr5TBoSQnGzaTPzar1T7Tw2
	 2MtckMp4r+16Q0bESP57B8u4yaFTUOgxI7++tztVVsYZ8axs9BBcaSCVmsdqR7nsQ7
	 siCTOmwWHjZ9fjlBjEgwyuXGoDC60UEB5A9TL2oI=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Zhiquan Li <zhiquan_li@163.com>,
	Sean Christopherson <seanjc@google.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1 17/69] KVM: selftests: Add -U_FORTIFY_SOURCE to avoid some unpredictable test failures
Date: Mon,  9 Feb 2026 15:23:45 +0100
Message-ID: <20260209142302.546864853@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260209142301.913348974@linuxfoundation.org>
References: <20260209142301.913348974@linuxfoundation.org>
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
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	TAGGED_FROM(0.00)[bounces-215237-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,163.com,google.com,kernel.org];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[msgid.link:url,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: CB7C911116D
X-Rspamd-Action: no action

6.1-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Zhiquan Li <zhiquan_li@163.com>

[ Upstream commit e396a74222654486d6ab45dca5d0c54c408b8b91 ]

Some distributions (such as Ubuntu) configure GCC so that
_FORTIFY_SOURCE is automatically enabled at -O1 or above.  This results
in some fortified version of definitions of standard library functions
are included.  While linker resolves the symbols, the fortified versions
might override the definitions in lib/string_override.c and reference to
those PLT entries in GLIBC.  This is not a problem for the code in host,
but it is a disaster for the guest code.  E.g., if build and run
x86/nested_emulation_test on Ubuntu 24.04 will encounter a L1 #PF due to
memset() reference to __memset_chk@plt.

The option -fno-builtin-memset is not helpful here, because those
fortified versions are not built-in but some definitions which are
included by header, they are for different intentions.

In order to eliminate the unpredictable behaviors may vary depending on
the linker and platform, add the "-U_FORTIFY_SOURCE" into CFLAGS to
prevent from introducing the fortified definitions.

Signed-off-by: Zhiquan Li <zhiquan_li@163.com>
Link: https://patch.msgid.link/20260122053551.548229-1-zhiquan_li@163.com
Fixes: 6b6f71484bf4 ("KVM: selftests: Implement memcmp(), memcpy(), and memset() for guest use")
Cc: stable@vger.kernel.org
[sean: tag for stable]
Signed-off-by: Sean Christopherson <seanjc@google.com>
[ Makefile.kvm -> Makefile ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 tools/testing/selftests/kvm/Makefile |    1 +
 1 file changed, 1 insertion(+)

--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -202,6 +202,7 @@ else
 LINUX_TOOL_ARCH_INCLUDE = $(top_srcdir)/tools/arch/$(ARCH)/include
 endif
 CFLAGS += -Wall -Wstrict-prototypes -Wuninitialized -O2 -g -std=gnu99 \
+	-U_FORTIFY_SOURCE \
 	-fno-stack-protector -fno-PIE -I$(LINUX_TOOL_INCLUDE) \
 	-I$(LINUX_TOOL_ARCH_INCLUDE) -I$(LINUX_HDR_PATH) -Iinclude \
 	-I$(<D) -Iinclude/$(UNAME_M) -I ../rseq -I.. $(EXTRA_CFLAGS) \



