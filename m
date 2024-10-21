Return-Path: <stable+bounces-87268-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BA39B9A6427
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 12:43:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 628111F21AA3
	for <lists+stable@lfdr.de>; Mon, 21 Oct 2024 10:43:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35BE81F4292;
	Mon, 21 Oct 2024 10:38:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="HDvqJTz0"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E37131EBFEA;
	Mon, 21 Oct 2024 10:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729507097; cv=none; b=PXZ5FvsofgbosXxvPQQHvrdOYxCu8tFRFYbGAoR9U8vvbSzNMFrzsnEerOlYUFAKR+mbphUTlEWb54I/RE1uB7TKRqNhX5MMqPZN8WjGzPTxZRlQMQYKqC/cro2duzDsnSU6OxPlcOxlHruN8ECiyf+g/6OJSduMF52nKiGotAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729507097; c=relaxed/simple;
	bh=ecwcNWl4URAmNo9jzfFv0EIGu2ulq7KygCxJ89qaKOw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dKW3AAFJlSdJyRu5KyuretHevae29AbR7EFCSP3XNhZF47YeEAbJBhZ1kGD2ZdEk+Pq/GG27l+0BdAFQJO6uE+QyzA0Mzs7OabMzhYrNxByvLjGguhtVNKbkPqzFbTID4Cd7iujPFO3O7a8RxXK+JJAGC0LmAH4OjIev///QZHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=HDvqJTz0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 644C4C4CEC3;
	Mon, 21 Oct 2024 10:38:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1729507096;
	bh=ecwcNWl4URAmNo9jzfFv0EIGu2ulq7KygCxJ89qaKOw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HDvqJTz0jqmKPWfpkM6KFkXntm8jTDu477fQlEv4Dm3r1t/ocu6xT2pk5fOzspBQ9
	 Gn8QZwGiOInZC5iLPxt5ZYMGHY74NSkVv9mYB147hQ87FMDXGa25cJ+KWk/UfRAq0L
	 Tj8Uim+uIlaBmHL965QZZsHeb93lcEzduQTiT0DU=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Borislav Petkov <bp@alien8.de>,
	Johannes Wikner <kwikner@ethz.ch>,
	stable@kernel.org
Subject: [PATCH 6.6 057/124] x86/bugs: Skip RSB fill at VMEXIT
Date: Mon, 21 Oct 2024 12:24:21 +0200
Message-ID: <20241021102258.939487843@linuxfoundation.org>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241021102256.706334758@linuxfoundation.org>
References: <20241021102256.706334758@linuxfoundation.org>
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

6.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Johannes Wikner <kwikner@ethz.ch>

commit 0fad2878642ec46225af2054564932745ac5c765 upstream.

entry_ibpb() is designed to follow Intel's IBPB specification regardless
of CPU. This includes invalidating RSB entries.

Hence, if IBPB on VMEXIT has been selected, entry_ibpb() as part of the
RET untraining in the VMEXIT path will take care of all BTB and RSB
clearing so there's no need to explicitly fill the RSB anymore.

  [ bp: Massage commit message. ]

Suggested-by: Borislav Petkov <bp@alien8.de>
Signed-off-by: Johannes Wikner <kwikner@ethz.ch>
Cc: <stable@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/x86/kernel/cpu/bugs.c |   15 +++++++++++++++
 1 file changed, 15 insertions(+)

--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1115,6 +1115,14 @@ do_cmd_auto:
 		setup_force_cpu_cap(X86_FEATURE_ENTRY_IBPB);
 		setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 		mitigate_smt = true;
+
+		/*
+		 * There is no need for RSB filling: entry_ibpb() ensures
+		 * all predictions, including the RSB, are invalidated,
+		 * regardless of IBPB implementation.
+		 */
+		setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
+
 		break;
 
 	case RETBLEED_MITIGATION_STUFF:
@@ -2622,6 +2630,13 @@ static void __init srso_select_mitigatio
 			if (!boot_cpu_has(X86_FEATURE_ENTRY_IBPB) && has_microcode) {
 				setup_force_cpu_cap(X86_FEATURE_IBPB_ON_VMEXIT);
 				srso_mitigation = SRSO_MITIGATION_IBPB_ON_VMEXIT;
+
+				/*
+				 * There is no need for RSB filling: entry_ibpb() ensures
+				 * all predictions, including the RSB, are invalidated,
+				 * regardless of IBPB implementation.
+				 */
+				setup_clear_cpu_cap(X86_FEATURE_RSB_VMEXIT);
 			}
 		} else {
 			pr_err("WARNING: kernel not compiled with CPU_SRSO.\n");



