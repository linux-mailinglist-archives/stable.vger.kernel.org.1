Return-Path: <stable+bounces-247424-lists+stable=lfdr.de@vger.kernel.org>
Delivered-To: lists+stable@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uCofNaPLBmrynwIAu9opvQ
	(envelope-from <stable+bounces-247424-lists+stable=lfdr.de@vger.kernel.org>)
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:30:43 +0200
X-Original-To: lists+stable@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 58D4554A98F
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 09:30:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1001B30B7028
	for <lists+stable@lfdr.de>; Fri, 15 May 2026 07:23:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98B733E557C;
	Fri, 15 May 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Vji17BLk"
X-Original-To: stable@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C17C37AA81
	for <stable@vger.kernel.org>; Fri, 15 May 2026 07:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778829795; cv=none; b=GU7Yaw7LmYSZ0gsxB7UXfCyj6Bu90xA5eyXatzPM9xtLHQ1b7NFkTDPpcVZ4Uj7Uw9UnRW7T6d2N8IDORp3aHlR1m0uyOl1v4Gs+LzKXDZS+Fe+nmYyL/eHzwr4NK4m64l4ZFtCtF/ioGgYtFcicRJSDIE7x1i8GybtyLFplj/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778829795; c=relaxed/simple;
	bh=oyQQ5kd1PZvcHwewyORw7xDszbBrppH2PsTkWkRKG48=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=EjvmUcq8lLWTRQvoLnGTn4cd1jx8nqTPL59y50DnjACVk8T4L49HFi559TmgUO2WL3nuHdFx+kUWAVaPP1nMWTsl+RVX/iFH7TlXIJXZ2lx2K5rox+LFQL3IagA/VaIH+pa6aNW8kNGtHf2I7Lt36pkbAv3vdyF2SxB9v2CPJ5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Vji17BLk; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A8738C2BCB0;
	Fri, 15 May 2026 07:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1778829795;
	bh=oyQQ5kd1PZvcHwewyORw7xDszbBrppH2PsTkWkRKG48=;
	h=Subject:To:Cc:From:Date:From;
	b=Vji17BLkRQeNdQw+tWMbEwga+cn5yN8Fzzgx2hNlY7WqQZB4AOWRxygTctsBEtFID
	 AEJNdXooViajX8teT9gCcw0MCXso9FhVHHinTLVU8ilZ9wrNCCC7VF0AlhTBewzVoQ
	 qrCnCFdVHxf7d3w/TqPEO3bIuVERJED2jCkM5eO4=
Subject: FAILED: patch "[PATCH] media: venus: fix QCOM_MDT_LOADER dependency" failed to apply to 5.15-stable tree
To: arnd@arndb.de,bod@kernel.org,dikshita.agarwal@oss.qualcomm.com,hverkuil+cisco@kernel.org,konrad.dybcio@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Fri, 15 May 2026 09:23:09 +0200
Message-ID: <2026051509-retract-lurk-6c0a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 58D4554A98F
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [3.84 / 15.00];
	MID_END_EQ_FROM_USER_PART(4.00)[];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_RHS_NOT_FQDN(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-247424-lists,stable=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,stable@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-0.988];
	TO_DN_NONE(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[stable,cisco];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arndb.de:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:dkim,gregkh:email,qualcomm.com:email]
X-Rspamd-Action: no action


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x aa23c94cc433b145d1ce93820ecdfe16d8940e28
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026051509-retract-lurk-6c0a@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From aa23c94cc433b145d1ce93820ecdfe16d8940e28 Mon Sep 17 00:00:00 2001
From: Arnd Bergmann <arnd@arndb.de>
Date: Mon, 30 Mar 2026 12:08:21 +0100
Subject: [PATCH] media: venus: fix QCOM_MDT_LOADER dependency

When build-testined with CONFIG_QCOM_MDT_LOADER=m and VIDEO_QCOM_VENUS=y,
the kernel fails to link:

x86_64-linux-ld: drivers/media/platform/qcom/venus/firmware.o: in function `venus_boot':
firmware.c:(.text+0x1e3): undefined reference to `qcom_mdt_get_size'
firmware.c:(.text+0x25a): undefined reference to `qcom_mdt_load'
firmware.c:(.text+0x272): undefined reference to `qcom_mdt_load_no_init'

The problem is the conditional 'select' statement. Change this to
make the driver built-in here regardless of CONFIG_ARCH_QCOM,
same as for the similar IRIS driver.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Reviewed-by: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Reviewed-by: Dikshita Agarwal <dikshita.agarwal@oss.qualcomm.com>
Fixes: 0399b696f7f4 ("media: venus: fix compile-test build on non-qcom ARM platform")
Cc: stable@vger.kernel.org
Signed-off-by: Bryan O'Donoghue <bod@kernel.org>
Signed-off-by: Hans Verkuil <hverkuil+cisco@kernel.org>

diff --git a/drivers/media/platform/qcom/venus/Kconfig b/drivers/media/platform/qcom/venus/Kconfig
index ffb731ecd48c..63ee8c78dc6d 100644
--- a/drivers/media/platform/qcom/venus/Kconfig
+++ b/drivers/media/platform/qcom/venus/Kconfig
@@ -4,7 +4,7 @@ config VIDEO_QCOM_VENUS
 	depends on VIDEO_DEV && QCOM_SMEM
 	depends on (ARCH_QCOM && ARM64 && IOMMU_API) || COMPILE_TEST
 	select OF_DYNAMIC if ARCH_QCOM
-	select QCOM_MDT_LOADER if ARCH_QCOM
+	select QCOM_MDT_LOADER
 	select QCOM_SCM
 	select VIDEOBUF2_DMA_CONTIG
 	select V4L2_MEM2MEM_DEV


