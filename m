Return-Path: <stable+bounces-87471-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ED0739A654D
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:55:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B2C45B29559
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:54:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 487FD1F667A;
	Mon, 21 Oct 2024 10:48:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="FsLhMJNn"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F375B1F585A;
	Mon, 21 Oct 2024 10:48:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507703; cv=none; b=HPo1izJ0HZzQRsizwGh87+gYL4McNLj9M1lqZd0MdMPZF13foeKrKpL4XgeVtONAbczvGOjgHQRGPYY+zytNMsn2x4Xusv9WSW5SW/JSGnXRNJ49O1uE7GZ5EbKoix3qZREx6ctkcKpIsEYHPy6nCTzo+2KQm5pVXYUWV5CnOdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507703; c=relaxed/simple;
	bh=fqE6frRUfi20neo0UgJRybSYe4aVceZfg3D4sFsgHgo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AGxUBMSskByq8hV8NZANTeowFweTKWqA5YAB0iMxanTCn9ascxLPbQKRMZ1Nab1vd1QkNQ3dIi9UOSCAa9BToLXchpzDPKtpETN1DisXdYcJOQ91yKVJgfZ7YOAKotyZ6MzLlQBNswD/Y5N//vJG80hFobQhyPgaW5uREEmnkt8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=FsLhMJNn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C56C4CEC3;
	Mon, 21 Oct 2024 10:48:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507702;
	bh=fqE6frRUfi20neo0UgJRybSYe4aVceZfg3D4sFsgHgo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FsLhMJNnORqzPiFuXRcTeBtIpqSKRMVhk5UlSbQL2fnOrJMv32XDWSebgMcvAVGzo
	 RRJHjKOwx7glr1w2EfaDzs4TqBHnLOAESFUxBwhN1ZiEESy1qVyJapBPZ8ZF4Ei783
	 lIUYCiWExd6Bs/P1mLgP+XPF5Y8/XvW5MSN9LgCg=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>,
	Johannes Wikner <kwikner@ethz.ch>,
	stable@kernel.org
Subject: [PATCH 5.15 46/82] x86/bugs: Do not use UNTRAIN_RET with IBPB on entry
Date: Mon, 21 Oct 2024 12:25:27 +0200
Message-ID: <20241021102249.061179050@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102247.209765070@linuxfoundation.org>
References: <20241021102247.209765070@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

5.15-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Wikner <kwikner@ethz.ch>

commit c62fa117c32bd1abed9304c58e0da6940f8c7fc2 upstream.

Since X86_FEATURE_ENTRY_IBPB will invalidate all harmful predictions
with IBPB, no software-based untraining of returns is needed anymore.
Currently, this change affects retbleed and SRSO mitigations so if
either of the mitigations is doing IBPB and the other one does the
software sequence, the latter is not needed anymore.

  [ bp: Massage commit message. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Johannes Wikner <kwikner@ethz.ch>
Cc: <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   17 +++++++++++++++++
 1 file changed, 17 insertions(+)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1092,6 +1092,15 @@ do_cmd_auto:
 
 	case RETBLEED_MITIGATION_IBPB:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
+
+		/*
+		 * IBPB on entry already obviates the need for
+		 * software-based untraining so clear those in case some
+		 * other mitigation like SRSO has selected them.
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_UNRET);
+		setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
+
 		mitigate_smt = true;
 
 		/*
@@ -2599,6 +2608,14 @@ static void __init srso_select_mitigatio
 			if (has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
 				srso_mitigation = SRSO_MITIGATION_IBPB;
+
+				/*
+				 * IBPB on entry already obviates the need for
+				 * software-based untraining so clear those in case some
+				 * other mitigation like Retbleed has selected them.
+				 */
+				setup_clear_cpu_cap(X86_FEATURE_UNRET);
+				setup_clear_cpu_cap(X86_FEATURE_RETHUNK);
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_IBPB_ENTRY.\n");



