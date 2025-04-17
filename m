Return-Path: <stable+bounces-132947-lists+stable=lfdr.de@vger.kernel.org>
X-Original-To: lists+stable@lfdr.de
Delivered-To: lists+stable@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D9370A9189A
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 12:02:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6E01919E27AD
	for <lists+stable@lfdr.de>; Thu, 17 Apr 2025 10:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1FC3122618F;
	Thu, 17 Apr 2025 10:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="qsU4BlTU"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D2F9E1C84AD
	for <stable@vger.kernel.org>; Thu, 17 Apr 2025 10:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744884131; cv=none; b=OHZf0+4zNzbxiFHS5l/iQXFQbB969Ea6RlrRpmN/iCVFkhfSQfzg2el6HsjpT77AAYudFFYvTbP0dczKkh5q2M2aiI80B3vMyAEsfRf2l4L3bsuv2drUT/hrTF3LjK9nVO0FD++TYFD97MyohzJTPfJKdoFyzFjcKnhwG9SAdAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744884131; c=relaxed/simple;
	bh=1kRNFMpUDe4VU3Se74CRAxJA1GYD0EweC4LwSfG4xk0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=J6R05vPBinyJTIzWfIAW3XZ6HaLY/ZOmI3P4fIgfCdNNaUobXlzCWo1qGZuovJ1leqyLa9NEcZmSYDUdguShYGIQl7vA5dFiAjnJPbKgOQ8M+fNHTFEMKoArrGKajFXiUoZPNNiJqDFMa99pwTX9PeC2MMxFxYpW8kTsPK2+GDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=qsU4BlTU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFB97C4CEE7;
	Thu, 17 Apr 2025 10:02:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1744884130;
	bh=1kRNFMpUDe4VU3Se74CRAxJA1GYD0EweC4LwSfG4xk0=;
	h=Subject:To:Cc:From:Date:From;
	b=qsU4BlTUiiCpnZtxg/klg2Il2ZwZ6UhpZvVx0i0NFBi4IGODSpRu2lBPwwYMxJbCp
	 j7lbnofybzfvurxLUyt5qnMa8zvlyJMwtyhxwuqo9qyG0gClQJU4c4ujAbW/xA5RX9
	 kkmV7Tvop3d0o4ZVcwy+oiYzPQkzknE3TOiXqgSg=
Subject: FAILED: patch "[PATCH] arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre" failed to apply to 6.1-stable tree
To: dianders@chromium.org,catalin.marinas@arm.com,quic_tsoni@quicinc.com,sbauer@quicinc.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 17 Apr 2025 12:01:58 +0200
Message-ID: <2025041758-fastness-smilingly-2494@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 0c9fc6e652cd5aed48c5f700c32b7642bea7f453
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2025041758-fastness-smilingly-2494@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0c9fc6e652cd5aed48c5f700c32b7642bea7f453 Mon Sep 17 00:00:00 2001
From: Douglas Anderson <dianders@chromium.org>
Date: Tue, 7 Jan 2025 12:06:00 -0800
Subject: [PATCH] arm64: errata: Add KRYO 2XX/3XX/4XX silver cores to Spectre
 BHB safe list

Qualcomm has confirmed that, much like Cortex A53 and A55, KRYO
2XX/3XX/4XX silver cores are unaffected by Spectre BHB. Add them to
the safe list.

Fixes: 558c303c9734 ("arm64: Mitigate spectre style branch history side channels")
Cc: stable@vger.kernel.org
Cc: Scott Bauer <sbauer@quicinc.com>
Signed-off-by: Douglas Anderson <dianders@chromium.org>
Acked-by: Trilok Soni <quic_tsoni@quicinc.com>
Link: https://lore.kernel.org/r/20250107120555.v4.3.Iab8dbfb5c9b1e143e7a29f410bce5f9525a0ba32@changeid
Signed-off-by: Catalin Marinas <catalin.marinas@arm.com>

diff --git a/arch/arm64/kernel/proton-pack.c b/arch/arm64/kernel/proton-pack.c
index 17aa836fe46d..89405be53d8f 100644
--- a/arch/arm64/kernel/proton-pack.c
+++ b/arch/arm64/kernel/proton-pack.c
@@ -854,6 +854,9 @@ static bool is_spectre_bhb_safe(int scope)
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A510),
 		MIDR_ALL_VERSIONS(MIDR_CORTEX_A520),
 		MIDR_ALL_VERSIONS(MIDR_BRAHMA_B53),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_2XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_3XX_SILVER),
+		MIDR_ALL_VERSIONS(MIDR_QCOM_KRYO_4XX_SILVER),
 		{},
 	};
 	static bool all_safe = true;


