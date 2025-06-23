Return-Path: <stable+bounces-156332-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 53E25AE4F28
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 23:13:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 14EDF7AC5B9
	for <lists+stable@lfdr.de>; Mon, 23 Jun 2025 21:11:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C404A221F3E;
	Mon, 23 Jun 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ImYWsAmB"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822DD1ACEDA;
	Mon, 23 Jun 2025 21:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750713155; cv=none; b=Va+77tZ+q6s5ZMrO/vA1DSZbE59o6C5HWe6BuajUraqNdJHkFk/KFV9M4IdB5Cs1+jHhJag3sjTGdDBHG9uUX2pfNR0g1VEgoea9U43GIoIHi2cxE8rEGPGIPNDFryYbCJqyXiiaXS0gXqNuvToLEO8kH3MttrDCZ5vsvMihRZ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750713155; c=relaxed/simple;
	bh=zHtBULAmpau6XnChW5kVY/zILCaVqOuPyWW12+9nAOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aTuzFpsu0/9ob1HgH8wgKwfuVLbjgIODgo+YmHX/usPqJ3KAQadRrIChuIHzxPehQFri8GObb8vdtPd295aHdYgDtm7LokEfFIWwgGwhWTcuQLVSZCcRPj4aVbOWiS71jY61Sefl3RdhS34fYTCUsT9ynk56JH8iQZyoAyFqQpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ImYWsAmB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 194EDC4CEEA;
	Mon, 23 Jun 2025 21:12:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1750713155;
	bh=zHtBULAmpau6XnChW5kVY/zILCaVqOuPyWW12+9nAOo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ImYWsAmBLgRSmiA9iaPgyN18lSgdpIvpjgJmQuENqnEHoyjzWWXWlO4BnD1n6ZYVK
	 DQBzs2Zm5Nt6iWdTSngfLnQ33s5SPyC20jtUkf2t4WEewLVrxKq/jo+IQLcXH7GCSc
	 9kxCh+OVbwGHzME6EdwCfdPSC65Oor+fvSxdC+II=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Tom Rini <trini@konsulko.com>,
	Masahiro Yamada <masahiroy@kernel.org>,
	Nathan Chancellor <nathan@kernel.org>
Subject: [PATCH 5.10 148/355] kbuild: add $(CLANG_FLAGS) to KBUILD_CPPFLAGS
Date: Mon, 23 Jun 2025 15:05:49 +0200
Message-ID: <20250623130631.159580975@linuxfoundation.org>
X-Mailer: git-send-email 2.50.0
In-Reply-To: <20250623130626.716971725@linuxfoundation.org>
References: <20250623130626.716971725@linuxfoundation.org>
User-Agent: quilt/0.68
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Masahiro Yamada <masahiroy@kernel.org>

commit feb843a469fb0ab00d2d23cfb9bcc379791011bb upstream.

When preprocessing arch/*/kernel/vmlinux.lds.S, the target triple is
not passed to $(CPP) because we add it only to KBUILD_{C,A}FLAGS.

As a result, the linker script is preprocessed with predefined macros
for the build host instead of the target.

Assuming you use an x86 build machine, compare the following:

 $ clang -dM -E -x c /dev/null
 $ clang -dM -E -x c /dev/null -target aarch64-linux-gnu

There is no actual problem presumably because our linker scripts do not
rely on such predefined macros, but it is better to define correct ones.

Move $(CLANG_FLAGS) to KBUILD_CPPFLAGS, so that all *.c, *.S, *.lds.S
will be processed with the proper target triple.

[Note]
After the patch submission, we got an actual problem that needs this
commit. (CBL issue 1859)

Link: https://github.com/ClangBuiltLinux/linux/issues/1859
Reported-by: Tom Rini <trini@konsulko.com>
Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Tested-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 Makefile |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

--- a/Makefile
+++ b/Makefile
@@ -586,8 +586,7 @@ else
 CLANG_FLAGS	+= -fno-integrated-as
 endif
 CLANG_FLAGS	+= -Werror=unknown-warning-option
-KBUILD_CFLAGS	+= $(CLANG_FLAGS)
-KBUILD_AFLAGS	+= $(CLANG_FLAGS)
+KBUILD_CPPFLAGS	+= $(CLANG_FLAGS)
 export CLANG_FLAGS
 endif
 



