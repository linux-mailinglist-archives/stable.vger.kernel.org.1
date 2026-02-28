Return-Path: <stable+bounces-220274-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBvoNq0zo2mX+QQAu9opvQ
	(envelope-from <stable+bounces-220274-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:57 +0100
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 50FD51C5D23
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 19:27:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DF41932340B0
	for <lists+stable@lfdr.de>; Sat, 28 Feb 2026 18:03:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52EA047DD71;
	Sat, 28 Feb 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bg5Wq9Mq"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13174381CDB;
	Sat, 28 Feb 2026 17:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772300178; cv=none; b=HGIGlMAGYUoVI40RuajkvI5edn16CC/fMY7gQmA9BQU+LXI2a96ePiALiai6ZsD8fv17llXJFGD7eskSB4fVbbuCrT3CxJgDRsZHjkRa9qNGSSMvW+w19bCX7th6cdHkqD6vSLAui0oMD3xxJgliKBfJzX/pI9Jec90YvLy7NW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772300178; c=relaxed/simple;
	bh=In2dEzgRQhkET1JyDUBYmQbxdy3S2uzNqXaE3eNgILw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ijr5VbehaV26+csiAdp0P3ZGp2On2hUxBmZzKWM1OsN6vzI3hJrTQsMviKFzgTY9yUG+hnvHL0Ituqcz8jtvaP5tENWMEhBDB81pU2BJ6fr29vpMtmjwvmaHXMcZgSIr7M6vZ1ONT7EhszM7bYg0cHJrnSukuBcoDkwQUi1MN+c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bg5Wq9Mq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2139C116D0;
	Sat, 28 Feb 2026 17:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772300177;
	bh=In2dEzgRQhkET1JyDUBYmQbxdy3S2uzNqXaE3eNgILw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bg5Wq9Mq5uGv23jbZJuV5d0kgOwejT/i4vJcbNulhdOg3zMr3SREI/oCoK4HihGOk
	 NEYsNHoVAsRLtGxplHzWDQ8lWaVNDMxxEj9DFxUOduyexTc+122fAKVGm4MY/xrdZH
	 pzH0trtVzu/00dzZz6IUb2ZRDAIkztQjxJwqkGogmv7DUwNQF2tSD6Zrm5z1KuhaCO
	 lS/TVTzF+snQB/OVd4sZ2C+R7WBvcjMDFdPB+PTBIuib/LoJLPXj2qDoh2k0Y3ZV6v
	 35FflYydMxGnnkIO4H99s3vzF7kqpqo+RPh5xaa2nqGf4K4juOY5zIuYsDqdSdGQ9P
	 eNBv18E2+JOXA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	kernel test robot <lkp@intel.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Nicolas Schier <nsc@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.19 196/844] virt: vbox: uapi: Mark inner unions in packed structs as packed
Date: Sat, 28 Feb 2026 12:21:49 -0500
Message-ID: <20260228173244.1509663-197-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260228173244.1509663-1-sashal@kernel.org>
References: <20260228173244.1509663-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-220274-lists,stable=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MIME_TRACE(0.00)[0:+];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,stable@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[stable];
	RCPT_COUNT_SEVEN(0.00)[9];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 50FD51C5D23
X-Rspamd-Action: no action

From: Thomas Weißschuh <thomas.weissschuh@linutronix.de>

[ Upstream commit c25d01e1c4f2d43f47af87c00e223f5ca7c71792 ]

The unpacked unions within a packed struct generates alignment warnings
on clang for 32-bit ARM:

./usr/include/linux/vbox_vmmdev_types.h:239:4: error: field u within 'struct vmmdev_hgcm_function_parameter32'
  is less aligned than 'union (unnamed union at ./usr/include/linux/vbox_vmmdev_types.h:223:2)'
  and is usually due to 'struct vmmdev_hgcm_function_parameter32' being packed,
  which can lead to unaligned accesses [-Werror,-Wunaligned-access]
     239 |         } u;
         |           ^

./usr/include/linux/vbox_vmmdev_types.h:254:6: error: field u within
  'struct vmmdev_hgcm_function_parameter64::(anonymous union)::(unnamed at ./usr/include/linux/vbox_vmmdev_types.h:249:3)'
  is less aligned than 'union (unnamed union at ./usr/include/linux/vbox_vmmdev_types.h:251:4)' and is usually due to
  'struct vmmdev_hgcm_function_parameter64::(anonymous union)::(unnamed at ./usr/include/linux/vbox_vmmdev_types.h:249:3)'
  being packed, which can lead to unaligned accesses [-Werror,-Wunaligned-access]

With the recent changes to compile-test the UAPI headers in more cases,
these warning in combination with CONFIG_WERROR breaks the build.

Fix the warnings.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202512140314.DzDxpIVn-lkp@intel.com/
Reported-by: Nathan Chancellor <nathan@kernel.org>
Closes: https://lore.kernel.org/linux-kbuild/20260110-uapi-test-disable-headers-arm-clang-unaligned-access-v1-1-b7b0fa541daa@kernel.org/
Suggested-by: Arnd Bergmann <arnd@arndb.de>
Link: https://lore.kernel.org/linux-kbuild/29b2e736-d462-45b7-a0a9-85f8d8a3de56@app.fastmail.com/
Signed-off-by: Thomas Weißschuh <thomas.weissschuh@linutronix.de>
Tested-by: Nicolas Schier <nsc@kernel.org>
Reviewed-by: Nicolas Schier <nsc@kernel.org>
Acked-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20260115-kbuild-alignment-vbox-v1-2-076aed1623ff@linutronix.de
Signed-off-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/uapi/linux/vbox_vmmdev_types.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/vbox_vmmdev_types.h b/include/uapi/linux/vbox_vmmdev_types.h
index 6073858d52a2e..11f3627c3729b 100644
--- a/include/uapi/linux/vbox_vmmdev_types.h
+++ b/include/uapi/linux/vbox_vmmdev_types.h
@@ -236,7 +236,7 @@ struct vmmdev_hgcm_function_parameter32 {
 			/** Relative to the request header. */
 			__u32 offset;
 		} page_list;
-	} u;
+	} __packed u;
 } __packed;
 VMMDEV_ASSERT_SIZE(vmmdev_hgcm_function_parameter32, 4 + 8);
 
@@ -251,7 +251,7 @@ struct vmmdev_hgcm_function_parameter64 {
 			union {
 				__u64 phys_addr;
 				__u64 linear_addr;
-			} u;
+			} __packed u;
 		} __packed pointer;
 		struct {
 			/** Size of the buffer described by the page list. */
-- 
2.51.0


